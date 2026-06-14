package org.example.repository;

import org.example.model.Livro;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LivroRepository extends JpaRepository<Livro, Integer> {

    boolean existsByIsbn(String isbn);

    // ✅ buscar por título (contém)
    List<Livro> findByTituloContainingIgnoreCase(String titulo);

    // ✅ livros disponíveis (estoque > 0)
    List<Livro> findByQuantidadeDisponivelGreaterThan(int quantidade);

}