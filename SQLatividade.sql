CREATE DATABASE biblioteca CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

USE biblioteca;

 CREATE TABLE livros (
	iSBN INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    data_lancamento DATETIME NOT NULL
    
 );
 
 CREATE TABLE autores (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    data_nascimento DATETIME NOT NULL
 );
 
 CREATE TABLE usuarios(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20)
 );
 
 CREATE TABLE emprestimos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATETIME NOT NULL,
    id_usuario INT NOT NULL,
    isbn_livro INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (isbn_livro) REFERENCES livro(isbn)
);

CREATE TABLE categoria_livros(
	id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
	isbn_livro INT NOT NULL,
	FOREIGN KEY (isbn_livro) REFERENCES livro(isbn)
);

select * from livros;