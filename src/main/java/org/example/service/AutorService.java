package org.example.service;

import org.example.model.Autor;
import org.example.repository.AutorRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AutorService {

    private final AutorRepository repository;

    public AutorService(AutorRepository repository) {
        this.repository = repository;
    }

    public void cadastrar(Autor autor) throws Exception {

        if (autor.getNome() == null || autor.getNome().isEmpty()) {
            throw new Exception("Nome do autor é obrigatório!");
        }

        repository.save(autor);
    }

    public List<Autor> listar() {
        return repository.findAll();
    }
}