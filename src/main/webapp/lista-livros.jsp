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
    <title>Biblioteca Java - Livros</title>

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

    <div class="row g-3 mb-4">
        <div class="col-12 col-md-4">
            <div class="metric-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Total de Livros</p>
                        <h2 class="metric-value mb-0"><%= totalLivros != null ? totalLivros : 0 %></h2>
                    </div>
                    <div class="book-cover"><i class="bi bi-book"></i></div>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-4">
            <div class="metric-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Sistema</p>
                        <h2 class="metric-value mb-0">Java Web</h2>
                    </div>
                    <div class="book-cover"><i class="bi bi-code-slash"></i></div>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-4">
            <div class="metric-card">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Banco de Dados</p>
                        <h2 class="metric-value mb-0">PostgreSQL</h2>
                    </div>
                    <div class="book-cover"><i class="bi bi-database"></i></div>
                </div>
            </div>
        </div>
    </div>

    <section class="card hero-card mb-4">
        <div class="card-body p-4 d-flex flex-column flex-lg-row justify-content-between gap-3 align-items-lg-center">
            <div>
                <span class="badge badge-soft mb-2">Sistema de Gestão de Biblioteca</span>
                <h1 class="h3 fw-bold mb-1">Cadastro de Livros</h1>
                <p class="text-muted mb-0">Gerencie livros, usuários e estados do sistema.</p>
            </div>

            <a href="<%= request.getContextPath() %>/livros/novo" class="btn btn-primary btn-rounded px-4">
                <i class="bi bi-plus-lg"></i>
                Novo Livro
            </a>
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

    <div class="mb-3">
        <input id="buscaInstantanea" type="text" class="form-control" placeholder="Buscar livro por nome, ISBN, autor ou e-mail...">
    </div>

    <section class="card table-card">
        <div class="card-body p-0">
            <div class="table-responsive desktop-table">
                <table id="tabelaDados" class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Livro</th>
                        <th>Email</th>
                        <th>Autor</th>
                        <th>Valor</th>
                        <th class="text-end">Ações</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (livros == null || livros.isEmpty()) { %>
                        <tr><td colspan="6" class="text-center text-muted py-4">Nenhum livro cadastrado.</td></tr>
                    <% } else { %>
                        <% for (Livro livro : livros) { %>
                            <tr>
                                <td><%= livro.getId() %></td>
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="book-cover"><i class="bi bi-book"></i></div>
                                        <div>
                                            <div class="fw-semibold"><%= livro.getNomeLivro() %></div>
                                            <small class="text-muted">ISBN: <%= livro.getIsbn() %></small>
                                        </div>
                                    </div>
                                </td>
                                <td><%= livro.getEmail() %></td>
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
