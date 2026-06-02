-------
/*devolução sem atraso*/

USE BiblioTechDB;
GO

EXEC biblioteca.sp_RegistrarDevolucao
    @id_emprestimo = 1,
    @data_devolucao = '2026-06-05 10:00:00';
GO

-------
/* devolução com atraso*/

USE BiblioTechDB;
GO

EXEC biblioteca.sp_RegistrarDevolucao
    @id_emprestimo = 2,
    @data_devolucao = '2026-06-20 14:00:00';
GO

-------
/*devolução duplicada*/

USE BiblioTechDB;
GO

EXEC biblioteca.sp_RegistrarDevolucao
    @id_emprestimo = 1,
    @data_devolucao = '2026-06-06 09:00:00';
GO