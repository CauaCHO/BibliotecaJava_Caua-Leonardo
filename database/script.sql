-- =========================================================
-- Banco de Dados - Biblioteca Java
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
    usuario_id INTEGER REFERENCES usuarios(id),
    livro_id INTEGER REFERENCES livros(id),
    data_emprestimo DATE NOT NULL,
    data_devolucao_prevista DATE,
    data_devolucao_real DATE,
    status VARCHAR(30) NOT NULL
);

-- =========================================================
-- Migrações seguras
-- =========================================================

ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS estado_id INTEGER;
ALTER TABLE livros ADD COLUMN IF NOT EXISTS categoria_id INTEGER;
ALTER TABLE livros ADD COLUMN IF NOT EXISTS capa_livro VARCHAR(255);

ALTER TABLE usuarios
ADD CONSTRAINT IF NOT EXISTS fk_usuario_estado
FOREIGN KEY (estado_id) REFERENCES estados(id);

ALTER TABLE livros
ADD CONSTRAINT IF NOT EXISTS fk_livro_categoria
FOREIGN KEY (categoria_id) REFERENCES categorias(id);

ALTER TABLE usuarios ALTER COLUMN cpf_cnpj TYPE VARCHAR(18);

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
('Java', 'Livros específicos da linguagem Java')
ON CONFLICT (nome_categoria) DO NOTHING;

INSERT INTO usuarios (nome_usuario, cpf_cnpj, email, estado_id)
VALUES
('Administrador', '000.000.000-00', 'admin@biblioteca.com', 1)
ON CONFLICT (email) DO NOTHING;

INSERT INTO livros (
    nome_livro,
    isbn,
    autor,
    capa_livro,
    data_publicacao,
    valor_livro,
    categoria_id
)
VALUES
(
    'Java Web com JSP e Servlets',
    '978-85-0000-001-1',
    'Autor Exemplo',
    'https://placehold.co/220x320/4f46e5/ffffff?text=Java+Web',
    '2024-01-10',
    89.90,
    4
),
(
    'Banco de Dados PostgreSQL',
    '978-85-0000-002-8',
    'Autor Exemplo',
    'https://placehold.co/220x320/0f766e/ffffff?text=PostgreSQL',
    '2024-02-15',
    79.90,
    2
);
