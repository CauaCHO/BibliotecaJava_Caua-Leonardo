<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.cadastro.model.Categoria" %>
<%
    Categoria categoria = (Categoria) request.getAttribute("categoria");
    boolean editando = categoria != null && categoria.getId() != null;
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= editando ? "Editar Categoria" : "Nova Categoria" %></title>

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
    <section class="card hero-card mx-auto" style="max-width: 760px;">
        <div class="card-body p-5">
            <div class="mb-4">
                <span class="badge badge-soft mb-2"><%= editando ? "Edição" : "Novo Cadastro" %></span>
                <h1 class="h3 fw-bold mb-1"><%= editando ? "Editar Categoria" : "Cadastrar Categoria" %></h1>
                <p class="text-muted mb-0">As categorias organizam os livros e deixam o sistema mais conectado.</p>
            </div>

            <form action="<%= request.getContextPath() %>/categorias/salvar" method="post" class="row g-3 needs-validation" novalidate>
                <% if (editando) { %>
                    <input type="hidden" name="id" value="<%= categoria.getId() %>">
                <% } %>

                <div class="col-12">
                    <label class="form-label">Nome da Categoria</label>
                    <input type="text" class="form-control" name="nomeCategoria" maxlength="100" required
                           value="<%= categoria != null && categoria.getNomeCategoria() != null ? categoria.getNomeCategoria() : "" %>">
                    <div class="invalid-feedback">Informe o nome da categoria.</div>
                </div>

                <div class="col-12">
                    <label class="form-label">Descrição</label>
                    <textarea class="form-control" name="descricao" maxlength="255" rows="4" placeholder="Ex: Livros sobre programação, banco de dados, tecnologia..."><%= categoria != null && categoria.getDescricao() != null ? categoria.getDescricao() : "" %></textarea>
                </div>

                <div class="col-12 d-flex justify-content-end gap-2 mt-4">
                    <a href="<%= request.getContextPath() %>/categorias" class="btn btn-outline-secondary btn-rounded px-4">Cancelar</a>
                    <button type="submit" class="btn btn-primary btn-rounded px-4"><%= editando ? "Salvar Alterações" : "Cadastrar Categoria" %></button>
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
