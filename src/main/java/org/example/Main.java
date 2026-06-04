package org.example;

import org.example.enums.StatusEmprestimo;
import org.example.enums.StatusUsuario;
import org.example.enums.TipoUsuario;
import org.example.exception.ValidacaoException;
import org.example.model.*;
import org.example.repository.EmprestimoRepository;
import org.example.repository.UsuarioRepository;
import org.example.service.EmprestimoService;
import org.example.service.LivroService;


import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {

        /*PARTE 1 - TESTE DE USUÁRIO*/

            /*UsuarioRepository usuarioRepository = new UsuarioRepository();
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
            }*/


        //----------------------------------


        /*PARTE 2 - CRIAÇÃO DE LIVRO*/

        // 1. Criamos a base (Categoria e Autor)
        /*Categoria cat = new Categoria();
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
        }*/

        //-------------------

        /*PARTE 3 - EMPRÉSTIMO*/

        Usuario usuario = new Usuario();
        usuario.setId(1);
        usuario.setNomeCompleto("João Silva");
        usuario.setEmail("joao@email.com");
        usuario.setTelefone("81999999999");
        usuario.setMatricula("2026001");
        usuario.setTipoUsuario(TipoUsuario.ALUNO);
        usuario.setStatusUsuario(StatusUsuario.ATIVO);

        Livro livro = new Livro();
        livro.setId(1);
        livro.setTitulo("Clean Code");
        livro.setIsbn("123456789");
        livro.setAnoPublicacao((short) 2008);
        livro.setEditora("Prentice Hall");
        livro.setQuantidadeTotal(3);
        livro.setQuantidadeDisponivel(3);

        Emprestimo emprestimo = new Emprestimo();
        emprestimo.setId(1);
        emprestimo.setUsuario(usuario);
        emprestimo.setLivro(livro);
        emprestimo.setDataPrevistaDevolucao(LocalDate.now().plusDays(7));
        emprestimo.setStatusEmprestimo(StatusEmprestimo.EM_ABERTO);

        EmprestimoRepository emprestimoRepository = new EmprestimoRepository();
        EmprestimoService emprestimoService = new EmprestimoService(emprestimoRepository);

        try {
            String mensagem = emprestimoService.registrarEmprestimo(emprestimo);
            System.out.println(mensagem);
            System.out.println(emprestimo);
            System.out.println("Quantidade disponível após empréstimo: " + livro.getQuantidadeDisponivel());
        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
        }

        //-----------------

        /*PARTE 4 - TESTE DE DEVOLUÇÃO*/

        try {
            String mensagemDevolucao = emprestimoService.registrarDevolucao(emprestimo);
            System.out.println(mensagemDevolucao);
            System.out.println(emprestimo);
            System.out.println("Quantidade disponível após devolução: " + livro.getQuantidadeDisponivel());
            System.out.println("Dias de atraso: " + emprestimo.getDiasAtraso());
            System.out.println("Valor da multa: " + emprestimo.getValorMulta());
        } catch (Exception e) {
            System.out.println("Erro na devolução: " + e.getMessage());
        }


    }
}