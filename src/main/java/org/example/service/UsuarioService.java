package org.example.service;

import org.example.exception.ValidacaoException;
import org.example.model.Usuario;
import org.example.repository.UsuarioRepository;

public class UsuarioService {

    private UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public String cadastrarUsuario(Usuario usuario) {
        validarNome(usuario.getNomeCompleto());
        validarEmail(usuario.getEmail());
        validarTelefone(usuario.getTelefone());
        validarEmailUnico(usuario.getEmail());
        validarMatriculaUnica(usuario.getMatricula());

        usuarioRepository.salvar(usuario);

        return "Usuário cadastrado com sucesso.";
    }

    private void validarNome(String nome) {
        if (nome == null || nome.trim().isEmpty()) {
            throw new ValidacaoException("Nome não pode ser vazio.");
        }
    }

    private void validarEmail(String email) {
        if (email == null || email.trim().isEmpty() || !email.contains("@")) {
            throw new ValidacaoException("Email inválido.");
        }
    }

    private void validarTelefone(String telefone) {
        if (telefone == null || telefone.trim().isEmpty()) {
            throw new ValidacaoException("Telefone obrigatório.");
        }

        if (!telefone.matches("[0-9()\\-\\s]+")) {
            throw new ValidacaoException("Telefone contém caracteres inválidos.");
        }
    }

    private void validarEmailUnico(String email) {
        if (usuarioRepository.buscarPorEmail(email) != null) {
            throw new ValidacaoException("Email já cadastrado.");
        }
    }

    private void validarMatriculaUnica(String matricula) {
        if (usuarioRepository.buscarPorMatricula(matricula) != null) {
            throw new ValidacaoException("Matrícula já cadastrada.");
        }
    }

    private void validarMatricula(String matricula) {
        if (matricula == null || matricula.trim().isEmpty()) {
            throw new ValidacaoException("Matrícula obrigatória.");
        }
    }

    private void validarTipoUsuario(Object tipoUsuario) {
        if (tipoUsuario == null) {
            throw new ValidacaoException("Tipo de usuário obrigatório.");
        }
    }

    private void validarStatusUsuario(Object statusUsuario) {
        if (statusUsuario == null) {
            throw new ValidacaoException("Status do usuário obrigatório.");
        }
    }
}