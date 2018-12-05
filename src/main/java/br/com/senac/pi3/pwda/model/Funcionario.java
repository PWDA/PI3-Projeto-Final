package br.com.senac.pi3.pwda.model;

public class Funcionario  extends Pessoa{
    
    private String departamento;
    private String cargo;
    private int idLogin;
    private int idEmpresa;
    private String empresa;

    public Funcionario(int id) {
        super(id);
    }
    
    public Funcionario() {
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

    public int getIdEmpresa() {
        return idEmpresa;
    }

    public void setIdEmpresa(int idEmpresa) {
        this.idEmpresa = idEmpresa;
    }
    

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }
    
    
}

