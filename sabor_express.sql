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