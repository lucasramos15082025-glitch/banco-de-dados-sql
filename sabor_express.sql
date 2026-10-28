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
    categoria_id  INT NOT NULL,
    CONSTRAINT fk_pratos_categoria
		FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);


CREATE TABLE ficha_tecnica (
	id INT AUTO_INCREMENT PRIMARY KEY,
    ingredientes VARCHAR(100) NOT NULL,
    calorias DECIMAL NOT NULL,
    prato_id INT NOT NULL,
    CONSTRAINT fk_fichaTec_prato
		FOREIGN KEY (prato_id) REFERENCES prato(id)
);




CREATE TABLE pedido (
	id INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATETIME NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL,
    entregador_id INT NOT NULL,
    CONSTRAINT fk_pedido_entregador
		FOREIGN KEY (entregador_id) REFERENCES entregador(id)
);







CREATE TABLE item_pedido (
	id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    prato_id INT NOT NULL,
    CONSTRAINT fk_itemPedido_pedido
		FOREIGN KEY (pedido_id) REFERENCES pedido(id)
         ON DELETE CASCADE,	
    CONSTRAINT fk_itemPedido_prato
		FOREIGN KEY (prato_id) REFERENCES Prato(id),
	avaliacao FLOAT(10) NOT NULL
);



INSERT INTO categorias (nome) VALUES
('carbonara'),
('');