package br.com.cadastro.model;

public class Estado {
    private Integer id;
    private String nomeEstado;
    private String siglaEstado;

    public Estado() {
    }

    public Estado(Integer id, String nomeEstado, String siglaEstado) {
        this.id = id;
        this.nomeEstado = nomeEstado;
        this.siglaEstado = siglaEstado;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNomeEstado() {
        return nomeEstado;
    }

    public void setNomeEstado(String nomeEstado) {
        this.nomeEstado = nomeEstado;
    }

    public String getSiglaEstado() {
        return siglaEstado;
    }

    public void setSiglaEstado(String siglaEstado) {
        this.siglaEstado = siglaEstado;
    }
}
