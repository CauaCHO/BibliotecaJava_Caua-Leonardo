<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Usuario" %>
<%@ page import="br.com.cadastro.model.Estado" %>
<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    List<Estado> estados = (List<Estado>) request.getAttribute("estados");
    boolean editando = usuario != null && usuario.getId() != null;
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= editando ? "Editar Pessoa" : "Nova Pessoa" %></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/navbar.jsp" />

<main class="container py-5">
    <section class="hero-card mx-auto" style="max-width: 860px;">
        <div class="card-body p-5">

            <div class="mb-5">
                <span class="badge badge-soft mb-3"><%= editando ? "Edição Premium" : "Novo Cadastro" %></span>
                <h1 class="display-6 fw-bold mb-2"><%= editando ? "Editar Pessoa" : "Cadastrar Pessoa" %></h1>
                <p class="text-muted fs-5 mb-0">Sistema unificado com design cinematográfico.</p>
            </div>

            <form action="<%= request.getContextPath() %>/usuarios/salvar" method="post" class="row g-4">

                <% if (editando) { %>
                    <input type="hidden" name="id" value="<%= usuario.getId() %>">
                <% } %>

                <div class="col-12">
                    <label class="form-label">Nome</label>
                    <input type="text" class="form-control" name="nomeUsuario"
                           value="<%= usuario != null && usuario.getNomeUsuario() != null ? usuario.getNomeUsuario() : "" %>"
                           required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">CPF/CNPJ</label>
                    <input type="text" class="form-control" name="cpfCnpj"
                           value="<%= usuario != null && usuario.getCpfCnpj() != null ? usuario.getCpfCnpj() : "" %>"
                           required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">E-mail</label>
                    <input type="email" class="form-control" name="email"
                           value="<%= usuario != null && usuario.getEmail() != null ? usuario.getEmail() : "" %>"
                           required>
                </div>

                <div class="col-12">
                    <label class="form-label">Estado</label>
                    <select class="form-select" name="estadoId" required>
                        <option value="">Selecione</option>

                        <% if (estados != null) {
                            for (Estado estado : estados) {
                        %>
                        <option value="<%= estado.getId() %>">
                            <%= estado.getNomeEstado() %> - <%= estado.getSiglaEstado() %>
                        </option>
                        <% }} %>
                    </select>
                </div>

                <div class="col-12 d-flex justify-content-end gap-3 mt-4">
                    <a href="<%= request.getContextPath() %>/usuarios" class="btn btn-outline-light btn-rounded px-4">
                        Voltar
                    </a>

                    <button type="submit" class="btn btn-primary btn-rounded px-5">
                        <%= editando ? "Salvar Alterações" : "Cadastrar Pessoa" %>
                    </button>
                </div>
            </form>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
