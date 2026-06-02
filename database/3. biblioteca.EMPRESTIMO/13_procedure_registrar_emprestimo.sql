/*
   Script: 13_procedure_registrar_emprestimo.sql
   Objetivo: registrar um empréstimo com validações e atualização de estoque
*/

USE BiblioTechDB;
GO

CREATE OR ALTER PROCEDURE biblioteca.sp_RegistrarEmprestimo
    @id_usuario INT,
    @id_livro INT,
    @data_prevista_devolucao DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @status_usuario VARCHAR(20);
        DECLARE @quantidade_disponivel INT;

        -- Verifica o usuário
        SELECT @status_usuario = status_usuario
        FROM biblioteca.USUARIO
        WHERE id_usuario = @id_usuario;

        IF @status_usuario IS NULL
        BEGIN
            RAISERROR('Usuário não encontrado.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @status_usuario <> 'ATIVO'
        BEGIN
            RAISERROR('Somente usuários ATIVOS podem realizar empréstimo.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Verifica o livro
        SELECT @quantidade_disponivel = quantidade_disponivel
        FROM biblioteca.LIVRO
        WHERE id_livro = @id_livro;

        IF @quantidade_disponivel IS NULL
        BEGIN
            RAISERROR('Livro não encontrado.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @quantidade_disponivel <= 0
        BEGIN
            RAISERROR('Não há exemplares disponíveis para este livro.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insere o empréstimo
        INSERT INTO biblioteca.EMPRESTIMO
        (
            id_usuario,
            id_livro,
            data_emprestimo,
            data_prevista_devolucao,
            status_emprestimo
        )
        VALUES
        (
            @id_usuario,
            @id_livro,
            SYSDATETIME(),
            @data_prevista_devolucao,
            'EMABERTO'
        );

        -- Atualiza disponibilidade
        UPDATE biblioteca.LIVRO
        SET quantidade_disponivel = quantidade_disponivel - 1
        WHERE id_livro = @id_livro;

        COMMIT TRANSACTION;

        PRINT 'Empréstimo registrado com sucesso.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @MensagemErro NVARCHAR(4000);
        SET @MensagemErro = ERROR_MESSAGE();

        RAISERROR(@MensagemErro, 16, 1);
    END CATCH
END
GO

------

EXEC biblioteca.sp_RegistrarEmprestimo
    @id_usuario = 1,
    @id_livro = 1,
    @data_prevista_devolucao = '2026-06-10';