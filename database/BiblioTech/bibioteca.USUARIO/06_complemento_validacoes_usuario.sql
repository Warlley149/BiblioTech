/*
   Script: 06_complemento_validacoes_usuario.sql
   Objetivo: adicionar validações faltantes do documento
*/

USE BiblioTechDB;
GO

/* 
   Validação básica de e-mail:
   - não permite espaço
   - exige pelo menos um caractere antes do @
   - exige presença de @
   - exige ponto após o @
*/
ALTER TABLE biblioteca.USUARIO
ADD CONSTRAINT CK_USUARIO_EMAIL_FORMATO
CHECK (
    email NOT LIKE '% %'
    AND email LIKE '_%@_%._%'
);
GO

/*
   Validação de telefone:
   permite apenas números, espaço, parênteses e hífen
*/
ALTER TABLE biblioteca.USUARIO
ADD CONSTRAINT CK_USUARIO_TELEFONE_FORMATO
CHECK (
    telefone NOT LIKE '%[^0-9() -]%'
);
GO

/*TESTE PARA EMAIL INVÁLIDO*/

INSERT INTO biblioteca.USUARIO
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES
    ('Email Invalido', 'emailinvalido', '(81)99999-9999', 'TESTE_EMAIL_01', 'ALUNO', 'ATIVO');
GO

/*TESTE PARA TELEFONE INVÁLIDO*/

INSERT INTO biblioteca.USUARIO
    (nome_completo, email, telefone, matricula, tipo_usuario, status_usuario)
VALUES
    ('Telefone Invalido', 'tel.invalido@teste.com', '81#99999@9999', 'TESTE_TEL_01', 'ALUNO', 'ATIVO');
GO

/*   Verificar se os dados foram inseridos corretamente
*/

USE BiblioTechDB;
GO

SELECT *
FROM biblioteca.USUARIO
ORDER BY id_usuario;
GO