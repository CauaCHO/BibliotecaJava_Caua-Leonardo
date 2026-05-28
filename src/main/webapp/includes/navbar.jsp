<nav class="navbar navbar-expand-lg app-navbar premium-navbar">
    <div class="container-fluid px-4 px-lg-5 py-2">
        <a class="navbar-brand premium-brand" href="<%= request.getContextPath() %>/dashboard">
            <span>CL</span> Book's
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav mx-auto gap-lg-2">
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/livros">Livros</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/categorias">Categorias</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/usuarios">Pessoas</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/estados">Estados</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/emprestimos">Empréstimos</a></li>
            </ul>

            <div class="d-flex gap-2 align-items-center mt-3 mt-lg-0 flex-wrap">
                <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/categorias/novo">Nova Categoria</a>
                <a class="btn btn-sm btn-outline-light btn-rounded" href="<%= request.getContextPath() %>/usuarios/novo">Nova Pessoa</a>
                <a class="btn btn-sm btn-primary btn-rounded" href="<%= request.getContextPath() %>/livros/novo">Novo Livro</a>
            </div>
        </div>
    </div>
</nav>
