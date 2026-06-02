USE BiblioTechDB;
GO

CREATE OR ALTER PROCEDURE biblioteca.sp_RegistrarDevolucao
    @id_emprestimo INT,
    @data_devolucao DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @status_emprestimo VARCHAR(20);
        DECLARE @data_emprestimo DATETIME2;
        DECLARE @data_prevista_devolucao DATE;
        DECLARE @id_livro INT;
        DECLARE @dias_atraso INT;
        DECLARE @valor_multa DECIMAL(10,2);

        -- Busca os dados do empréstimo
        SELECT
            @status_emprestimo = status_emprestimo,
            @data_emprestimo = data_emprestimo,
            @data_prevista_devolucao = data_prevista_devolucao,
            @id_livro = id_livro
        FROM biblioteca.EMPRESTIMO
        WHERE id_emprestimo = @id_emprestimo;

        -- Valida se o empréstimo existe
        IF @status_emprestimo IS NULL
        BEGIN
            RAISERROR('Empréstimo não encontrado.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Valida se o empréstimo está em aberto
        IF @status_emprestimo <> 'EMABERTO'
        BEGIN
            RAISERROR('Somente empréstimos EMABERTO podem ser devolvidos.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Valida a data da devolução
        IF @data_devolucao < @data_emprestimo
        BEGIN
            RAISERROR('A data de devolução não pode ser anterior à data do empréstimo.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Calcula dias de atraso
        SET @dias_atraso = DATEDIFF(DAY, @data_prevista_devolucao, CAST(@data_devolucao AS DATE));

        IF @dias_atraso < 0
            SET @dias_atraso = 0;

        -- Regra de multa simples: R$ 2,00 por dia de atraso
        SET @valor_multa = @dias_atraso * 2.00;

        -- Atualiza o empréstimo
        UPDATE biblioteca.EMPRESTIMO
        SET
            data_devolucao = @data_devolucao,
            status_emprestimo = 'DEVOLVIDO'
        WHERE id_emprestimo = @id_emprestimo;

        -- Devolve o exemplar ao estoque
        UPDATE biblioteca.LIVRO
        SET quantidade_disponivel = quantidade_disponivel + 1
        WHERE id_livro = @id_livro;

        -- Se houve atraso, registra multa
        IF @dias_atraso > 0
        BEGIN
            INSERT INTO biblioteca.MULTA
            (
                id_emprestimo,
                dias_atraso,
                valor_multa,
                status_multa
            )
            VALUES
            (
                @id_emprestimo,
                @dias_atraso,
                @valor_multa,
                'PENDENTE'
            );
        END

        COMMIT TRANSACTION;

        PRINT 'Devolução registrada com sucesso.';
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