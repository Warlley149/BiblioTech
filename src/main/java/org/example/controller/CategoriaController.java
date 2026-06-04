package org.example.controller;

import org.example.model.Categoria;
import org.example.service.CategoriaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/categorias")
public class CategoriaController {

    private final CategoriaService service;

    public CategoriaController(CategoriaService service) {
        this.service = service;
    }

    @PostMapping
    public String cadastrar(@RequestBody Categoria categoria) throws Exception {
        service.cadastrar(categoria);
        return "Categoria cadastrada com sucesso!";
    }

    @GetMapping
    public List<Categoria> listar() {
        return service.listar();
    }
}