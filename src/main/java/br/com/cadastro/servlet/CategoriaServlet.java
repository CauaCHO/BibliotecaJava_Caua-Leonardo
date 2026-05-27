package br.com.cadastro.servlet;

import br.com.cadastro.dao.CategoriaDAO;
import br.com.cadastro.model.Categoria;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = {
        "/categorias",
        "/categorias/novo",
        "/categorias/salvar",
        "/categorias/editar",
        "/categorias/excluir"
})
public class CategoriaServlet extends HttpServlet {

    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String caminho = request.getServletPath();

        try {
            switch (caminho) {
                case "/categorias/novo":
                    abrirFormulario(request, response, new Categoria());
                    break;
                case "/categorias/editar":
                    editar(request, response);
                    break;
                case "/categorias/excluir":
                    excluir(request, response);
                    break;
                case "/categorias":
                default:
                    listar(request, response);
                    break;
            }
        } catch (Exception e) {
            tratarErro(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            salvar(request, response);
        } catch (Exception e) {
            tratarErro(request, response, e);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("categorias", categoriaDAO.listarTodos());
        request.setAttribute("totalCategorias", categoriaDAO.contar());
        request.getRequestDispatcher("/lista-categorias.jsp").forward(request, response);
    }

    private void abrirFormulario(HttpServletRequest request, HttpServletResponse response, Categoria categoria)
            throws ServletException, IOException {

        request.setAttribute("categoria", categoria);
        request.getRequestDispatcher("/form-categoria.jsp").forward(request, response);
    }

    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Categoria categoria = categoriaDAO.buscarPorId(id);

        if (categoria == null) {
            throw new IllegalArgumentException("Categoria não encontrada.");
        }

        abrirFormulario(request, response, categoria);
    }

    private void salvar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Categoria categoria = new Categoria();

        String id = request.getParameter("id");
        if (id != null && !id.isBlank()) {
            categoria.setId(Integer.parseInt(id));
        }

        categoria.setNomeCategoria(request.getParameter("nomeCategoria"));
        categoria.setDescricao(request.getParameter("descricao"));

        validar(categoria);
        categoriaDAO.salvar(categoria);

        request.getSession().setAttribute(
                "mensagemSucesso",
                categoria.getId() == null
                        ? "Categoria cadastrada com sucesso!"
                        : "Categoria atualizada com sucesso!"
        );

        response.sendRedirect(request.getContextPath() + "/categorias");
    }

    private void excluir(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        categoriaDAO.excluir(id);

        request.getSession().setAttribute("mensagemSucesso", "Categoria excluída com sucesso!");
        response.sendRedirect(request.getContextPath() + "/categorias");
    }

    private void validar(Categoria categoria) {
        if (categoria.getNomeCategoria() == null || categoria.getNomeCategoria().isBlank()) {
            throw new IllegalArgumentException("O nome da categoria é obrigatório.");
        }

        if (categoriaDAO.nomeExiste(categoria.getNomeCategoria(), categoria.getId())) {
            throw new IllegalArgumentException("Já existe uma categoria com este nome.");
        }
    }

    private void tratarErro(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws ServletException, IOException {

        request.setAttribute("mensagemErro", e.getMessage());
        request.setAttribute("categorias", categoriaDAO.listarTodos());
        request.setAttribute("totalCategorias", categoriaDAO.contar());
        request.getRequestDispatcher("/lista-categorias.jsp").forward(request, response);
    }
}
