package br.com.senac.pi3.pwda.dao;

import br.com.senac.pi3.pwda.db.utils.ConnectionUtils;
import br.com.senac.pi3.pwda.model.Relatorio;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class DaoRelatorio {

    public static List<Relatorio> relatorioGlobal(String inicio, String fim, String cliente, String filial)
            throws SQLException, ClassNotFoundException {
        String condicao = "";
        String comandoSQL = "";
        float totVendido = 0;

        if (inicio == null) {
            inicio = "";
        }
        if (fim == null) {
            fim = "";
        }
        if (cliente == null) {
            cliente = "";
        }
        if (filial == null || filial.equalsIgnoreCase("TODAS")) {
            filial = "";
        }

        List<Relatorio> listVenda = new ArrayList<Relatorio>();

        Connection connection = ConnectionUtils.getConnection();
        Statement pst = connection.createStatement();

        if (!inicio.equals("") || !inicio.trim().isEmpty()) {
            condicao = condicao + " AND VEN.DH_INCLUSAO >= CONVERT('" + inicio + " 00:00:00'" + ", DATETIME)";
        }
        if (!fim.equals("") || !fim.trim().isEmpty()) {
            condicao = condicao + " AND VEN.DH_INCLUSAO <= CONVERT('" + fim + " 23:59:59'" + ", DATETIME)";
        }
        if (!filial.equals("") || !filial.trim().isEmpty()) {
            condicao = condicao + " AND EMP.EMPRESA LIKE '" + filial + "' ";
        }

        condicao = condicao.substring(5);
        if (!condicao.equals("") || !condicao.trim().isEmpty()) {
            condicao = " WHERE " + condicao;
        }
        comandoSQL
                = "SELECT\n"
                + "MAX(VEN.PK_ID) AS COD_VENDA,\n"
                + "MAX(EMP.EMPRESA) AS EMPRESA,\n"
                + "MAX(CLI.NOME) AS CLIENTE,\n"
                + "PROD.PRODUTO AS PRODUTO,\n"
                + "COUNT(ITE.PK_ID) AS QUANTIDADE,\n"
                + "MAX(PROD.VL_UNITARIO) AS VL_UNITARIO,\n"
                + "COUNT(ITE.PK_ID)*PROD.VL_UNITARIO AS VL_TOTAL,\n"
                + "MAX(VEN.DH_INCLUSAO) AS DT_COMPRA\n"
                + "FROM FI_VENDA AS VEN\n"
                + "INNER JOIN FI_ITEMVENDA AS ITE ON ITE.FK_VENDA   = VEN.PK_ID\n"
                + "INNER JOIN TB_PRODUTO AS PROD ON PROD.PK_ID      = ITE.FK_PRODUTO\n"
                + "INNER JOIN TB_EMPRESA AS EMP ON EMP.PK_ID        = VEN.FK_EMPRESA\n"
                + "INNER JOIN TB_CLIENTE AS CLI ON CLI.PK_ID        = VEN.FK_CLIENTE\n"
                + condicao
                + "GROUP BY ITE.FK_VENDA\n "
                + " ORDER BY VEN.PK_ID;";

        ResultSet resultado = pst.executeQuery(comandoSQL);

        while (resultado.next()) {

            Relatorio rel = new Relatorio();

            rel.setCodigo(resultado.getInt("COD_VENDA"));
            rel.setProduto(resultado.getString("PRODUTO"));
            rel.setCliente(resultado.getString("CLIENTE"));
            rel.setQtdComprado(resultado.getInt("QUANTIDADE"));
            rel.setValorUnitario(resultado.getFloat("VL_UNITARIO"));
            rel.setValorTotal(resultado.getFloat("VL_TOTAL"));
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            rel.setDataCompra(formatter.format(resultado.getDate("DT_COMPRA")));
            rel.setEmpresa(resultado.getString("EMPRESA"));
            totVendido = totVendido + rel.getValorTotal();

            if (resultado.isLast()) {
                rel.setTotFaturado(totVendido);
            }

            listVenda.add(rel);
        }

        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }

        return listVenda;
    }

    public static List<Relatorio> relatorioRegional(String inicio, String fim, String filial)
            throws SQLException, ClassNotFoundException {
        String condicao = "";
        String comandoSQL = "";
        float totVendido = 0;

        if (inicio == null) {
            inicio = "";
        }
        if (fim == null) {
            fim = "";
        }
        if (filial == null) {
            filial = "";
        }
        if (!filial.equals("") || !filial.trim().isEmpty()) {
            condicao = condicao + " AND EMP.EMPRESA LIKE '" + filial + "' ";
        }

        List<Relatorio> listVenda = new ArrayList<Relatorio>();

        Connection connection = ConnectionUtils.getConnection();
        Statement pst = connection.createStatement();

        if (!inicio.equals("") || !inicio.trim().isEmpty()) {
            condicao = condicao + " AND VEN.DH_INCLUSAO >= CONVERT('" + inicio + " 00:00:00'" + ", DATETIME)";
        }
        if (!fim.equals("") || !fim.trim().isEmpty()) {
            condicao = condicao + " AND VEN.DH_INCLUSAO <= CONVERT('" + fim + " 23:59:59'" + ", DATETIME)";
        }

        condicao = condicao.substring(5);
        if (!condicao.equals("") || !condicao.trim().isEmpty()) {
            condicao = " WHERE " + condicao;
        }

        comandoSQL
                = "SELECT\n"
                + "MAX(VEN.PK_ID) AS COD_VENDA,\n"
                + "MAX(EMP.EMPRESA) AS EMPRESA,\n"
                + "MAX(PROD.PRODUTO) AS PRODUTO,\n"
                + "MAX(CLI.NOME) AS CLIENTE,\n"
                + "COUNT(ITE.PK_ID) AS QUANTIDADE,\n"
                + "MAX(PROD.VL_UNITARIO) AS VL_UNITARIO,\n"
                + "COUNT(ITE.PK_ID)*PROD.VL_UNITARIO AS VL_TOTAL,\n"
                + "MAX(VEN.DH_INCLUSAO) AS DT_COMPRA\n"
                + "FROM FI_VENDA AS VEN\n"
                + "INNER JOIN FI_ITEMVENDA AS ITE ON ITE.FK_VENDA   = VEN.PK_ID\n"
                + "INNER JOIN TB_PRODUTO AS PROD ON PROD.PK_ID      = ITE.FK_PRODUTO\n"
                + "INNER JOIN TB_CLIENTE AS CLI ON CLI.PK_ID        = VEN.FK_CLIENTE\n"
                + "INNER JOIN TB_EMPRESA AS EMP ON EMP.PK_ID        = VEN.FK_EMPRESA\n"
                + condicao
                + "GROUP BY ITE.FK_VENDA\n "
                + " ORDER BY VEN.PK_ID;";

        ResultSet resultado = pst.executeQuery(comandoSQL);

        while (resultado.next()) {

            Relatorio rel = new Relatorio();

            rel.setCodigo(resultado.getInt("COD_VENDA"));
            rel.setProduto(resultado.getString("PRODUTO"));
            rel.setCliente(resultado.getString("CLIENTE"));
            rel.setQtdComprado(resultado.getInt("QUANTIDADE"));
            rel.setValorUnitario(resultado.getFloat("VL_UNITARIO"));
            rel.setValorTotal(resultado.getFloat("VL_TOTAL"));
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            rel.setDataCompra(formatter.format(resultado.getDate("DT_COMPRA")));
            rel.setEmpresa(resultado.getString("EMPRESA"));
            totVendido = totVendido + rel.getValorTotal();

            if (resultado.isLast()) {
                rel.setTotFaturado(totVendido);
            }

            listVenda.add(rel);
        }

        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
        return listVenda;
    }

    // REALTÓRIO DE VENDAS POR CLIENTE
    public static List<Relatorio> relatorioCliente(String inicio, String fim, String filial)
            throws SQLException, ClassNotFoundException {
        String condicao = "";
        String comandoSQL = "";
        float totVendido = 0;

        if (inicio == null) {
            inicio = "";
        }
        if (fim == null) {
            fim = "";
        }
        if (filial == null) {
            filial = "";
        }

        List<Relatorio> listVenda = new ArrayList<Relatorio>();

        Connection connection = ConnectionUtils.getConnection();
        Statement pst = connection.createStatement();

        if (!inicio.equals("") || !inicio.trim().isEmpty()) {
            condicao = condicao + " AND VEN.DH_INCLUSAO >= CONVERT('" + inicio + " 00:00:00'" + ", DATETIME)";
        }
        if (!fim.equals("") || !fim.trim().isEmpty()) {
            condicao = condicao + " AND VEN.DH_INCLUSAO <= CONVERT('" + fim + " 23:59:59'" + ", DATETIME)";
        }
        if (!filial.equals("") || !filial.trim().isEmpty()) {
            condicao = condicao + " AND EMP.EMPRESA LIKE '" + filial + "' ";
        }

        condicao = condicao.substring(5);
        if (!condicao.equals("") || !condicao.trim().isEmpty()) {
            condicao = " WHERE " + condicao;
        }
        comandoSQL
                = "SELECT\n"
                + "VEN.FK_CLIENTE AS COD_CLIENTE,\n"
                + "EMP.EMPRESA AS EMPRESA,\n"
                + "MAX(CLI.NOME) AS CLIENTE,\n"
                + "COUNT(ITE.PK_ID) AS QUANTIDADE,\n"
                + "COUNT(ITE.PK_ID)*PROD.VL_UNITARIO AS VL_TOTAL,\n"
                + "MAX(VEN.DH_INCLUSAO) AS DT_ULTCOMPRA\n"
                + "FROM FI_VENDA AS VEN\n"
                + "INNER JOIN FI_ITEMVENDA AS ITE ON ITE.FK_VENDA   = VEN.PK_ID\n"
                + "INNER JOIN TB_PRODUTO AS PROD ON PROD.PK_ID      = ITE.FK_PRODUTO\n"
                + "INNER JOIN TB_CLIENTE AS CLI ON CLI.PK_ID        = VEN.FK_CLIENTE\n"
                + "INNER JOIN TB_EMPRESA AS EMP ON EMP.PK_ID        = VEN.FK_EMPRESA\n"
                + condicao
                + "GROUP BY VEN.FK_CLIENTE, VEN.FK_EMPRESA\n"
                + " ORDER BY VEN.PK_ID;";

        ResultSet resultado = pst.executeQuery(comandoSQL);

        while (resultado.next()) {

            Relatorio rel = new Relatorio();

            rel.setCodigo(resultado.getInt("COD_CLIENTE"));
            rel.setCliente(resultado.getString("CLIENTE"));
            rel.setQtdComprado(resultado.getInt("QUANTIDADE"));
            rel.setValorTotal(resultado.getFloat("VL_TOTAL"));
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            rel.setDataCompra(formatter.format(resultado.getDate("DT_ULTCOMPRA")));
            rel.setEmpresa(resultado.getString("EMPRESA"));
            totVendido = totVendido + rel.getValorTotal();

            if (resultado.isLast()) {
                rel.setTotFaturado(totVendido);
            }

            listVenda.add(rel);
        }

        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
        return listVenda;
    }

    // REALTÓRIO DE VENDAS POR PRODUTO
    public static List<Relatorio> relatorioProduto(String inicio, String fim, String filial)
            throws SQLException, ClassNotFoundException {
        String condicao = "";
        String comandoSQL = "";
        float totVendido = 0;

        if (inicio == null) {
            inicio = "";
        }
        if (fim == null) {
            fim = "";
        }
        if (filial == null) {
            filial = "";
        }

        List<Relatorio> listVenda = new ArrayList<Relatorio>();

        Connection connection = ConnectionUtils.getConnection();
        Statement pst = connection.createStatement();

        if (!inicio.equals("") || !inicio.trim().isEmpty()) {
            condicao = condicao + " AND VEN.DH_INCLUSAO >= CONVERT('" + inicio + " 00:00:00'" + ", DATETIME)";
        }
        if (!fim.equals("") || !fim.trim().isEmpty()) {
            condicao = condicao + " AND VEN.DH_INCLUSAO <= CONVERT('" + fim + " 23:59:59'" + ", DATETIME)";
        }
        if (!filial.equals("") || !filial.trim().isEmpty()) {
            condicao = condicao + " AND EMP.EMPRESA LIKE '" + filial + "' ";
        }

        condicao = condicao.substring(5);
        if (!condicao.equals("") || !condicao.trim().isEmpty()) {
            condicao = " WHERE " + condicao;
        }
        comandoSQL
                = "SELECT\n"
                + "ITE.FK_PRODUTO AS COD_PRODUTO,\n"
                + "EMP.EMPRESA AS EMPRESA,\n"
                + "PROD.PRODUTO AS PRODUTO,\n"
                + "COUNT(ITE.PK_ID) AS QUANTIDADE,\n"
                + "MAX(PROD.VL_UNITARIO) AS VL_UNITARIO,\n"
                + "COUNT(ITE.PK_ID)*PROD.VL_UNITARIO AS VL_TOTAL,\n"
                + "MAX(VEN.DH_INCLUSAO) AS DT_ULTCOMPRA\n"
                + "FROM FI_VENDA AS VEN\n"
                + "INNER JOIN FI_ITEMVENDA AS ITE ON ITE.FK_VENDA   = VEN.PK_ID\n"
                + "INNER JOIN TB_PRODUTO AS PROD ON PROD.PK_ID      = ITE.FK_PRODUTO\n"
                + "INNER JOIN TB_CLIENTE AS CLI ON CLI.PK_ID        = VEN.FK_CLIENTE\n"
                + "INNER JOIN TB_EMPRESA AS EMP ON EMP.PK_ID        = VEN.FK_EMPRESA\n"
                + condicao
                + "GROUP BY ITE.FK_PRODUTO, VEN.FK_EMPRESA\n"
                + " ORDER BY VEN.PK_ID;";

        ResultSet resultado = pst.executeQuery(comandoSQL);

        while (resultado.next()) {

            Relatorio rel = new Relatorio();

            rel.setCodigo(resultado.getInt("COD_PRODUTO"));
            rel.setProduto(resultado.getString("PRODUTO"));
            rel.setQtdComprado(resultado.getInt("QUANTIDADE"));
            rel.setValorUnitario(resultado.getFloat("VL_UNITARIO"));
            rel.setValorTotal(resultado.getFloat("VL_TOTAL"));
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            rel.setDataCompra(formatter.format(resultado.getDate("DT_ULTCOMPRA")));
            rel.setEmpresa(resultado.getString("EMPRESA"));
            totVendido = totVendido + rel.getValorTotal();

            if (resultado.isLast()) {
                rel.setTotFaturado(totVendido);
            }

            listVenda.add(rel);
        }

        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
        return listVenda;
    }
}
