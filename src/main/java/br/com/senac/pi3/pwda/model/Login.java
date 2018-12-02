package br.com.senac.pi3.pwda.model;

import java.io.Serializable;
import org.mindrot.jbcrypt.BCrypt;

public class Login implements Serializable {

    private int id;
    private int func;
    private int idEmp;
    private int autorizar;
    private String login;
    private String senha;
    private String permissao;
    private String empresa;
    private int inativo;

    public Login() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFunc() {
        return func;
    }

    public void setFunc(int func) {
        this.func = func;
    }

    public int getIdEmp() {
        return idEmp;
    }

    public void setIdEmp(int idEmp) {
        this.idEmp = idEmp;
    }
    

    public int getAutorizar() {
        return autorizar;
    }

    public void setAutorizar(int autorizar) {
        this.autorizar = autorizar;
    }

    public String getPermissao() {
        return permissao;
    }

    public void setPermissao(String permissao) {
        this.permissao = permissao;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = BCrypt.hashpw(senha, BCrypt.gensalt());
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public int getInativo() {
        return inativo;
    }

    public void setInativo(int inativo) {
        this.inativo = inativo;
    }

}
