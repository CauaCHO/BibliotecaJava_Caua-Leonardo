-- =========================================================
-- Banco de Dados - Biblioteca Java
-- PostgreSQL
-- =========================================================

-- 1) Execute este comando primeiro conectado no PostgreSQL padrão.
-- 2) Depois conecte-se ao banco "biblioteca" e execute o restante do script.

CREATE DATABASE biblioteca;

-- =========================================================
-- IMPORTANTE
-- A partir daqui, execute conectado ao banco: biblioteca
-- =========================================================

CREATE TABLE IF NOT EXISTS estados (
    id SERIAL PRIMARY KEY,
    nome_estado VARCHAR(100) NOT NULL,
    sigla_estado VARCHAR(2) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nome_usuario VARCHAR(120) NOT NULL,
    cpf_cnpj VARCHAR(18) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS livros (
    id SERIAL PRIMARY KEY,
    nome_livro VARCHAR(150) NOT NULL,
    isbn VARCHAR(50) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    capa_livro VARCHAR(255),
    data_publicacao DATE NOT NULL,
    valor_livro NUMERIC(10,2) NOT NULL
);

-- =========================================================
-- Migrações seguras para bancos criados em versões antigas
-- =========================================================

DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name = 'estados' AND column_name = 'nome'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name = 'estados' AND column_name = 'nome_estado'
    ) THEN
        ALTER TABLE estados RENAME COLUMN nome TO nome_estado;
    END IF;

    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name = 'estados' AND column_name = 'sigla'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name = 'estados' AND column_name = 'sigla_estado'
    ) THEN
        ALTER TABLE estados RENAME COLUMN sigla TO sigla_estado;
    END IF;
END $$;

ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS cpf_cnpj VARCHAR(18);
ALTER TABLE usuarios ALTER COLUMN cpf_cnpj TYPE VARCHAR(18);

ALTER TABLE livros ADD COLUMN IF NOT EXISTS email VARCHAR(150);
ALTER TABLE livros ADD COLUMN IF NOT EXISTS capa_livro VARCHAR(255);

UPDATE livros
SET email = CONCAT('livro', id, '@exemplo.com')
WHERE email IS NULL;

ALTER TABLE livros ALTER COLUMN email SET NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'uk_livros_email'
    ) THEN
        ALTER TABLE livros ADD CONSTRAINT uk_livros_email UNIQUE (email);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'uk_estados_sigla'
    ) THEN
        ALTER TABLE estados ADD CONSTRAINT uk_estados_sigla UNIQUE (sigla_estado);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'uk_usuarios_email'
    ) THEN
        ALTER TABLE usuarios ADD CONSTRAINT uk_usuarios_email UNIQUE (email);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'uk_usuarios_cpf_cnpj'
    ) THEN
        ALTER TABLE usuarios ADD CONSTRAINT uk_usuarios_cpf_cnpj UNIQUE (cpf_cnpj);
    END IF;
END $$;

-- =========================================================
-- Dados iniciais para teste
-- =========================================================

INSERT INTO estados (nome_estado, sigla_estado)
VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Minas Gerais', 'MG'),
('Paraná', 'PR'),
('Mato Grosso do Sul', 'MS')
ON CONFLICT (sigla_estado) DO NOTHING;

INSERT INTO usuarios (nome_usuario, cpf_cnpj, email)
VALUES
('Administrador', '000.000.000-00', 'admin@biblioteca.com')
ON CONFLICT (email) DO NOTHING;

INSERT INTO livros (nome_livro, isbn, autor, email, capa_livro, data_publicacao, valor_livro)
VALUES
('Java Web com JSP e Servlets', '978-85-0000-001-1', 'Autor Exemplo', 'javaweb@biblioteca.com', 'https://placehold.co/220x320/4f46e5/ffffff?text=Java+Web', '2024-01-10', 89.90),
('Banco de Dados PostgreSQL', '978-85-0000-002-8', 'Autor Exemplo', 'postgresql@biblioteca.com', 'https://placehold.co/220x320/0f766e/ffffff?text=PostgreSQL', '2024-02-15', 79.90)
ON CONFLICT (email) DO NOTHING;
