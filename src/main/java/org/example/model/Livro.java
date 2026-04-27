package org.example.model;

import java.util.ArrayList;
import java.util.List;

public class Livro {
    private int id;
    private String titulo;
    private String isbn;
    private short anoPublicacao;
    private String editora;
    private int quantidadeTotal;
    private int quantidadeDisponivel;

    // Relacionamentos (O segredo do projeto)
    private Categoria categoria;
    private List<Autor> autores = new ArrayList<>();

    public Livro() {}

    // Getters e Setters
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public int getQuantidadeTotal() { return quantidadeTotal; }
    public void setQuantidadeTotal(int quantidadeTotal) { this.quantidadeTotal = quantidadeTotal; }

    public int getQuantidadeDisponivel() { return quantidadeDisponivel; }
    public void setQuantidadeDisponivel(int quantidadeDisponivel) { this.quantidadeDisponivel = quantidadeDisponivel; }

    public Categoria getCategoria() { return categoria; }
    public void setCategoria(Categoria categoria) { this.categoria = categoria; }

    public List<Autor> getAutores() { return autores; }
    public void setAutores(List<Autor> autores) { this.autores = autores; }

    public short getAnoPublicacao() { return anoPublicacao; }
    public void setAnoPublicacao(short anoPublicacao) { this.anoPublicacao = anoPublicacao; }

    // Adicione os outros que faltarem (id, editora...)
}