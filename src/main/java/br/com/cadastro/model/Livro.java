package br.com.cadastro.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Livro {
    private Integer id;
    private String nomeLivro;
    private String isbn;
    private String autor;
    private String email;
    private String capaLivro;
    private LocalDate dataPublicacao;
    private BigDecimal valorLivro;

    public Livro() {
    }

    public Livro(Integer id, String nomeLivro, String isbn, String autor, String email, String capaLivro, LocalDate dataPublicacao, BigDecimal valorLivro) {
        this.id = id;
        this.nomeLivro = nomeLivro;
        this.isbn = isbn;
        this.autor = autor;
        this.email = email;
        this.capaLivro = capaLivro;
        this.dataPublicacao = dataPublicacao;
        this.valorLivro = valorLivro;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
}
