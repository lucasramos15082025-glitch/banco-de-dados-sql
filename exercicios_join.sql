USE faculdade;

select * from cursos;


-- 1

SELECT a.nome, c.nome 
FROM alunos a
INNER JOIN cursos c ON a.curso_id  = c.id
WHERE c.nome = 'Análise e Desenvolvimento de Sistemas';

-- 2

SELECT d.nome AS disciplinas ,  p.nome AS professor 
FROM disciplinas d
LEFT JOIN professores p ON d.professor_id = p.id;


-- 3

SELECT d.nome
FROM professores p
RIGHT JOIN disciplinas d ON d.professor_id= p.id 
WHERE p.id IS NULL;


-- 4

select * from professores;
select * from disciplinas;

SELECT p.nome
FROM disciplinas d
RIGHT JOIN professores p ON p.id = d.professor_id
WHERE d.id IS NULL;


-- 5
select * from cursos;
SELECT  * FROM alunos;


 SELECT * 
 FROM alunos a
 left join carteirinhas c ON a.id = c.aluno_id
 WHERE c.id IS NULL;
 
 
 -- 6
 
 SELECT * FROM matriculas;
 
 SELECT * 
 FROM alunos a
 LEFT JOIN matriculas m on a.id = c.id
 WHERE c.nota < 7;