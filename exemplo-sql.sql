CREATE DATABASE ecommerce CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

USE ecommerce;

-- Entidade/tabela clientes

CREATE TABLE clientes (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);
-- Visualizar registros da nossa tabela
SELECT * FROM clientes;
-- INSERINDO REGISTROS
INSERT INTO clientes (nome, email, telefone)
VALUES
('Maria Silva', 'maria@gmail.com', '14979875487'),
('João Vitor', 'joao@email.com', '14478156825');

CREATE TABLE teste (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);
-- Apagar tabela
DROP TABLE teste;

CREATE TABLE categorias (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL
);

CREATE TABLE produtos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL (10, 2) NOT NULL,
    estoque INT DEFAULT 0,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

SELECT * FROM produtos;

INSERT INTO categorias (nome)
VALUES
('Periféricos'),
('Audio'),
('Informática');

SELECT * FROM categorias;

INSERT INTO produtos (nome, preco, estoque, categoria_id)
VALUES 
('Mouse Logitech', 400.00, 20, 1),
('Caixa de som JBL', 200.00, 2, 2),
('Monitor AlienWare', 3000.00, 15, 3),
('Teclado Redragon', 250.00, 10, 1),
('Headset HyperX', 350.00, 5, 2);

SELECT * FROM produtos;

CREATE TABLE pedidos (
	id 	INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE pedidos_has_produtos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT DEFAULT 1,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO pedidos (cliente_id)
VALUES 
(1),
(2);

SELECT * FROM produtos;

INSERT INTO pedidos_has_produtos (pedido_id, produto_id, quantidade, preco_unitario)
VALUES 
(1, 2, 1, 180.00), -- pedido 1 da Maria
(1, 4, 2, 250.00), -- pedido 1 da Maria (Maria comprou 2 produtos diferentes em um mesmo pedido) 
(2, 5, 1, 300.00); -- pedido 2 do Joao


select * from categorias;


select * from produtos;

-- alias (apelidos)
SELECT nome AS produtos, preco from produtos;

-- exibiir podutos com preco maior que 300 reais
SELECT * FROM produtos
WHERE preco >300;
 
 SELECT * FROM produtos
WHERE preco < 300;

-- exibiir podutos com nome seja iagual a teclado redragon
SELECT * FROM produtos
WHERE nome = 'teclado Redragon';


-- exibiir podutos que tenham preco menor que 250
-- ou estoque maior que 15
SELECT * FROM produtos
WHERE preco >= 250 AND estoque > 15;

-- exibiir podutos que tenham preco menor que 1000
-- e estoque maior que 15
SELECT * FROM produtos
WHERE preco >= 1000 OR estoque > 15;


SELECT * FROM produtos
WHERE estoque >= 10 AND estoque <= 20;

SELECT * FROM produtos
WHERE estoque BETWEEN 10 AND 20;

-- filtro para proucurar itens em uma lista ('Mouse legitech', 'Monitor AlienWere')
	SELECT * FROM produtos
    WHERE nome = 'Mouse legitech' or nome = 'Monitor AlienWere';
    
   SELECT * FROM produtos
    WHERE nome IN ('Mouse legitech', 'Monitor AlienWere'); 
    
    
    -- filtrar por partes de texto
    SELECT * FROM  produtos
    WHERE nome LIKE '%teclado%'; -- busca por um nome que cntenha teclado
    
       SELECT * FROM  produtos
    WHERE nome LIKE '%redragon%'; -- busca por um nome que cntenha redragon
    
    SELECT * FROM  produtos
    WHERE nome NOT LIKE '%teclado%'; -- busca por nomes que nao contenham teclado
    
    -- ordenando registros
    SELECT * FROM  produtos
    WHERE nome NOT LIKE '%teclado%'
    ORDER BY preco;
    
    
	SELECT * FROM  produtos
    WHERE nome NOT LIKE '%teclado%'
    ORDER BY preco DESC;
    
    SELECT * FROM  produtos
    WHERE nome NOT LIKE '%teclado%'
    ORDER BY preco ASC;
    
    SELECT * FROM  produtos
    WHERE nome NOT LIKE '%teclado%'
    ORDER BY preco ASC
    LIMIT 3; -- LIMITA A QUANTIDADE DE ITENS EXIBIDOS
    
    
    -- EXERCICIO 5 -----------------------------------------------------------------------------
    
    
    -- NIVEL 1
    
    SELECT * FROM produtos;
    
	SELECT nome AS produtos, preco from produtos;
    
    SELECT * FROM produtos
	WHERE preco > 500;
    
    
    -- nivel 2
    
    SELECT * FROM produtos
	WHERE estoque < 20
	ORDER BY preco ASC;
    

    SELECT * FROM  produtos
    WHERE nome LIKE '%ps5%';
    
    SELECT * FROM produtos
	ORDER BY preco DESC
    LIMIT 2;
    
    
    SELECT nome, preco, estoque, (preco * estoque) AS valor_total
    FROM produtos;
    
    SELECT nome, preco, estoque, (preco * estoque) AS valor_total
    FROM produtos
    ORDER BY valor_total ASC;
    
    -- funcao de agregacao
    
    -- quantos produtos diferentes temos em estoque
    SELECT COUNT(*) AS qtd_produto FROM produtos; 
    
    SELECT SUM(estoque) FROM prudutos;
    
    SELECT SUM(preco) FROM prudutos;
    
    SELECT SUM(estoque * preco) AS valor_total
    FROM produtos;
    
    SELECT AVG(estoque) from produtos ;
    
    select nome, max(estoque) from produtos; 
    
     select nome, min(estoque) from produtos;
     
      select nome, max(preco)as mais_caros, min(preco) as mais_barato  from produtos; 
      
      select
		max(preco) as mais_caro,
        min(oreco) as mais_barato,
        avg(preco) as media
        from produtos;
        
        select round(avg(preco), 2)-- comn o round consigo arredonda os numeros e defenir 2 numeros depois da virgula
        from produtos;-- calcular a media
        
        -- funcao de agregacao + filtros
        -- contar quantos produtos diferentes nos temos que tenham precos > 250
         select count(*)from produtos
        where preco > 250;
        
        select count(estoque) from produtos
        where preco > 250;