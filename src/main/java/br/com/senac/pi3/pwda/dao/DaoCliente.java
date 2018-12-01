package br.com.senac.pi3.pwda.dao;

import br.com.senac.pi3.pwda.db.utils.ConnectionUtils;
import br.com.senac.pi3.pwda.model.Pessoa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DaoCliente {

    public static boolean update(Pessoa cli)
            throws SQLException, Exception {

        Connection connection = ConnectionUtils.getConnection();

        String sqlComando = "UPDATE TB_CLIENTE SET NOME=?, NRDOC=?, "
                + "ENDERECO=?, BAIRRO=?, UF=?, CIDADE=?, CEP=?, TELEFONE=?, EMAIL=?, "
                + "TG_PESSOA=?, DH_ALTERACAO= NOW() WHERE (PK_ID=?)";

        PreparedStatement pst = connection.prepareStatement(sqlComando);

        try {

            pst.setString(1, cli.getNome());
            pst.setString(2, cli.getNumDocumento());
            pst.setString(3, cli.getEndereco());
            pst.setString(4, cli.getBairro());
            pst.setString(5, cli.getUf());
            pst.setString(6, cli.getCidade());
            pst.setString(7, cli.getCep());
            pst.setString(8, cli.getTelefone());
            pst.setString(9, cli.getEmail());
            pst.setString(10, cli.getTagPessoa());
            pst.setInt(11, cli.getId());

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

    public static boolean insert(Pessoa cli)
            throws SQLException, Exception {

        Connection connection = ConnectionUtils.getConnection();

        String sqlComando = "INSERT INTO TB_CLIENTE"
                + "(NOME, NRDOC, ENDERECO, BAIRRO, UF, CIDADE, CEP, TELEFONE, "
                + "EMAIL, TG_PESSOA, TG_INATIVO, DH_INCLUSAO)"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, NOW())";

        PreparedStatement pst = connection.prepareStatement(sqlComando);

        try {
            if (connection != null) {

                pst.setString(1, cli.getNome());
                pst.setString(2, cli.getNumDocumento());
                pst.setString(3, cli.getEndereco());
                pst.setString(4, cli.getBairro());
                pst.setString(5, cli.getUf());
                pst.setString(6, cli.getCidade());
                pst.setString(7, cli.getCep());
                pst.setString(8, cli.getTelefone());
                pst.setString(9, cli.getEmail());
                pst.setString(10, cli.getTagPessoa());

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

    public static List<Pessoa> selectAll(String condicao, String situacao)
            throws SQLException, ClassNotFoundException {
        String filtro = "";
        String filtro2 = "";

        if (condicao == null) {
            condicao = "";
        } else if (situacao == null) {
            situacao = "";
        }

        List<Pessoa> listarCli = new ArrayList<Pessoa>();

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
                "SELECT PK_ID, NOME, NRDOC, TELEFONE, "
                + "EMAIL FROM TB_CLIENTE WHERE NOME LIKE'%" + filtro + "%'" + filtro2 + ";");

        while (resultado.next()) {

            Pessoa cli = new Pessoa();
            cli.setId(resultado.getInt("PK_ID"));
            cli.setNome(resultado.getString("NOME"));
            cli.setNumDocumento(resultado.getString("NRDOC"));
            cli.setTelefone(resultado.getString("TELEFONE"));
            cli.setEmail(resultado.getString("EMAIL"));

            listarCli.add(cli);
        }
        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
        return listarCli;
    }

    public static boolean inativar(Pessoa cli)
            throws SQLException, Exception {

        String sqlComando = "UPDATE TB_CLIENTE SET TG_INATIVO = 1 WHERE PK_ID = ?";

        Connection connection = ConnectionUtils.getConnection();
        PreparedStatement pst = connection.prepareStatement(sqlComando);
        pst.setInt(1, cli.getId());

        try {
            pst.execute();
            pst.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    public static boolean setRegistro(Pessoa cli) throws Exception, ClassNotFoundException, SQLException {
        if (cli.getId() == 0) {
            return insert(cli);
        } else {
            return update(cli);
        }
    }

    public static Pessoa getById(int id) throws Exception, ClassNotFoundException, SQLException {
        Pessoa cli = new Pessoa();

        Connection connection = ConnectionUtils.getConnection();

        Statement st = connection.createStatement();

        ResultSet rs = st.executeQuery("SELECT * FROM TB_CLIENTE WHERE PK_ID = " + id);

        while (rs.next()) {
            cli.setId(rs.getInt("PK_ID"));
            cli.setNome(rs.getString("NOME").trim());
            cli.setNumDocumento(rs.getString("NRDOC").trim());
            cli.setEndereco(rs.getString("ENDERECO"));
            cli.setBairro(rs.getString("BAIRRO").trim());
            cli.setUf(rs.getString("UF").trim());
            cli.setCidade(rs.getString("CIDADE").trim());
            cli.setCep(rs.getString("CEP").trim());
            cli.setTelefone(rs.getString("TELEFONE").trim());
            cli.setEmail(rs.getString("EMAIL").trim());
            cli.setTagPessoa(rs.getString("TG_PESSOA"));

        }

        return cli;
    }

}
