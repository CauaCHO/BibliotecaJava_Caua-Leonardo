package br.com.cadastro.servlet;

import br.com.cadastro.dao.LivroDAO;
import br.com.cadastro.model.Livro;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/livros")
public class LivroServlet extends HttpServlet {
    private final LivroDAO livroDAO = new LivroDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        if (acao == null) acao = "listar";

        try {
            switch (acao) {
                case "novo":
                    request.getRequestDispatcher("livro-form.jsp").forward(request, response);
                    break;
                case "editar":
                    editar(request, response);
                    break;
                case "excluir":
                    excluir(request, response);
                    break;
                default:
                    listar(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("erro", e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");

        try {
            if ("atualizar".equals(acao)) {
                atualizar(request, response);
            } else {
                inserir(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("erro", e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Livro> livros = livroDAO.listar();
        request.setAttribute("livros", livros);
        request.getRequestDispatcher("livro-lista.jsp").forward(request, response);
    }

    private void inserir(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Livro livro = montarLivro(request);
        livroDAO.inserir(livro);
        response.sendRedirect("livros");
    }

    private void editar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("id");
        Livro livro = livroDAO.buscarPorId(id);
        request.setAttribute("livro", livro);
        request.getRequestDispatcher("livro-form.jsp").forward(request, response);
    }

    private void atualizar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Livro livro = montarLivro(request);
        livro.setId(request.getParameter("id"));
        livroDAO.atualizar(livro);
        response.sendRedirect("livros");
    }

    private void excluir(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("id");
        livroDAO.excluir(id);
        response.sendRedirect("livros");
    }

    private Livro montarLivro(HttpServletRequest request) {
        Livro livro = new Livro();
        livro.setNomeLivro(request.getParameter("nomeLivro"));
        livro.setIsbn(request.getParameter("isbn"));
        livro.setAutor(request.getParameter("autor"));
        livro.setDataPublicacao(request.getParameter("dataPublicacao"));

        String valor = request.getParameter("valorLivro");
        livro.setValorLivro(valor == null || valor.isBlank() ? BigDecimal.ZERO : new BigDecimal(valor));
        return livro;
    }
}
