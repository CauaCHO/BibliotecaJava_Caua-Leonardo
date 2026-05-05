<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Livro" %>
<%
    List<Livro> livros = (List<Livro>) request.getAttribute("livros");
    String mensagemSucesso = (String) session.getAttribute("mensagemSucesso");
    String mensagemErro = (String) request.getAttribute("mensagemErro");
    if (mensagemSucesso != null) {
        session.removeAttribute("mensagemSucesso");
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca Java - Livros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container py-2">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/livros">📚 Biblioteca Java</a>
    </div>
</nav>

<main class="container py-4">
    <section class="card hero-card mb-4">
        <div class="card-body p-4 d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3">
            <div>
                <h1 class="h3 fw-bold mb-1">Cadastro de Livros</h1>
                <p class="text-muted mb-0">Sistema Java Web com JSP, Servlet, DAO e PostgreSQL.</p>
            </div>
            <a href="<%= request.getContextPath() %>/livros/novo" class="btn btn-primary btn-rounded px-4">+ Novo Livro</a>
        </div>
    </section>

    <% if (mensagemSucesso != null) { %>
        <div class="alert alert-success"><%= mensagemSucesso %></div>
    <% } %>

    <% if (mensagemErro != null) { %>
        <div class="alert alert-danger"><%= mensagemErro %></div>
    <% } %>

    <section class="card table-card">
        <div class="card-body p-0">
            <div class="table-responsive desktop-table">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Livro</th>
                        <th>ISBN</th>
                        <th>Autor</th>
                        <th>Publicação</th>
                        <th>Valor</th>
                        <th class="text-end">Ações</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (livros == null || livros.isEmpty()) { %>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">Nenhum livro cadastrado.</td>
                        </tr>
                    <% } else { %>
                        <% for (Livro livro : livros) { %>
                            <tr>
                                <td><%= livro.getId() %></td>
                                <td class="fw-semibold"><%= livro.getNomeLivro() %></td>
                                <td><%= livro.getIsbn() %></td>
                                <td><%= livro.getAutor() %></td>
                                <td><%= livro.getDataPublicacao() %></td>
                                <td>R$ <%= livro.getValorLivro() %></td>
                                <td>
                                    <div class="action-buttons justify-content-end">
                                        <a class="btn btn-sm btn-outline-primary" href="<%= request.getContextPath() %>/livros/editar?id=<%= livro.getId() %>">Editar</a>
                                        <a class="btn btn-sm btn-outline-danger" href="<%= request.getContextPath() %>/livros/excluir?id=<%= livro.getId() %>" onclick="return confirm('Deseja realmente excluir este livro?')">Excluir</a>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="mobile-card p-3">
                <% if (livros == null || livros.isEmpty()) { %>
                    <p class="text-center text-muted mb-0">Nenhum livro cadastrado.</p>
                <% } else { %>
                    <% for (Livro livro : livros) { %>
                        <div class="card mb-3 border-0 shadow-sm">
                            <div class="card-body">
                                <h2 class="h5 fw-bold"><%= livro.getNomeLivro() %></h2>
                                <p class="mb-1"><strong>ID:</strong> <%= livro.getId() %></p>
                                <p class="mb-1"><strong>ISBN:</strong> <%= livro.getIsbn() %></p>
                                <p class="mb-1"><strong>Autor:</strong> <%= livro.getAutor() %></p>
                                <p class="mb-1"><strong>Publicação:</strong> <%= livro.getDataPublicacao() %></p>
                                <p class="mb-3"><strong>Valor:</strong> R$ <%= livro.getValorLivro() %></p>
                                <div class="action-buttons">
                                    <a class="btn btn-sm btn-outline-primary" href="<%= request.getContextPath() %>/livros/editar?id=<%= livro.getId() %>">Editar</a>
                                    <a class="btn btn-sm btn-outline-danger" href="<%= request.getContextPath() %>/livros/excluir?id=<%= livro.getId() %>" onclick="return confirm('Deseja realmente excluir este livro?')">Excluir</a>
                                </div>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </div>
    </section>
</main>
</body>
</html>
