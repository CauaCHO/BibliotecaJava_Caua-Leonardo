package br.com.cadastro.api;

import br.com.cadastro.dao.CategoriaDAO;
import br.com.cadastro.model.Categoria;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/categorias")
public class ApiCategoriaServlet extends HttpServlet {

    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        try {
            List<Categoria> categorias = categoriaDAO.listarTodos();
            StringBuilder json = new StringBuilder("[");

            for (int i = 0; i < categorias.size(); i++) {
                Categoria categoria = categorias.get(i);

                if (i > 0) {
                    json.append(",");
                }

                json.append("{")
                        .append("\"id\":").append(categoria.getId()).append(",")
                        .append("\"nomeCategoria\":\"").append(escapar(categoria.getNomeCategoria())).append("\",")
                        .append("\"descricao\":\"").append(escapar(categoria.getDescricao())).append("\"")
                        .append("}");
            }

            json.append("]");
            response.getWriter().write(json.toString());

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"erro\":\"" + escapar(e.getMessage()) + "\"}");
        }
    }

    private String escapar(String texto) {
        if (texto == null) {
            return "";
        }
        return texto.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
