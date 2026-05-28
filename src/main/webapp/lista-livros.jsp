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
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
    <div class="container py-2 d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/dashboard.jsp">📚 CL Book's</a>

        <div class="d-flex gap-2 flex-wrap">
            <a class="btn btn-sm btn-light btn-rounded" href="<%= request.getContextPath() %>/livros">Catálogo</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/usuarios">Usuários</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/estados">Estados</a>
        </div>
    </div>
</nav>

<main class="container py-4">

    <section class="hero-card mb-4">
        <div class="card-body p-4 p-lg-5 d-flex flex-column flex-lg-row justify-content-between gap-4 align-items-lg-center">
            <div>
                <span class="badge badge-soft mb-3">Catálogo Premium</span>
                <h1 class="display-5 fw-bold mb-2">Livros cadastrados com visual moderno.</h1>
                <p class="text-muted mb-0">Gerencie obras, categorias, autores, capas e valores em uma experiência mais elegante.</p>
            </div>

            <div class="text-lg-end">
                <div class="metric-value mb-2"><%= totalLivros != null ? totalLivros : 0 %></div>
                <p class="text-muted mb-3">livros no catálogo</p>
                <a href="<%= request.getContextPath() %>/livros/novo" class="btn btn-primary btn-rounded px-4">
                    <i class="bi bi-plus-lg"></i>
                    Novo Livro
                </a>
            </div>
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

    <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap mb-4">
        <input id="buscaInstantanea" type="text" class="form-control" style="max-width: 460px;"
               placeholder="Buscar livro por nome, ISBN, autor ou categoria...">

        <span class="badge text-bg-primary fs-6 px-3 py-2">
            <%= livros != null ? livros.size() : 0 %> resultado(s)
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
                        <img src="<%= capa %>" alt="Capa de <%= livro.getNomeLivro() %>"
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='grid';">
                        <div class="book-cover-fallback"><i class="bi bi-book-half"></i></div>
                    </div>

                    <div class="book-content">
                        <span class="book-category"><%= livro.getNomeCategoria() != null ? livro.getNomeCategoria() : "Sem categoria" %></span>
                        <h3 class="mt-3 mb-1"><%= livro.getNomeLivro() %></h3>
                        <p class="text-muted mb-2"><%= livro.getAutor() %></p>
                        <small class="text-muted d-block mb-3">ISBN: <%= livro.getIsbn() %></small>

                        <div class="d-flex justify-content-between align-items-center gap-2">
                            <div class="book-price">R$ <%= livro.getValorLivro() %></div>

                            <div class="action-buttons">
                                <a class="btn btn-sm btn-outline-light" href="<%= request.getContextPath() %>/livros/editar?id=<%= livro.getId() %>">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a class="btn btn-sm btn-outline-danger" href="<%= request.getContextPath() %>/livros/excluir?id=<%= livro.getId() %>"
                                   onclick="return confirm('Deseja realmente excluir este livro?')">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </article>
            <% } %>
        <% } %>
    </section>

    <section class="card table-card">
        <div class="card-body p-0">
            <div class="table-responsive desktop-table">
                <table id="tabelaDados" class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Livro</th>
                        <th>Categoria</th>
                        <th>Autor</th>
                        <th>Valor</th>
                        <th class="text-end">Ações</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (livros == null || livros.isEmpty()) { %>
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">Nenhum livro cadastrado.</td>
                        </tr>
                    <% } else { %>
                        <% for (Livro livro : livros) { %>
                            <tr class="item-busca">
                                <td><%= livro.getId() %></td>
                                <td>
                                    <div class="fw-semibold"><%= livro.getNomeLivro() %></div>
                                    <small class="text-muted">ISBN: <%= livro.getIsbn() %></small>
                                </td>
                                <td><span class="badge text-bg-primary"><%= livro.getNomeCategoria() != null ? livro.getNomeCategoria() : "Sem categoria" %></span></td>
                                <td><%= livro.getAutor() %></td>
                                <td>R$ <%= livro.getValorLivro() %></td>
                                <td>
                                    <div class="action-buttons justify-content-end">
                                        <a class="btn btn-sm btn-outline-primary" href="<%= request.getContextPath() %>/livros/editar?id=<%= livro.getId() %>"><i class="bi bi-pencil"></i></a>
                                        <a class="btn btn-sm btn-outline-danger" href="<%= request.getContextPath() %>/livros/excluir?id=<%= livro.getId() %>" onclick="return confirm('Deseja realmente excluir este livro?')"><i class="bi bi-trash"></i></a>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/app.js"></script>
</body>
</html>
