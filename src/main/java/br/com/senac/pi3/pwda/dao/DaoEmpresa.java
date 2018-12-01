package br.com.senac.pi3.pwda.dao;

import br.com.senac.pi3.pwda.db.utils.ConnectionUtils;
import br.com.senac.pi3.pwda.model.Empresa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DaoEmpresa {

    public static boolean update(Empresa emp)
            throws SQLException, Exception {

        Connection connection = ConnectionUtils.getConnection();

        String sqlComando = "UPDATE TB_EMPRESA SET EMPRESA=?, DIRETOR=?, NR_CNPJ=?,"
                + "ENDERECO=?, BAIRRO=?, CIDADE=?, UF=?,"
                + "CEP=?, EMAIL=?, TELEFONE=?, DH_ALTERACAO= NOW() WHERE (PK_ID=?)";

        PreparedStatement pst = connection.prepareStatement(sqlComando);

        try {

            pst.setString(1, emp.getEmpresa());
            pst.setString(2, emp.getDiretor());
            pst.setString(3, emp.getCnpj());
            pst.setString(4, emp.getEndereco());
            pst.setString(5, emp.getBairro());
            pst.setString(6, emp.getCidade());
            pst.setString(7, emp.getUf());
            pst.setString(8, emp.getCep());
            pst.setString(9, emp.getEmail());
            pst.setString(10, emp.getTelefone());
            pst.setInt(11, emp.getId());
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

    public static boolean insert(Empresa emp)
            throws SQLException, Exception {

        Connection connection = ConnectionUtils.getConnection();

        String sqlComando = "INSERT INTO TB_EMPRESA "
                + "(EMPRESA, DIRETOR, NR_CNPJ, ENDERECO, BAIRRO,"
                + "CIDADE, UF, CEP, EMAIL, TELEFONE, DH_INCLUSAO, TG_INATIVO)"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), 0);";

        PreparedStatement pst = connection.prepareStatement(sqlComando);

        try {
            if (connection != null) {

                pst.setString(1, emp.getEmpresa());
                pst.setString(2, emp.getDiretor());
                pst.setString(3, emp.getCnpj());
                pst.setString(4, emp.getEndereco());
                pst.setString(5, emp.getBairro());
                pst.setString(6, emp.getCidade());
                pst.setString(7, emp.getUf());
                pst.setString(8, emp.getCep());
                pst.setString(9, emp.getEmail());
                pst.setString(10, emp.getTelefone());

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

    public static List<Empresa> selectAll(String condicao, String situacao)
            throws SQLException, ClassNotFoundException {

        String filtro = "";
        String filtro2 = "";

        if (condicao == null) {
            condicao = "";
        } else if (situacao == null) {
            situacao = "";
        }

        List<Empresa> listarEmp = new ArrayList<Empresa>();

        Connection connection = ConnectionUtils.getConnection();
        Statement pst = connection.createStatement();

        if (condicao != null || !condicao.trim().isEmpty()) {
            filtro = condicao;
        }
        if (situacao.trim().equals("Ativos")) {
            filtro2 = " AND EMP.TG_INATIVO = 0";
        } else if (situacao.trim().equals("Inativos")) {
            filtro2 = " AND EMP.TG_INATIVO = 1";
        }

        ResultSet resultado = pst.executeQuery(
                "SELECT EMP.* FROM TB_EMPRESA AS EMP "
                + "WHERE EMP.EMPRESA LIKE'%" + filtro + "%'" + filtro2 + ";");

        while (resultado.next()) {

            Empresa emp = new Empresa();

            emp.setId(resultado.getInt("PK_ID"));
            emp.setEmpresa(resultado.getString("EMPRESA"));
            emp.setDiretor(resultado.getString("DIRETOR"));
            emp.setCnpj(resultado.getString("NR_CNPJ"));
            emp.setEndereco(resultado.getString("ENDERECO"));
            emp.setCidade(resultado.getString("CIDADE"));
            emp.setBairro(resultado.getString("BAIRRO"));
            emp.setCep(resultado.getString("CEP"));
            emp.setUf(resultado.getString("UF"));
            emp.setEmail(resultado.getString("EMAIL"));
            emp.setTelefone(resultado.getString("TELEFONE"));
            emp.setInativo(resultado.getInt("TG_INATIVO"));

            listarEmp.add(emp);
        }
        if (pst != null && !pst.isClosed()) {
            pst.close();
        }
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
        return listarEmp;
    }

    public static boolean inativar(Empresa emp)
            throws SQLException, Exception {

        String sqlComando = "";
        
        if (emp.getInativo() == 0) {
            sqlComando = "UPDATE TB_EMPRESA SET TG_INATIVO = 1, DH_ALTERACAO= NOW() WHERE PK_ID = ?";
        } else {
            sqlComando = "UPDATE TB_EMPRESA SET TG_INATIVO = 0, DH_ALTERACAO= NOW() WHERE PK_ID = ?";
        }

        Connection connection = ConnectionUtils.getConnection();
        PreparedStatement pst = connection.prepareStatement(sqlComando);

        pst.setInt(1, emp.getId());

        try {
            pst.execute();
            pst.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    public static boolean setRegistro(Empresa emp) throws Exception, ClassNotFoundException, SQLException {
        if (emp.getId() == 0) {
            return insert(emp);
        } else {
            return update(emp);
        }
    }

    public static Empresa getById(int id) throws Exception, ClassNotFoundException, SQLException {

        Empresa emp = new Empresa();

        Connection connection = ConnectionUtils.getConnection();

        Statement st = connection.createStatement();

        ResultSet resultado = st.executeQuery("SELECT * FROM TB_EMPRESA WHERE PK_ID = " + id);

        while (resultado.next()) {
            emp.setId(resultado.getInt("PK_ID"));
            emp.setEmpresa(resultado.getString("EMPRESA"));
            emp.setDiretor(resultado.getString("DIRETOR"));
            emp.setCnpj(resultado.getString("NR_CNPJ"));
            emp.setEndereco(resultado.getString("ENDERECO"));
            emp.setCidade(resultado.getString("CIDADE"));
            emp.setBairro(resultado.getString("BAIRRO"));
            emp.setCep(resultado.getString("CEP"));
            emp.setUf(resultado.getString("UF"));
            emp.setEmail(resultado.getString("EMAIL"));
            emp.setTelefone(resultado.getString("TELEFONE"));
            emp.setInativo(resultado.getInt("TG_INATIVO"));
        }

        return emp;
    }

}
