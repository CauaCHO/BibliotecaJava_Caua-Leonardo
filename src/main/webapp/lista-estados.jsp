<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Estado" %>
<%
    List<Estado> estados = (List<Estado>) request.getAttribute("estados");
    Long totalEstados = (Long) request.getAttribute("totalEstados");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Estados - Biblioteca Java</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
    <div class="container py-2 d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/livros">📚 Biblioteca Java</a>

        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-light btn-rounded" href="<%= request.getContextPath() %>/livros">Livros</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/estados">Estados</a>
        </div>
    </div>
</nav>

<main class="container py-4">

    <section class="hero-card card border-0 shadow-sm mb-4">
        <div class="card-body p-4 d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3">
            <div>
                <span class="badge text-bg-primary mb-2">Gerenciamento</span>
                <h1 class="h3 fw-bold mb-1">Estados Cadastrados</h1>
                <p class="text-muted mb-0">Cadastro e manutenção de estados do sistema.</p>
            </div>

            <div class="text-lg-end">
                <div class="small text-muted">Total de estados</div>
                <div class="display-6 fw-bold"><%= totalEstados != null ? totalEstados : 0 %></div>
            </div>
        </div>
    </section>

    <div class="d-flex justify-content-end mb-3">
        <a href="<%= request.getContextPath() %>/estados/novo" class="btn btn-primary btn-rounded px-4">
            ➕ Novo Estado
        </a>
    </div>

    <% if (request.getAttribute("mensagemErro") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= request.getAttribute("mensagemErro") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <% if (session.getAttribute("mensagemSucesso") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= session.getAttribute("mensagemSucesso") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% session.removeAttribute("mensagemSucesso"); %>
    <% } %>

    <section class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Estado</th>
                        <th>Sigla</th>
                        <th class="text-end">Ações</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% if (estados != null && !estados.isEmpty()) {
                        for (Estado estado : estados) { %>

                        <tr>
                            <td><%= estado.getId() %></td>
                            <td class="fw-semibold"><%= estado.getNomeEstado() %></td>
                            <td>
                                <span class="badge text-bg-primary">
                                    <%= estado.getSiglaEstado() %>
                                </span>
                            </td>
                            <td class="text-end">
                                <a href="<%= request.getContextPath() %>/estados/editar?id=<%= estado.getId() %>"
                                   class="btn btn-sm btn-outline-primary btn-rounded">
                                    ✏️ Editar
                                </a>

                                <a href="<%= request.getContextPath() %>/estados/excluir?id=<%= estado.getId() %>"
                                   class="btn btn-sm btn-outline-danger btn-rounded"
                                   onclick="return confirm('Deseja realmente excluir este estado?');">
                                    🗑️ Excluir
                                </a>
                            </td>
                        </tr>

                    <% }
                    } else { %>

                        <tr>
                            <td colspan="4" class="text-center py-4 text-muted">
                                Nenhum estado cadastrado.
                            </td>
                        </tr>

                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
