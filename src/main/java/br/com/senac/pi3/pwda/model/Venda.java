package br.com.senac.pi3.pwda.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Venda {
    
    private int codigoVenda;
    private Date dataVenda;
    private Double valorTotal;
    private List<ItemVenda> itens;
    private Pessoa cliente;
    
    public Venda() {
        this.itens = new ArrayList<ItemVenda>();
        this.cliente = new Pessoa();
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

    public Pessoa getCliente() {
        return cliente;
    }

    public void setCliente(Pessoa cliente) {
        this.cliente = cliente;
    }
    
    
    public Double getCalcularTotal() {
        double total = 0;
        for (ItemVenda iv : itens) {
            total += (iv.getValorUnitario() * iv.getQuantidade());
        }
        return total;
    }
    
}
