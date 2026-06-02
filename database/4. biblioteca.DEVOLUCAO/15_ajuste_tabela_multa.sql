USE BiblioTechDB;
GO

IF OBJECT_ID('biblioteca.MULTA', 'U') IS NULL
BEGIN
    CREATE TABLE biblioteca.MULTA
    (
        id_multa INT IDENTITY(1,1) NOT NULL,
        id_emprestimo INT NOT NULL,
        dias_atraso INT NOT NULL,
        valor_multa DECIMAL(10,2) NOT NULL,
        status_multa VARCHAR(20) NOT NULL,

        CONSTRAINT PK_MULTA
            PRIMARY KEY (id_multa),

        CONSTRAINT FK_MULTA_EMPRESTIMO
            FOREIGN KEY (id_emprestimo)
            REFERENCES biblioteca.EMPRESTIMO (id_emprestimo),

        CONSTRAINT CK_MULTA_DIAS_ATRASO
            CHECK (dias_atraso >= 0),

        CONSTRAINT CK_MULTA_VALOR
            CHECK (valor_multa >= 0),

        CONSTRAINT CK_MULTA_STATUS
            CHECK (status_multa IN ('PENDENTE', 'PAGA', 'CANCELADA'))
    );
END
GO