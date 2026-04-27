package org.example.repository;

import org.example.model.Livro;
import java.util.ArrayList;
import java.util.List;

public class LivroRepository {
    private List<Livro> livros = new ArrayList<>();
    private int proximoId = 1;

    public void salvar(Livro livro) {
        livro.setQuantidadeDisponivel(livro.getQuantidadeTotal()); // Regra: Inicial = Total
        livros.add(livro);
    }

    public boolean existeIsbn(String isbn) {
        return livros.stream().anyMatch(l -> l.getIsbn().equals(isbn));
    }
}