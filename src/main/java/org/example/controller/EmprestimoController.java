package org.example.controller;

import org.example.model.Emprestimo;
import org.example.repository.EmprestimoRepository;
import org.example.service.EmprestimoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/emprestimos")
public class EmprestimoController {

    private final EmprestimoService service;

    public EmprestimoController(EmprestimoService service) {
        this.service = service;
    }

    @PostMapping
    public Emprestimo emprestar(
            @RequestParam Integer usuarioId,
            @RequestParam Integer livroId) throws Exception {

        return service.emprestar(usuarioId, livroId);
    }
    @GetMapping
    public List<Emprestimo> listar() {
        return service.listar();
    }
    @PutMapping("/devolver/{id}")
    public Emprestimo devolver(@PathVariable Integer id) {
        return service.devolver(id);
    }
}
