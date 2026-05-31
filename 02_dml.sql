-- ============================================================
--  FOCA – DML – Inserção de Dados
-- ============================================================

-- ESCOLA (5 registros)
INSERT INTO escola (nome, logradouro, cidade, estado, cep) VALUES
  ('Escola Estadual Dom Pedro II',    'Av. Presidente Médici, 1200', 'Arapiraca', 'AL', '57300000'),
  ('Escola Estadual Santos Dumont',   'R. Joaquim Nabuco, 45',       'Arapiraca', 'AL', '57312100'),
  ('CEFET-AL',                         'Av. Durval de Góes Monteiro', 'Maceió',    'AL', '57020600'),
  ('Escola Estadual Graciliano Ramos', 'R. Sete de Setembro, 320',    'Arapiraca', 'AL', '57301100'),
  ('Colégio Estadual Maceió',          'Av. Fernandes Lima, 1580',    'Maceió',    'AL', '57057900');

INSERT INTO escola_telefone VALUES
  (1,'8232210000'),(1,'8299870001'),(2,'8232215555'),
  (3,'8233316000'),(4,'8232219999'),(5,'8233320000');

-- TURMAS (5 registros)
INSERT INTO turma (nome, ano_letivo, turno, id_escola) VALUES
  ('3o Ano A', 2025, 'Matutino',   1),
  ('3o Ano B', 2025, 'Vespertino', 1),
  ('2o Ano A', 2025, 'Matutino',   2),
  ('1o Ano A', 2025, 'Noturno',    2),
  ('3o Ano A', 2025, 'Matutino',   3);

-- DISCIPLINAS (10 registros)
INSERT INTO disciplina (nome, area_conhecimento) VALUES
  ('Matematica',      'Ciencias Exatas'),
  ('Portugues',       'Linguagens'),
  ('Historia',        'Ciencias Humanas'),
  ('Fisica',          'Ciencias Exatas'),
  ('Quimica',         'Ciencias Exatas'),
  ('Biologia',        'Ciencias da Natureza'),
  ('Geografia',       'Ciencias Humanas'),
  ('Ingles',          'Linguagens'),
  ('Filosofia',       'Ciencias Humanas'),
  ('Educacao Fisica', 'Linguagens');

-- USUARIOS (15 registros)
INSERT INTO usuario (nome, cpf, email, senha_hash, tipo) VALUES
  -- Professores
  ('Carlos Alberto Melo',  '11122233344', 'carlos@escola1.edu.br',  'hash1', 'professor'),
  ('Fernanda Souza',        '22233344455', 'fernanda@escola1.edu.br','hash2', 'professor'),
  ('Ricardo Lima',          '33344455566', 'ricardo@escola2.edu.br', 'hash3', 'professor'),
  ('Patricia Vieira',       '44455566677', 'patricia@escola2.edu.br','hash4', 'professor'),
  ('Marcos Oliveira',       '55566677788', 'marcos@cefet.edu.br',    'hash5', 'professor'),
  -- Coordenadores
  ('Ana Claudia Ferreira',  '66677788899', 'ana@escola1.edu.br',     'hash6', 'coordenador'),
  ('Bruno Henrique Costa',  '77788899900', 'bruno@escola2.edu.br',   'hash7', 'coordenador'),
  -- Alunos
  ('Lucas Pereira',         '88899900011', 'lucas@aluno.br',   'hash8',  'aluno'),
  ('Maria Eduarda Santos',  '99900011122', 'medu@aluno.br',    'hash9',  'aluno'),
  ('Joao Vitor Alves',      '10011122233', 'joao@aluno.br',    'hash10', 'aluno'),
  ('Camila Rocha',          '11122233300', 'camila@aluno.br',  'hash11', 'aluno'),
  ('Pedro Henrique Lima',   '12233344411', 'pedro@aluno.br',   'hash12', 'aluno'),
  ('Isabela Nascimento',    '13344455522', 'isabela@aluno.br', 'hash13', 'aluno'),
  ('Thiago Barbosa',        '14455566633', 'thiago@aluno.br',  'hash14', 'aluno'),
  ('Ana Beatriz Costa',     '15566677744', 'anab@aluno.br',    'hash15', 'aluno');

-- ESPECIALIZACOES
INSERT INTO professor (id_usuario, registro_profissional) VALUES
  (1,'PROF-AL-001'),(2,'PROF-AL-002'),(3,'PROF-AL-003'),
  (4,'PROF-AL-004'),(5,'PROF-AL-005');

INSERT INTO coordenador (id_usuario, id_escola) VALUES (6,1),(7,2);

INSERT INTO aluno (id_usuario, id_turma, matricula) VALUES
  (8, 1,'2025001'),(9, 1,'2025002'),
  (10,1,'2025003'), (11,2,'2025004'),
  (12,2,'2025005'),(13,3,'2025006'),
  (14,3,'2025007'),(15,4,'2025008');

-- GRADE CURRICULAR (12 registros)
INSERT INTO grade_curricular (id_turma,id_disciplina,carga_horaria_semanal,id_professor) VALUES
  (1,1,5.0,1), -- 3oA / Matematica / Carlos
  (1,2,4.0,2), -- 3oA / Portugues  / Fernanda
  (1,4,3.0,1), -- 3oA / Fisica     / Carlos
  (1,5,3.0,2), -- 3oA / Quimica    / Fernanda
  (1,3,2.0,3), -- 3oA / Historia   / Ricardo
  (2,1,5.0,1), -- 3oB / Matematica / Carlos
  (2,2,4.0,2), -- 3oB / Portugues  / Fernanda
  (2,6,3.0,3), -- 3oB / Biologia   / Ricardo
  (3,1,4.0,3), -- 2oA / Matematica / Ricardo
  (3,7,3.0,4), -- 2oA / Geografia  / Patricia
  (4,8,3.0,4), -- 1oA / Ingles     / Patricia
  (4,9,2.0,5); -- 1oA / Filosofia  / Marcos

-- SESSOES DE ESTUDO (41 registros – semana 20/2025)
INSERT INTO sessao_estudo
  (id_aluno,id_grade,data_agendada,duracao_minutos,status,semana_referencia) VALUES
  -- Lucas (id=8) – rotina estavel
  (8, 1,'2025-05-19',60,'concluida',   20),
  (8, 2,'2025-05-20',50,'concluida',   20),
  (8, 3,'2025-05-21',45,'concluida',   20),
  (8, 4,'2025-05-22',45,'concluida',   20),
  (8, 5,'2025-05-23',30,'concluida',   20),
  -- Maria Eduarda (id=9) – rotina irregular
  (9, 1,'2025-05-19',60,'concluida',   20),
  (9, 2,'2025-05-20',50,'perdida',     20),
  (9, 3,'2025-05-21',45,'concluida',   20),
  (9, 4,'2025-05-22',45,'perdida',     20),
  (9, 5,'2025-05-23',30,'redistribuida',20),
  -- Joao Vitor (id=10) – rotina ausente
  (10,1,'2025-05-19',60,'perdida',     20),
  (10,2,'2025-05-20',50,'perdida',     20),
  (10,3,'2025-05-21',45,'pendente',    20),
  (10,4,'2025-05-22',45,'pendente',    20),
  (10,5,'2025-05-23',30,'pendente',    20),
  -- Camila (id=11) – turma 3oB estavel
  (11,6,'2025-05-19',60,'concluida',   20),
  (11,7,'2025-05-20',50,'concluida',   20),
  (11,8,'2025-05-21',45,'concluida',   20),
  (11,6,'2025-05-22',60,'concluida',   20),
  (11,7,'2025-05-23',50,'concluida',   20),
  -- Pedro (id=12) – turma 3oB irregular
  (12,6,'2025-05-19',60,'concluida',   20),
  (12,7,'2025-05-20',50,'perdida',     20),
  (12,8,'2025-05-21',45,'perdida',     20),
  (12,6,'2025-05-22',60,'concluida',   20),
  (12,7,'2025-05-23',50,'perdida',     20),
  -- Isabela (id=13) – turma 2oA estavel
  (13,9, '2025-05-19',50,'concluida',  20),
  (13,10,'2025-05-20',40,'concluida',  20),
  (13,9, '2025-05-21',50,'concluida',  20),
  (13,10,'2025-05-22',40,'concluida',  20),
  (13,9, '2025-05-23',50,'concluida',  20),
  -- Thiago (id=14) – turma 2oA ausente
  (14,9, '2025-05-19',50,'perdida',    20),
  (14,10,'2025-05-20',40,'perdida',    20),
  (14,9, '2025-05-21',50,'perdida',    20),
  (14,10,'2025-05-22',40,'pendente',   20),
  (14,9, '2025-05-23',50,'pendente',   20),
  -- Ana Beatriz (id=15) – turma 1oA
  (15,11,'2025-05-19',40,'concluida',  20),
  (15,12,'2025-05-20',30,'concluida',  20),
  (15,11,'2025-05-21',40,'perdida',    20),
  (15,12,'2025-05-22',30,'concluida',  20),
  (15,11,'2025-05-23',40,'concluida',  20);

-- REGISTROS DE FOCO (somente sessoes concluidas)
INSERT INTO registro_foco (id_sessao, nivel_foco, observacao) VALUES
  (1, 'sim',          NULL),
  (2, 'parcialmente', 'Muitos ruidos em casa'),
  (3, 'sim',          NULL),
  (4, 'sim',          NULL),
  (5, 'nao',          'Estava cansado'),
  (6, 'sim',          NULL),
  (8, 'parcialmente', NULL),
  (16,'sim',          NULL),
  (17,'sim',          NULL),
  (18,'sim',          NULL),
  (19,'sim',          NULL),
  (20,'sim',          NULL),
  (21,'sim',          NULL),
  (24,'parcialmente', 'Cansada apos trabalho'),
  (26,'sim',          NULL),
  (27,'sim',          NULL),
  (28,'sim',          NULL),
  (29,'sim',          NULL),
  (30,'sim',          NULL),
  (36,'sim',          NULL),
  (37,'sim',          NULL),
  (39,'sim',          NULL),
  (40,'sim',          NULL);


-- Sessão nao concluida (adicionada depois)
INSERT INTO sessao_estudo 
  (id_aluno, id_grade, data_agendada, duracao_minutos, status, semana_referencia)
VALUES (8, 1, '2025-05-26', 60, 'concluida', 21);
