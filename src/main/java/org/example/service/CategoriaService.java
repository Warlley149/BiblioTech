package org.example.service;

import org.example.model.Categoria;
import org.example.repository.CategoriaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoriaService {

    private final CategoriaRepository repository;

    public CategoriaService(CategoriaRepository repository) {
        this.repository = repository;
    }

    public void cadastrar(Categoria categoria) throws Exception {

        if (categoria.getNome() == null || categoria.getNome().trim().isEmpty()) {
            throw new Exception("O nome da categoria é obrigatório!");
        }

        repository.save(categoria); // ✅ antes era salvar()
        System.out.println("Categoria '" + categoria.getNome() + "' cadastrada com sucesso!");
    }

    public List<Categoria> listar() {
        return repository.findAll(); // ✅ antes era listarTodas()
    }
}