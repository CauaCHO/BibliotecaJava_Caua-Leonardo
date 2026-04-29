<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty livro ? 'Novo Livro' : 'Editar Livro'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="livros">📚 Biblioteca Web</a>
    </div>
</nav>

<main class="container py-4">
    <div class="form-wrapper mx-auto">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
                <h1 class="h3 fw-bold mb-1">${empty livro ? 'Cadastrar Livro' : 'Editar Livro'}</h1>
                <p class="text-muted mb-4">Preencha as informações abaixo.</p>

                <form method="post" action="livros">
                    <input type="hidden" name="acao" value="${empty livro ? 'inserir' : 'atualizar'}">
                    <c:if test="${not empty livro}">
                        <input type="hidden" name="id" value="${livro.id}">
                    </c:if>

                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">Nome do Livro</label>
                            <input class="form-control form-control-lg" type="text" name="nomeLivro" value="${livro.nomeLivro}" required maxlength="150">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">ISBN</label>
                            <input class="form-control form-control-lg" type="text" name="isbn" value="${livro.isbn}" required maxlength="50">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Autor</label>
                            <input class="form-control form-control-lg" type="text" name="autor" value="${livro.autor}" required maxlength="100">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Data de Publicação</label>
                            <input class="form-control form-control-lg" type="date" name="dataPublicacao" value="${livro.dataPublicacao}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Valor do Livro</label>
                            <input class="form-control form-control-lg" type="number" name="valorLivro" value="${livro.valorLivro}" step="0.01" min="0" required>
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-4 flex-column flex-sm-row">
                        <button class="btn btn-primary btn-lg" type="submit">Salvar</button>
                        <a class="btn btn-outline-secondary btn-lg" href="livros">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>
</body>
</html>
