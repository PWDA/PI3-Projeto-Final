package br.com.senac.pi3.pwda.model;

public class Funcionario  extends Pessoa{
    
    private Integer registro;
    private String departamento;
    private String cargo;
    private int idLogin;

    public Funcionario(int id) {
        super(id);
    }
    
    public Funcionario() {
    }

    public int getRegistro() {
        return registro;
    }

    public void setRegistro(int registro) {
        this.registro = registro;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String funcao) {
        this.cargo = funcao;
    } 

    public int getIdLogin() {
        return idLogin;
    }

    public void setIdLogin(int idLogin) {
        this.idLogin = idLogin;
    }
    
}

