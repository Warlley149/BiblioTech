USE BiblioTechDB;
GO

CREATE OR ALTER PROCEDURE biblioteca.sp_RegistrarReserva
    @id_usuario INT,
    @id_livro INT,
    @data_reserva DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status_usuario VARCHAR(20);
    DECLARE @quantidade_disponivel INT;
    DECLARE @posicao_fila INT;

    IF NOT EXISTS (
        SELECT 1
        FROM biblioteca.USUARIO
        WHERE id_usuario = @id_usuario
    )
    BEGIN
        RAISERROR('Usuário não encontrado.', 16, 1);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM biblioteca.LIVRO
        WHERE id_livro = @id_livro
    )
    BEGIN
        RAISERROR('Livro não encontrado.', 16, 1);
        RETURN;
    END;

    SELECT @status_usuario = status_usuario
    FROM biblioteca.USUARIO
    WHERE id_usuario = @id_usuario;

    IF @status_usuario <> 'ATIVO'
    BEGIN
        RAISERROR('Somente usuários ATIVOS podem realizar reservas.', 16, 1);
        RETURN;
    END;

    SELECT @quantidade_disponivel = quantidade_disponivel
    FROM biblioteca.LIVRO
    WHERE id_livro = @id_livro;

    IF @quantidade_disponivel > 0
    BEGIN
        RAISERROR('Reserva permitida apenas para livro indisponível.', 16, 1);
        RETURN;
    END;

    IF EXISTS (
        SELECT 1
        FROM biblioteca.RESERVA
        WHERE id_usuario = @id_usuario
          AND id_livro = @id_livro
          AND status_reserva = 'ATIVA'
    )
    BEGIN
        RAISERROR('O usuário já possui reserva ativa para este livro.', 16, 1);
        RETURN;
    END;

    SELECT @posicao_fila = ISNULL(MAX(posicao_fila), 0) + 1
    FROM biblioteca.RESERVA
    WHERE id_livro = @id_livro
      AND status_reserva = 'ATIVA';

    INSERT INTO biblioteca.RESERVA (
        id_usuario,
        id_livro,
        data_reserva,
        status_reserva,
        posicao_fila
    )
    VALUES (
        @id_usuario,
        @id_livro,
        @data_reserva,
        'ATIVA',
        @posicao_fila
    );

    SELECT
        SCOPE_IDENTITY() AS id_reserva,
        @posicao_fila AS posicao_fila,
        'Reserva registrada com sucesso.' AS mensagem;
END;
GO