/*
   Script: 05_testes_erros_usuario.sql
   Objetivo: Provar que as validações BLOQUEIAM dados inválidos
   IMPORTANTE: Execute UM TESTE POR VEZ para ver cada erro!
*/

USE BiblioTechDB;
GO

PRINT '=== TESTE 1: NOT NULL (nome_completo) ===';
INSERT INTO biblioteca.USUARIO (email, telefone, matricula, tipo_usuario, status_usuario)
VALUES ('teste@null.com', '(81)91111-1111', 'NULL001', 'ALUNO', 'ATIVO');
-- ESPERA ERRO: Cannot insert NULL into column 'nome_completo'
GO

PRINT '=== TESTE 2: UNIQUE EMAIL duplicado ===';
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES ('Duplicado Email', 'maria.silva@aluno.universidade.br', '(81)92222-2222', 'DUP001', 'ALUNO', 'ATIVO');
-- ESPERA ERRO: Violation of UNIQUE KEY constraint 'UQ_USUARIO_EMAIL'
GO

PRINT '=== TESTE 3: UNIQUE MATRICULA duplicada ===';
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES ('Duplicado Matricula', 'matricula.dupla@br.com', '(81)93333-3333', '2024001', 'PROFESSOR', 'ATIVO');
-- ESPERA ERRO: Violation of UNIQUE KEY constraint 'UQ_USUARIO_MATRICULA'
GO

PRINT '=== TESTE 4: CHECK TIPO inválido ===';
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES ('Tipo Errado', 'tipo.errado@br.com', '(81)94444-4444', 'TIPOERR', 'ADMIN', 'ATIVO');
-- ESPERA ERRO: CHECK constraint 'CK_USUARIO_TIPO'
GO

PRINT '=== TESTE 5: CHECK STATUS inválido ===';
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES ('Status Errado', 'status.errado@br.com', '(81)95555-5555', 'STATUSERR', 'ALUNO', 'SUSPENSO');
-- ESPERA ERRO: CHECK constraint 'CK_USUARIO_STATUS'
GO

PRINT '=== TESTE 6: CHECK NOME vazio ===';
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES ('   ', 'vazio@br.com', '(81)96666-6666', 'VAZIO001', 'ALUNO', 'ATIVO');
-- ESPERA ERRO: CHECK constraint 'CK_USUARIO_NOME'
GO