CREATE DATABASE biblioteca;

-- Conecte no banco biblioteca antes de executar o restante.

CREATE TABLE IF NOT EXISTS estados (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sigla CHAR(2) NOT NULL UNIQUE
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

-- Caso a tabela livros já exista sem o campo email,
-- execute os comandos abaixo:

ALTER TABLE livros
ADD COLUMN IF NOT EXISTS email VARCHAR(150);

UPDATE livros
SET email = CONCAT('livro', id, '@exemplo.com')
WHERE email IS NULL;

ALTER TABLE livros
ALTER COLUMN email SET NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'uk_livros_email'
    ) THEN

        ALTER TABLE livros
        ADD CONSTRAINT uk_livros_email UNIQUE (email);

    END IF;
END $$;

-- Estados iniciais para testes

INSERT INTO estados (nome, sigla)
VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Minas Gerais', 'MG'),
('Paraná', 'PR'),
('Mato Grosso do Sul', 'MS')
ON CONFLICT (sigla) DO NOTHING;