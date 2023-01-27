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
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `chat_id` bigint NOT NULL AUTO_INCREMENT,
  `first_user_id` bigint DEFAULT NULL,
  `second_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `FK9265u35xsivl39tpo2dt3msk` (`first_user_id`),
  KEY `FK7hx3gjyxthygliqucpt85oup4` (`second_user_id`),
  CONSTRAINT `FK7hx3gjyxthygliqucpt85oup4` FOREIGN KEY (`second_user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK9265u35xsivl39tpo2dt3msk` FOREIGN KEY (`first_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `likes_count` int DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `post_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `FKs1slvnkuemjsq2kj4h3vhx7i1` (`post_id`),
  KEY `FK8kcum44fvpupyw6f5baccx25c` (`user_id`),
  CONSTRAINT `FK8kcum44fvpupyw6f5baccx25c` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKs1slvnkuemjsq2kj4h3vhx7i1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'2023-01-26 14:22:46.709028',0,'dasdasdasd',1,2),(2,'2023-01-26 14:37:50.485007',0,'dasdasd',1,2),(3,'2023-01-27 14:55:02.059936',0,'foarte frumos',1,1),(4,'2023-01-27 15:11:34.109450',0,'nu imi mai fura vanzarile',2,2),(5,'2023-01-27 16:10:25.513733',0,'dasdasd',1,2),(6,'2023-01-27 16:10:26.802657',0,'asdasd',1,2),(7,'2023-01-27 16:10:27.931313',0,'asdad',1,2),(8,'2023-01-27 16:18:03.638446',0,'dasdasd',1,2),(9,'2023-01-27 16:18:05.192324',0,'dadsad',1,2),(10,'2023-01-27 16:18:06.195468',0,'dd',1,2),(11,'2023-01-27 16:18:07.380689',0,'d',1,2),(12,'2023-01-27 16:18:08.398248',0,'d',1,2),(13,'2023-01-27 16:18:10.744323',0,'d',1,2),(14,'2023-01-27 16:18:11.752517',0,'d',1,2),(15,'2023-01-27 16:18:13.135271',0,'d',1,2),(16,'2023-01-27 16:54:23.367757',0,'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',1,2),(17,'2023-01-27 17:03:34.240746',0,'dddddddddasda akdsa kaj dloasjdklasjd aksdjla sdjaskl djaslkdasl jdaksldjasld\n',1,2),(18,'2023-01-27 17:07:00.956291',0,'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',1,2),(19,'2023-01-27 17:12:23.563692',0,'ddddddddddddddddddddddddddddddddddddddddddddddd',1,2),(20,'2023-01-27 17:14:59.620497',0,'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',1,2),(21,'2023-01-27 17:28:35.117149',0,'jkasndk asdjasdj knasdjknas jdkaskjdasn  jkdasndkjas  ndaskjnd as',1,2);
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
  CONSTRAINT `FK28jq0hbsgm4tqch6co05usp2i` FOREIGN KEY (`follower_id`) REFERENCES `profile` (`profile_id`),
  CONSTRAINT `FK3xc9a9rnt6pxp8vinc1oc5a0r` FOREIGN KEY (`followed_id`) REFERENCES `profile` (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (1,2,1),(2,1,2);
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
  `comment_id` bigint DEFAULT NULL,
  `post_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`like_id`),
  KEY `FK8arpx7i3g3e5dammtdsira2m6` (`comment_id`),
  KEY `FKowd6f4s7x9f3w50pvlo6x3b41` (`post_id`),
  KEY `FKi2wo4dyk4rok7v4kak8sgkwx0` (`user_id`),
  CONSTRAINT `FK8arpx7i3g3e5dammtdsira2m6` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`),
  CONSTRAINT `FKi2wo4dyk4rok7v4kak8sgkwx0` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKowd6f4s7x9f3w50pvlo6x3b41` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,NULL,1,1),(7,NULL,1,2);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `message_id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `chat_id` bigint DEFAULT NULL,
  `recipient_id` bigint DEFAULT NULL,
  `sender_id` bigint DEFAULT NULL,
  PRIMARY KEY (`message_id`),
  KEY `FKmejd0ykokrbuekwwgd5a5xt8a` (`chat_id`),
  KEY `FKiup8wew331d92o7u3k8d918o3` (`recipient_id`),
  KEY `FKcnj2qaf5yc36v2f90jw2ipl9b` (`sender_id`),
  CONSTRAINT `FKcnj2qaf5yc36v2f90jw2ipl9b` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKiup8wew331d92o7u3k8d918o3` FOREIGN KEY (`recipient_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKmejd0ykokrbuekwwgd5a5xt8a` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`chat_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,_binary '\0','alexandra.ene started following you','2023-01-27 16:33:44.883904','FOLLOW',NULL,2,1),(2,_binary '','alexandra.ene just liked your post','2023-01-27 16:35:19.882744','LIKE',1,2,1),(3,_binary '','alexandra.ene just commented on your post','2023-01-27 16:55:02.067936','COMMENT',1,2,1),(4,_binary '\0','ortansa.barbu started following you','2023-01-27 17:09:19.968865','FOLLOW',NULL,1,2),(5,_binary '','ortansa.barbu just commented on your post','2023-01-27 17:11:34.114450','COMMENT',2,1,2),(6,_binary '','ortansa.barbu just liked your post','2023-01-27 20:56:47.058322','LIKE',2,1,2),(7,_binary '','ortansa.barbu just liked your post','2023-01-27 20:58:45.379072','LIKE',2,1,2),(8,_binary '','ortansa.barbu just liked your post','2023-01-27 20:59:14.633758','LIKE',2,1,2);
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
  CONSTRAINT `FK72mt33dhhs48hf9gcqrq4fxte` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,20,'2023-01-26 14:12:08.415628','Descriere','product-images/e81008c4-701f-4e80-b2e2-255555a8749f-istockphoto-1076492576-612x612.jpg',2,1,2,'Titlu',2),(2,1,'2023-01-27 15:04:36.453273','Descriere2','product-images/74e2767b-42df-4a13-a25f-2393fb835339-istockphoto-1076492576-612x612.jpg',0,2,1,'Titlu2',1);
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
INSERT INTO `profile` VALUES (1,'New to Reseller','Alexandra Ene','profile-pictures/19e2dc29-d7b4-4178-bd63-45ea3cd94248-windows_10_red_in_4k-wallpaper-1920x1080.jpg',_binary '\0','alexandra.ene',1),(2,'New to Reseller','Ortansa Barbu','profile-pictures/bab0132a-8d15-4256-89fc-0661cfdb886d-user-ge5a12c801_640.png',_binary '\0','ortansa.barbu',2),(3,'New to Reseller','Floare Ionescu',NULL,_binary '\0','floare.ionescu',3),(4,'New to Reseller','Anastasia Ionita',NULL,_binary '\0','anastasia.ionita',4),(5,'New to Reseller','Emil Dumitrescu',NULL,_binary '\0','emil.dumitrescu',5),(6,'New to Reseller','Nicusor Stanescu',NULL,_binary '\0','nicusor.stanescu',6),(7,'New to Reseller','Semenica Tomescu',NULL,_binary '\0','semenica.tomescu',7),(8,'New to Reseller','Todor Puscasu',NULL,_binary '\0','todor.puscasu',8),(9,'New to Reseller','Florenta Tabacu',NULL,_binary '\0','florenta.tabacu',9),(10,'New to Reseller','Leontina Oprea',NULL,_binary '\0','leontina.oprea',10),(11,'New to Reseller','Adela Dinu',NULL,_binary '\0','adela.dinu',11),(12,'New to Reseller','Geanina Dochioiu',NULL,_binary '\0','geanina.dochioiu',12),(13,'New to Reseller','Estera Barbu',NULL,_binary '\0','estera.barbu',13),(14,'New to Reseller','Simion Oprea',NULL,_binary '\0','simion.oprea',14),(15,'New to Reseller','Irina Nistor',NULL,_binary '\0','irina.nistor',15),(16,'New to Reseller','Raul Nistor',NULL,_binary '\0','raul.nistor',16),(17,'New to Reseller','Flaviu Eftimie',NULL,_binary '\0','flaviu.eftimie',17),(18,'New to Reseller','Teofil Ababei',NULL,_binary '\0','teofil.ababei',18),(19,'New to Reseller','Marcel Toma',NULL,_binary '\0','marcel.toma',19),(20,'New to Reseller','Marcu Stancu',NULL,_binary '\0','marcu.stancu',20),(21,'New to Reseller','admin admin',NULL,_binary '\0','admin',21);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_token`
--

LOCK TABLES `refresh_token` WRITE;
/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
INSERT INTO `refresh_token` VALUES (1,'2023-01-26 14:09:27.638082','b7de2321-37dc-4ab4-a226-52739823a8f7'),(3,'2023-01-27 14:33:20.603159','689d16f3-c249-4c99-b35b-5e4f899fbd1e'),(6,'2023-01-27 15:08:57.497381','d1a860ad-8bef-4a3d-897f-78663cf762c8'),(7,'2023-01-27 21:22:16.690749','ee2c7958-25f4-47ef-8b4e-60e776e9ff64');
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
  CONSTRAINT `FKe32ek7ixanakfqsdaokm4q9y2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
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
INSERT INTO `user` VALUES (1,'2023-01-24 11:06:37.678446','alexandra.ene@gmail.com',_binary '','$2a$10$tjY.GpacmpqR0AZxcL/lzeaWl/KZ6KDHBagNIvNupnqiYkNBwrd7S','USER','alexandra.ene'),(2,'2023-01-24 11:06:37.810448','ortansa.barbu@gmail.com',_binary '','$2a$10$PwoodipTv9ndCJGA6257GOzNqmS.9rpuvlO9arfmS.clcTZH9L29O','USER','ortansa.barbu'),(3,'2023-01-24 11:06:37.889447','floare.ionescu@gmail.com',_binary '','$2a$10$icrIL6uPq8a5juUEK44C5O7sYlEtK2w8F8njphXp0CcVNCBEakx8i','USER','floare.ionescu'),(4,'2023-01-24 11:06:37.965450','anastasia.ionita@gmail.com',_binary '','$2a$10$r3Oi6ZCfP33UDt2pnFxrjODGhN0Atj7V5DtMCFzZfDlF5T2YCPKE6','USER','anastasia.ionita'),(5,'2023-01-24 11:06:38.045448','emil.dumitrescu@gmail.com',_binary '','$2a$10$iToo6MBq5xQxctn3e//u0OxsbG3AE1YepeBf0mbPaUZbtKFOeFHqa','USER','emil.dumitrescu'),(6,'2023-01-24 11:06:38.127448','nicusor.stanescu@gmail.com',_binary '','$2a$10$H0KMM.SloEuA/n55E/OaSeCzD55DGXVp7IpRKwsfXUSlrvV3CWfBm','USER','nicusor.stanescu'),(7,'2023-01-24 11:06:38.205449','semenica.tomescu@gmail.com',_binary '','$2a$10$TjwGR0nNZ/WyUMTV14yy4O2H1OVk6H0gdw4H.BUepTlXieaMNqcdW','USER','semenica.tomescu'),(8,'2023-01-24 11:06:38.288449','todor.puscasu@gmail.com',_binary '','$2a$10$dkIhb1kmFaEriGoxxzi8OuSSTMPNdwzvn9RZARxAy93569/sldJPi','USER','todor.puscasu'),(9,'2023-01-24 11:06:38.366008','florenta.tabacu@gmail.com',_binary '','$2a$10$hO6TjNVR1YWsckSv.cgvNu.UeLzVLuN4RKVuMqwxkmBzyzYxzWdXK','USER','florenta.tabacu'),(10,'2023-01-24 11:06:38.443009','leontina.oprea@gmail.com',_binary '','$2a$10$p6Qmsfvbfqu/q/lOwebzG.2xZwVfCvpA5GnRRc4ZiQG/58ByRPSWW','USER','leontina.oprea'),(11,'2023-01-24 11:06:38.522010','adela.dinu@gmail.com',_binary '','$2a$10$7jqHZI/c8F5JoO.i3Lzz3uAZgPFi55Gm6kHxu6.VxIX5EPWGMWR.G','USER','adela.dinu'),(12,'2023-01-24 11:06:38.598011','geanina.dochioiu@gmail.com',_binary '','$2a$10$UNnkBd2/Kzk.ZkZA2Q06R.UvssuQS2DTUFmDMdl1cEoY1Aqcgyp/a','USER','geanina.dochioiu'),(13,'2023-01-24 11:06:38.677010','estera.barbu@gmail.com',_binary '','$2a$10$ZhFU3pLm17FsyOBKRvSHHeaLZeVv7hc21mxPNFAKqrvke/PZfXutu','USER','estera.barbu'),(14,'2023-01-24 11:06:38.758011','simion.oprea@gmail.com',_binary '','$2a$10$PSYusk.A3jUEjFsDOk/OfeV3FBaIcxtXfh2QvooJK6XDrU6LthcYq','USER','simion.oprea'),(15,'2023-01-24 11:06:38.836009','irina.nistor@gmail.com',_binary '','$2a$10$4hMgGtlWOiebA4Gg75ALcehnP7fZPmJBlByYiattGaeTDxzZI4yzi','USER','irina.nistor'),(16,'2023-01-24 11:06:38.918009','raul.nistor@gmail.com',_binary '','$2a$10$xGTjHEh0qpIVHM.9diVpVu2UF0RqYq.0FY9dTawbB5S99Cl9z5AW.','USER','raul.nistor'),(17,'2023-01-24 11:06:39.001011','flaviu.eftimie@gmail.com',_binary '','$2a$10$7XlO6qL28.YVHT6uCgA/le/NVmzcspesqwdYeKPBAzCMXXwDasTAK','USER','flaviu.eftimie'),(18,'2023-01-24 11:06:39.086012','teofil.ababei@gmail.com',_binary '','$2a$10$zRMjsBr.DIXV099Y84yHkOiPLew/uqUN6gAGd0Zlf9vvkl7.eSkaC','USER','teofil.ababei'),(19,'2023-01-24 11:06:39.170009','marcel.toma@gmail.com',_binary '','$2a$10$ZrDih7Ln93lVmdASwg2q8umfyp32P.SRQXmOmXFnZYAwiKRGGnZvy','USER','marcel.toma'),(20,'2023-01-24 11:06:39.249009','marcu.stancu@gmail.com',_binary '','$2a$10$8kNtE3wZlJEwmvGfIdRx2OscOUGH98oJ1GJA9401KaXyctuGTZcxq','USER','marcu.stancu'),(21,'2023-01-24 11:08:21.019177','admin@mil.com',_binary '','$2a$10$juBBX.SqiV9Lj/PATSophebeHM3YxjV8xaV07OgysVkikaVuIVJG6','ADMIN','admin');
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
  CONSTRAINT `FKceor61aistecmo62mqb8b8dgd` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `FKd4r80jm8s41fgoa0xv9yy5lo8` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (1,1,1),(2,1,2),(3,2,2);
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

-- Dump completed on 2023-01-27 23:45:56
