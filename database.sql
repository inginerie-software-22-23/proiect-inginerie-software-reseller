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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (1,7,4),(2,13,15),(3,13,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'2023-01-30 22:07:19.777768',0,'Very nice',22,7),(2,'2023-01-30 22:08:34.323891',0,'They are so ugly.',28,7),(3,'2023-01-30 22:12:09.811559',0,'Very expensive ???',6,7),(4,'2023-01-30 22:12:36.563522',0,'nice pose',2,7),(5,'2023-01-30 22:13:34.178205',0,'very expensive considering the condition ????',3,7),(6,'2023-01-30 22:14:04.809110',0,'Lovely ❤️❤️',16,7),(7,'2023-01-30 22:16:07.981244',0,'Is that you??? ?? So beautiful ?',18,7),(8,'2023-01-30 22:19:11.317042',0,'Foarte tare!!!',5,13),(9,'2023-01-30 22:20:04.456341',0,'Merg la un fotbal cu baetii',8,13),(10,'2023-01-30 22:33:53.721151',0,'Uita-te la mesaje. RASPUNDE-MI?',8,13),(11,'2023-01-30 22:44:17.038572',0,'Still available?',31,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (1,4,7),(2,3,7),(3,2,7),(4,15,13),(5,4,13),(6,13,15),(7,7,4),(8,13,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (2,NULL,24,7),(3,NULL,22,7),(4,NULL,21,7),(5,NULL,18,7),(6,NULL,14,7),(8,NULL,5,13),(11,NULL,8,13),(12,NULL,9,13),(13,NULL,19,13),(14,NULL,30,15),(15,NULL,27,15),(16,NULL,21,15),(17,NULL,18,15),(19,NULL,17,15),(20,NULL,15,15),(21,NULL,14,15),(22,NULL,13,15),(23,NULL,12,15),(24,NULL,11,15),(26,NULL,2,15),(27,NULL,19,15),(29,NULL,31,4),(30,NULL,24,4),(31,NULL,25,4),(32,NULL,28,7),(33,NULL,27,7),(34,NULL,25,7),(35,NULL,17,7),(36,NULL,16,7),(37,NULL,15,7);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'2023-01-30 22:23:10.685696','Buna',3,4,13),(2,'2023-01-30 22:24:28.407865','hei?',3,13,4),(3,'2023-01-30 22:25:22.717681','cum facem sa cumpar si eu ghetele alea de fotbal ca am duminica un amical cu brigada',2,15,13),(4,'2023-01-30 22:30:44.458066','As vrea sa cumpar papucii UGG pentru prietena mea. Crezi ca ai mai putea lasa putin din pret? ?',3,4,13),(5,'2023-01-30 22:40:29.408393','Imi trimiti detaliile de livrare si ii pun cu prima ocazie la curier',2,13,15),(6,'2023-01-30 22:41:02.473469','pretul este acelasi sau se mai poate negocia?',2,15,13),(7,'2023-01-30 22:41:24.327491','Din pacate, pretul nu este negociabil',2,13,15),(8,'2023-01-30 22:45:07.126612','Pot lasa din pret pana la 39₺',3,13,4),(9,'2023-01-30 22:45:40.009794','Hi',1,4,7),(10,'2023-01-30 22:45:50.713739','Yes, the dress is still available',1,4,7),(11,'2023-01-30 22:46:34.854119','U just need to send me the shipping details and i will send it to you',1,4,7),(12,'2023-01-30 22:47:12.051890','Nice',1,7,4),(13,'2023-01-30 22:47:23.643705','I will get back to you soon with the details ',1,7,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,_binary '','zenobia.toma just liked your post','2023-01-31 00:05:50.994606','LIKE',27,3,7),(2,_binary '','zenobia.toma just liked your post','2023-01-31 00:05:55.612361','LIKE',24,1,7),(3,_binary '','zenobia.toma just liked your post','2023-01-31 00:06:00.954259','LIKE',21,2,7),(4,_binary '','zenobia.toma just liked your post','2023-01-31 00:06:05.251728','LIKE',18,4,7),(5,_binary '','zenobia.toma just liked your post','2023-01-31 00:06:35.937112','LIKE',14,19,7),(6,_binary '','zenobia.toma just commented on your post','2023-01-31 00:07:19.790769','COMMENT',22,1,7),(7,_binary '','zenobia.toma just commented on your post','2023-01-31 00:08:34.326892','COMMENT',28,3,7),(8,_binary '','zenobia.toma just commented on your post','2023-01-31 00:12:09.815561','COMMENT',6,12,7),(9,_binary '','zenobia.toma just commented on your post','2023-01-31 00:12:36.566520','COMMENT',2,13,7),(10,_binary '','zenobia.toma just commented on your post','2023-01-31 00:13:34.181205','COMMENT',3,13,7),(11,_binary '','zenobia.toma just commented on your post','2023-01-31 00:14:04.813109','COMMENT',16,4,7),(12,_binary '\0','zenobia.toma started following you','2023-01-31 00:14:17.949047','FOLLOW',NULL,4,7),(13,_binary '','zenobia.toma just commented on your post','2023-01-31 00:16:07.983241','COMMENT',18,4,7),(14,_binary '\0','zenobia.toma started following you','2023-01-31 00:16:59.427279','FOLLOW',NULL,3,7),(15,_binary '\0','zenobia.toma started following you','2023-01-31 00:18:31.649339','FOLLOW',NULL,2,7),(16,_binary '','axinte.mocanu just liked your post','2023-01-31 00:18:59.268585','LIKE',5,12,13),(17,_binary '','axinte.mocanu just commented on your post','2023-01-31 00:19:11.321043','COMMENT',5,12,13),(18,_binary '','axinte.mocanu just liked your post','2023-01-31 00:19:34.565298','LIKE',9,15,13),(19,_binary '','axinte.mocanu just commented on your post','2023-01-31 00:20:04.459344','COMMENT',8,15,13),(20,_binary '\0','axinte.mocanu started following you','2023-01-31 00:20:40.746554','FOLLOW',NULL,15,13),(21,_binary '','axinte.mocanu just liked your post','2023-01-31 00:21:06.956830','LIKE',19,2,13),(22,_binary '\0','axinte.mocanu started following you','2023-01-31 00:21:24.037387','FOLLOW',NULL,4,13),(23,_binary '','axinte.mocanu just commented on your post','2023-01-31 00:33:53.750152','COMMENT',8,15,13),(24,_binary '','octaviu.suciu just liked your post','2023-01-31 00:41:44.875684','LIKE',30,7,15),(25,_binary '','octaviu.suciu just liked your post','2023-01-31 00:41:50.352177','LIKE',27,3,15),(26,_binary '','octaviu.suciu just liked your post','2023-01-31 00:41:53.463597','LIKE',21,2,15),(27,_binary '','octaviu.suciu just liked your post','2023-01-31 00:41:56.656431','LIKE',18,4,15),(28,_binary '','octaviu.suciu just liked your post','2023-01-31 00:42:02.500611','LIKE',15,19,15),(29,_binary '','octaviu.suciu just liked your post','2023-01-31 00:42:07.153310','LIKE',12,16,15),(30,_binary '','octaviu.suciu just liked your post','2023-01-31 00:42:23.170467','LIKE',2,13,15),(31,_binary '\0','octaviu.suciu started following you','2023-01-31 00:42:40.939846','FOLLOW',NULL,13,15),(32,_binary '','janeta.ionescu just liked your post','2023-01-31 00:43:49.512624','LIKE',31,7,4),(33,_binary '\0','janeta.ionescu started following you','2023-01-31 00:43:50.476953','FOLLOW',NULL,7,4),(34,_binary '','janeta.ionescu just commented on your post','2023-01-31 00:44:17.041570','COMMENT',31,7,4),(35,_binary '','janeta.ionescu just liked your post','2023-01-31 00:47:34.120714','LIKE',24,1,4),(36,_binary '','janeta.ionescu just liked your post','2023-01-31 00:47:35.279166','LIKE',25,3,4),(37,_binary '\0','janeta.ionescu started following you','2023-01-31 00:47:50.835745','FOLLOW',NULL,13,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,0,'2023-01-30 21:08:17.887535','Carhartt Men\'s Blue and Navy Jeans  Size: 36\"','product-images/ebf3c8ec-fe70-4356-9166-67142a6e712a-Carhartt_Men\'s_Blue_and_Navy_Jeans.jpg',0,52,0,'Jeans',13),(2,1,'2023-01-30 21:11:04.501648','Umbro Men\'s Joggers-tracksuits    Size	XL','product-images/262bbcf4-1f96-4faa-bcab-0e65f95370e4-Umbro_Men\'s_Joggers-tracksuits.jpg',1,14,0,'Joggers',13),(3,1,'2023-01-30 21:15:53.700915','Nike Men\'s Trainers       Size	UK 9.5','product-images/33c6a679-9a67-400c-8be4-02e07542dbcf-Nike_Men\'s_Trainers.jpg',0,54,0,'Trainers',13),(4,0,'2023-01-30 21:20:17.136559','Ralph Lauren Men\'s Grey and White Shirt   Size	L','product-images/a57cf60d-9ccd-4866-85ce-195cfd67c041-Ralph_Lauren_Men\'s_Grey_and_White_Shirt.jpg',0,30,0,'Shirt',12),(5,1,'2023-01-30 21:22:08.004626','Supreme Men\'s Blue Hat','product-images/4660d1e3-90b9-4b0a-b9f8-bd7ab00ab103-Supreme_Men\'s_Blue_Hat.jpg',1,89,0,'Supreme Hat',12),(6,1,'2023-01-30 21:25:11.171786','BAPE Men\'s Jacket       Size	S','product-images/1ae0df5d-4af0-4c04-94c5-e176de4413b2-Bape_x_PSG_Blue_Camo_Shark_Jacket.jpg',0,999,0,'Babe Jacket',12),(7,0,'2023-01-30 21:27:22.884833','Nike react element 55 SE white size 8 | great condition, only worn a few times, pretty well looked after','product-images/248e480c-2d55-42f8-9c98-cbe1bc61db1f-Nike_react_element_55_SE_white_size_8.jpg',0,48,0,'Trainers',15),(8,2,'2023-01-30 21:28:12.542183','Lotto Solista football boots, firm ground, moulded studs, grey and orange. Really unique boots.  Men\'s size 10  Selling as I never wear them.','product-images/2a3e9536-c427-491a-9e23-ce11fd1b31ae-Lotto_Men\'s_Grey_and_Orange_Footwear.jpg',1,32,1,'Football boots',15),(9,0,'2023-01-30 21:29:01.052751','Canterbury Men\'s Black and Grey T-shirt | Ireland Rugby jersey Great Condition XL but fits like a Large','product-images/a7b275ad-8096-4352-98f5-21229ee65706-Canterbury_Men\'s_Black_and_Grey_T-shirt.jpg',1,30,0,'T-shirt',15),(10,0,'2023-01-30 21:30:10.824977','Alpha Industries nylon biker style jacket. Excellent condition.','product-images/a9fc2bd9-6ba7-46bf-9459-a7a945b92e8e-Alpha_Industries_Men\'s_Black_Jacket.jpg',0,37,0,'Jacket',16),(11,0,'2023-01-30 21:30:34.455274','Vintage rare military felt lined coat.  Great condition. Size medium/large.','product-images/0c8071a8-764e-4b79-870f-65058efb06f8-Men\'s_Green_and_Khaki_Jacket.jpg',1,28,0,'Jacket',16),(12,0,'2023-01-30 21:31:05.486814','Good For Nothing mens puffer coat Worn a bit but still in good condition Acceptable offers✅ Size	L','product-images/c706cf08-e4b1-4a90-9c59-6fa6bdc652f0-Good_for_Nothing_Men\'s_Grey_Coat.jpg',1,72,0,'Coat',16),(13,0,'2023-01-30 21:32:20.961367','Nike Woven Utility Cargo Trousers / Bottoms / Pants in Black. These have been worn a fair amount however they’re still in good condition. Size	L','product-images/6cedc0cc-703d-4aa6-b44b-05e164878f0c-Nike_mens_black_trousers.jpg',1,30,0,'Trousers',19),(14,0,'2023-01-30 21:32:52.121970','?‍♂️ Stussy embroidered logo hoodie  - Size XL  - High quality heavyweight material  - Super nice rose colour  - Great condition no noticeable flaws  - Bought Dover street market E shop and  - Sold as seen ?  - Any questions let me know ?','product-images/22826da0-c6b9-4786-85f4-bd8dcad6b01c-Stüssy_Men\'s_Pink_and_Red_Hoodie.jpg',2,90,0,'Hoodie',19),(15,0,'2023-01-30 21:33:50.345840','Men\'s Khaki and Green Joggers-tracksuits.   Size	L.  Brand new with tags','product-images/d1fb58d1-26e2-4fdc-a248-9f446af37dcc-Men\'s_Khaki_and_Green_Joggers-tracksuits.jpg',2,200,0,'Joggers',19),(16,1,'2023-01-30 21:46:30.937853','Ugg sliders.  Size	UK 6. Condition	Brand new','product-images/b7741c05-15b7-42ac-9d37-c593cd8f08fd-UGG_Women\'s_Slides.jpg',1,42,0,'Slides',4),(17,0,'2023-01-30 21:47:16.252915','Juicy Couture Women\'s Black Joggers-tracksuits. Black wide leg/flared bottoms. Velour. Missing one of the silver waist tie caps.  Also selling the matching hoodie. Will sell together for cheaper.  Will show more pics if requested?','product-images/3e75da44-9ddf-4771-ab43-44203e8201ff-Juicy_Couture_Women\'s_Black_Joggers-tracksuits.jpg',2,48,0,'Joggers',4),(18,1,'2023-01-30 21:49:14.925977','PrettyLittleThing Women\'s Brown and Tan Jacket.  Size	S. Condition	Like new','product-images/14ab2ddf-0e9a-4171-b160-c58481eeb00c-PrettyLittleThing_Women\'s_Brown_and_Tan_Jacket.jpg',2,10,1,'Jacket',4),(19,0,'2023-01-30 21:50:28.895424','Urban Outfitters BDG ecru low waist cargo pants.  Size S. Condition	Used - Excellent','product-images/7d250522-b14c-4f44-b263-38085cc7181f-Urban_Outfitters_Women\'s_Trousers.jpg',2,34,0,'Trousers',2),(20,0,'2023-01-30 21:52:26.854494','Women’s Nike Thea trainers  Size 5  Worn and signs of wear  Any questions please ask','product-images/cfc9a207-45e6-4315-9e92-dcbd20c9e416-Nike_Women\'s_Trainers.jpg',0,15,0,'Trainers',2),(21,0,'2023-01-30 21:53:02.375409','Addidas football boots paid £120. Hardley worn. Selling because dont fit. Addidas nemesis pro FG. Size	UK 8.5','product-images/310b9291-5860-41aa-8aee-d88340555069-Adidas_Women\'s_Trainers.jpg',2,60,1,'Trainers',2),(22,1,'2023-01-30 21:53:44.397987','Gymshark leggings size small','product-images/ff65aaad-04b1-4e09-ad1a-e21c8fa49c67-Gymshark_Women\'s_Leggings.jpg',1,12,0,'Leggings',1),(23,0,'2023-01-30 21:54:37.878121','Gorgeous handmade liquid gold co ord. worn once for a few hours. Size	8','product-images/d1d99776-2b1d-4fa3-b3b8-d3a30ce3b952-Women\'s_Dress.jpg',0,89,0,'Dress',1),(24,0,'2023-01-30 21:55:21.693190','Black open toes kitten heels. Size 5. Worn but good condition','product-images/4c99f843-8585-4e55-abcd-20c96cb8f099-Women\'s_Black_Footwear.jpg',2,5,1,'Footwear',1),(25,0,'2023-01-30 21:56:54.150018','NIKE LAHAR women’s chunky trainers. Worn a handful of times but in great condition. Selling because I am moving and don’t have space. Size	UK 6','product-images/d53250db-4ee6-4cbe-a0bd-6a15749882e6-Nike_Women\'s_Black_Trainers.jpg',2,87,0,'Trainers',3),(27,0,'2023-01-30 22:00:20.955195','Oh Polly red bikini top. Brand new with tags.  Size large','product-images/b515e37c-1294-4e37-a858-bb8c969ec50b-Oh_Polly_Women\'s_Red_Bikini-and-tankini-tops.jpg',2,33,2,'Bikini and tankini tops',3),(28,1,'2023-01-30 22:00:58.347355','Brown kitten heels. Size 5. Slightly worn but good condition','product-images/ddfafcf0-d3a6-48c0-b42d-68b3527e369d-Women\'s_Brown_Footwear.jpg',1,5,0,'Footwear',3),(29,0,'2023-01-30 22:03:22.329032','LV inspired pj shorts set! So cute?. Size: 8 UK','product-images/9f85c01d-7faf-4313-979e-89c62d595d39-Women\'s_Pajamas.jpg',0,12,0,'Pajamas',7),(30,0,'2023-01-30 22:04:06.239857','Motel rocks pink mini halter dress. Size xxs','product-images/f3f97d7a-0aba-470a-9863-53df5261630a-Motel_Women\'s_Pink_Dress.jpg',1,25,1,'Dress',7),(31,1,'2023-01-30 22:04:34.875993','Rose gold plt dress - see through material on waist (can’t really see in pics) - only worn once. Size	8','product-images/3933e5a5-c485-421d-9d29-133b7f1a7843-PrettyLittleThing_Women\'s_Dress.jpg',1,19,1,'Dress',7);
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
  CONSTRAINT `FKawh070wpue34wqvytjqr4hj5e` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (1,'New to Reseller','Mara Stoica','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','mara.stoica',1),(2,'New to Reseller','Alexandrina Voinea','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','alexandrina.voinea',2),(3,'New to Reseller','Crina Stancu','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','crina.stancu',3),(4,'FMI-@unibuc','Janeta Ionescu','profile-pictures/e8ddc548-b0ff-4f8e-b364-0fa64196ccd5-Screenshot_2.png',_binary '\0','janeta.ionescu',4),(5,'New to Reseller','Monalisa Stoica','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','monalisa.stoica',5),(6,'New to Reseller','Andreea Eftimie','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','andreea.eftimie',6),(7,'UMFCD ?','Zenobia Toma','profile-pictures/9f213096-59cb-4fdf-98bd-0355a2a770d9-Screenshot_5.png',_binary '\0','zenobia.toma',7),(8,'New to Reseller','Roxana Toma','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','roxana.toma',8),(9,'New to Reseller','Anisoara Marin','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','anisoara.marin',9),(10,'New to Reseller','Luiza Stanescu','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','luiza.stanescu',10),(11,'New to Reseller','Horia Albu','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','horia.albu',11),(12,'New to Reseller','Leordean Stanescu','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','leordean.stanescu',12),(13,'Horse Trainer ☿','Axinte Mocanu','profile-pictures/d1623991-c7d5-48a4-b7b9-4d83c01b43db-Screenshot_3.png',_binary '\0','axinte.mocanu',13),(14,'New to Reseller','Anton Ardelean','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','anton.ardelean',14),(15,'Personal blog','Octaviu Suciu','profile-pictures/536ca12a-32e0-4bbc-a00b-35de899b4102-Screenshot_4.png',_binary '\0','octaviu.suciu',15),(16,'New to Reseller','Paul Dima','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','paul.dima',16),(17,'New to Reseller','Lucian Dinu','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','lucian.dinu',17),(18,'New to Reseller','Petru Eftimie','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','petru.eftimie',18),(19,'New to Reseller','Corneliu Diaconu','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','corneliu.diaconu',19),(20,'New to Reseller','Niculita Dinu','profile-pictures/9384e2a7-c7fb-46d2-9610-6a36c6d9d05f-user-ge5a12c801_640.png',_binary '\0','niculita.dinu',20);
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_token`
--

LOCK TABLES `refresh_token` WRITE;
/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
INSERT INTO `refresh_token` VALUES (1,'2023-01-30 21:04:57.592720','d3671c70-df9b-4639-8673-a1e80de7fea9'),(3,'2023-01-30 21:17:09.334812','13bcf35e-921e-4b50-a6ff-3f82771491f8'),(5,'2023-01-30 21:26:07.293821','f043bf67-6b45-4935-a011-1f9a429555e3'),(6,'2023-01-30 21:29:24.853881','f2588010-28a4-4529-a343-3a5ac879b6c1'),(7,'2023-01-30 21:31:40.495136','1859736d-8508-41b1-a44d-c0cc675b9a34'),(8,'2023-01-30 21:44:42.035546','4baa2c9b-7042-40a4-a030-c83d634dbbef'),(9,'2023-01-30 21:49:29.885778','d2e443f1-116b-4549-9288-892c3cce22ce'),(10,'2023-01-30 21:53:21.785670','a0bc553c-37d6-4932-b338-c8283015dfb6'),(11,'2023-01-30 21:55:47.807270','954e935b-ef85-475e-b946-9e75c77facb0'),(13,'2023-01-30 22:02:10.170529','3934f5d8-f178-4dcc-b269-2c154bc032c6'),(14,'2023-01-30 22:02:32.764578','e81c6f1e-ae41-4eb3-a495-153229d38185'),(16,'2023-01-30 22:18:45.216344','834f7d50-b2bd-4f29-a0f5-cdb632971da5'),(18,'2023-01-30 22:22:42.736534','a107a230-0780-4fd1-acc7-eb2e4022fe99'),(19,'2023-01-30 22:22:55.642145','e3e10ad6-ed7c-4db0-afa2-aea3ca9f61fb'),(20,'2023-01-30 22:23:19.570687','89ea4e13-8400-432d-8e37-eb221a1d912a'),(22,'2023-01-30 22:39:19.427478','3d913d9f-b73b-4806-91e6-153fba58307c'),(23,'2023-01-30 22:40:46.458311','44ec61c4-1d41-4458-8182-b5ee3a41fdba'),(24,'2023-01-30 22:41:08.640616','5a9cf3e6-6967-4a99-a5e4-176a28fc77e3'),(25,'2023-01-30 22:43:36.162749','976d24b8-94df-486d-b4ed-d2f152ac3481'),(26,'2023-01-30 22:45:17.461563','6311d4ce-666c-45d1-98d1-7987c5975142'),(27,'2023-01-30 22:46:41.084806','2cd49afb-fc31-455e-9c38-4e5bd5f395dc'),(28,'2023-01-30 22:50:13.536302','675ff043-6750-4f5b-8eab-502e41828fb0'),(29,'2023-01-30 22:51:42.717417','a90a4984-f446-4dc5-ad09-340c03e21d99'),(30,'2023-01-30 22:52:25.771094','7d973860-aed7-4a58-a5ea-cc723ed3ce5a'),(31,'2023-01-30 22:53:17.690198','7ed06327-f1ad-49b0-a8bf-f746734ebdcb'),(32,'2023-01-30 22:53:59.046270','865bc08c-43f8-434a-87b7-acd4c614a663'),(33,'2023-01-30 22:54:20.629052','5fc48c66-1c87-432a-a61a-b4f44d157960'),(35,'2023-01-30 22:59:57.329513','8c8f6a22-5404-4db0-86a6-13928ef81ab9'),(36,'2023-01-30 23:00:11.504197','11de901f-331d-4350-9a11-6c70e7e53a54'),(37,'2023-01-30 23:00:16.583532','4d6f8e22-ecfe-4e28-999d-e7a77f278bbd'),(38,'2023-01-30 23:00:40.286836','879b21cd-bc88-47dd-a884-9da6daa49627');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,NULL,'9e91305b-c3a2-4310-aaba-dcf38146276a',1),(2,NULL,'dac547ec-7cb4-4f9c-b7ba-7dcb3b1b920d',2),(3,NULL,'40f1a89c-dcc4-4665-946a-c8fe4e0b18b0',3),(4,NULL,'592a7aff-2d67-4d51-a785-d2cca4ec1612',4),(5,NULL,'f9e5b742-504d-40a4-adb8-76957515fd01',5),(6,NULL,'1ff58a64-a188-4ac3-b456-037be8d6b61d',6),(7,NULL,'aaef52ef-b505-4054-b8ba-9e520e50932a',7),(8,NULL,'d197b033-dd0c-483c-96ad-a21fd3483867',8),(9,NULL,'f864ffbd-f0c4-419d-9e7e-5537fa49d28d',9),(10,NULL,'d267a89c-cf60-4e03-b31a-86a3ee1dcae2',10),(11,NULL,'ef17472b-ff7f-4e45-a177-10ea7138226a',11),(12,NULL,'832f478f-204d-4a9c-a9ca-d8ac698dce5e',12),(13,NULL,'d18d3a16-7984-4735-b935-32e3a4be883f',13),(14,NULL,'ae1851c7-8896-4ee0-8e78-254ec7b6c1d8',14),(15,NULL,'f43cd4b0-7766-4fb4-af4d-bff3c3e13083',15),(16,NULL,'1409eeef-a8c6-4bd0-b275-aca5b5157e77',16),(17,NULL,'2abb4673-a69e-497b-baa6-a5e981788b0b',17),(18,NULL,'78dd8eeb-95eb-4098-acfc-9b3d6503086a',18),(19,NULL,'62a51f15-2f16-4fa2-9854-58371d564c8b',19),(20,NULL,'cfc8e3ee-6722-47b5-8b9b-3f64f5abe8e5',20);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2023-01-30 20:51:29.080897','mara.stoica@gmail.com',_binary '','$2a$10$zQdJ4XRCJLg78SOe./rBfuqQjD0Sz4HRVck5eSjje4dNmUSQFmQAG','USER','mara.stoica'),(2,'2023-01-30 20:51:29.208896','alexandrina.voinea@gmail.com',_binary '','$2a$10$blcvQq58vmahMyuxG6GwSuEu.PEkgHGR1zLTvpdI50vZ1i39BXalm','USER','alexandrina.voinea'),(3,'2023-01-30 20:51:29.289898','crina.stancu@gmail.com',_binary '','$2a$10$0Nl9nMcFyR52FDK4M7Yjpuhfe183v41Yty8/aa5mkZst7kDKNMH6a','USER','crina.stancu'),(4,'2023-01-30 20:51:29.370896','janeta.ionescu@gmail.com',_binary '','$2a$10$J7d9RHTvJgcAqHcJts8AYOOTCIU3sdVPj.BvHQHypEx0/D2M13Egi','USER','janeta.ionescu'),(5,'2023-01-30 20:51:29.448896','monalisa.stoica@gmail.com',_binary '','$2a$10$JSMqNhoj5Z0hOLenUqvsA.QVBK.YA4qOYPrI4jspbNW1lnfwJZV7a','USER','monalisa.stoica'),(6,'2023-01-30 20:51:29.528896','andreea.eftimie@gmail.com',_binary '','$2a$10$VXI0anf/5Wev2X7aRxgIZ.VifsMCMWVTyoCBjSYtYvku4jSg6wIGy','USER','andreea.eftimie'),(7,'2023-01-30 20:51:29.604896','zenobia.toma@gmail.com',_binary '','$2a$10$1NnKPyNOFAsyU/87AhHrXu/tkj6OjEY7wqLYyoiMwzPQgu7m0VRK2','USER','zenobia.toma'),(8,'2023-01-30 20:51:29.682898','roxana.toma@gmail.com',_binary '','$2a$10$XVU61K77ruZc82tutSjHUeIlSRaijtB2B41q/Kiv50Bkrz9BDTwRW','USER','roxana.toma'),(9,'2023-01-30 20:51:29.759896','anisoara.marin@gmail.com',_binary '','$2a$10$36q2UBDG7JvqU1FRDlPZCOqnEQi6iIMF66LcsZWOgcEzi33ywtzcK','USER','anisoara.marin'),(10,'2023-01-30 20:51:29.836897','luiza.stanescu@gmail.com',_binary '','$2a$10$a03I4WVjqvZOzeWOakvYdeOZgi5BQftx5b2ac5.cpD7KchX8NTl3e','USER','luiza.stanescu'),(11,'2023-01-30 20:51:29.915897','horia.albu@gmail.com',_binary '','$2a$10$Qzh4.GL8kjDHqfLnjLqxgewlIShnFtZYo8WI3iZWsj3kMHjBt9afW','USER','horia.albu'),(12,'2023-01-30 20:51:29.990897','leordean.stanescu@gmail.com',_binary '','$2a$10$Eb0xtVjLPHBTTnHktAfHuusBbOYmqUEqxCvL9eyAULB4cLZk3hQva','USER','leordean.stanescu'),(13,'2023-01-30 20:51:30.068897','axinte.mocanu@gmail.com',_binary '','$2a$10$gBcCndUQghlROmKxn1OFgepctQNpL1.2MON4.RuA8AaNQRmkBNIBK','USER','axinte.mocanu'),(14,'2023-01-30 20:51:30.144896','anton.ardelean@gmail.com',_binary '','$2a$10$UWoAKHCc0IhqRp95RHzTJuoBEXO2Q2dz4iXZ1axNVr2t4DJSse/Tu','USER','anton.ardelean'),(15,'2023-01-30 20:51:30.221897','octaviu.suciu@gmail.com',_binary '','$2a$10$w8DeF.75mmUKfkGoQocvruxchkdJt/iqLYfxebccldHt4opEvWxsq','USER','octaviu.suciu'),(16,'2023-01-30 20:51:30.299896','paul.dima@gmail.com',_binary '','$2a$10$94T5k79ZW8p5MqPP2kqU3OBm/m8WtXcf.2BaiTvuFTNk9ySCsaJmW','USER','paul.dima'),(17,'2023-01-30 20:51:30.374896','lucian.dinu@gmail.com',_binary '','$2a$10$QFKZ4CKlkSs.V2ogqMd57.a5O5mx46RWpM0VLMT0A7GW.iX5ymTUa','USER','lucian.dinu'),(18,'2023-01-30 20:51:30.451896','petru.eftimie@gmail.com',_binary '','$2a$10$dNjBHKKcn9R1IZysDKEbzeFhuc6VI6VqL2/0PeprQnp9Cjs6Q2nWe','USER','petru.eftimie'),(19,'2023-01-30 20:51:30.528897','corneliu.diaconu@gmail.com',_binary '','$2a$10$OdgP/C.581gG45dx2H7uvOPt9UenXdx07hSGJNBSFWr7dsGV6H4wm','USER','corneliu.diaconu'),(20,'2023-01-30 20:51:30.604898','niculita.dinu@gmail.com',_binary '','$2a$10$C607lm0WyZ6l06.c5hp7QuDrpX3Ao1/JxYpnu832i8nA0Hb8qYNpm','USER','niculita.dinu');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (1,27,7),(2,24,7),(3,8,13),(4,30,15),(5,27,15),(6,21,15),(7,18,15),(8,31,4);
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

-- Dump completed on 2023-01-31  1:03:21
