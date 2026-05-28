<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.cadastro.model.Estado" %>
<%
    List<Estado> estados = (List<Estado>) request.getAttribute("estados");
    Long totalEstados = (Long) request.getAttribute("totalEstados");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Estados - CL Book's</title>

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
            <div class="col-lg-8">
                <span class="badge badge-soft mb-3">Regiões & Localização</span>
                <h1 class="display-4 fw-bold mb-3">Gerencie estados da plataforma.</h1>
                <p class="text-muted fs-5 mb-4">Sistema premium para organização geográfica do ecossistema literário.</p>

                <a href="<%= request.getContextPath() %>/estados/novo" class="btn btn-primary btn-lg btn-rounded px-4">
                    Novo Estado
                </a>
            </div>

            <div class="col-lg-4">
                <div class="chart-glow-card text-center p-5">
                    <i class="bi bi-geo-alt-fill" style="font-size: 5rem; color: #F59E0B"></i>
                </div>
            </div>
        </div>
    </section>

    <section class="table-card p-4">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
            <div>
                <h2 class="fw-bold mb-1">Estados cadastrados</h2>
                <p class="text-muted mb-0">Base geográfica da plataforma.</p>
            </div>

            <span class="badge text-bg-primary px-3 py-2 fs-6">
                <%= totalEstados != null ? totalEstados : 0 %> estados
            </span>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Estado</th>
                    <th>Sigla</th>
                    <th class="text-end">Ações</th>
                </tr>
                </thead>

                <tbody>
                <% if (estados != null && !estados.isEmpty()) {
                    for (Estado estado : estados) { %>

                    <tr>
                        <td><%= estado.getId() %></td>
                        <td class="fw-semibold"><%= estado.getNomeEstado() %></td>
                        <td>
                            <span class="badge text-bg-primary px-3 py-2">
                                <%= estado.getSiglaEstado() %>
                            </span>
                        </td>
                        <td>
                            <div class="action-buttons justify-content-end">
                                <a href="<%= request.getContextPath() %>/estados/editar?id=<%= estado.getId() %>"
                                   class="btn btn-sm btn-outline-light rounded-pill">
                                    <i class="bi bi-pencil"></i>
                                </a>

                                <a href="<%= request.getContextPath() %>/estados/excluir?id=<%= estado.getId() %>"
                                   class="btn btn-sm btn-outline-danger rounded-pill"
                                   onclick="return confirm('Deseja realmente excluir este estado?');">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>

                <% }
                } else { %>
                    <tr>
                        <td colspan="4" class="text-center py-5 text-muted">
                            Nenhum estado cadastrado.
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
