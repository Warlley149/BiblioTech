package org.example.service;

import org.example.enums.StatusUsuario;
import org.example.model.Usuario;
import org.example.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {

    private final UsuarioRepository repository;

    public UsuarioService(UsuarioRepository repository) {
        this.repository = repository;
    }

    public Usuario salvar(Usuario usuario) {

        // ✅ REGRA DE NEGÓCIO AQUI
        if (usuario.getStatusUsuario() != StatusUsuario.ATIVO) {
            throw new RuntimeException("Usuário precisa estar ATIVO para ser cadastrado.");
        }

        return repository.save(usuario);
    }

    public List<Usuario> listar() {
        return repository.findAll();
    }

    public Usuario buscarPorId(Integer id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
    }

    public Usuario atualizar(Integer id, Usuario usuario) {
        Usuario existente = buscarPorId(id);

        existente.setNomeCompleto(usuario.getNomeCompleto());
        existente.setEmail(usuario.getEmail());
        existente.setTelefone(usuario.getTelefone());
        existente.setMatricula(usuario.getMatricula());
        existente.setTipoUsuario(usuario.getTipoUsuario());
        existente.setStatusUsuario(usuario.getStatusUsuario());

        return repository.save(existente);
    }

    public void deletar(Integer id) {
        repository.deleteById(id);
    }

}