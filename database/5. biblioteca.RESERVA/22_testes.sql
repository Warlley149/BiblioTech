/*TESTES*/

--BUSCAR POR TÍTULO
EXEC biblioteca.sp_ConsultarLivros
    @titulo = 'Algoritmos';

--BUSCAR POR ISBN
EXEC biblioteca.sp_ConsultarLivros
    @isbn = '9788575226986';

--BUSCAR POR CATEGORIA
EXEC biblioteca.sp_ConsultarLivros
    @id_categoria = 1;

--BUSCAR SOMENTE DISPONÍVEIS
EXEC biblioteca.sp_ConsultarLivros
    @disponivel = 1;

--BUSCAR INDISPONÍVEIS
EXEC biblioteca.sp_ConsultarLivros
    @disponivel = 0;