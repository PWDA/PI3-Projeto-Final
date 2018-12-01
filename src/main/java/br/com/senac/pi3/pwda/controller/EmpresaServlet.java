package br.com.senac.pi3.pwda.controller;

import br.com.senac.pi3.pwda.model.Empresa;
import br.com.senac.pi3.pwda.servico.ServicoEmpresa;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EmpresaServlet", urlPatterns = {"/EmpConsultar", "/EmpCadastrar", "/EmpDeletar"})
public class EmpresaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String pagina = request.getRequestURI();

        try {
            if (pagina.endsWith("EmpConsultar")) {
                empresaConsultar(request, response);
            } else if (pagina.endsWith("EmpCadastrar")) {
                empresaDigitar(request, response);
            } else if (pagina.endsWith("EmpDeletar")) {
                empresaInativar(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String pagina = request.getRequestURI();

        try {
            if (pagina.endsWith("EmpConsultar")) {
                empresaConsultar(request, response);
            } else if (pagina.endsWith("EmpCadastrar")) {
                empresaSalvar(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

    protected void empresaSalvar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {

        Empresa empresa = new Empresa();

        // id = 0 CASO FOR TENTADO CADASTRAR MAIS DE 1 VEZ NA MESMA PAGINA
        if (request.getParameter("id").equalsIgnoreCase("") || request.getParameter("id") == null) {
            empresa.setId(0);
        } else {
            empresa.setId(Integer.valueOf(request.getParameter("id")));
        }

        empresa.setEmpresa(request.getParameter("empresa"));
        empresa.setDiretor(request.getParameter("diretor"));
        empresa.setCnpj(request.getParameter("cnpj"));
        empresa.setEndereco(request.getParameter("endereco"));
        empresa.setCidade(request.getParameter("cidade"));
        empresa.setBairro(request.getParameter("bairro"));
        empresa.setCep(request.getParameter("cep"));
        empresa.setUf(request.getParameter("uf"));
        empresa.setEmail(request.getParameter("email"));
        empresa.setTelefone(request.getParameter("telefone"));
        try {

            boolean resposta = ServicoEmpresa.insertFunc(empresa);

            if (resposta == true) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("EmpConsultar");
                dispatcher.forward(request, response);
            }

        } catch (Exception ex) {
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/cadastrarEmp.jsp");
            request.setAttribute("erro", ex.getMessage());

            rd.forward(request, response);
        }
    }

    protected void empresaConsultar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        String busca = request.getParameter("buscar");
        String situacao = request.getParameter("situacao");

        if (busca == null && situacao == null) {
            busca = "";
            situacao = "Ativos";
        }
        List<Empresa> empresa = ServicoEmpresa.getList(busca, situacao);

        RequestDispatcher rd = request.getRequestDispatcher("./jsp/consultarEmp.jsp");
        request.setAttribute("buscar", busca);
        request.setAttribute("empresa", empresa);
        rd.forward(request, response);
    }

    protected void empresaDigitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        String req = request.getParameter("id");
        int id;

        if (req == null) {
            id = 0;
        } else {
            id = Integer.parseInt(req);
        }

        Empresa emp = ServicoEmpresa.getById(id);

        if (emp.getId() != id) {
            response.sendRedirect("EmpConsultar");
        } else {

            RequestDispatcher rd = request.getRequestDispatcher("./jsp/cadastrarEmp.jsp");
            request.setAttribute("emp", emp);
            rd.forward(request, response);
        }
    }

    protected void empresaInativar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));

        try {

            boolean resposta = ServicoEmpresa.deleteRegistro(id);

            if (resposta == true) {
                RequestDispatcher rd = request.getRequestDispatcher("EmpConsultar");
                rd.forward(request, response);
            }

        } catch (Exception ex) {
            request.setAttribute("erro", ex.getMessage());
            empresaConsultar(request, response);
        }
    }
}
