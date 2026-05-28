<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Premium - CL Book's</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body class="dashboard-body">

<div class="dashboard-layout">

    <aside class="sidebar shadow-lg">
        <div>
            <div class="sidebar-brand">
                <h2>📚 CL Book's</h2>
                <span>Premium Java Platform</span>
            </div>

            <nav class="sidebar-nav mt-4">
                <a href="<%= request.getContextPath() %>/dashboard.jsp" class="active">
                    <i class="bi bi-speedometer2"></i>
                    Dashboard
                </a>

                <a href="<%= request.getContextPath() %>/livros">
                    <i class="bi bi-book"></i>
                    Livros
                </a>
            </nav>
        </div>
    </aside>

    <main class="dashboard-content">
        <section class="hero-card p-5 mb-4">
            <h1 class="display-4 fw-bold mb-3">
                Plataforma literária premium.
            </h1>

            <p class="text-muted fs-5 mb-4">
                Sistema Java Web modernizado com visual cinematográfico.
            </p>

            <a href="<%= request.getContextPath() %>/livros" class="btn btn-primary btn-lg px-4">
                Explorar catálogo
            </a>
        </section>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
