USE faculdade;
 
SELECT * FROM alunos;

SELECT * FROM cursos;

#SELECT a.nome AS alunos, c.nome AS curso
#FROM alunos a
#CROSS JOIN cursos c;


# INEER JOIN
# A tabela que vem na frente do from é a tabela 'principal'
# na frente da palavra join eu vou colocar o nome da minha tabela secudaria
# INNER join ele so devolve o que tem par nas duas tabelas
SELECT * FROM alunos
INNER JOIN cursos ON alunos.curso_id  = cursos.id;

# seleção das informações de duas tabelas
SELECT alunos.nome, cursos.nome FROM alunos
INNER JOIN cursos ON alunos.curso_id  = cursos.id;


SELECT a.nome, c.nome 
FROM alunos a
INNER JOIN cursos c ON a.curso_id  = c.id;


# erro de ambiguidade nas duas tabelas
SELECT nome
FROM alunos a
INNER JOIN cursos c ON a.curso_id  = c.id;