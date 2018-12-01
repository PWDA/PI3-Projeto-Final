package br.com.senac.pi3.pwda.model;

public class ItemVenda {
    private int codigoItemVenda;
    private Produto produto;
    private int quantidade;
    private Double valorUnitario;
    private int codigoVenda;

    public ItemVenda() {
//        this.codigoItemVenda = 0;
        this.produto = new Produto();
//        this.quantidade = 0;
//        this.valorUnitario = 0.0;
//        this.codigoVenda = 0;
    }

    public int getCodigoItemVenda() {
        return codigoItemVenda;
    }

    public void setCodigoItemVenda(int codigoItemVenda) {
        this.codigoItemVenda = codigoItemVenda;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public Double getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(Double valorUnitario) {
        this.valorUnitario = valorUnitario;
    }

    public int getCodigoVenda() {
        return codigoVenda;
    }

    public void setCodigoVenda(int codigoVenda) {
        this.codigoVenda = codigoVenda;
    }           
    
}
