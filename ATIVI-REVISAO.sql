USE revisao;

SELECT * FROM funcionarios;

SELECT * FROM departamentos;

SELECT * FROM funcionarios, departamentos;

SELECT * FROM funcionarios f
INNER JOIN departamentos d ON f.departamento_id = d.id;

SELECT * FROM funcionarios f
LEFT JOIN departamentos d ON f.departamento_id = d.id;

-- como descubrir que funcionario nao tem departamento

SELECT * FROM funcionarios f
LEFT JOIN departamentos d ON f.departamento_id = d.id
WHERE d.id IS NULL;

SELECT * FROM funcionarios f
RIGHT JOIN departamentos d ON f.departamento_id = d.id;

SELECT * FROM departamentos d
LEFT JOIN funcionarios f ON f.departamento_id = d.id;

-- auto join

SELECT f.nome AS funcionario , f2.nome as gerente
FROM funcionarios f
INNER JOIN funcionarios f2 ON f.gerente_id = f2.id;

SELECT 
f.nome AS funcionario , p.nome AS projeto 
FROM alocacoes a
INNER JOIN funcionarios f ON a.funcionario_id = f.id
INNER JOIN projetos p ON a.projeto_id = p.id;

-- quero todos projetos, com departamento ao qual o projeto pertence
-- os funcionarios q trabalham nesse projeto, e tem que listar inclusive
-- projetos que nao tem ninguem

SELECT 
*
FROM projetos p
LEFT JOIN departamentos d; 