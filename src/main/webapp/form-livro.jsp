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
            : "https://placehold.co/360x520/1e293b/f59e0b?text=CL+Book%27s";
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= editando ? "Editar Livro" : "Novo Livro" %> - CL Book's</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/navbar.jsp" />

<main class="container-fluid px-4 px-lg-5 py-5">
    <section class="hero-card mx-auto p-4 p-lg-5" style="max-width: 1180px;">
        <div class="row g-5 align-items-center">
            <div class="col-lg-7">
                <span class="badge badge-soft mb-3"><%= editando ? "Edição premium" : "Novo cadastro" %></span>
                <h1 class="display-5 fw-bold mb-3"><%= editando ? "Editar obra do catálogo" : "Cadastrar nova obra" %></h1>
                <p class="text-muted fs-5 mb-4">Organize capa, categoria, ISBN, autor e valor em uma tela cinematográfica unificada.</p>

                <form id="formLivro" action="<%= request.getContextPath() %>/livros/salvar" method="post" class="row g-4">
                    <% if (editando) { %>
                        <input type="hidden" name="id" value="<%= livro.getId() %>">
                    <% } %>

                    <div class="col-md-8">
                        <label class="form-label">Nome do Livro</label>
                        <input type="text" class="form-control" name="nomeLivro" maxlength="150" required
                               value="<%= livro != null && livro.getNomeLivro() != null ? livro.getNomeLivro() : "" %>">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">ISBN</label>
                        <input type="text" class="form-control" name="isbn" maxlength="50" required
                               value="<%= livro != null && livro.getIsbn() != null ? livro.getIsbn() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Autor</label>
                        <input type="text" class="form-control" name="autor" maxlength="100" required
                               value="<%= livro != null && livro.getAutor() != null ? livro.getAutor() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Categoria</label>
                        <select class="form-select" name="categoriaId" required>
                            <option value="">Selecione uma categoria</option>
                            <% if (categorias != null) {
                                for (Categoria categoria : categorias) {
                            %>
                            <option value="<%= categoria.getId() %>"
                                <%= livro != null && livro.getCategoriaId() != null && livro.getCategoriaId().equals(categoria.getId()) ? "selected" : "" %>>
                                <%= categoria.getNomeCategoria() %>
                            </option>
                            <% }} %>
                        </select>
                    </div>

                    <div class="col-12">
                        <label class="form-label">URL da Capa</label>
                        <input type="url" class="form-control" id="capaLivro" name="capaLivro" maxlength="255"
                               placeholder="https://exemplo.com/capa.jpg"
                               value="<%= livro != null && livro.getCapaLivro() != null ? livro.getCapaLivro() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Data de Publicação</label>
                        <input type="date" class="form-control" name="dataPublicacao" required
                               value="<%= livro != null && livro.getDataPublicacao() != null ? livro.getDataPublicacao() : "" %>">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Valor</label>
                        <input type="number" class="form-control" name="valorLivro" min="0" step="0.01" required
                               value="<%= livro != null && livro.getValorLivro() != null ? livro.getValorLivro() : "" %>">
                    </div>

                    <div class="col-12 d-flex justify-content-end gap-3 mt-4">
                        <a href="<%= request.getContextPath() %>/livros" class="btn btn-outline-light btn-rounded px-4">Cancelar</a>
                        <button type="submit" class="btn btn-primary btn-rounded px-5"><%= editando ? "Salvar Alterações" : "Cadastrar Livro" %></button>
                    </div>
                </form>
            </div>

            <div class="col-lg-5">
                <div class="book-preview-premium mx-auto">
                    <img id="previewCapaLivro" src="<%= capaAtual %>" alt="Capa do livro">
                    <div class="book-preview-glow"></div>
                </div>
            </div>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/app.js"></script>
</body>
</html>
