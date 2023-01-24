-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: reseller
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `post_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `FKs1slvnkuemjsq2kj4h3vhx7i1` (`post_id`),
  KEY `FK8kcum44fvpupyw6f5baccx25c` (`user_id`),
  CONSTRAINT `FK8kcum44fvpupyw6f5baccx25c` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `FKs1slvnkuemjsq2kj4h3vhx7i1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `followed_id` bigint DEFAULT NULL,
  `follower_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3xc9a9rnt6pxp8vinc1oc5a0r` (`followed_id`),
  KEY `FK28jq0hbsgm4tqch6co05usp2i` (`follower_id`),
  CONSTRAINT `FK28jq0hbsgm4tqch6co05usp2i` FOREIGN KEY (`follower_id`) REFERENCES `profile` (`profile_id`) ON DELETE CASCADE,
  CONSTRAINT `FK3xc9a9rnt6pxp8vinc1oc5a0r` FOREIGN KEY (`followed_id`) REFERENCES `profile` (`profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `like_id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`like_id`),
  KEY `FKowd6f4s7x9f3w50pvlo6x3b41` (`post_id`),
  KEY `FKi2wo4dyk4rok7v4kak8sgkwx0` (`user_id`),
  CONSTRAINT `FKi2wo4dyk4rok7v4kak8sgkwx0` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `FKowd6f4s7x9f3w50pvlo6x3b41` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notification_id` bigint NOT NULL AUTO_INCREMENT,
  `flag` bit(1) NOT NULL,
  `text` varchar(255) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `type` varchar(255) NOT NULL,
  `post_id` bigint DEFAULT NULL,
  `recipient_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `FKn1l10g2mvj4r1qs93k952fshe` (`post_id`),
  KEY `FKqnduwq6ix2pxx1add03905i1i` (`recipient_id`),
  KEY `FKnbt1hengkgjqru2q44q8rlc2c` (`sender_id`),
  CONSTRAINT `FKn1l10g2mvj4r1qs93k952fshe` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `FKnbt1hengkgjqru2q44q8rlc2c` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKqnduwq6ix2pxx1add03905i1i` FOREIGN KEY (`recipient_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT,
  `comment_count` int DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `likes_count` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `saved_count` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `FK72mt33dhhs48hf9gcqrq4fxte` (`user_id`),
  CONSTRAINT `FK72mt33dhhs48hf9gcqrq4fxte` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `profile_id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  KEY `FKawh070wpue34wqvytjqr4hj5e` (`user_id`),
  CONSTRAINT `FKawh070wpue34wqvytjqr4hj5e` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (1,'New to Reseller','Alexandra Ene',NULL,_binary '\0','alexandra.ene',1),(2,'New to Reseller','Ortansa Barbu',NULL,_binary '\0','ortansa.barbu',2),(3,'New to Reseller','Floare Ionescu',NULL,_binary '\0','floare.ionescu',3),(4,'New to Reseller','Anastasia Ionita',NULL,_binary '\0','anastasia.ionita',4),(5,'New to Reseller','Emil Dumitrescu',NULL,_binary '\0','emil.dumitrescu',5),(6,'New to Reseller','Nicusor Stanescu',NULL,_binary '\0','nicusor.stanescu',6),(7,'New to Reseller','Semenica Tomescu',NULL,_binary '\0','semenica.tomescu',7),(8,'New to Reseller','Todor Puscasu',NULL,_binary '\0','todor.puscasu',8),(9,'New to Reseller','Florenta Tabacu',NULL,_binary '\0','florenta.tabacu',9),(10,'New to Reseller','Leontina Oprea',NULL,_binary '\0','leontina.oprea',10),(11,'New to Reseller','Adela Dinu',NULL,_binary '\0','adela.dinu',11),(12,'New to Reseller','Geanina Dochioiu',NULL,_binary '\0','geanina.dochioiu',12),(13,'New to Reseller','Estera Barbu',NULL,_binary '\0','estera.barbu',13),(14,'New to Reseller','Simion Oprea',NULL,_binary '\0','simion.oprea',14),(15,'New to Reseller','Irina Nistor',NULL,_binary '\0','irina.nistor',15),(16,'New to Reseller','Raul Nistor',NULL,_binary '\0','raul.nistor',16),(17,'New to Reseller','Flaviu Eftimie',NULL,_binary '\0','flaviu.eftimie',17),(18,'New to Reseller','Teofil Ababei',NULL,_binary '\0','teofil.ababei',18),(19,'New to Reseller','Marcel Toma',NULL,_binary '\0','marcel.toma',19),(20,'New to Reseller','Marcu Stancu',NULL,_binary '\0','marcu.stancu',20),(21,'New to Reseller','admin admin',NULL,_binary '\0','admin',21);
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_token`
--

LOCK TABLES `refresh_token` WRITE;
/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
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
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKe32ek7ixanakfqsdaokm4q9y2` (`user_id`),
  CONSTRAINT `FKe32ek7ixanakfqsdaokm4q9y2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,NULL,'87b8db82-e7cb-4004-9907-3a4a7e48c62c',1),(2,NULL,'f86a7899-039e-4d2d-ba46-2bec00d76df2',2),(3,NULL,'4eec7af3-6b48-4eea-b851-9ad432f2f113',3),(4,NULL,'7ba93a3d-6817-4ea5-8dd7-5abd063e39ff',4),(5,NULL,'012f34e0-fcc4-4a8c-810a-9394a5f84ea6',5),(6,NULL,'4d4d9d6a-2ee9-45a9-9018-48b05e9ee725',6),(7,NULL,'99c05417-aede-464f-934d-30451b49cffe',7),(8,NULL,'df9eda18-a40a-47fb-b298-adf90842104f',8),(9,NULL,'2d976efb-4e57-4c87-a061-460ca9d1235f',9),(10,NULL,'0c8658c8-4dfb-4220-92bf-6fefb0e62aa1',10),(11,NULL,'99aeb1e1-9970-4349-a678-536ecffe873f',11),(12,NULL,'3c6a52c3-bcda-4683-b3f0-540abd8767da',12),(13,NULL,'5e2b6f28-03ae-4e74-87ff-1068c5495735',13),(14,NULL,'3cad490d-0627-4e94-8358-174cd070d06b',14),(15,NULL,'8b413636-1348-4d63-ba98-09924930009c',15),(16,NULL,'275d10e5-06ce-42e1-99ca-299c7f36555c',16),(17,NULL,'a8ddbf8c-0f3d-4c94-8abd-d8786cca8cfe',17),(18,NULL,'a1d439db-2baf-4921-91b3-93cba739033f',18),(19,NULL,'f4483bd2-9c74-4078-b00a-322005d6468f',19),(20,NULL,'a2cff88c-4ac8-4841-9f75-f8cafa20e793',20),(21,NULL,'bc930f19-8ca6-42b6-936e-e841bd23efbc',21);
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
  `email` varchar(255) DEFAULT NULL,
  `enabled` bit(1) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2023-01-24 11:06:37.678446','alexandra.ene@gmail.com',_binary '','$2a$10$tjY.GpacmpqR0AZxcL/lzeaWl/KZ6KDHBagNIvNupnqiYkNBwrd7S','USER','alexandra.ene'),(2,'2023-01-24 11:06:37.810448','ortansa.barbu@gmail.com',_binary '','$2a$10$PwoodipTv9ndCJGA6257GOzNqmS.9rpuvlO9arfmS.clcTZH9L29O','USER','ortansa.barbu'),(3,'2023-01-24 11:06:37.889447','floare.ionescu@gmail.com',_binary '','$2a$10$icrIL6uPq8a5juUEK44C5O7sYlEtK2w8F8njphXp0CcVNCBEakx8i','USER','floare.ionescu'),(4,'2023-01-24 11:06:37.965450','anastasia.ionita@gmail.com',_binary '','$2a$10$r3Oi6ZCfP33UDt2pnFxrjODGhN0Atj7V5DtMCFzZfDlF5T2YCPKE6','USER','anastasia.ionita'),(5,'2023-01-24 11:06:38.045448','emil.dumitrescu@gmail.com',_binary '','$2a$10$iToo6MBq5xQxctn3e//u0OxsbG3AE1YepeBf0mbPaUZbtKFOeFHqa','USER','emil.dumitrescu'),(6,'2023-01-24 11:06:38.127448','nicusor.stanescu@gmail.com',_binary '','$2a$10$H0KMM.SloEuA/n55E/OaSeCzD55DGXVp7IpRKwsfXUSlrvV3CWfBm','USER','nicusor.stanescu'),(7,'2023-01-24 11:06:38.205449','semenica.tomescu@gmail.com',_binary '','$2a$10$TjwGR0nNZ/WyUMTV14yy4O2H1OVk6H0gdw4H.BUepTlXieaMNqcdW','USER','semenica.tomescu'),(8,'2023-01-24 11:06:38.288449','todor.puscasu@gmail.com',_binary '','$2a$10$dkIhb1kmFaEriGoxxzi8OuSSTMPNdwzvn9RZARxAy93569/sldJPi','USER','todor.puscasu'),(9,'2023-01-24 11:06:38.366008','florenta.tabacu@gmail.com',_binary '','$2a$10$hO6TjNVR1YWsckSv.cgvNu.UeLzVLuN4RKVuMqwxkmBzyzYxzWdXK','USER','florenta.tabacu'),(10,'2023-01-24 11:06:38.443009','leontina.oprea@gmail.com',_binary '','$2a$10$p6Qmsfvbfqu/q/lOwebzG.2xZwVfCvpA5GnRRc4ZiQG/58ByRPSWW','USER','leontina.oprea'),(11,'2023-01-24 11:06:38.522010','adela.dinu@gmail.com',_binary '','$2a$10$7jqHZI/c8F5JoO.i3Lzz3uAZgPFi55Gm6kHxu6.VxIX5EPWGMWR.G','USER','adela.dinu'),(12,'2023-01-24 11:06:38.598011','geanina.dochioiu@gmail.com',_binary '','$2a$10$UNnkBd2/Kzk.ZkZA2Q06R.UvssuQS2DTUFmDMdl1cEoY1Aqcgyp/a','USER','geanina.dochioiu'),(13,'2023-01-24 11:06:38.677010','estera.barbu@gmail.com',_binary '','$2a$10$ZhFU3pLm17FsyOBKRvSHHeaLZeVv7hc21mxPNFAKqrvke/PZfXutu','USER','estera.barbu'),(14,'2023-01-24 11:06:38.758011','simion.oprea@gmail.com',_binary '','$2a$10$PSYusk.A3jUEjFsDOk/OfeV3FBaIcxtXfh2QvooJK6XDrU6LthcYq','USER','simion.oprea'),(15,'2023-01-24 11:06:38.836009','irina.nistor@gmail.com',_binary '','$2a$10$4hMgGtlWOiebA4Gg75ALcehnP7fZPmJBlByYiattGaeTDxzZI4yzi','USER','irina.nistor'),(16,'2023-01-24 11:06:38.918009','raul.nistor@gmail.com',_binary '','$2a$10$xGTjHEh0qpIVHM.9diVpVu2UF0RqYq.0FY9dTawbB5S99Cl9z5AW.','USER','raul.nistor'),(17,'2023-01-24 11:06:39.001011','flaviu.eftimie@gmail.com',_binary '','$2a$10$7XlO6qL28.YVHT6uCgA/le/NVmzcspesqwdYeKPBAzCMXXwDasTAK','USER','flaviu.eftimie'),(18,'2023-01-24 11:06:39.086012','teofil.ababei@gmail.com',_binary '','$2a$10$zRMjsBr.DIXV099Y84yHkOiPLew/uqUN6gAGd0Zlf9vvkl7.eSkaC','USER','teofil.ababei'),(19,'2023-01-24 11:06:39.170009','marcel.toma@gmail.com',_binary '','$2a$10$ZrDih7Ln93lVmdASwg2q8umfyp32P.SRQXmOmXFnZYAwiKRGGnZvy','USER','marcel.toma'),(20,'2023-01-24 11:06:39.249009','marcu.stancu@gmail.com',_binary '','$2a$10$8kNtE3wZlJEwmvGfIdRx2OscOUGH98oJ1GJA9401KaXyctuGTZcxq','USER','marcu.stancu'),(21,'2023-01-24 11:08:21.019177','admin@mil.com',_binary '','$2a$10$juBBX.SqiV9Lj/PATSophebeHM3YxjV8xaV07OgysVkikaVuIVJG6','USER','admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `wishlist_id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`wishlist_id`),
  KEY `FKceor61aistecmo62mqb8b8dgd` (`post_id`),
  KEY `FKd4r80jm8s41fgoa0xv9yy5lo8` (`user_id`),
  CONSTRAINT `FKceor61aistecmo62mqb8b8dgd` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE,
  CONSTRAINT `FKd4r80jm8s41fgoa0xv9yy5lo8` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-24 13:09:29
