package org.example.service;

import org.example.model.Livro;
import org.example.model.Reserva;
import org.example.model.Usuario;
import org.example.repository.LivroRepository;
import org.example.repository.ReservaRepository;
import org.example.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservaService {

    private final ReservaRepository repository;
    private final LivroRepository livroRepository;
    private final UsuarioRepository usuarioRepository;

    public ReservaService(ReservaRepository repository,
                          LivroRepository livroRepository,
                          UsuarioRepository usuarioRepository) {
        this.repository = repository;
        this.livroRepository = livroRepository;
        this.usuarioRepository = usuarioRepository;
    }

    public Reserva reservar(Integer usuarioId, Integer livroId) {

        Livro livro = livroRepository.findById(livroId)
                .orElseThrow(() -> new RuntimeException("Livro não encontrado"));

        if (livro.getQuantidadeDisponivel() > 0) {
            throw new RuntimeException("Livro disponível, não precisa reservar");
        }

        Usuario usuario = usuarioRepository.findById(usuarioId)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        List<Reserva> fila = repository.findByLivroIdOrderByDataReserva(livroId);

        Reserva reserva = new Reserva();
        reserva.setUsuario(usuario);
        reserva.setLivro(livro);
        reserva.setPosicaoFila(fila.size() + 1);

        return repository.save(reserva);
    }
}