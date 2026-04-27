-- 1. Tabela de Categorias [cite: 152]
CREATE TABLE CATEGORIA (
                           id_categoria INT PRIMARY KEY IDENTITY(1,1), -- PK auto incremento [cite: 154]
                           nome VARCHAR(100) NOT NULL, [cite: 155]
                           descricao VARCHAR(255), [cite: 156]
    status_ativo BIT DEFAULT 1 [cite: 157]
);

-- 2. Tabela de Autores [cite: 159]
CREATE TABLE AUTOR (
                       id_autor INT PRIMARY KEY IDENTITY(1,1), [cite: 160]
                       nome VARCHAR(120) NOT NULL, [cite: 161]
    nacionalidade VARCHAR(50), [cite: 162]
    data_nascimento DATE [cite: 163]
);

-- 3. Tabela de Livros [cite: 165]
CREATE TABLE LIVRO (
                       id_livro INT PRIMARY KEY IDENTITY(1,1), [cite: 166]
                       titulo VARCHAR(200) NOT NULL, [cite: 168]
    isbn VARCHAR(20) UNIQUE NOT NULL, [cite: 169]
    ano_publicacao SMALLINT NOT NULL, [cite: 170]
    editora VARCHAR(120), [cite: 171]
    quantidade_total INT NOT NULL CHECK (quantidade_total > 0), [cite: 173, 60]
    quantidade_disponivel INT NOT NULL, [cite: 174]
    id_categoria INT FOREIGN KEY REFERENCES CATEGORIA(id_categoria) [cite: 175]
);

-- 4. Tabela Associativa (Muitos para Muitos entre Livro e Autor) [cite: 176]
CREATE TABLE LIVRO_AUTOR (
                             id_livro INT FOREIGN KEY REFERENCES LIVRO(id_livro), [cite: 179]
                             id_autor INT FOREIGN KEY REFERENCES AUTOR(id_autor), [cite: 180]
    PRIMARY KEY (id_livro, id_autor)
);