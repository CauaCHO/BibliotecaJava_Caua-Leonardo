package br.com.cadastro.model;

public class Usuario {
    private Integer id;
    private String nomeUsuario;
    private String cpfCnpj;
    private String email;

    public Usuario() {
    }

    public Usuario(Integer id, String nomeUsuario, String cpfCnpj, String email) {
        this.id = id;
        this.nomeUsuario = nomeUsuario;
        this.cpfCnpj = cpfCnpj;
        this.email = email;
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
}
