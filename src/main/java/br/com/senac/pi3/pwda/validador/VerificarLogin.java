package br.com.senac.pi3.pwda.validador;

import br.com.senac.pi3.pwda.db.utils.ConnectionUtils;
import br.com.senac.pi3.pwda.model.Login;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class VerificarLogin {

    public static boolean CheckLogin(int idFunc) throws ClassNotFoundException, SQLException {
        Login login = new Login();

        Connection connection = ConnectionUtils.getConnection();

        Statement st = connection.createStatement();

        ResultSet rs = st.executeQuery("SELECT * FROM TS_LOGIN WHERE FK_FUNCIONARIO= " + idFunc);

        while (rs.next()) {

            login.setId(rs.getInt("PK_ID"));
            login.setLogin(rs.getString("LOGIN"));
            login.setSenha(rs.getString("SENHA"));
            login.setPermissao(rs.getString("PERMISSAO"));
            login.setEmpresa(rs.getString("EMPRESA"));
            login.setFunc(rs.getInt("FK_FUNCIONARIO"));

        }
        if (login.getLogin() == null || login.getId() == 0) {
            return false;
        }
        return true;

    }
}
