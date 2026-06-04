package org.example.repository;

import org.example.model.Categoria;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class CategoriaRepository {

    private List<Categoria> categorias = new ArrayList<>();
    private int proximoId = 1;

    public void salvar(Categoria categoria) {
        categoria.setId(proximoId++);
        categorias.add(categoria);
    }

    public List<Categoria> listarTodas() {
        return categorias;
    }
}