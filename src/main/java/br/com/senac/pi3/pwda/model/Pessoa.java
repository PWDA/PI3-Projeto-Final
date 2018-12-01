package br.com.senac.pi3.pwda.model;

import java.util.Date;

public class Pessoa {
    private int id;
    private String nome;
    private String numDocumento;
    private String telefone;
    private Date dataNasci;
    private String nacionalidade;    
    private String endereco;
    private String bairro;
    private String cidade;
    private String uf;
    private String cep;
    private String email;
    private String tagPessoa;
    private String sexo;
    private int inativo;

    public Pessoa(int id) {
		this.id = id;
	}
    
    public Pessoa() {
    }  
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getNumDocumento() {
        return numDocumento;
    }
    
    
    public void setNumDocumento(String numDocumento) {
        this.numDocumento = numDocumento;
    }
    
    public String getTagPessoa() {
        return tagPessoa;
    }

    public void setTagPessoa(String TagPessoa) {
        this.tagPessoa = TagPessoa;
    }



    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public Date getDataNasci() {
        return dataNasci;
    }

    public void setDataNasci(Date dataNasci) {
        this.dataNasci = dataNasci;
    }

    public String getNacionalidade() {
        return nacionalidade;
    }

    public void setNacionalidade(String nacionalidade) {
        this.nacionalidade = nacionalidade;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public int getInativo() {
        return inativo;
    }

    public void setInativo(int inativo) {
        this.inativo = inativo;
    }
    
}

