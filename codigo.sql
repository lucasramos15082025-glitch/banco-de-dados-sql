CREATE DATABASE biblioteca CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE biblioteca;




CREATE TABLE autores (
id_autor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL
);




CREATE TABLE categorias (
id_categoria INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL
);




CREATE TABLE livros (
id_livro INT PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR(150) NOT NULL,
ano_publicacao INT,
id_categoria INT,
FOREIGN KEY (id_categoria)
REFERENCES categorias(id_categoria)
);




CREATE TABLE livro_autor (
id_livro INT,
id_autor INT,
PRIMARY KEY (id_livro, id_autor),
FOREIGN KEY (id_livro)
REFERENCES livros(id_livro),
FOREIGN KEY (id_autor)
REFERENCES autores(id_autor)
);




CREATE TABLE usuarios (
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
telefone VARCHAR(20)
);





CREATE TABLE emprestimos (
id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT,
id_livro INT,
data_emprestimo DATE NOT NULL,
data_devolucao DATE,
FOREIGN KEY (id_usuario)
REFERENCES usuarios(id_usuario),
FOREIGN KEY (id_livro)
REFERENCES livros(id_livro)
);




INSERT INTO autores (nome) VALUES
('Machado de Assis'),
('Jorge Amado'),
('Clarice Lispector'),
('J. K. Rowling');





INSERT INTO categorias (nome) VALUES
('Romance'),
('Literatura Brasileira'),
('Fantasia'),
('Ficção');




INSERT INTO livros (titulo, ano_publicacao, id_categoria) VALUES
('Dom Casmurro', 1899, 2),
('Capitães da Areia', 1937, 2),
('Harry Potter e a Pedra Filosofal', 1997, 3),
('A Hora da Estrela', 1977, 1);






INSERT INTO livro_autor (id_livro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 4),
(4, 3);




INSERT INTO usuarios (nome, email, telefone) VALUES
('João Silva', 'joao@gmail.com', '14999990001'),
('Maria Oliveira', 'maria@gmail.com', '14999990002'),
('Pedro Santos', 'pedro@gmail.com', '14999990003'),
('Ana Souza', 'ana@gmail.com', '14999990004');




INSERT INTO emprestimos
(id_usuario, id_livro, data_emprestimo, data_devolucao)
VALUES
(1, 1, '2026-09-01', '2026-09-15'),
(2, 3, '2026-09-03', '2026-09-17'),
(3, 2, '2026-09-05', '2026-09-19'),
(4, 4, '2026-09-07', '2026-09-21');




SELECT * FROM autores;

SELECT * FROM categorias;

SELECT * FROM livros;

SELECT * FROM livro_autor;

SELECT * FROM usuarios;

SELECT * FROM emprestimos;