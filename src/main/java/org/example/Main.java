package org.example;

import org.example.model.Autor;
import org.example.model.Categoria;
import org.example.model.Livro;
import org.example.service.LivroService;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        // 1. Criamos a base (Categoria e Autor)
        Categoria cat = new Categoria();
        cat.setNome("Programação");

        Autor autor = new Autor();
        autor.setId(Integer.parseInt("Robert C. Martin"));

        // 2. Criamos o Livro e associamos a base a ele
        Livro livro = new Livro();
        livro.setTitulo("Clean Code");
        livro.setIsbn("978-0132350884");
        livro.setQuantidadeTotal(5);
        livro.setCategoria(cat); // Vincula categoria

        List<Autor> listaAutores = new ArrayList<>();
        listaAutores.add(autor);
        livro.setAutores(listaAutores); // Vincula autor

        // 3. Tentamos cadastrar via Service
        LivroService livroService = new LivroService();
        try {
            livroService.cadastrar(livro);
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
}