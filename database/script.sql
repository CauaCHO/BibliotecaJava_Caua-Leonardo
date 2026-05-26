-- Banco de dados do Sistema de Gestão de Biblioteca
-- PostgreSQL

CREATE DATABASE biblioteca;

-- IMPORTANTE:
-- Depois de criar o banco, conecte-se ao banco "biblioteca" antes de executar o restante deste script.

CREATE TABLE IF NOT EXISTS estados (
    id SERIAL PRIMARY KEY,
    nome_estado VARCHAR(100) NOT NULL,
    sigla_estado VARCHAR(2) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nome_usuario VARCHAR(120) NOT NULL,
    cpf_cnpj VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS livros (
    id SERIAL PRIMARY KEY,
    nome_livro VARCHAR(150) NOT NULL,
    isbn VARCHAR(50) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    data_publicacao DATE NOT NULL,
    valor_livro NUMERIC(10,2) NOT NULL
);

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'estados' AND column_name = 'nome')
       AND NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'estados' AND column_name = 'nome_estado') THEN
        ALTER TABLE estados RENAME COLUMN nome TO nome_estado;
    END IF;

    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'estados' AND column_name = 'sigla')
       AND NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'estados' AND column_name = 'sigla_estado') THEN
        ALTER TABLE estados RENAME COLUMN sigla TO sigla_estado;
    END IF;
END $$;

ALTER TABLE livros ADD COLUMN IF NOT EXISTS email VARCHAR(150);
UPDATE livros SET email = CONCAT('livro', id, '@exemplo.com') WHERE email IS NULL;
ALTER TABLE livros ALTER COLUMN email SET NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'uk_livros_email') THEN
        ALTER TABLE livros ADD CONSTRAINT uk_livros_email UNIQUE (email);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'uk_estados_sigla') THEN
        ALTER TABLE estados ADD CONSTRAINT uk_estados_sigla UNIQUE (sigla_estado);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'uk_usuarios_email') THEN
        ALTER TABLE usuarios ADD CONSTRAINT uk_usuarios_email UNIQUE (email);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'uk_usuarios_cpf_cnpj') THEN
        ALTER TABLE usuarios ADD CONSTRAINT uk_usuarios_cpf_cnpj UNIQUE (cpf_cnpj);
    END IF;
END $$;

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
('Administrador', '00000000000', 'admin@biblioteca.com')
ON CONFLICT (email) DO NOTHING;
