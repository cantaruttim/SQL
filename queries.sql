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
SELECT * FROM banco.produtos;

SELECT p.ID_Produto,
	   prod.Nome_Produto AS "Produto", prod.Marca_Produto AS "Marca"
FROM pedidos p
	LEFT JOIN produtos prod
    ON p.ID_Produto = prod.ID_Produto
;


-- PROCEDURES
-- Procedure para criação de login de usuários
DELIMITER &&
CREATE PROCEDURE registros(IN idCliente INT, OUT resultado VARCHAR(50))
BEGIN

    DECLARE nomeCliente VARCHAR(50);
    DECLARE sobrenomeCliente VARCHAR(50);
    
    -- seleciona o nome do cliente
    SET nomeCliente = (SELECT Nome FROM clientes WHERE idCliente = ID_Cliente);
    -- seleciona o sobrenome do cliente
    SET sobrenomeCliente = (SELECT Sobrenome FROM clientes WHERE idCliente = ID_Cliente);
    
    -- concatena o nome com o sobrenome e gera um login
    SET resultado = CONCAT(nomeCliente, ".", sobrenomeCliente);
    
END &&

DELIMITER ;

CALL registros(15, @resultado);
SELECT @resultado AS LoginCliente;

SELECT * FROM clientes;




DROP PROCEDURE IF EXISTS idade;
DELIMITER &&
CREATE PROCEDURE idade(IN idCliente INT, OUT idade INT, OUT res VARCHAR(20))
BEGIN
	DECLARE dt INT;
    
    SET dt = (SELECT CAST(EXTRACT(YEAR FROM Data_Nascimento) AS REAL) FROM clientes WHERE idCliente = ID_Cliente);
    SET idade = YEAR(NOW()) - dt;
    
    IF (idade >= 18) THEN
		SET res = 'Maior';
	ELSE
		SET res = 'Menor';
	END IF;


END &&

DELIMITER ;

CALL idade(2, @idadecliente, @resultado);
SELECT @idadecliente,@resultado;







-----------------------------------------------------------

-- TABLES
CREATE TABLE client (
	Client_ID INT PRIMARY KEY,
  	Name VARCHAR(100),
    Surname VARCHAR(100),
    Age INT,
    Gender CHAR(1)
);

CREATE TABLE sales (
	Sales_ID INT PRIMARY KEY,
    data_venda VARCHAR(10),
    hora_venda VARCHAR(10),
    pk_cliente INT,
  	FOREIGN KEY (pk_cliente) REFERENCES client(Client_ID) 
);

-- CLIENT TABLE
INSERT INTO client VALUES (1, "Matheus", "Barbosa", 15, "M");
INSERT INTO client VALUES (2, "Lucas", "Feitosa", 23, "M");
INSERT INTO client VALUES (3, "Fernanda", "Fernandez", 35, "F");
INSERT INTO client VALUES (4, "Júlia", "Silva", 40, "F");
INSERT INTO client VALUES (5, "Bruna", "Teixeira", 33, "F");
INSERT INTO client VALUES (6, "Vitor", "Santos", 15, "M");
INSERT INTO client VALUES (7, "Victória", "Gular", 25, "F");
INSERT INTO client VALUES (8, "Fernando", "Daniel", 23, "M");
INSERT INTO client VALUES (9, "Alef", "Almeida", 68, "M");
INSERT INTO client VALUES (10, "Alexandra", "Silva", 55, "F");
INSERT INTO client VALUES (11, "Lucas", "Barbosa", 24, "M");
INSERT INTO client VALUES (12, "Suzana", "Xavier", 55, "F");
INSERT INTO client VALUES (13, "Wellington", "Justos", 45, "M");
INSERT INTO client VALUES (14, "Silvio", "Oliveira", 35, "M");
INSERT INTO client VALUES (15, "Selma", "Almeida", 23, "F");


-- SALE TABLE
INSERT INTO sales VALUES (1, "26-12-2023", "09:10", 1);
INSERT INTO sales VALUES (2, "26-12-2023", "09:15", 2);
INSERT INTO sales VALUES (3, "26-12-2023", "09:30", 3);
INSERT INTO sales VALUES (4, "26-12-2023", "09:40", 4);
INSERT INTO sales VALUES (5, "26-12-2023", "09:45", 6);
INSERT INTO sales VALUES (6, "26-12-2023", "10:00", 5);
INSERT INTO sales VALUES (7, "26-12-2023", "10:05", 7);
INSERT INTO sales VALUES (8, "26-12-2023", "10:10", 8);
INSERT INTO sales VALUES (9, "26-12-2023", "10:20", 9);
INSERT INTO sales VALUES (10, "26-12-2023", "10:30", 10);
INSERT INTO sales VALUES (11, "26-12-2023", "10:31", 11);
INSERT INTO sales VALUES (12, "26-12-2023", "10:32", 13);
INSERT INTO sales VALUES (13, "26-12-2023", "10:33", 4);
INSERT INTO sales VALUES (14, "26-12-2023", "10:33", 2);
INSERT INTO sales VALUES (15, "26-12-2023", "10:35", 3);
INSERT INTO sales VALUES (16, "26-12-2023", "10:35", 7);
INSERT INTO sales VALUES (17, "26-12-2023", "11:30", 6);
INSERT INTO sales VALUES (18, "26-12-2023", "12:00", 5);
INSERT INTO sales VALUES (19, "26-12-2023", "12:10", 4);
INSERT INTO sales VALUES (20, "26-12-2023", "12:10", 2);
INSERT INTO sales VALUES (21, "26-12-2023", "12:35", 3);
INSERT INTO sales VALUES (22, "26-12-2023", "13:00", 4);
INSERT INTO sales VALUES (23, "26-12-2023", "13:10", 5);
INSERT INTO sales VALUES (24, "26-12-2023", "13:15", 6);
INSERT INTO sales VALUES (25, "26-12-2023", "13:20", 8);
