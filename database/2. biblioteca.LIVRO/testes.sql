/*TESTES PARA O CADASTRO DE LIVROS, AUTORES E CATEGORIAS*/

--Primeiro, veja se você já tem categorias e autores cadastrados:
USE BiblioTechDB;
GO

SELECT *
FROM biblioteca.CATEGORIA
ORDER BY id_categoria;

SELECT *
FROM biblioteca.AUTOR
ORDER BY id_autor;
GO

-- Conferir livros já cadastrados
USE BiblioTechDB;
GO

SELECT *
FROM biblioteca.LIVRO
ORDER BY id_livro;
GO

--  Inserir um livro válido
USE BiblioTechDB;
GO

INSERT INTO biblioteca.LIVRO
(
    titulo,
    isbn,
    ano_publicacao,
    editora,
    quantidade_total,
    quantidade_disponivel,
    id_categoria
)
VALUES
(
    'O Cortico',
    '9788535909553',
    1890,
    'Editora Exemplo',
    4,
    4,
    1
);
GO

--Ver o livro inserido
USE BiblioTechDB;
GO

SELECT *
FROM biblioteca.LIVRO
WHERE isbn = '9788535909553';
GO

-- Vincular livro a autor
USE BiblioTechDB;
GO

SELECT id_livro, titulo
FROM biblioteca.LIVRO
ORDER BY id_livro;

SELECT id_autor, nome
FROM biblioteca.AUTOR
ORDER BY id_autor;
GO

-- Depois faça o vínculo, ajustando os IDs se necessário
USE BiblioTechDB;
GO

INSERT INTO biblioteca.LIVROAUTOR (id_livro, id_autor)
VALUES (3, 1);
GO

--Livro com categoria
USE BiblioTechDB;
GO

SELECT
    l.id_livro,
    l.titulo,
    l.isbn,
    l.ano_publicacao,
    l.editora,
    l.quantidade_total,
    l.quantidade_disponivel,
    c.nome AS categoria
FROM biblioteca.LIVRO l
INNER JOIN biblioteca.CATEGORIA c
    ON l.id_categoria = c.id_categoria
ORDER BY l.titulo;
GO

--Livro com autor
USE BiblioTechDB;
GO

SELECT
    l.id_livro,
    l.titulo,
    a.id_autor,
    a.nome AS autor
FROM biblioteca.LIVROAUTOR la
INNER JOIN biblioteca.LIVRO l
    ON la.id_livro = l.id_livro
INNER JOIN biblioteca.AUTOR a
    ON la.id_autor = a.id_autor
ORDER BY l.titulo, a.nome;
GO

-- Consulta completa do cadastro de livro
USE BiblioTechDB;
GO

SELECT
    l.id_livro,
    l.titulo,
    l.isbn,
    l.ano_publicacao,
    l.editora,
    l.quantidade_total,
    l.quantidade_disponivel,
    c.nome AS categoria,
    a.nome AS autor
FROM biblioteca.LIVRO l
INNER JOIN biblioteca.CATEGORIA c
    ON l.id_categoria = c.id_categoria
INNER JOIN biblioteca.LIVROAUTOR la
    ON l.id_livro = la.id_livro
INNER JOIN biblioteca.AUTOR a
    ON la.id_autor = a.id_autor
ORDER BY l.titulo, a.nome;
GO