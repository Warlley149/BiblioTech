USE BiblioTechDB;
GO

SELECT
    (SELECT COUNT(*) FROM biblioteca.LIVRO) AS total_livros,
    (SELECT COUNT(*) FROM biblioteca.LIVRO WHERE quantidade_disponivel > 0) AS livros_disponiveis,
    (SELECT COUNT(*) FROM biblioteca.EMPRESTIMO WHERE status_emprestimo = 'EMABERTO') AS emprestimos_em_aberto,
    (SELECT COUNT(*) FROM biblioteca.RESERVA WHERE status_reserva = 'ATIVA') AS reservas_ativas,
    (SELECT COUNT(*) FROM biblioteca.MULTA WHERE status_multa = 'PENDENTE') AS multas_pendentes;
GO

--VERSÃO EM PROCEDURE (MAIS RÁPIDA)

USE BiblioTechDB;
GO

CREATE OR ALTER PROCEDURE biblioteca.sp_DashboardInicial
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        (SELECT COUNT(*) FROM biblioteca.LIVRO) AS total_livros,
        (SELECT COUNT(*) FROM biblioteca.LIVRO WHERE quantidade_disponivel > 0) AS livros_disponiveis,
        (SELECT COUNT(*) FROM biblioteca.EMPRESTIMO WHERE status_emprestimo = 'EMABERTO') AS emprestimos_em_aberto,
        (SELECT COUNT(*) FROM biblioteca.RESERVA WHERE status_reserva = 'ATIVA') AS reservas_ativas,
        (SELECT COUNT(*) FROM biblioteca.MULTA WHERE status_multa = 'PENDENTE') AS multas_pendentes;
END;
GO

--EXECUTAR
EXEC biblioteca.sp_DashboardInicial;