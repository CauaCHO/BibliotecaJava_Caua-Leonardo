<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.cadastro.model.Estado" %>
<%
    Estado estado = (Estado) request.getAttribute("estado");
    boolean editando = estado != null && estado.getId() != null;
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= editando ? "Editar Estado" : "Novo Estado" %></title>
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
    <section class="card hero-card mx-auto border-0 shadow-sm" style="max-width: 700px;">
        <div class="card-body p-4 p-md-5">

            <div class="mb-4">
                <span class="badge text-bg-primary mb-2"><%= editando ? "Edição" : "Novo cadastro" %></span>
                <h1 class="h3 fw-bold mb-1"><%= editando ? "Editar Estado" : "Cadastrar Estado" %></h1>
                <p class="text-muted mb-0">A sigla deve possuir 2 caracteres e não pode ser duplicada.</p>
            </div>

            <form action="<%= request.getContextPath() %>/estados/salvar" method="post" class="row g-3 needs-validation" novalidate>

                <% if (editando) { %>
                    <input type="hidden" name="id" value="<%= estado.getId() %>">
                <% } %>

                <div class="col-12">
                    <label for="nomeEstado" class="form-label">Nome do Estado</label>
                    <input type="text"
                           class="form-control"
                           id="nomeEstado"
                           name="nomeEstado"
                           maxlength="100"
                           required
                           value="<%= estado != null && estado.getNomeEstado() != null ? estado.getNomeEstado() : "" %>">

                    <div class="invalid-feedback">
                        Informe o nome do estado.
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <label for="siglaEstado" class="form-label">Sigla</label>
                    <input type="text"
                           class="form-control text-uppercase"
                           id="siglaEstado"
                           name="siglaEstado"
                           maxlength="2"
                           minlength="2"
                           required
                           value="<%= estado != null && estado.getSiglaEstado() != null ? estado.getSiglaEstado() : "" %>">

                    <div class="invalid-feedback">
                        Informe uma sigla válida com 2 caracteres.
                    </div>
                </div>

                <div class="col-12 d-flex flex-column flex-md-row gap-2 justify-content-end mt-4">
                    <a href="<%= request.getContextPath() %>/estados"
                       class="btn btn-outline-secondary btn-rounded px-4">
                        Cancelar
                    </a>

                    <button type="submit"
                            class="btn btn-primary btn-rounded px-4">
                        <%= editando ? "Salvar Alterações" : "Cadastrar Estado" %>
                    </button>
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
</body>
</html>
