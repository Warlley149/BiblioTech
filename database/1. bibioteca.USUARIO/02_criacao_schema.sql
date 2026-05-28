/*
   Script: 02_criacao_schema.sql
   Objetivo: criar o schema principal do sistema
*/

USE BiblioTechDB;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'biblioteca'
)
BEGIN
    EXEC('CREATE SCHEMA biblioteca');
END
GO