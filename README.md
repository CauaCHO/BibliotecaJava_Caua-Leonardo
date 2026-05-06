# 📚 BibliotecaJava - Cadastro de Livros

Sistema web desenvolvido em Java utilizando JSP, Servlets e PostgreSQL para gerenciamento de cadastro de livros.

Projeto desenvolvido para a disciplina de Programação Java Web.

---

# 👨‍💻 Integrantes

- Cauã Henrique de Oliveira
- Leonardo Guilherme

---

# 🎯 Objetivo do Projeto

Desenvolver uma aplicação Java Web utilizando a arquitetura tradicional baseada em JSP + Servlets, permitindo realizar operações de manutenção de um cadastro de livros.

O sistema possibilita:

- Cadastro de livros
- Edição de informações
- Exclusão de registros
- Visualização da lista de livros cadastrados

Além disso, o projeto foi desenvolvido com foco em:

- Organização em camadas
- Integração com banco de dados PostgreSQL
- Interface responsiva
- Estrutura baseada em DAO

---

# 📖 Classe Livro

A entidade `Livro` representa os dados principais do sistema.

## Atributos da classe

| Campo | Tipo | Descrição |
|------|------|-----------|
| id | Integer | Identificador único |
| nomeLivro | String | Nome do livro |
| isbn | String | Código ISBN |
| autor | String | Nome do autor |
| dataPublicacao | Date | Data de publicação |
| valorLivro | BigDecimal | Valor do livro |

---

# ⚙️ Funcionalidades do Sistema

✅ Listagem de livros cadastrados  
✅ Cadastro de novos livros  
✅ Alteração de livros existentes  
✅ Exclusão de livros  
✅ Interface responsiva para desktop e dispositivos móveis  
✅ Integração com PostgreSQL via JDBC  

---

# 🛠️ Tecnologias Utilizadas

| Tecnologia | Finalidade |
|------------|------------|
| Java 17 | Linguagem principal |
| JSP | Renderização das páginas |
| Servlets Jakarta | Controle das requisições |
| JDBC | Comunicação com banco de dados |
| PostgreSQL | Banco de dados relacional |
| Maven | Gerenciamento de dependências |
| Bootstrap 5 | Estilização e responsividade |
| Apache Tomcat 10 | Servidor de aplicação |

---

# 🧱 Arquitetura Utilizada

O projeto foi estruturado seguindo o padrão:

```text
Model → DAO → Servlet → JSP
