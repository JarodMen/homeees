-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: billions
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

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
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `id_pack` int NOT NULL,
  `owner_id` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `date_buyed` datetime NOT NULL,
  `pay_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `comprobante` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `voucher` int NOT NULL DEFAULT '1',
  `fecha_activacion` datetime DEFAULT NULL,
  PRIMARY KEY (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (15,6,30,3,'2023-10-02 02:19:37','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696214373711-imagen (18).png',2,NULL),(18,1,41,2,'2023-10-03 07:39:58','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','',1,NULL),(19,1,55,2,'2023-10-03 22:02:40','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696370962449-Froy 2 PRINCIPAL.png',2,NULL),(20,1,55,2,'2023-10-03 22:02:43','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','',2,NULL),(21,1,45,3,'2023-10-04 20:42:55','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696463399300-WhatsApp Image 2023-10-04 at 6.49.18 PM.jpeg',1,NULL),(22,1,73,3,'2023-10-05 02:37:58','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696473581197-imagen (19).png',1,NULL),(23,1,64,3,'2023-10-08 20:27:35','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','',2,NULL),(26,1,45,3,'2023-10-09 16:06:04','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696867588166-imagen (25).png',1,'2023-10-09 16:07:35'),(27,4,40,3,'2023-10-09 20:26:21','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696883302649-IMAGEN FONDO 8 PM.jpg',2,'2023-10-16 04:43:28'),(28,2,75,3,'2023-10-10 18:52:38','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696963975172-imagen (27).png',1,'2023-10-10 18:56:04'),(29,2,1,2,'2023-10-10 18:57:35','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696964270995-IMAGENDUBAI  FONDO 9PM.png',1,NULL),(30,1,64,2,'2023-10-10 19:03:26','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','',1,NULL),(31,1,64,2,'2023-10-10 19:03:27','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','',1,NULL),(32,7,64,2,'2023-10-10 20:17:10','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','',1,NULL),(35,4,55,3,'2023-10-11 02:48:33','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696992602609-IMG-20231010-WA0085.jpg',2,'2023-10-17 02:44:16'),(36,2,64,2,'2023-10-11 03:34:07','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1696995274721-IMG_1102.png',1,NULL),(56,1,30,2,'2023-10-12 18:31:52','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','',1,NULL),(59,1,85,3,'2023-10-13 05:16:48','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','',1,'2023-10-14 07:04:48'),(60,2,30,1,'2023-10-14 15:17:01','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697296645196-FROY 2 PRINCIPAL 3.png',1,NULL),(61,2,30,1,'2023-10-14 15:17:03','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,2,NULL),(62,4,87,3,'2023-10-14 15:30:39','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697297455040-imagen (30).png',1,'2023-10-14 15:32:02'),(63,1,87,3,'2023-10-14 15:37:48','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697297878499-imagen (30).png',2,'2023-10-14 15:39:14'),(68,1,64,2,'2023-10-15 21:53:36','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(69,2,38,3,'2023-10-15 23:40:55','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697413341069-WhatsApp Image 2023-09-30 at 2.08.11 PM.jpeg',1,'2023-10-15 23:43:04'),(70,2,64,3,'2023-10-16 01:42:29','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,'2023-10-16 01:56:30'),(71,1,59,3,'2023-10-16 02:21:16','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697422892818-image_WEpToaHx_1696897298074_raw.jpg',2,'2023-10-17 21:05:58'),(72,1,78,3,'2023-10-16 03:37:40','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697427466324-architecture-1909673_1280.jpg',1,'2023-10-16 03:37:58'),(73,2,78,1,'2023-10-16 03:53:27','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697428418821-EVIN3835.JPG',1,NULL),(74,2,78,3,'2023-10-16 03:53:29','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,'2023-10-16 03:54:07'),(75,5,88,3,'2023-10-16 04:01:33','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697428902203-Screenshot_1696007701.png',2,'2023-10-16 04:07:55'),(76,5,88,3,'2023-10-16 04:01:37','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,2,'2023-10-16 04:02:03'),(77,4,36,3,'2023-10-16 04:51:50','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697431926171-WhatsApp Image 2023-09-30 at 2.08.11 PM.jpeg',2,'2023-10-16 04:52:46'),(78,3,94,3,'2023-10-17 18:49:59','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697568636804-IMG_7346.png',1,'2023-10-17 22:41:59'),(79,3,84,3,'2023-10-17 22:49:25','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697582979987-WhatsApp Image 2023-09-30 at 2.08.11 PM.jpeg',2,'2023-10-17 22:50:06'),(80,2,60,3,'2023-10-18 16:03:29','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697645045750-IMG-20231017-WA0227.jpg',2,'2023-10-18 20:24:46'),(81,2,83,3,'2023-10-18 20:35:31','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1697662467847-Screenshot_20231018-154737.png',1,'2023-10-18 20:57:44'),(82,2,83,2,'2023-10-18 20:35:37','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(83,1,87,2,'2023-10-18 23:14:39','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(84,1,87,2,'2023-10-24 01:07:16','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(85,2,48,2,'2023-10-24 04:13:28','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(86,3,48,1,'2023-10-24 04:15:01','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1698120950302-imagen-4.png',1,NULL),(87,1,87,2,'2023-10-25 01:45:38','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(88,5,97,3,'2023-10-25 06:08:44','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1698214153889-willian-justen-de-vasconcellos-mZKEIRBStv4-unsplash.jpg',1,'2023-10-25 06:09:57'),(89,6,98,3,'2023-10-25 06:13:57','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1698214452427-FROY 2 PRINCIPAL 3.png',1,'2023-10-25 06:14:44'),(90,1,87,2,'2023-10-26 02:52:40','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(91,1,87,2,'2023-10-27 03:50:01','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(92,3,68,3,'2023-10-27 15:56:24','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1698422202197-IMG-20231027-WA0007.jpeg',2,'2023-10-27 16:02:20'),(93,1,40,1,'2023-10-27 16:37:00','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(94,1,49,2,'2023-10-28 03:40:40','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(95,2,49,3,'2023-10-28 03:41:09','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1698465516624-WhatsApp Image 2023-10-27 at 10.07.17 PM.jpeg',2,'2023-10-28 03:59:32'),(96,2,101,3,'2023-10-28 03:47:18','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,2,'2023-10-28 03:59:59'),(97,1,36,2,'2023-10-28 14:01:08','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3',NULL,1,NULL),(98,3,44,3,'2023-10-28 14:49:59','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1698504656460-Screenshot_2023-10-28-09-40-52-874_com.google.android.gm.jpg',2,'2023-10-29 04:34:04'),(99,3,41,3,'2023-10-29 12:57:35','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1698584333677-IMG-20231028-WA0024.jpg',2,'2023-10-29 15:56:26'),(100,3,42,3,'2023-10-29 19:59:34','TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3','/uploads/1698609604788-IMG-20231029-WA0023.jpg',2,'2023-10-29 23:53:17');
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonus`
--

DROP TABLE IF EXISTS `bonus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonus` (
  `bonus_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `comission` decimal(10,2) NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`bonus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonus`
--

LOCK TABLES `bonus` WRITE;
/*!40000 ALTER TABLE `bonus` DISABLE KEYS */;
/*!40000 ALTER TABLE `bonus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_app`
--

DROP TABLE IF EXISTS `config_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_app` (
  `id_config` int NOT NULL AUTO_INCREMENT,
  `binario` int NOT NULL,
  `directo` int NOT NULL,
  `roi` int NOT NULL,
  PRIMARY KEY (`id_config`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_app`
--

LOCK TABLES `config_app` WRITE;
/*!40000 ALTER TABLE `config_app` DISABLE KEYS */;
INSERT INTO `config_app` VALUES (1,10,10,2);
/*!40000 ALTER TABLE `config_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposits`
--

DROP TABLE IF EXISTS `deposits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposits` (
  `id_deposit` int NOT NULL AUTO_INCREMENT,
  `mount` decimal(10,2) NOT NULL,
  `date_deposit` datetime DEFAULT CURRENT_TIMESTAMP,
  `bonus_id` int NOT NULL,
  `user_id` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_deposit`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposits`
--

LOCK TABLES `deposits` WRITE;
/*!40000 ALTER TABLE `deposits` DISABLE KEYS */;
INSERT INTO `deposits` VALUES (65,10.00,NULL,2,59,1),(66,5.00,NULL,2,74,1),(67,5.00,NULL,2,74,1),(68,10.00,NULL,2,74,1),(71,50.00,'2023-10-16 04:43:28',2,39,1),(72,50.00,'2023-10-16 04:52:46',2,35,1),(73,50.00,'2023-10-17 02:44:16',2,54,1),(74,30.00,'2023-10-17 22:41:59',2,93,1),(75,10.00,'2023-10-18 20:57:44',2,60,1),(76,100.00,'2023-10-25 06:09:57',2,87,1),(77,300.00,'2023-10-25 06:14:44',2,87,1);
/*!40000 ALTER TABLE `deposits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packs`
--

DROP TABLE IF EXISTS `packs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packs` (
  `pack_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `roi` int NOT NULL,
  `months` int NOT NULL,
  `pack_imagen` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `comision` decimal(7,2) NOT NULL DEFAULT '10.00',
  PRIMARY KEY (`pack_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packs`
--

LOCK TABLES `packs` WRITE;
/*!40000 ALTER TABLE `packs` DISABLE KEYS */;
INSERT INTO `packs` VALUES (1,'Billions50',50.00,10,15,'/uploads/1697406117205-1.svg',10.00),(2,'Billions100',100.00,10,15,'/uploads/1697406123295-2.svg',10.00),(3,'Billions300',300.00,10,15,'/uploads/1697406129988-3.svg',10.00),(4,'Billions500',500.00,10,15,'/uploads/1697406134940-4.svg',10.00),(5,'Billions1000',1000.00,10,15,'/uploads/1697406139787-5.svg',10.00),(6,'Billions3000',3000.00,10,15,'/uploads/1697406146474-6.svg',10.00),(7,'Billions5000',5000.00,10,15,'/uploads/1697406151632-7.svg',10.00);
/*!40000 ALTER TABLE `packs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rangos`
--

DROP TABLE IF EXISTS `rangos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rangos` (
  `rango_id` int NOT NULL AUTO_INCREMENT,
  `puntos` int NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `imagen` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `puntos_inicio` int NOT NULL,
  `puntos_final` int NOT NULL,
  `rango_nombre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `posicion` int NOT NULL,
  PRIMARY KEY (`rango_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rangos`
--

LOCK TABLES `rangos` WRITE;
/*!40000 ALTER TABLE `rangos` DISABLE KEYS */;
INSERT INTO `rangos` VALUES (1,2000,1,'',2000,4000,'B2000',1),(2,5000,1,'',5000,10000,'B5000',2),(3,15000,1,'',15000,30000,'ZAFIRO',4),(4,50000,1,'',50000,100000,'RUBI',3),(5,150000,1,'',150000,300000,'ESMERALDA',5),(6,300000,1,'',300000,600000,'DIAMANTE',6),(7,600000,1,'',600000,1200000,'DOBLE DIAMANTE',7),(8,1000000,1,'',1000000,2000000,'TRIPLE DIAMANTE',8),(9,2000000,1,'',2000000,4000000,'DIAMANTE CORONA',9);
/*!40000 ALTER TABLE `rangos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `firstName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `lastName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `referrer` int NOT NULL DEFAULT '0',
  `position` int NOT NULL,
  `role` int NOT NULL DEFAULT '0',
  `lado` int DEFAULT '1',
  `directo` int NOT NULL,
  `status_user` int NOT NULL DEFAULT '1',
  `avatar` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ADMINISTRADOR','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','admin@gmail.com','Froy','Puri',0,0,1,1,0,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(30,'FROY2','b844b2bddcba3d907439a22f68c6502cd51438af3699d4d011e8fa9e83ad1de3','billions.teamfpv@gmail.com','Froy','Puri',1,2,0,1,1,1,'https://billionsoffice.com:3002/uploads/1696989788199-imagen (27).png'),(35,'BILLIONSGLOBAL','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negociosdigitalesfpv10@gmail.com','BILION','PURI VILLAR',30,2,0,2,30,1,'https://billionsoffice.com:3002/uploads/1697432474257-WhatsApp Image 2023-09-30 at 2.08.11 PM.jpeg'),(36,'LATAMBILLIONS','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negociosantony@gmail.com','Anthony','puri villar',35,2,0,1,35,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(37,'BILLIONSTEAM','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negociosdigitalesfpv10+1@gmail.com','BILLION','COMPANY',36,2,0,2,36,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(38,'BILLIONSLATAM','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','purivillardiego5@gmail.com','DIEGO','PURI VILLAR',37,2,0,1,37,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(39,'MILLONAIREYANINA29','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','yaninagaray818@gmail.com','YANINA','GARAY MERINO',38,2,0,2,37,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(40,'BLUEDIAMONDYOSEP','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negocioshidalgo21@gmail.com','Yosep ','hidalgo ferrer',39,2,0,2,39,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(41,'ANGELOBILLIONS','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Angeloramoslizana60@gmail.com','angelo','Ramos Lizana',40,2,0,1,40,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(42,'BILLIONSLR','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','akenjilizet@gmail.com','Kenji Lizet','Antonio Rojas',41,2,0,1,41,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(43,'BILLIONSFLOR','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negociosjob28@gmail.com','FLOR','YAPU',42,2,0,2,42,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(44,'NEWIMPACT2023','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','roberguillermo29@gmail.com','ROBER','CERCADO YVERICO',43,2,0,1,43,1,'https://billionsoffice.com:3002/uploads/1697076151385-IMG_20230708_131424.jpg'),(45,'SALINASDIAMOND','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','billions.teamfpv+1@gmail.com','huaranga','obregon',44,2,0,1,44,1,'https://billionsoffice.com:3002/uploads/1696990875919-IMG-20231005-WA0031.jpg'),(46,'SANDRA2003','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','castilloruiz1820@gamil.com','Sandra Milda','Castillo Ruiz',45,2,0,2,45,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(47,'RENEDIAMOND','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','renihidalgo123@gmail.com','RENE','HIDALGO ZAPANA',46,2,0,2,46,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(48,'CROWDIAMONDJ','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','josephcondorchuna10@gmail.com','José','Condorcahuana Calachua',47,2,0,1,47,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(49,'NIKBILLION','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','intelartif0001@gmail.com','NICO','MAMANI',48,2,0,1,48,1,'https://billionsoffice.com:3002/uploads/1698462462219-WhatsApp Image 2023-10-27 at 10.07.17 PM.jpeg'),(50,'DESPERTADOR','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','lucio.crispin28@gmail.com','LUCIO ORLANDO','Crispin Quinto',49,2,0,2,49,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(51,'BILLONAIREN','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','a71604318@gmail.com','NELYDA',' Astupiñan Ortega',50,2,0,2,50,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(52,'DIAMANTECORONAM','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','marisolmarquina28@gmail.com','Marisol','Marquina Briceño',51,2,0,2,51,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(53,'DANIELO','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','danielo@gmail.com','Danielo','Gomez',52,2,0,1,1,2,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(54,'DIAMONDAR','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','armandorc_022883@hotmail.com','ARMANDO','Rojas Carlos',53,2,0,2,52,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(55,'BILLIONSCLUB','00b92f3b841fab7b0ebb3617f02a9914320ebc94fc3232aed563aaa9fa77f534','fresiahuamani51@gmail.com','Fressy Huamani Apumayta','adrian puri',54,2,0,1,54,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(56,'DIAMANTE01LILI','ff90c8bdba28e8d97fb9e87c878fbbe78c4c0497ab12df47553058b32c26dbf9','Lilianamachacacconislla@gmail.com','LILIANA','MACHACA CCONISLLA',40,1,0,1,40,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(57,'DIAMANTE02ROUS','ff90c8bdba28e8d97fb9e87c878fbbe78c4c0497ab12df47553058b32c26dbf9','rousaronicjuro@gmail.com','ROSMERY ','ARONI CJURO',56,1,0,1,56,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(58,'TITAN100K','93d0bfee8dca59788e36396e6ffad98c4ef943fc039b24f2b208cf905f859787','julyaroni38@gmail.com','Julio ','Aroni',55,2,0,2,55,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(59,'BILLIONS10K','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','billions10k@gmail.com','Billions10k','10k10k',1,1,0,1,1,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(60,'DIAMANTE03FLOR','ff90c8bdba28e8d97fb9e87c878fbbe78c4c0497ab12df47553058b32c26dbf9','florminaflaviahidalgoferrer@gmail.com','FLORMINA ','HIDALGO FERRER ',57,1,0,2,57,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(61,'DIAMANTE04','ff90c8bdba28e8d97fb9e87c878fbbe78c4c0497ab12df47553058b32c26dbf9','ayalabartolome48@gmail.com','BARTOLOME','AYALA MANAYAY',60,1,0,2,60,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(62,'DIAMANTE05','ff90c8bdba28e8d97fb9e87c878fbbe78c4c0497ab12df47553058b32c26dbf9','vivianapimentelaguirre@gmail.com','VIVIANA NOEMÍ ','PIMENTEL AGUIRRE ',61,1,0,1,61,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(63,'DIAMONDBA','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negociosjob28+1@gmail.com','BONI','ARONI',58,2,0,2,58,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(64,'ESMERALDVE','932f3c1b56257ce8539ac269d7aab42550dacf8818d075f0bdf1990562aae3ef','dgonnou@gmail.com','Darren','Chiquito',59,1,0,1,59,1,'https://billionsoffice.com:3002/uploads/1697406196411-Imagen de WhatsApp 2023-10-08 a las 16.35.45_91b27902.jpg'),(65,'DIAMANTE06HUGO','ff90c8bdba28e8d97fb9e87c878fbbe78c4c0497ab12df47553058b32c26dbf9','huamanttitohugo96@gmail.com','HUGO','HUAMAN TTITO ',62,1,0,1,62,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(66,' BILLIONSRM','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','zevallosrolan02@gmail.com','ROLANDO','MANCILLA',63,2,0,2,63,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(67,'VISIONGLOBALJH','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','jhonatanhuillcasarmiento9@gmail.com','JONATAN','HUILCA',66,2,0,2,66,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(68,'IMPARABLESA','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negociosjob28+2@gmail.com','Sonia','ALLHUAY',67,2,0,1,67,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(69,'DIAMONDDS','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','deysysuxso74@gmail.com','Deysy Suxso','hancco',68,2,0,2,68,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(71,'JULIOELCAZADOR','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','julio1elcazador@gmail.com','JULIO','BORDA',69,2,0,2,69,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(72,'DIAMONDCL','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Claudioluk2021@gmail.com','CLAUDIO','LUQUE APAZA',71,2,0,2,71,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(73,'DIAMANTE','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','billions.teamfpv+4@gmail.com','froy','puri villar',55,1,0,1,55,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(74,'DIAMANTE07','ff90c8bdba28e8d97fb9e87c878fbbe78c4c0497ab12df47553058b32c26dbf9','negocioshidalgo21+1@gmail.com','Pedro ','Polinar ',65,1,0,1,65,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(75,'ANTONIOPEREZ','8cafdbbb17720250f87ce95f17abbbd6fa156c5e97209529b3f267012c45e02e','Felicidadalmundo360@gmail.com','Pedro Antonio','Pérez Cerroy',72,2,0,1,72,1,'https://billionsoffice.com:3002/uploads/1697951583392-IMG_20230910_083804.jpg'),(76,'OLIVERN','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negociosdigitalesfpv10+5@gmail.com','OLIVER','NOREÑA',75,2,0,2,75,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(77,'JAVICUEVA','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','cueva123garcia@gmail.com','Javier Cueva','Garcia',76,2,0,2,76,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(78,'DAN123','7e25139aa8c5e08de4820f1e416daff3444e44bfe180dd97ba3df8144db99f7e','2002teclado@gmail.com','RENZO','TELLO',74,1,0,1,74,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(79,'JUAN4466','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','villonaguilarjuanmarcial@gmail.com','juan','villon aguilar',77,2,0,2,77,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(80,'JESLIN100','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','globalultra03@gmail.com','DARREN','WEEKEND',64,1,0,1,64,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(81,'AYALABILLIONS','ca20cffd89c01dd095d145f54aa6a2bdb4aead6eaefc1f32d573568659ae8278','ayalabartolome48+1@gmail.com','Bartolomé ','Ayala Manayay ',61,2,0,2,61,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(83,'FLAVIA22','ca20cffd89c01dd095d145f54aa6a2bdb4aead6eaefc1f32d573568659ae8278','florminaflaviahidalgoferrer+1@gmail.com','Flormina','Hidalgo Ferrer',60,2,0,1,60,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(84,'BILLIONSCORP','fd1b29e5cbe52f05084fb0c852e575837ca0d5bf9af45233e883c757c9d4ef9e','negociosmarlit28@gmail.com','Anthony ','Puri',36,1,0,1,36,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(85,'ADELYDIAMANTE','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Adelivargasfernandez714@gmail.com','Adeli ','Vargas Fernández',79,2,0,2,79,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(86,'MILLONAIREYVETE','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Marimoretomoreto@gmail.com','MARY','MORETO MORETO',85,2,0,2,85,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(87,'FROY1','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','negociosdigitalesfpv10+8@gmail.com','froy ','puri villar',30,1,0,1,30,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(88,'NUTELLA23030','15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225','prueba123@gmail.com','NUTELLA','TELLO',87,2,0,1,87,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(89,'NATALY19','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Cotrinotorresnataly@gmail.com','nataly','cotrino',86,2,0,2,86,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(90,'TORRES25','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','torresmaritza543@gmail.com','Sonia Maritza','torres santos',89,2,0,2,89,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(91,'JHULYBETHDIAMOND','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','74251275.robles@gmail.com','Jhulybeth','Robles Gomez',90,2,0,2,90,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(92,'CHABELIDIAMOND','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','chabelitrujillo@gmail.com','Trujillo Ambrosio','Chabeli',91,1,0,1,91,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(93,'VIPBILLIONS','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','NEGOCIOSDIGITALESFPV10+9@GMAIL.COM','Puri ','Villar ',91,2,0,2,91,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(94,'JUDITH','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','asenjoislajudith@gmail.com','Tania Judith','Asenjo Isla',93,2,0,2,93,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(95,'INVICTOS','15a3a2d329d494ab7e6363af38c85dd500953b13a5a137df0fdc44a5712b1250','fresiahuamani51@gmial.com','Fresia ','Huamani Apumayta ',73,1,0,1,73,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(96,'TRUJILLO ','f10dcb0a5890fef0a104c211c4d2a4c7897eb92c08e707038dc5fe1bdc7c3415','crispintrujillofresnil@gmail.com','Fresnil','Crispin Trujillo ',94,2,0,1,94,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(97,'LEONEL10','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','billions.teamfpv+11@gmail.com','Leonel','puri',88,2,0,1,87,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(98,'LEONEL20','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','billions.teamfpv+12@gmail.com','leonel2','puri 2',87,1,0,1,87,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(99,'JHOJAN09','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','soniaaq31@gmail.com','Jhojan','Chirapa',68,1,0,1,68,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(100,'KELLY20 ','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Soniaaq31+2@gimail.com','Kelly','Chirapa ',99,1,0,1,99,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(101,'LUIS DIAMANTE CORONA','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','intelartifvip1@gmail.com','Luis David','Perca Chutas',49,1,0,1,49,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(102,'NEWIMPACT2024','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','roberguillermo29+1@gmail.com','Rober ','Cercado Yverico',44,1,0,1,44,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(103,'NEWIMPACT2025','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','roberguillermo29+2@gmail.com','Rober','Cercado Yverico',102,1,0,1,102,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(104,'DAYMONDPRO07','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Angeloramoslizana60+3@gmail.com','Angelo','Ramos',41,1,0,1,41,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(105,'ÉXITOPRO07','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Angeloramoslizana60+4@gmail.com','Angelo','Ramos',104,1,0,1,104,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png'),(106,'ANGELO','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Angeloramoslizana60+5@gmail.com','Billionspro07','Billionspro07',105,1,0,1,105,1,'https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_001_profile_avatar_round_user-512.png');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_codes`
--

DROP TABLE IF EXISTS `verification_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_codes` (
  `id_codigo` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  PRIMARY KEY (`id_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_codes`
--

LOCK TABLES `verification_codes` WRITE;
/*!40000 ALTER TABLE `verification_codes` DISABLE KEYS */;
INSERT INTO `verification_codes` VALUES (6,'ESMERALDVE','ZQck2bkn'),(9,'BILLIONSCORP','2y04oe1d');
/*!40000 ALTER TABLE `verification_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `wallet_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `wallet_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `label` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`wallet_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallets`
--

LOCK TABLES `wallets` WRITE;
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
INSERT INTO `wallets` VALUES (15,30,'1A1YfoWtaoS4qG16bUyFx2aBoeXScHgFQz',0,'2023-10-02 02:42:30','froy pago'),(16,73,'1A1YfoWtaoS4qG16bUyFx2aBoeXScHgFQz',0,'2023-10-05 02:44:34','froy pago'),(17,85,'',0,'2023-10-13 05:18:07',''),(18,87,'',0,'2023-10-27 03:51:26','');
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdrawals`
--

DROP TABLE IF EXISTS `withdrawals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdrawals` (
  `withdrawal_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `date` datetime NOT NULL,
  `wallet` int NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`withdrawal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdrawals`
--

LOCK TABLES `withdrawals` WRITE;
/*!40000 ALTER TABLE `withdrawals` DISABLE KEYS */;
INSERT INTO `withdrawals` VALUES (1,1,2000.00,'2023-09-16 04:11:40',1,1);
/*!40000 ALTER TABLE `withdrawals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-09 22:45:55
