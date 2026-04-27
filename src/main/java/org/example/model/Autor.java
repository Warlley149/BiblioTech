package org.example.model;

import java.time.LocalDate;

public class Autor { // Verifique se aqui está 'Autor' e não 'Altor'
    private int id;
    private String nome;
    private String nacionalidade;
    private LocalDate dataNascimento;
    private boolean statusAtivo;

    public Autor() {
        this.statusAtivo = true;
    }

    public void setId(int i) {
    }
}