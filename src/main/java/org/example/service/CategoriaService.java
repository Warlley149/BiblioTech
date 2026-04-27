package org.example.service;

import org.example.model.Categoria;
import org.example.repository.CategoriaRepository;

public class CategoriaService {
    private CategoriaRepository repository = new CategoriaRepository();

    public void cadastrar(Categoria categoria) throws Exception {
        // Validação obrigatória da Etapa 1
        if (categoria.getNome() == null || categoria.getNome().trim().isEmpty()) {
            throw new Exception("O nome da categoria é obrigatório!");
        }

        repository.salvar(categoria);
        System.out.println("Categoria '" + categoria.getNome() + "' cadastrada com sucesso!");
    }
}
