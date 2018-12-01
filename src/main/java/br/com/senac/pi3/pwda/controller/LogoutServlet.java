package br.com.senac.pi3.pwda.controller;

import br.com.senac.pi3.pwda.validador.Comuns;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sessao = request.getSession();

        sessao.invalidate();
        Comuns.setUsuarioLogado(null);

        response.sendRedirect(request.getContextPath() + "/Login?code=99");
    }

}
