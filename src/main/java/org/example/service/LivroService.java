package org.example.service;

import org.example.model.Livro;
import org.example.repository.LivroRepository;

public class LivroService {
    private LivroRepository repository = new LivroRepository();

    public void cadastrar(Livro livro) throws Exception {
        // Validações obrigatórias
        if (livro.getTitulo() == null || livro.getTitulo().trim().isEmpty()) {
            throw new Exception("Erro: Título é obrigatório!");
        }
        if (livro.getIsbn() == null || livro.getIsbn().isEmpty()) {
            throw new Exception("Erro: ISBN é obrigatório!");
        }
        if (livro.getQuantidadeTotal() <= 0) {
            throw new Exception("Erro: Quantidade total deve ser maior que zero!");
        }
        if (livro.getCategoria() == null) {
            throw new Exception("Erro: O livro deve ter uma categoria!");
        }
        if (livro.getAutores() == null || livro.getAutores().isEmpty()) {
            throw new Exception("Erro: O livro deve ter pelo menos um autor!");
        }
        if (repository.existeIsbn(livro.getIsbn())) {
            throw new Exception("Erro: Este ISBN já está cadastrado!");
        }

        repository.salvar(livro);
        System.out.println("Livro '" + livro.getTitulo() + "' cadastrado com sucesso!");
    }
}