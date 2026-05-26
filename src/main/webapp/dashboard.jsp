<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Biblioteca Java</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
    <div class="container py-2 d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/livros">
            📚 Biblioteca Java
        </a>

        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-light btn-rounded" href="<%= request.getContextPath() %>/livros">Livros</a>
            <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/estados">Estados</a>
        </div>
    </div>
</nav>

<main class="container py-4">

    <section class="card hero-card mb-4">
        <div class="card-body p-5 text-center">
            <span class="badge badge-soft mb-3">Sistema de Gestão de Biblioteca</span>
            <h1 class="display-5 fw-bold mb-3">Dashboard Principal</h1>
            <p class="text-muted mb-4">
                Gerencie livros, estados e informações do sistema em um único ambiente.
            </p>

            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="<%= request.getContextPath() %>/livros"
                   class="btn btn-primary btn-lg btn-rounded px-4">
                    <i class="bi bi-book"></i>
                    Gerenciar Livros
                </a>

                <a href="<%= request.getContextPath() %>/estados"
                   class="btn btn-outline-primary btn-lg btn-rounded px-4">
                    <i class="bi bi-globe-americas"></i>
                    Gerenciar Estados
                </a>
            </div>
        </div>
    </section>

    <div class="row g-4">

        <div class="col-12 col-md-4">
            <div class="metric-card h-100">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Tecnologia</p>
                        <h2 class="metric-value mb-0">Java Web</h2>
                    </div>

                    <div class="book-cover">
                        <i class="bi bi-code-square"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-4">
            <div class="metric-card h-100">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Banco de Dados</p>
                        <h2 class="metric-value mb-0">PostgreSQL</h2>
                    </div>

                    <div class="book-cover">
                        <i class="bi bi-database"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-4">
            <div class="metric-card h-100">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Arquitetura</p>
                        <h2 class="metric-value mb-0">MVC + DAO</h2>
                    </div>

                    <div class="book-cover">
                        <i class="bi bi-diagram-3"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
