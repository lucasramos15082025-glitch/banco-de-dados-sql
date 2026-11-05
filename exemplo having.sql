USE faculdade;

-- HAVING

-- quantos alunos tem em cada curso

SELECT c.nome, COUNT(a.id)
FROM cursos c
INNER JOIN alunos a ON a.curso_id = c.id
WHERE COUNT(a.id) > 3
GROUP BY c.id
ORDER BY c.id;

-- diferença entre o WHERE e o HAVING
-- WHERE filtra linhas
-- HAVING grupos
-- com o HAVING o grupo precisa existir ( ja ter executado) pra poder ser filtrado

SELECT c.nome, COUNT(a.id)
FROM cursos c
INNER JOIN alunos a ON a.curso_id = c.id
GROUP BY c.id
HAVING COUNT(a.id) > 3;



SELECT a.nome, COUNT(m.id) 
FROM alunos a
INNER JOIN matriculas m ON m.aluno_id = a.id
GROUP BY a.id
HAVING COUNT(m.id) >= 2;


-- EXERCICIO:
-- quais disciplinas tem 3 ou mais alunos matriculados

select * from disciplinas;

select * from matriculas;

SELECT d.nome, COUNT(m.id) AS total_matriculas
FROM disciplinas d
INNER JOIN matriculas m ON m.disciplina_id = d.id
GROUP BY d.id
HAVING total_matriculas >= 3;

SELECT d.nome, ROUND(AVG(m.nota),2) AS media
FROM disciplinas d 
INNER JOIN matriculas m ON m.disciplina_id = d.id
GROUP BY d.id
HAVING media >= 7
ORDER BY media DESC;

-- quais professores tem 60 horas ou menos carga horaria somando as disciplinas


SELECT p.nome, SUM(d.carga_horaria) AS carga_total
FROM professores p 
INNER JOIN disciplinas d ON p.id = d.professor_id
GROUP BY p.id
HAVING carga_total <= 60;

-- HAVING ele pode ser usado com qualquer função de agragação (min, max, avg, sum , count)

-- a media de cada aluno, ams contando as disciplinas de 60 ou mais.
-- e mostrando se quem tem 7 ou masi de media


SELECT a.nome, ROUND(AVG(m.nota),2) AS media 
FROM alunos a
INNER JOIN matriculas m ON m.aluno_id = a.id
INNER JOIN disciplinas d on m.disciplina_id = d.id
WHERE d.carga_horaria >= 60 	
GROUP BY a.id
HAVING media >= 7;

select * from cursos;

SELECT c.nome, COUNT(a.id) as total_alunos 
FROM cursos c
INNER JOIN alunos a ON a.curso_id = c.id
GROUP BY c.id
HAVING c.nome = 'Engenharia de Software';