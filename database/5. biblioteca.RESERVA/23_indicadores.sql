USE BiblioTechDB;
GO

SELECT COUNT(*) AS total_livros
FROM biblioteca.LIVRO;

SELECT COUNT(*) AS livros_disponiveis
FROM biblioteca.LIVRO
WHERE quantidade_disponivel > 0;

SELECT COUNT(*) AS emprestimos_em_aberto
FROM biblioteca.EMPRESTIMO
WHERE status_emprestimo = 'EMABERTO';

SELECT COUNT(*) AS reservas_ativas
FROM biblioteca.RESERVA
WHERE status_reserva = 'ATIVA';

SELECT COUNT(*) AS multas_pendentes
FROM biblioteca.MULTA
WHERE status_multa = 'PENDENTE';
GO