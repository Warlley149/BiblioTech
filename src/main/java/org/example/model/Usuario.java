package org.example.model;

import org.example.enums.TipoUsuario;
import org.example.enums.StatusUsuario;

public class Usuario {
    private int id;
    private String nomeCompleto;
    private String email;
    private String telefone;
    private String matricula;
    private TipoUsuario tipoUsuario;
    private StatusUsuario statusUsuario;

    public Usuario() {}

    public Usuario(int id, String nomeCompleto, String email, String telefone, String matricula, TipoUsuario tipoUsuario, StatusUsuario statusUsuario) {
        this.id = id;
        this.nomeCompleto = nomeCompleto;
        this.email = email;
        this.telefone = telefone;
        this.matricula = matricula;
        this.tipoUsuario = tipoUsuario;
        this.statusUsuario = statusUsuario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public void setNomeCompleto(String nomeCompleto) {
        this.nomeCompleto = nomeCompleto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public TipoUsuario getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(TipoUsuario tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public StatusUsuario getStatusUsuario() {
        return statusUsuario;
    }

    public void setStatusUsuario(StatusUsuario statusUsuario) {
        this.statusUsuario = statusUsuario;
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nomeCompleto='" + nomeCompleto + '\'' +
                ", email='" + email + '\'' +
                ", telefone='" + telefone + '\'' +
                ", matricula='" + matricula + '\'' +
                ", tipoUsuario=" + tipoUsuario +
                ", statusUsuario=" + statusUsuario +
                '}';
    }

}
