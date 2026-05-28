/*
   Script: 03_tabela_usuario.sql
   Objetivo: criar a tabela USUARIO com regras de integridade
*/

USE BiblioTechDB;
GO

CREATE TABLE biblioteca.USUARIO
(
    -- Chave primária da tabela
    id_usuario INT IDENTITY(1,1) NOT NULL,

    -- Nome completo do usuário
    nome_completo VARCHAR(120) NOT NULL,

    -- E-mail do usuário (deve ser único)
    email VARCHAR(150) NOT NULL,

    -- Telefone do usuário
    telefone VARCHAR(15) NOT NULL,

    -- Matrícula institucional ou identificador do usuário
    matricula VARCHAR(20) NOT NULL,

    -- Tipo de usuário permitido no sistema
    tipo_usuario VARCHAR(20) NOT NULL,

    -- Situação atual do usuário no sistema
    status_usuario VARCHAR(20) NOT NULL,

    -- Constraint de chave primária
    CONSTRAINT PK_USUARIO
        PRIMARY KEY (id_usuario),

    -- Constraint de unicidade para e-mail
    CONSTRAINT UQ_USUARIO_EMAIL
        UNIQUE (email),

    -- Constraint de unicidade para matrícula
    CONSTRAINT UQ_USUARIO_MATRICULA
        UNIQUE (matricula),

    -- Constraint para tipos permitidos
    CONSTRAINT CK_USUARIO_TIPO
        CHECK (tipo_usuario IN ('ALUNO', 'PROFESSOR', 'FUNCIONARIO', 'COMUNIDADE')),

    -- Constraint para status permitidos
    CONSTRAINT CK_USUARIO_STATUS
        CHECK (status_usuario IN ('ATIVO', 'INATIVO', 'BLOQUEADO')),

    -- Constraint para impedir nome vazio
    CONSTRAINT CK_USUARIO_NOME
        CHECK (LTRIM(RTRIM(nome_completo)) <> '')
);
GO