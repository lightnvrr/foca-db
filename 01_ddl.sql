-- ============================================================
--  FOCA – DDL – Criação do Banco de Dados
-- ============================================================

CREATE TABLE escola (
  id_escola    SERIAL        PRIMARY KEY,
  nome         VARCHAR(150)  NOT NULL,
  logradouro   VARCHAR(200)  NOT NULL,
  cidade       VARCHAR(100)  NOT NULL,
  estado       CHAR(2)       NOT NULL CHECK (estado ~ '^[A-Z]{2}$'),
  cep          CHAR(8)       NOT NULL CHECK (cep ~ '^[0-9]{8}$')
);

CREATE TABLE escola_telefone (
  id_escola    INT           NOT NULL REFERENCES escola(id_escola)
                             ON DELETE CASCADE,
  telefone     VARCHAR(20)   NOT NULL,
  PRIMARY KEY (id_escola, telefone)
);

CREATE TABLE turma (
  id_turma     SERIAL        PRIMARY KEY,
  nome         VARCHAR(50)   NOT NULL,
  ano_letivo   SMALLINT      NOT NULL CHECK (ano_letivo >= 2020),
  turno        VARCHAR(20)   NOT NULL
               CHECK (turno IN ('Matutino','Vespertino','Noturno')),
  id_escola    INT           NOT NULL REFERENCES escola(id_escola)
);

CREATE TABLE disciplina (
  id_disciplina   SERIAL       PRIMARY KEY,
  nome            VARCHAR(100) NOT NULL UNIQUE,
  area_conhecimento VARCHAR(80) NOT NULL
);

CREATE TABLE usuario (
  id_usuario    SERIAL        PRIMARY KEY,
  nome          VARCHAR(150)  NOT NULL,
  cpf           CHAR(11)      NOT NULL UNIQUE
                CHECK (cpf ~ '^[0-9]{11}$'),
  email         VARCHAR(150)  NOT NULL UNIQUE,
  senha_hash    VARCHAR(255)  NOT NULL,
  data_cadastro DATE          NOT NULL DEFAULT CURRENT_DATE,
  tipo          VARCHAR(20)   NOT NULL
                CHECK (tipo IN ('aluno','professor','coordenador'))
);

CREATE TABLE aluno (
  id_usuario    INT           PRIMARY KEY
                REFERENCES usuario(id_usuario) ON DELETE CASCADE,
  id_turma      INT           NOT NULL REFERENCES turma(id_turma),
  matricula     VARCHAR(20)   NOT NULL UNIQUE
);

CREATE TABLE professor (
  id_usuario          INT         PRIMARY KEY
                      REFERENCES usuario(id_usuario) ON DELETE CASCADE,
  registro_profissional VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE coordenador (
  id_usuario    INT           PRIMARY KEY
                REFERENCES usuario(id_usuario) ON DELETE CASCADE,
  id_escola     INT           NOT NULL REFERENCES escola(id_escola)
);

CREATE TABLE grade_curricular (
  id_grade              SERIAL    PRIMARY KEY,
  id_turma              INT       NOT NULL REFERENCES turma(id_turma),
  id_disciplina         INT       NOT NULL REFERENCES disciplina(id_disciplina),
  carga_horaria_semanal NUMERIC(4,1) NOT NULL CHECK (carga_horaria_semanal > 0),
  id_professor          INT       NOT NULL REFERENCES professor(id_usuario),
  UNIQUE (id_turma, id_disciplina)
);

CREATE TABLE sessao_estudo (
  id_sessao         SERIAL       PRIMARY KEY,
  id_aluno          INT          NOT NULL REFERENCES aluno(id_usuario),
  id_grade          INT          NOT NULL REFERENCES grade_curricular(id_grade),
  data_agendada     DATE         NOT NULL,
  duracao_minutos   SMALLINT     NOT NULL CHECK (duracao_minutos > 0),
  status            VARCHAR(20)  NOT NULL DEFAULT 'pendente'
                    CHECK (status IN ('pendente','concluida',
                                      'perdida','redistribuida')),
  semana_referencia SMALLINT     NOT NULL CHECK (semana_referencia BETWEEN 1 AND 53),
  criada_em         TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE registro_foco (
  id_registro     SERIAL       PRIMARY KEY,
  id_sessao       INT          NOT NULL UNIQUE
                  REFERENCES sessao_estudo(id_sessao),
  nivel_foco      VARCHAR(15)  NOT NULL
                  CHECK (nivel_foco IN ('sim','parcialmente','nao')),
  observacao      TEXT,
  registrado_em   TIMESTAMP    NOT NULL DEFAULT NOW()
);