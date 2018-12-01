package br.com.senac.pi3.pwda.servico;

import br.com.senac.pi3.pwda.dao.DaoLogin;
import br.com.senac.pi3.pwda.model.Login;
import org.mindrot.jbcrypt.BCrypt;

public class ServicoLogin {

    public static boolean insertLogin(Login login) throws Exception {
        try {
            DaoLogin.setRegistro(login);

        } catch (Exception ex) {
            throw new Exception("Erro na fonte de dados. \n\n" + ex.getMessage());
        }

        return true;
    }

    public static Login getById(int id) throws Exception {

        Login login;

        try {
            login = DaoLogin.getById(id);
        } catch (Exception ex) {
            throw new Exception("Falha para consultar registro. \n\n" + ex.getMessage());
        }

        return login;
    }

    public static Login validarLogin(String login, String senha) throws Exception {
        Login usuario = DaoLogin.validarLogin(login, senha);
        

        if (usuario.getId() == 0 && !BCrypt.checkpw(senha.trim(), usuario.getSenha())){
            throw new Exception("Atenção! Login e/ou Senha incorretos ou usuário inexistente.");
        }

        return usuario;
    }
}
