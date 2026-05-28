package br.com.cadastro.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if ("admin@biblioteca.com".equals(email) && "admin".equals(senha)) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", email);

            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        request.setAttribute("erro", "E-mail ou senha inválidos.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
