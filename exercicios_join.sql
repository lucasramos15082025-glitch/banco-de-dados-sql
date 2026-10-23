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
 LEFT JOIN matriculas m on a.id = m.id
 WHERE m.nota < 7;
 
 
 -- 7
 select * from disciplinas;
 select * from alunos;
 
 SELECT *
 FROM disciplinas d
 LEFT JOIN alunos a ON d.id = a.curso_id
 where a.id is null;
 
 select * from matriculas;
 
 -- 8
 
  SELECT *
 FROM alunos a 
 LEFT JOIN matriculas m ON a.id = m.disciplina_id 
 where m.id is null;
 
 
 
 -- 9 
 

 SELECT c.nome AS cursos, COUNT(a.id) AS qtd_alunos
FROM cursos c
LEFT JOIN alunos a ON c.id = a.curso_id
GROUP BY c.id, c.nome;



-- 10
select * from professores;
select * from disciplinas;


SELECT p.nome, COUNT(d.id) AS qtd_disciplinas
FROM professores p
LEFT JOIN disciplinas d ON p.id = d.professor_id
GROUP BY p.id, p.nome
ORDER BY quantidade_disciplinas DESC;



-- 11


SELECT p.nome AS professor, d.nome AS disciplina
FROM disciplinas d
RIGHT JOIN professores p ON d.professor_id = p.id;


SELECT p.nome AS professor, d.nome AS disciplina
FROM professores p
LEFT JOIN disciplinas d ON p.id = d.professor_id;



-- 12

SELECT d.nome AS disciplina
FROM alunos a
CROSS JOIN disciplinas d
LEFT JOIN matriculas m
ON a.id = m.aluno_id
AND d.id = m.disciplina_id
WHERE a.nome = 'Gabriela Torres'
AND m.id IS NULL;


-- 13



-- alunos e cursos

SELECT COUNT(*)
FROM alunos
CROSS JOIN cursos;


-- disciplinas e professores

SELECT COUNT(*)
FROM disciplinas
CROSS JOIN professores;