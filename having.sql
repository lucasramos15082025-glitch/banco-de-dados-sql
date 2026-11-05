-- 1
select * from alunos;

select * from disciplinas;

SELECT d.nome, COUNT(a.id) AS quant_alunos
FROM  disciplinas d
INNER JOIN alunos a ON a.curso_id = d.id
GROUP BY d.id
HAVING quant_alunos >= 3;


-- 2
select * from matriculas;

SELECT a.nome, ROUND(AVG(m.nota),2) AS media 
FROM alunos a 
INNER JOIN matriculas m ON m.disciplina_id = a.id
GROUP BY a.id
HAVING media < 7 
ORDER BY media DESC;



-- 3

select * from disciplinas;
select * from professores;

SELECT p.nome, COUNT(d.professor_id) AS quant_disciplinas
FROM professores p 
INNER JOIN disciplinas d ON d.professor_id = p.id
GROUP BY p.id
HAVING quant_disciplinas > 1;


-- 4
SELECT a.nome, MAX(m.nota) AS maior_nota
FROM alunos a
INNER JOIN matriculas m ON m.aluno_id = a.id
GROUP BY a.id
HAVING maior_nota >= 9
ORDER BY maior_nota DESC;


-- 5
SELECT d.nome, ROUND(AVG(m.nota), 2) AS media, COUNT(m.nota) AS quantidade
FROM disciplinas d
INNER JOIN matriculas m ON m.disciplina_id = d.id
GROUP BY d.id
HAVING media > 7.5 AND quantidade >= 2;


-- 6
SELECT a.nome, COUNT(m.id) AS quantidade
FROM alunos a
INNER JOIN matriculas m ON m.aluno_id = a.id
WHERE m.data_matricula > '2026/02/03'
GROUP BY a.id
HAVING quantidade >= 2;


-- 7
SELECT c.nome, ROUND(AVG(m.nota), 2) AS media
FROM cursos c
INNER JOIN alunos a ON a.curso_id = c.id
INNER JOIN matriculas m ON m.aluno_id = a.id
GROUP BY c.id
HAVING media >= 7;


-- 8
SELECT d.nome
FROM disciplinas d
LEFT JOIN matriculas m ON m.disciplina_id = d.id
GROUP BY d.id
HAVING COUNT(m.id) = 0;


SELECT d.nome
FROM disciplinas d
LEFT JOIN matriculas m ON m.disciplina_id = d.id
WHERE m.id IS NULL;
