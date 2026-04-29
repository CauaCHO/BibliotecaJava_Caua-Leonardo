# Cadastro de Livros - Java Web + Servlets + Firebase

Sistema Java Web para manutenção de cadastro de livros.

## Funcionalidades

- Listar livros cadastrados
- Cadastrar livros
- Editar livros
- Excluir livros
- Interface responsiva para PC e celular
- Banco online com Firebase Firestore

## Tecnologias

- Java 17
- Maven
- Jakarta Servlets
- JSP/JSTL
- Firebase Admin SDK
- Cloud Firestore
- Bootstrap 5
- Apache Tomcat 10+

## Classe Livro

- id
- nomeLivro
- isbn
- autor
- dataPublicacao
- valorLivro

## Configuração do Firebase

1. Acesse o Firebase Console.
2. Crie um projeto.
3. Vá em **Build > Firestore Database**.
4. Clique em **Criar banco de dados**.
5. Escolha modo de teste ou produção.
6. Vá em **Configurações do projeto > Contas de serviço**.
7. Clique em **Gerar nova chave privada**.
8. Renomeie o arquivo baixado para:

```text
firebase-key.json
```

9. Coloque o arquivo em:

```text
src/main/resources/firebase-key.json
```

> Importante: esse arquivo não deve ser enviado para o GitHub.

## Como executar

No terminal, dentro da pasta do projeto:

```bash
mvn clean package
```

Depois execute no Apache Tomcat 10 ou superior.

Acesse:

```text
http://localhost:8080/cadastro-livros-firebase/livros
```

## GitHub

O projeto já possui `.gitignore` para impedir que a chave privada do Firebase seja enviada.

Comandos básicos:

```bash
git init
git add .
git commit -m "Cadastro de livros com Java Web e Firebase"
git branch -M main
git remote add origin LINK_DO_REPOSITORIO
git push -u origin main
```
