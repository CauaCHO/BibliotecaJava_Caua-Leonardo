<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empréstimos - CL Book's</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/premium.css" rel="stylesheet">
</head>
<body>

<div class="container py-5">

    <div class="hero-card p-5 mb-4">
        <h1 class="fw-bold mb-3">Sistema de Empréstimos</h1>
        <p class="text-muted">Gerencie empréstimos da plataforma premium.</p>
    </div>

    <div class="card table-card p-4">
        <form method="post" action="<%= request.getContextPath() %>/emprestimos">

            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label">ID Usuário</label>
                    <input type="number" name="usuarioId" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">ID Livro</label>
                    <input type="number" name="livroId" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Data devolução</label>
                    <input type="date" name="dataDevolucao" class="form-control" required>
                </div>
            </div>

            <button type="submit" class="btn btn-primary mt-4 px-4">
                Registrar Empréstimo
            </button>
        </form>
    </div>
</div>

</body>
</html>
