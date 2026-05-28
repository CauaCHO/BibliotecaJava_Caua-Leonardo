package br.com.cadastro.servlet;

import br.com.cadastro.dao.EmprestimoDAO;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/emprestimos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Emprestimo emprestimo = new Emprestimo();

        emprestimo.setUsuarioId(Integer.parseInt(request.getParameter("usuarioId")));
        emprestimo.setLivroId(Integer.parseInt(request.getParameter("livroId")));
        emprestimo.setDataDevolucaoPrevista(LocalDate.parse(request.getParameter("dataDevolucao")));
        emprestimo.setStatus("ATIVO");
        emprestimo.setRenovacoesRestantes(2);

        emprestimoDAO.cadastrar(emprestimo);

        response.sendRedirect(request.getContextPath() + "/emprestimos");
    }
}
