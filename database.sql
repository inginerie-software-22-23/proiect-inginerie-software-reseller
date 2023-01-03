CREATE DATABASE  IF NOT EXISTS `reseller` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `reseller`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: reseller
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `refresh_token`
--

DROP TABLE IF EXISTS `refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refresh_token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_token`
--

LOCK TABLES `refresh_token` WRITE;
/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
INSERT INTO `refresh_token` VALUES (2,'2023-01-03 20:37:09.585759','9cf1870e-b62f-4a8c-8a45-731060e1daa7'),(3,'2023-01-03 20:37:20.959339','a1af6b4a-ae2f-4c01-9adc-14e2b3b929ca');
/*!40000 ALTER TABLE `refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `expiry_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `user_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK79keudebybjlldk2o4i0nwqev` (`user_user_id`),
  CONSTRAINT `FK79keudebybjlldk2o4i0nwqev` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,NULL,'49838773-1c44-4f54-8d43-c9c83a89599f',1),(2,NULL,'47e72dd9-09d9-4937-858b-45995afb6a74',2),(3,NULL,'626f6012-68a7-4735-8814-6b539ccfd9be',3),(4,NULL,'db05273e-929b-413d-a642-13d02d664ece',4),(5,NULL,'4cb9740f-07d0-4ec5-a095-843b05256721',5),(6,NULL,'a2ed9053-4a6f-4820-b887-b12a624a852b',6),(7,NULL,'04cd665e-ca25-4cf1-8dc5-959cdca9ee76',7);
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `created` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_role` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2022-12-15 16:02:45.764064','test2@mail.ro',_binary '\0','$2a$10$hjJFD3ZcIHic2AYHnVBtA.HtI1ZEsHKgo0UTvLun82nsW2DtZWOXO','USER','test2'),(2,'2022-12-15 18:37:28.421725','hatz@mail.ro',_binary '\0','$2a$10$YYdM8Ex1QmeDqlmCM6NoV.dWQ51639AobgzBGyXodNggrDLn5nEA6','USER','mimi'),(3,'2022-12-15 18:59:34.502385','verif@mail.ro',_binary '','$2a$10$lL4vzbIbsc7HYLwc8GFOBOM5FBG304TtIpGIr7YZ18CuqSZXMVdUG','USER','accVerificationTest'),(4,'2022-12-15 20:53:38.301228','gion@fakemail.com',_binary '\0','$2a$10$yJo.bFuBkMaCE3p4aIgoOek0YbYksvCs0kzUV4RlrZSbKtxzLj786','USER','gioni'),(5,'2023-01-03 17:03:53.552088','big@mail.ro',_binary '','$2a$10$DiaYUv8Z/ooHelGAe.U9weVkfrX7Be3llK8Mr3RN6FOVbiFGdyw8a','USER','jaja'),(6,'2023-01-03 17:11:15.013178','salutare@mai.com',_binary '','$2a$10$qGbfyOGpd.C5dkLc2h2YW.cf8JuWSMdi9WtAj6wDZ2nQPEbP3KA1e','USER','mama'),(7,'2023-01-03 17:41:56.662389','bigt@mail.ro',_binary '','$2a$10$n/nu5tdarS.EfMsnT3Xffu0ltaebv0FnBH5nXI6TbQBcB0C9ED8c.','ADMIN','bigtima');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-03 22:39:03
