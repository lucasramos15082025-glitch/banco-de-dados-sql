-- ============================================================
-- Banco de exemplo para a aula de relacionamentos: faculdade
-- Relacionamentos:
--   1:N  cursos -> alunos
--   1:N  professores -> disciplinas
--   1:1  alunos -> carteirinhas
--   N:N  alunos <-> disciplinas (tabela associativa: matriculas)
-- Pode ser executado quantas vezes quiser: ele recria o banco do zero.
-- ============================================================

DROP DATABASE IF EXISTS faculdade;
CREATE DATABASE faculdade CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;
USE faculdade;

-- Tabelas do lado "1" primeiro, para que as chaves estrangeiras
-- sempre apontem para tabelas que já existem.

CREATE TABLE cursos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  duracao_semestres INT NOT NULL
);

CREATE TABLE professores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL
);

-- 1:N  Um curso tem vários alunos; cada aluno pertence a um curso.
-- A chave estrangeira fica no lado "N" (alunos).
CREATE TABLE alunos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  curso_id INT NOT NULL,
  CONSTRAINT fk_alunos_curso
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- 1:1  Cada aluno tem no máximo uma carteirinha, e cada carteirinha é de um só aluno.
-- O UNIQUE em aluno_id é o que transforma o 1:N em 1:1.
-- ON DELETE CASCADE: apagar o aluno apaga a carteirinha dele.
CREATE TABLE carteirinhas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  aluno_id INT NOT NULL UNIQUE,
  numero VARCHAR(10) UNIQUE NOT NULL,
  validade DATE NOT NULL,
  CONSTRAINT fk_carteirinhas_aluno
    FOREIGN KEY (aluno_id) REFERENCES alunos(id)
    ON DELETE CASCADE
);

-- 1:N  Um professor dá várias disciplinas; cada disciplina tem um professor.
-- professor_id aceita NULL (disciplina ainda sem professor).
-- ON DELETE SET NULL: apagar o professor deixa a disciplina sem professor.
CREATE TABLE disciplinas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  carga_horaria INT NOT NULL,
  professor_id INT NULL,
  CONSTRAINT fk_disciplinas_professor
    FOREIGN KEY (professor_id) REFERENCES professores(id)
    ON DELETE SET NULL
);

-- N:N  Um aluno cursa várias disciplinas; uma disciplina tem vários alunos.
-- Isso exige uma tabela associativa com duas chaves estrangeiras.
-- UNIQUE (aluno_id, disciplina_id) impede matricular o mesmo aluno duas vezes na mesma disciplina.
-- nota e data_matricula pertencem à relação, não ao aluno nem à disciplina.
CREATE TABLE matriculas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  aluno_id INT NOT NULL,
  disciplina_id INT NOT NULL,
  data_matricula DATE NOT NULL,
  nota DECIMAL(4,2) NULL,
  CONSTRAINT fk_matriculas_aluno
    FOREIGN KEY (aluno_id) REFERENCES alunos(id)
    ON DELETE CASCADE,
  CONSTRAINT fk_matriculas_disciplina
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
    ON DELETE CASCADE,
  CONSTRAINT uq_matricula UNIQUE (aluno_id, disciplina_id)
);

-- ------------------------------------------------------------
-- Dados (a ordem também importa: primeiro o lado "1", depois o "N")
-- ------------------------------------------------------------

INSERT INTO cursos (nome, duracao_semestres) VALUES
  ('Análise e Desenvolvimento de Sistemas', 5),   -- id 1
  ('Engenharia de Software', 8),                  -- id 2
  ('Ciência de Dados', 6);                        -- id 3 (ainda sem alunos)

INSERT INTO professores (nome, email) VALUES
  ('Marcos Andrade', 'marcos.andrade@faculdade.edu'),   -- id 1
  ('Beatriz Lima',   'beatriz.lima@faculdade.edu'),     -- id 2
  ('Renato Souza',   'renato.souza@faculdade.edu'),     -- id 3
  ('Patrícia Gomes', 'patricia.gomes@faculdade.edu');   -- id 4 (ainda sem disciplinas)

INSERT INTO carteirinhas (aluno_id, numero, validade) VALUES
  (1, '2026-0001', '2026-12-31'),
  (2, '2026-0002', '2026-12-31'),
  (3, '2026-0003', '2026-12-31'),
  (4, '2026-0004', '2026-12-31'),
  (5, '2026-0005', '2026-12-31'),
  (6, '2026-0006', '2026-12-31');
INSERT INTO alunos (nome, email, curso_id) VALUES
  ('Ana Paula Ribeiro', 'ana.ribeiro@aluno.edu',   1),   -- id 1
  ('Bruno Carvalho',    'bruno.carvalho@aluno.edu', 1),  -- id 2
  ('Carla Mendes',      'carla.mendes@aluno.edu',   1),  -- id 3
  ('Diego Martins',     'diego.martins@aluno.edu',  2),  -- id 4
  ('Elisa Ferreira',    'elisa.ferreira@aluno.edu', 2),  -- id 5
  ('Fábio Nogueira',    'fabio.nogueira@aluno.edu', 2),  -- id 6
  ('Gabriela Torres',   'gabriela.torres@aluno.edu', 1); -- id 7 (sem carteirinha)


INSERT INTO disciplinas (nome, carga_horaria, professor_id) VALUES
  ('Banco de Dados',         80, 1),   -- id 1
  ('Programação Web',        80, 2),   -- id 2
  ('Algoritmos',             60, 3),   -- id 3
  ('Engenharia de Requisitos', 40, 2), -- id 4
  ('Estatística',            60, NULL);-- id 5 (sem professor)

INSERT INTO matriculas (aluno_id, disciplina_id, data_matricula, nota) VALUES
  (1, 1, '2026-02-02', 8.5),
  (1, 2, '2026-02-02', 9.0),
  (1, 3, '2026-02-02', 7.5),
  (2, 1, '2026-02-03', 6.0),
  (2, 3, '2026-02-03', 5.5),
  (3, 1, '2026-02-03', 9.5),
  (3, 2, '2026-02-04', NULL),
  (4, 1, '2026-02-04', 7.0),
  (4, 4, '2026-02-04', 8.0),
  (5, 2, '2026-02-05', 6.5),
  (5, 4, '2026-02-05', NULL),
  (6, 3, '2026-02-05', 4.5);

-- Conferindo
SELECT 'cursos' AS tabela, COUNT(*) AS linhas FROM cursos
UNION ALL SELECT 'professores', COUNT(*) FROM professores
UNION ALL SELECT 'alunos', COUNT(*) FROM alunos
UNION ALL SELECT 'carteirinhas', COUNT(*) FROM carteirinhas
UNION ALL SELECT 'disciplinas', COUNT(*) FROM disciplinas
UNION ALL SELECT 'matriculas', COUNT(*) FROM matriculas;