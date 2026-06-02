USE BiblioTechDB;
GO

SELECT
    c.column_id,
    c.name AS nome_coluna,
    t.name AS tipo_dado,
    c.max_length AS tamanho,
    c.is_nullable AS permite_nulo
FROM sys.columns c
INNER JOIN sys.types t
    ON c.user_type_id = t.user_type_id
WHERE c.object_id = OBJECT_ID('biblioteca.EMPRESTIMO')
ORDER BY c.column_id;
GO