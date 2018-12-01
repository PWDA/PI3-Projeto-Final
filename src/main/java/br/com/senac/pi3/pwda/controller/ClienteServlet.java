package br.com.senac.pi3.pwda.controller;

import br.com.senac.pi3.pwda.model.Pessoa;
import br.com.senac.pi3.pwda.servico.ServicoCliente;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/CliConsultar", "/CliCadastrar", "/CliDeletar"})
public class ClienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String pagina = request.getRequestURI();

        try {
            if (pagina.endsWith("CliConsultar")) {
                clienteConsultar(request, response);
            } else if (pagina.endsWith("CliCadastrar")) {
                clienteDigitar(request, response);
            } else if (pagina.endsWith("CliDeletar")) {
                clienteDeletar(request, response);
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
            if (pagina.endsWith("CliConsultar")) {
                clienteConsultar(request, response);
            } else if (pagina.endsWith("CliCadastrar")) {
                clienteSalvar(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }
    }

    protected void clienteSalvar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {

        Pessoa cliente = new Pessoa();

        // id = 0 CASO FOR TENTADO CADASTRAR MAIS DE 1 VEZ NA MESMA PAGINA
        if (request.getParameter("id").equalsIgnoreCase("") || request.getParameter("id") == null) {
            cliente.setId(0);
        } else {
            cliente.setId(Integer.valueOf(request.getParameter("id")));
        }

        cliente.setNome(request.getParameter("nome"));
        cliente.setTagPessoa(request.getParameter("tagPessoa"));
        cliente.setNumDocumento(request.getParameter("NrDocumento"));
        cliente.setTelefone(request.getParameter("telefone"));
        cliente.setEmail(request.getParameter("email"));
        cliente.setEndereco(request.getParameter("endereco"));
        cliente.setBairro(request.getParameter("bairro"));
        cliente.setCep(request.getParameter("cep"));
        cliente.setCidade(request.getParameter("cidade"));
        cliente.setUf(request.getParameter("uf"));

        try {

            boolean resposta = ServicoCliente.insertCli(cliente);
            if (resposta == true) {
                RequestDispatcher dispatcher
                        = request.getRequestDispatcher("CliConsultar");
                dispatcher.forward(request, response);
            }
        } catch (Exception ex) {
            RequestDispatcher rd = request.getRequestDispatcher(".jsp/cadastrarCli.jsp");

            request.setAttribute("cliente", cliente);
            request.setAttribute("erro", ex.getMessage());

            rd.forward(request, response);
        }
    }

    protected void clienteConsultar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        String busca = request.getParameter("buscar");
        String situacao = request.getParameter("situacao");

        if (busca == null && situacao == null) {
            busca = "";
            situacao = "Ativos";
        }

        List<Pessoa> cli = ServicoCliente.getList(busca, situacao);

        RequestDispatcher rd = request.getRequestDispatcher("/jsp/consultarCli.jsp");
        request.setAttribute("buscar", busca);
        request.setAttribute("cliente", cli);
        rd.forward(request, response);
    }

    protected void clienteDigitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        String req = request.getParameter("id");
        int id;

        if (req == null) {
            id = 0;
        } else {
            id = Integer.parseInt(req);
        }

        Pessoa cliente = ServicoCliente.getById(id);

        if (cliente.getId() != id) {
            response.sendRedirect("/jsp/consultarCli.jsp");
        } else {

            RequestDispatcher rd = request.getRequestDispatcher("/jsp/cadastrarCli.jsp");
            request.setAttribute("cliente", cliente);
            rd.forward(request, response);
        }
    }

    protected void clienteDeletar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        int id = Integer.parseInt(request.getParameter("id"));

        try {

            boolean resposta = ServicoCliente.deleteRegistro(id);

            if (resposta == true) {
                RequestDispatcher rd
                        = request.getRequestDispatcher("CliConsultar");
                rd.forward(request, response);
            }

        } catch (Exception ex) {
            request.setAttribute("erro", ex.getMessage());

            clienteConsultar(request, response);
        }
    }
}
