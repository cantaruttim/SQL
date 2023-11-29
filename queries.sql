DROP TABLE IF EXISTS products;
CREATE TABLE products (
  idProduct INT,
  nameProduct VARCHAR(100),
  categoryProduct VARCHAR(100),
  quantityProduct INT,
  priceProduct FLOAT(10,2),
  order_date DATE
  
);

INSERT INTO products VALUES 
	(1, "Television", "Eletronic", 1500, 5000.00, "2020-05-10"),
    (2, "Toaster", "Eletronic", 2500, 15000.00, "2020-05-11"),
    (3, "Notebook", "Eletronic", 3000, 3800.00, "2020-05-10"),
    (4, "Paper Book", "Stationery", 15000, 10.00,"2020-05-12"), 
    (5, "Digital Blackboard", "Stationery", 1000, 15000.50, "2020-05-11"),
    (6, "Battery", "Stationery", 1000, 25.75, "2020-05-12"),
    (7, "Controller", "Game", 1000, 55.75, "2020-05-11"),
    (8, "God of War 5", "Game", 1500, 35.00, "2020-05-10"),
    (9, "IPhone", "Eletronic", 1500, 1335.00, "2020-05-13"),
    (10, "Game Chair", "Office", 1000, 800.00, "2020-05-10");


SELECT order_date 
 , SUM(CASE WHEN categoryProduct = "Eletronic" THEN priceProduct
       ELSE "-"
       END) AS "Eletronic Amount"
 , SUM(CASE WHEN categoryProduct = "Stationery" THEN priceProduct
       ELSE "-"
       END) AS "Stationery Amount"
 , SUM(CASE WHEN categoryProduct = "Game" THEN priceProduct
       ELSE "-"
       END) AS "Game Amount"
 , SUM(CASE WHEN categoryProduct = "Office" THEN priceProduct
       ELSE "-"
       END) AS "Office Amount"
 FROM products
 GROUP BY 1
 ;




-------



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
