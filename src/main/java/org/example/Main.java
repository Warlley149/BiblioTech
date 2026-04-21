package org.example;

import org.example.enums.StatusUsuario;
import org.example.enums.TipoUsuario;
import org.example.exception.ValidacaoException;
import org.example.model.Usuario;
import org.example.repository.UsuarioRepository;
import org.example.service.UsuarioService;

public class Main {

    /*TESTE DE USUÁRIO*/

    public static void main(String[] args) {

        UsuarioRepository usuarioRepository = new UsuarioRepository();
        UsuarioService usuarioService = new UsuarioService(usuarioRepository);

        Usuario usuario = new Usuario();
        usuario.setNomeCompleto("João da Silva");
        usuario.setEmail("joao@email.com");
        usuario.setTelefone("(81) 99999-9999");
        usuario.setMatricula("2026001");
        usuario.setTipoUsuario(TipoUsuario.ALUNO);
        usuario.setStatusUsuario(StatusUsuario.ATIVO);

        try {
            String mensagem = usuarioService.cadastrarUsuario(usuario);
            System.out.println(mensagem);
        } catch (ValidacaoException e) {
            System.out.println("Erro ao cadastrar usuário: " + e.getMessage());
        }
    }
}