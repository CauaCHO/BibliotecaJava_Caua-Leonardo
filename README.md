# BibliotecaJava - Cadastro de Livros

Projeto desenvolvido para a disciplina de Programação Java Web.

## Integrantes

- Cauã Henrique de Oliveira
- Leonardo

## Objetivo

Construir um sistema Java Web utilizando JSP e Servlets para realizar a manutenção de um cadastro de livros.

## Classe Livro

A classe `Livro` possui os seguintes atributos:

- `id`
- `nomeLivro`
- `isbn`
- `autor`
- `dataPublicacao`
- `valorLivro`

## Funcionalidades

- Listar livros cadastrados
- Cadastrar livros
- Alterar livros
- Excluir livros
- Interface responsiva para computador e celular

## Tecnologias utilizadas

- Java 17
- JSP
- Servlets Jakarta
- JDBC
- PostgreSQL
- Maven
- Bootstrap 5
- Apache Tomcat 10

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
```

## Banco de dados

O script está em:

```text
database/script.sql
```

Script principal:

```sql
CREATE DATABASE biblioteca_java;

CREATE TABLE IF NOT EXISTS livros (
    id SERIAL PRIMARY KEY,
    nome_livro VARCHAR(150) NOT NULL,
    isbn VARCHAR(50) NOT NULL,
    autor VARCHAR(120) NOT NULL,
    data_publicacao DATE NOT NULL,
    valor_livro NUMERIC(10,2) NOT NULL
);
```

## Configuração da conexão

Por padrão, o sistema tenta conectar em:

```text
URL: jdbc:postgresql://localhost:5432/biblioteca_java
Usuário: postgres
Senha: postgres
```

Caso sua senha seja diferente, altere o arquivo:

```text
src/main/java/br/com/cadastro/util/Conexao.java
```

Ou configure variáveis de ambiente:

```text
DB_URL
DB_USER
DB_PASSWORD
```

## Como executar

1. Criar o banco no PostgreSQL usando o script `database/script.sql`.
2. Importar o projeto no Eclipse como projeto Maven.
3. Configurar Apache Tomcat 10.
4. Executar o projeto em `Run As > Run on Server`.
5. Acessar:

```text
http://localhost:8080/BibliotecaJava_Caua-Leonardo/livros
```

## Observação

Este projeto segue o padrão de Java Web tradicional com JSP, Servlet, DAO, JDBC e PostgreSQL.
