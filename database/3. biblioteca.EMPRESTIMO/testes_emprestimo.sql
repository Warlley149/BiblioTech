USE BiblioTechDB;
GO

INSERT INTO biblioteca.USUARIO
(
    nome_completo,
    email,
    telefone,
    matricula,
    tipo_usuario,
    status_usuario
)
VALUES
(
    'Ana Paula Souza',
    'ana.paula@bibliotech.com',
    '11999990000',
    '2026001',
    'ALUNO',
    'ATIVO'
);
GO

EXEC biblioteca.sp_RegistrarEmprestimo
    @id_usuario = 1,
    @id_livro = 1,
    @data_prevista_devolucao = '2026-06-10';
GO

SELECT *
FROM biblioteca.EMPRESTIMO;
GO

SELECT *
FROM biblioteca.LIVRO
WHERE id_livro = 1;
GO

--------

/*USUÁRIO INATIVO - TESTE DE RESTRIÇÃO DE EMPRÉSTIMO*/

UPDATE biblioteca.USUARIO
SET status_usuario = 'INATIVO'
WHERE id_usuario = 1;
GO

EXEC biblioteca.sp_RegistrarEmprestimo
    @id_usuario = 1,
    @id_livro = 1,
    @data_prevista_devolucao = '2026-06-10';
GO