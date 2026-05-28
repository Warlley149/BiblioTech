/*
   Script: 10_tabela_livro.sql
   Objetivo: criar a tabela LIVRO para o acervo da biblioteca
*/

USE BiblioTechDB;
GO

CREATE TABLE biblioteca.LIVRO
(
    -- Identificador único do livro
    id_livro INT IDENTITY(1,1) NOT NULL,

    -- Título completo da obra
    titulo VARCHAR(200) NOT NULL,

    -- ISBN do livro, obrigatório e único
    isbn VARCHAR(20) NOT NULL,

    -- Ano de publicação
    ano_publicacao SMALLINT NOT NULL,

    -- Editora da obra
    editora VARCHAR(120) NULL,

    -- Quantidade total de exemplares no acervo
    quantidade_total INT NOT NULL,

    -- Quantidade atualmente disponível para empréstimo
    quantidade_disponivel INT NOT NULL,

    -- Categoria do livro
    id_categoria INT NOT NULL,

    CONSTRAINT PK_LIVRO
        PRIMARY KEY (id_livro),

    CONSTRAINT UQ_LIVRO_ISBN
        UNIQUE (isbn),

    CONSTRAINT FK_LIVRO_CATEGORIA
        FOREIGN KEY (id_categoria)
        REFERENCES biblioteca.CATEGORIA (id_categoria),

    CONSTRAINT CK_LIVRO_TITULO
        CHECK (LTRIM(RTRIM(titulo)) <> ''),

    CONSTRAINT CK_LIVRO_ANO_PUBLICACAO
        CHECK (ano_publicacao BETWEEN 1000 AND YEAR(GETDATE())),

    CONSTRAINT CK_LIVRO_QUANTIDADE_TOTAL
        CHECK (quantidade_total > 0),

    CONSTRAINT CK_LIVRO_QUANTIDADE_DISPONIVEL
        CHECK (quantidade_disponivel >= 0 AND quantidade_disponivel <= quantidade_total)
);
GO

/* 
   Comentários:
   - A tabela LIVRO possui um identificador único (id_livro) que é auto-incrementado.
   - O campo titulo é obrigatório e deve conter o título completo da obra.
   - O campo isbn é obrigatório, deve ser único e conter o ISBN do livro.
   - O campo ano_publicacao é obrigatório e deve conter um valor entre 1000 e o ano atual.
   - O campo editora é opcional e pode conter o nome da editora da obra.
   - O campo quantidade_total é obrigatório e deve conter a quantidade total de exemplares do livro no acervo, sendo maior que zero.
   - O campo quantidade_disponivel é obrigatório e deve conter a quantidade atualmente disponível para empréstimo, sendo um valor entre zero e a quantidade total.
   - O campo id_categoria é obrigatório e referencia a categoria do livro na tabela CATEGORIA.
*/

/*TESTES*/

USE BiblioTechDB;
GO

SELECT
    s.name AS schema_name,
    t.name AS table_name
FROM sys.tables t
INNER JOIN sys.schemas s
    ON t.schema_id = s.schema_id
WHERE t.name = 'LIVRO';
GO
----
USE BiblioTechDB;
GO

SELECT *
FROM biblioteca.CATEGORIA;
GO
------
USE BiblioTechDB;
GO

INSERT INTO biblioteca.LIVRO
(
    titulo,
    isbn,
    ano_publicacao,
    editora,
    quantidade_total,
    quantidade_disponivel,
    id_categoria
)
VALUES
(
    'Dom Casmurro',
    '9788525406987',
    1899,
    'Editora Ática',
    10,
    10,
    1
);
GO

-----

USE BiblioTechDB;
GO

SELECT
    s.name AS schema_name,
    o.name AS object_name,
    o.type_desc
FROM sys.objects o
INNER JOIN sys.schemas s
    ON o.schema_id = s.schema_id
WHERE o.name = 'LIVRO';
GO

USE BiblioTechDB;
GO

SELECT
    c.name AS nome_coluna,
    t.name AS tipo,
    c.max_length AS tamanho,
    c.is_nullable AS aceita_nulo
FROM sys.columns c
INNER JOIN sys.types t
    ON c.user_type_id = t.user_type_id
WHERE c.object_id = OBJECT_ID('biblioteca.LIVRO')
ORDER BY c.column_id;
GO

USE BiblioTechDB;
GO

SELECT
    name AS nome_constraint,
    type_desc AS tipo_constraint
FROM sys.objects
WHERE parent_object_id = OBJECT_ID('biblioteca.LIVRO')
ORDER BY type_desc, name;
GO

USE BiblioTechDB;
GO

SELECT * 
FROM biblioteca.CATEGORIA;
GO

USE BiblioTechDB;
GO

INSERT INTO biblioteca.LIVRO
(
    titulo,
    isbn,
    ano_publicacao,
    editora,
    quantidade_total,
    quantidade_disponivel,
    id_categoria
)
VALUES
(
    'Dom Casmurro',
    '9788525406987',
    1899,
    'Editora Atica',
    10,
    10,
    1
);
GO