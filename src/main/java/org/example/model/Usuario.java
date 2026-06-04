package org.example.model;

import jakarta.persistence.*;
import org.example.enums.StatusUsuario;
import org.example.enums.TipoUsuario;

@Entity
@Table(name = "USUARIO", schema = "biblioteca")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Integer id;

    @Column(name = "nome_completo", nullable = false, length = 120)
    private String nomeCompleto;

    @Column(name = "email", nullable = false, unique = true, length = 150)
    private String email;

    @Column(name = "telefone", nullable = false, length = 15)
    private String telefone;

    @Column(name = "matricula", nullable = false, unique = true, length = 20)
    private String matricula;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo_usuario", nullable = false, length = 20)
    private TipoUsuario tipoUsuario;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_usuario", nullable = false, length = 20)
    private StatusUsuario statusUsuario;

    public Usuario() {
    }

    public Usuario(Integer id, String nomeCompleto, String email, String telefone, String matricula,
                   TipoUsuario tipoUsuario, StatusUsuario statusUsuario) {
        this.id = id;
        this.nomeCompleto = nomeCompleto;
        this.email = email;
        this.telefone = telefone;
        this.matricula = matricula;
        this.tipoUsuario = tipoUsuario;
        this.statusUsuario = statusUsuario;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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
}