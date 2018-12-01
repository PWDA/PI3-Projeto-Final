package br.com.senac.pi3.pwda.controller;

import br.com.senac.pi3.pwda.dao.DaoVenda;
import br.com.senac.pi3.pwda.model.Produto;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "VendaServlet", urlPatterns = {"/Venda", "/CarregarProd", "/IncluirProd", "/DeleteVenda"})
public class VendaServlet extends HttpServlet {
        
    private List<Produto> listaProd = new ArrayList<Produto>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        
        String pagina = request.getRequestURI();  
        
        if (pagina.endsWith("DeleteVenda")) {
            try {
                deleteProdCarrinho(request, response);
            } catch (Exception ex) {
                Logger.getLogger(VendaServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
         
        RequestDispatcher rd
            = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pagina = request.getRequestURI();        
        
        try {
            if (pagina.endsWith("CarregarProd")) {
                produtoCarregar(request, response);
            }
            if (pagina.endsWith("IncluirProd")) {
                produtoCarrinho(request, response);
            }

        } catch (Exception ex) {
            throw new ServletException(ex.getMessage());
        }

    }
    
    protected void produtoCarregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        
        String busca = request.getParameter("vendaProduto");        

        Produto prod = DaoVenda.selectProd(busca);       
        
        //faz calculo do subtotal
        float subtotal = 0;
        for (int i = 0; i < listaProd.size(); i++) {
            
            subtotal += listaProd.get(i).getValorTotal();
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp"); 
        request.setAttribute("subtotal", subtotal); 
        request.setAttribute("listaProduto", listaProd);        
        request.setAttribute("produto", prod);       
        rd.forward(request, response);
    }
    
    protected void produtoCarrinho(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        
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
                                                                       
        RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp");
        request.setAttribute("subtotal", subtotal); 
        request.setAttribute("listaProduto", listaProd);       
        rd.forward(request, response);            
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
        for (int i = 0; i < listaProd.size(); i++) {
            
            subtotal += listaProd.get(i).getValorTotal();
        }

        RequestDispatcher rd = request.getRequestDispatcher("/jsp/realizarVenda.jsp");  
        request.setAttribute("subtotal", subtotal); 
        request.setAttribute("listaProduto", listaProd);       
        rd.forward(request, response);            
    }

}
