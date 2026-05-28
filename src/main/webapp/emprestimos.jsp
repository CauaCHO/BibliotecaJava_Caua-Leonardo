<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                <h1 class="display-4 fw-bold mb-3">Registre empréstimos com uma experiência premium.</h1>
                <p class="text-muted fs-5 mb-4">Controle a saída de livros, leitores responsáveis e previsão de devolução.</p>

                <div class="d-flex gap-3 flex-wrap">
                    <a href="<%= request.getContextPath() %>/livros" class="btn btn-outline-light btn-lg btn-rounded px-4">Ver Catálogo</a>
                    <a href="<%= request.getContextPath() %>/usuarios" class="btn btn-outline-light btn-lg btn-rounded px-4">Ver Pessoas</a>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="chart-glow-card p-5 text-center">
                    <i class="bi bi-arrow-left-right" style="font-size:5rem;color:#8B5CF6"></i>
                    <h3 class="fw-bold mt-4 mb-2">Fluxo inteligente</h3>
                    <p class="text-muted mb-0">Base pronta para histórico, multas e devoluções.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="table-card p-4 p-lg-5">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
            <div>
                <h2 class="fw-bold mb-1">Novo empréstimo</h2>
                <p class="text-muted mb-0">Informe os IDs do usuário e do livro para registrar a movimentação.</p>
            </div>
            <span class="badge text-bg-primary px-3 py-2">Operação ativa</span>
        </div>

        <form method="post" action="<%= request.getContextPath() %>/emprestimos" class="row g-4">
            <div class="col-md-4">
                <label class="form-label">ID da Pessoa</label>
                <input type="number" name="usuarioId" class="form-control" placeholder="Ex: 1" required>
            </div>

            <div class="col-md-4">
                <label class="form-label">ID do Livro</label>
                <input type="number" name="livroId" class="form-control" placeholder="Ex: 2" required>
            </div>

            <div class="col-md-4">
                <label class="form-label">Data prevista de devolução</label>
                <input type="date" name="dataDevolucao" class="form-control" required>
            </div>

            <div class="col-12 d-flex justify-content-end gap-3 mt-4">
                <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-outline-light btn-rounded px-4">Cancelar</a>
                <button type="submit" class="btn btn-primary btn-rounded px-5">
                    Registrar Empréstimo
                </button>
            </div>
        </form>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
