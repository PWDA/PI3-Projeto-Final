package br.com.senac.pi3.pwda.servico;

import br.com.senac.pi3.pwda.dao.DaoEmpresa;
import br.com.senac.pi3.pwda.model.Empresa;
import br.com.senac.pi3.pwda.validador.ValidarDados;
import java.util.List;

public class ServicoEmpresa {
    public static boolean insertFunc(Empresa emp) throws Exception {
        try {
           boolean resposta = ValidarDados.validarEmp(emp);
           
           if (resposta == true){
               DaoEmpresa.setRegistro(emp);
           }
           
        } catch (Exception ex) {
            throw new Exception("Erro na fonte de dados. \n\n" + ex.getMessage());
        }

        return true;
    }

    public static List<Empresa> getList(String condicao, String situacao) throws Exception {

        List<Empresa> listFunc;

        try {
            listFunc = DaoEmpresa.selectAll(condicao, situacao);
        } catch (Exception ex) {
            throw new Exception("Falha para consultar registros. \n\n" + ex.getMessage());
        }

        return listFunc;
    }

    public static Empresa getById(int id) throws Exception {

        Empresa emp;

        try {
            emp = DaoEmpresa.getById(id);
        } catch (Exception ex) {
            throw new Exception("Falha para consultar registro. \n\n" + ex.getMessage());
        }

        return emp;
    }

    public static boolean deleteRegistro(int id) throws Exception {
        return deleteRegistro(getById(id));
    }

    public static boolean deleteRegistro(Empresa emp) throws Exception {
        if (emp.getId() == 0) {
            throw new Exception("Nenhum registro selecionado para a inativação.");
        }

        try {
            DaoEmpresa.inativar(emp);
        } catch (Exception ex) {
            throw new Exception("Falha para inativar registro. \n\n O mesmo contém outros registros vinculados ou a conexão com o servidor foi perdida. \n\n " + ex.getMessage());
        }

        return true;
    }
}
