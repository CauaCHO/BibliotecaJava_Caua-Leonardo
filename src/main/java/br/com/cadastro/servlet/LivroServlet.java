package br.com.cadastro.servlet;

import br.com.cadastro.dao.LivroDAO;
import br.com.cadastro.model.Livro;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.regex.Pattern;

@WebServlet(urlPatterns = {
        "/livros",
        "/livros/novo",
        "/livros/salvar",
        "/livros/editar",
        "/livros/excluir"
})
public class LivroServlet extends HttpServlet {

    private final LivroDAO livroDAO = new LivroDAO();

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String caminho = request.getServletPath();

        try {

            switch (caminho) {

                case "/livros/novo":
                    abrirFormulario(request, response, new Livro());
                    break;

                case "/livros/editar":
                    editar(request, response);
                    break;

                case "/livros/excluir":
                    excluir(request, response);
                    break;

                case "/livros":
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

        String pesquisa = request.getParameter("pesquisa");

        if (pesquisa != null && !pesquisa.isBlank()) {

            request.setAttribute("livros", livroDAO.pesquisar(pesquisa));
            request.setAttribute("pesquisa", pesquisa);

        } else {

            request.setAttribute("livros", livroDAO.listarTodos());
        }

        request.setAttribute("totalLivros", livroDAO.contar());

        request.getRequestDispatcher("/lista-livros.jsp")
                .forward(request, response);
    }

    private void abrirFormulario(HttpServletRequest request,
                                 HttpServletResponse response,
                                 Livro livro)
            throws ServletException, IOException {

        request.setAttribute("livro", livro);

        request.getRequestDispatcher("/form-livro.jsp")
                .forward(request, response);
    }

    private void editar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Livro livro = livroDAO.buscarPorId(id);

        if (livro == null) {

            request.getSession().setAttribute(
                    "mensagemErro",
                    "Livro não encontrado."
            );

            response.sendRedirect(request.getContextPath() + "/livros");
            return;
        }

        abrirFormulario(request, response, livro);
    }

    private void salvar(HttpServletRequest request,
                        HttpServletResponse response)
            throws IOException {

        Livro livro = new Livro();

        String id = request.getParameter("id");

        if (id != null && !id.isBlank()) {
            livro.setId(Integer.parseInt(id));
        }

        livro.setNomeLivro(request.getParameter("nomeLivro"));
        livro.setIsbn(request.getParameter("isbn"));
        livro.setAutor(request.getParameter("autor"));
        livro.setEmail(request.getParameter("email"));

        livro.setDataPublicacao(
                LocalDate.parse(request.getParameter("dataPublicacao"))
        );

        livro.setValorLivro(
                new BigDecimal(
                        request.getParameter("valorLivro")
                                .replace(",", ".")
                )
        );

        validar(livro);

        livroDAO.salvar(livro);

        String mensagem = livro.getId() == null
                ? "Livro cadastrado com sucesso!"
                : "Livro atualizado com sucesso!";

        request.getSession().setAttribute(
                "mensagemSucesso",
                mensagem
        );

        response.sendRedirect(request.getContextPath() + "/livros");
    }

    private void excluir(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        livroDAO.excluir(id);

        request.getSession().setAttribute(
                "mensagemSucesso",
                "Livro excluído com sucesso!"
        );

        response.sendRedirect(request.getContextPath() + "/livros");
    }

    private void validar(Livro livro) {

        if (livro.getNomeLivro() == null
                || livro.getNomeLivro().isBlank()) {

            throw new IllegalArgumentException(
                    "O nome do livro é obrigatório."
            );
        }

        if (livro.getIsbn() == null
                || livro.getIsbn().isBlank()) {

            throw new IllegalArgumentException(
                    "O ISBN é obrigatório."
            );
        }

        if (livro.getAutor() == null
                || livro.getAutor().isBlank()) {

            throw new IllegalArgumentException(
                    "O autor é obrigatório."
            );
        }

        if (livro.getEmail() == null
                || livro.getEmail().isBlank()) {

            throw new IllegalArgumentException(
                    "O e-mail é obrigatório."
            );
        }

        if (!EMAIL_PATTERN.matcher(livro.getEmail()).matches()) {

            throw new IllegalArgumentException(
                    "Formato de e-mail inválido."
            );
        }

        if (livroDAO.emailExiste(
                livro.getEmail(),
                livro.getId()
        )) {

            throw new IllegalArgumentException(
                    "Este e-mail já está cadastrado."
            );
        }

        if (livro.getDataPublicacao() == null) {

            throw new IllegalArgumentException(
                    "A data de publicação é obrigatória."
            );
        }

        if (livro.getValorLivro() == null
                || livro.getValorLivro()
                .compareTo(BigDecimal.ZERO) < 0) {

            throw new IllegalArgumentException(
                    "O valor do livro deve ser maior ou igual a zero."
            );
        }
    }

    private void tratarErro(HttpServletRequest request,
                            HttpServletResponse response,
                            Exception e)
            throws ServletException, IOException {

        request.setAttribute("mensagemErro", e.getMessage());

        request.setAttribute(
                "livros",
                livroDAO.listarTodos()
        );

        request.setAttribute(
                "totalLivros",
                livroDAO.contar()
        );

        request.getRequestDispatcher("/lista-livros.jsp")
                .forward(request, response);
    }
}
