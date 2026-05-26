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
<body class="dashboard-body">

<div class="dashboard-layout">

    <aside class="sidebar shadow-lg">
        <div>
            <div class="sidebar-brand">
                <h2>📚 Biblioteca</h2>
                <span>Java Web System</span>
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

                <a href="<%= request.getContextPath() %>/usuarios">
                    <i class="bi bi-people"></i>
                    Usuários
                </a>

                <a href="<%= request.getContextPath() %>/estados">
                    <i class="bi bi-globe-americas"></i>
                    Estados
                </a>
            </nav>
        </div>

        <button class="btn btn-outline-light w-100 mt-4" id="toggleDarkMode" type="button">
            <i class="bi bi-moon-stars"></i>
            Dark Mode
        </button>
    </aside>

    <main class="dashboard-content">

        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
            <div>
                <h1 class="fw-bold mb-1">Dashboard</h1>
                <p class="text-muted mb-0">Sistema de Gestão de Biblioteca em Java Web</p>
            </div>

            <div class="badge text-bg-primary fs-6 px-3 py-2 shadow-sm">
                Java + JSP + Servlet + PostgreSQL
            </div>
        </div>

        <div class="row g-4 mb-4">

            <div class="col-md-4">
                <a class="text-decoration-none" href="<%= request.getContextPath() %>/livros">
                    <div class="dashboard-card dashboard-blue">
                        <div>
                            <span class="dashboard-label">Livros</span>
                            <h2>CRUD</h2>
                            <small>Cadastro, alteração e exclusão</small>
                        </div>

                        <i class="bi bi-book-half dashboard-icon"></i>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a class="text-decoration-none" href="<%= request.getContextPath() %>/usuarios">
                    <div class="dashboard-card dashboard-green">
                        <div>
                            <span class="dashboard-label">Usuários</span>
                            <h2>Cadastro</h2>
                            <small>CPF/CNPJ, e-mail e validações</small>
                        </div>

                        <i class="bi bi-people-fill dashboard-icon"></i>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a class="text-decoration-none" href="<%= request.getContextPath() %>/estados">
                    <div class="dashboard-card dashboard-purple">
                        <div>
                            <span class="dashboard-label">Estados</span>
                            <h2>Gerenciamento</h2>
                            <small>Sigla única e validações</small>
                        </div>

                        <i class="bi bi-globe dashboard-icon"></i>
                    </div>
                </a>
            </div>
        </div>

        <section class="card border-0 shadow-sm rounded-4 p-4 mb-4">
            <h3 class="fw-bold mb-3">📌 Sobre o Projeto</h3>

            <p class="text-muted mb-0">
                Projeto desenvolvido seguindo o padrão Java Web tradicional com JSP, Servlets, DAO, JDBC e PostgreSQL.
                O sistema possui gerenciamento de livros, usuários e estados, além de validações frontend/backend,
                dashboard administrativa e estrutura MVC baseada nas aulas da disciplina.
            </p>
        </section>

        <section class="card border-0 shadow-sm rounded-4 p-4">
            <h3 class="fw-bold mb-3">✅ Recursos Implementados</h3>

            <div class="row g-3">
                <div class="col-md-3"><span class="badge text-bg-light w-100 p-3">JSP</span></div>
                <div class="col-md-3"><span class="badge text-bg-light w-100 p-3">Servlet</span></div>
                <div class="col-md-3"><span class="badge text-bg-light w-100 p-3">DAO</span></div>
                <div class="col-md-3"><span class="badge text-bg-light w-100 p-3">PostgreSQL</span></div>
            </div>
        </section>
    </main>
</div>

<script>
    const toggle = document.getElementById('toggleDarkMode');
    toggle.addEventListener('click', () => {
        document.body.classList.toggle('dark-mode');
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
