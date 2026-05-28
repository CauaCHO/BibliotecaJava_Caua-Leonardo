-- =========================================================
-- Banco de Dados - Biblioteca Java 2.0
-- PostgreSQL
-- =========================================================

CREATE DATABASE biblioteca;

-- =========================================================
-- Execute o restante conectado no banco biblioteca
-- =========================================================

CREATE TABLE IF NOT EXISTS estados (
    id SERIAL PRIMARY KEY,
    nome_estado VARCHAR(100) NOT NULL,
    sigla_estado VARCHAR(2) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS categorias (
    id SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nome_usuario VARCHAR(120) NOT NULL,
    cpf_cnpj VARCHAR(18) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    estado_id INTEGER REFERENCES estados(id)
);

CREATE TABLE IF NOT EXISTS livros (
    id SERIAL PRIMARY KEY,
    nome_livro VARCHAR(150) NOT NULL,
    isbn VARCHAR(50) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    capa_livro VARCHAR(255),
    data_publicacao DATE NOT NULL,
    valor_livro NUMERIC(10,2) NOT NULL,
    categoria_id INTEGER REFERENCES categorias(id)
);

CREATE TABLE IF NOT EXISTS emprestimos (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
    livro_id INTEGER NOT NULL REFERENCES livros(id),
    data_emprestimo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_efetiva DATE,
    status VARCHAR(30) NOT NULL DEFAULT 'ATIVO',
    renovacoes_restantes INTEGER NOT NULL DEFAULT 2,
    CONSTRAINT ck_emprestimos_status CHECK (status IN ('ATIVO', 'DEVOLVIDO', 'ATRASADO'))
);

CREATE TABLE IF NOT EXISTS devolucoes (
    id SERIAL PRIMARY KEY,
    emprestimo_id INTEGER NOT NULL REFERENCES emprestimos(id),
    data_devolucao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    multa_dias_atraso NUMERIC(10,2) DEFAULT 0,
    observacoes TEXT
);

CREATE TABLE IF NOT EXISTS avaliacoes (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
    livro_id INTEGER NOT NULL REFERENCES livros(id),
    nota INTEGER NOT NULL,
    comentario TEXT,
    data_avaliacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ck_avaliacoes_nota CHECK (nota BETWEEN 1 AND 5),
    CONSTRAINT uk_avaliacao_usuario_livro UNIQUE (usuario_id, livro_id)
);

CREATE TABLE IF NOT EXISTS estoque_livros (
    id SERIAL PRIMARY KEY,
    livro_id INTEGER NOT NULL UNIQUE REFERENCES livros(id),
    quantidade_total INTEGER NOT NULL DEFAULT 0,
    quantidade_disponivel INTEGER NOT NULL DEFAULT 0,
    data_atualizacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ck_estoque_quantidades CHECK (quantidade_total >= 0 AND quantidade_disponivel >= 0 AND quantidade_disponivel <= quantidade_total)
);

-- =========================================================
-- Migrações seguras
-- =========================================================

ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS estado_id INTEGER;
ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS tipo_usuario VARCHAR(30) DEFAULT 'LEITOR';
ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS ativo BOOLEAN DEFAULT true;
ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS telefone VARCHAR(20);
ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS endereco_completo TEXT;

ALTER TABLE livros ADD COLUMN IF NOT EXISTS categoria_id INTEGER;
ALTER TABLE livros ADD COLUMN IF NOT EXISTS capa_livro VARCHAR(255);
ALTER TABLE livros ADD COLUMN IF NOT EXISTS editora VARCHAR(255);
ALTER TABLE livros ADD COLUMN IF NOT EXISTS idioma VARCHAR(50) DEFAULT 'Português';
ALTER TABLE livros ADD COLUMN IF NOT EXISTS numero_paginas INTEGER;
ALTER TABLE livros ADD COLUMN IF NOT EXISTS descricao_detalhada TEXT;
ALTER TABLE livros ADD COLUMN IF NOT EXISTS nota_media NUMERIC(3,2) DEFAULT 0;
ALTER TABLE livros ADD COLUMN IF NOT EXISTS quantidade_avaliacoes INTEGER DEFAULT 0;

ALTER TABLE usuarios ALTER COLUMN cpf_cnpj TYPE VARCHAR(18);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'ck_usuarios_tipo_usuario') THEN
        ALTER TABLE usuarios ADD CONSTRAINT ck_usuarios_tipo_usuario CHECK (tipo_usuario IN ('ADMIN', 'BIBLIOTECARIO', 'LEITOR'));
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_usuario_estado') THEN
        ALTER TABLE usuarios ADD CONSTRAINT fk_usuario_estado FOREIGN KEY (estado_id) REFERENCES estados(id);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_livro_categoria') THEN
        ALTER TABLE livros ADD CONSTRAINT fk_livro_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id);
    END IF;
END $$;

-- =========================================================
-- Dados iniciais
-- =========================================================

INSERT INTO estados (nome_estado, sigla_estado)
VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Minas Gerais', 'MG'),
('Paraná', 'PR'),
('Mato Grosso do Sul', 'MS')
ON CONFLICT (sigla_estado) DO NOTHING;

INSERT INTO categorias (nome_categoria, descricao)
VALUES
('Programação', 'Livros sobre desenvolvimento de software'),
('Banco de Dados', 'Livros sobre SQL e PostgreSQL'),
('Tecnologia', 'Livros gerais de tecnologia'),
('Java', 'Livros específicos da linguagem Java'),
('Arquitetura de Software', 'Livros sobre boas práticas, padrões e arquitetura')
ON CONFLICT (nome_categoria) DO NOTHING;

INSERT INTO usuarios (nome_usuario, cpf_cnpj, email, estado_id, tipo_usuario, telefone, endereco_completo)
VALUES
('Administrador', '000.000.000-00', 'admin@biblioteca.com', 1, 'ADMIN', '(17) 99999-0000', 'Biblioteca Central')
ON CONFLICT (email) DO NOTHING;

INSERT INTO livros (
    nome_livro,
    isbn,
    autor,
    capa_livro,
    data_publicacao,
    valor_livro,
    categoria_id,
    editora,
    idioma,
    numero_paginas,
    descricao_detalhada
)
VALUES
(
    'Java Web com JSP e Servlets',
    '978-85-0000-001-1',
    'Autor Exemplo',
    'https://placehold.co/360x520/1e293b/f59e0b?text=Java+Web',
    '2024-01-10',
    89.90,
    4,
    'Editora Técnica',
    'Português',
    320,
    'Livro introdutório para desenvolvimento web com JSP, Servlets e arquitetura MVC.'
),
(
    'Banco de Dados PostgreSQL',
    '978-85-0000-002-8',
    'Autor Exemplo',
    'https://placehold.co/360x520/0f766e/ffffff?text=PostgreSQL',
    '2024-02-15',
    79.90,
    2,
    'Editora Dados',
    'Português',
    280,
    'Material prático sobre modelagem, SQL, constraints e consultas em PostgreSQL.'
)
ON CONFLICT DO NOTHING;

INSERT INTO estoque_livros (livro_id, quantidade_total, quantidade_disponivel)
SELECT id, 5, 5 FROM livros
ON CONFLICT (livro_id) DO NOTHING;
