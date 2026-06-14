USE BiblioTechDB
GO

SELECT * FROM biblioteca.EMPRESTIMO;

SELECT quantidade_disponivel FROM biblioteca.LIVRO WHERE id_livro = 1;

ALTER TABLE biblioteca.EMPRESTIMO
ADD dias_atraso INT,
    valor_multa DECIMAL(10,2);

UPDATE biblioteca.EMPRESTIMO
SET data_prevista_devolucao = '2026-06-01'
WHERE id_emprestimo = 12;

UPDATE biblioteca.EMPRESTIMO
SET data_prevista_devolucao = '2026-06-15'
WHERE id_emprestimo = 12;

UPDATE biblioteca.EMPRESTIMO
SET data_prevista_devolucao = '2026-06-10'
WHERE id_emprestimo = 12;

UPDATE biblioteca.EMPRESTIMO
SET data_emprestimo = '2026-06-01'
WHERE id_emprestimo = 12;

UPDATE biblioteca.EMPRESTIMO
SET data_prevista_devolucao = '2026-06-08'
WHERE id_emprestimo = 12;

SELECT * FROM biblioteca.RESERVA;

UPDATE biblioteca.LIVRO
SET quantidade_disponivel = 0
WHERE id_livro = 1;

UPDATE biblioteca.LIVRO
SET quantidade_disponivel = 0
WHERE id_livro = 1;

SELECT quantidade_disponivel FROM biblioteca.LIVRO WHERE id_livro = 1;

UPDATE biblioteca.LIVRO
SET quantidade_disponivel = 5
WHERE id_livro = 1;

SELECT quantidade_disponivel
FROM biblioteca.LIVRO 
WHERE id_livro = 1;

UPDATE biblioteca.LIVRO
SET quantidade_disponivel = 0
WHERE id_livro = 1;

SELECT * FROM biblioteca.CATEGORIA;
