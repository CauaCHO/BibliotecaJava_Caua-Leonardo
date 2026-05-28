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
    <title>Pessoas - CL Book's</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/navbar.jsp" />

<main class="container py-5">

    <section class="hero-card mb-5">
        <div class="card-body p-5 d-flex flex-column flex-lg-row justify-content-between gap-4 align-items-lg-center">
            <div>
                <span class="badge badge-soft mb-3">Pessoas & Gestão</span>
                <h1 class="display-5 fw-bold mb-2">Gerenciamento premium de usuários.</h1>
                <p class="text-muted mb-0 fs-5">Cadastre administradores, leitores e bibliotecários dentro da plataforma.</p>
            </div>

            <a href="<%= request.getContextPath() %>/usuarios/novo" class="btn btn-primary btn-lg px-4 btn-rounded">
                <i class="bi bi-plus-lg"></i>
                Nova Pessoa
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

    <div class="card table-card border-0">
        <div class="card-body p-4">

            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
                <input id="buscaInstantanea" type="text" class="form-control"
                       style="max-width:420px"
                       placeholder="Buscar pessoas...">

                <div class="badge text-bg-primary px-3 py-2 fs-6">
                    <%= usuarios != null ? usuarios.size() : 0 %> registros
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
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
                    <% if (usuarios != null) {
                        for (Usuario usuario : usuarios) {
                    %>
                    <tr>
                        <td><%= usuario.getId() %></td>
                        <td class="fw-semibold"><%= usuario.getNomeUsuario() %></td>
                        <td><%= usuario.getCpfCnpj() %></td>
                        <td><%= usuario.getEmail() %></td>
                        <td>
                            <span class="badge text-bg-primary">
                                <%= usuario.getSiglaEstado() != null ? usuario.getSiglaEstado() : "--" %>
                            </span>
                        </td>
                        <td>
                            <div class="action-buttons justify-content-end">
                                <a class="btn btn-sm btn-outline-primary" href="<%= request.getContextPath() %>/usuarios/editar?id=<%= usuario.getId() %>">
                                    <i class="bi bi-pencil"></i>
                                </a>

                                <a class="btn btn-sm btn-outline-danger"
                                   href="<%= request.getContextPath() %>/usuarios/excluir?id=<%= usuario.getId() %>">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% }} %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/app.js"></script>
</body>
</html>
