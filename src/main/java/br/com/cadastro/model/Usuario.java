package br.com.cadastro.model;

public class Usuario {
    private Integer id;
    private String nomeUsuario;
    private String cpfCnpj;
    private String email;
    private Integer estadoId;
    private String nomeEstado;
    private String siglaEstado;

    public Usuario() {
    }

    public Usuario(Integer id, String nomeUsuario, String cpfCnpj, String email,
                   Integer estadoId, String nomeEstado, String siglaEstado) {
        this.id = id;
        this.nomeUsuario = nomeUsuario;
        this.cpfCnpj = cpfCnpj;
        this.email = email;
        this.estadoId = estadoId;
        this.nomeEstado = nomeEstado;
        this.siglaEstado = siglaEstado;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNomeUsuario() {
        return nomeUsuario;
    }

    public void setNomeUsuario(String nomeUsuario) {
        this.nomeUsuario = nomeUsuario;
    }

    public String getCpfCnpj() {
        return cpfCnpj;
    }

    public void setCpfCnpj(String cpfCnpj) {
        this.cpfCnpj = cpfCnpj;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getEstadoId() {
        return estadoId;
    }

    public void setEstadoId(Integer estadoId) {
        this.estadoId = estadoId;
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
