package org.example.repository;

import org.example.model.Autor;

import java.util.ArrayList;
import java.util.List;

public class AutorRepository {
    private List<Autor> autores = new ArrayList<>();
    private int proximoId = 1;

    public void salvar(Autor autor) {
        autor.setId(proximoId++);
        autores.add(autor);
    }

    public List<Autor> listarTodos() {
        return autores;
    }
}