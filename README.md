# FOCA 🎯 - Plataforma de Gestão de Rotina Acadêmica

Bem-vindo(a) ao repositório do projeto **FOCA**, um banco de dados relacional desenvolvido para uma plataforma de gestão de rotina acadêmica voltada para alunos do ensino médio. 

Este projeto foi desenvolvido como requisito da disciplina de Banco de Dados do curso de Ciência da Computação na Universidade Federal de Alagoas (UFAL).

## 📋 Sobre o Projeto

O FOCA tem como princípio central eliminar a barreira de entrada ao estudo autônomo. Em vez de exigir que o aluno monte sua própria agenda do zero, o sistema organiza as sessões de estudo automaticamente com base nas disciplinas e cargas horárias cadastradas pela escola, entregando uma semana já estruturada desde o primeiro acesso.

### 👥 Perfis de Usuário
- **Aluno:** Acessa o aplicativo diariamente para visualizar e executar sessões de estudo, registra o nível de foco e gerencia sessões perdidas.
- **Professor:** Monitora o painel de acompanhamento de sua turma, visualizando o estado da rotina de cada aluno (estável, irregular ou ausente).
- **Coordenador:** Possui acesso ao painel gerencial, acompanhando o trabalho dos professores e o desempenho global da escola.

## 🗄️ Estrutura do Banco de Dados

O banco foi projetado utilizando o modelo relacional e normalizado até a **3ª Forma Normal (3FN)**. O dialeto SQL utilizado é compatível com **PostgreSQL**.

As principais entidades e lógicas implementadas incluem:
* `Escola`, `Turma`, `Disciplina`
* `Usuario` (Especialização estruturada em *Table Per Type*: `Aluno`, `Professor`, `Coordenador`)
* `Grade_Curricular` (Entidade Associativa)
* `Sessao_Estudo` e `Registro_Foco`

## 📂 Estrutura do Repositório

O repositório está organizado para refletir todas as etapas do desenvolvimento do banco de dados:

* 📄 **`01_ddl.sql`**: Scripts de criação das tabelas, definição de tipos de dados e aplicação de restrições de integridade (Primary Keys, Foreign Keys, `UNIQUE`, `CHECK`).
* 📄 **`02_dml.sql`**: Scripts de inserção (população do banco) com dados representativos, cobrindo diversos casos de borda essenciais para testar as regras de negócio.
* 📄 **`03_consultas.sql`**: Bateria de 10 consultas SQL de complexidade progressiva. Inclui seleções simples, junções variadas (`INNER`, `LEFT`, `RIGHT`), subconsultas (correlacionadas e não-correlacionadas), operadores de conjunto e agregações (`GROUP BY`/`HAVING`). Também inclui a criação da `VIEW` `vw_estado_rotina`.
* 🖼️ **`foca_bd_modelo_ER.png`**: Diagrama Entidade-Relacionamento (ER) ilustrando a modelagem conceitual do sistema.
* 📑 **`Foca_Projeto_Relatorio.pdf`**: Relatório completo do projeto detalhando o mini-mundo, as decisões de mapeamento, análise crítica do modelo e justificativas técnicas.

## 🚀 Como Executar

1. Certifique-se de ter um SGBD relacional instalado (recomendamos fortemente o **PostgreSQL**, pois o código utiliza funções específicas como `FILTER`).
2. Conecte-se ao seu banco de dados via terminal (ex: `psql`) ou interface gráfica (ex: pgAdmin, DBeaver).
3. Execute o arquivo `01_ddl.sql` para criar o schema completo.
4. Execute o arquivo `02_dml.sql` para popular as tabelas.
5. Utilize o arquivo `03_consultas.sql` para testar os resultados e visualizar o painel do professor através da View.

## 👩‍💻 Equipe Desenvolvedora

* **Jamily Barbosa de Oliveira**
* **Sarah Maria Rocha de Oliveira** 

---
*Projeto acadêmico de Banco de Dados - 4° Período - 2026*
