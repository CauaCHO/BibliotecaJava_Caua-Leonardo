<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="alert alert-danger shadow-sm">
        <h1 class="h4">Ocorreu um erro</h1>
        <p>${erro}</p>
        <a href="livros" class="btn btn-danger">Voltar</a>
    </div>
</div>
</body>
</html>
