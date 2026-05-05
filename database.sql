CREATE TABLE livro (
    id SERIAL PRIMARY KEY,
    nome_livro VARCHAR(150) NOT NULL,
    isbn VARCHAR(50) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    data_publicacao DATE NOT NULL,
    valor_livro NUMERIC(10,2) NOT NULL
);

ALTER TABLE livro RENAME TO livros;