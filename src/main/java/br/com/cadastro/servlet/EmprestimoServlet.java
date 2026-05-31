package br.com.cadastro.servlet;

import br.com.cadastro.dao.EmprestimoDAO;
import br.com.cadastro.dao.LivroDAO;
import br.com.cadastro.dao.UsuarioDAO;
import br.com.cadastro.model.Emprestimo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/emprestimos")
public class EmprestimoServlet extends HttpServlet {

    private final EmprestimoDAO emprestimoDAO = new EmprestimoDAO();
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    private final LivroDAO livroDAO = new LivroDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        carregarDadosTela(request);
        request.getRequestDispatcher("/emprestimos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            Emprestimo emprestimo = new Emprestimo();

            emprestimo.setUsuarioId(Integer.parseInt(request.getParameter("usuarioId")));
            emprestimo.setLivroId(Integer.parseInt(request.getParameter("livroId")));
            emprestimo.setDataDevolucaoPrevista(LocalDate.parse(request.getParameter("dataDevolucao")));
            emprestimo.setStatus("ATIVO");
            emprestimo.setRenovacoesRestantes(2);

            emprestimoDAO.cadastrar(emprestimo);
            request.getSession().setAttribute("mensagemSucesso", "Empréstimo registrado com sucesso!");

            response.sendRedirect(request.getContextPath() + "/emprestimos");
        } catch (Exception e) {
            request.setAttribute("mensagemErro", e.getMessage());
            carregarDadosTela(request);
            request.getRequestDispatcher("/emprestimos.jsp").forward(request, response);
        }
    }

    private void carregarDadosTela(HttpServletRequest request) {
        request.setAttribute("usuarios", usuarioDAO.listarTodos());
        request.setAttribute("livros", livroDAO.listarTodos());
        request.setAttribute("emprestimos", emprestimoDAO.listar());
    }
}
