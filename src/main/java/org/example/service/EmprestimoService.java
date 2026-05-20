package org.example.service;

import org.example.enums.StatusEmprestimo;
import org.example.enums.StatusUsuario;
import org.example.exception.ValidacaoException;
import org.example.model.Emprestimo;
import org.example.repository.EmprestimoRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class EmprestimoService {

    private EmprestimoRepository emprestimoRepository;

    public EmprestimoService(EmprestimoRepository emprestimoRepository) {
        this.emprestimoRepository = emprestimoRepository;
    }

    public String registrarEmprestimo(Emprestimo emprestimo) {
        validarUsuario(emprestimo);
        validarLivro(emprestimo);
        validarDataPrevista(emprestimo);

        emprestimo.setDataEmprestimo(LocalDateTime.now());
        emprestimo.setStatusEmprestimo(StatusEmprestimo.EM_ABERTO);
        emprestimo.getLivro().setQuantidadeDisponivel(
                emprestimo.getLivro().getQuantidadeDisponivel() - 1
        );

        emprestimoRepository.salvar(emprestimo);

        return "Empréstimo registrado com sucesso.";
    }

    private void validarUsuario(Emprestimo emprestimo) {
        if (emprestimo.getUsuario() == null) {
            throw new ValidacaoException("Usuário obrigatório.");
        }

        if (emprestimo.getUsuario().getStatusUsuario() != StatusUsuario.ATIVO) {
            throw new ValidacaoException("Somente usuários ativos podem realizar empréstimo.");
        }
    }

    private void validarLivro(Emprestimo emprestimo) {
        if (emprestimo.getLivro() == null) {
            throw new ValidacaoException("Livro obrigatório.");
        }

        if (emprestimo.getLivro().getQuantidadeDisponivel() <= 0) {
            throw new ValidacaoException("Livro indisponível para empréstimo.");
        }
    }

    private void validarDataPrevista(Emprestimo emprestimo) {
        if (emprestimo.getDataPrevistaDevolucao() == null) {
            throw new ValidacaoException("Data prevista de devolução obrigatória.");
        }
    }

    public String registrarDevolucao(Emprestimo emprestimo) {
        validarDevolucao(emprestimo);

        LocalDateTime dataDevolucao = LocalDateTime.now();
        emprestimo.setDataDevolucao(dataDevolucao);

        if (dataDevolucao.isBefore(emprestimo.getDataEmprestimo())) {
            throw new ValidacaoException("Data de devolução não pode ser anterior à data do empréstimo.");
        }

        int diasAtraso = 0;
        double valorMulta = 0.0;

        LocalDate dataPrevista = emprestimo.getDataPrevistaDevolucao();
        LocalDate dataReal = dataDevolucao.toLocalDate();

        if (dataReal.isAfter(dataPrevista)) {
            diasAtraso = (int) ChronoUnit.DAYS.between(dataPrevista, dataReal);
            valorMulta = diasAtraso * 2.0;
        }

        emprestimo.setDiasAtraso(diasAtraso);
        emprestimo.setValorMulta(valorMulta);
        emprestimo.setStatusEmprestimo(StatusEmprestimo.DEVOLVIDO);

        emprestimo.getLivro().setQuantidadeDisponivel(
                emprestimo.getLivro().getQuantidadeDisponivel() + 1
        );

        return "Devolução registrada com sucesso.";
    }

    //VALIDAR DEVOLUÇÃO

    private void validarDevolucao(Emprestimo emprestimo) {
        if (emprestimo == null) {
            throw new ValidacaoException("Empréstimo obrigatório.");
        }

        if (emprestimo.getStatusEmprestimo() != StatusEmprestimo.EM_ABERTO) {
            throw new ValidacaoException("Somente empréstimos EM_ABERTO podem ser devolvidos.");
        }

        if (emprestimo.getDataDevolucao() != null) {
            throw new ValidacaoException("Devolução já registrada para este empréstimo.");
        }

        if (emprestimo.getLivro() == null) {
            throw new ValidacaoException("Livro obrigatório.");
        }

        if (emprestimo.getDataEmprestimo() == null) {
            throw new ValidacaoException("Data do empréstimo obrigatória.");
        }

        if (emprestimo.getDataPrevistaDevolucao() == null) {
            throw new ValidacaoException("Data prevista de devolução obrigatória.");
        }
    }
}