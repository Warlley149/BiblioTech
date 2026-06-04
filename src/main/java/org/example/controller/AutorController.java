package org.example.controller;

import org.example.model.Autor;
import org.example.service.AutorService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/autores")
public class AutorController {

    private final AutorService service;

    public AutorController(AutorService service) {
        this.service = service;
    }

    @PostMapping
    public String cadastrar(@RequestBody Autor autor) throws Exception {
        service.cadastrar(autor);
        return "Autor cadastrado com sucesso!";
    }

    @GetMapping
    public List<Autor> listar() {
        return service.listar();
    }
}