package br.com.cadastro.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Livro {
    private Integer id;
    private String nomeLivro;
    private String isbn;
    private String autor;
    private String capaLivro;
    private LocalDate dataPublicacao;
    private BigDecimal valorLivro;
    private Integer categoriaId;
    private String nomeCategoria;

    public Livro() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNomeLivro() {
        return nomeLivro;
    }

    public void setNomeLivro(String nomeLivro) {
        this.nomeLivro = nomeLivro;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getCapaLivro() {
        return capaLivro;
    }

    public void setCapaLivro(String capaLivro) {
        this.capaLivro = capaLivro;
    }

    public LocalDate getDataPublicacao() {
        return dataPublicacao;
    }

    public void setDataPublicacao(LocalDate dataPublicacao) {
        this.dataPublicacao = dataPublicacao;
    }

    public BigDecimal getValorLivro() {
        return valorLivro;
    }

    public void setValorLivro(BigDecimal valorLivro) {
        this.valorLivro = valorLivro;
    }

    public Integer getCategoriaId() {
        return categoriaId;
    }

    public void setCategoriaId(Integer categoriaId) {
        this.categoriaId = categoriaId;
    }

    public String getNomeCategoria() {
        return nomeCategoria;
    }

    public void setNomeCategoria(String nomeCategoria) {
        this.nomeCategoria = nomeCategoria;
    }
}
