package org.example.service;

import org.example.enums.StatusEmprestimo;
import org.example.enums.StatusUsuario;
import org.example.model.Emprestimo;
import org.example.model.Livro;
import org.example.model.Usuario;
import org.example.repository.EmprestimoRepository;
import org.example.repository.LivroRepository;
import org.example.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class EmprestimoService {

    private final EmprestimoRepository repository;
    private final LivroRepository livroRepository;
    private final UsuarioRepository usuarioRepository;

    public EmprestimoService(EmprestimoRepository repository,
                             LivroRepository livroRepository,
                             UsuarioRepository usuarioRepository) {
        this.repository = repository;
        this.livroRepository = livroRepository;
        this.usuarioRepository = usuarioRepository;
    }

    public Emprestimo emprestar(Integer usuarioId, Integer livroId) throws Exception {

        Usuario usuario = usuarioRepository.findById(usuarioId)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        Livro livro = livroRepository.findById(livroId)
                .orElseThrow(() -> new RuntimeException("Livro não encontrado"));

       /* // ✅ valida usuário
        if (usuario.getStatusUsuario() == StatusUsuario.INATIVO) {
            throw new Exception("Usuário não está ativo");
        }*/

        // ✅ valida livro
        if (livro.getQuantidadeDisponivel() <= 0) {
            throw new Exception("Livro indisponível");}


        // ✅ diminui estoque
        livro.setQuantidadeDisponivel(livro.getQuantidadeDisponivel() - 1);
        livroRepository.save(livro);

        // ✅ cria empréstimo
        Emprestimo emprestimo = new Emprestimo();
        emprestimo.setUsuario(usuario);
        emprestimo.setLivro(livro);
        emprestimo.setStatusEmprestimo(StatusEmprestimo.EM_ABERTO);

        return repository.save(emprestimo);
    }
    public List<Emprestimo> listar() {
        return repository.findAll();
    }

    //DEVOUÇÃO DE LIVRO

    public Emprestimo devolver(Integer emprestimoId) {

        Emprestimo emprestimo = repository.findById(emprestimoId)
                .orElseThrow(() -> new RuntimeException("Empréstimo não encontrado"));

        emprestimo.setStatusEmprestimo(StatusEmprestimo.DEVOLVIDO);

        LocalDateTime agora = LocalDateTime.now();
        emprestimo.setDataDevolucao(agora);

        // ✅ lógica de atraso
        LocalDate dataPrevista = emprestimo.getDataPrevistaDevolucao();
        LocalDate hoje = LocalDate.now();

        if (hoje.isAfter(dataPrevista)) {

            long dias = java.time.temporal.ChronoUnit.DAYS
                    .between(dataPrevista, hoje);

            emprestimo.setDiasAtraso((int) dias);
            emprestimo.setValorMulta(dias * 2.0);

        } else {
            emprestimo.setDiasAtraso(0);
            emprestimo.setValorMulta(0.0);
        }

        // ✅ devolve ao estoque
        Livro livro = emprestimo.getLivro();
        livro.setQuantidadeDisponivel(livro.getQuantidadeDisponivel() + 1);
        livroRepository.save(livro);

        return repository.save(emprestimo);
    }
}