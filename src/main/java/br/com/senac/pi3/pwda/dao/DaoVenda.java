package br.com.senac.pi3.pwda.dao;

import br.com.senac.pi3.pwda.db.utils.ConnectionUtils;
import br.com.senac.pi3.pwda.model.ItemVenda;
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
         
        String sql = "INSERT INTO FI_ITEMVENDA (FK_VENDA, FK_PRODUTO, VL_UNITARIO, "
                + "QUANTIDADE, DH_INCLUSAO) VALUES (?, ?, ?, ?, NOW())";
        
        PreparedStatement pst = connection.prepareStatement(sql);
        
        try {
            if(connection != null){
                
                pst.setInt(1, idVenda);
                pst.setInt(2, itemVenda.getProduto().getId());
                pst.setDouble(3, itemVenda.getValorUnitario());
                pst.setInt(4, itemVenda.getQuantidade());

                pst.execute();
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
    
    public static void decrementarEstoque(ItemVenda quantidade) throws SQLException,
            Exception {
        
        Connection connection = ConnectionUtils.getConnection();
        
        String sql = "UPDATE TB_PRODUTO SET QUANTIDADE=? WHERE PK_ID=?";
        
        PreparedStatement pst = connection.prepareStatement(sql);
        
        try {
            if(connection != null){                
            
                
                pst.setInt(1, quantidade.getProduto().getQtdProd() - quantidade.getQuantidade());
                pst.setInt(2, quantidade.getProduto().getId());

                pst.executeUpdate();
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
    
    public static void inserir(Venda venda) throws SQLException, Exception {
        
        Connection connection = ConnectionUtils.getConnection();
        
        String sql = "INSERT INTO FI_VENDA (FK_CLIENTE, FK_ITEMVENDA, VL_TOTAL, "
                + "DT_VENDA, DH_INCLUSAO) VALUES (?, ?, ?, NOW(), NOW())";
                
         PreparedStatement pst = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

        try {
            
            if(connection != null){
                connection = ConnectionUtils.getConnection();
                pst.setInt(1, venda.getCliente().getId());
                pst.setInt(2, 10); // nº 10 - teste com FK_ITEMVENDA
                pst.setDouble(3, venda.getCalcularTotal());

                pst.execute();
            }


            Integer idVenda = null;
            ResultSet chaveGeradaVenda = pst.getGeneratedKeys();
            if (chaveGeradaVenda.next()) {
                idVenda = chaveGeradaVenda.getInt(1);
            }

            for (ItemVenda item : venda.getItens()) {
                inserirItemVenda(item, idVenda);
                decrementarEstoque(item);
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
    
}
