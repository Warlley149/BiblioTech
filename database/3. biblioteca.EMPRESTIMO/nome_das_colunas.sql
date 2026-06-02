USE BiblioTechDB;
GO

SELECT 
    c.name AS nome_coluna
FROM sys.columns c
WHERE c.object_id = OBJECT_ID('biblioteca.LIVRO')
ORDER BY c.column_id;
GO