package br.com.cadastro.servlet;

import br.com.cadastro.dao.UsuarioDAO;
import br.com.cadastro.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet(urlPatterns = {
        "/usuarios",
        "/usuarios/novo",
        "/usuarios/salvar",
        "/usuarios/editar",
        "/usuarios/excluir"
})
public class UsuarioServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String caminho = request.getServletPath();

        try {
            switch (caminho) {

                case "/usuarios/novo":
                    abrirFormulario(request, response, new Usuario());
                    break;

                case "/usuarios/editar":
                    editar(request, response);
                    break;

                case "/usuarios/excluir":
                    excluir(request, response);
                    break;

                case "/usuarios":
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

        request.setAttribute("usuarios", usuarioDAO.listarTodos());

        request.getRequestDispatcher("/lista-usuarios.jsp")
                .forward(request, response);
    }

    private void abrirFormulario(HttpServletRequest request,
                                 HttpServletResponse response,
                                 Usuario usuario)
            throws ServletException, IOException {

        request.setAttribute("usuario", usuario);

        request.getRequestDispatcher("/form-usuario.jsp")
                .forward(request, response);
    }

    private void editar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Usuario usuario = usuarioDAO.buscarPorId(id);

        if (usuario == null) {
            throw new IllegalArgumentException("Usuário não encontrado.");
        }

        abrirFormulario(request, response, usuario);
    }

    private void salvar(HttpServletRequest request,
                        HttpServletResponse response)
            throws IOException {

        Usuario usuario = new Usuario();

        String id = request.getParameter("id");

        if (id != null && !id.isBlank()) {
            usuario.setId(Integer.parseInt(id));
        }

        usuario.setNomeUsuario(request.getParameter("nomeUsuario"));
        usuario.setCpfCnpj(request.getParameter("cpfCnpj"));
        usuario.setEmail(request.getParameter("email"));

        validar(usuario);

        usuarioDAO.salvar(usuario);

        request.getSession().setAttribute(
                "mensagemSucesso",
                usuario.getId() == null
                        ? "Usuário cadastrado com sucesso!"
                        : "Usuário atualizado com sucesso!"
        );

        response.sendRedirect(request.getContextPath() + "/usuarios");
    }

    private void excluir(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        usuarioDAO.excluir(id);

        request.getSession().setAttribute(
                "mensagemSucesso",
                "Usuário excluído com sucesso!"
        );

        response.sendRedirect(request.getContextPath() + "/usuarios");
    }

    private void validar(Usuario usuario) {

        if (usuario.getNomeUsuario() == null || usuario.getNomeUsuario().isBlank()) {
            throw new IllegalArgumentException("O nome do usuário é obrigatório.");
        }

        if (usuario.getCpfCnpj() == null || usuario.getCpfCnpj().isBlank()) {
            throw new IllegalArgumentException("O CPF/CNPJ é obrigatório.");
        }

        if (usuarioDAO.cpfExiste(usuario.getCpfCnpj(), usuario.getId())) {
            throw new IllegalArgumentException("Já existe um usuário com este CPF/CNPJ.");
        }

        if (usuario.getEmail() == null || usuario.getEmail().isBlank()) {
            throw new IllegalArgumentException("O e-mail é obrigatório.");
        }

        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

        if (!Pattern.matches(regex, usuario.getEmail())) {
            throw new IllegalArgumentException("Formato de e-mail inválido.");
        }

        if (usuarioDAO.emailExiste(usuario.getEmail(), usuario.getId())) {
            throw new IllegalArgumentException("Já existe um usuário com este e-mail.");
        }
    }

    private void tratarErro(HttpServletRequest request,
                            HttpServletResponse response,
                            Exception e)
            throws ServletException, IOException {

        request.setAttribute("mensagemErro", e.getMessage());
        request.setAttribute("usuarios", usuarioDAO.listarTodos());

        request.getRequestDispatcher("/lista-usuarios.jsp")
                .forward(request, response);
    }
}
