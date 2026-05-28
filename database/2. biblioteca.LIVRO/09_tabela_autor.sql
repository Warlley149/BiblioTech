/*
   Script: 09_tabela_autor.sql
   Objetivo: criar a tabela AUTOR para o módulo de livros
*/

USE BiblioTechDB;
GO

CREATE TABLE biblioteca.AUTOR
(
    -- Identificador único do autor
    id_autor INT IDENTITY(1,1) NOT NULL,

    -- Nome do autor
    nome VARCHAR(120) NOT NULL,

    -- Nacionalidade do autor
    nacionalidade VARCHAR(60) NULL,

    -- Data de nascimento do autor
    data_nascimento DATE NULL,

    -- Status do autor: 1 = ativo / 0 = inativo
    status_ativo BIT NOT NULL
        CONSTRAINT DF_AUTOR_STATUS_ATIVO DEFAULT (1),

    CONSTRAINT PK_AUTOR
        PRIMARY KEY (id_autor),

    CONSTRAINT CK_AUTOR_NOME
        CHECK (LTRIM(RTRIM(nome)) <> '')
);
GO

/* 
   Comentários:
   - A tabela AUTOR possui um identificador único (id_autor) que é auto-incrementado.
   - O campo nome é obrigatório e deve conter o nome do autor.
   - O campo nacionalidade é opcional e pode conter a nacionalidade do autor.
   - O campo data_nascimento é opcional e pode conter a data de nascimento do autor.
   - O campo status_ativo indica se o autor está ativo ou inativo, com um valor padrão de 1 (ativo).
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
WHERE t.name = 'AUTOR';
GO

------

USE BiblioTechDB;
GO

INSERT INTO biblioteca.AUTOR (nome, nacionalidade, data_nascimento)
VALUES
('Machado de Assis', 'Brasileira', '1839-06-21'),
('Clarice Lispector', 'Brasileira', '1920-12-10'),
('George Orwell', 'Britânica', '1903-06-25');
GO

SELECT *
FROM biblioteca.AUTOR
ORDER BY id_autor;
GO