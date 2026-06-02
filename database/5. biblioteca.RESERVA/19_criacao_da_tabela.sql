USE BiblioTechDB;
GO

IF OBJECT_ID('biblioteca.RESERVA', 'U') IS NULL
BEGIN
    CREATE TABLE biblioteca.RESERVA (
        id_reserva INT IDENTITY(1,1) PRIMARY KEY,
        id_usuario INT NOT NULL,
        id_livro INT NOT NULL,
        data_reserva DATETIME2 NOT NULL,
        status_reserva VARCHAR(20) NOT NULL,
        posicao_fila INT NOT NULL,

        CONSTRAINT FK_RESERVA_USUARIO
            FOREIGN KEY (id_usuario) REFERENCES biblioteca.USUARIO(id_usuario),

        CONSTRAINT FK_RESERVA_LIVRO
            FOREIGN KEY (id_livro) REFERENCES biblioteca.LIVRO(id_livro),

        CONSTRAINT CK_RESERVA_STATUS
            CHECK (status_reserva IN ('ATIVA', 'CANCELADA', 'ATENDIDA')),

        CONSTRAINT CK_RESERVA_POSICAO
            CHECK (posicao_fila > 0)
    );
END;
GO