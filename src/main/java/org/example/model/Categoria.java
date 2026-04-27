package org.example.model;

public class Categoria {
    private int id;
    private String nome;
    private String descricao;
    private boolean statusAtivo;

    public Categoria() {
        this.statusAtivo = true; // Categoria nasce ativa por padrão
    }

    // Getters e Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public boolean isStatusAtivo() { return statusAtivo; }
    public void setStatusAtivo(boolean statusAtivo) { this.statusAtivo = statusAtivo; }
}