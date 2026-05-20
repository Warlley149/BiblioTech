package org.example;

import org.example.enums.StatusUsuario;
import org.example.enums.TipoUsuario;
import org.example.exception.ValidacaoException;
import org.example.model.Autor;
import org.example.model.Categoria;
import org.example.model.Livro;
import org.example.model.Usuario;
import org.example.repository.UsuarioRepository;
import org.example.service.LivroService;
import org.example.service.UsuarioService;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {

        /*PARTE 1 - TESTE DE USUÁRIO*/

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


        //----------------------------------


        /*PARTE 2 - CRIAÇÃO DE LIVRO*/

        // 1. Criamos a base (Categoria e Autor)
        Categoria cat = new Categoria();
        cat.setNome("Programação");

        Autor autor = new Autor();
        autor.setNome("Robert C. Martin"); // <-- O nome vai aqui, e é uma String!

        // 2. Criamos o Livro e associamos a base a ele
        Livro livro = new Livro();
        livro.setTitulo("Clean Code");
        livro.setIsbn("978-0132350884");
        livro.setQuantidadeTotal(5);
        livro.setCategoria(cat); // Vincula categoria

        List<Autor> listaAutores = new ArrayList<>();
        listaAutores.add(autor);
        livro.setAutores(listaAutores); // Vincula autor

        // 3. Tentamos cadastrar via Service
        LivroService livroService = new LivroService();
        try {
            livroService.cadastrar(livro);
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
}