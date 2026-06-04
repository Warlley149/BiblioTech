package org.example.controller;

import org.example.model.Livro;
import org.example.service.LivroService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/livros")
public class LivroController {

    private final LivroService service;

    public LivroController(LivroService service) {
        this.service = service;
    }

    @PostMapping
    public Livro cadastrar(@RequestBody Livro livro) throws Exception {
        return service.cadastrar(livro);
    }

    @GetMapping
    public List<Livro> listar() {
        return service.listar();
    }
}
