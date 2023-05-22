CREATE DATABASE  IF NOT EXISTS `gerenciador_de_contas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gerenciador_de_contas`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: gerenciador_de_contas
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `senha` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'jeanever39@gmail.com','$2y$10$J7DHpsqVxK.kWU/xAHBUZ.weRmyel/kTTTYbHLfSl19vpyxsbYzPS','2023-05-16 20:04:01','2023-05-16 20:04:01'),(2,'jeanever39@gmail.com','$2y$10$jt.VgO3HvpSO4Pjfee0O9Orsrq81PEIvH8uM1NJayMYRf7gbgypu.','2023-05-16 20:04:29','2023-05-16 20:04:29'),(3,'jeanever39@gmail.com','$2y$10$wYnaMwYJtBGJ6XFE1MSv4.JAEVnGn75W9Y0LF5.h6tN2JN7pF45qm','2023-05-16 20:04:44','2023-05-16 20:04:44'),(4,'jeanever39@gmail.com','$2y$10$bDU5c8gEoIwqpeammEwLseaT1plDOGAAl2ZJ9WMsfgZs1p8Yz0/vm','2023-05-16 20:04:54','2023-05-16 20:04:54'),(5,'jeanever39@gmail.com','$2y$10$Bv95FAP84nGp4TNz67gfg.5tgHxy1vqKvaz2XWpFwaVosXRxU/blS','2023-05-16 20:05:09','2023-05-16 20:05:09'),(6,'jeanever39@gmail.com','$2y$10$HBa5Ln46fhcMOLYazkFSwu6fEk2F5q8RzYYdYpRAW7w6QWFqgTgQC','2023-05-17 16:40:37','2023-05-17 16:40:37'),(7,'jeanever39@gmail.com','$2y$10$kOeD2.YT9YFQbkV4BhMXl.xY2Xl/WBRF6HiPUTp7EclIuz4JK7vga','2023-05-17 16:44:00','2023-05-17 16:44:00'),(8,'jeanever39@gmail.com','$2y$10$G03oIg3aQbJ2sWfreGJIguU.uFM6zHkeSW5tDGfLVGwSR1ngaHH7a','2023-05-17 16:45:08','2023-05-17 16:45:08'),(9,'jeanever39@gmail.com','$2y$10$JhfNBF8bsfOQTxqk5Kq.bOOcUZY9NPrcZXwAIbBMMWwbTi97OrY3K','2023-05-17 16:46:32','2023-05-17 16:46:32'),(10,'jeanever39@gmail.com','$2y$10$UueySDW2Lpqdvv8yza4HPOpbqdqdnUdwWydizij84u9AHIVJu0gxS','2023-05-17 16:55:00','2023-05-17 16:55:00'),(11,'jeanever39@gmail.com','$2y$10$d9onqbJHnBMRHIx2B3d8KOS36QiWpDpMfQkAZLqwu.sBFC3oXXHe6','2023-05-17 16:55:54','2023-05-17 16:55:54'),(12,'jeanever39@gmail.com','$2y$10$bensxCzlvvOzcwamXbDvwOT7QxPhCaYkogrRsVctNu6660xKKhjIm','2023-05-17 17:34:38','2023-05-17 17:34:38'),(13,'jeanever39@gmail.com','$2y$10$ZPWPVv1Fjd1r.2d8Exk5X.J2le8kwcUuTSUdAkK1z/QFlgkgctTiy','2023-05-17 17:37:16','2023-05-17 17:37:16'),(14,'jeanever39@gmail.com','$2y$10$42wNoqq0249E8rQxOLjnPuDv86PYGw1EXaTemNAP8/MtsQsxFroZ.','2023-05-17 18:02:58','2023-05-17 18:02:58'),(15,'jeanever39@gmail.com','$2y$10$JJO/LRNFb/GRt7GUmRb9D.EcnVyV620d.Sr4bgQYxroyhoMSQfYKW','2023-05-17 18:26:45','2023-05-17 18:26:45'),(16,'jeanever39@gmail.com','$2y$10$uPPbc3K3YqrXIghWhOZI2.cLNerByC9jSGRaeL.KyNe0kZ7Rpqtxi','2023-05-17 19:14:03','2023-05-17 19:14:03'),(17,'jeanever39@gmail.com','$2y$10$lQRwKyx/CGdYGnedC3EUze2vO/yqKau0gOFHurLnt9LMzaks3aZOK','2023-05-17 20:35:17','2023-05-17 20:35:17'),(18,'jeanever39@gmail.com','$2y$10$VykkI.U91ZoPv36kT0cxrOhs2yNYCS7OGPY71hgVna7be5fkZzRd6','2023-05-17 20:35:33','2023-05-17 20:35:33');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-18 13:35:51
