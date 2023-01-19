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
  CONSTRAINT `FK8kcum44fvpupyw6f5baccx25c` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKs1slvnkuemjsq2kj4h3vhx7i1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
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
  KEY `FK3gu03ktcbxq8nm9rf4ll2glrr` (`followed_id`),
  KEY `FKmow2qk674plvwyb4wqln37svv` (`follower_id`),
  CONSTRAINT `FK3gu03ktcbxq8nm9rf4ll2glrr` FOREIGN KEY (`followed_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `FKmow2qk674plvwyb4wqln37svv` FOREIGN KEY (`follower_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
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
-- Table structure for table `follower`
--

DROP TABLE IF EXISTS `follower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follower` (
  `follow_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`follow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follower`
--

LOCK TABLES `follower` WRITE;
/*!40000 ALTER TABLE `follower` DISABLE KEYS */;
/*!40000 ALTER TABLE `follower` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followers_following`
--

DROP TABLE IF EXISTS `followers_following`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `followers_following` (
  `follower_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`follower_id`,`user_id`),
  KEY `FK41gjdu8bc14wefdkydxqd3jbl` (`user_id`),
  CONSTRAINT `FK41gjdu8bc14wefdkydxqd3jbl` FOREIGN KEY (`user_id`) REFERENCES `follower` (`follow_id`),
  CONSTRAINT `FK9rfuwyqsyq3o1yfwy62k4uofr` FOREIGN KEY (`follower_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers_following`
--

LOCK TABLES `followers_following` WRITE;
/*!40000 ALTER TABLE `followers_following` DISABLE KEYS */;
/*!40000 ALTER TABLE `followers_following` ENABLE KEYS */;
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
  CONSTRAINT `FKi2wo4dyk4rok7v4kak8sgkwx0` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKowd6f4s7x9f3w50pvlo6x3b41` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
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
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `likes_count` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `comment_count` int DEFAULT NULL,
  `saved_count` int DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `FK72mt33dhhs48hf9gcqrq4fxte` (`user_id`),
  CONSTRAINT `FK72mt33dhhs48hf9gcqrq4fxte` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
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
  `user_user_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  KEY `FKj1eifqha612nl7d01avbpe4ft` (`user_user_id`),
  KEY `FKawh070wpue34wqvytjqr4hj5e` (`user_id`),
  CONSTRAINT `FKawh070wpue34wqvytjqr4hj5e` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `FKj1eifqha612nl7d01avbpe4ft` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (1,'New to Reseller','Ioanina Tabacu',NULL,_binary '\0','ioanina.tabacu',1,NULL),(2,'New to Reseller','Florica Marin',NULL,_binary '\0','florica.marin',2,NULL),(3,'New to Reseller','Luciana Popescu',NULL,_binary '\0','luciana.popescu',3,NULL),(4,'New to Reseller','Noemi Diaconu',NULL,_binary '\0','noemi.diaconu',4,NULL),(5,'New to Reseller','Georgeta Suciu',NULL,_binary '\0','georgeta.suciu',5,NULL),(6,'New to Reseller','Axinte Florea',NULL,_binary '\0','axinte.florea',6,NULL),(7,'New to Reseller','Suzana Tomescu',NULL,_binary '\0','suzana.tomescu',7,NULL),(8,'New to Reseller','Romeo Dumitrescu',NULL,_binary '\0','romeo.dumitrescu',8,NULL),(9,'New to Reseller','Rada Ababei',NULL,_binary '\0','rada.ababei',9,NULL),(10,'New to Reseller','Tudor Tabacu',NULL,_binary '\0','tudor.tabacu',10,NULL),(11,'New to Reseller','Georgel Tabacu',NULL,_binary '\0','georgel.tabacu',11,NULL),(12,'New to Reseller','Evelina Dobre',NULL,_binary '\0','evelina.dobre',12,NULL),(13,'New to Reseller','Costache Diaconescu',NULL,_binary '\0','costache.diaconescu',13,NULL),(14,'New to Reseller','Mina Ene',NULL,_binary '\0','mina.ene',14,NULL),(15,'New to Reseller','Liviu Ionita',NULL,_binary '\0','liviu.ionita',15,NULL),(16,'New to Reseller','Felix Gheorghiu',NULL,_binary '\0','felix.gheorghiu',16,NULL),(17,'New to Reseller','Costache Stoica',NULL,_binary '\0','costache.stoica',17,NULL),(18,'New to Reseller','Crenguta Ababei',NULL,_binary '\0','crenguta.ababei',18,NULL),(19,'New to Reseller','Ovidiu Pop',NULL,_binary '\0','ovidiu.pop',19,NULL),(20,'New to Reseller','Luiza Mocanu',NULL,_binary '\0','luiza.mocanu',20,NULL),(21,'New to Reseller','admin admin',NULL,_binary '\0','admin',NULL,21);
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
  `user_user_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK79keudebybjlldk2o4i0nwqev` (`user_user_id`),
  KEY `FKe32ek7ixanakfqsdaokm4q9y2` (`user_id`),
  CONSTRAINT `FK79keudebybjlldk2o4i0nwqev` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `FKe32ek7ixanakfqsdaokm4q9y2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,NULL,'98a9886e-f301-46e8-9c6a-9f0d6a6087d9',1,NULL),(2,NULL,'66cc3023-e0ca-491d-82f9-d52012b17261',2,NULL),(3,NULL,'4cb36bb6-1699-43b7-a02f-d2ff3a5a4746',3,NULL),(4,NULL,'977f0866-f8e0-4b65-b7c1-980113985c55',4,NULL),(5,NULL,'34fb1cc4-b19a-4ce5-9599-0e7872c431de',5,NULL),(6,NULL,'aa106c81-4a88-49f2-9c93-11892ffb7157',6,NULL),(7,NULL,'21959f37-ba59-4ecf-92df-fd2664361f5d',7,NULL),(8,NULL,'c1cab8ae-b9a6-4dcb-b213-435ca8ba8010',8,NULL),(9,NULL,'85e39c81-b556-4382-91a4-70e8abc2d1bc',9,NULL),(10,NULL,'78484d76-5d93-4943-9b8b-ad5a72cd3f88',10,NULL),(11,NULL,'8e54eb76-0984-4b6e-beec-ce7ec9e08b1c',11,NULL),(12,NULL,'b22dcd44-dcc8-4d2a-b0f7-77ea3295b844',12,NULL),(13,NULL,'d8fa0fe2-d509-48ed-947c-b7c8b35a8a59',13,NULL),(14,NULL,'65d7f335-871a-4217-9c11-d7ea8a3717a5',14,NULL),(15,NULL,'4866ded8-9e8d-4316-95a0-8a2c0cca8904',15,NULL),(16,NULL,'837ab6b0-1904-431e-81cd-20ccb67375a1',16,NULL),(17,NULL,'3076141e-adb4-4140-8056-ae6bad3f73f6',17,NULL),(18,NULL,'bd02bee3-a86f-466c-b935-895b69914e5c',18,NULL),(19,NULL,'e4e20123-865c-44b6-91a8-7a921dc562bf',19,NULL),(20,NULL,'2ea01229-a58e-4956-abda-c1c7eaeec2cb',20,NULL),(21,NULL,'7be47921-fb9f-470e-bf35-60143447dbc6',NULL,21);
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
INSERT INTO `user` VALUES (1,'2023-01-19 22:32:19.692733','ioanina.tabacu@gmail.com',_binary '','$2a$10$zg6TZL13aKe4wYKHH4MAf.0C.PxrFyGMhT0Nu29D4JuiwyuKZe0qO','USER','ioanina.tabacu'),(2,'2023-01-19 22:32:19.817733','florica.marin@gmail.com',_binary '','$2a$10$ik5U.sjxa6.jfkVqrtRNTeMeo3F1XHcyMFPEkWYbrKUEEukbW2g7i','USER','florica.marin'),(3,'2023-01-19 22:32:19.896733','luciana.popescu@gmail.com',_binary '','$2a$10$hbx1lwoJcUyKurqoZtnP9e4GACJmG/Hllj/NEIMIoxbcusmTFxSxK','USER','luciana.popescu'),(4,'2023-01-19 22:32:19.972735','noemi.diaconu@gmail.com',_binary '','$2a$10$Y/prWej6emQPVcfDgJgIF.1HOnREtDnIc3S3vDj/BUwjKUQQipFYW','USER','noemi.diaconu'),(5,'2023-01-19 22:32:20.048733','georgeta.suciu@gmail.com',_binary '','$2a$10$dXwAajizuOF/uGi806z6/OUgPsFG6GDy7Rmo8GELjPy/dPHWpHGbq','USER','georgeta.suciu'),(6,'2023-01-19 22:32:20.125735','axinte.florea@gmail.com',_binary '','$2a$10$wb.AVhmkpZy8WfbYUEWlmuhL6DddWaHgIEmP9.98gqccLdBa06AYC','USER','axinte.florea'),(7,'2023-01-19 22:32:20.203734','suzana.tomescu@gmail.com',_binary '','$2a$10$Ewa0wto1e9a1aOZDvKLU0un0mNNa3enzEOMF6ySrKk4zZBdGI24Ya','USER','suzana.tomescu'),(8,'2023-01-19 22:32:20.281736','romeo.dumitrescu@gmail.com',_binary '','$2a$10$X6TDlBR5x2P4XJhLiKK1iOpp58as9WSGIzbwSvgWGMxvTIGJBld5K','USER','romeo.dumitrescu'),(9,'2023-01-19 22:32:20.358734','rada.ababei@gmail.com',_binary '','$2a$10$5zBIh34GioOOFgZuS8B9sOYHWTzLQ7AeO5PguiNRgqtld8mKdzGkK','USER','rada.ababei'),(10,'2023-01-19 22:32:20.435736','tudor.tabacu@gmail.com',_binary '','$2a$10$CUSaeyI974ogln1zCVEY0OKlPNKvnq8ZLvCEizjzO2pkBhJy4qKhK','USER','tudor.tabacu'),(11,'2023-01-19 22:32:20.513735','georgel.tabacu@gmail.com',_binary '','$2a$10$5.Xa3viWbbNva4Va6D2mEOyL.kOXEjDCzlRCPGhTg7mhgPdYbv9nm','USER','georgel.tabacu'),(12,'2023-01-19 22:32:20.590735','evelina.dobre@gmail.com',_binary '','$2a$10$sYrFDCa/M30clChts0h0EuB5RdcW0sQH4uo9fbYFZllpmykXETYVK','USER','evelina.dobre'),(13,'2023-01-19 22:32:20.666736','costache.diaconescu@gmail.com',_binary '','$2a$10$lGCliskg/o/McC.Q78G9ru2CMu1a80RZA7Ozil4/UYhVRyuanOCKu','USER','costache.diaconescu'),(14,'2023-01-19 22:32:20.746736','mina.ene@gmail.com',_binary '','$2a$10$MfzLIPRL9ZSHuttuGi10duyEjd5L89wJquGt3Ga3TPdsuOYREJL9m','USER','mina.ene'),(15,'2023-01-19 22:32:20.821733','liviu.ionita@gmail.com',_binary '','$2a$10$mFxzj7YVusjNItTzM3FEeOHq4ZsIzHAD/D8HL7uj74JfLd/fmVFme','USER','liviu.ionita'),(16,'2023-01-19 22:32:20.896735','felix.gheorghiu@gmail.com',_binary '','$2a$10$QPJnbU5Vrmtt6/qwfGE7M.mwErj9xy/DmdEK46S41gAbBNSm5ugaK','USER','felix.gheorghiu'),(17,'2023-01-19 22:32:20.973735','costache.stoica@gmail.com',_binary '','$2a$10$QZrtTGjoae.tKzJZjgoI2O6z51Y8SpYvx7m9pPa6va2fTSN/Uc/Bi','USER','costache.stoica'),(18,'2023-01-19 22:32:21.048733','crenguta.ababei@gmail.com',_binary '','$2a$10$S7FQJIY33n5s5qLK.qoD1uYoaQCWe2YGRiMf1WdVvtxWDzHNfosue','USER','crenguta.ababei'),(19,'2023-01-19 22:32:21.125735','ovidiu.pop@gmail.com',_binary '','$2a$10$ialq403oQT9nP.WlVUZxReQzU2pBc0VZAOHfl6CXau6bdJ71zLLTW','USER','ovidiu.pop'),(20,'2023-01-19 22:32:21.200733','luiza.mocanu@gmail.com',_binary '','$2a$10$Qb1Vkir64hJj5mvvsLSB4OuVDqSaEOiAsis6yVephGZexfJQ7JOrK','USER','luiza.mocanu'),(21,'2023-01-19 22:50:49.096204','admin@mil.com',_binary '\0','$2a$10$SPEjQdcriAFDiVU/xXUCyeoFloCrC6lfXf0foCRap9Y5tGqZy2xH2','ADMIN','admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `user_id` bigint NOT NULL,
  `post_id` bigint NOT NULL,
  `wishlist_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `FKceor61aistecmo62mqb8b8dgd` (`post_id`),
  CONSTRAINT `FKceor61aistecmo62mqb8b8dgd` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `FKd4r80jm8s41fgoa0xv9yy5lo8` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
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

-- Dump completed on 2023-01-20  0:51:48
