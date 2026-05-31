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
    <title><%= editando ? "Editar Categoria" : "Nova Categoria" %> - CL Book's</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/navbar.jsp" />

<main class="container-fluid px-4 px-lg-5 py-5">
    <section class="hero-card mx-auto p-4 p-lg-5" style="max-width: 880px;">
        <div class="mb-5">
            <span class="badge badge-soft mb-3"><%= editando ? "Edição Premium" : "Novo Cadastro" %></span>
            <h1 class="display-6 fw-bold mb-2"><%= editando ? "Editar Categoria" : "Cadastrar Categoria" %></h1>
            <p class="text-muted fs-5 mb-0">Categorias organizam o catálogo e conectam os livros por assunto.</p>
        </div>

        <form action="<%= request.getContextPath() %>/categorias/salvar" method="post" class="row g-4 needs-validation" novalidate>
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
                <textarea class="form-control" name="descricao" maxlength="255" rows="5" placeholder="Ex: Livros sobre programação, banco de dados, tecnologia..."><%= categoria != null && categoria.getDescricao() != null ? categoria.getDescricao() : "" %></textarea>
            </div>

            <div class="col-12 d-flex justify-content-end gap-3 mt-4">
                <a href="<%= request.getContextPath() %>/categorias" class="btn btn-outline-light btn-rounded px-4">Cancelar</a>
                <button type="submit" class="btn btn-primary btn-rounded px-5"><%= editando ? "Salvar Alterações" : "Cadastrar Categoria" %></button>
            </div>
        </form>
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