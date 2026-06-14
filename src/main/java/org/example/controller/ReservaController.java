package org.example.controller;

import org.example.model.Reserva;
import org.example.service.ReservaService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/reservas")
public class ReservaController {

    private final ReservaService service;

    public ReservaController(ReservaService service) {
        this.service = service;
    }

    @PostMapping
    public Reserva reservar(@RequestParam Integer usuarioId,
                            @RequestParam Integer livroId) {
        return service.reservar(usuarioId, livroId);
    }
}