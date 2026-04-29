package br.com.cadastro.model;

import java.math.BigDecimal;

public class Livro {
    private String id;
    private String nomeLivro;
    private String isbn;
    private String autor;
    private String dataPublicacao;
    private BigDecimal valorLivro;

    public Livro() {}

    public Livro(String id, String nomeLivro, String isbn, String autor, String dataPublicacao, BigDecimal valorLivro) {
        this.id = id;
        this.nomeLivro = nomeLivro;
        this.isbn = isbn;
        this.autor = autor;
        this.dataPublicacao = dataPublicacao;
        this.valorLivro = valorLivro;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getNomeLivro() { return nomeLivro; }
    public void setNomeLivro(String nomeLivro) { this.nomeLivro = nomeLivro; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public String getAutor() { return autor; }
    public void setAutor(String autor) { this.autor = autor; }

    public String getDataPublicacao() { return dataPublicacao; }
    public void setDataPublicacao(String dataPublicacao) { this.dataPublicacao = dataPublicacao; }

    public BigDecimal getValorLivro() { return valorLivro; }
    public void setValorLivro(BigDecimal valorLivro) { this.valorLivro = valorLivro; }
}
