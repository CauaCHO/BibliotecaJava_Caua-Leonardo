# 📚 Biblioteca Java - Sistema de Gestão de Biblioteca

Sistema web desenvolvido em Java utilizando JSP, Servlets, JDBC e PostgreSQL para gerenciamento de livros, usuários e estados.

Projeto desenvolvido para a disciplina de Programação Java Web.

---

# 👨‍💻 Integrantes

- Cauã Henrique de Oliveira
- Leonardo Guilherme

---

# 🎯 Objetivo do Projeto

Desenvolver uma aplicação Java Web utilizando a arquitetura MVC tradicional baseada em:

- JSP
- Servlets
- DAO
- JDBC
- PostgreSQL

O sistema permite o gerenciamento completo de:

- 📚 Livros
- 👤 Usuários
- 🌎 Estados

---

# 🚀 Funcionalidades

## 📚 Livros

- Cadastro de livros
- Edição de livros
- Exclusão de livros
- Busca instantânea
- Preview de capa
- Capas personalizadas
- Fallback automático de imagem
- Validação de e-mail
- Dashboard com indicadores

## 👤 Usuários

- Cadastro de usuários
- CRUD completo
- Validação de CPF/CNPJ
- Validação de e-mail
- Busca instantânea

## 🌎 Estados

- Cadastro de estados
- CRUD completo
- Controle de duplicidade da sigla
- Validação frontend/backend

---

# 🎨 Interface

O sistema possui:

- Dashboard administrativo
- Sidebar moderna
- Dark mode
- Bootstrap 5
- Bootstrap Icons
- Layout responsivo
- Cards administrativos
- Paginação visual
- Busca instantânea em JavaScript
- Visual premium para tabelas e formulários

---

# 🛠️ Tecnologias Utilizadas

| Tecnologia | Utilização |
|---|---|
| Java 17 | Linguagem principal |
| JSP | Interface |
| Servlets (`javax.servlet`) | Controle |
| JDBC | Persistência |
| PostgreSQL | Banco de dados |
| Maven | Gerenciamento de dependências |
| Bootstrap 5 | Interface responsiva |
| Bootstrap Icons | Ícones |
| Apache Tomcat 9 | Servidor |

---

# 🧱 Arquitetura do Projeto

```text
Model → DAO → Servlet → JSP
```

---

# 📂 Estrutura do Projeto

```text
src/main/java/br/com/cadastro
├── dao
├── model
├── servlet
└── util

src/main/webapp
├── css
├── js
├── WEB-INF
├── dashboard.jsp
├── lista-livros.jsp
├── lista-usuarios.jsp
├── lista-estados.jsp
├── form-livro.jsp
├── form-usuario.jsp
└── form-estado.jsp
```

---

# 🗄️ Banco de Dados

O arquivo:

```text
database/script.sql
```

já contém:

- criação do banco
- criação das tabelas
- constraints
- migrações seguras
- dados iniciais
- compatibilidade com versões antigas do projeto

## ✅ Basta executar o arquivo completo

---

# ⚙️ Configuração do Banco

Por padrão:

```text
Banco: biblioteca
Usuário: postgres
Senha: postgres
```

Caso necessário, altere:

```text
src/main/java/br/com/cadastro/util/Conexao.java
```

---

# 🚀 Como Executar o Projeto

## 1️⃣ Executar o banco

Execute:

```text
database/script.sql
```

no PostgreSQL.

---

## 2️⃣ Executar o setup automático

Execute:

```text
setup_e_rodar.bat
```

O script:

- verifica Java
- verifica Maven
- baixa Tomcat 9
- gera WAR
- faz deploy
- inicia servidor
- abre navegador automaticamente

---

# 🌐 Acesso do Sistema

```text
http://localhost:8080/BibliotecaJava_Caua-Leonardo/livros
```

---

# 🔐 Tomcat Manager

```text
Usuário: admin
Senha: admin
```

---

# 📌 Requisitos

- Java JDK 17
- Maven
- PostgreSQL
- Windows

---

# 🧠 Padrões Utilizados

- MVC
- DAO
- JDBC
- Responsividade
- Validações frontend/backend

---

# 📷 Recursos Visuais

- Dashboard premium
- Dark mode
- Sidebar administrativa
- Busca dinâmica
- Capas de livros
- Preview automático de capa
- Cards administrativos

---

# 📄 Licença

Projeto acadêmico desenvolvido para fins educacionais.
