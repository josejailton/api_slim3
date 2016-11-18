CREATE DATABASE  IF NOT EXISTS `madenor_1` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `madenor_1`;
-- MySQL dump 10.13  Distrib 5.5.53, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: madenor_1
-- ------------------------------------------------------
-- Server version	5.5.53-0ubuntu0.14.04.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Hardt');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_categories_1_idx` (`category_id`),
  CONSTRAINT `fk_categories_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (2,NULL,'Ferragens'),(3,2,'Corrediças');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `details`
--

DROP TABLE IF EXISTS `details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_details_variations1_idx` (`variation_id`),
  CONSTRAINT `fk_details_1` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `details`
--

LOCK TABLES `details` WRITE;
/*!40000 ALTER TABLE `details` DISABLE KEYS */;
INSERT INTO `details` VALUES (1,1,'30CM'),(2,1,'35CM'),(3,1,'40CM'),(4,1,'45CM'),(5,1,'50CM'),(6,2,'Zincada'),(7,2,'Comum'),(8,3,'45KG'),(9,3,'60KG');
/*!40000 ALTER TABLE `details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grids`
--

DROP TABLE IF EXISTS `grids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grids` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grids`
--

LOCK TABLES `grids` WRITE;
/*!40000 ALTER TABLE `grids` DISABLE KEYS */;
INSERT INTO `grids` VALUES (1,'Corrediças Telescópicas');
/*!40000 ALTER TABLE `grids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grids_variations`
--

DROP TABLE IF EXISTS `grids_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grids_variations` (
  `grid_id` int(10) unsigned NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`grid_id`,`variation_id`),
  KEY `fk_grids_has_variations_variations1_idx` (`variation_id`),
  KEY `fk_grids_has_variations_grids1_idx` (`grid_id`),
  CONSTRAINT `fk_grids_has_variations_grids1` FOREIGN KEY (`grid_id`) REFERENCES `grids` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grids_has_variations_variations1` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grids_variations`
--

LOCK TABLES `grids_variations` WRITE;
/*!40000 ALTER TABLE `grids_variations` DISABLE KEYS */;
INSERT INTO `grids_variations` VALUES (1,1);
/*!40000 ALTER TABLE `grids_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peaces`
--

DROP TABLE IF EXISTS `peaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peaces` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `grid_id` int(10) unsigned NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_variations_grids1_idx` (`grid_id`),
  CONSTRAINT `fk_variations_grids1` FOREIGN KEY (`grid_id`) REFERENCES `grids` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peaces`
--

LOCK TABLES `peaces` WRITE;
/*!40000 ALTER TABLE `peaces` DISABLE KEYS */;
INSERT INTO `peaces` VALUES (1,1,'30CM Zincada 45KG'),(2,1,'30CM Zincada 60KG'),(3,1,'30CM Comum 45KG'),(4,1,'30CM Comum 60KG'),(5,1,'35CM Zincada 45KG'),(6,1,'35CM Zincada 60KG'),(7,1,'35CM Comum 45KG'),(8,1,'35CM Comum 60KG'),(9,1,'40CM Zincada 45KG'),(10,1,'40CM Zincada 60KG'),(11,1,'40CM Comum 45KG'),(12,1,'40CM Comum 60KG'),(13,1,'45CM Zincada 45KG'),(14,1,'45CM Zincada 60KG'),(15,1,'45CM Comum 45KG'),(16,1,'45CM Comum 60KG'),(17,1,'50CM Zincada 45KG'),(18,1,'50CM Zincada 60KG'),(19,1,'50CM Comum 45KG'),(20,1,'50CM Comum 60KG');
/*!40000 ALTER TABLE `peaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peaces_details`
--

DROP TABLE IF EXISTS `peaces_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peaces_details` (
  `peace_id` int(10) unsigned NOT NULL,
  `detail_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`peace_id`,`detail_id`),
  KEY `fk_peaces_has_details_details1_idx` (`detail_id`),
  KEY `fk_peaces_has_details_peaces1_idx` (`peace_id`),
  CONSTRAINT `fk_peaces_details_1` FOREIGN KEY (`peace_id`) REFERENCES `peaces` (`id`),
  CONSTRAINT `fk_peaces_details_2` FOREIGN KEY (`detail_id`) REFERENCES `details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peaces_details`
--

LOCK TABLES `peaces_details` WRITE;
/*!40000 ALTER TABLE `peaces_details` DISABLE KEYS */;
INSERT INTO `peaces_details` VALUES (1,1),(2,1),(3,1),(4,1),(5,2),(6,2),(7,2),(8,2),(9,3),(10,3),(11,3),(12,3),(13,4),(14,4),(15,4),(16,4),(17,5),(18,5),(19,5),(20,5),(1,6),(2,6),(5,6),(6,6),(9,6),(10,6),(13,6),(14,6),(17,6),(18,6),(3,7),(4,7),(7,7),(8,7),(11,7),(12,7),(15,7),(16,7),(19,7),(20,7),(1,8),(3,8),(5,8),(7,8),(9,8),(11,8),(13,8),(15,8),(17,8),(19,8),(2,9),(4,9),(6,9),(8,9),(10,9),(12,9),(14,9),(16,9),(18,9),(20,9);
/*!40000 ALTER TABLE `peaces_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `peace_id` int(10) unsigned NOT NULL,
  `amount` int(20) NOT NULL,
  `price` float unsigned NOT NULL,
  `price_limit` float unsigned NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stocks_products1_idx` (`product_id`),
  KEY `fk_stocks_variations1_idx` (`peace_id`),
  CONSTRAINT `fk_stocks_products1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `fk_stocks_variations1` FOREIGN KEY (`peace_id`) REFERENCES `peaces` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,1,1,10,50.3049,23.059,1),(2,1,2,4,51.3049,24.059,1),(3,1,3,50,52.3049,25.059,1),(4,1,4,30,53.3049,26.059,1),(5,1,5,11,54.3049,27.059,1),(7,1,6,11,11,11,1),(8,1,7,11,11,11,1),(9,1,8,11,11,11,1),(10,1,9,11,11,11,1),(11,1,10,11,11,11,1),(12,1,11,11,11,11,1),(13,1,12,11,11,11,1),(14,1,13,11,11,11,1),(15,1,14,11,11,11,1),(16,1,15,11,11,11,1),(17,1,16,11,11,11,1),(18,1,17,11,11,11,1),(19,1,18,11,11,11,1),(20,1,19,11,11,11,1),(21,1,20,11,11,11,1);
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `brand_id` int(10) unsigned NOT NULL,
  `supplier_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_products_1_idx` (`brand_id`),
  KEY `fk_products_2_idx` (`supplier_id`),
  KEY `fk_products_3_idx` (`category_id`),
  CONSTRAINT `fk_products_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  CONSTRAINT `fk_products_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`),
  CONSTRAINT `fk_products_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Corrediça Telescópica Push Open',1,1,3);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Hardt Importadora e Distribuidora Ltda');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variations`
--

DROP TABLE IF EXISTS `variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `order` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variations`
--

LOCK TABLES `variations` WRITE;
/*!40000 ALTER TABLE `variations` DISABLE KEYS */;
INSERT INTO `variations` VALUES (1,'Comprimento de Corrediça',1),(2,'Acabamento de Corrediça',3),(3,'Capacidade de Peso de Corrediça',2);
/*!40000 ALTER TABLE `variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'madenor_1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-18  3:05:09
