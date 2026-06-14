package org.example.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "RESERVA", schema = "biblioteca")
public class Reserva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reserva")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_usuario")
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "id_livro")
    private Livro livro;

    private LocalDateTime dataReserva;

    private String statusReserva;

    private Integer posicaoFila;

    public Reserva() {
        this.dataReserva = LocalDateTime.now();
        this.statusReserva = "ATIVA";
    }

    // getters e setters

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public void setLivro(Livro livro) {
        this.livro = livro;
    }

    public void setPosicaoFila(Integer posicaoFila) {
        this.posicaoFila = posicaoFila;
    }
    public Usuario getUsuario() {
        return usuario;
    }

    public Livro getLivro() {
        return livro;
    }

    public Integer getPosicaoFila() {
        return posicaoFila;
    }

    public String getStatusReserva() {
        return statusReserva;
    }
    
}