package br.com.senac.pi3.pwda.servico;

import br.com.senac.pi3.pwda.dao.DaoVenda;
import br.com.senac.pi3.pwda.model.ItemVenda;
import br.com.senac.pi3.pwda.model.Venda;
import br.com.senac.pi3.pwda.validador.ValidarVenda;

public class ServicoVenda {
    
    public static String cadastrarVenda(Venda venda) {
        String resposta = null;
       
        resposta = ValidarVenda.validar(venda);
        if (resposta == null) {
            try {
              DaoVenda.inserir(venda);

            } catch (Exception e) {
                e.printStackTrace();
                resposta = "Erro na fonte de dados";
            }

        }
        return resposta;
    }

    public static String cadastrarItemVenda(ItemVenda itemVenda) {
        String resposta = null;
        resposta = ValidarVenda.validarItemVenda(itemVenda);

        if (resposta == null) {
            try {
                DaoVenda.inserirItemVenda(itemVenda,0);

            } catch (Exception e) {
                e.printStackTrace();
                resposta = "Erro na fonte de dados";
            }
        }
        return resposta;
    }

    
}
