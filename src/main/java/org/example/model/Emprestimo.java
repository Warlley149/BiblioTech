package org.example.model;

import jakarta.persistence.*;
import org.example.enums.StatusEmprestimo;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "EMPRESTIMO", schema = "biblioteca")
public class Emprestimo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_emprestimo")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "id_livro", nullable = false)
    private Livro livro;

    @Column(name = "data_emprestimo")
    private LocalDateTime dataEmprestimo;

    @Column(name = "data_prevista_devolucao")
    private LocalDate dataPrevistaDevolucao;

    @Column(name = "data_devolucao")
    private LocalDateTime dataDevolucao;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_emprestimo")
    private StatusEmprestimo statusEmprestimo;

    @Column(name = "dias_atraso")
    private Integer diasAtraso;

    @Column(name = "valor_multa")
    private Double valorMulta;

    public Emprestimo() {
        this.dataEmprestimo = LocalDateTime.now();
        this.dataPrevistaDevolucao = LocalDate.now().plusDays(7);
        this.statusEmprestimo = StatusEmprestimo.EM_ABERTO;
        /*this.diasAtraso = 0;
        this.valorMulta = 0.0;*/
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public Livro getLivro() {
        return livro;
    }

    public StatusEmprestimo getStatusEmprestimo() {
        return statusEmprestimo;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public void setLivro(Livro livro) {
        this.livro = livro;
    }

    public void setStatusEmprestimo(StatusEmprestimo statusEmprestimo) {
        this.statusEmprestimo = statusEmprestimo;
    }

    // getters e setters

    public void setDataDevolucao(LocalDateTime dataDevolucao) {
        this.dataDevolucao = dataDevolucao;
    }

    public void setDiasAtraso(Integer diasAtraso) {
        this.diasAtraso = diasAtraso;
    }

    public void setValorMulta(Double valorMulta) {
        this.valorMulta = valorMulta;
    }

    public LocalDate getDataPrevistaDevolucao() {
        return dataPrevistaDevolucao;
    }

    public Integer getDiasAtraso() {
        return diasAtraso;
    }

    public Double getValorMulta() {
        return valorMulta;
    }
}