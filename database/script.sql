CREATE DATABASE biblioteca;

-- Depois de criar o banco, conecte nele e execute os comandos abaixo.

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

-- Caso você já tenha criado a tabela livros sem o campo email, execute:
-- ALTER TABLE livros ADD COLUMN email VARCHAR(150);
-- UPDATE livros SET email = CONCAT('livro', id, '@exemplo.com') WHERE email IS NULL;
-- ALTER TABLE livros ALTER COLUMN email SET NOT NULL;
-- ALTER TABLE livros ADD CONSTRAINT uk_livros_email UNIQUE (email);
