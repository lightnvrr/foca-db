-- CONSULTAS

SELECT nome, area_conhecimento
FROM disciplina
WHERE area_conhecimento = 'Ciencias Exatas'
ORDER BY nome;
----------------------------------------------

SELECT u.nome AS aluno, t.nome AS turma, e.nome AS escola, t.turno
FROM usuario u
INNER JOIN aluno a  ON a.id_usuario = u.id_usuario
INNER JOIN turma t  ON t.id_turma   = a.id_turma
INNER JOIN escola e ON e.id_escola  = t.id_escola
ORDER BY e.nome, t.nome, u.nome;
----------------------------------------------

SELECT u.nome AS aluno,
       COUNT(s.id_sessao) AS total_sessoes
FROM usuario u
INNER JOIN aluno a ON a.id_usuario = u.id_usuario
LEFT  JOIN sessao_estudo s ON s.id_aluno = a.id_usuario
GROUP BY u.nome
ORDER BY total_sessoes DESC;
----------------------------------------------

SELECT u.nome AS professor,
       d.nome AS disciplina,
       t.nome AS turma,
       g.carga_horaria_semanal AS carga_h
FROM grade_curricular g
RIGHT JOIN professor p ON p.id_usuario    = g.id_professor
INNER JOIN usuario u  ON u.id_usuario     = p.id_usuario
LEFT  JOIN disciplina d ON d.id_disciplina = g.id_disciplina
LEFT  JOIN turma t      ON t.id_turma      = g.id_turma
ORDER BY u.nome, t.nome;
----------------------------------------------

SELECT u.nome AS aluno,
       s.status,
       COUNT(*) AS qtd
FROM sessao_estudo s
INNER JOIN aluno a   ON a.id_usuario = s.id_aluno
INNER JOIN usuario u ON u.id_usuario = a.id_usuario
WHERE s.semana_referencia = 20
GROUP BY u.nome, s.status
ORDER BY u.nome, s.status;
----------------------------------------------

SELECT u.nome AS aluno,
       COUNT(*) AS sessoes_perdidas
FROM sessao_estudo s
INNER JOIN aluno a   ON a.id_usuario = s.id_aluno
INNER JOIN usuario u ON u.id_usuario = a.id_usuario
WHERE s.status = 'perdida'
  AND s.semana_referencia = 20
GROUP BY u.nome
HAVING COUNT(*) > 2
ORDER BY sessoes_perdidas DESC;
----------------------------------------------

SELECT u.nome AS aluno, COUNT(*) AS concluidas
FROM sessao_estudo s
INNER JOIN aluno a   ON a.id_usuario = s.id_aluno
INNER JOIN usuario u ON u.id_usuario = a.id_usuario
WHERE s.status = 'concluida'
GROUP BY u.nome
HAVING COUNT(*) > (
    SELECT AVG(cnt) FROM (
        SELECT COUNT(*) AS cnt
        FROM sessao_estudo
        WHERE status = 'concluida'
        GROUP BY id_aluno
    ) AS sub
)
ORDER BY concluidas DESC;
----------------------------------------------

SELECT s.id_sessao, u.nome AS aluno,
       d.nome AS disciplina,
       s.data_agendada
FROM sessao_estudo s
INNER JOIN aluno a   ON a.id_usuario    = s.id_aluno
INNER JOIN usuario u ON u.id_usuario    = a.id_usuario
INNER JOIN grade_curricular g ON g.id_grade = s.id_grade
INNER JOIN disciplina d ON d.id_disciplina = g.id_disciplina
WHERE s.status = 'concluida'
  AND NOT EXISTS (
      SELECT 1 FROM registro_foco rf
      WHERE rf.id_sessao = s.id_sessao
  )
ORDER BY s.data_agendada;
----------------------------------------------

SELECT u.nome, 'Professor' AS papel, u.email
FROM usuario u
INNER JOIN professor p ON p.id_usuario = u.id_usuario
UNION
SELECT u.nome, 'Coordenador' AS papel, u.email
FROM usuario u
INNER JOIN coordenador c ON c.id_usuario = u.id_usuario
ORDER BY papel, nome;

----------------------------------------------------------------
-- CRIAÇÃO VIEW

CREATE VIEW vw_estado_rotina AS
SELECT
    u.id_usuario,
    u.nome AS aluno,
    t.nome AS turma,
    e.nome AS escola,
    s.semana_referencia,
    COUNT(*)                                       AS total_sessoes,
    COUNT(*) FILTER (WHERE s.status = 'concluida') AS concluidas,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE s.status = 'concluida')
        / NULLIF(COUNT(*), 0), 1
    )                                              AS pct_concluidas,
    CASE
        WHEN COUNT(*) = 0 THEN 'Sem sessoes'
        WHEN 100.0 * COUNT(*) FILTER (WHERE s.status = 'concluida')
             / COUNT(*) >= 80 THEN 'Estavel'
        WHEN 100.0 * COUNT(*) FILTER (WHERE s.status = 'concluida')
             / COUNT(*) >= 40 THEN 'Irregular'
        ELSE 'Ausente'
    END AS estado_rotina
FROM sessao_estudo s
INNER JOIN aluno a  ON a.id_usuario = s.id_aluno
INNER JOIN usuario u ON u.id_usuario = a.id_usuario
INNER JOIN turma t  ON t.id_turma    = a.id_turma
INNER JOIN escola e ON e.id_escola   = t.id_escola
GROUP BY u.id_usuario, u.nome, t.nome, e.nome, s.semana_referencia;

-- Consultando a view (painel do professor):
SELECT aluno, turma, pct_concluidas, estado_rotina
FROM vw_estado_rotina
WHERE semana_referencia = 20
ORDER BY estado_rotina, aluno;