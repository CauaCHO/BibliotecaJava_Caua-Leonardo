<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.cadastro.model.Livro" %>
<%
    Livro livro = (Livro) request.getAttribute("livro");
    boolean editando = livro != null && livro.getId() != null;
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= editando ? "Editar Livro" : "Novo Livro" %></title>
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
    <section class="card hero-card mx-auto" style="max-width: 850px;">
        <div class="card-body p-4">
            <div class="mb-4">
                <h1 class="h3 fw-bold mb-1"><%= editando ? "Editar Livro" : "Cadastrar Livro" %></h1>
                <p class="text-muted mb-0">Preencha os dados abaixo para manter o cadastro atualizado.</p>
            </div>

            <form action="<%= request.getContextPath() %>/livros/salvar" method="post" class="row g-3">
                <% if (editando) { %>
                    <input type="hidden" name="id" value="<%= livro.getId() %>">
                <% } %>

                <div class="col-12 col-md-8">
                    <label for="nomeLivro" class="form-label">Nome do Livro</label>
                    <input type="text" class="form-control" id="nomeLivro" name="nomeLivro" maxlength="150" required
                           value="<%= livro != null && livro.getNomeLivro() != null ? livro.getNomeLivro() : "" %>">
                </div>

                <div class="col-12 col-md-4">
                    <label for="isbn" class="form-label">ISBN</label>
                    <input type="text" class="form-control" id="isbn" name="isbn" maxlength="50" required
                           value="<%= livro != null && livro.getIsbn() != null ? livro.getIsbn() : "" %>">
                </div>

                <div class="col-12 col-md-6">
                    <label for="autor" class="form-label">Autor</label>
                    <input type="text" class="form-control" id="autor" name="autor" maxlength="120" required
                           value="<%= livro != null && livro.getAutor() != null ? livro.getAutor() : "" %>">
                </div>

                <div class="col-12 col-md-3">
                    <label for="dataPublicacao" class="form-label">Data de Publicação</label>
                    <input type="date" class="form-control" id="dataPublicacao" name="dataPublicacao" required
                           value="<%= livro != null && livro.getDataPublicacao() != null ? livro.getDataPublicacao() : "" %>">
                </div>

                <div class="col-12 col-md-3">
                    <label for="valorLivro" class="form-label">Valor do Livro</label>
                    <input type="number" class="form-control" id="valorLivro" name="valorLivro" min="0" step="0.01" required
                           value="<%= livro != null && livro.getValorLivro() != null ? livro.getValorLivro() : "" %>">
                </div>

                <div class="col-12 d-flex flex-column flex-md-row gap-2 justify-content-end mt-4">
                    <a href="<%= request.getContextPath() %>/livros" class="btn btn-outline-secondary btn-rounded px-4">Cancelar</a>
                    <button type="submit" class="btn btn-primary btn-rounded px-4"><%= editando ? "Salvar Alterações" : "Cadastrar Livro" %></button>
                </div>
            </form>
        </div>
    </section>
</main>
</body>
</html>
