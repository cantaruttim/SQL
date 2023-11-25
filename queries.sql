USE banco;
-- DESCRIBE categorias; #df.info() do python
DESCRIBE produtos;

SELECT COUNT(*) AS "Registros", SUM(Preco_unit) AS "R$ Unitário"
FROM produtos; 

SELECT Sexo, COUNT(*) AS "Registros"
FROM clientes
GROUP BY Sexo;

SELECT 
	Marca_Produto AS "Marca", 
    COUNT(*) AS "Registros"
FROM produtos
GROUP BY Marca_Produto
ORDER BY COUNT(*) DESC;

SELECT
	COUNT(*) AS "Registros",
    ID_Loja AS "Loja",
 	SUM(Receita_Venda) AS "Receita Total",
    SUM(Custo_Venda) AS "Custo Total"
FROM pedidos
GROUP BY ID_Loja
ORDER BY SUM(Receita_Venda) DESC;

SELECT 
	COUNT(*) AS "Registros Totais na Tabela de Clientes",
    COUNT(Telefone) AS "Telefones Registrados",
    COUNT(DISTINCT Sexo) AS "# Registros por Sexo",
    COUNT(DISTINCT Escolaridade) AS "# Registros por Escolaridade",
    SUM(Renda_Anual) AS "Renda Anual Total",
    AVG(Renda_Anual) AS "Média Anual",
    MIN(Renda_Anual) AS "Renda Mínima",
    MAX(Renda_Anual) AS "Renda Máxima"
FROM clientes;

SELECT
	Escolaridade,
    COUNT(Escolaridade) AS "Contagem Escolaridade",
	COUNT(DISTINCT Escolaridade) AS "Registros únicos"
FROM clientes
GROUP BY Escolaridade
ORDER BY COUNT(Escolaridade) DESC;

/*
SELECT Data_Nascimento as "Nascimento" 
FROM clientes
ORDER BY Data_Nascimento DESC
LIMIT 5;

-- selecionando dados vazios
SELECT 
	Nome, Sobrenome, Telefone
FROM clientes
WHERE Telefone IS NULL
ORDER BY Nome;

SELECT * FROM produtos
ORDER BY Preco_unit DESC; #DEFAULT ASC

*/