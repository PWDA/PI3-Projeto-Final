package br.com.senac.pi3.pwda.servico;

import br.com.senac.pi3.pwda.dao.DaoProduto;
import br.com.senac.pi3.pwda.model.Produto;
import br.com.senac.pi3.pwda.validador.ValidarDados;
import java.util.List;

public class ServicoProduto {
    

    public static boolean insertFunc(Produto prod) throws Exception {
        try {
           boolean resposta = ValidarDados.validarProd(prod);
           
           if (resposta == true){
               DaoProduto.setRegistro(prod);
           }
           
        } catch (Exception ex) {
            throw new Exception("Erro na fonte de dados. \n\n" + ex.getMessage());
        }

        return true;
    }

    public static List<Produto> getList(String condicao, String situacao) throws Exception {

        List<Produto> listProd;

        try {
            listProd = DaoProduto.selectAll(condicao, situacao);
        } catch (Exception ex) {
            throw new Exception("Falha para consultar registros. \n\n" + ex.getMessage());
        }

        return listProd;
    }

    public static Produto getById(int id) throws Exception {

        Produto prod;

        try {
            prod = DaoProduto.getById(id);
        } catch (Exception ex) {
            throw new Exception("Falha para consultar registro. \n\n" + ex.getMessage());
        }

        return prod;
    }

    public static boolean deleteRegistro(int id) throws Exception {
        return deleteRegistro(getById(id));
    }

    public static boolean deleteRegistro(Produto prod) throws Exception {
        if (prod.getId() == 0) {
            throw new Exception("Nenhum registro selecionado para a exclusão.");
        }

        try {
            DaoProduto.inativar(prod);
        } catch (Exception ex) {
            throw new Exception("Falha para deletar registro. \n\n O mesmo contém outros registros vinculados ou a conexão com o servidor foi perdida. \n\n " + ex.getMessage());
        }

        return true;
    }
    
}
