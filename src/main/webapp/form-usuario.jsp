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
    <title><%= editando ? "Editar Usuário" : "Novo Usuário" %></title>

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
    <section class="card hero-card mx-auto" style="max-width: 760px;">
        <div class="card-body p-5">
            <div class="mb-4">
                <span class="badge badge-soft mb-2"><%= editando ? "Edição" : "Novo Cadastro" %></span>
                <h1 class="h3 fw-bold mb-1"><%= editando ? "Editar Usuário" : "Cadastrar Usuário" %></h1>
                <p class="text-muted mb-0">O usuário agora fica vinculado a um estado cadastrado.</p>
            </div>

            <form id="formUsuario" action="<%= request.getContextPath() %>/usuarios/salvar" method="post" class="row g-3 needs-validation" novalidate>
                <% if (editando) { %>
                    <input type="hidden" name="id" value="<%= usuario.getId() %>">
                <% } %>

                <div class="col-12">
                    <label class="form-label">Nome do Usuário</label>
                    <input type="text" class="form-control" name="nomeUsuario" maxlength="120" required
                           value="<%= usuario != null && usuario.getNomeUsuario() != null ? usuario.getNomeUsuario() : "" %>">
                    <div class="invalid-feedback">Informe o nome do usuário.</div>
                </div>

                <div class="col-12 col-md-6">
                    <label class="form-label">CPF/CNPJ</label>
                    <input type="text" class="form-control" id="cpfCnpj" name="cpfCnpj" maxlength="18" required
                           value="<%= usuario != null && usuario.getCpfCnpj() != null ? usuario.getCpfCnpj() : "" %>">
                    <div class="invalid-feedback">Informe o CPF/CNPJ.</div>
                </div>

                <div class="col-12 col-md-6">
                    <label class="form-label">E-mail</label>
                    <input type="email" class="form-control" id="email" name="email" maxlength="150" required
                           value="<%= usuario != null && usuario.getEmail() != null ? usuario.getEmail() : "" %>">
                    <div class="invalid-feedback">Informe um e-mail válido.</div>
                </div>

                <div class="col-12">
                    <label class="form-label">Estado</label>
                    <select class="form-select" name="estadoId" required>
                        <option value="">Selecione um estado</option>
                        <% if (estados != null) { %>
                            <% for (Estado estado : estados) { %>
                                <option value="<%= estado.getId() %>"
                                    <%= usuario != null && usuario.getEstadoId() != null && usuario.getEstadoId().equals(estado.getId()) ? "selected" : "" %>>
                                    <%= estado.getNomeEstado() %> - <%= estado.getSiglaEstado() %>
                                </option>
                            <% } %>
                        <% } %>
                    </select>
                    <div class="invalid-feedback">Selecione o estado do usuário.</div>
                </div>

                <div class="col-12 d-flex justify-content-end gap-2 mt-4">
                    <a href="<%= request.getContextPath() %>/usuarios" class="btn btn-outline-secondary btn-rounded px-4">Cancelar</a>
                    <button type="submit" class="btn btn-primary btn-rounded px-4"><%= editando ? "Salvar Alterações" : "Cadastrar Usuário" %></button>
                </div>
            </form>
        </div>
    </section>
</main>

<script>
    (() => {
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/app.js"></script>
</body>
</html>
