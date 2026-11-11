-- Lucas ramos
-- 2205072

-- Wander 
-- 2213535

-- João pedro
-- 2201566

DROP DATABASE IF EXISTS sabor_express;

CREATE DATABASE sabor_express CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

USE sabor_express;




CREATE TABLE categorias (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);



CREATE TABLE entregador (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(10) NOT NULL
);


CREATE TABLE prato (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco decimal NOT NULL,
    categoria_id  INT NULL,
    CONSTRAINT fk_pratos_categoria
		FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);


CREATE TABLE ficha_tecnica (
	id INT AUTO_INCREMENT PRIMARY KEY,
    ingredientes VARCHAR(100) NOT NULL,
    calorias DECIMAL NOT NULL,
    prato_id INT NULL,
    CONSTRAINT fk_fichaTec_prato
		FOREIGN KEY (prato_id) REFERENCES prato(id)
);




CREATE TABLE pedido (
	id INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATETIME NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL,
    entregador_id INT NULL,
    CONSTRAINT fk_pedido_entregador
		FOREIGN KEY (entregador_id) REFERENCES entregador(id)
);







CREATE TABLE item_pedido (
	id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT  NULL,
    prato_id INT NULL,
    CONSTRAINT fk_itemPedido_pedido
		FOREIGN KEY (pedido_id) REFERENCES pedido(id)
         ON DELETE CASCADE,	
    CONSTRAINT fk_itemPedido_prato
		FOREIGN KEY (prato_id) REFERENCES Prato(id),
	avaliacao DECIMAL(3, 1) CHECK (avaliacao >= 0 AND avaliacao <= 10)
);



SELECT * FROM categorias;

INSERT INTO categorias (nome) VALUES
('Massas'),
('Carnes'),
('Sobremesas');



SELECT * FROM entregador;

INSERT INTO entregador (nome, telefone) VALUES
('Wander', '9437964501'),
('Lucas', '1437274201'),
('Joao', '1439487601'),
('Marcelo', '1331523001');



SELECT * FROM prato;

INSERT INTO prato (nome, preco, categoria_id) VALUES
('Espaguete Carbonara', 28.00, 1),
('Lasanha Bolonhesa', 35.00, 1),
('Macarrao ao Molho Branco', 32.00, 1),
('Frango a Parmegiana', 38.00, 2),
('Bife Acebolado', 42.00, 2),
('Escondidinho de Carne', 29.00, 2),
('Nhoque ao Sugo', 25.00, 1),
('Ravioli de Queijo', 34.00, 1);



SELECT * FROM ficha_tecnica;

INSERT INTO ficha_tecnica (ingredientes, calorias, prato_id) VALUES
('Espaguete, bacon, ovos e queijo', 520, 1),
('Massa, carne moida, molho e queijo', 650, 2),
('Macarrao, creme de leite e queijo', 480, 3),
('Frango, molho de tomate e queijo', 700, 4),
('Carne bovina, cebola e temperos', 600, 5),
('Pure de mandioca e carne moida', 550, 6);




SELECT * FROM pedido;

INSERT INTO pedido (data_pedido, nome_cliente, entregador_id) VALUES
('2026-10-20 12:00:00', 'Ana Silva', NULL),
('2026-10-20 12:30:00', 'Bruno Costa', 2),
('2026-10-20 13:00:00', 'Carla Souza', 3),
('2026-10-20 13:30:00', 'Diego Lima', 3),
('2026-10-20 14:00:00', 'Marina Alves', 4);



select * from item_pedido;


INSERT INTO item_pedido (pedido_id, prato_id, avaliacao) VALUES
(1, 1, 9.0),
(1, 2, 6.0),
(1, 3, 8.0),
(2, 4, 5.0),
(2, 5, 9.5),
(3, 6, 4.0),
(3, 7, 8.5),
(3, 1, 7.0),
(4, 2, 6.5),
(4, 4, 9.0);




-- 1

SELECT p.nome AS prato, p.preco, c.nome AS categoria

FROM prato p

INNER JOIN categorias c ON p.categoria_id = c.id

WHERE p.preco > 30.00

ORDER BY p.preco DESC;

-- 2

SELECT pd.data_pedido, pd.nome_cliente, e.nome AS entregador

FROM pedido pd

LEFT JOIN entregador e ON pd.entregador_id = e.id;

-- 3

SELECT e.nome AS entregador

FROM entregador e

LEFT JOIN pedido ped ON e.id = ped.entregador_id

WHERE ped.id IS NULL;

-- 4

SELECT p.nome AS prato, c.nome AS categoria

FROM prato p

INNER JOIN categorias c ON p.categoria_id = c.id

LEFT JOIN ficha_tecnica ft ON p.id = ft.prato_id

WHERE ft.id IS NULL;

-- 5

SELECT p.nome AS prato

FROM prato p

LEFT JOIN item_pedido ip ON p.id = ip.prato_id

WHERE ip.id IS NULL;



-- 6

SELECT pedido.nome_cliente, prato.nome AS prato, item_pedido.avaliacao
FROM item_pedido
INNER JOIN pedido ON item_pedido.pedido_id = pedido.id
INNER JOIN prato ON item_pedido.prato_id = prato.id
WHERE item_pedido.avaliacao < 7
ORDER BY item_pedido.avaliacao ASC;


-- 7

SELECT pedido.data_pedido, pedido.nome_cliente
FROM pedido
LEFT JOIN item_pedido ON pedido.id = item_pedido.pedido_id
WHERE item_pedido.id IS NULL;


-- 8

SELECT categorias.nome
FROM categorias
LEFT JOIN prato ON categorias.id = prato.categoria_id
WHERE prato.id IS NULL;


-- 9

SELECT prato.nome, COUNT(item_pedido.id) AS vezes_pedido
FROM prato
LEFT JOIN item_pedido ON prato.id = item_pedido.prato_id
GROUP BY prato.id, prato.nome;


-- 10

SELECT categorias.nome, COUNT(prato.id) AS quantidade_pratos
FROM categorias
LEFT JOIN prato ON categorias.id = prato.categoria_id
GROUP BY categorias.id, categorias.nome
ORDER BY quantidade_pratos DESC;


-- 11 A

SELECT pedido.data_pedido, pedido.nome_cliente, entregador.nome AS entregador
FROM entregador
RIGHT JOIN pedido ON entregador.id = pedido.entregador_id;


-- 11 B

SELECT pedido.data_pedido, pedido.nome_cliente, entregador.nome AS entregador
FROM pedido
LEFT JOIN entregador ON pedido.entregador_id = entregador.id;