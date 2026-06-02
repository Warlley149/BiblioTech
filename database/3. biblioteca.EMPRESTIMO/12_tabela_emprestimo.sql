/*
   Script: 12_tabela_emprestimo.sql
   Objetivo: criar a tabela EMPRESTIMO
*/

USE BiblioTechDB;
GO

CREATE TABLE biblioteca.EMPRESTIMO
(
    -- Identificador único do empréstimo
    id_emprestimo INT IDENTITY(1,1) NOT NULL,

    -- Usuário que realizou o empréstimo
    id_usuario INT NOT NULL,

    -- Livro emprestado
    id_livro INT NOT NULL,

    -- Data e hora do empréstimo
    data_emprestimo DATETIME2 NOT NULL
        CONSTRAINT DF_EMPRESTIMO_DATA_EMPRESTIMO DEFAULT (SYSDATETIME()),

    -- Data prevista para devolução
    data_prevista_devolucao DATE NOT NULL,

    -- Data real da devolução
    data_devolucao DATETIME2 NULL,

    -- Status atual do empréstimo
    status_emprestimo VARCHAR(20) NOT NULL
        CONSTRAINT DF_EMPRESTIMO_STATUS DEFAULT ('EMABERTO'),

    CONSTRAINT PK_EMPRESTIMO
        PRIMARY KEY (id_emprestimo),

    CONSTRAINT FK_EMPRESTIMO_USUARIO
        FOREIGN KEY (id_usuario)
        REFERENCES biblioteca.USUARIO (id_usuario),

    CONSTRAINT FK_EMPRESTIMO_LIVRO
        FOREIGN KEY (id_livro)
        REFERENCES biblioteca.LIVRO (id_livro),

    CONSTRAINT CK_EMPRESTIMO_STATUS
        CHECK (status_emprestimo IN ('EMABERTO', 'DEVOLVIDO', 'ATRASADO', 'CANCELADO')),

    CONSTRAINT CK_EMPRESTIMO_DATA_PREVISTA
        CHECK (data_prevista_devolucao >= CAST(data_emprestimo AS DATE)),

    CONSTRAINT CK_EMPRESTIMO_DATA_DEVOLUCAO
        CHECK (
            data_devolucao IS NULL
            OR data_devolucao >= data_emprestimo
        )
);
GO

----------

/*TESTAR A CRIAÇÃO DA TABELA EMPRESTIMO*/

USE BiblioTechDB;
GO

SELECT
    s.name AS schema_name,
    t.name AS table_name
FROM sys.tables t
INNER JOIN sys.schemas s
    ON t.schema_id = s.schema_id
WHERE t.name = 'EMPRESTIMO';
GO

--------
/*TESTAR AS COLUNAS DA TABELA EMPRESTIMO*/

USE BiblioTechDB;
GO

SELECT
    c.name AS nome_coluna,
    ty.name AS tipo_dado,
    c.max_length AS tamanho,
    c.is_nullable AS permite_nulo
FROM sys.columns c
INNER JOIN sys.types ty
    ON c.user_type_id = ty.user_type_id
WHERE c.object_id = OBJECT_ID('biblioteca.EMPRESTIMO')
ORDER BY c.column_id;
GO