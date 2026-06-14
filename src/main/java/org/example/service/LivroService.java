package org.example.service;

import org.example.model.Livro;
import org.example.repository.LivroRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LivroService {

    private final LivroRepository LivroRepository;

    public LivroService(LivroRepository repository) {
        this.LivroRepository = repository;
    }

    public Livro cadastrar(Livro livro) throws Exception {

        if (livro.getTitulo() == null || livro.getTitulo().isEmpty()) {
            throw new Exception("Título é obrigatório!");
        }

        if (livro.getQuantidadeTotal() <= 0) {
            throw new Exception("Quantidade deve ser maior que zero!");
        }

        if (livro.getCategoria() == null) {
            throw new Exception("Livro deve ter categoria!");
        }

        if (livro.getAutores() == null || livro.getAutores().isEmpty()) {
            throw new Exception("Livro deve ter pelo menos um autor!");
        }

        if (LivroRepository.existsByIsbn(livro.getIsbn())) {
            throw new Exception("ISBN já cadastrado!");
        }

        // regra do sistema
        livro.setQuantidadeDisponivel(livro.getQuantidadeTotal());

        return LivroRepository.save(livro);
    }

    public List<Livro> listar() {
        return LivroRepository.findAll();
    }

    public List<Livro> buscar(String titulo, Boolean disponivel) {

        if (titulo != null && !titulo.isEmpty()) {
            return LivroRepository.findByTituloContainingIgnoreCase(titulo);
        }

        if (disponivel != null && disponivel) {
            return LivroRepository.findByQuantidadeDisponivelGreaterThan(0);
        }

        return LivroRepository.findAll();
    }
}