<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Livros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="livros">📚 Biblioteca Web UNIFEF</a>
    </div>
</nav>

<main class="container py-4">
    <section class="hero-card mb-4">
        <div>
            <p class="text-uppercase text-primary fw-bold mb-1">Java Web + Servlets + Firebase</p>
            <h1 class="h2 fw-bold mb-2">Cadastro de Livros</h1>
            <p class="text-muted mb-0">Sistema CRUD responsivo para manutenção de livros cadastrados.</p>
        </div>
        <a href="livros?acao=novo" class="btn btn-primary btn-lg">+ Novo Livro</a>
    </section>

    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <h2 class="h5 fw-bold mb-0">Livros cadastrados</h2>
                <span class="badge text-bg-light">Total: ${livros.size()}</span>
            </div>

            <c:choose>
                <c:when test="${empty livros}">
                    <div class="empty-state text-center py-5">
                        <div class="display-5">📖</div>
                        <h3 class="h5 mt-3">Nenhum livro cadastrado</h3>
                        <p class="text-muted">Clique em “Novo Livro” para começar.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive desktop-table">
                        <table class="table align-middle table-hover">
                            <thead>
                            <tr>
                                <th>Livro</th>
                                <th>ISBN</th>
                                <th>Autor</th>
                                <th>Publicação</th>
                                <th>Valor</th>
                                <th class="text-end">Ações</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="livro" items="${livros}">
                                <tr>
                                    <td class="fw-semibold">${livro.nomeLivro}</td>
                                    <td>${livro.isbn}</td>
                                    <td>${livro.autor}</td>
                                    <td>${livro.dataPublicacao}</td>
                                    <td>R$ ${livro.valorLivro}</td>
                                    <td class="text-end actions">
                                        <a class="btn btn-sm btn-outline-primary" href="livros?acao=editar&id=${livro.id}">Editar</a>
                                        <a class="btn btn-sm btn-outline-danger" href="livros?acao=excluir&id=${livro.id}" onclick="return confirm('Deseja excluir este livro?')">Excluir</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="mobile-cards">
                        <c:forEach var="livro" items="${livros}">
                            <div class="book-card">
                                <h3>${livro.nomeLivro}</h3>
                                <p><strong>ISBN:</strong> ${livro.isbn}</p>
                                <p><strong>Autor:</strong> ${livro.autor}</p>
                                <p><strong>Publicação:</strong> ${livro.dataPublicacao}</p>
                                <p><strong>Valor:</strong> R$ ${livro.valorLivro}</p>
                                <div class="d-grid gap-2 mt-3">
                                    <a class="btn btn-outline-primary" href="livros?acao=editar&id=${livro.id}">Editar</a>
                                    <a class="btn btn-outline-danger" href="livros?acao=excluir&id=${livro.id}" onclick="return confirm('Deseja excluir este livro?')">Excluir</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>
</body>
</html>
