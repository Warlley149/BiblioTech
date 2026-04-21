/*
   Arquivo: 07_finalizacao_usuario.sql
   Objetivo: finalizar a estrutura da entidade USUARIO
   Etapas:
   1) Criar índices de apoio para consultas frequentes
   2) Criar view para consulta de usuários ativos
*/

USE BiblioTechDB;
GO

/* =====================================================
   1. ÍNDICES
   ===================================================== */

/*
   Índice para pesquisas por e-mail.
   Observação:
   o campo email já possui UNIQUE CONSTRAINT, e o SQL Server
   normalmente já cria um índice único para suportá-la.
   Este bloco só cria o índice se ele ainda não existir.
*/
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_USUARIO_EMAIL'
      AND object_id = OBJECT_ID('biblioteca.USUARIO')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_USUARIO_EMAIL
        ON biblioteca.USUARIO (email);
END
GO

/*
   Índice para pesquisas por matrícula.
   Observação:
   matricula também já possui UNIQUE CONSTRAINT.
   Este bloco evita duplicar criação desnecessária se você
   decidir manter apenas os índices automáticos da UNIQUE.
*/
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_USUARIO_MATRICULA'
      AND object_id = OBJECT_ID('biblioteca.USUARIO')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_USUARIO_MATRICULA
        ON biblioteca.USUARIO (matricula);
END
GO

/*
   Índice útil para consultas por status e tipo de usuário,
   que faz sentido para filtros administrativos e relatórios.
*/
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_USUARIO_STATUS_TIPO'
      AND object_id = OBJECT_ID('biblioteca.USUARIO')
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_USUARIO_STATUS_TIPO
        ON biblioteca.USUARIO (status_usuario, tipo_usuario);
END
GO

/* =====================================================
   2. VIEW
   ===================================================== */

/*
   View para facilitar consultas de usuários ativos.
   Útil para telas, relatórios e futura integração com Java.
*/
IF OBJECT_ID('biblioteca.vw_USUARIOS_ATIVOS', 'V') IS NOT NULL
BEGIN
    DROP VIEW biblioteca.vw_USUARIOS_ATIVOS;
END
GO

CREATE VIEW biblioteca.vw_USUARIOS_ATIVOS
AS
SELECT
    id_usuario,
    nome_completo,
    email,
    telefone,
    matricula,
    tipo_usuario,
    status_usuario
FROM biblioteca.USUARIO
WHERE status_usuario = 'ATIVO';
GO

/* =====================================================
   3. TESTES FINAIS
   ===================================================== */

/* Ver dados da view */
SELECT *
FROM biblioteca.vw_USUARIOS_ATIVOS
ORDER BY id_usuario;
GO

/* Ver índices da tabela */
SELECT
    i.name AS nome_indice,
    i.type_desc AS tipo_indice
FROM sys.indexes i
WHERE i.object_id = OBJECT_ID('biblioteca.USUARIO')
  AND i.name IS NOT NULL;
GO

/*   Verificar se os dados foram inseridos corretamente
*/

USE BiblioTechDB;
GO

SELECT *
FROM biblioteca.USUARIO
ORDER BY id_usuario;
GO

/*Confirmar se os índices foram criados*/

USE BiblioTechDB;
GO

SELECT
    i.name AS nome_indice,
    i.type_desc AS tipo_indice,
    i.is_unique AS eh_unico
FROM sys.indexes i
WHERE i.object_id = OBJECT_ID('biblioteca.USUARIO')
  AND i.name IS NOT NULL
ORDER BY i.name;
GO

/*Testar se a View foi criada*/

USE BiblioTechDB;
GO

SELECT
    name AS nome_view
FROM sys.views
WHERE name = 'vw_USUARIOS_ATIVOS'
  AND schema_id = SCHEMA_ID('biblioteca');
GO

/*Testar o conteúdo da view*/

USE BiblioTechDB;
GO

SELECT *
FROM biblioteca.vw_USUARIOS_ATIVOS
ORDER BY id_usuario;
GO

/* Comparar quantidades */
SELECT COUNT(*) AS total_tabela
FROM biblioteca.USUARIO;

SELECT COUNT(*) AS total_view_ativos
FROM biblioteca.vw_USUARIOS_ATIVOS;
GO

/*   Verificar se os dados foram inseridos corretamente
*/

USE BiblioTechDB;
GO

SELECT *
FROM biblioteca.USUARIO
ORDER BY id_usuario;
GO

/* Verificar formato de e-mails e telefones */

USE BiblioTechDB;
GO

SELECT
    o.name AS nome_constraint,
    o.type_desc AS tipo_constraint,
    cc.definition AS definicao_check
FROM sys.objects o
LEFT JOIN sys.check_constraints cc
    ON o.object_id = cc.object_id
WHERE o.parent_object_id = OBJECT_ID('biblioteca.USUARIO')
ORDER BY o.name;
GO