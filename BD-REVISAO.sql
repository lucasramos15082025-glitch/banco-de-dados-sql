-- =====================================================================
--  BANCO DE EXEMPLO - AULA DE REVISÃO: JOIN, GROUP BY E HAVING
--  Compatível com PostgreSQL e MySQL/MariaDB (testado nos dois).
--
--  Como usar:
--    PostgreSQL:  CREATE DATABASE revisao;   depois conecte nele (\c revisao)
--                 e execute este arquivo.
--    MySQL:       CREATE DATABASE revisao;  USE revisao;
--                 e execute este arquivo.
--
--  O script pode ser executado de novo a qualquer momento:
--  ele apaga as tabelas e recria tudo do zero.
--
--  Dados "armadilha" de propósito (para mostrar a diferença entre os JOINs):
--    * Departamento JURÍDICO (id 5) não tem nenhum funcionário.
--    * João Pereira e Marcos Silva não têm departamento (departamento_id NULL).
--    * Ana Souza e Marcos Silva não têm gerente (gerente_id NULL).
--    * Ana Souza e Larissa Gomes não estão alocadas em nenhum projeto.
--    * O projeto "Auditoria 2027" não tem ninguém alocado.
-- =====================================================================
CREATE DATABASE IF NOT EXISTS revisao;
USE REVISAO;

DROP TABLE IF EXISTS alocacoes;
DROP TABLE IF EXISTS projetos;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS departamentos;

CREATE TABLE departamentos (
    id      INT          PRIMARY KEY,
    nome    VARCHAR(50)  NOT NULL,
    cidade  VARCHAR(50)  NOT NULL
);

CREATE TABLE funcionarios (
    id               INT           PRIMARY KEY,
    nome             VARCHAR(60)   NOT NULL,
    cargo            VARCHAR(50)   NOT NULL,
    salario          DECIMAL(10,2) NOT NULL,
    departamento_id  INT           NULL,
    gerente_id       INT           NULL,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id),
    FOREIGN KEY (gerente_id)      REFERENCES funcionarios(id)
);

CREATE TABLE projetos (
    id               INT           PRIMARY KEY,
    nome             VARCHAR(60)   NOT NULL,
    orcamento        DECIMAL(10,2) NOT NULL,
    departamento_id  INT           NOT NULL,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

-- Tabela associativa (relacionamento N:N entre funcionários e projetos)
CREATE TABLE alocacoes (
    funcionario_id  INT NOT NULL,
    projeto_id      INT NOT NULL,
    horas           INT NOT NULL,
    PRIMARY KEY (funcionario_id, projeto_id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id),
    FOREIGN KEY (projeto_id)     REFERENCES projetos(id)
);

INSERT INTO departamentos (id, nome, cidade) VALUES
(1, 'TI',         'São Paulo'),
(2, 'Vendas',     'Rio de Janeiro'),
(3, 'RH',         'São Paulo'),
(4, 'Financeiro', 'Belo Horizonte'),
(5, 'Jurídico',   'Curitiba');          -- sem funcionários

-- A ordem importa: o gerente precisa existir antes do subordinado.
INSERT INTO funcionarios (id, nome, cargo, salario, departamento_id, gerente_id) VALUES
(1,  'Ana Souza',      'Diretora',            15000.00, 1,    NULL),  -- sem gerente
(2,  'Bruno Lima',     'Desenvolvedor',        7000.00, 1,    1),
(3,  'Carla Mendes',   'Desenvolvedora',       7500.00, 1,    1),
(4,  'Diego Rocha',    'Analista de Suporte',  4000.00, 1,    2),
(5,  'Elisa Martins',  'Gerente de Vendas',    9000.00, 2,    1),
(6,  'Fábio Costa',    'Vendedor',             3500.00, 2,    5),
(7,  'Gabriela Alves', 'Vendedora',            3800.00, 2,    5),
(8,  'Henrique Dias',  'Vendedor',             3200.00, 2,    5),
(9,  'Isabela Nunes',  'Analista de RH',       5000.00, 3,    1),
(10, 'João Pereira',   'Estagiário',           1800.00, NULL, 2),     -- sem departamento
(11, 'Larissa Gomes',  'Analista Financeira',  6000.00, 4,    1),
(12, 'Marcos Silva',   'Consultor',            8000.00, NULL, NULL);  -- sem departamento e sem gerente

INSERT INTO projetos (id, nome, orcamento, departamento_id) VALUES
(1, 'Novo Site',            50000.00, 1),
(2, 'App Mobile',           80000.00, 1),
(3, 'Campanha de Natal',    30000.00, 2),
(4, 'Treinamento Interno',  10000.00, 3),
(5, 'Auditoria 2027',       20000.00, 4);   -- ninguém alocado

INSERT INTO alocacoes (funcionario_id, projeto_id, horas) VALUES
(2,  1, 120),
(3,  1,  80),
(10, 1,  30),
(2,  2,  60),
(3,  2, 150),
(4,  2,  40),
(12, 2, 100),
(5,  3,  20),
(6,  3,  50),
(7,  3,  70),
(8,  3,  30),
(9,  4,  40);

-- Conferência rápida (deve mostrar 5, 12, 5 e 12)
SELECT 'departamentos' AS tabela, COUNT(*) AS linhas FROM departamentos
UNION ALL SELECT 'funcionarios', COUNT(*) FROM funcionarios
UNION ALL SELECT 'projetos',     COUNT(*) FROM projetos
UNION ALL SELECT 'alocacoes',    COUNT(*) FROM alocacoes;