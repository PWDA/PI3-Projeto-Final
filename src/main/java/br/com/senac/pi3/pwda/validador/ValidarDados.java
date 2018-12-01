package br.com.senac.pi3.pwda.validador;

import br.com.senac.pi3.pwda.dao.DaoCliente;
import br.com.senac.pi3.pwda.model.Empresa;
import br.com.senac.pi3.pwda.model.Funcionario;
import br.com.senac.pi3.pwda.model.Pessoa;
import br.com.senac.pi3.pwda.model.Produto;


public class ValidarDados {

    public static boolean validarFunc(Funcionario func) throws Exception {

        if (func.getNome().trim().isEmpty()) {
            throw new Exception("Atenção! Nome do Funcionario não preenchido.");
        }

        if (func.getNumDocumento().trim().isEmpty()) {
            throw new Exception("Atenção! Número de Cpf não preenchido.");
        }

        if (!ValidarDocumentos.isValidDocument(func.getTagPessoa(), func.getNumDocumento())) {
            throw new Exception("Atenção! Número do documento inválido.");
        }

        return true;
    }
        public static boolean validarEmp(Empresa emp) throws Exception {

        if (emp.getEmpresa().trim().isEmpty()) {
            throw new Exception("Atenção! Empresa não preenchido.");
        }

        if (emp.getCnpj().trim().isEmpty()) {
            throw new Exception("Atenção! CNPJ não preenchido.");
        }

        if (!ValidarDocumentos.isValidDocument("J", emp.getCnpj())) {
            throw new Exception("Atenção! CNPJ inválido.");
        }

        return true;
    }
    
    public static boolean validarProd(Produto prod) throws Exception {


        return true;
    }
        
     public static boolean validarCli(Pessoa cli) throws Exception {

        if (cli.getNome().trim().isEmpty()) {
            throw new Exception("Atenção! Nome do Funcionario não preenchido.");
        }

        if (cli.getNumDocumento().trim().isEmpty()) {
            throw new Exception("Atenção! Número de Cpf não preenchido.");
        }

        if (!ValidarDocumentos.isValidDocument(cli.getTagPessoa(), cli.getNumDocumento())) {
            throw new Exception("Atenção! Número do documento inválido.");
        }

        try {
            DaoCliente.setRegistro(cli);
        } catch (Exception ex) {
            throw new Exception("Falha para salvar registro. \n\n" + ex.getMessage());
        }

        return true;
    }
}
