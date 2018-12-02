package br.com.senac.pi3.pwda.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Venda {
    
    private int codigoVenda;
    private Date dataVenda;
    private Double valorTotal;
    private List<ItemVenda> itens;
    private int IdCliente;
    private int idCaixa;
    private int quantidade;
    private int empresa;
    
    public Venda() {
        this.itens = new ArrayList<ItemVenda>();
    }

    public int getCodigoVenda() {
        return codigoVenda;
    }

    public void setCodigoVenda(int codigoVenda) {
        this.codigoVenda = codigoVenda;
    }

    public Date getDataVenda() {
        return dataVenda;
    }

    public void setDataVenda(Date dataVenda) {
        this.dataVenda = dataVenda;
    }

    public Double getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(Double valorTotal) {
        this.valorTotal = valorTotal;
    }

    public List<ItemVenda> getItens() {
        return itens;
    }

    public void setItens(List<ItemVenda> itens) {
        this.itens = itens;
    }

    public int getIdCliente() {
        return IdCliente;
    }

    public void setIdCliente(int IdCliente) {
        this.IdCliente = IdCliente;
    }
    
    public int getIdCaixa() {
        return idCaixa;
    }

    public void setIdCaixa(int idCaixa) {
        this.idCaixa = idCaixa;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }
    
    
//    public Double getCalcularTotal() {
//        double total = 0;
//        for (ItemVenda iv : itens) {
//            total += (iv.getValorUnitario() * iv.getQuantidade());
//        }
//        return total;
//    }

    public int getEmpresa() {
        return empresa;
    }

    public void setEmpresa(int empresa) {
        this.empresa = empresa;
    }
    
}
