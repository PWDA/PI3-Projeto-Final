package br.com.senac.pi3.pwda.controller;

import br.com.senac.pi3.pwda.dao.DaoRelatorio;
import br.com.senac.pi3.pwda.model.Login;
import br.com.senac.pi3.pwda.model.Relatorio;
import br.com.senac.pi3.pwda.validador.Comuns;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RelatorioServlet", urlPatterns = {"/Relatorio-Global", "/Relatorio-Regional", "/Relatorio-Produto", "/Relatorio-Cliente"})
public class RelatorioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String pagina = request.getRequestURI();

        try {
            if (pagina.endsWith("Relatorio-Global")) {
                relatorioGlobal(request, response);
            } else if (pagina.endsWith("Relatorio-Regional")) {
                relatorioRegional(request, response);
            } else if (pagina.endsWith("Relatorio-Produto")) {
                relatorioProduto(request, response);
            } else if (pagina.endsWith("Relatorio-Cliente")) {
                relatorioCliente(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String pagina = request.getRequestURI();

        try {
            if (pagina.endsWith("Relatorio-Global")) {
                relatorioGlobal(request, response);
            } else if (pagina.endsWith("Relatorio-Regional")) {
                relatorioRegional(request, response);
            } else if (pagina.endsWith("Relatorio-Produto")) {
                relatorioProduto(request, response);
            } else if (pagina.endsWith("Relatorio-Cliente")) {
                relatorioCliente(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

    protected void relatorioGlobal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        DateFormat nova = new SimpleDateFormat("yyyy-MM-dd");
        String inicio = request.getParameter("dt_inicial");
        String fim = request.getParameter("dt_final");
        String busca = request.getParameter("buscar");
        String filial = request.getParameter("filial");
        Date date = new Date();

        if (inicio == null) {
            inicio = nova.format(date);
        }

        if (fim == null) {
            fim = nova.format(date);
        }

        if (busca == null) {
            busca = "";
        }
        if (filial == null) {
            filial = "PWDA-SÃO PAULO";
        }

        List<Relatorio> rel = DaoRelatorio.relatorioGlobal(inicio, fim, busca, filial);

        RequestDispatcher rd = request.getRequestDispatcher("/jsp/relatorio-global.jsp");
        request.setAttribute("buscar", busca);
        request.setAttribute("dt_inicial", inicio);
        request.setAttribute("dt_final", fim);
        request.setAttribute("relatorio", rel);
        rd.forward(request, response);
    }

    protected void relatorioRegional(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        DateFormat nova = new SimpleDateFormat("yyyy-MM-dd");
        String inicio = request.getParameter("dt_inicial");
        String fim = request.getParameter("dt_final");
        String busca = request.getParameter("buscar");
        String filial = request.getParameter("filial");
        Login usuario = Comuns.getUsuarioLogado();

        Date date = new Date();

        if (inicio == null) {
            inicio = nova.format(date);
        }

        if (fim == null) {
            fim = nova.format(date);
        }

        if (busca == null) {
            busca = "";
        }
        if (usuario.getAutorizar() == 1) {
            filial = usuario.getEmpresa();
        } else {
            filial = "PWDA-SÃO PAULO";
        }
        List<Relatorio> rel = DaoRelatorio.relatorioRegional(inicio, fim, filial);

        RequestDispatcher rd = request.getRequestDispatcher("/jsp/relatorio-regional.jsp");
        request.setAttribute("buscar", busca);
        request.setAttribute("dt_inicial", inicio);
        request.setAttribute("dt_final", fim);
        request.setAttribute("relatorio", rel);
        rd.forward(request, response);
    }

    protected void relatorioProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        DateFormat nova = new SimpleDateFormat("yyyy-MM-dd");
        String inicio = request.getParameter("dt_inicial");
        String fim = request.getParameter("dt_final");
        String busca = request.getParameter("buscar");
        String filial = request.getParameter("filial");
        Login usuario = Comuns.getUsuarioLogado();

        Date date = new Date();

        if (inicio == null) {
            inicio = nova.format(date);
        }

        if (fim == null) {
            fim = nova.format(date);
        }

        if (busca == null) {
            busca = "";
        }
        if (usuario.getAutorizar() == 1) {
            filial = usuario.getEmpresa();
        } else {
            filial = "PWDA-SÃO PAULO";
        }
        List<Relatorio> rel = DaoRelatorio.relatorioProduto(inicio, fim, filial);

        RequestDispatcher rd = request.getRequestDispatcher("/jsp/relatorio-produto.jsp");
        request.setAttribute("buscar", busca);
        request.setAttribute("dt_inicial", inicio);
        request.setAttribute("dt_final", fim);
        request.setAttribute("relatorio", rel);

        rd.forward(request, response);
    }

    protected void relatorioCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        DateFormat nova = new SimpleDateFormat("yyyy-MM-dd");
        String inicio = request.getParameter("dt_inicial");
        String fim = request.getParameter("dt_final");
        String busca = request.getParameter("buscar");
        String filial = request.getParameter("filial");
        Login usuario = Comuns.getUsuarioLogado();

        Date date = new Date();

        if (inicio == null) {
            inicio = nova.format(date);
        }

        if (fim == null) {
            fim = nova.format(date);
        }

        if (busca == null) {
            busca = "";
        }
        if (usuario.getAutorizar() == 1) {
            filial = usuario.getEmpresa();
        } else {
            filial = "PWDA-SÃO PAULO";
        }
        List<Relatorio> rel = DaoRelatorio.relatorioCliente(inicio, fim, filial);

        RequestDispatcher rd = request.getRequestDispatcher("/jsp/relatorio-cliente.jsp");
        request.setAttribute("buscar", busca);
        request.setAttribute("dt_inicial", inicio);
        request.setAttribute("dt_final", fim);
        request.setAttribute("relatorio", rel);
        rd.forward(request, response);
    }
}
