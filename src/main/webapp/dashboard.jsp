<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%
    Map<String, Integer> metricas = (Map<String, Integer>) request.getAttribute("metricas");
    int livros = metricas != null && metricas.get("livros") != null ? metricas.get("livros") : 0;
    int usuarios = metricas != null && metricas.get("usuarios") != null ? metricas.get("usuarios") : 0;
    int emprestimos = metricas != null && metricas.get("emprestimosAtivos") != null ? metricas.get("emprestimosAtivos") : 0;
    int avaliacoes = metricas != null && metricas.get("avaliacoes") != null ? metricas.get("avaliacoes") : 0;
%>
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

<jsp:include page="/includes/navbar.jsp" />

<main class="container-fluid px-4 px-lg-5 py-5">
    <section class="hero-card p-5 mb-5 dashboard-hero">
        <div class="row align-items-center g-5">
            <div class="col-lg-7">
                <span class="badge badge-soft mb-3">Dashboard cinematográfico</span>
                <h1 class="display-3 fw-bold mb-3">Controle sua biblioteca com dados vivos.</h1>
                <p class="text-muted fs-5 mb-4">Métricas, cadastros, empréstimos e indicadores em um visual premium unificado.</p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="<%= request.getContextPath() %>/livros" class="btn btn-primary btn-lg px-4 btn-rounded">Catálogo</a>
                    <a href="<%= request.getContextPath() %>/usuarios" class="btn btn-outline-light btn-lg px-4 btn-rounded">Pessoas</a>
                    <a href="<%= request.getContextPath() %>/emprestimos" class="btn btn-outline-light btn-lg px-4 btn-rounded">Empréstimos</a>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="chart-glow-card">
                    <canvas id="overviewChart" height="240"></canvas>
                </div>
            </div>
        </div>
    </section>

    <div class="row g-4 mb-5">
        <div class="col-md-3"><div class="dashboard-card dashboard-blue"><div><span class="dashboard-label">Livros ativos</span><h2><%= livros %></h2><small>Obras no acervo</small></div><i class="bi bi-book dashboard-icon"></i></div></div>
        <div class="col-md-3"><div class="dashboard-card dashboard-green"><div><span class="dashboard-label">Pessoas</span><h2><%= usuarios %></h2><small>Leitores e equipe</small></div><i class="bi bi-people dashboard-icon"></i></div></div>
        <div class="col-md-3"><div class="dashboard-card dashboard-purple"><div><span class="dashboard-label">Empréstimos</span><h2><%= emprestimos %></h2><small>Ativos no momento</small></div><i class="bi bi-arrow-repeat dashboard-icon"></i></div></div>
        <div class="col-md-3"><div class="dashboard-card dashboard-orange"><div><span class="dashboard-label">Avaliações</span><h2><%= avaliacoes %></h2><small>Feedbacks registrados</small></div><i class="bi bi-star dashboard-icon"></i></div></div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <section class="table-card p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">Movimento do acervo</h3>
                        <p class="text-muted mb-0">Simulação visual para apresentação do fluxo mensal.</p>
                    </div>
                    <span class="badge text-bg-primary px-3 py-2">Chart.js</span>
                </div>
                <canvas id="movementChart" height="130"></canvas>
            </section>
        </div>
        <div class="col-lg-4">
            <section class="table-card p-4 h-100">
                <h3 class="fw-bold mb-1">Distribuição</h3>
                <p class="text-muted mb-4">Visão comparativa dos módulos principais.</p>
                <canvas id="distributionChart" height="230"></canvas>
            </section>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const metricas = [<%= livros %>, <%= usuarios %>, <%= emprestimos %>, <%= avaliacoes %>];
    const labels = ['Livros', 'Pessoas', 'Empréstimos', 'Avaliações'];
    const neon = ['#F59E0B', '#3B82F6', '#8B5CF6', '#22C55E'];

    new Chart(document.getElementById('overviewChart'), {
        type: 'doughnut',
        data: { labels, datasets: [{ data: metricas, backgroundColor: neon, borderColor: '#0B1120', borderWidth: 4 }] },
        options: { plugins: { legend: { labels: { color: '#E5E7EB' } } }, cutout: '65%' }
    });

    new Chart(document.getElementById('movementChart'), {
        type: 'line',
        data: {
            labels: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun'],
            datasets: [
                { label: 'Empréstimos', data: [12, 19, 28, 35, 42, Math.max(emprestimos, 16)], borderColor: '#F59E0B', backgroundColor: 'rgba(245,158,11,.18)', tension: .45, fill: true },
                { label: 'Avaliações', data: [3, 7, 12, 16, 22, Math.max(avaliacoes, 8)], borderColor: '#8B5CF6', backgroundColor: 'rgba(139,92,246,.16)', tension: .45, fill: true }
            ]
        },
        options: { plugins: { legend: { labels: { color: '#E5E7EB' } } }, scales: { x: { ticks: { color: '#94A3B8' }, grid: { color: 'rgba(255,255,255,.06)' } }, y: { ticks: { color: '#94A3B8' }, grid: { color: 'rgba(255,255,255,.06)' } } } }
    });

    new Chart(document.getElementById('distributionChart'), {
        type: 'bar',
        data: { labels, datasets: [{ label: 'Total', data: metricas, backgroundColor: neon, borderRadius: 14 }] },
        options: { plugins: { legend: { display: false } }, scales: { x: { ticks: { color: '#94A3B8' }, grid: { display: false } }, y: { ticks: { color: '#94A3B8' }, grid: { color: 'rgba(255,255,255,.06)' } } } }
    });
</script>
</body>
</html>
