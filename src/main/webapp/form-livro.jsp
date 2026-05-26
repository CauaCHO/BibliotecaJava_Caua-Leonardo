<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Livro" %>
<%@ page import="br.com.cadastro.model.Categoria" %>
<%
    Livro livro = (Livro) request.getAttribute("livro");
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    boolean editando = livro != null && livro.getId() != null;
    String capaAtual = livro != null && livro.getCapaLivro() != null && !livro.getCapaLivro().isBlank()
            ? livro.getCapaLivro()
            : "https://placehold.co/220x320/4f46e5/ffffff?text=Livro";
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= editando ? "Editar Livro" : "Novo Livro" %></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container py-2 d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/dashboard.jsp">📚 Biblioteca Java</a>

        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-light btn-rounded" href="<%= request.getContextPath() %>/livros">Livros</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/usuarios">Usuários</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/estados">Estados</a>
        </div>
    </div>
</nav>

<main class="container py-4">
    <section class="card hero-card mx-auto" style="max-width: 1020px;">
        <div class="card-body p-4 p-md-5">
            <div class="mb-4">
                <span class="badge text-bg-primary mb-2"><%= editando ? "Edição" : "Novo cadastro" %></span>
                <h1 class="h3 fw-bold mb-1"><%= editando ? "Editar Livro" : "Cadastrar Livro" %></h1>
                <p class="text-muted mb-0">Preencha os dados abaixo. O livro deve estar vinculado a uma categoria.</p>
            </div>

            <form id="formLivro" action="<%= request.getContextPath() %>/livros/salvar" method="post" class="row g-4">
                <% if (editando) { %>
                    <input type="hidden" name="id" value="<%= livro.getId() %>">
                <% } %>

                <div class="col-12 col-lg-8">
                    <div class="row g-3">
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
                            <input type="text" class="form-control" id="autor" name="autor" maxlength="100" required
                                   value="<%= livro != null && livro.getAutor() != null ? livro.getAutor() : "" %>">
                        </div>

                        <div class="col-12 col-md-6">
                            <label for="categoriaId" class="form-label">Categoria</label>
                            <select class="form-select" id="categoriaId" name="categoriaId" required>
                                <option value="">Selecione uma categoria</option>
                                <% if (categorias != null) { %>
                                    <% for (Categoria categoria : categorias) { %>
                                        <option value="<%= categoria.getId() %>"
                                            <%= livro != null && livro.getCategoriaId() != null && livro.getCategoriaId().equals(categoria.getId()) ? "selected" : "" %>>
                                            <%= categoria.getNomeCategoria() %>
                                        </option>
                                    <% } %>
                                <% } %>
                            </select>
                            <div class="form-text">Agora livro pertence a uma categoria.</div>
                        </div>

                        <div class="col-12">
                            <label for="capaLivro" class="form-label">URL da Capa do Livro</label>
                            <input type="url" class="form-control" id="capaLivro" name="capaLivro" maxlength="255"
                                   placeholder="https://exemplo.com/capa.jpg"
                                   value="<%= livro != null && livro.getCapaLivro() != null ? livro.getCapaLivro() : "" %>">
                            <div class="form-text">Se deixar vazio, o sistema usa uma capa padrão automaticamente.</div>
                        </div>

                        <div class="col-12 col-md-6">
                            <label for="dataPublicacao" class="form-label">Data de Publicação</label>
                            <input type="date" class="form-control" id="dataPublicacao" name="dataPublicacao" required
                                   value="<%= livro != null && livro.getDataPublicacao() != null ? livro.getDataPublicacao() : "" %>">
                        </div>

                        <div class="col-12 col-md-6">
                            <label for="valorLivro" class="form-label">Valor do Livro</label>
                            <input type="number" class="form-control" id="valorLivro" name="valorLivro" min="0" step="0.01" required
                                   value="<%= livro != null && livro.getValorLivro() != null ? livro.getValorLivro() : "" %>">
                        </div>
                    </div>
                </div>

                <div class="col-12 col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 p-3 text-center h-100">
                        <div class="text-muted mb-2">Prévia da capa</div>
                        <img id="previewCapaLivro" src="<%= capaAtual %>" alt="Capa do livro" class="img-fluid rounded-4 shadow-sm" style="max-height: 320px; object-fit: cover;">
                    </div>
                </div>

                <div class="col-12 d-flex flex-column flex-md-row gap-2 justify-content-end mt-4">
                    <a href="<%= request.getContextPath() %>/livros" class="btn btn-outline-secondary btn-rounded px-4">Cancelar</a>
                    <button type="submit" class="btn btn-primary btn-rounded px-4"><%= editando ? "Salvar Alterações" : "Cadastrar Livro" %></button>
                </div>
            </form>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/app.js"></script>
</body>
</html>
