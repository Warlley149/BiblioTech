package org.example.repository;

import org.example.model.Emprestimo;

import java.util.ArrayList;
import java.util.List;

public class EmprestimoRepository {

    private List<Emprestimo> emprestimos = new ArrayList<>();

    public void salvar(Emprestimo emprestimo) {
        emprestimos.add(emprestimo);
    }

    public List<Emprestimo> listarTodos() {
        return emprestimos;
    }

    public Emprestimo buscarPorId(int id) {
        for (Emprestimo emprestimo : emprestimos) {
            if (emprestimo.getId() == id) {
                return emprestimo;
            }
        }
        return null;
    }
}