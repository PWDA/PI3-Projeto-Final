package br.com.senac.pi3.pwda.dao;

import br.com.senac.pi3.pwda.db.utils.ConnectionUtils;
import br.com.senac.pi3.pwda.model.ItemVenda;
import br.com.senac.pi3.pwda.model.Pessoa;
import br.com.senac.pi3.pwda.model.Produto;
import br.com.senac.pi3.pwda.model.Venda;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class DaoVenda {
    
    public static void inserirItemVenda(ItemVenda itemVenda, int idVenda)
            throws SQLException, Exception {
        
         Connection connection = ConnectionUtils.getConnection();
         
        String sql = "INSERT INTO FI_ITEMVENDA (FK_VENDA, FK_PRODUTO, "
                + "DH_INCLUSAO) VALUES (?, ?, NOW())";
        
        PreparedStatement pst = connection.prepareStatement(sql);
        
        try {
            if(connection != null){
                
                for (int i = 0; i < itemVenda.getQuantidade(); i++) {
                
                    pst.setInt(1, idVenda);
                    pst.setInt(2, itemVenda.getCodigoProd());                                   

                    pst.execute();
                }
            }

        } finally {
            if (pst != null && !pst.isClosed()) {
                pst.close();
            }
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        }
    }
    
//    public static void decrementarEstoque(ItemVenda quantidade) throws SQLException,
//            Exception {
//        
//        Connection connection = ConnectionUtils.getConnection();
//        
//        String sql = "UPDATE TB_PRODUTO SET QUANTIDADE=? WHERE PK_ID=?";
//        
//        PreparedStatement pst = connection.prepareStatement(sql);
//        
//        try {
//            if(connection != null){                
//            
//                
//                pst.setInt(1, quantidade.getProduto().getQtdProd() - quantidade.getQuantidade());
//                pst.setInt(2, quantidade.getProduto().getId());
//
//                pst.executeUpdate();
//            }
//
//        } finally {
//            if (pst != null && !pst.isClosed()) {
//                pst.close();
//            }
//            if (connection != null && !connection.isClosed()) {
//                connection.close();
//            }
//        }
//    }
    
    public static void inserir(Venda venda) throws SQLException, Exception {
        
        Connection connection = ConnectionUtils.getConnection();
        
        String sql = "INSERT INTO FI_VENDA (FK_CAIXA, FK_CLIENTE, FK_EMPRESA, VL_TOTAL, "
                + "QUANTIDADE, DT_VENDA, DH_INCLUSAO) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
                
         PreparedStatement pst = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

        try {
            
            if(connection != null){                
                pst.setInt(1, venda.getIdCaixa());
                pst.setInt(2, venda.getIdCliente());
                pst.setInt(3, 1);    //venda.getEmpresa()
                pst.setDouble(4, venda.getValorTotal());
                pst.setInt(5, venda.getQuantidade());

                pst.execute();
            }


            Integer idVenda = null;
            ResultSet chaveGeradaVenda = pst.getGeneratedKeys();
            if (chaveGeradaVenda.next()) {
                idVenda = chaveGeradaVenda.getInt(1);
            }

            for (ItemVenda item : venda.getItens()) {
                inserirItemVenda(item, idVenda);
                //decrementarEstoque(item);
            }

        } finally {
            if (pst != null && !pst.isClosed()) {
                pst.close();
            }
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        }

    }
    
    public static Produto selectProd(String condicao)
        throws SQLException, ClassNotFoundException {
        
        String filtro = "";        
        
         Produto listarProd = new Produto();

        Connection connection = ConnectionUtils.getConnection();
        Statement pst = connection.createStatement();  
        
        if(condicao != null || !condicao.trim().isEmpty()){
            filtro = condicao;
        }             
        
        ResultSet resultado = pst.executeQuery(
            "SELECT PK_ID, PRODUTO, QUANTIDADE, VL_UNITARIO "
                + "FROM TB_PRODUTO WHERE PRODUTO LIKE '"+filtro+"%' AND TG_INATIVO = 0;");

        while (resultado.next()) {

            Produto prod = new Produto();
            prod.setId(resultado.getInt("PK_ID"));
            prod.setProduto(resultado.getString("PRODUTO"));            
            prod.setQtdProd(resultado.getInt("QUANTIDADE"));            
            prod.setValorUnitario(resultado.getFloat("VL_UNITARIO"));            

            listarProd = prod;
        }
        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
        return listarProd;
    }
    
    public static Pessoa selectCli(String condicao)
        throws SQLException, ClassNotFoundException {
        
        String filtro = "";        
        
         Pessoa listarCli = new Pessoa();

        Connection connection = ConnectionUtils.getConnection();
        Statement pst = connection.createStatement();  
        
        if(condicao != null || !condicao.trim().isEmpty()){
            filtro = condicao;
        }             
        
        ResultSet resultado = pst.executeQuery(
            "SELECT PK_ID, NOME, NRDOC "
                + "FROM TB_CLIENTE WHERE NRDOC = "+filtro+" AND TG_INATIVO = 0;");

        while (resultado.next()) {

            Pessoa cli = new Pessoa();
            cli.setId(resultado.getInt("PK_ID"));
            cli.setNome(resultado.getString("NOME"));            
            cli.setNumDocumento(resultado.getString("NRDOC"));                                 

            listarCli = cli;
        }
        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
        return listarCli;
    }
    
}
