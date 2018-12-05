package br.com.senac.pi3.pwda.model;

public class Relatorio {
    private int codigo;
    private String produto;
    private int qtdComprado;
    private float valorUnitario;
    private float valorTotal;
    private String dataCompra;
    private float totFaturado;
    private String empresa;
    private String cliente;

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getProduto() {
        return produto;
    }

    public void setProduto(String produto) {
        this.produto = produto;
    }

    public int getQtdComprado() {
        return qtdComprado;
    }

    public void setQtdComprado(int qtdComprado) {
        this.qtdComprado = qtdComprado;
    }

    public float getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(float valorUnitario) {
        this.valorUnitario = valorUnitario;
    }

    public float getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(float valorTotal) {
        this.valorTotal = valorTotal;
    }

    public String getDataCompra() {
        return dataCompra;
    }

    public void setDataCompra(String dataCompra) {
        this.dataCompra = dataCompra;
    }

    public float getTotFaturado() {
        return totFaturado;
    }

    public void setTotFaturado(float totFaturado) {
        this.totFaturado = totFaturado;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }
    
    

}
