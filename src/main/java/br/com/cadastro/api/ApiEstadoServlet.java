package br.com.cadastro.api;

import br.com.cadastro.dao.EstadoDAO;
import br.com.cadastro.model.Estado;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/estados")
public class ApiEstadoServlet extends HttpServlet {

    private final EstadoDAO estadoDAO = new EstadoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        List<Estado> estados = estadoDAO.listarTodos();
        StringBuilder json = new StringBuilder("[");

        for (int i = 0; i < estados.size(); i++) {
            Estado estado = estados.get(i);

            if (i > 0) {
                json.append(",");
            }

            json.append("{");
            json.append("\"id\":").append(estado.getId()).append(",");
            json.append("\"nomeEstado\":\"").append(limpar(estado.getNomeEstado())).append("\",");
            json.append("\"siglaEstado\":\"").append(limpar(estado.getSiglaEstado())).append("\"");
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
