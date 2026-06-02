USE BiblioTechDB;
GO

CREATE OR ALTER PROCEDURE biblioteca.sp_ConsultarLivros
    @titulo VARCHAR(200) = NULL,
    @isbn VARCHAR(20) = NULL,
    @id_categoria INT = NULL,
    @id_autor INT = NULL,
    @disponivel BIT = NULL,
    @pagina INT = 1,
    @quantidade_por_pagina INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    IF @pagina < 1
        SET @pagina = 1;

    IF @quantidade_por_pagina < 1
        SET @quantidade_por_pagina = 10;

    SELECT
        l.id_livro,
        l.titulo,
        l.isbn,
        l.ano_publicacao,
        l.editora,
        l.quantidade_total,
        l.quantidade_disponivel,
        c.nome AS categoria
    FROM biblioteca.LIVRO l
    INNER JOIN biblioteca.CATEGORIA c
        ON c.id_categoria = l.id_categoria
    LEFT JOIN biblioteca.LIVROAUTOR la
        ON la.id_livro = l.id_livro
    WHERE
        (@titulo IS NULL OR l.titulo LIKE '%' + @titulo + '%')
        AND (@isbn IS NULL OR l.isbn = @isbn)
        AND (@id_categoria IS NULL OR l.id_categoria = @id_categoria)
        AND (@id_autor IS NULL OR la.id_autor = @id_autor)
        AND (
            @disponivel IS NULL
            OR (@disponivel = 1 AND l.quantidade_disponivel > 0)
            OR (@disponivel = 0 AND l.quantidade_disponivel = 0)
        )
    GROUP BY
        l.id_livro, l.titulo, l.isbn, l.ano_publicacao, l.editora,
        l.quantidade_total, l.quantidade_disponivel, c.nome
    ORDER BY l.titulo
    OFFSET (@pagina - 1) * @quantidade_por_pagina ROWS
    FETCH NEXT @quantidade_por_pagina ROWS ONLY;
END;
GO

/*TESTES FINAIS*/

--BUSCAR POR TÍTULOS
EXEC biblioteca.sp_ConsultarLivros
    @titulo = 'Banco';

--BUSCAR POR ISBN
EXEC biblioteca.sp_ConsultarLivros
    @isbn = '9788575226986';

--BUSCAR POR CATEGORIA
EXEC biblioteca.sp_ConsultarLivros
    @id_categoria = 1;

--BUSCAR POR AUTORES
EXEC biblioteca.sp_ConsultarLivros
    @id_autor = 1;

--BUSCAR APENAS DISPONÍVEIS
EXEC biblioteca.sp_ConsultarLivros
    @disponivel = 1;

--BUSCAR APENAS INDISPONÍVEIS
EXEC biblioteca.sp_ConsultarLivros
    @disponivel = 0;

--TESTAR PAGINAÇÃO
EXEC biblioteca.sp_ConsultarLivros
    @pagina = 1,
    @quantidade_por_pagina = 5;