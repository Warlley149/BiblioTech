USE BiblioTechDB;
GO

-- Verificar se o schema e tabela existem
SELECT 
    s.name AS schema_nome,
    t.name AS tabela_nome
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'biblioteca' AND t.name = 'USUARIO';
GO

-- Ver as colunas
SELECT name, max_length, is_nullable 
FROM sys.columns 
WHERE object_id = OBJECT_ID('biblioteca.USUARIO');
GO

/*
   Script: 04_dados_teste_usuario.sql - PARTE 1
   Objetivo: Inserir dados VÁLIDOS para testar funcionamento normal
*/

USE BiblioTechDB;
GO

-- Usuário 1: Aluno ATIVO
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES 
    ('Maria Silva Santos', 'maria.silva@aluno.universidade.br', '(81)99999-9999', '2024001', 'ALUNO', 'ATIVO');

-- Usuário 2: Professor ATIVO  
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES 
    ('João Pedro Oliveira', 'joao.oliveira@prof.universidade.br', '(81)98888-8888', 'PROF001', 'PROFESSOR', 'ATIVO');

-- Usuário 3: Funcionário INATIVO
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES 
    ('Ana Costa Lima', 'ana.lima@funcionario.br', '(81)97777-7777', 'FUNC001', 'FUNCIONARIO', 'INATIVO');

-- Usuário 4: Comunidade BLOQUEADO
INSERT INTO biblioteca.USUARIO 
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES 
    ('Carlos Almeida Souza', 'carlos.souza@comunidade.br', '(81)96666-6666', 'COMU001', 'COMUNIDADE', 'BLOQUEADO');
GO

/*
   Script: 04_dados_teste_usuario.sql - PARTE 2
   Verificar se os dados foram inseridos corretamente
*/

USE BiblioTechDB;
GO

-- Ver todos os usuários
SELECT * FROM biblioteca.USUARIO;
GO

--/*
--   Teste NOT NULL - deve DAR ERRO
--*/

-- Tentativa 1: Sem nome_completo
--INSERT INTO biblioteca.USUARIO (email, telefone, matricula, tipo_usuario, status_usuario)
--VALUES ('teste@null.com', '(81)91111-1111', 'TEST001', 'ALUNO', 'ATIVO');
-- ERRO: Cannot insert the value NULL into column 'nome_completo'

--/*
--   Teste UNIQUE EMAIL - deve DAR ERRO
--*/

--INSERT INTO biblioteca.USUARIO 
--    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
--VALUES 
--    ('Teste Duplicado', 'maria.silva@aluno.universidade.br', '(81)92222-2222', 'TEST002', 'ALUNO', 'ATIVO');
---- ERRO: Violation of UNIQUE KEY constraint 'UQ_USUARIO_EMAIL'

--/*
--   Teste UNIQUE MATRICULA - deve DAR ERRO
--*/

--INSERT INTO biblioteca.USUARIO 
--    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
--VALUES 
--    ('Outro Teste', 'outro.teste@br.com', '(81)93333-3333', '2024001', 'PROFESSOR', 'ATIVO');
---- ERRO: Violation of UNIQUE KEY constraint 'UQ_USUARIO_MATRICULA'

--/*
--   Teste CHECK TIPO_USUARIO - deve DAR ERRO
--*/

--INSERT INTO biblioteca.USUARIO 
--    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
--VALUES 
--    ('Tipo Inválido', 'tipo.invalido@br.com', '(81)94444-4444', 'TIPO001', 'ADMIN', 'ATIVO');
---- ERRO: The INSERT statement conflicted with the CHECK constraint 'CK_USUARIO_TIPO'

--/*
--   Teste CHECK STATUS_USUARIO - deve DAR ERRO
--*/

--INSERT INTO biblioteca.USUARIO 
--    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
--VALUES 
--    ('Status Inválido', 'status.invalido@br.com', '(81)95555-5555', 'STATUS001', 'ALUNO', 'SUSPENSO');
---- ERRO: The INSERT statement conflicted with the CHECK constraint 'CK_USUARIO_STATUS'

--/*
--   Teste CHECK NOME VAZIO - deve DAR ERRO
--*/

--INSERT INTO biblioteca.USUARIO 
--    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
--VALUES 
--    ('   ', 'vazio@br.com', '(81)96666-6666', 'VAZIO001', 'ALUNO', 'ATIVO');
---- ERRO: The INSERT statement conflicted with the CHECK constraint 'CK_USUARIO_NOME'

/*
   Consultas úteis para o dashboard e relatórios
*/

USE BiblioTechDB;
GO

-- 1. Todos usuários ATIVOS
SELECT * FROM biblioteca.USUARIO WHERE status_usuario = 'ATIVO';

-- 2. Contagem por tipo
SELECT tipo_usuario, COUNT(*) as quantidade
FROM biblioteca.USUARIO 
GROUP BY tipo_usuario;

-- 3. Apenas ALUNOS ativos (para empréstimos)
SELECT id_usuario, nome_completo, matricula, email
FROM biblioteca.USUARIO 
WHERE tipo_usuario = 'ALUNO' AND status_usuario = 'ATIVO'
ORDER BY nome_completo;

-- 4. Usuários por status
SELECT status_usuario, COUNT(*) as total
FROM biblioteca.USUARIO 
GROUP BY status_usuario
ORDER BY total DESC;
GO

/*
   Ver constraints criadas (para auditoria)
*/

USE BiblioTechDB;
GO

SELECT 
    o.name AS constraint_nome,
    o.type_desc AS tipo_constraint,
    cc.definition AS definicao_check
FROM sys.objects o
LEFT JOIN sys.check_constraints cc ON o.object_id = cc.object_id
WHERE o.parent_object_id = OBJECT_ID('biblioteca.USUARIO');
GO

USE BiblioTechDB;
GO

SELECT * FROM biblioteca.USUARIO 
ORDER BY id_usuario;
GO