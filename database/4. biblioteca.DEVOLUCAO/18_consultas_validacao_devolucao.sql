------
/*CONSULTAR EMPRÉSTIMO*/

USE BiblioTechDB;
GO

SELECT
    id_emprestimo,
    id_usuario,
    id_livro,
    data_emprestimo,
    data_prevista_devolucao,
    data_devolucao,
    status_emprestimo
FROM biblioteca.EMPRESTIMO
ORDER BY id_emprestimo;
GO

------
/*Consultar disponibilidade do livro*/

USE BiblioTechDB;
GO

SELECT
    id_livro,
    titulo,
    quantidade_total,
    quantidade_disponivel
FROM biblioteca.LIVRO
ORDER BY id_livro;
GO

-----
/*Consultar multas geradas*/

USE BiblioTechDB;
GO

SELECT
    id_multa,
    id_emprestimo,
    dias_atraso,
    valor_multa,
    status_multa
FROM biblioteca.MULTA
ORDER BY id_multa;
GO