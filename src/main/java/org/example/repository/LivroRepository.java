package org.example.repository;

import org.example.model.Livro;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LivroRepository extends JpaRepository<Livro, Integer> {

    boolean existsByIsbn(String isbn);
}