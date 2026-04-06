CREATE DATABASE  IF NOT EXISTS `sisgesc` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sisgesc`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: sisgesc
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos` (
  `pk_rgm_aluno` int NOT NULL AUTO_INCREMENT,
  `nome_aluno` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `cpf` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_aluno` enum('ativo','inativo','trancado') COLLATE utf8mb4_unicode_ci DEFAULT 'ativo',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_rgm_aluno`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES (1,'Ana Clara Souza','2002-05-14','11122233344','ativo','2026-03-28 22:08:59'),(2,'Pedro Henrique Gomes','1999-10-20','55566677788','ativo','2026-03-28 22:08:59'),(3,'Lucas Moraes','2001-01-30','99988877766','trancado','2026-03-28 22:08:59');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carga_horaria_docente`
--

DROP TABLE IF EXISTS `carga_horaria_docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carga_horaria_docente` (
  `pk_registro_cargo` int NOT NULL AUTO_INCREMENT,
  `fk_registro_professor` int NOT NULL,
  `horas_aula` tinyint unsigned NOT NULL,
  PRIMARY KEY (`pk_registro_cargo`),
  KEY `fk_registro_professor` (`fk_registro_professor`),
  CONSTRAINT `carga_horaria_docente_ibfk_1` FOREIGN KEY (`fk_registro_professor`) REFERENCES `professores` (`pk_registro_professor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carga_horaria_docente`
--

LOCK TABLES `carga_horaria_docente` WRITE;
/*!40000 ALTER TABLE `carga_horaria_docente` DISABLE KEYS */;
INSERT INTO `carga_horaria_docente` VALUES (1,1,40);
/*!40000 ALTER TABLE `carga_horaria_docente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratos_educacionais`
--

DROP TABLE IF EXISTS `contratos_educacionais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratos_educacionais` (
  `pk_nr_contrato` int NOT NULL AUTO_INCREMENT,
  `fk_rgm_aluno` int NOT NULL,
  `data_inicio` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_nr_contrato`),
  KEY `fk_rgm_aluno` (`fk_rgm_aluno`),
  CONSTRAINT `contratos_educacionais_ibfk_1` FOREIGN KEY (`fk_rgm_aluno`) REFERENCES `alunos` (`pk_rgm_aluno`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos_educacionais`
--

LOCK TABLES `contratos_educacionais` WRITE;
/*!40000 ALTER TABLE `contratos_educacionais` DISABLE KEYS */;
INSERT INTO `contratos_educacionais` VALUES (1,1,'2026-01-15','2026-03-28 22:08:59');
/*!40000 ALTER TABLE `contratos_educacionais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `pk_codigo_curso` int NOT NULL AUTO_INCREMENT,
  `nome_curso` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`pk_codigo_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,'Análise e Desenvolvimento de Sistemas'),(2,'Administração');
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplinas`
--

DROP TABLE IF EXISTS `disciplinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disciplinas` (
  `pk_codigo_disciplina` int NOT NULL AUTO_INCREMENT,
  `nome_disciplina` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fk_codigo_curso` int NOT NULL,
  PRIMARY KEY (`pk_codigo_disciplina`),
  KEY `fk_codigo_curso` (`fk_codigo_curso`),
  CONSTRAINT `disciplinas_ibfk_1` FOREIGN KEY (`fk_codigo_curso`) REFERENCES `cursos` (`pk_codigo_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplinas`
--

LOCK TABLES `disciplinas` WRITE;
/*!40000 ALTER TABLE `disciplinas` DISABLE KEYS */;
INSERT INTO `disciplinas` VALUES (1,'Banco de Dados I',1),(2,'Algoritmos e Lógica',1),(3,'Gestão Financeira',2);
/*!40000 ALTER TABLE `disciplinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionarios` (
  `pk_nr_funcionario` int NOT NULL AUTO_INCREMENT,
  `nome_funcionario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`pk_nr_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
INSERT INTO `funcionarios` VALUES (1,'Carlos Roberto (Professor)'),(2,'Fernanda Lima (Professora)'),(3,'João Silva (Secretaria)');
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matriculas` (
  `pk_numero_matricula` int NOT NULL AUTO_INCREMENT,
  `fk_rgm_aluno` int NOT NULL,
  `fk_codigo_disciplina` int NOT NULL,
  `data_matricula` date NOT NULL,
  `status_matricula` enum('ativa','cancelada','concluida') COLLATE utf8mb4_unicode_ci DEFAULT 'ativa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_numero_matricula`),
  UNIQUE KEY `uq_matricula` (`fk_rgm_aluno`,`fk_codigo_disciplina`),
  KEY `fk_codigo_disciplina` (`fk_codigo_disciplina`),
  CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`fk_codigo_disciplina`) REFERENCES `disciplinas` (`pk_codigo_disciplina`),
  CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`fk_rgm_aluno`) REFERENCES `alunos` (`pk_rgm_aluno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
INSERT INTO `matriculas` VALUES (1,1,1,'2026-02-01','ativa','2026-03-28 22:08:59'),(2,2,1,'2026-02-02','ativa','2026-03-28 22:08:59'),(3,1,2,'2026-02-01','ativa','2026-03-28 22:08:59');
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensalidades`
--

DROP TABLE IF EXISTS `mensalidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensalidades` (
  `pk_codigo_mensalidade` int NOT NULL AUTO_INCREMENT,
  `fk_nr_contrato` int NOT NULL,
  `valor_mensalidade` decimal(10,2) NOT NULL,
  `data_vencimento` date NOT NULL,
  `status_pagamento` enum('pendente','pago','atrasado') COLLATE utf8mb4_unicode_ci DEFAULT 'pendente',
  PRIMARY KEY (`pk_codigo_mensalidade`),
  KEY `fk_nr_contrato` (`fk_nr_contrato`),
  CONSTRAINT `mensalidades_ibfk_1` FOREIGN KEY (`fk_nr_contrato`) REFERENCES `contratos_educacionais` (`pk_nr_contrato`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensalidades`
--

LOCK TABLES `mensalidades` WRITE;
/*!40000 ALTER TABLE `mensalidades` DISABLE KEYS */;
INSERT INTO `mensalidades` VALUES (1,1,850.00,'2026-02-10','pago'),(2,1,850.00,'2026-03-10','pendente');
/*!40000 ALTER TABLE `mensalidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas` (
  `pk_registro_nota` int NOT NULL AUTO_INCREMENT,
  `qtde_faltas` tinyint unsigned NOT NULL DEFAULT '0',
  `fk_numero_matricula` int NOT NULL,
  `nota_final` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`pk_registro_nota`),
  KEY `fk_numero_matricula` (`fk_numero_matricula`),
  CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`fk_numero_matricula`) REFERENCES `matriculas` (`pk_numero_matricula`),
  CONSTRAINT `notas_chk_1` CHECK ((`nota_final` between 0 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (1,2,1,9.50),(2,10,2,4.00);
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos`
--

DROP TABLE IF EXISTS `pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamentos` (
  `pk_nr_pagamento` int NOT NULL AUTO_INCREMENT,
  `fk_codigo_mensalidade` int NOT NULL,
  `data_pagamento` date NOT NULL,
  `valor_pago` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_nr_pagamento`),
  KEY `fk_codigo_mensalidade` (`fk_codigo_mensalidade`),
  CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`fk_codigo_mensalidade`) REFERENCES `mensalidades` (`pk_codigo_mensalidade`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos`
--

LOCK TABLES `pagamentos` WRITE;
/*!40000 ALTER TABLE `pagamentos` DISABLE KEYS */;
INSERT INTO `pagamentos` VALUES (1,1,'2026-02-09',850.00,'2026-03-28 22:08:59');
/*!40000 ALTER TABLE `pagamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professores`
--

DROP TABLE IF EXISTS `professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professores` (
  `pk_registro_professor` int NOT NULL AUTO_INCREMENT,
  `fk_nr_funcionario` int NOT NULL,
  PRIMARY KEY (`pk_registro_professor`),
  KEY `fk_nr_funcionario` (`fk_nr_funcionario`),
  CONSTRAINT `professores_ibfk_1` FOREIGN KEY (`fk_nr_funcionario`) REFERENCES `funcionarios` (`pk_nr_funcionario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professores`
--

LOCK TABLES `professores` WRITE;
/*!40000 ALTER TABLE `professores` DISABLE KEYS */;
INSERT INTO `professores` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vinculos_professor_disciplina`
--

DROP TABLE IF EXISTS `vinculos_professor_disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vinculos_professor_disciplina` (
  `pk_codigo_vinculo` int NOT NULL AUTO_INCREMENT,
  `fk_registro_professor` int NOT NULL,
  `fk_codigo_disciplina` int NOT NULL,
  PRIMARY KEY (`pk_codigo_vinculo`),
  UNIQUE KEY `uq_vinculo` (`fk_registro_professor`,`fk_codigo_disciplina`),
  KEY `fk_codigo_disciplina` (`fk_codigo_disciplina`),
  CONSTRAINT `vinculos_professor_disciplina_ibfk_1` FOREIGN KEY (`fk_registro_professor`) REFERENCES `professores` (`pk_registro_professor`),
  CONSTRAINT `vinculos_professor_disciplina_ibfk_2` FOREIGN KEY (`fk_codigo_disciplina`) REFERENCES `disciplinas` (`pk_codigo_disciplina`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vinculos_professor_disciplina`
--

LOCK TABLES `vinculos_professor_disciplina` WRITE;
/*!40000 ALTER TABLE `vinculos_professor_disciplina` DISABLE KEYS */;
INSERT INTO `vinculos_professor_disciplina` VALUES (1,1,1),(2,1,2);
/*!40000 ALTER TABLE `vinculos_professor_disciplina` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-28 20:18:01
