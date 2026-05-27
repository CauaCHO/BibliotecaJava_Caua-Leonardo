package br.com.cadastro.api;

import br.com.cadastro.dao.LivroDAO;
import br.com.cadastro.model.Livro;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/livros")
public class ApiLivroServlet extends HttpServlet {

    private final LivroDAO livroDAO = new LivroDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        List<Livro> livros = livroDAO.listarTodos();
        StringBuilder json = new StringBuilder();
        json.append("[");

        for (int i = 0; i < livros.size(); i++) {
            Livro livro = livros.get(i);

            if (i > 0) {
                json.append(",");
            }

            json.append("{");
            json.append("\"id\":").append(livro.getId()).append(",");
            json.append("\"nomeLivro\":\"").append(limpar(livro.getNomeLivro())).append("\",");
            json.append("\"autor\":\"").append(limpar(livro.getAutor())).append("\",");
            json.append("\"isbn\":\"").append(limpar(livro.getIsbn())).append("\",");
            json.append("\"capaLivro\":\"").append(limpar(livro.getCapaLivro())).append("\",");
            json.append("\"valorLivro\":\"").append(livro.getValorLivro()).append("\",");
            json.append("\"nomeCategoria\":\"").append(limpar(livro.getNomeCategoria())).append("\"");
            json.append("}");
        }

        json.append("]");
        response.getWriter().write(json.toString());
    }

    private String limpar(String valor) {
        if (valor == null) {
            return "";
        }
        return valor.replace("\"", "'");
    }
}
