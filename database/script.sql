CREATE DATABASE biblioteca;

-- Depois de criar o banco, conecte nele e execute os comandos abaixo.

CREATE TABLE IF NOT EXISTS estados (
    id SERIAL PRIMARY KEY,
    nome_estado VARCHAR(100) NOT NULL,
    sigla_estado VARCHAR(2) NOT NULL UNIQUE
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

-- Migração para quem já tinha criado a tabela estados com nomes antigos.
ALTER TABLE estados ADD COLUMN IF NOT EXISTS nome_estado VARCHAR(100);
ALTER TABLE estados ADD COLUMN IF NOT EXISTS sigla_estado VARCHAR(2);
UPDATE estados SET nome_estado = nome WHERE nome_estado IS NULL AND EXISTS (
    SELECT 1 FROM information_schema.columns WHERE table_name = 'estados' AND column_name = 'nome'
);
UPDATE estados SET sigla_estado = sigla WHERE sigla_estado IS NULL AND EXISTS (
    SELECT 1 FROM information_schema.columns WHERE table_name = 'estados' AND column_name = 'sigla'
);

-- Migração para quem já tinha criado a tabela livros sem o campo email.
ALTER TABLE livros ADD COLUMN IF NOT EXISTS email VARCHAR(150);
UPDATE livros SET email = CONCAT('livro', id, '@exemplo.com') WHERE email IS NULL;
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
END $$;

INSERT INTO estados (nome_estado, sigla_estado)
VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Minas Gerais', 'MG'),
('Paraná', 'PR'),
('Mato Grosso do Sul', 'MS')
ON CONFLICT (sigla_estado) DO NOTHING;
