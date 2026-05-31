<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Usuario" %>
<%@ page import="br.com.cadastro.model.Livro" %>
<%@ page import="br.com.cadastro.model.Emprestimo" %>
<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
    List<Livro> livros = (List<Livro>) request.getAttribute("livros");
    List<Emprestimo> emprestimos = (List<Emprestimo>) request.getAttribute("emprestimos");
    String mensagemSucesso = (String) session.getAttribute("mensagemSucesso");
    String mensagemErro = (String) request.getAttribute("mensagemErro");

    if (mensagemSucesso != null) {
        session.removeAttribute("mensagemSucesso");
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empréstimos - CL Book's</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/navbar.jsp" />

<main class="container-fluid px-4 px-lg-5 py-5">

    <section class="hero-card p-5 mb-5">
        <div class="row align-items-center g-5">
            <div class="col-lg-7">
                <span class="badge badge-soft mb-3">Movimentação do Acervo</span>
                <h1 class="display-4 fw-bold mb-3">Empréstimos com fluxo real.</h1>
                <p class="text-muted fs-5 mb-4">Selecione pessoa, livro e data prevista de devolução sem digitar IDs manualmente.</p>

                <div class="d-flex gap-3 flex-wrap">
                    <a href="<%= request.getContextPath() %>/livros" class="btn btn-outline-light btn-lg btn-rounded px-4">Ver Livros</a>
                    <a href="<%= request.getContextPath() %>/usuarios" class="btn btn-outline-light btn-lg btn-rounded px-4">Ver Pessoas</a>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="chart-glow-card p-5 text-center">
                    <i class="bi bi-arrow-left-right" style="font-size:5rem;color:#8B5CF6"></i>
                    <h3 class="fw-bold mt-4 mb-2"><%= emprestimos != null ? emprestimos.size() : 0 %> registro(s)</h3>
                    <p class="text-muted mb-0">Histórico de movimentações do acervo.</p>
                </div>
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

    <section class="table-card p-4 p-lg-5 mb-5">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
            <div>
                <h2 class="fw-bold mb-1">Novo empréstimo</h2>
                <p class="text-muted mb-0">Escolha os registros já cadastrados no sistema.</p>
            </div>
            <span class="badge text-bg-primary px-3 py-2">Operação ativa</span>
        </div>

        <form method="post" action="<%= request.getContextPath() %>/emprestimos" class="row g-4">
            <div class="col-md-4">
                <label class="form-label">Pessoa</label>
                <select name="usuarioId" class="form-select" required>
                    <option value="">Selecione uma pessoa</option>
                    <% if (usuarios != null) {
                        for (Usuario usuario : usuarios) { %>
                            <option value="<%= usuario.getId() %>"><%= usuario.getNomeUsuario() %> - <%= usuario.getEmail() %></option>
                    <% }} %>
                </select>
            </div>

            <div class="col-md-4">
                <label class="form-label">Livro</label>
                <select name="livroId" class="form-select" required>
                    <option value="">Selecione um livro</option>
                    <% if (livros != null) {
                        for (Livro livro : livros) { %>
                            <option value="<%= livro.getId() %>"><%= livro.getNomeLivro() %> - <%= livro.getAutor() %></option>
                    <% }} %>
                </select>
            </div>

            <div class="col-md-4">
                <label class="form-label">Data prevista de devolução</label>
                <input type="date" name="dataDevolucao" class="form-control" required>
            </div>

            <div class="col-12 d-flex justify-content-end gap-3 mt-4">
                <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-outline-light btn-rounded px-4">Cancelar</a>
                <button type="submit" class="btn btn-primary btn-rounded px-5">Registrar Empréstimo</button>
            </div>
        </form>
    </section>

    <section class="table-card p-4 p-lg-5">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
            <div>
                <h2 class="fw-bold mb-1">Empréstimos cadastrados</h2>
                <p class="text-muted mb-0">Histórico de movimentações registradas.</p>
            </div>
            <span class="badge text-bg-primary px-3 py-2 fs-6"><%= emprestimos != null ? emprestimos.size() : 0 %> empréstimos</span>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Pessoa</th>
                    <th>Livro</th>
                    <th>Empréstimo</th>
                    <th>Prevista</th>
                    <th>Status</th>
                    <th>Renovações</th>
                </tr>
                </thead>
                <tbody>
                <% if (emprestimos == null || emprestimos.isEmpty()) { %>
                    <tr>
                        <td colspan="7" class="text-center py-5 text-muted">Nenhum empréstimo registrado.</td>
                    </tr>
                <% } else {
                    for (Emprestimo emprestimo : emprestimos) { %>
                        <tr>
                            <td><%= emprestimo.getId() %></td>
                            <td class="fw-semibold"><%= emprestimo.getNomeUsuario() %></td>
                            <td><%= emprestimo.getNomeLivro() %></td>
                            <td><%= emprestimo.getDataEmprestimo() %></td>
                            <td><%= emprestimo.getDataDevolucaoPrevista() %></td>
                            <td><span class="badge text-bg-primary px-3 py-2"><%= emprestimo.getStatus() %></span></td>
                            <td><%= emprestimo.getRenovacoesRestantes() %></td>
                        </tr>
                <% }} %>
                </tbody>
            </table>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/js/app.js"></script>
</body>
</html>