package br.com.senac.pi3.pwda.controller;

import br.com.senac.pi3.pwda.dao.DaoVenda;
import br.com.senac.pi3.pwda.model.ItemVenda;
import br.com.senac.pi3.pwda.model.Login;
import br.com.senac.pi3.pwda.model.Pessoa;
import br.com.senac.pi3.pwda.model.Produto;
import br.com.senac.pi3.pwda.model.Venda;
import br.com.senac.pi3.pwda.servico.ServicoVenda;
import br.com.senac.pi3.pwda.validador.Comuns;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "VendaServlet", urlPatterns = {"/Caixa", "/CarregarProd", "/IncluirProd", "/DeleteVenda", "/RealizarVenda", "/CarregarCli"})
public class VendaServlet extends HttpServlet {
        
    private List<Produto> listaProd = new ArrayList<Produto>();
    Venda venda = null;
    Pessoa cliente;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {  
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String pagina = request.getRequestURI();        
                
            try {
                if (pagina.endsWith("DeleteVenda")) {
                    deleteProdCarrinho(request, response);
                }
                
                if (pagina.endsWith("Caixa")) { 
                    if(!listaProd.isEmpty()){
                        listaProd.clear();
                        cliente = null;
                    }    

                    RequestDispatcher rd                        
                        = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
                    rd.forward(request, response);                 
                }
                
            } catch (Exception ex) {
                throw new ServletException(ex.getMessage());
            }                 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String pagina = request.getRequestURI();        
        
        try {
            if (pagina.endsWith("CarregarProd")) {
                produtoCarregar(request, response);
            }
            
            if (pagina.endsWith("IncluirProd")) {
                produtoCarrinho(request, response);
            }
            
            if (pagina.endsWith("RealizarVenda")) {            
                finalizarVenda(request, response);
            }
            
            if(pagina.endsWith("CarregarCli")){
                clienteCarregar(request, response);
            }

        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }

    }
    
    protected void produtoCarregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        
        try {
            
            String busca = request.getParameter("vendaProduto");        

            Produto prod = DaoVenda.selectProd(busca);                    

            //faz calculo do subtotal
            float subtotal = 0;
            for (int i = 0; i < listaProd.size(); i++) {

                subtotal += listaProd.get(i).getValorTotal();
            }

            Login usuario = Comuns.getUsuarioLogado();
            HttpSession sessao = request.getSession();
            sessao.setAttribute("usuario", usuario.getId());
            sessao.setAttribute("usuario", usuario);

            RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp"); 
            request.setAttribute("subtotal", subtotal); 
            if(!listaProd.isEmpty()){
                    request.setAttribute("listaProduto", listaProd);      
            }                
            request.setAttribute("produto", prod);  
            request.setAttribute("cliente", cliente);
            rd.forward(request, response);
            
        } catch (Exception e) {
            
            //faz calculo1 do subtotal
            float subtotal = 0;
            if(!listaProd.isEmpty()){

                for (int i = 0; i < listaProd.size(); i++) {

                    subtotal += listaProd.get(i).getValorTotal();
                }
            }

            Login usuario = Comuns.getUsuarioLogado();
            HttpSession sessao = request.getSession();
            sessao.setAttribute("usuario", usuario.getId());
            sessao.setAttribute("usuario", usuario);
            
            request.setAttribute("msgErro", "Informar o Código do Produto");
            RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
            request.setAttribute("subtotal", subtotal);
            if(!listaProd.isEmpty()){
                request.setAttribute("listaProduto", listaProd);      
            }    
            request.setAttribute("cliente", cliente);
            rd.forward(request, response);
                                        
        }                        
    }
    
    protected void produtoCarrinho(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        
        try {
            
             Produto produto = new Produto();                 
            
            produto.setId(Integer.valueOf(request.getParameter("id")));                
            produto.setProduto(request.getParameter("vendaProduto"));        
            int qtd = Integer.parseInt(request.getParameter("quantidadeVenda"));
            produto.setQtdProd(qtd);                          
            float valorUnitario = Float.parseFloat(request.getParameter("valorUnitario").replace(',', '.'));
            produto.setValorUnitario(valorUnitario);                
            produto.setValorTotal(valorUnitario * qtd); 

            listaProd.add(produto);

            //faz calculo do subtotal
            float subtotal = 0;
            for (int i = 0; i < listaProd.size(); i++) {

                subtotal += listaProd.get(i).getValorTotal();
            }
            
            Login usuario = Comuns.getUsuarioLogado();
            HttpSession sessao = request.getSession();
            sessao.setAttribute("usuario", usuario.getId());
            sessao.setAttribute("usuario", usuario);

            RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
            request.setAttribute("subtotal", subtotal); 
            if(!listaProd.isEmpty()){
                request.setAttribute("listaProduto", listaProd);      
            }       
            request.setAttribute("cliente", cliente);
            rd.forward(request, response); 
            
        } catch (Exception e) {
            
            //faz calculo1 do subtotal
            float subtotal = 0;
            if(!listaProd.isEmpty()){

                for (int i = 0; i < listaProd.size(); i++) {

                    subtotal += listaProd.get(i).getValorTotal();
                }
            }

            Login usuario = Comuns.getUsuarioLogado();
            HttpSession sessao = request.getSession();
            sessao.setAttribute("usuario", usuario.getId());
            sessao.setAttribute("usuario", usuario);
            
            if(request.getParameter("quantidadeVenda") == null || request.getParameter("quantidadeVenda") == ""){
                request.setAttribute("msgErro", "Informar a quantidade");
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
            request.setAttribute("subtotal", subtotal);
            if(!listaProd.isEmpty()){
                request.setAttribute("listaProduto", listaProd);      
            }   
            request.setAttribute("cliente", cliente);
            rd.forward(request, response);                    
        }             
    }
    
    protected void deleteProdCarrinho(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
                               
        int id = Integer.parseInt(request.getParameter("id"));
                
        for(int i = 0; i < listaProd.size(); i++) {            

            if(listaProd.get(i).getId() == id)
            {                
                // Remove.
                listaProd.remove(i);

                // Sai do loop.
                break;
            }
        }   
        
        //faz calculo do subtotal
        float subtotal = 0;      
        if(!listaProd.isEmpty()){
            
            for (int i = 0; i < listaProd.size(); i++) {

                subtotal += listaProd.get(i).getValorTotal();
            }
        }
        
        Login usuario = Comuns.getUsuarioLogado();
        HttpSession sessao = request.getSession();
        sessao.setAttribute("usuario", usuario.getId());
        sessao.setAttribute("usuario", usuario);

        RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp");          
        request.setAttribute("subtotal", subtotal); 
        if(!listaProd.isEmpty()){
            request.setAttribute("listaProduto", listaProd);      
        }      
        request.setAttribute("cliente", cliente);
        rd.forward(request, response);            
    }
    
    protected void finalizarVenda(HttpServletRequest request, HttpServletResponse response) 
                throws ServletException, IOException, Exception {
        
        try {
            
            int idCaixa = Integer.parseInt(request.getParameter("idCaixa"));            

            venda = new Venda();
            String retorno = null;                

            double valorTotal = Double.parseDouble(request.getParameter("sub-total"));
            
            int idCliente;
            if(request.getParameter("idCliente").equals("") || request.getParameter("idCliente") == null){
                idCliente = 1;
            }else{
                idCliente = Integer.parseInt(request.getParameter("idCliente"));
            }            
            
            List<ItemVenda> listaItemVenda = new ArrayList<ItemVenda>();
            for (int i = 0; i < listaProd.size(); i++) {
                ItemVenda itemVenda = new ItemVenda();
                itemVenda.setCodigoProd(listaProd.get(i).getId());
                itemVenda.setQuantidade(listaProd.get(i).getQtdProd());

                venda.setQuantidade(listaProd.get(i).getQtdProd());                                            
                listaItemVenda.add(itemVenda);               
            } 
            venda.setIdCliente(idCliente);
            venda.setItens(listaItemVenda);        
            venda.setIdCaixa(idCaixa);
            venda.setValorTotal(valorTotal);           

            retorno = ServicoVenda.cadastrarVenda(venda);

            if (retorno == null) { 
                listaProd.clear();
                cliente = null;                
                RequestDispatcher rd
                            = request.getRequestDispatcher("./jsp/home.jsp");
                response.sendRedirect("./jsp/home.jsp"); 
            } else{
                request.setAttribute("msgErro", retorno);
            RequestDispatcher rd
                = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
            rd.forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("msgErro", "Não há produto selecionado para a venda");
            RequestDispatcher rd
                = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
            rd.forward(request, response);
        }            
                                         
    }
    
    protected void clienteCarregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        
        try {
            
            String busca = request.getParameter("cpf");        
            
             
            cliente = DaoVenda.selectCli(busca);                    

            //faz calculo do subtotal
            float subtotal = 0;
            for (int i = 0; i < listaProd.size(); i++) {

                subtotal += listaProd.get(i).getValorTotal();
            }

            Login usuario = Comuns.getUsuarioLogado();
            HttpSession sessao = request.getSession();
            sessao.setAttribute("usuario", usuario.getId());
            sessao.setAttribute("usuario", usuario);

            RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp"); 
            request.setAttribute("subtotal", subtotal); 
            if(!listaProd.isEmpty()){
                    request.setAttribute("listaProduto", listaProd);      
            }                
            request.setAttribute("cliente", cliente);       
            rd.forward(request, response);
            
        } catch (Exception e) {
            
            //faz calculo1 do subtotal
            float subtotal = 0;
            if(!listaProd.isEmpty()){

                for (int i = 0; i < listaProd.size(); i++) {

                    subtotal += listaProd.get(i).getValorTotal();
                }
            }

            Login usuario = Comuns.getUsuarioLogado();
            HttpSession sessao = request.getSession();
            sessao.setAttribute("usuario", usuario.getId());
            sessao.setAttribute("usuario", usuario);
            
            request.setAttribute("msgErro", "Informar o Código do Produto");
            RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
            request.setAttribute("subtotal", subtotal);
            if(!listaProd.isEmpty()){
                request.setAttribute("listaProduto", listaProd);      
            }     
            request.setAttribute("cliente", cliente);
            rd.forward(request, response);
                                        
        }                        
    }

}
