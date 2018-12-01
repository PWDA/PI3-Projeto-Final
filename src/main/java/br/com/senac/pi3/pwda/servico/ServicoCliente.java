package br.com.senac.pi3.pwda.servico;

import br.com.senac.pi3.pwda.dao.DaoCliente;
import br.com.senac.pi3.pwda.model.Pessoa;
import br.com.senac.pi3.pwda.validador.ValidarDados;
import java.util.List;


public class ServicoCliente {    

    public static boolean insertCli(Pessoa cli) throws Exception {
        try {
           boolean resposta = ValidarDados.validarCli(cli);
           
           if (resposta == true){
               DaoCliente.setRegistro(cli);
           }
           
        } catch (Exception ex) {
            throw new Exception("Erro na fonte de dados. \n\n" + ex.getMessage());
        }

        return true;
    }

    public static List<Pessoa> getList(String condicao, String situacao) throws Exception {

        List<Pessoa> listCli;

        try {
            listCli = DaoCliente.selectAll(condicao, situacao);
        } catch (Exception ex) {
            throw new Exception("Falha para consultar registros. \n\n" + ex.getMessage());
        }

        return listCli;
    }

    public static Pessoa getById(int id) throws Exception {

        Pessoa cli;

        try {
            cli = DaoCliente.getById(id);
        } catch (Exception ex) {
            throw new Exception("Falha para consultar registro. \n\n" + ex.getMessage());
        }

        return cli;
    }

    public static boolean deleteRegistro(int id) throws Exception {
        return deleteRegistro(getById(id));
    }

    public static boolean deleteRegistro(Pessoa cli) throws Exception {
        if (cli.getId() == 0) {
            throw new Exception("Nenhum registro selecionado para a exclusão.");
        }

        try {
            DaoCliente.inativar(cli);
        } catch (Exception ex) {
            throw new Exception("Falha para deletar registro. \n\n O mesmo contém outros registros vinculados ou a conexão com o servidor foi perdida. \n\n " + ex.getMessage());
        }

        return true;
    }
    
}
