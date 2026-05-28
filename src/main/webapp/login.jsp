<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CL Book's</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body class="dashboard-body d-flex align-items-center justify-content-center">

<div class="hero-card p-5" style="width:100%;max-width:480px;">
    <div class="text-center mb-4">
        <h1 class="fw-bold">📚 CL Book's</h1>
        <p class="text-muted">Acesse a plataforma premium.</p>
    </div>

    <% if(request.getAttribute("erro") != null) { %>
        <div class="alert alert-danger">
            <%= request.getAttribute("erro") %>
        </div>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/login">
        <div class="mb-3">
            <label class="form-label">E-mail</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-4">
            <label class="form-label">Senha</label>
            <input type="password" name="senha" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-3">
            Entrar
        </button>
    </form>

    <div class="text-center mt-4 text-muted small">
        admin@biblioteca.com / admin
    </div>
</div>

</body>
</html>
