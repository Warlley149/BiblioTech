/*
   Script: 11_tabela_livro_autor.sql
   Objetivo: criar a tabela de associação entre LIVRO e AUTOR
*/

USE BiblioTechDB;
GO

CREATE TABLE biblioteca.LIVROAUTOR
(
    -- Identificador único do relacionamento livro-autor
    id_livro_autor INT IDENTITY(1,1) NOT NULL,

    -- Livro relacionado
    id_livro INT NOT NULL,

    -- Autor relacionado
    id_autor INT NOT NULL,

    CONSTRAINT PK_LIVROAUTOR
        PRIMARY KEY (id_livro_autor),

    CONSTRAINT FK_LIVROAUTOR_LIVRO
        FOREIGN KEY (id_livro)
        REFERENCES biblioteca.LIVRO (id_livro),

    CONSTRAINT FK_LIVROAUTOR_AUTOR
        FOREIGN KEY (id_autor)
        REFERENCES biblioteca.AUTOR (id_autor),

    -- Impede cadastro duplicado do mesmo par livro + autor
    CONSTRAINT UQ_LIVROAUTOR_LIVRO_AUTOR
        UNIQUE (id_livro, id_autor)
);
GO

/* 
   Comentários:
   - A tabela LIVROAUTOR é uma tabela de associação que relaciona livros e autores, permitindo um relacionamento muitos-para-muitos.
   - Cada registro na tabela representa a relação entre um livro e um autor específico.
   - O campo id_livro_autor é um identificador único para cada relacionamento, auto-incrementado.
   - Os campos id_livro e id_autor são chaves estrangeiras que referenciam as tabelas LIVRO e AUTOR, respectivamente.
   - A restrição UNIQUE garante que o mesmo par livro-autor não seja cadastrado mais de uma vez.
 */

 /*TESTES*/

 USE BiblioTechDB;
GO

SELECT * FROM biblioteca.LIVRO ORDER BY id_livro;
SELECT * FROM biblioteca.AUTOR ORDER BY id_autor;
GO

INSERT INTO biblioteca.LIVROAUTOR (id_livro, id_autor)
VALUES (1, 1);
GO

INSERT INTO biblioteca.LIVROAUTOR (id_livro, id_autor)
VALUES 
    (1, 1),
    (2, 3);
GO

USE BiblioTechDB;
GO

SELECT
    la.id_livro_autor,
    l.titulo AS titulo_livro,
    a.nome AS nome_autor
FROM biblioteca.LIVROAUTOR la
INNER JOIN biblioteca.LIVRO l
    ON la.id_livro = l.id_livro
INNER JOIN biblioteca.AUTOR a
    ON la.id_autor = a.id_autor
ORDER BY l.titulo, a.nome;
GO

USE BiblioTechDB;
GO

