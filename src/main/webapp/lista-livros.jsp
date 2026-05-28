<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Livro" %>
<%
    List<Livro> livros = (List<Livro>) request.getAttribute("livros");
    String mensagemSucesso = (String) session.getAttribute("mensagemSucesso");
    String mensagemErro = (String) request.getAttribute("mensagemErro");
    Object totalLivros = request.getAttribute("totalLivros");

    if (mensagemSucesso != null) {
        session.removeAttribute("mensagemSucesso");
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CL Book's - Catálogo</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/navbar.jsp" />

<main class="container-fluid px-4 px-lg-5 py-5">

    <section class="hero-card catalog-hero mb-5 p-5">
        <div class="row align-items-center g-5">
            <div class="col-lg-7">
                <span class="badge badge-soft mb-3">Catálogo cinematográfico</span>
                <h1 class="display-3 fw-bold mb-3">Explore livros em uma experiência premium.</h1>
                <p class="text-muted fs-5 mb-4">Visual inspirado em plataformas modernas com foco em impacto visual e experiência elegante.</p>

                <div class="d-flex gap-3 flex-wrap">
                    <a href="<%= request.getContextPath() %>/livros/novo" class="btn btn-primary btn-lg btn-rounded px-4">
                        Novo Livro
                    </a>

                    <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-outline-light btn-lg btn-rounded px-4">
                        Dashboard
                    </a>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="catalog-floating-books">
                    <div class="floating-book glow-orange"></div>
                    <div class="floating-book glow-purple"></div>
                    <div class="floating-book glow-blue"></div>
                </div>
            </div>
        </div>
    </section>

    <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap mb-4">
        <input id="buscaInstantanea" type="text" class="form-control search-premium"
               style="max-width: 460px;"
               placeholder="Buscar livro por nome, ISBN ou autor...">

        <span class="badge text-bg-primary fs-6 px-3 py-2">
            <%= livros != null ? livros.size() : 0 %> livros
        </span>
    </div>

    <section class="catalog-grid mb-4">
        <% if (livros != null && !livros.isEmpty()) { %>
            <% for (Livro livro : livros) {
                String capa = livro.getCapaLivro() != null && !livro.getCapaLivro().isBlank()
                        ? livro.getCapaLivro()
                        : "https://placehold.co/360x520/1e293b/f59e0b?text=CL+Book%27s";
            %>
                <article class="book-card item-busca">
                    <div class="book-cover-large">
                        <img src="<%= capa %>" alt="Capa de <%= livro.getNomeLivro() %>">
                    </div>

                    <div class="book-content">
                        <span class="book-category"><%= livro.getNomeCategoria() != null ? livro.getNomeCategoria() : "Sem categoria" %></span>
                        <h3 class="mt-3 mb-1"><%= livro.getNomeLivro() %></h3>
                        <p class="text-muted mb-2"><%= livro.getAutor() %></p>
                        <small class="text-muted d-block mb-3">ISBN: <%= livro.getIsbn() %></small>

                        <div class="d-flex justify-content-between align-items-center gap-2">
                            <div class="book-price">R$ <%= livro.getValorLivro() %></div>

                            <div class="action-buttons">
                                <a class="btn btn-sm btn-outline-light rounded-pill" href="<%= request.getContextPath() %>/livros/editar?id=<%= livro.getId() %>">
                                    <i class="bi bi-pencil"></i>
                                </a>

                                <a class="btn btn-sm btn-outline-danger rounded-pill" href="<%= request.getContextPath() %>/livros/excluir?id=<%= livro.getId() %>">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </article>
            <% } %>
        <% } %>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/app.js"></script>
</body>
</html>
