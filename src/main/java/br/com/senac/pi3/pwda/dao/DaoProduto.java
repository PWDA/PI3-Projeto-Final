package br.com.senac.pi3.pwda.dao;

import br.com.senac.pi3.pwda.db.utils.ConnectionUtils;
import br.com.senac.pi3.pwda.model.Produto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DaoProduto {

    public static boolean update(Produto prod)
            throws SQLException, Exception {

        Connection connection = ConnectionUtils.getConnection();

        String sqlComando = "UPDATE TB_PRODUTO SET PRODUTO=?, FK_TIPOPROD=?, QUANTIDADE=?,"
                + "ORIGEM=?, VL_UNITARIO=?, DESCRICAO=?, DH_ALTERACAO= NOW() WHERE (PK_ID=?)";

        PreparedStatement pst = connection.prepareStatement(sqlComando);

        try {

            pst.setString(1, prod.getProduto());
            pst.setInt(2, prod.getTipoProd());
            pst.setInt(3, prod.getQtdProd());
            pst.setString(4, prod.getOrigem());
            pst.setDouble(5, prod.getValorUnitario());
            pst.setString(6, prod.getDescricao());
            pst.setInt(7, prod.getId());

            pst.execute();
        } finally {
            if (pst != null && !pst.isClosed()) {
                pst.close();
            }
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        }

        return true;
    }

    public static boolean insert(Produto prod)
            throws SQLException, Exception {

        Connection connection = ConnectionUtils.getConnection();

        String sqlComando = "INSERT INTO TB_PRODUTO"
                + "(PRODUTO, FK_TIPOPROD, QUANTIDADE, ORIGEM, VL_UNITARIO, DESCRICAO, DH_INCLUSAO,"
                + "TG_INATIVO) VALUES (?, ?, ?, ?, ?, ?, NOW(), 0);";

        PreparedStatement pst = connection.prepareStatement(sqlComando);

        try {
            if (connection != null) {

                pst.setString(1, prod.getProduto());
                pst.setInt(2, prod.getTipoProd());
                pst.setInt(3, prod.getQtdProd());
                pst.setString(4, prod.getOrigem());
                pst.setFloat(5, prod.getValorUnitario());
                pst.setString(6, prod.getDescricao());

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

        return true;
    }

    public static List<Produto> selectAll(String condicao, String situacao)
            throws SQLException, ClassNotFoundException {
        String filtro = "";
        String filtro2 = "";

        if (condicao == null) {
            condicao = "";
        } else if (situacao == null) {
            situacao = "";
        }

        List<Produto> listarProd = new ArrayList<Produto>();

        Connection connection = ConnectionUtils.getConnection();
        Statement pst = connection.createStatement();

        if (condicao != null || !condicao.trim().isEmpty()) {
            filtro = condicao;
        }

        if (situacao.trim().equals("Ativos")) {
            filtro2 = " AND TG_INATIVO = 0";
        } else if (situacao.trim().equals("Inativos")) {
            filtro2 = " AND TG_INATIVO = 1";
        }

        ResultSet resultado = pst.executeQuery(
                "SELECT PK_ID, PRODUTO, FK_TIPOPROD, QUANTIDADE, ORIGEM, "
                + "VL_UNITARIO, DESCRICAO FROM TB_PRODUTO WHERE PRODUTO LIKE'%" + filtro + "%'" + filtro2 + ";");

        while (resultado.next()) {

            Produto prod = new Produto();
            prod.setId(resultado.getInt("PK_ID"));
            prod.setProduto(resultado.getString("PRODUTO"));
            prod.setTipoProd(resultado.getInt("FK_TIPOPROD"));
            prod.setQtdProd(resultado.getInt("QUANTIDADE"));
            prod.setOrigem(resultado.getString("ORIGEM"));
            prod.setValorUnitario(resultado.getFloat("VL_UNITARIO"));
            prod.setDescricao(resultado.getString("DESCRICAO"));

            listarProd.add(prod);
        }
        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
        return listarProd;
    }

    public static boolean inativar(Produto prod)
            throws SQLException, Exception {

        String sqlComando = "UPDATE TB_PRODUTO SET TG_INATIVO = 1 WHERE PK_ID = ?";

        Connection connection = ConnectionUtils.getConnection();
        PreparedStatement pst = connection.prepareStatement(sqlComando);
        pst.setInt(1, prod.getId());

        try {
            pst.execute();
            pst.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    public static boolean setRegistro(Produto prod) throws Exception, ClassNotFoundException, SQLException {
        if (prod.getId() == 0) {
            return insert(prod);
        } else {
            return update(prod);
        }
    }

    public static Produto getById(int id) throws Exception, ClassNotFoundException, SQLException {
        Produto prod = new Produto();

        Connection connection = ConnectionUtils.getConnection();

        Statement st = connection.createStatement();

        ResultSet rs = st.executeQuery("SELECT * FROM TB_PRODUTO WHERE PK_ID = " + id);

        while (rs.next()) {

            prod.setId(rs.getInt("PK_ID"));
            prod.setProduto(rs.getString("PRODUTO"));
            prod.setTipoProd(rs.getInt("FK_TIPOPROD"));
            prod.setQtdProd(rs.getInt("QUANTIDADE"));
            prod.setOrigem(rs.getString("ORIGEM"));
            prod.setValorUnitario(rs.getFloat("VL_UNITARIO"));
            prod.setDescricao(rs.getString("DESCRICAO"));
            prod.setInativo(rs.getInt("TG_INATIVO"));

        }

        return prod;
    }

}
