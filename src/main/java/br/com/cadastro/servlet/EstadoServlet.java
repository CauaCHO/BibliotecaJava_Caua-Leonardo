package br.com.cadastro.servlet;

import br.com.cadastro.dao.EstadoDAO;
import br.com.cadastro.model.Estado;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = {
        "/estados",
        "/estados/novo",
        "/estados/salvar",
        "/estados/editar",
        "/estados/excluir"
})
public class EstadoServlet extends HttpServlet {

    private final EstadoDAO estadoDAO = new EstadoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String caminho = request.getServletPath();

        try {

            switch (caminho) {

                case "/estados/novo":
                    abrirFormulario(request, response, new Estado());
                    break;

                case "/estados/editar":
                    editar(request, response);
                    break;

                case "/estados/excluir":
                    excluir(request, response);
                    break;

                case "/estados":
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

        request.setAttribute("estados", estadoDAO.listarTodos());
        request.setAttribute("totalEstados", estadoDAO.contar());

        request.getRequestDispatcher("/lista-estados.jsp")
                .forward(request, response);
    }

    private void abrirFormulario(HttpServletRequest request,
                                 HttpServletResponse response,
                                 Estado estado)
            throws ServletException, IOException {

        request.setAttribute("estado", estado);

        request.getRequestDispatcher("/form-estado.jsp")
                .forward(request, response);
    }

    private void editar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Estado estado = estadoDAO.buscarPorId(id);

        if (estado == null) {
            request.getSession().setAttribute(
                    "mensagemErro",
                    "Estado não encontrado."
            );

            response.sendRedirect(request.getContextPath() + "/estados");
            return;
        }

        abrirFormulario(request, response, estado);
    }

    private void salvar(HttpServletRequest request,
                        HttpServletResponse response)
            throws IOException {

        Estado estado = new Estado();

        String id = request.getParameter("id");

        if (id != null && !id.isBlank()) {
            estado.setId(Integer.parseInt(id));
        }

        estado.setNomeEstado(request.getParameter("nomeEstado"));
        estado.setSiglaEstado(request.getParameter("siglaEstado"));

        validar(estado);

        estadoDAO.salvar(estado);

        request.getSession().setAttribute(
                "mensagemSucesso",
                estado.getId() == null
                        ? "Estado cadastrado com sucesso!"
                        : "Estado atualizado com sucesso!"
        );

        response.sendRedirect(request.getContextPath() + "/estados");
    }

    private void excluir(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        estadoDAO.excluir(id);

        request.getSession().setAttribute(
                "mensagemSucesso",
                "Estado excluído com sucesso!"
        );

        response.sendRedirect(request.getContextPath() + "/estados");
    }

    private void validar(Estado estado) {

        if (estado.getNomeEstado() == null
                || estado.getNomeEstado().isBlank()) {

            throw new IllegalArgumentException(
                    "O nome do estado é obrigatório."
            );
        }

        if (estado.getSiglaEstado() == null
                || estado.getSiglaEstado().isBlank()) {

            throw new IllegalArgumentException(
                    "A sigla do estado é obrigatória."
            );
        }

        if (estado.getSiglaEstado().length() != 2) {

            throw new IllegalArgumentException(
                    "A sigla deve possuir 2 caracteres."
            );
        }

        if (estadoDAO.siglaExiste(
                estado.getSiglaEstado(),
                estado.getId()
        )) {

            throw new IllegalArgumentException(
                    "Já existe um estado com esta sigla."
            );
        }
    }

    private void tratarErro(HttpServletRequest request,
                            HttpServletResponse response,
                            Exception e)
            throws ServletException, IOException {

        request.setAttribute("mensagemErro", e.getMessage());
        request.setAttribute("estados", estadoDAO.listarTodos());
        request.setAttribute("totalEstados", estadoDAO.contar());

        request.getRequestDispatcher("/lista-estados.jsp")
                .forward(request, response);
    }
}
