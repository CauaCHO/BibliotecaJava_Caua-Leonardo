# BibliotecaJava - Cadastro de Livros

Projeto desenvolvido para a disciplina de Programação Java Web.

## Integrantes

- Cauã Henrique de Oliveira  
- Leonardo  

---

## Objetivo

Construir um sistema Java Web utilizando JSP e Servlets para realizar a manutenção de um cadastro de livros.

---

## Classe Livro

A classe `Livro` possui os seguintes atributos:

- `id`
- `nomeLivro`
- `isbn`
- `autor`
- `dataPublicacao`
- `valorLivro`

---

## Funcionalidades

- Listar livros cadastrados
- Cadastrar livros
- Alterar livros
- Excluir livros
- Interface responsiva para computador e celular

---

## Tecnologias utilizadas

- Java 17
- JSP
- Servlets (Jakarta)
- JDBC
- PostgreSQL
- Maven
- Bootstrap 5
- Apache Tomcat 10

---

## Estrutura do projeto

```text
src/main/java/br/com/cadastro
├── dao
│   └── LivroDAO.java
├── model
│   └── Livro.java
├── servlet
│   └── LivroServlet.java
└── util
    └── Conexao.java

src/main/webapp
├── index.jsp
├── lista-livros.jsp
├── form-livro.jsp
├── css/style.css
└── WEB-INF/web.xml