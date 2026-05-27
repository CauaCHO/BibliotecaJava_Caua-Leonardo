<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Usuario" %>
<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
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
    <title>Usuários - Biblioteca Java</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
    <div class="container py-2 d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/dashboard.jsp">📚 Biblioteca Java</a>

        <div class="d-flex gap-2 flex-wrap">
            <a class="btn btn-sm btn-light btn-rounded" href="<%= request.getContextPath() %>/livros">Livros</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/usuarios">Usuários</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/estados">Estados</a>
        </div>
    </div>
</nav>

<main class="container py-4">

    <section class="card hero-card mb-4">
        <div class="card-body p-4 d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3">
            <div>
                <span class="badge badge-soft mb-2">Gerenciamento</span>
                <h1 class="h3 fw-bold mb-1">Cadastro de Usuários</h1>
                <p class="text-muted mb-0">Usuários conectados aos estados cadastrados no sistema.</p>
            </div>

            <a href="<%= request.getContextPath() %>/usuarios/novo" class="btn btn-primary btn-rounded px-4">
                <i class="bi bi-plus-lg"></i>
                Novo Usuário
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

    <div class="mb-3">
        <input id="buscaInstantanea" type="text" class="form-control" placeholder="Buscar usuário por nome, CPF/CNPJ, e-mail ou estado...">
    </div>

    <section class="card table-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table id="tabelaDados" class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>CPF/CNPJ</th>
                        <th>E-mail</th>
                        <th>Estado</th>
                        <th class="text-end">Ações</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% if (usuarios == null || usuarios.isEmpty()) { %>
                        <tr><td colspan="6" class="text-center py-4 text-muted">Nenhum usuário cadastrado.</td></tr>
                    <% } else { %>
                        <% for (Usuario usuario : usuarios) { %>
                            <tr>
                                <td><%= usuario.getId() %></td>
                                <td class="fw-semibold"><%= usuario.getNomeUsuario() %></td>
                                <td><%= usuario.getCpfCnpj() %></td>
                                <td><%= usuario.getEmail() %></td>

                                <td>
                                    <% if (usuario.getNomeEstado() != null) { %>
                                        <span class="badge text-bg-primary">
                                            <%= usuario.getNomeEstado() %> - <%= usuario.getSiglaEstado() %>
                                        </span>
                                    <% } else { %>
                                        <span class="badge text-bg-secondary">Sem estado</span>
                                    <% } %>
                                </td>

                                <td>
                                    <div class="action-buttons justify-content-end">
                                        <a class="btn btn-sm btn-outline-primary" href="<%= request.getContextPath() %>/usuarios/editar?id=<%= usuario.getId() %>">
                                            <i class="bi bi-pencil"></i>
                                        </a>

                                        <a class="btn btn-sm btn-outline-danger"
                                           href="<%= request.getContextPath() %>/usuarios/excluir?id=<%= usuario.getId() %>"
                                           onclick="return confirm('Deseja realmente excluir este usuário?')">
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
