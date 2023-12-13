USE banco;
-- DESCRIBE categorias; #df.info() do python
DESCRIBE produtos;

SELECT * FROM categorias;
SELECT * FROM clientes;
DESC clientes;
SELECT * FROM locais;
SELECT * FROM lojas;
SELECT * FROM pedidos;
SELECT * FROM produtos;

-- uso do WHERE
/* Aqui conto todos os registros dos clientes do sexo Masculino, que possuem renda anual maior que 60000 e seja */
SELECT 
		Nome,
        Sobrenome,
        Email,
        Telefone,
		Sexo
FROM clientes
WHERE 
	Renda_Anual > 60000
    AND Sexo = "M"
	AND Qtd_Filhos >= 1
GROUP BY Nome, Sobrenome, Email, Telefone, Sexo;

SELECT
	Nome,
    Telefone,
	Escolaridade,
    Qtd_Filhos
FROM clientes
WHERE
	Escolaridade = "Pós-graduado"
    AND Qtd_Filhos BETWEEN 2 AND 3
;

SELECT
	Nome,
    Sobrenome,
    Telefone,
	Escolaridade,
    Email
FROM clientes
WHERE
	-- Apenas emails com domínio gmail e possuem entre 2 e 3 filhos
	Email LIKE "%@gmail%"
    AND Qtd_Filhos BETWEEN 2 AND 3 AND Renda_Anual > 50000
;

SELECT
	Nome,
    Sobrenome,
    Telefone,
    Email,
	Estado_Civil AS "Estado Civil"
FROM clientes
WHERE 
	Escolaridade IN (
		"Pós-graduado",
        "Graduação"
        )
	AND Estado_Civil = "C"
;

-- uso do SUM
SELECT * FROM pedidos;

SELECT 
	EXTRACT(MONTH FROM Data_Venda) AS "Mês da Venda",
    SUM(Receita_Venda) AS "Receita Total",
    AVG(Receita_Venda) AS "Receita Médida",
    SUM(Custo_Venda) AS "Custo Total"
FROM pedidos
GROUP BY 1
ORDER BY 1
;

-- uso do JOIN
-- Clientes e Pedidos
SELECT * FROM clientes;
SELECT * FROM pedidos;
DESC pedidos;
   
    
SELECT 
	ID_Cliente,
	Receita_Venda 
FROM pedidos
WHERE ID_Cliente = 16;


SELECT 
	c.ID_Cliente
	,c.Nome
    , c.Sobrenome
    , c.Renda_Anual AS "Renda Anual"
    , p.Receita_Venda AS "Venda"
FROM clientes c
	INNER JOIN pedidos p
		ON c.ID_Cliente = p.ID_Cliente
GROUP BY c.ID_Cliente, c.Nome, c.Sobrenome, c.Renda_Anual, 
		 p.Receita_Venda
ORDER BY Renda_Anual DESC
;



SELECT 
	c.Nome
    , c.Sobrenome
    , c.Renda_Anual
    , p.Receita_Venda
FROM clientes c
	RIGHT JOIN pedidos p
		ON c.ID_Cliente = p.ID_Cliente
;


-- TRUNCATE TABLE
USE banco;

DROP TABLE IF EXISTS books;
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

DELIMITER $$
CREATE PROCEDURE load_book_data(IN num INT(4))
BEGIN
	DECLARE counter INT(4) DEFAULT 0;
	DECLARE book_title VARCHAR(255) DEFAULT '';

	WHILE counter < num DO
	  SET book_title = CONCAT('Book title #',counter);
	  SET counter = counter + 1;

	  INSERT INTO books(title)
	  VALUES(book_title);
	END WHILE;
END$$
DELIMITER ;

CALL load_book_data(10000);
SELECT * FROM banco.books;

TRUNCATE TABLE banco.books;

SELECT * FROM banco.books;
