CREATE DATABASE `graph`;

DROP SCHEMA IF EXISTS `graph`;
CREATE SCHEMA `graph`;
USE `graph`;

-- MySQL dump 10.13  Distrib 8.2.0, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: graph
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Resource`
--

DROP TABLE IF EXISTS `Resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Resource` (
  `uuid` varchar(36) NOT NULL,
  `resourceKindId` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `fk_Resource_ResourceKind_idx` (`resourceKindId`),
  CONSTRAINT `fk_Resource_ResourceKind` FOREIGN KEY (`resourceKindId`) REFERENCES `ResourceKind` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- 
-- Insert root Resource
--

INSERT INTO graph.Resource
(uuid, resourceKindId, name)
VALUES('0f5ffe8d-ce52-4cae-bfa5-a06550865d53', 1, 'root');

--
-- Table structure for table `ResourceKind`
--

DROP TABLE IF EXISTS `ResourceKind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ResourceKind` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `propertyName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `key_UN` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ResourcesInheritance`
--

DROP TABLE IF EXISTS `ResourcesInheritance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ResourcesInheritance` (
  `parentUuid` varchar(36) NOT NULL,
  `childUuid` varchar(36) NOT NULL,
  PRIMARY KEY (`parentUuid`,`childUuid`),
  KEY `fk_ResourcesInheritance_child_idx` (`childUuid`),
  KEY `fk_ResourcesInheritance_parent_idx` (`parentUuid`),
  CONSTRAINT `fk_ResourcesInheritance_child` FOREIGN KEY (`childUuid`) REFERENCES `Resource` (`uuid`),
  CONSTRAINT `fk_ResourcesInheritance_parent` FOREIGN KEY (`parentUuid`) REFERENCES `Resource` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_migration`
--

DROP TABLE IF EXISTS `_migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_migration` (
  `id` int NOT NULL,
  `version` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-04 21:49:58

INSERT INTO graph.ResourceKind
(id, `key`, name, propertyName)
VALUES(1, 'ROOT', 'root', 'root');
INSERT INTO graph.ResourceKind
(id, `key`, name, propertyName)
VALUES(2, 'ORGANIZATION', 'organization', 'organization');
INSERT INTO graph.ResourceKind
(id, `key`, name, propertyName)
VALUES(3, 'FOLDER', 'Pasta', 'folder');
INSERT INTO graph.ResourceKind
(id, `key`, name, propertyName)
VALUES(4, 'ENVIRONMENT', 'Ambiente', 'environment');
INSERT INTO graph.ResourceKind
(id, `key`, name, propertyName)
VALUES(5, 'USER', 'user', 'group');
INSERT INTO graph.ResourceKind
(id, `key`, name, propertyName)
VALUES(6, 'USER_GROUP', 'user group', 'user');
