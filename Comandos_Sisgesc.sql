-- criação do banco de dados

create database sisgesc character set utf8mb4 collate utf8mb4_unicode_ci;
use sisgesc;

create table funcionarios(
	pk_nr_funcionario int auto_increment primary key,
    nome_funcionario  varchar(50) not null
);

create table alunos (
	pk_rgm_aluno int auto_increment primary key,
    nome_aluno varchar(50) not null,
    data_nascimento date,
    cpf varchar(14) not null unique,
    status_aluno enum('ativo', 'inativo', 'trancado') default 'ativo',
    created_at timestamp default current_timestamp
);

create table cursos(
	pk_codigo_curso int auto_increment primary key,
    nome_curso varchar(100) not null
);

create table professores(
	pk_registro_professor int auto_increment primary key,
    fk_nr_funcionario int not null,
    foreign key(fk_nr_funcionario) references funcionarios(pk_nr_funcionario)
    );

create table disciplinas(
	pk_codigo_disciplina int auto_increment primary key,
    nome_disciplina varchar(60) not null,
    fk_codigo_curso int not null,
    foreign key(fk_codigo_curso) references cursos(pk_codigo_curso)
);

create table matriculas(
	pk_numero_matricula int auto_increment primary key,
    fk_rgm_aluno int not null,
    fk_codigo_disciplina int not null,
    data_matricula date not null,
    status_matricula enum('ativa', 'cancelada', 'concluida') default 'ativa',
    created_at timestamp default current_timestamp,
    
    foreign key(fk_codigo_disciplina) references disciplinas(pk_codigo_disciplina),
    foreign key(fk_rgm_aluno) references alunos(pk_rgm_aluno),
    constraint uq_matricula unique(fk_rgm_aluno, fk_codigo_disciplina)
);

create table notas(
	pk_registro_nota int auto_increment primary key,
    qtde_faltas tinyint unsigned not null default 0,
    fk_numero_matricula int not null,
    
    nota_final decimal(4,2) check(nota_final between 0 and 10),
    foreign key(fk_numero_matricula) references matriculas(pk_numero_matricula)
);

create table contratos_educacionais(
	pk_nr_contrato int auto_increment primary key,
    fk_rgm_aluno int not null,
    data_inicio date not null,
    created_at timestamp default current_timestamp,
    
    foreign key(fk_rgm_aluno) references alunos(pk_rgm_aluno)
);

create table mensalidades(
	pk_codigo_mensalidade int auto_increment primary key,
    fk_nr_contrato int not null,
    valor_mensalidade decimal(10,2) not null,
    data_vencimento date not null,
	status_pagamento enum('pendente', 'pago', 'atrasado') default 'pendente',
    
    foreign key(fk_nr_contrato) references contratos_educacionais(pk_nr_contrato)
);

create table pagamentos(
	pk_nr_pagamento int auto_increment primary key,
    fk_codigo_mensalidade int not null,
    data_pagamento date not null,
    valor_pago decimal(10,2) not null,
    created_at timestamp default current_timestamp,
    
    foreign key(fk_codigo_mensalidade) references mensalidades(pk_codigo_mensalidade)
);

create table vinculos_professor_disciplina(
	pk_codigo_vinculo int auto_increment primary key,
    fk_registro_professor int not null,
    fk_codigo_disciplina int not null,
    
    foreign key(fk_registro_professor) references professores(pk_registro_professor),
    foreign key(fk_codigo_disciplina) references disciplinas(pk_codigo_disciplina),
    constraint uq_vinculo unique(fk_registro_professor, fk_codigo_disciplina)
);

create table carga_horaria_docente(
	pk_registro_cargo int auto_increment primary key,
    fk_registro_professor int not null,
    horas_aula tinyint unsigned not null,
    
    foreign key(fk_registro_professor) references professores(pk_registro_professor)
);

-- testes INSERT

INSERT INTO funcionarios (nome_funcionario) VALUES 
('Carlos Roberto (Professor)'), 
('Fernanda Lima (Professora)'),
('João Silva (Secretaria)');

INSERT INTO professores (fk_nr_funcionario) VALUES (1), (2);

INSERT INTO cursos (nome_curso) VALUES 
('Análise e Desenvolvimento de Sistemas'), 
('Administração');

INSERT INTO disciplinas (nome_disciplina, fk_codigo_curso) VALUES 
('Banco de Dados I', 1), 
('Algoritmos e Lógica', 1),
('Gestão Financeira', 2);

INSERT INTO alunos (nome_aluno, data_nascimento, cpf, status_aluno) VALUES 
('Ana Clara Souza', '2002-05-14', '11122233344', 'ativo'),
('Pedro Henrique Gomes', '1999-10-20', '55566677788', 'ativo'),
('Lucas Moraes', '2001-01-30', '99988877766', 'trancado');

INSERT INTO matriculas (fk_rgm_aluno, fk_codigo_disciplina, data_matricula) VALUES 
(1, 1, '2026-02-01'), 
(2, 1, '2026-02-02'),
(1, 2, '2026-02-01'); 

INSERT INTO notas (qtde_faltas, fk_numero_matricula, nota_final) VALUES 
(2, 1, 9.50),
(10, 2, 4.00);

INSERT INTO contratos_educacionais (fk_rgm_aluno, data_inicio) VALUES (1, '2026-01-15');

INSERT INTO mensalidades (fk_nr_contrato, valor_mensalidade, data_vencimento, status_pagamento) VALUES 
(1, 850.00, '2026-02-10', 'pago'),
(1, 850.00, '2026-03-10', 'pendente');

INSERT INTO pagamentos (fk_codigo_mensalidade, data_pagamento, valor_pago) VALUES 
(1, '2026-02-09', 850.00);

INSERT INTO vinculos_professor_disciplina (fk_registro_professor, fk_codigo_disciplina) VALUES 
(1, 1), (1, 2);

INSERT INTO carga_horaria_docente (fk_registro_professor, horas_aula) VALUES (1, 40);

-- testando os SELECTS com os dados inseridos

SELECT * FROM funcionarios;
SELECT * FROM alunos;
SELECT * FROM cursos;
SELECT * FROM professores;
SELECT * FROM disciplinas;
SELECT * FROM matriculas;
SELECT * FROM notas;
SELECT * FROM contratos_educacionais;
SELECT * FROM mensalidades;
SELECT * FROM pagamentos;
SELECT * FROM vinculos_professor_disciplina;
SELECT * FROM carga_horaria_docente;

-- vou unir dados e tabelas com os JOINs

-- JOIN com alunos, matriculas e disciplinas

-- Boletim do Aluno
SELECT 
    a.nome_aluno AS 'Aluno',
    c.nome_curso AS 'Curso',
    d.nome_disciplina AS 'Disciplina',
    n.qtde_faltas AS 'Faltas',
    n.nota_final AS 'Nota'
FROM alunos a
INNER JOIN matriculas m ON a.pk_rgm_aluno = m.fk_rgm_aluno
INNER JOIN disciplinas d ON m.fk_codigo_disciplina = d.pk_codigo_disciplina
INNER JOIN cursos c ON d.fk_codigo_curso = c.pk_codigo_curso
INNER JOIN notas n ON m.pk_numero_matricula = n.fk_numero_matricula
WHERE a.nome_aluno = 'Ana Clara Souza';

-- Inadimplência financeira
SELECT 
    a.nome_aluno AS 'Aluno',
    a.cpf AS 'CPF',
    men.data_vencimento AS 'Vencimento',
    men.valor_mensalidade AS 'Valor (R$)',
    men.status_pagamento AS 'Status'
FROM alunos a
INNER JOIN contratos_educacionais ce ON a.pk_rgm_aluno = ce.fk_rgm_aluno
INNER JOIN mensalidades men ON ce.pk_nr_contrato = men.fk_nr_contrato
WHERE men.status_pagamento != 'pago';

-- Relatório de Matrículas
SELECT 
    a.nome_aluno AS 'Nome do Aluno',
    d.nome_disciplina AS 'Disciplina Matriculada',
    m.data_matricula AS 'Data da Matrícula'
FROM matriculas m
INNER JOIN alunos a ON m.fk_rgm_aluno = a.pk_rgm_aluno
INNER JOIN disciplinas d ON m.fk_codigo_disciplina = d.pk_codigo_disciplina
ORDER BY a.nome_aluno;


-- Relatório de Notas
SELECT 
    a.nome_aluno AS 'Aluno',
    d.nome_disciplina AS 'Disciplina',
    n.nota_final AS 'Nota',
    n.qtde_faltas AS 'Faltas',
    -- Calculando a aprovação
    CASE 
        WHEN n.nota_final >= 6.0 AND n.qtde_faltas <= 15 THEN 'Aprovado'
        ELSE 'Reprovado'
    END AS 'Situação'
FROM notas n
INNER JOIN matriculas m ON n.fk_numero_matricula = m.pk_numero_matricula
INNER JOIN alunos a ON m.fk_rgm_aluno = a.pk_rgm_aluno
INNER JOIN disciplinas d ON m.fk_codigo_disciplina = d.pk_codigo_disciplina
ORDER BY a.nome_aluno, d.nome_disciplina;

-- Relatório financeiro
SELECT 
    a.nome_aluno AS 'Aluno',
    men.valor_mensalidade AS 'Valor Original (R$)',
    men.data_vencimento AS 'Vencimento',
    men.status_pagamento AS 'Status',
    p.data_pagamento AS 'Data Pago',
    p.valor_pago AS 'Valor Pago (R$)'
FROM mensalidades men
INNER JOIN contratos_educacionais c ON men.fk_nr_contrato = c.pk_nr_contrato
INNER JOIN alunos a ON c.fk_rgm_aluno = a.pk_rgm_aluno
LEFT JOIN pagamentos p ON p.fk_codigo_mensalidade = men.pk_codigo_mensalidade
ORDER BY men.data_vencimento ASC;


-- Alocação de professores
SELECT 
    f.nome_funcionario AS 'Professor',
    d.nome_disciplina AS 'Disciplina Lecionada',
    ch.horas_aula AS 'Carga Horária (Horas)'
FROM vinculos_professor_disciplina vpd
INNER JOIN professores p ON vpd.fk_registro_professor = p.pk_registro_professor
INNER JOIN funcionarios f ON p.fk_nr_funcionario = f.pk_nr_funcionario
INNER JOIN disciplinas d ON vpd.fk_codigo_disciplina = d.pk_codigo_disciplina
LEFT JOIN carga_horaria_docente ch ON p.pk_registro_professor = ch.fk_registro_professor
ORDER BY f.nome_funcionario;

-- modificando o limeite de caracteres, tirando a máscara
alter table alunos modify cpf char(11) not null;