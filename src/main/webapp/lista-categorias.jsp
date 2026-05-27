<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Categoria" %>
<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
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
    <title>Categorias - Biblioteca Java</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm app-navbar">
    <div class="container py-2 d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/dashboard.jsp">📚 Biblioteca Java</a>
        <div class="d-flex gap-2 flex-wrap">
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/livros">Livros</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/usuarios">Usuários</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/estados">Estados</a>
            <a class="btn btn-sm btn-light btn-rounded" href="<%= request.getContextPath() %>/categorias">Categorias</a>
        </div>
    </div>
</nav>

<main class="container py-4 page-transition">
    <section class="card hero-card mb-4">
        <div class="card-body p-4 d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3">
            <div>
                <span class="badge badge-soft mb-2">Organização</span>
                <h1 class="h3 fw-bold mb-1">Categorias</h1>
                <p class="text-muted mb-0">As categorias conectam os livros dentro do sistema.</p>
            </div>

            <a href="<%= request.getContextPath() %>/categorias/novo" class="btn btn-primary btn-rounded px-4">
                <i class="bi bi-plus-lg"></i>
                Nova Categoria
            </a>
        </div>
    </section>

    <% if (mensagemSucesso != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= mensagemSucesso %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <% if (mensagemErro != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= mensagemErro %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <section class="card table-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Categoria</th>
                        <th>Descrição</th>
                        <th class="text-end">Ações</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (categorias == null || categorias.isEmpty()) { %>
                        <tr>
                            <td colspan="4" class="text-center py-4 text-muted">Nenhuma categoria cadastrada.</td>
                        </tr>
                    <% } else { %>
                        <% for (Categoria categoria : categorias) { %>
                            <tr>
                                <td><%= categoria.getId() %></td>
                                <td>
                                    <span class="badge text-bg-primary fs-6 px-3 py-2">
                                        <%= categoria.getNomeCategoria() %>
                                    </span>
                                </td>
                                <td><%= categoria.getDescricao() != null ? categoria.getDescricao() : "-" %></td>
                                <td>
                                    <div class="action-buttons justify-content-end">
                                        <a class="btn btn-sm btn-outline-primary"
                                           href="<%= request.getContextPath() %>/categorias/editar?id=<%= categoria.getId() %>">
                                            <i class="bi bi-pencil"></i>
                                        </a>

                                        <a class="btn btn-sm btn-outline-danger"
                                           href="<%= request.getContextPath() %>/categorias/excluir?id=<%= categoria.getId() %>"
                                           onclick="return confirm('Deseja realmente excluir esta categoria?')">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/app.js"></script>
</body>
</html>
