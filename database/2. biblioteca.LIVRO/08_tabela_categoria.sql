/*
   Script: 08_tabela_categoria.sql
   Objetivo: criar a tabela CATEGORIA para o módulo de livros
*/

USE BiblioTechDB;
GO

CREATE TABLE biblioteca.CATEGORIA
(
    -- Identificador único da categoria
    id_categoria INT IDENTITY(1,1) NOT NULL,

    -- Nome da categoria
    nome VARCHAR(100) NOT NULL,

    -- Descrição opcional da categoria
    descricao VARCHAR(255) NULL,

    -- Status da categoria: 1 = ativa / 0 = inativa
    status_ativo BIT NOT NULL
        CONSTRAINT DF_CATEGORIA_STATUS_ATIVO DEFAULT (1),

    -- Data de cadastro da categoria
    data_cadastro DATETIME2 NOT NULL
        CONSTRAINT DF_CATEGORIA_DATA_CADASTRO DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_CATEGORIA
        PRIMARY KEY (id_categoria),

    CONSTRAINT UQ_CATEGORIA_NOME
        UNIQUE (nome),

    CONSTRAINT CK_CATEGORIA_NOME
        CHECK (LTRIM(RTRIM(nome)) <> '')
);
GO

/* 
   Comentários:
   - A tabela CATEGORIA possui um identificador único (id_categoria) que é auto-incrementado.
   - O campo nome é obrigatório e deve ser único, garantindo que não haja categorias duplicadas.
   - O campo descricao é opcional e pode conter uma breve descrição da categoria.
   - O campo status_ativo indica se a categoria está ativa ou inativa, com um valor padrão de 1 (ativa).
   - O campo data_cadastro registra a data e hora em que a categoria foi criada, com um valor padrão do momento da inserção.
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
WHERE t.name = 'CATEGORIA';
GO

-----

USE BiblioTechDB;
GO

INSERT INTO biblioteca.CATEGORIA (nome, descricao)
VALUES
('Tecnologia', 'Livros de tecnologia e programação'),
('Literatura', 'Obras literárias em geral'),
('História', 'Livros de história e sociedade');
GO

SELECT *
FROM biblioteca.CATEGORIA
ORDER BY id_categoria;
GO