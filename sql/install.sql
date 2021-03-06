-- MySQL dump 10.13  Distrib 5.7.18-16, for osx10.12 (x86_64)
--
-- Host: localhost    Database: tekapocart
-- ------------------------------------------------------
-- Server version	5.7.18-16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!50717 SELECT COUNT(*) INTO @rocksdb_has_p_s_session_variables FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'session_variables' */;
/*!50717 SET @rocksdb_get_is_supported = IF (@rocksdb_has_p_s_session_variables, 'SELECT COUNT(*) INTO @rocksdb_is_supported FROM performance_schema.session_variables WHERE VARIABLE_NAME=\'rocksdb_bulk_load\'', 'SELECT 0') */;
/*!50717 PREPARE s FROM @rocksdb_get_is_supported */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
/*!50717 SET @rocksdb_enable_bulk_load = IF (@rocksdb_is_supported, 'SET SESSION rocksdb_bulk_load = 1', 'SET @rocksdb_dummy_bulk_load = 0') */;
/*!50717 PREPARE s FROM @rocksdb_enable_bulk_load */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;

--
-- Current Database: `tekapocart`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tekapocart` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `tekapocart`;

--
-- Table structure for table `ps_access`
--

DROP TABLE IF EXISTS `ps_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_access` (
  `id_profile` int(10) unsigned NOT NULL,
  `id_authorization_role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_profile`,`id_authorization_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_access`
--

LOCK TABLES `ps_access` WRITE;
/*!40000 ALTER TABLE `ps_access` DISABLE KEYS */;
INSERT INTO `ps_access` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,29),(1,30),(1,31),(1,32),(1,33),(1,34),(1,35),(1,36),(1,37),(1,38),(1,39),(1,40),(1,41),(1,42),(1,43),(1,44),(1,45),(1,46),(1,47),(1,48),(1,49),(1,50),(1,51),(1,52),(1,53),(1,54),(1,55),(1,56),(1,57),(1,58),(1,59),(1,60),(1,61),(1,62),(1,63),(1,64),(1,65),(1,66),(1,67),(1,68),(1,69),(1,70),(1,71),(1,72),(1,73),(1,74),(1,75),(1,76),(1,77),(1,78),(1,79),(1,80),(1,81),(1,82),(1,83),(1,84),(1,85),(1,86),(1,87),(1,88),(1,89),(1,90),(1,91),(1,92),(1,93),(1,94),(1,95),(1,96),(1,97),(1,98),(1,99),(1,100),(1,101),(1,102),(1,103),(1,104),(1,105),(1,106),(1,107),(1,108),(1,109),(1,110),(1,111),(1,112),(1,113),(1,114),(1,115),(1,116),(1,117),(1,118),(1,119),(1,120),(1,121),(1,122),(1,123),(1,124),(1,125),(1,126),(1,127),(1,128),(1,129),(1,130),(1,131),(1,132),(1,133),(1,134),(1,135),(1,136),(1,137),(1,138),(1,139),(1,140),(1,141),(1,142),(1,143),(1,144),(1,145),(1,146),(1,147),(1,148),(1,149),(1,150),(1,151),(1,152),(1,153),(1,154),(1,155),(1,156),(1,157),(1,158),(1,159),(1,160),(1,161),(1,162),(1,163),(1,164),(1,165),(1,166),(1,167),(1,168),(1,169),(1,170),(1,171),(1,172),(1,173),(1,174),(1,175),(1,176),(1,177),(1,178),(1,179),(1,180),(1,181),(1,182),(1,183),(1,184),(1,185),(1,186),(1,187),(1,188),(1,189),(1,190),(1,191),(1,192),(1,193),(1,194),(1,195),(1,196),(1,197),(1,198),(1,199),(1,200),(1,201),(1,202),(1,203),(1,204),(1,205),(1,206),(1,207),(1,208),(1,209),(1,210),(1,211),(1,212),(1,213),(1,214),(1,215),(1,216),(1,217),(1,218),(1,219),(1,220),(1,221),(1,222),(1,223),(1,224),(1,225),(1,226),(1,227),(1,228),(1,229),(1,230),(1,231),(1,232),(1,233),(1,234),(1,235),(1,236),(1,237),(1,238),(1,239),(1,240),(1,241),(1,242),(1,243),(1,244),(1,245),(1,246),(1,247),(1,248),(1,249),(1,250),(1,251),(1,252),(1,253),(1,254),(1,255),(1,256),(1,257),(1,258),(1,259),(1,260),(1,261),(1,262),(1,263),(1,264),(1,265),(1,266),(1,267),(1,268),(1,269),(1,270),(1,271),(1,272),(1,273),(1,274),(1,275),(1,276),(1,277),(1,278),(1,279),(1,280),(1,281),(1,282),(1,283),(1,284),(1,285),(1,286),(1,287),(1,288),(1,289),(1,290),(1,291),(1,292),(1,293),(1,294),(1,295),(1,296),(1,297),(1,298),(1,299),(1,300),(1,301),(1,302),(1,303),(1,304),(1,305),(1,306),(1,307),(1,308),(1,309),(1,310),(1,311),(1,312),(1,313),(1,314),(1,315),(1,316),(1,317),(1,318),(1,319),(1,320),(1,321),(1,322),(1,323),(1,324),(1,325),(1,326),(1,327),(1,328),(1,329),(1,330),(1,331),(1,332),(1,333),(1,334),(1,335),(1,336),(1,337),(1,338),(1,339),(1,340),(1,341),(1,342),(1,343),(1,344),(1,345),(1,346),(1,347),(1,348),(1,349),(1,350),(1,351),(1,352),(1,353),(1,354),(1,355),(1,356),(1,357),(1,358),(1,359),(1,360),(1,361),(1,362),(1,363),(1,364),(1,365),(1,366),(1,367),(1,368),(1,369),(1,370),(1,371),(1,372),(1,373),(1,374),(1,375),(1,376),(1,377),(1,378),(1,379),(1,380),(1,381),(1,382),(1,383),(1,384),(1,385),(1,386),(1,387),(1,388),(1,389),(1,390),(1,391),(1,392),(1,393),(1,394),(1,395),(1,396),(1,397),(1,398),(1,399),(1,400),(1,401),(1,402),(1,403),(1,404),(1,405),(1,406),(1,407),(1,408),(1,409),(1,410),(1,411),(1,412),(1,413),(1,414),(1,415),(1,416),(1,417),(1,418),(1,419),(1,420),(1,421),(1,422),(1,423),(1,424),(1,425),(1,426),(1,427),(1,428),(1,429),(1,430),(1,431),(1,432),(1,433),(1,434),(1,435),(1,436),(1,437),(1,438),(1,439),(1,440),(1,441),(1,442),(1,443),(1,444),(1,445),(1,446),(1,447),(1,448),(1,449),(1,450),(1,451),(1,452),(1,465),(1,466),(1,467),(1,468),(1,569),(1,570),(1,571),(1,572),(1,573),(1,574),(1,575),(1,576),(1,577),(1,578),(1,579),(1,580),(1,681),(1,682),(1,683),(1,684),(1,685),(1,686),(1,687),(1,688),(1,745),(1,746),(1,747),(1,748),(1,829),(1,830),(1,831),(1,832),(1,849),(1,850),(1,851),(1,852),(1,857),(1,858),(1,859),(1,860),(1,881),(1,882),(1,883),(1,884),(1,897),(1,925),(1,926),(1,927),(1,928),(1,929),(1,930),(1,931),(1,932),(1,933),(1,934),(1,935),(1,936),(1,937),(1,938),(1,939),(1,940),(1,941),(1,942),(1,943),(1,944),(1,945),(1,946),(1,947),(1,948),(1,949),(1,950),(1,951),(1,952),(1,953),(1,954),(1,955),(1,956),(1,957),(1,958),(1,959),(1,960),(1,961),(1,962),(1,963),(1,964),(1,965),(1,966),(1,967),(1,968),(1,969),(1,970),(1,971),(1,972),(2,25),(2,26),(2,27),(2,28),(2,37),(2,38),(2,39),(2,40),(2,45),(2,46),(2,47),(2,48),(2,49),(2,50),(2,51),(2,52),(2,97),(2,98),(2,99),(2,100),(2,189),(2,190),(2,191),(2,192),(2,234),(2,235),(2,265),(2,266),(2,267),(2,268),(2,301),(2,302),(2,303),(2,304),(2,361),(2,362),(2,363),(2,364),(2,365),(2,366),(2,367),(2,368),(2,377),(2,378),(2,379),(2,380),(2,381),(2,382),(2,383),(2,384),(2,393),(2,394),(2,395),(2,396),(2,425),(2,426),(2,427),(2,428),(2,445),(2,446),(2,447),(2,448),(3,9),(3,10),(3,11),(3,12),(3,41),(3,42),(3,43),(3,44),(3,73),(3,74),(3,75),(3,76),(3,77),(3,78),(3,79),(3,80),(3,173),(3,174),(3,175),(3,176),(3,181),(3,182),(3,183),(3,184),(3,201),(3,202),(3,203),(3,204),(3,209),(3,210),(3,211),(3,212),(3,241),(3,242),(3,243),(3,244),(3,361),(3,362),(3,363),(3,364),(3,445),(3,446),(3,447),(3,448),(4,0),(4,53),(4,54),(4,55),(4,56),(4,165),(4,166),(4,167),(4,168),(4,225),(4,226),(4,227),(4,228),(4,234),(4,235),(4,277),(4,278),(4,279),(4,280),(4,393),(4,394),(4,395),(4,396),(4,409),(4,410),(4,411),(4,412),(4,441),(4,442),(4,443),(4,444),(4,569),(4,570),(4,571),(4,572),(4,573),(4,574),(4,575),(4,576),(4,577),(4,578),(4,579),(4,580);
/*!40000 ALTER TABLE `ps_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_accessory`
--

DROP TABLE IF EXISTS `ps_accessory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_accessory` (
  `id_product_1` int(10) unsigned NOT NULL,
  `id_product_2` int(10) unsigned NOT NULL,
  KEY `accessory_product` (`id_product_1`,`id_product_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_accessory`
--

LOCK TABLES `ps_accessory` WRITE;
/*!40000 ALTER TABLE `ps_accessory` DISABLE KEYS */;
INSERT INTO `ps_accessory` VALUES (1,2),(1,3),(1,4),(1,11),(1,12);
/*!40000 ALTER TABLE `ps_accessory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_address`
--

DROP TABLE IF EXISTS `ps_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_address` (
  `id_address` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(10) unsigned NOT NULL,
  `id_state` int(10) unsigned DEFAULT NULL,
  `id_customer` int(10) unsigned NOT NULL DEFAULT '0',
  `id_manufacturer` int(10) unsigned NOT NULL DEFAULT '0',
  `id_supplier` int(10) unsigned NOT NULL DEFAULT '0',
  `id_warehouse` int(10) unsigned NOT NULL DEFAULT '0',
  `alias` varchar(32) NOT NULL,
  `company` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `address1` varchar(128) NOT NULL,
  `address2` varchar(128) DEFAULT NULL,
  `postcode` varchar(12) DEFAULT NULL,
  `city` varchar(64) NOT NULL,
  `other` text,
  `phone` varchar(32) DEFAULT NULL,
  `phone_mobile` varchar(32) DEFAULT NULL,
  `vat_number` varchar(32) DEFAULT NULL,
  `dni` varchar(16) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_address`),
  KEY `address_customer` (`id_customer`),
  KEY `id_country` (`id_country`),
  KEY `id_state` (`id_state`),
  KEY `id_manufacturer` (`id_manufacturer`),
  KEY `id_supplier` (`id_supplier`),
  KEY `id_warehouse` (`id_warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_address`
--

LOCK TABLES `ps_address` WRITE;
/*!40000 ALTER TABLE `ps_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_address_format`
--

DROP TABLE IF EXISTS `ps_address_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_address_format` (
  `id_country` int(10) unsigned NOT NULL,
  `format` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_address_format`
--

LOCK TABLES `ps_address_format` WRITE;
/*!40000 ALTER TABLE `ps_address_format` DISABLE KEYS */;
INSERT INTO `ps_address_format` VALUES (1,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(2,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(3,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(4,'firstname lastname\ncompany\naddress1\naddress2\ncity State:name postcode\nCountry:name\nphone'),(5,'lastname firstname\r\nphone_mobile\r\nCountry:name\r\ncity\r\npostcode\r\naddress1\r\ncompany \r\nvat_number'),(6,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(7,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(8,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(9,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(10,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nState:name\nCountry:name\nphone'),(11,'lastname firstname\r\nphone_mobile\r\nCountry:name\r\ncity\r\npostcode\r\naddress1\r\ncompany \r\nvat_number'),(12,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(13,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(14,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(15,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(16,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(17,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\ncity\npostcode\nCountry:name\nphone'),(18,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(19,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(20,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(21,'firstname lastname\r\nphone_mobile\r\nCountry:name\r\ncity\r\npostcode\r\naddress1\r\ncompany \r\nvat_number'),(22,'lastname firstname\r\nphone_mobile\r\nCountry:name\r\ncity\r\npostcode\r\naddress1\r\ncompany \r\nvat_number'),(23,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(24,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\ncity State:iso_code postcode\nCountry:name\nphone'),(25,'lastname firstname\r\nphone_mobile\r\nCountry:name\r\ncity\r\npostcode\r\naddress1\r\ncompany \r\nvat_number'),(26,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(27,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(28,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(29,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(30,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(31,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(32,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(33,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(34,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(35,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(36,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(37,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(38,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(39,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(40,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(41,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(42,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(43,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(44,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nState:name\nCountry:name\nphone'),(45,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(46,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(47,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(48,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(49,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(50,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(51,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(52,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(53,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(54,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(55,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(56,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(57,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(58,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(59,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(60,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(61,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(62,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(63,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(64,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(65,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(66,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(67,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(68,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(69,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(70,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(71,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(72,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(73,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(74,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(75,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(76,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(77,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(78,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(79,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(80,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(81,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(82,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(83,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(84,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(85,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(86,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(87,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(88,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(89,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(90,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(91,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(92,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(93,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(94,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(95,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(96,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(97,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(98,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(99,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(100,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(101,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(102,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(103,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(104,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(105,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(106,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(107,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(108,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(109,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(110,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\ncity\npostcode\nState:name\nCountry:name\nphone'),(111,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nState:name\nCountry:name\nphone'),(112,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(113,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(114,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(115,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(116,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(117,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(118,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(119,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(120,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(121,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(122,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(123,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(124,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(125,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(126,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(127,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(128,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(129,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(130,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(131,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(132,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(133,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(134,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(135,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(136,'lastname firstname\r\nphone_mobile\r\nCountry:name\r\ncity\r\npostcode\r\naddress1\r\ncompany \r\nvat_number'),(137,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(138,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(139,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(140,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(141,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(142,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(143,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(144,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(145,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nState:name\nCountry:name\nphone'),(146,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(147,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(148,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(149,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(150,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(151,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(152,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(153,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(154,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(155,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(156,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(157,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(158,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(159,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(160,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(161,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(162,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(163,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(164,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(165,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(166,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(167,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(168,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(169,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(170,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(171,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(172,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(173,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(174,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(175,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(176,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(177,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(178,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(179,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(180,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(181,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(182,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(183,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(184,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(185,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(186,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(187,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(188,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(189,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(190,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(191,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(192,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(193,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(194,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(195,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(196,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(197,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(198,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(199,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(200,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(201,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(202,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(203,'lastname firstname\r\nphone_mobile\r\nCountry:name\r\ncity\r\npostcode\r\naddress1\r\ncompany \r\nvat_number'),(204,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(205,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(206,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(207,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(208,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(209,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(210,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(211,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(212,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(213,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(214,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(215,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(216,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(217,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(218,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(219,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(220,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(221,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(222,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(223,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(224,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(225,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(226,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(227,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(228,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(229,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(230,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(231,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(232,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(233,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(234,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(235,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(236,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(237,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(238,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(239,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(240,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(241,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(242,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(243,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(244,'firstname lastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone'),(245,'lastname firstname\r\nphone_mobile\r\nCountry:name\r\ncompany \r\nvat_number'),(246,'lastname firstname\r\nphone_mobile\r\nCountry:name\r\ncompany \r\nvat_number');
/*!40000 ALTER TABLE `ps_address_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_admin_filter`
--

DROP TABLE IF EXISTS `ps_admin_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_admin_filter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee` int(11) NOT NULL,
  `shop` int(11) NOT NULL,
  `controller` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `filter` longtext COLLATE utf8_unicode_ci NOT NULL,
  `filter_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_filter_search_idx` (`employee`,`shop`,`controller`,`action`,`filter_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_admin_filter`
--

LOCK TABLES `ps_admin_filter` WRITE;
/*!40000 ALTER TABLE `ps_admin_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_admin_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_alias`
--

DROP TABLE IF EXISTS `ps_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_alias` (
  `id_alias` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL,
  `search` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_alias`),
  UNIQUE KEY `alias` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_alias`
--

LOCK TABLES `ps_alias` WRITE;
/*!40000 ALTER TABLE `ps_alias` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attachment`
--

DROP TABLE IF EXISTS `ps_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attachment` (
  `id_attachment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file` varchar(40) NOT NULL,
  `file_name` varchar(128) NOT NULL,
  `file_size` bigint(10) unsigned NOT NULL DEFAULT '0',
  `mime` varchar(128) NOT NULL,
  PRIMARY KEY (`id_attachment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attachment`
--

LOCK TABLES `ps_attachment` WRITE;
/*!40000 ALTER TABLE `ps_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attachment_lang`
--

DROP TABLE IF EXISTS `ps_attachment_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attachment_lang` (
  `id_attachment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id_attachment`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attachment_lang`
--

LOCK TABLES `ps_attachment_lang` WRITE;
/*!40000 ALTER TABLE `ps_attachment_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_attachment_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attribute`
--

DROP TABLE IF EXISTS `ps_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute` (
  `id_attribute` int(11) NOT NULL AUTO_INCREMENT,
  `id_attribute_group` int(11) NOT NULL,
  `color` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`id_attribute`),
  KEY `attribute_group` (`id_attribute_group`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attribute`
--

LOCK TABLES `ps_attribute` WRITE;
/*!40000 ALTER TABLE `ps_attribute` DISABLE KEYS */;
INSERT INTO `ps_attribute` VALUES (1,1,'',0),(2,1,'',1),(3,1,'',2),(4,1,'',3),(5,1,'',4),(6,2,'',0),(7,2,'',1),(8,2,'',2),(9,3,'#2ddcbd',0),(10,3,'#2da4dc',1),(11,3,'#e72121',2),(12,3,'#fae603',3);
/*!40000 ALTER TABLE `ps_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attribute_group`
--

DROP TABLE IF EXISTS `ps_attribute_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_group` (
  `id_attribute_group` int(11) NOT NULL AUTO_INCREMENT,
  `is_color_group` tinyint(1) NOT NULL,
  `group_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`id_attribute_group`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attribute_group`
--

LOCK TABLES `ps_attribute_group` WRITE;
/*!40000 ALTER TABLE `ps_attribute_group` DISABLE KEYS */;
INSERT INTO `ps_attribute_group` VALUES (1,0,'radio',0),(2,1,'color',1),(3,1,'color',2);
/*!40000 ALTER TABLE `ps_attribute_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attribute_group_lang`
--

DROP TABLE IF EXISTS `ps_attribute_group_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_group_lang` (
  `id_attribute_group` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `public_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_attribute_group`,`id_lang`),
  KEY `IDX_4653726C67A664FB` (`id_attribute_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attribute_group_lang`
--

LOCK TABLES `ps_attribute_group_lang` WRITE;
/*!40000 ALTER TABLE `ps_attribute_group_lang` DISABLE KEYS */;
INSERT INTO `ps_attribute_group_lang` VALUES (1,1,'尺寸','尺寸'),(1,2,'Size','Size'),(1,3,'尺寸','尺寸'),(1,4,'Size','Size'),(2,1,'紙料','紙料'),(2,2,'Material','Material'),(2,3,'纸料','纸料'),(2,4,'紙の生地','紙の生地'),(3,1,'顏色','顏色'),(3,2,'Color','Color'),(3,3,'颜色','颜色'),(3,4,'カラー','カラー');
/*!40000 ALTER TABLE `ps_attribute_group_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attribute_group_shop`
--

DROP TABLE IF EXISTS `ps_attribute_group_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_group_shop` (
  `id_attribute_group` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  PRIMARY KEY (`id_attribute_group`,`id_shop`),
  KEY `IDX_DB30BAAC67A664FB` (`id_attribute_group`),
  KEY `IDX_DB30BAAC274A50A0` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attribute_group_shop`
--

LOCK TABLES `ps_attribute_group_shop` WRITE;
/*!40000 ALTER TABLE `ps_attribute_group_shop` DISABLE KEYS */;
INSERT INTO `ps_attribute_group_shop` VALUES (1,1),(2,1),(3,1);
/*!40000 ALTER TABLE `ps_attribute_group_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attribute_impact`
--

DROP TABLE IF EXISTS `ps_attribute_impact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_impact` (
  `id_attribute_impact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(11) unsigned NOT NULL,
  `id_attribute` int(11) unsigned NOT NULL,
  `weight` decimal(20,6) NOT NULL,
  `price` decimal(17,2) NOT NULL,
  PRIMARY KEY (`id_attribute_impact`),
  UNIQUE KEY `id_product` (`id_product`,`id_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attribute_impact`
--

LOCK TABLES `ps_attribute_impact` WRITE;
/*!40000 ALTER TABLE `ps_attribute_impact` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_attribute_impact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attribute_lang`
--

DROP TABLE IF EXISTS `ps_attribute_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_lang` (
  `id_attribute` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_attribute`,`id_lang`),
  KEY `IDX_3ABE46A77A4F53DC` (`id_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attribute_lang`
--

LOCK TABLES `ps_attribute_lang` WRITE;
/*!40000 ALTER TABLE `ps_attribute_lang` DISABLE KEYS */;
INSERT INTO `ps_attribute_lang` VALUES (1,1,'XS'),(1,2,'XS'),(1,3,'XS'),(1,4,'XS'),(2,1,'S'),(2,2,'S'),(2,3,'S'),(2,4,'S'),(3,1,'M'),(3,2,'M'),(3,3,'M'),(3,4,'M'),(4,1,'L'),(4,2,'L'),(4,3,'L'),(4,4,'L'),(5,1,'XL'),(5,2,'XL'),(5,3,'XL'),(5,4,'XL'),(6,1,'波面剛古紙'),(6,2,'波面剛古紙'),(6,3,'波面剛古紙'),(6,4,'コンケラーコンツァ'),(7,1,'トーメイあらじま'),(7,2,'トーメイあらじま'),(7,3,'トーメイあらじま'),(7,4,'トーメイあらじま'),(8,1,'炫光紙'),(8,2,'炫光紙'),(8,3,'炫光紙'),(8,4,'キュリアス メタル'),(9,1,'湖綠'),(9,2,'湖綠'),(9,3,'湖綠'),(9,4,'ライトグリーン'),(10,1,'海藍'),(10,2,'海藍'),(10,3,'海藍'),(10,4,'シーブルー'),(11,1,'血紅'),(11,2,'血紅'),(11,3,'血紅'),(11,4,'レッド'),(12,1,'日金'),(12,2,'日金'),(12,3,'日金'),(12,4,'イエロー');
/*!40000 ALTER TABLE `ps_attribute_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_attribute_shop`
--

DROP TABLE IF EXISTS `ps_attribute_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_attribute_shop` (
  `id_attribute` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  PRIMARY KEY (`id_attribute`,`id_shop`),
  KEY `IDX_A7DD8E677A4F53DC` (`id_attribute`),
  KEY `IDX_A7DD8E67274A50A0` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_attribute_shop`
--

LOCK TABLES `ps_attribute_shop` WRITE;
/*!40000 ALTER TABLE `ps_attribute_shop` DISABLE KEYS */;
INSERT INTO `ps_attribute_shop` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1);
/*!40000 ALTER TABLE `ps_attribute_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_authorization_role`
--

DROP TABLE IF EXISTS `ps_authorization_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_authorization_role` (
  `id_authorization_role` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id_authorization_role`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_authorization_role`
--

LOCK TABLES `ps_authorization_role` WRITE;
/*!40000 ALTER TABLE `ps_authorization_role` DISABLE KEYS */;
INSERT INTO `ps_authorization_role` VALUES (809,'ROLE_MOD_MODULE_BLOCKREASSURANCE_CREATE'),(812,'ROLE_MOD_MODULE_BLOCKREASSURANCE_DELETE'),(810,'ROLE_MOD_MODULE_BLOCKREASSURANCE_READ'),(811,'ROLE_MOD_MODULE_BLOCKREASSURANCE_UPDATE'),(453,'ROLE_MOD_MODULE_CONTACTFORM_CREATE'),(456,'ROLE_MOD_MODULE_CONTACTFORM_DELETE'),(454,'ROLE_MOD_MODULE_CONTACTFORM_READ'),(455,'ROLE_MOD_MODULE_CONTACTFORM_UPDATE'),(457,'ROLE_MOD_MODULE_DASHACTIVITY_CREATE'),(460,'ROLE_MOD_MODULE_DASHACTIVITY_DELETE'),(458,'ROLE_MOD_MODULE_DASHACTIVITY_READ'),(459,'ROLE_MOD_MODULE_DASHACTIVITY_UPDATE'),(469,'ROLE_MOD_MODULE_DASHGOALS_CREATE'),(472,'ROLE_MOD_MODULE_DASHGOALS_DELETE'),(470,'ROLE_MOD_MODULE_DASHGOALS_READ'),(471,'ROLE_MOD_MODULE_DASHGOALS_UPDATE'),(473,'ROLE_MOD_MODULE_DASHPRODUCTS_CREATE'),(476,'ROLE_MOD_MODULE_DASHPRODUCTS_DELETE'),(474,'ROLE_MOD_MODULE_DASHPRODUCTS_READ'),(475,'ROLE_MOD_MODULE_DASHPRODUCTS_UPDATE'),(461,'ROLE_MOD_MODULE_DASHTRENDS_CREATE'),(464,'ROLE_MOD_MODULE_DASHTRENDS_DELETE'),(462,'ROLE_MOD_MODULE_DASHTRENDS_READ'),(463,'ROLE_MOD_MODULE_DASHTRENDS_UPDATE'),(985,'ROLE_MOD_MODULE_ECPAY_711_CREATE'),(921,'ROLE_MOD_MODULE_ECPAY_CREATE'),(988,'ROLE_MOD_MODULE_ECPAY_CVS_DELETE'),(986,'ROLE_MOD_MODULE_ECPAY_CVS_READ'),(987,'ROLE_MOD_MODULE_ECPAY_CVS_UPDATE'),(924,'ROLE_MOD_MODULE_ECPAY_DELETE'),(922,'ROLE_MOD_MODULE_ECPAY_READ'),(989,'ROLE_MOD_MODULE_ECPAY_TCAT_CREATE'),(992,'ROLE_MOD_MODULE_ECPAY_TCAT_DELETE'),(990,'ROLE_MOD_MODULE_ECPAY_TCAT_READ'),(991,'ROLE_MOD_MODULE_ECPAY_TCAT_UPDATE'),(923,'ROLE_MOD_MODULE_ECPAY_UPDATE'),(973,'ROLE_MOD_MODULE_EZSHIP_CREATE'),(976,'ROLE_MOD_MODULE_EZSHIP_DELETE'),(977,'ROLE_MOD_MODULE_EZSHIP_HOME_CREATE'),(980,'ROLE_MOD_MODULE_EZSHIP_HOME_DELETE'),(978,'ROLE_MOD_MODULE_EZSHIP_HOME_READ'),(979,'ROLE_MOD_MODULE_EZSHIP_HOME_UPDATE'),(974,'ROLE_MOD_MODULE_EZSHIP_READ'),(975,'ROLE_MOD_MODULE_EZSHIP_UPDATE'),(477,'ROLE_MOD_MODULE_GRAPHNVD3_CREATE'),(480,'ROLE_MOD_MODULE_GRAPHNVD3_DELETE'),(478,'ROLE_MOD_MODULE_GRAPHNVD3_READ'),(479,'ROLE_MOD_MODULE_GRAPHNVD3_UPDATE'),(481,'ROLE_MOD_MODULE_GRIDHTML_CREATE'),(484,'ROLE_MOD_MODULE_GRIDHTML_DELETE'),(482,'ROLE_MOD_MODULE_GRIDHTML_READ'),(483,'ROLE_MOD_MODULE_GRIDHTML_UPDATE'),(909,'ROLE_MOD_MODULE_GSHOPPINGFLUX_CREATE'),(912,'ROLE_MOD_MODULE_GSHOPPINGFLUX_DELETE'),(910,'ROLE_MOD_MODULE_GSHOPPINGFLUX_READ'),(911,'ROLE_MOD_MODULE_GSHOPPINGFLUX_UPDATE'),(889,'ROLE_MOD_MODULE_GSITEMAP_CREATE'),(892,'ROLE_MOD_MODULE_GSITEMAP_DELETE'),(890,'ROLE_MOD_MODULE_GSITEMAP_READ'),(891,'ROLE_MOD_MODULE_GSITEMAP_UPDATE'),(893,'ROLE_MOD_MODULE_PAYPAL_CREATE'),(896,'ROLE_MOD_MODULE_PAYPAL_DELETE'),(894,'ROLE_MOD_MODULE_PAYPAL_READ'),(895,'ROLE_MOD_MODULE_PAYPAL_UPDATE'),(793,'ROLE_MOD_MODULE_PSCLEANER_CREATE'),(796,'ROLE_MOD_MODULE_PSCLEANER_DELETE'),(794,'ROLE_MOD_MODULE_PSCLEANER_READ'),(795,'ROLE_MOD_MODULE_PSCLEANER_UPDATE'),(797,'ROLE_MOD_MODULE_PSPIXEL_CREATE'),(800,'ROLE_MOD_MODULE_PSPIXEL_DELETE'),(798,'ROLE_MOD_MODULE_PSPIXEL_READ'),(799,'ROLE_MOD_MODULE_PSPIXEL_UPDATE'),(485,'ROLE_MOD_MODULE_PS_BANNER_CREATE'),(488,'ROLE_MOD_MODULE_PS_BANNER_DELETE'),(486,'ROLE_MOD_MODULE_PS_BANNER_READ'),(487,'ROLE_MOD_MODULE_PS_BANNER_UPDATE'),(709,'ROLE_MOD_MODULE_PS_BESTSELLERS_CREATE'),(712,'ROLE_MOD_MODULE_PS_BESTSELLERS_DELETE'),(710,'ROLE_MOD_MODULE_PS_BESTSELLERS_READ'),(711,'ROLE_MOD_MODULE_PS_BESTSELLERS_UPDATE'),(773,'ROLE_MOD_MODULE_PS_BRANDLIST_CREATE'),(776,'ROLE_MOD_MODULE_PS_BRANDLIST_DELETE'),(774,'ROLE_MOD_MODULE_PS_BRANDLIST_READ'),(775,'ROLE_MOD_MODULE_PS_BRANDLIST_UPDATE'),(913,'ROLE_MOD_MODULE_PS_CATEGORYPRODUCTS_CREATE'),(916,'ROLE_MOD_MODULE_PS_CATEGORYPRODUCTS_DELETE'),(914,'ROLE_MOD_MODULE_PS_CATEGORYPRODUCTS_READ'),(915,'ROLE_MOD_MODULE_PS_CATEGORYPRODUCTS_UPDATE'),(489,'ROLE_MOD_MODULE_PS_CATEGORYTREE_CREATE'),(492,'ROLE_MOD_MODULE_PS_CATEGORYTREE_DELETE'),(490,'ROLE_MOD_MODULE_PS_CATEGORYTREE_READ'),(491,'ROLE_MOD_MODULE_PS_CATEGORYTREE_UPDATE'),(497,'ROLE_MOD_MODULE_PS_CONTACTINFO_CREATE'),(500,'ROLE_MOD_MODULE_PS_CONTACTINFO_DELETE'),(498,'ROLE_MOD_MODULE_PS_CONTACTINFO_READ'),(499,'ROLE_MOD_MODULE_PS_CONTACTINFO_UPDATE'),(725,'ROLE_MOD_MODULE_PS_CROSSSELLING_CREATE'),(728,'ROLE_MOD_MODULE_PS_CROSSSELLING_DELETE'),(726,'ROLE_MOD_MODULE_PS_CROSSSELLING_READ'),(727,'ROLE_MOD_MODULE_PS_CROSSSELLING_UPDATE'),(501,'ROLE_MOD_MODULE_PS_CURRENCYSELECTOR_CREATE'),(504,'ROLE_MOD_MODULE_PS_CURRENCYSELECTOR_DELETE'),(502,'ROLE_MOD_MODULE_PS_CURRENCYSELECTOR_READ'),(503,'ROLE_MOD_MODULE_PS_CURRENCYSELECTOR_UPDATE'),(805,'ROLE_MOD_MODULE_PS_CUSTOMERACCOUNTLINKS_CREATE'),(808,'ROLE_MOD_MODULE_PS_CUSTOMERACCOUNTLINKS_DELETE'),(806,'ROLE_MOD_MODULE_PS_CUSTOMERACCOUNTLINKS_READ'),(807,'ROLE_MOD_MODULE_PS_CUSTOMERACCOUNTLINKS_UPDATE'),(509,'ROLE_MOD_MODULE_PS_CUSTOMERSIGNIN_CREATE'),(512,'ROLE_MOD_MODULE_PS_CUSTOMERSIGNIN_DELETE'),(510,'ROLE_MOD_MODULE_PS_CUSTOMERSIGNIN_READ'),(511,'ROLE_MOD_MODULE_PS_CUSTOMERSIGNIN_UPDATE'),(513,'ROLE_MOD_MODULE_PS_CUSTOMTEXT_CREATE'),(516,'ROLE_MOD_MODULE_PS_CUSTOMTEXT_DELETE'),(514,'ROLE_MOD_MODULE_PS_CUSTOMTEXT_READ'),(515,'ROLE_MOD_MODULE_PS_CUSTOMTEXT_UPDATE'),(757,'ROLE_MOD_MODULE_PS_EMAILALERTS_CREATE'),(760,'ROLE_MOD_MODULE_PS_EMAILALERTS_DELETE'),(758,'ROLE_MOD_MODULE_PS_EMAILALERTS_READ'),(759,'ROLE_MOD_MODULE_PS_EMAILALERTS_UPDATE'),(517,'ROLE_MOD_MODULE_PS_EMAILSUBSCRIPTION_CREATE'),(520,'ROLE_MOD_MODULE_PS_EMAILSUBSCRIPTION_DELETE'),(518,'ROLE_MOD_MODULE_PS_EMAILSUBSCRIPTION_READ'),(519,'ROLE_MOD_MODULE_PS_EMAILSUBSCRIPTION_UPDATE'),(521,'ROLE_MOD_MODULE_PS_FACETEDSEARCH_CREATE'),(524,'ROLE_MOD_MODULE_PS_FACETEDSEARCH_DELETE'),(522,'ROLE_MOD_MODULE_PS_FACETEDSEARCH_READ'),(523,'ROLE_MOD_MODULE_PS_FACETEDSEARCH_UPDATE'),(525,'ROLE_MOD_MODULE_PS_FEATUREDPRODUCTS_CREATE'),(528,'ROLE_MOD_MODULE_PS_FEATUREDPRODUCTS_DELETE'),(526,'ROLE_MOD_MODULE_PS_FEATUREDPRODUCTS_READ'),(527,'ROLE_MOD_MODULE_PS_FEATUREDPRODUCTS_UPDATE'),(761,'ROLE_MOD_MODULE_PS_GOOGLEANALYTICS_CREATE'),(764,'ROLE_MOD_MODULE_PS_GOOGLEANALYTICS_DELETE'),(762,'ROLE_MOD_MODULE_PS_GOOGLEANALYTICS_READ'),(763,'ROLE_MOD_MODULE_PS_GOOGLEANALYTICS_UPDATE'),(529,'ROLE_MOD_MODULE_PS_IMAGESLIDER_CREATE'),(532,'ROLE_MOD_MODULE_PS_IMAGESLIDER_DELETE'),(530,'ROLE_MOD_MODULE_PS_IMAGESLIDER_READ'),(531,'ROLE_MOD_MODULE_PS_IMAGESLIDER_UPDATE'),(533,'ROLE_MOD_MODULE_PS_LANGUAGESELECTOR_CREATE'),(536,'ROLE_MOD_MODULE_PS_LANGUAGESELECTOR_DELETE'),(534,'ROLE_MOD_MODULE_PS_LANGUAGESELECTOR_READ'),(535,'ROLE_MOD_MODULE_PS_LANGUAGESELECTOR_UPDATE'),(537,'ROLE_MOD_MODULE_PS_LINKLIST_CREATE'),(540,'ROLE_MOD_MODULE_PS_LINKLIST_DELETE'),(538,'ROLE_MOD_MODULE_PS_LINKLIST_READ'),(539,'ROLE_MOD_MODULE_PS_LINKLIST_UPDATE'),(545,'ROLE_MOD_MODULE_PS_MAINMENU_CREATE'),(548,'ROLE_MOD_MODULE_PS_MAINMENU_DELETE'),(546,'ROLE_MOD_MODULE_PS_MAINMENU_READ'),(547,'ROLE_MOD_MODULE_PS_MAINMENU_UPDATE'),(729,'ROLE_MOD_MODULE_PS_NEWPRODUCTS_CREATE'),(732,'ROLE_MOD_MODULE_PS_NEWPRODUCTS_DELETE'),(730,'ROLE_MOD_MODULE_PS_NEWPRODUCTS_READ'),(731,'ROLE_MOD_MODULE_PS_NEWPRODUCTS_UPDATE'),(721,'ROLE_MOD_MODULE_PS_REMINDER_CREATE'),(724,'ROLE_MOD_MODULE_PS_REMINDER_DELETE'),(722,'ROLE_MOD_MODULE_PS_REMINDER_READ'),(723,'ROLE_MOD_MODULE_PS_REMINDER_UPDATE'),(549,'ROLE_MOD_MODULE_PS_SEARCHBAR_CREATE'),(552,'ROLE_MOD_MODULE_PS_SEARCHBAR_DELETE'),(550,'ROLE_MOD_MODULE_PS_SEARCHBAR_READ'),(551,'ROLE_MOD_MODULE_PS_SEARCHBAR_UPDATE'),(553,'ROLE_MOD_MODULE_PS_SHAREBUTTONS_CREATE'),(556,'ROLE_MOD_MODULE_PS_SHAREBUTTONS_DELETE'),(554,'ROLE_MOD_MODULE_PS_SHAREBUTTONS_READ'),(555,'ROLE_MOD_MODULE_PS_SHAREBUTTONS_UPDATE'),(557,'ROLE_MOD_MODULE_PS_SHOPPINGCART_CREATE'),(560,'ROLE_MOD_MODULE_PS_SHOPPINGCART_DELETE'),(558,'ROLE_MOD_MODULE_PS_SHOPPINGCART_READ'),(559,'ROLE_MOD_MODULE_PS_SHOPPINGCART_UPDATE'),(561,'ROLE_MOD_MODULE_PS_SOCIALFOLLOW_CREATE'),(564,'ROLE_MOD_MODULE_PS_SOCIALFOLLOW_DELETE'),(562,'ROLE_MOD_MODULE_PS_SOCIALFOLLOW_READ'),(563,'ROLE_MOD_MODULE_PS_SOCIALFOLLOW_UPDATE'),(713,'ROLE_MOD_MODULE_PS_SPECIALS_CREATE'),(716,'ROLE_MOD_MODULE_PS_SPECIALS_DELETE'),(714,'ROLE_MOD_MODULE_PS_SPECIALS_READ'),(715,'ROLE_MOD_MODULE_PS_SPECIALS_UPDATE'),(777,'ROLE_MOD_MODULE_PS_SUPPLIERLIST_CREATE'),(780,'ROLE_MOD_MODULE_PS_SUPPLIERLIST_DELETE'),(778,'ROLE_MOD_MODULE_PS_SUPPLIERLIST_READ'),(779,'ROLE_MOD_MODULE_PS_SUPPLIERLIST_UPDATE'),(565,'ROLE_MOD_MODULE_PS_THEMECUSTO_CREATE'),(568,'ROLE_MOD_MODULE_PS_THEMECUSTO_DELETE'),(566,'ROLE_MOD_MODULE_PS_THEMECUSTO_READ'),(567,'ROLE_MOD_MODULE_PS_THEMECUSTO_UPDATE'),(769,'ROLE_MOD_MODULE_PS_VIEWEDPRODUCT_CREATE'),(772,'ROLE_MOD_MODULE_PS_VIEWEDPRODUCT_DELETE'),(770,'ROLE_MOD_MODULE_PS_VIEWEDPRODUCT_READ'),(771,'ROLE_MOD_MODULE_PS_VIEWEDPRODUCT_UPDATE'),(581,'ROLE_MOD_MODULE_PS_WIREPAYMENT_CREATE'),(584,'ROLE_MOD_MODULE_PS_WIREPAYMENT_DELETE'),(582,'ROLE_MOD_MODULE_PS_WIREPAYMENT_READ'),(583,'ROLE_MOD_MODULE_PS_WIREPAYMENT_UPDATE'),(873,'ROLE_MOD_MODULE_SIMPLICITY_CMSBLOCK_CREATE'),(876,'ROLE_MOD_MODULE_SIMPLICITY_CMSBLOCK_DELETE'),(874,'ROLE_MOD_MODULE_SIMPLICITY_CMSBLOCK_READ'),(875,'ROLE_MOD_MODULE_SIMPLICITY_CMSBLOCK_UPDATE'),(877,'ROLE_MOD_MODULE_SIMPLICITY_FBMESSAGING_CREATE'),(880,'ROLE_MOD_MODULE_SIMPLICITY_FBMESSAGING_DELETE'),(878,'ROLE_MOD_MODULE_SIMPLICITY_FBMESSAGING_READ'),(879,'ROLE_MOD_MODULE_SIMPLICITY_FBMESSAGING_UPDATE'),(917,'ROLE_MOD_MODULE_SIMPLICITY_FOOTERBAR_CREATE'),(920,'ROLE_MOD_MODULE_SIMPLICITY_FOOTERBAR_DELETE'),(918,'ROLE_MOD_MODULE_SIMPLICITY_FOOTERBAR_READ'),(919,'ROLE_MOD_MODULE_SIMPLICITY_FOOTERBAR_UPDATE'),(901,'ROLE_MOD_MODULE_SIMPLICITY_GTM_CREATE'),(904,'ROLE_MOD_MODULE_SIMPLICITY_GTM_DELETE'),(902,'ROLE_MOD_MODULE_SIMPLICITY_GTM_READ'),(903,'ROLE_MOD_MODULE_SIMPLICITY_GTM_UPDATE'),(885,'ROLE_MOD_MODULE_SIMPLICITY_HEADERBAR_CREATE'),(886,'ROLE_MOD_MODULE_SIMPLICITY_HEADERBAR_DELETE'),(887,'ROLE_MOD_MODULE_SIMPLICITY_HEADERBAR_READ'),(888,'ROLE_MOD_MODULE_SIMPLICITY_HEADERBAR_UPDATE'),(905,'ROLE_MOD_MODULE_SIMPLICITY_IGFEED_CREATE'),(908,'ROLE_MOD_MODULE_SIMPLICITY_IGFEED_DELETE'),(906,'ROLE_MOD_MODULE_SIMPLICITY_IGFEED_READ'),(907,'ROLE_MOD_MODULE_SIMPLICITY_IGFEED_UPDATE'),(801,'ROLE_MOD_MODULE_SIMPLICITY_LOGO_CREATE'),(804,'ROLE_MOD_MODULE_SIMPLICITY_LOGO_DELETE'),(802,'ROLE_MOD_MODULE_SIMPLICITY_LOGO_READ'),(803,'ROLE_MOD_MODULE_SIMPLICITY_LOGO_UPDATE'),(813,'ROLE_MOD_MODULE_SIMPLICITY_SOCIALLOGIN_CREATE'),(816,'ROLE_MOD_MODULE_SIMPLICITY_SOCIALLOGIN_DELETE'),(814,'ROLE_MOD_MODULE_SIMPLICITY_SOCIALLOGIN_READ'),(815,'ROLE_MOD_MODULE_SIMPLICITY_SOCIALLOGIN_UPDATE'),(597,'ROLE_MOD_MODULE_STATSBESTCUSTOMERS_CREATE'),(600,'ROLE_MOD_MODULE_STATSBESTCUSTOMERS_DELETE'),(598,'ROLE_MOD_MODULE_STATSBESTCUSTOMERS_READ'),(599,'ROLE_MOD_MODULE_STATSBESTCUSTOMERS_UPDATE'),(601,'ROLE_MOD_MODULE_STATSBESTPRODUCTS_CREATE'),(604,'ROLE_MOD_MODULE_STATSBESTPRODUCTS_DELETE'),(602,'ROLE_MOD_MODULE_STATSBESTPRODUCTS_READ'),(603,'ROLE_MOD_MODULE_STATSBESTPRODUCTS_UPDATE'),(625,'ROLE_MOD_MODULE_STATSDATA_CREATE'),(628,'ROLE_MOD_MODULE_STATSDATA_DELETE'),(626,'ROLE_MOD_MODULE_STATSDATA_READ'),(627,'ROLE_MOD_MODULE_STATSDATA_UPDATE'),(633,'ROLE_MOD_MODULE_STATSFORECAST_CREATE'),(636,'ROLE_MOD_MODULE_STATSFORECAST_DELETE'),(634,'ROLE_MOD_MODULE_STATSFORECAST_READ'),(635,'ROLE_MOD_MODULE_STATSFORECAST_UPDATE'),(637,'ROLE_MOD_MODULE_STATSLIVE_CREATE'),(640,'ROLE_MOD_MODULE_STATSLIVE_DELETE'),(638,'ROLE_MOD_MODULE_STATSLIVE_READ'),(639,'ROLE_MOD_MODULE_STATSLIVE_UPDATE'),(661,'ROLE_MOD_MODULE_STATSSALES_CREATE'),(664,'ROLE_MOD_MODULE_STATSSALES_DELETE'),(662,'ROLE_MOD_MODULE_STATSSALES_READ'),(663,'ROLE_MOD_MODULE_STATSSALES_UPDATE'),(673,'ROLE_MOD_MODULE_STATSVISITS_CREATE'),(676,'ROLE_MOD_MODULE_STATSVISITS_DELETE'),(674,'ROLE_MOD_MODULE_STATSVISITS_READ'),(675,'ROLE_MOD_MODULE_STATSVISITS_UPDATE'),(993,'ROLE_MOD_MODULE_TC_711_CREATE'),(996,'ROLE_MOD_MODULE_TC_CVS_DELETE'),(994,'ROLE_MOD_MODULE_TC_CVS_READ'),(995,'ROLE_MOD_MODULE_TC_CVS_UPDATE'),(1001,'ROLE_MOD_MODULE_TC_HOME2_CREATE'),(1004,'ROLE_MOD_MODULE_TC_HOME2_DELETE'),(1002,'ROLE_MOD_MODULE_TC_HOME2_READ'),(1003,'ROLE_MOD_MODULE_TC_HOME2_UPDATE'),(1005,'ROLE_MOD_MODULE_TC_HOME3_CREATE'),(1008,'ROLE_MOD_MODULE_TC_HOME3_DELETE'),(1006,'ROLE_MOD_MODULE_TC_HOME3_READ'),(1007,'ROLE_MOD_MODULE_TC_HOME3_UPDATE'),(997,'ROLE_MOD_MODULE_TC_HOME_CREATE'),(1000,'ROLE_MOD_MODULE_TC_HOME_DELETE'),(998,'ROLE_MOD_MODULE_TC_HOME_READ'),(999,'ROLE_MOD_MODULE_TC_HOME_UPDATE'),(981,'ROLE_MOD_MODULE_TC_POD_CREATE'),(984,'ROLE_MOD_MODULE_TC_POD_DELETE'),(982,'ROLE_MOD_MODULE_TC_POD_READ'),(983,'ROLE_MOD_MODULE_TC_POD_UPDATE'),(1,'ROLE_MOD_TAB_ADMINACCESS_CREATE'),(4,'ROLE_MOD_TAB_ADMINACCESS_DELETE'),(2,'ROLE_MOD_TAB_ADMINACCESS_READ'),(3,'ROLE_MOD_TAB_ADMINACCESS_UPDATE'),(5,'ROLE_MOD_TAB_ADMINADDONSCATALOG_CREATE'),(8,'ROLE_MOD_TAB_ADMINADDONSCATALOG_DELETE'),(6,'ROLE_MOD_TAB_ADMINADDONSCATALOG_READ'),(7,'ROLE_MOD_TAB_ADMINADDONSCATALOG_UPDATE'),(9,'ROLE_MOD_TAB_ADMINADDRESSES_CREATE'),(12,'ROLE_MOD_TAB_ADMINADDRESSES_DELETE'),(10,'ROLE_MOD_TAB_ADMINADDRESSES_READ'),(11,'ROLE_MOD_TAB_ADMINADDRESSES_UPDATE'),(13,'ROLE_MOD_TAB_ADMINADMINPREFERENCES_CREATE'),(16,'ROLE_MOD_TAB_ADMINADMINPREFERENCES_DELETE'),(14,'ROLE_MOD_TAB_ADMINADMINPREFERENCES_READ'),(15,'ROLE_MOD_TAB_ADMINADMINPREFERENCES_UPDATE'),(17,'ROLE_MOD_TAB_ADMINADVANCEDPARAMETERS_CREATE'),(20,'ROLE_MOD_TAB_ADMINADVANCEDPARAMETERS_DELETE'),(18,'ROLE_MOD_TAB_ADMINADVANCEDPARAMETERS_READ'),(19,'ROLE_MOD_TAB_ADMINADVANCEDPARAMETERS_UPDATE'),(21,'ROLE_MOD_TAB_ADMINATTACHMENTS_CREATE'),(24,'ROLE_MOD_TAB_ADMINATTACHMENTS_DELETE'),(22,'ROLE_MOD_TAB_ADMINATTACHMENTS_READ'),(23,'ROLE_MOD_TAB_ADMINATTACHMENTS_UPDATE'),(25,'ROLE_MOD_TAB_ADMINATTRIBUTESGROUPS_CREATE'),(28,'ROLE_MOD_TAB_ADMINATTRIBUTESGROUPS_DELETE'),(26,'ROLE_MOD_TAB_ADMINATTRIBUTESGROUPS_READ'),(27,'ROLE_MOD_TAB_ADMINATTRIBUTESGROUPS_UPDATE'),(29,'ROLE_MOD_TAB_ADMINBACKUP_CREATE'),(32,'ROLE_MOD_TAB_ADMINBACKUP_DELETE'),(30,'ROLE_MOD_TAB_ADMINBACKUP_READ'),(31,'ROLE_MOD_TAB_ADMINBACKUP_UPDATE'),(33,'ROLE_MOD_TAB_ADMINCARRIERS_CREATE'),(36,'ROLE_MOD_TAB_ADMINCARRIERS_DELETE'),(34,'ROLE_MOD_TAB_ADMINCARRIERS_READ'),(35,'ROLE_MOD_TAB_ADMINCARRIERS_UPDATE'),(37,'ROLE_MOD_TAB_ADMINCARTRULES_CREATE'),(40,'ROLE_MOD_TAB_ADMINCARTRULES_DELETE'),(38,'ROLE_MOD_TAB_ADMINCARTRULES_READ'),(39,'ROLE_MOD_TAB_ADMINCARTRULES_UPDATE'),(41,'ROLE_MOD_TAB_ADMINCARTS_CREATE'),(44,'ROLE_MOD_TAB_ADMINCARTS_DELETE'),(42,'ROLE_MOD_TAB_ADMINCARTS_READ'),(43,'ROLE_MOD_TAB_ADMINCARTS_UPDATE'),(45,'ROLE_MOD_TAB_ADMINCATALOG_CREATE'),(48,'ROLE_MOD_TAB_ADMINCATALOG_DELETE'),(46,'ROLE_MOD_TAB_ADMINCATALOG_READ'),(47,'ROLE_MOD_TAB_ADMINCATALOG_UPDATE'),(49,'ROLE_MOD_TAB_ADMINCATEGORIES_CREATE'),(52,'ROLE_MOD_TAB_ADMINCATEGORIES_DELETE'),(50,'ROLE_MOD_TAB_ADMINCATEGORIES_READ'),(51,'ROLE_MOD_TAB_ADMINCATEGORIES_UPDATE'),(53,'ROLE_MOD_TAB_ADMINCMSCONTENT_CREATE'),(56,'ROLE_MOD_TAB_ADMINCMSCONTENT_DELETE'),(54,'ROLE_MOD_TAB_ADMINCMSCONTENT_READ'),(55,'ROLE_MOD_TAB_ADMINCMSCONTENT_UPDATE'),(57,'ROLE_MOD_TAB_ADMINCONTACTS_CREATE'),(60,'ROLE_MOD_TAB_ADMINCONTACTS_DELETE'),(58,'ROLE_MOD_TAB_ADMINCONTACTS_READ'),(59,'ROLE_MOD_TAB_ADMINCONTACTS_UPDATE'),(61,'ROLE_MOD_TAB_ADMINCOUNTRIES_CREATE'),(64,'ROLE_MOD_TAB_ADMINCOUNTRIES_DELETE'),(62,'ROLE_MOD_TAB_ADMINCOUNTRIES_READ'),(63,'ROLE_MOD_TAB_ADMINCOUNTRIES_UPDATE'),(65,'ROLE_MOD_TAB_ADMINCURRENCIES_CREATE'),(68,'ROLE_MOD_TAB_ADMINCURRENCIES_DELETE'),(66,'ROLE_MOD_TAB_ADMINCURRENCIES_READ'),(67,'ROLE_MOD_TAB_ADMINCURRENCIES_UPDATE'),(69,'ROLE_MOD_TAB_ADMINCUSTOMERPREFERENCES_CREATE'),(72,'ROLE_MOD_TAB_ADMINCUSTOMERPREFERENCES_DELETE'),(70,'ROLE_MOD_TAB_ADMINCUSTOMERPREFERENCES_READ'),(71,'ROLE_MOD_TAB_ADMINCUSTOMERPREFERENCES_UPDATE'),(73,'ROLE_MOD_TAB_ADMINCUSTOMERS_CREATE'),(76,'ROLE_MOD_TAB_ADMINCUSTOMERS_DELETE'),(74,'ROLE_MOD_TAB_ADMINCUSTOMERS_READ'),(75,'ROLE_MOD_TAB_ADMINCUSTOMERS_UPDATE'),(77,'ROLE_MOD_TAB_ADMINCUSTOMERTHREADS_CREATE'),(80,'ROLE_MOD_TAB_ADMINCUSTOMERTHREADS_DELETE'),(78,'ROLE_MOD_TAB_ADMINCUSTOMERTHREADS_READ'),(79,'ROLE_MOD_TAB_ADMINCUSTOMERTHREADS_UPDATE'),(81,'ROLE_MOD_TAB_ADMINDASHBOARD_CREATE'),(84,'ROLE_MOD_TAB_ADMINDASHBOARD_DELETE'),(82,'ROLE_MOD_TAB_ADMINDASHBOARD_READ'),(83,'ROLE_MOD_TAB_ADMINDASHBOARD_UPDATE'),(465,'ROLE_MOD_TAB_ADMINDASHGOALS_CREATE'),(468,'ROLE_MOD_TAB_ADMINDASHGOALS_DELETE'),(466,'ROLE_MOD_TAB_ADMINDASHGOALS_READ'),(467,'ROLE_MOD_TAB_ADMINDASHGOALS_UPDATE'),(85,'ROLE_MOD_TAB_ADMINDELIVERYSLIP_CREATE'),(88,'ROLE_MOD_TAB_ADMINDELIVERYSLIP_DELETE'),(86,'ROLE_MOD_TAB_ADMINDELIVERYSLIP_READ'),(87,'ROLE_MOD_TAB_ADMINDELIVERYSLIP_UPDATE'),(89,'ROLE_MOD_TAB_ADMINEMAILS_CREATE'),(92,'ROLE_MOD_TAB_ADMINEMAILS_DELETE'),(90,'ROLE_MOD_TAB_ADMINEMAILS_READ'),(91,'ROLE_MOD_TAB_ADMINEMAILS_UPDATE'),(93,'ROLE_MOD_TAB_ADMINEMPLOYEES_CREATE'),(96,'ROLE_MOD_TAB_ADMINEMPLOYEES_DELETE'),(94,'ROLE_MOD_TAB_ADMINEMPLOYEES_READ'),(95,'ROLE_MOD_TAB_ADMINEMPLOYEES_UPDATE'),(97,'ROLE_MOD_TAB_ADMINFEATURES_CREATE'),(100,'ROLE_MOD_TAB_ADMINFEATURES_DELETE'),(98,'ROLE_MOD_TAB_ADMINFEATURES_READ'),(99,'ROLE_MOD_TAB_ADMINFEATURES_UPDATE'),(101,'ROLE_MOD_TAB_ADMINGENDERS_CREATE'),(104,'ROLE_MOD_TAB_ADMINGENDERS_DELETE'),(102,'ROLE_MOD_TAB_ADMINGENDERS_READ'),(103,'ROLE_MOD_TAB_ADMINGENDERS_UPDATE'),(105,'ROLE_MOD_TAB_ADMINGEOLOCATION_CREATE'),(108,'ROLE_MOD_TAB_ADMINGEOLOCATION_DELETE'),(106,'ROLE_MOD_TAB_ADMINGEOLOCATION_READ'),(107,'ROLE_MOD_TAB_ADMINGEOLOCATION_UPDATE'),(109,'ROLE_MOD_TAB_ADMINGROUPS_CREATE'),(112,'ROLE_MOD_TAB_ADMINGROUPS_DELETE'),(110,'ROLE_MOD_TAB_ADMINGROUPS_READ'),(111,'ROLE_MOD_TAB_ADMINGROUPS_UPDATE'),(113,'ROLE_MOD_TAB_ADMINIMAGES_CREATE'),(116,'ROLE_MOD_TAB_ADMINIMAGES_DELETE'),(114,'ROLE_MOD_TAB_ADMINIMAGES_READ'),(115,'ROLE_MOD_TAB_ADMINIMAGES_UPDATE'),(117,'ROLE_MOD_TAB_ADMINIMPORT_CREATE'),(120,'ROLE_MOD_TAB_ADMINIMPORT_DELETE'),(118,'ROLE_MOD_TAB_ADMINIMPORT_READ'),(119,'ROLE_MOD_TAB_ADMINIMPORT_UPDATE'),(121,'ROLE_MOD_TAB_ADMININFORMATION_CREATE'),(124,'ROLE_MOD_TAB_ADMININFORMATION_DELETE'),(122,'ROLE_MOD_TAB_ADMININFORMATION_READ'),(123,'ROLE_MOD_TAB_ADMININFORMATION_UPDATE'),(125,'ROLE_MOD_TAB_ADMININTERNATIONAL_CREATE'),(128,'ROLE_MOD_TAB_ADMININTERNATIONAL_DELETE'),(126,'ROLE_MOD_TAB_ADMININTERNATIONAL_READ'),(127,'ROLE_MOD_TAB_ADMININTERNATIONAL_UPDATE'),(129,'ROLE_MOD_TAB_ADMININVOICES_CREATE'),(132,'ROLE_MOD_TAB_ADMININVOICES_DELETE'),(130,'ROLE_MOD_TAB_ADMININVOICES_READ'),(131,'ROLE_MOD_TAB_ADMININVOICES_UPDATE'),(133,'ROLE_MOD_TAB_ADMINLANGUAGES_CREATE'),(136,'ROLE_MOD_TAB_ADMINLANGUAGES_DELETE'),(134,'ROLE_MOD_TAB_ADMINLANGUAGES_READ'),(135,'ROLE_MOD_TAB_ADMINLANGUAGES_UPDATE'),(137,'ROLE_MOD_TAB_ADMINLINKWIDGET_CREATE'),(140,'ROLE_MOD_TAB_ADMINLINKWIDGET_DELETE'),(138,'ROLE_MOD_TAB_ADMINLINKWIDGET_READ'),(139,'ROLE_MOD_TAB_ADMINLINKWIDGET_UPDATE'),(141,'ROLE_MOD_TAB_ADMINLOCALIZATION_CREATE'),(144,'ROLE_MOD_TAB_ADMINLOCALIZATION_DELETE'),(142,'ROLE_MOD_TAB_ADMINLOCALIZATION_READ'),(143,'ROLE_MOD_TAB_ADMINLOCALIZATION_UPDATE'),(145,'ROLE_MOD_TAB_ADMINLOGS_CREATE'),(148,'ROLE_MOD_TAB_ADMINLOGS_DELETE'),(146,'ROLE_MOD_TAB_ADMINLOGS_READ'),(147,'ROLE_MOD_TAB_ADMINLOGS_UPDATE'),(969,'ROLE_MOD_TAB_ADMINMAILTHEME_CREATE'),(972,'ROLE_MOD_TAB_ADMINMAILTHEME_DELETE'),(970,'ROLE_MOD_TAB_ADMINMAILTHEME_READ'),(971,'ROLE_MOD_TAB_ADMINMAILTHEME_UPDATE'),(149,'ROLE_MOD_TAB_ADMINMAINTENANCE_CREATE'),(152,'ROLE_MOD_TAB_ADMINMAINTENANCE_DELETE'),(150,'ROLE_MOD_TAB_ADMINMAINTENANCE_READ'),(151,'ROLE_MOD_TAB_ADMINMAINTENANCE_UPDATE'),(153,'ROLE_MOD_TAB_ADMINMANUFACTURERS_CREATE'),(156,'ROLE_MOD_TAB_ADMINMANUFACTURERS_DELETE'),(154,'ROLE_MOD_TAB_ADMINMANUFACTURERS_READ'),(155,'ROLE_MOD_TAB_ADMINMANUFACTURERS_UPDATE'),(157,'ROLE_MOD_TAB_ADMINMETA_CREATE'),(160,'ROLE_MOD_TAB_ADMINMETA_DELETE'),(158,'ROLE_MOD_TAB_ADMINMETA_READ'),(159,'ROLE_MOD_TAB_ADMINMETA_UPDATE'),(929,'ROLE_MOD_TAB_ADMINMODULESCATALOG_CREATE'),(932,'ROLE_MOD_TAB_ADMINMODULESCATALOG_DELETE'),(930,'ROLE_MOD_TAB_ADMINMODULESCATALOG_READ'),(931,'ROLE_MOD_TAB_ADMINMODULESCATALOG_UPDATE'),(925,'ROLE_MOD_TAB_ADMINMODULESMANAGE_CREATE'),(928,'ROLE_MOD_TAB_ADMINMODULESMANAGE_DELETE'),(926,'ROLE_MOD_TAB_ADMINMODULESMANAGE_READ'),(927,'ROLE_MOD_TAB_ADMINMODULESMANAGE_UPDATE'),(165,'ROLE_MOD_TAB_ADMINMODULESPOSITIONS_CREATE'),(168,'ROLE_MOD_TAB_ADMINMODULESPOSITIONS_DELETE'),(166,'ROLE_MOD_TAB_ADMINMODULESPOSITIONS_READ'),(167,'ROLE_MOD_TAB_ADMINMODULESPOSITIONS_UPDATE'),(169,'ROLE_MOD_TAB_ADMINMODULESSF_CREATE'),(172,'ROLE_MOD_TAB_ADMINMODULESSF_DELETE'),(170,'ROLE_MOD_TAB_ADMINMODULESSF_READ'),(171,'ROLE_MOD_TAB_ADMINMODULESSF_UPDATE'),(161,'ROLE_MOD_TAB_ADMINMODULES_CREATE'),(164,'ROLE_MOD_TAB_ADMINMODULES_DELETE'),(162,'ROLE_MOD_TAB_ADMINMODULES_READ'),(163,'ROLE_MOD_TAB_ADMINMODULES_UPDATE'),(173,'ROLE_MOD_TAB_ADMINORDERMESSAGE_CREATE'),(176,'ROLE_MOD_TAB_ADMINORDERMESSAGE_DELETE'),(174,'ROLE_MOD_TAB_ADMINORDERMESSAGE_READ'),(175,'ROLE_MOD_TAB_ADMINORDERMESSAGE_UPDATE'),(177,'ROLE_MOD_TAB_ADMINORDERPREFERENCES_CREATE'),(180,'ROLE_MOD_TAB_ADMINORDERPREFERENCES_DELETE'),(178,'ROLE_MOD_TAB_ADMINORDERPREFERENCES_READ'),(179,'ROLE_MOD_TAB_ADMINORDERPREFERENCES_UPDATE'),(181,'ROLE_MOD_TAB_ADMINORDERS_CREATE'),(184,'ROLE_MOD_TAB_ADMINORDERS_DELETE'),(182,'ROLE_MOD_TAB_ADMINORDERS_READ'),(183,'ROLE_MOD_TAB_ADMINORDERS_UPDATE'),(185,'ROLE_MOD_TAB_ADMINOUTSTANDING_CREATE'),(188,'ROLE_MOD_TAB_ADMINOUTSTANDING_DELETE'),(186,'ROLE_MOD_TAB_ADMINOUTSTANDING_READ'),(187,'ROLE_MOD_TAB_ADMINOUTSTANDING_UPDATE'),(189,'ROLE_MOD_TAB_ADMINPARENTATTRIBUTESGROUPS_CREATE'),(192,'ROLE_MOD_TAB_ADMINPARENTATTRIBUTESGROUPS_DELETE'),(190,'ROLE_MOD_TAB_ADMINPARENTATTRIBUTESGROUPS_READ'),(191,'ROLE_MOD_TAB_ADMINPARENTATTRIBUTESGROUPS_UPDATE'),(193,'ROLE_MOD_TAB_ADMINPARENTCARTRULES_CREATE'),(196,'ROLE_MOD_TAB_ADMINPARENTCARTRULES_DELETE'),(194,'ROLE_MOD_TAB_ADMINPARENTCARTRULES_READ'),(195,'ROLE_MOD_TAB_ADMINPARENTCARTRULES_UPDATE'),(197,'ROLE_MOD_TAB_ADMINPARENTCOUNTRIES_CREATE'),(200,'ROLE_MOD_TAB_ADMINPARENTCOUNTRIES_DELETE'),(198,'ROLE_MOD_TAB_ADMINPARENTCOUNTRIES_READ'),(199,'ROLE_MOD_TAB_ADMINPARENTCOUNTRIES_UPDATE'),(205,'ROLE_MOD_TAB_ADMINPARENTCUSTOMERPREFERENCES_CREATE'),(208,'ROLE_MOD_TAB_ADMINPARENTCUSTOMERPREFERENCES_DELETE'),(206,'ROLE_MOD_TAB_ADMINPARENTCUSTOMERPREFERENCES_READ'),(207,'ROLE_MOD_TAB_ADMINPARENTCUSTOMERPREFERENCES_UPDATE'),(209,'ROLE_MOD_TAB_ADMINPARENTCUSTOMERTHREADS_CREATE'),(212,'ROLE_MOD_TAB_ADMINPARENTCUSTOMERTHREADS_DELETE'),(210,'ROLE_MOD_TAB_ADMINPARENTCUSTOMERTHREADS_READ'),(211,'ROLE_MOD_TAB_ADMINPARENTCUSTOMERTHREADS_UPDATE'),(201,'ROLE_MOD_TAB_ADMINPARENTCUSTOMER_CREATE'),(204,'ROLE_MOD_TAB_ADMINPARENTCUSTOMER_DELETE'),(202,'ROLE_MOD_TAB_ADMINPARENTCUSTOMER_READ'),(203,'ROLE_MOD_TAB_ADMINPARENTCUSTOMER_UPDATE'),(213,'ROLE_MOD_TAB_ADMINPARENTEMPLOYEES_CREATE'),(216,'ROLE_MOD_TAB_ADMINPARENTEMPLOYEES_DELETE'),(214,'ROLE_MOD_TAB_ADMINPARENTEMPLOYEES_READ'),(215,'ROLE_MOD_TAB_ADMINPARENTEMPLOYEES_UPDATE'),(217,'ROLE_MOD_TAB_ADMINPARENTLOCALIZATION_CREATE'),(220,'ROLE_MOD_TAB_ADMINPARENTLOCALIZATION_DELETE'),(218,'ROLE_MOD_TAB_ADMINPARENTLOCALIZATION_READ'),(219,'ROLE_MOD_TAB_ADMINPARENTLOCALIZATION_UPDATE'),(965,'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_CREATE'),(968,'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_DELETE'),(966,'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_READ'),(967,'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_UPDATE'),(221,'ROLE_MOD_TAB_ADMINPARENTMANUFACTURERS_CREATE'),(224,'ROLE_MOD_TAB_ADMINPARENTMANUFACTURERS_DELETE'),(222,'ROLE_MOD_TAB_ADMINPARENTMANUFACTURERS_READ'),(223,'ROLE_MOD_TAB_ADMINPARENTMANUFACTURERS_UPDATE'),(229,'ROLE_MOD_TAB_ADMINPARENTMETA_CREATE'),(232,'ROLE_MOD_TAB_ADMINPARENTMETA_DELETE'),(230,'ROLE_MOD_TAB_ADMINPARENTMETA_READ'),(231,'ROLE_MOD_TAB_ADMINPARENTMETA_UPDATE'),(933,'ROLE_MOD_TAB_ADMINPARENTMODULESCATALOG_CREATE'),(936,'ROLE_MOD_TAB_ADMINPARENTMODULESCATALOG_DELETE'),(934,'ROLE_MOD_TAB_ADMINPARENTMODULESCATALOG_READ'),(935,'ROLE_MOD_TAB_ADMINPARENTMODULESCATALOG_UPDATE'),(225,'ROLE_MOD_TAB_ADMINPARENTMODULESSF_CREATE'),(228,'ROLE_MOD_TAB_ADMINPARENTMODULESSF_DELETE'),(226,'ROLE_MOD_TAB_ADMINPARENTMODULESSF_READ'),(227,'ROLE_MOD_TAB_ADMINPARENTMODULESSF_UPDATE'),(233,'ROLE_MOD_TAB_ADMINPARENTMODULES_CREATE'),(236,'ROLE_MOD_TAB_ADMINPARENTMODULES_DELETE'),(234,'ROLE_MOD_TAB_ADMINPARENTMODULES_READ'),(235,'ROLE_MOD_TAB_ADMINPARENTMODULES_UPDATE'),(237,'ROLE_MOD_TAB_ADMINPARENTORDERPREFERENCES_CREATE'),(240,'ROLE_MOD_TAB_ADMINPARENTORDERPREFERENCES_DELETE'),(238,'ROLE_MOD_TAB_ADMINPARENTORDERPREFERENCES_READ'),(239,'ROLE_MOD_TAB_ADMINPARENTORDERPREFERENCES_UPDATE'),(241,'ROLE_MOD_TAB_ADMINPARENTORDERS_CREATE'),(244,'ROLE_MOD_TAB_ADMINPARENTORDERS_DELETE'),(242,'ROLE_MOD_TAB_ADMINPARENTORDERS_READ'),(243,'ROLE_MOD_TAB_ADMINPARENTORDERS_UPDATE'),(245,'ROLE_MOD_TAB_ADMINPARENTPAYMENT_CREATE'),(248,'ROLE_MOD_TAB_ADMINPARENTPAYMENT_DELETE'),(246,'ROLE_MOD_TAB_ADMINPARENTPAYMENT_READ'),(247,'ROLE_MOD_TAB_ADMINPARENTPAYMENT_UPDATE'),(937,'ROLE_MOD_TAB_ADMINPARENTPAYPALCONFIGURATION_CREATE'),(940,'ROLE_MOD_TAB_ADMINPARENTPAYPALCONFIGURATION_DELETE'),(938,'ROLE_MOD_TAB_ADMINPARENTPAYPALCONFIGURATION_READ'),(939,'ROLE_MOD_TAB_ADMINPARENTPAYPALCONFIGURATION_UPDATE'),(249,'ROLE_MOD_TAB_ADMINPARENTPREFERENCES_CREATE'),(252,'ROLE_MOD_TAB_ADMINPARENTPREFERENCES_DELETE'),(250,'ROLE_MOD_TAB_ADMINPARENTPREFERENCES_READ'),(251,'ROLE_MOD_TAB_ADMINPARENTPREFERENCES_UPDATE'),(253,'ROLE_MOD_TAB_ADMINPARENTREQUESTSQL_CREATE'),(256,'ROLE_MOD_TAB_ADMINPARENTREQUESTSQL_DELETE'),(254,'ROLE_MOD_TAB_ADMINPARENTREQUESTSQL_READ'),(255,'ROLE_MOD_TAB_ADMINPARENTREQUESTSQL_UPDATE'),(257,'ROLE_MOD_TAB_ADMINPARENTSEARCHCONF_CREATE'),(260,'ROLE_MOD_TAB_ADMINPARENTSEARCHCONF_DELETE'),(258,'ROLE_MOD_TAB_ADMINPARENTSEARCHCONF_READ'),(259,'ROLE_MOD_TAB_ADMINPARENTSEARCHCONF_UPDATE'),(261,'ROLE_MOD_TAB_ADMINPARENTSHIPPING_CREATE'),(264,'ROLE_MOD_TAB_ADMINPARENTSHIPPING_DELETE'),(262,'ROLE_MOD_TAB_ADMINPARENTSHIPPING_READ'),(263,'ROLE_MOD_TAB_ADMINPARENTSHIPPING_UPDATE'),(265,'ROLE_MOD_TAB_ADMINPARENTSTOCKMANAGEMENT_CREATE'),(268,'ROLE_MOD_TAB_ADMINPARENTSTOCKMANAGEMENT_DELETE'),(266,'ROLE_MOD_TAB_ADMINPARENTSTOCKMANAGEMENT_READ'),(267,'ROLE_MOD_TAB_ADMINPARENTSTOCKMANAGEMENT_UPDATE'),(269,'ROLE_MOD_TAB_ADMINPARENTSTORES_CREATE'),(272,'ROLE_MOD_TAB_ADMINPARENTSTORES_DELETE'),(270,'ROLE_MOD_TAB_ADMINPARENTSTORES_READ'),(271,'ROLE_MOD_TAB_ADMINPARENTSTORES_UPDATE'),(273,'ROLE_MOD_TAB_ADMINPARENTTAXES_CREATE'),(276,'ROLE_MOD_TAB_ADMINPARENTTAXES_DELETE'),(274,'ROLE_MOD_TAB_ADMINPARENTTAXES_READ'),(275,'ROLE_MOD_TAB_ADMINPARENTTAXES_UPDATE'),(277,'ROLE_MOD_TAB_ADMINPARENTTHEMES_CREATE'),(280,'ROLE_MOD_TAB_ADMINPARENTTHEMES_DELETE'),(278,'ROLE_MOD_TAB_ADMINPARENTTHEMES_READ'),(279,'ROLE_MOD_TAB_ADMINPARENTTHEMES_UPDATE'),(285,'ROLE_MOD_TAB_ADMINPAYMENTPREFERENCES_CREATE'),(288,'ROLE_MOD_TAB_ADMINPAYMENTPREFERENCES_DELETE'),(286,'ROLE_MOD_TAB_ADMINPAYMENTPREFERENCES_READ'),(287,'ROLE_MOD_TAB_ADMINPAYMENTPREFERENCES_UPDATE'),(281,'ROLE_MOD_TAB_ADMINPAYMENT_CREATE'),(284,'ROLE_MOD_TAB_ADMINPAYMENT_DELETE'),(282,'ROLE_MOD_TAB_ADMINPAYMENT_READ'),(283,'ROLE_MOD_TAB_ADMINPAYMENT_UPDATE'),(941,'ROLE_MOD_TAB_ADMINPAYPALCONFIGURATION_CREATE'),(944,'ROLE_MOD_TAB_ADMINPAYPALCONFIGURATION_DELETE'),(942,'ROLE_MOD_TAB_ADMINPAYPALCONFIGURATION_READ'),(943,'ROLE_MOD_TAB_ADMINPAYPALCONFIGURATION_UPDATE'),(949,'ROLE_MOD_TAB_ADMINPAYPALCUSTOMIZECHECKOUT_CREATE'),(952,'ROLE_MOD_TAB_ADMINPAYPALCUSTOMIZECHECKOUT_DELETE'),(950,'ROLE_MOD_TAB_ADMINPAYPALCUSTOMIZECHECKOUT_READ'),(951,'ROLE_MOD_TAB_ADMINPAYPALCUSTOMIZECHECKOUT_UPDATE'),(953,'ROLE_MOD_TAB_ADMINPAYPALHELP_CREATE'),(956,'ROLE_MOD_TAB_ADMINPAYPALHELP_DELETE'),(954,'ROLE_MOD_TAB_ADMINPAYPALHELP_READ'),(955,'ROLE_MOD_TAB_ADMINPAYPALHELP_UPDATE'),(957,'ROLE_MOD_TAB_ADMINPAYPALLOGS_CREATE'),(960,'ROLE_MOD_TAB_ADMINPAYPALLOGS_DELETE'),(958,'ROLE_MOD_TAB_ADMINPAYPALLOGS_READ'),(959,'ROLE_MOD_TAB_ADMINPAYPALLOGS_UPDATE'),(961,'ROLE_MOD_TAB_ADMINPAYPALPROCESSLOGGER_CREATE'),(964,'ROLE_MOD_TAB_ADMINPAYPALPROCESSLOGGER_DELETE'),(962,'ROLE_MOD_TAB_ADMINPAYPALPROCESSLOGGER_READ'),(963,'ROLE_MOD_TAB_ADMINPAYPALPROCESSLOGGER_UPDATE'),(945,'ROLE_MOD_TAB_ADMINPAYPALSETUP_CREATE'),(948,'ROLE_MOD_TAB_ADMINPAYPALSETUP_DELETE'),(946,'ROLE_MOD_TAB_ADMINPAYPALSETUP_READ'),(947,'ROLE_MOD_TAB_ADMINPAYPALSETUP_UPDATE'),(289,'ROLE_MOD_TAB_ADMINPERFORMANCE_CREATE'),(292,'ROLE_MOD_TAB_ADMINPERFORMANCE_DELETE'),(290,'ROLE_MOD_TAB_ADMINPERFORMANCE_READ'),(291,'ROLE_MOD_TAB_ADMINPERFORMANCE_UPDATE'),(293,'ROLE_MOD_TAB_ADMINPPREFERENCES_CREATE'),(296,'ROLE_MOD_TAB_ADMINPPREFERENCES_DELETE'),(294,'ROLE_MOD_TAB_ADMINPPREFERENCES_READ'),(295,'ROLE_MOD_TAB_ADMINPPREFERENCES_UPDATE'),(297,'ROLE_MOD_TAB_ADMINPREFERENCES_CREATE'),(300,'ROLE_MOD_TAB_ADMINPREFERENCES_DELETE'),(298,'ROLE_MOD_TAB_ADMINPREFERENCES_READ'),(299,'ROLE_MOD_TAB_ADMINPREFERENCES_UPDATE'),(301,'ROLE_MOD_TAB_ADMINPRODUCTS_CREATE'),(304,'ROLE_MOD_TAB_ADMINPRODUCTS_DELETE'),(302,'ROLE_MOD_TAB_ADMINPRODUCTS_READ'),(303,'ROLE_MOD_TAB_ADMINPRODUCTS_UPDATE'),(305,'ROLE_MOD_TAB_ADMINPROFILES_CREATE'),(308,'ROLE_MOD_TAB_ADMINPROFILES_DELETE'),(306,'ROLE_MOD_TAB_ADMINPROFILES_READ'),(307,'ROLE_MOD_TAB_ADMINPROFILES_UPDATE'),(577,'ROLE_MOD_TAB_ADMINPSTHEMECUSTOADVANCED_CREATE'),(580,'ROLE_MOD_TAB_ADMINPSTHEMECUSTOADVANCED_DELETE'),(578,'ROLE_MOD_TAB_ADMINPSTHEMECUSTOADVANCED_READ'),(579,'ROLE_MOD_TAB_ADMINPSTHEMECUSTOADVANCED_UPDATE'),(573,'ROLE_MOD_TAB_ADMINPSTHEMECUSTOCONFIGURATION_CREATE'),(576,'ROLE_MOD_TAB_ADMINPSTHEMECUSTOCONFIGURATION_DELETE'),(574,'ROLE_MOD_TAB_ADMINPSTHEMECUSTOCONFIGURATION_READ'),(575,'ROLE_MOD_TAB_ADMINPSTHEMECUSTOCONFIGURATION_UPDATE'),(309,'ROLE_MOD_TAB_ADMINREFERRERS_CREATE'),(312,'ROLE_MOD_TAB_ADMINREFERRERS_DELETE'),(310,'ROLE_MOD_TAB_ADMINREFERRERS_READ'),(311,'ROLE_MOD_TAB_ADMINREFERRERS_UPDATE'),(313,'ROLE_MOD_TAB_ADMINREQUESTSQL_CREATE'),(316,'ROLE_MOD_TAB_ADMINREQUESTSQL_DELETE'),(314,'ROLE_MOD_TAB_ADMINREQUESTSQL_READ'),(315,'ROLE_MOD_TAB_ADMINREQUESTSQL_UPDATE'),(317,'ROLE_MOD_TAB_ADMINRETURN_CREATE'),(320,'ROLE_MOD_TAB_ADMINRETURN_DELETE'),(318,'ROLE_MOD_TAB_ADMINRETURN_READ'),(319,'ROLE_MOD_TAB_ADMINRETURN_UPDATE'),(321,'ROLE_MOD_TAB_ADMINSEARCHCONF_CREATE'),(324,'ROLE_MOD_TAB_ADMINSEARCHCONF_DELETE'),(322,'ROLE_MOD_TAB_ADMINSEARCHCONF_READ'),(323,'ROLE_MOD_TAB_ADMINSEARCHCONF_UPDATE'),(325,'ROLE_MOD_TAB_ADMINSEARCHENGINES_CREATE'),(328,'ROLE_MOD_TAB_ADMINSEARCHENGINES_DELETE'),(326,'ROLE_MOD_TAB_ADMINSEARCHENGINES_READ'),(327,'ROLE_MOD_TAB_ADMINSEARCHENGINES_UPDATE'),(329,'ROLE_MOD_TAB_ADMINSHIPPING_CREATE'),(332,'ROLE_MOD_TAB_ADMINSHIPPING_DELETE'),(330,'ROLE_MOD_TAB_ADMINSHIPPING_READ'),(331,'ROLE_MOD_TAB_ADMINSHIPPING_UPDATE'),(333,'ROLE_MOD_TAB_ADMINSHOPGROUP_CREATE'),(336,'ROLE_MOD_TAB_ADMINSHOPGROUP_DELETE'),(334,'ROLE_MOD_TAB_ADMINSHOPGROUP_READ'),(335,'ROLE_MOD_TAB_ADMINSHOPGROUP_UPDATE'),(337,'ROLE_MOD_TAB_ADMINSHOPURL_CREATE'),(340,'ROLE_MOD_TAB_ADMINSHOPURL_DELETE'),(338,'ROLE_MOD_TAB_ADMINSHOPURL_READ'),(339,'ROLE_MOD_TAB_ADMINSHOPURL_UPDATE'),(881,'ROLE_MOD_TAB_ADMINSIMPLICITYFBMESSAGING_CREATE'),(884,'ROLE_MOD_TAB_ADMINSIMPLICITYFBMESSAGING_DELETE'),(882,'ROLE_MOD_TAB_ADMINSIMPLICITYFBMESSAGING_READ'),(883,'ROLE_MOD_TAB_ADMINSIMPLICITYFBMESSAGING_UPDATE'),(341,'ROLE_MOD_TAB_ADMINSLIP_CREATE'),(344,'ROLE_MOD_TAB_ADMINSLIP_DELETE'),(342,'ROLE_MOD_TAB_ADMINSLIP_READ'),(343,'ROLE_MOD_TAB_ADMINSLIP_UPDATE'),(345,'ROLE_MOD_TAB_ADMINSPECIFICPRICERULE_CREATE'),(348,'ROLE_MOD_TAB_ADMINSPECIFICPRICERULE_DELETE'),(346,'ROLE_MOD_TAB_ADMINSPECIFICPRICERULE_READ'),(347,'ROLE_MOD_TAB_ADMINSPECIFICPRICERULE_UPDATE'),(349,'ROLE_MOD_TAB_ADMINSTATES_CREATE'),(352,'ROLE_MOD_TAB_ADMINSTATES_DELETE'),(350,'ROLE_MOD_TAB_ADMINSTATES_READ'),(351,'ROLE_MOD_TAB_ADMINSTATES_UPDATE'),(353,'ROLE_MOD_TAB_ADMINSTATS_CREATE'),(356,'ROLE_MOD_TAB_ADMINSTATS_DELETE'),(354,'ROLE_MOD_TAB_ADMINSTATS_READ'),(355,'ROLE_MOD_TAB_ADMINSTATS_UPDATE'),(357,'ROLE_MOD_TAB_ADMINSTATUSES_CREATE'),(360,'ROLE_MOD_TAB_ADMINSTATUSES_DELETE'),(358,'ROLE_MOD_TAB_ADMINSTATUSES_READ'),(359,'ROLE_MOD_TAB_ADMINSTATUSES_UPDATE'),(365,'ROLE_MOD_TAB_ADMINSTOCKCONFIGURATION_CREATE'),(368,'ROLE_MOD_TAB_ADMINSTOCKCONFIGURATION_DELETE'),(366,'ROLE_MOD_TAB_ADMINSTOCKCONFIGURATION_READ'),(367,'ROLE_MOD_TAB_ADMINSTOCKCONFIGURATION_UPDATE'),(369,'ROLE_MOD_TAB_ADMINSTOCKCOVER_CREATE'),(372,'ROLE_MOD_TAB_ADMINSTOCKCOVER_DELETE'),(370,'ROLE_MOD_TAB_ADMINSTOCKCOVER_READ'),(371,'ROLE_MOD_TAB_ADMINSTOCKCOVER_UPDATE'),(373,'ROLE_MOD_TAB_ADMINSTOCKINSTANTSTATE_CREATE'),(376,'ROLE_MOD_TAB_ADMINSTOCKINSTANTSTATE_DELETE'),(374,'ROLE_MOD_TAB_ADMINSTOCKINSTANTSTATE_READ'),(375,'ROLE_MOD_TAB_ADMINSTOCKINSTANTSTATE_UPDATE'),(377,'ROLE_MOD_TAB_ADMINSTOCKMANAGEMENT_CREATE'),(380,'ROLE_MOD_TAB_ADMINSTOCKMANAGEMENT_DELETE'),(378,'ROLE_MOD_TAB_ADMINSTOCKMANAGEMENT_READ'),(379,'ROLE_MOD_TAB_ADMINSTOCKMANAGEMENT_UPDATE'),(381,'ROLE_MOD_TAB_ADMINSTOCKMVT_CREATE'),(384,'ROLE_MOD_TAB_ADMINSTOCKMVT_DELETE'),(382,'ROLE_MOD_TAB_ADMINSTOCKMVT_READ'),(383,'ROLE_MOD_TAB_ADMINSTOCKMVT_UPDATE'),(361,'ROLE_MOD_TAB_ADMINSTOCK_CREATE'),(364,'ROLE_MOD_TAB_ADMINSTOCK_DELETE'),(362,'ROLE_MOD_TAB_ADMINSTOCK_READ'),(363,'ROLE_MOD_TAB_ADMINSTOCK_UPDATE'),(385,'ROLE_MOD_TAB_ADMINSTORES_CREATE'),(388,'ROLE_MOD_TAB_ADMINSTORES_DELETE'),(386,'ROLE_MOD_TAB_ADMINSTORES_READ'),(387,'ROLE_MOD_TAB_ADMINSTORES_UPDATE'),(389,'ROLE_MOD_TAB_ADMINSUPPLIERS_CREATE'),(392,'ROLE_MOD_TAB_ADMINSUPPLIERS_DELETE'),(390,'ROLE_MOD_TAB_ADMINSUPPLIERS_READ'),(391,'ROLE_MOD_TAB_ADMINSUPPLIERS_UPDATE'),(393,'ROLE_MOD_TAB_ADMINSUPPLYORDERS_CREATE'),(396,'ROLE_MOD_TAB_ADMINSUPPLYORDERS_DELETE'),(394,'ROLE_MOD_TAB_ADMINSUPPLYORDERS_READ'),(395,'ROLE_MOD_TAB_ADMINSUPPLYORDERS_UPDATE'),(397,'ROLE_MOD_TAB_ADMINTAGS_CREATE'),(400,'ROLE_MOD_TAB_ADMINTAGS_DELETE'),(398,'ROLE_MOD_TAB_ADMINTAGS_READ'),(399,'ROLE_MOD_TAB_ADMINTAGS_UPDATE'),(401,'ROLE_MOD_TAB_ADMINTAXES_CREATE'),(404,'ROLE_MOD_TAB_ADMINTAXES_DELETE'),(402,'ROLE_MOD_TAB_ADMINTAXES_READ'),(403,'ROLE_MOD_TAB_ADMINTAXES_UPDATE'),(405,'ROLE_MOD_TAB_ADMINTAXRULESGROUP_CREATE'),(408,'ROLE_MOD_TAB_ADMINTAXRULESGROUP_DELETE'),(406,'ROLE_MOD_TAB_ADMINTAXRULESGROUP_READ'),(407,'ROLE_MOD_TAB_ADMINTAXRULESGROUP_UPDATE'),(413,'ROLE_MOD_TAB_ADMINTHEMESCATALOG_CREATE'),(416,'ROLE_MOD_TAB_ADMINTHEMESCATALOG_DELETE'),(414,'ROLE_MOD_TAB_ADMINTHEMESCATALOG_READ'),(415,'ROLE_MOD_TAB_ADMINTHEMESCATALOG_UPDATE'),(569,'ROLE_MOD_TAB_ADMINTHEMESPARENT_CREATE'),(572,'ROLE_MOD_TAB_ADMINTHEMESPARENT_DELETE'),(570,'ROLE_MOD_TAB_ADMINTHEMESPARENT_READ'),(571,'ROLE_MOD_TAB_ADMINTHEMESPARENT_UPDATE'),(409,'ROLE_MOD_TAB_ADMINTHEMES_CREATE'),(412,'ROLE_MOD_TAB_ADMINTHEMES_DELETE'),(410,'ROLE_MOD_TAB_ADMINTHEMES_READ'),(411,'ROLE_MOD_TAB_ADMINTHEMES_UPDATE'),(417,'ROLE_MOD_TAB_ADMINTRACKING_CREATE'),(420,'ROLE_MOD_TAB_ADMINTRACKING_DELETE'),(418,'ROLE_MOD_TAB_ADMINTRACKING_READ'),(419,'ROLE_MOD_TAB_ADMINTRACKING_UPDATE'),(421,'ROLE_MOD_TAB_ADMINTRANSLATIONS_CREATE'),(424,'ROLE_MOD_TAB_ADMINTRANSLATIONS_DELETE'),(422,'ROLE_MOD_TAB_ADMINTRANSLATIONS_READ'),(423,'ROLE_MOD_TAB_ADMINTRANSLATIONS_UPDATE'),(425,'ROLE_MOD_TAB_ADMINWAREHOUSES_CREATE'),(428,'ROLE_MOD_TAB_ADMINWAREHOUSES_DELETE'),(426,'ROLE_MOD_TAB_ADMINWAREHOUSES_READ'),(427,'ROLE_MOD_TAB_ADMINWAREHOUSES_UPDATE'),(429,'ROLE_MOD_TAB_ADMINWEBSERVICE_CREATE'),(432,'ROLE_MOD_TAB_ADMINWEBSERVICE_DELETE'),(430,'ROLE_MOD_TAB_ADMINWEBSERVICE_READ'),(431,'ROLE_MOD_TAB_ADMINWEBSERVICE_UPDATE'),(433,'ROLE_MOD_TAB_ADMINZONES_CREATE'),(436,'ROLE_MOD_TAB_ADMINZONES_DELETE'),(434,'ROLE_MOD_TAB_ADMINZONES_READ'),(435,'ROLE_MOD_TAB_ADMINZONES_UPDATE'),(437,'ROLE_MOD_TAB_CONFIGURE_CREATE'),(440,'ROLE_MOD_TAB_CONFIGURE_DELETE'),(438,'ROLE_MOD_TAB_CONFIGURE_READ'),(439,'ROLE_MOD_TAB_CONFIGURE_UPDATE'),(441,'ROLE_MOD_TAB_IMPROVE_CREATE'),(444,'ROLE_MOD_TAB_IMPROVE_DELETE'),(442,'ROLE_MOD_TAB_IMPROVE_READ'),(443,'ROLE_MOD_TAB_IMPROVE_UPDATE'),(445,'ROLE_MOD_TAB_SELL_CREATE'),(448,'ROLE_MOD_TAB_SELL_DELETE'),(446,'ROLE_MOD_TAB_SELL_READ'),(447,'ROLE_MOD_TAB_SELL_UPDATE'),(449,'ROLE_MOD_TAB_SHOPPARAMETERS_CREATE'),(452,'ROLE_MOD_TAB_SHOPPARAMETERS_DELETE'),(450,'ROLE_MOD_TAB_SHOPPARAMETERS_READ'),(451,'ROLE_MOD_TAB_SHOPPARAMETERS_UPDATE');
/*!40000 ALTER TABLE `ps_authorization_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier`
--

DROP TABLE IF EXISTS `ps_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier` (
  `id_carrier` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_reference` int(10) unsigned NOT NULL,
  `id_tax_rules_group` int(10) unsigned DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `shipping_handling` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `range_behavior` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_module` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_free` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `shipping_external` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `need_range` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `external_module_name` varchar(64) DEFAULT NULL,
  `shipping_method` int(2) NOT NULL DEFAULT '0',
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `max_width` int(10) DEFAULT '0',
  `max_height` int(10) DEFAULT '0',
  `max_depth` int(10) DEFAULT '0',
  `max_weight` decimal(20,6) DEFAULT '0.000000',
  `grade` int(10) DEFAULT '0',
  `need_address` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '訂單明細顯示用途',
  PRIMARY KEY (`id_carrier`),
  KEY `deleted` (`deleted`,`active`),
  KEY `id_tax_rules_group` (`id_tax_rules_group`),
  KEY `reference` (`id_reference`,`deleted`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier`
--

LOCK TABLES `ps_carrier` WRITE;
/*!40000 ALTER TABLE `ps_carrier` DISABLE KEYS */;
INSERT INTO `ps_carrier` VALUES (101,101,0,'實體店','',1,0,0,0,0,1,0,0,'',1,0,0,0,0,0.000000,0,0),(102,102,0,'當面交易','',0,0,0,0,0,1,0,0,'',1,1,0,0,0,0.000000,3,0),(103,103,0,'7-11 取貨','',1,1,0,1,1,0,0,1,'smilepay_c2cup',2,2,45,30,30,5.000000,0,0),(104,104,0,'7-11 取貨付款','',1,1,0,1,1,0,0,1,'smilepay_c2c',2,3,45,30,30,5.000000,0,0),(105,105,0,'全家取貨','',1,1,0,1,1,0,0,1,'smilepay_c2cup',2,2,45,30,30,5.000000,0,0),(106,106,0,'全家取貨付款','',1,1,0,1,1,0,0,1,'smilepay_c2c',2,3,45,30,30,5.000000,0,0),(107,107,0,'黑貓宅配 常溫','',1,1,0,0,1,0,0,1,'smilepay_ezcatup',2,6,0,0,0,20.000000,1,1),(108,108,0,'黑貓宅配 冷藏','',1,1,0,0,1,0,0,1,'smilepay_ezcatup',2,7,0,0,0,20.000000,1,1),(109,109,0,'黑貓宅配 冷凍','',1,1,0,0,1,0,0,1,'smilepay_ezcatup',2,8,0,0,0,20.000000,1,1),(110,110,0,'黑貓貨到付現 常溫','',1,1,0,0,1,0,0,1,'smilepay_ezcat',2,9,0,0,0,20.000000,2,1),(111,111,0,'黑貓貨到付現 冷藏','',1,1,0,0,1,0,0,1,'smilepay_ezcat',2,10,0,0,0,0.000000,2,1),(112,112,0,'黑貓貨到付現 冷凍','',1,1,0,0,1,0,0,1,'smilepay_ezcat',2,11,0,0,0,20.000000,2,1),(113,113,0,'掌櫃取貨 常溫','',1,1,0,0,1,0,0,1,'smilepay_palmboxc2cup',2,12,31,34,41,20.000000,2,0),(114,114,0,'郵局 Chunghwa Post','',1,0,0,0,0,0,0,0,'',2,2,0,0,0,0.000000,1,1),(115,115,0,'ezShip OK超商 / 萊爾富 / 全家取貨','',1,0,0,1,1,0,1,1,'ezship',2,3,0,0,0,0.000000,0,0),(116,116,0,'ezShip 宅配','',1,0,1,1,1,0,1,1,'ezship_home',2,4,0,0,0,0.000000,0,1),(117,117,0,'綠界 711 取貨','',1,0,0,1,1,0,1,1,'ecpay_711',2,5,0,0,0,0.000000,0,0),(118,118,0,'綠界 黑貓宅配','',1,0,0,1,1,0,1,1,'ecpay_tcat',2,6,0,0,0,0.000000,0,1),(119,119,0,'711 交貨便','',1,0,0,1,1,0,1,1,'tc_711',2,7,0,0,0,0.000000,0,0),(120,120,0,'宅配','',1,0,0,1,1,0,1,1,'tc_home',2,8,0,0,0,0.000000,0,0),(121,121,0,'宅配 2','',1,0,0,1,1,0,1,1,'tc_home2',2,9,0,0,0,0.000000,0,0),(122,122,0,'宅配 3','',1,0,0,1,1,0,1,1,'tc_home3',2,10,0,0,0,0.000000,0,0);
/*!40000 ALTER TABLE `ps_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_group`
--

DROP TABLE IF EXISTS `ps_carrier_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_group` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_group`
--

LOCK TABLES `ps_carrier_group` WRITE;
/*!40000 ALTER TABLE `ps_carrier_group` DISABLE KEYS */;
INSERT INTO `ps_carrier_group` VALUES (101,1),(101,2),(101,3),(102,1),(102,2),(102,3),(103,1),(103,2),(103,3),(104,1),(104,2),(104,3),(105,1),(105,2),(105,3),(106,1),(106,2),(106,3),(107,1),(107,2),(107,3),(108,1),(108,2),(108,3),(109,1),(109,2),(109,3),(110,1),(110,2),(110,3),(111,1),(111,2),(111,3),(112,1),(112,2),(112,3),(113,1),(113,2),(113,3),(114,1),(114,2),(114,3),(115,1),(115,2),(115,3),(116,1),(116,2),(116,3),(117,1),(117,2),(117,3),(118,1),(118,2),(118,3),(119,1),(119,2),(119,3),(120,1),(120,2),(120,3),(121,1),(121,2),(121,3),(122,1),(122,2),(122,3);
/*!40000 ALTER TABLE `ps_carrier_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_lang`
--

DROP TABLE IF EXISTS `ps_carrier_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_lang` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_lang` int(10) unsigned NOT NULL,
  `delay` varchar(512) DEFAULT NULL,
  `shipped_email_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '已出貨通知信補充資訊',
  PRIMARY KEY (`id_lang`,`id_shop`,`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_lang`
--

LOCK TABLES `ps_carrier_lang` WRITE;
/*!40000 ALTER TABLE `ps_carrier_lang` DISABLE KEYS */;
INSERT INTO `ps_carrier_lang` VALUES (101,1,1,'店內取貨',''),(102,1,1,'限台北內湖南港，量大可送貨到府',''),(103,1,1,'先付款','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(104,1,1,'店內付款','預計 2 日送達指定門市。您可至 <a href=\"https://eservice.7-11.com.tw/\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(105,1,1,'先付款','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.famiport.com.tw/Web_Famiport/page/process.aspx\" target=\"_blank\">全家網站</a> 查看配送狀態。'),(106,1,1,'店內付款','預計 2 日送達指定門市。您可至 <a href=\"https://www.famiport.com.tw/Web_Famiport/page/process.aspx\" target=\"_blank\">全家網站</a> 查看配送狀態。'),(107,1,1,'2-3 天',''),(108,1,1,'2-3 天',''),(109,1,1,'2-3 天',''),(110,1,1,'2-3 天',''),(111,1,1,'2-3 天',''),(112,1,1,'2-3 天',''),(113,1,1,'2-3 天',''),(114,1,1,'2-3 天',''),(115,1,1,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,1,1,'2-3 天','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,1,1,'2-3 天',''),(118,1,1,'2-3 天',''),(119,1,1,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,1,1,'2-3 天',''),(121,1,1,'2-3 天',''),(122,1,1,'2-3 天',''),(101,2,1,'店內取貨',''),(102,2,1,'限台北內湖南港，量大可送貨到府',''),(114,2,1,'2-3 天',''),(115,2,1,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,2,1,'2-3 天','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,2,1,'2-3 天',''),(118,2,1,'2-3 天',''),(119,2,1,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,2,1,'2-3 天',''),(121,2,1,'2-3 天',''),(122,2,1,'2-3 天',''),(101,3,1,'店內取貨',''),(102,3,1,'限台北內湖南港，量大可送貨到府',''),(114,3,1,'2-3 天',''),(115,3,1,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,3,1,'2-3 天','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,3,1,'2-3 天',''),(118,3,1,'2-3 天',''),(119,3,1,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,3,1,'2-3 天',''),(121,3,1,'2-3 天',''),(122,3,1,'2-3 天',''),(101,4,1,'店內取貨',''),(102,4,1,'限台北內湖南港，量大可送貨到府',''),(114,4,1,'2-3 天',''),(115,4,1,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,4,1,'2-3 天','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,4,1,'2-3 天',''),(118,4,1,'2-3 天',''),(119,4,1,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,4,1,'2-3 天',''),(121,4,1,'2-3 天',''),(122,4,1,'2-3 天',''),(101,1,2,'Pickup in-store',''),(102,1,2,'Taipei Only',''),(103,1,2,'Payment in Advance',''),(104,1,2,'Payment on Pickup',''),(105,1,2,'Payment in Advance',''),(106,1,2,'Payment on Pickup',''),(107,1,2,'Home Delivery',''),(108,1,2,'Home Delivery',''),(109,1,2,'Home Delivery',''),(110,1,2,'Payment on Delivery',''),(111,1,2,'Payment on Delivery',''),(112,1,2,'Payment on Delivery',''),(113,1,2,'2-3 days',''),(114,1,2,'Home Delivery',''),(115,1,2,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,1,2,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,1,2,'2-3 天',''),(118,1,2,'2-3 天',''),(119,1,2,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,1,2,'2-3 天',''),(121,1,2,'2-3 天',''),(122,1,2,'2-3 天',''),(101,2,2,'Pickup in-store',''),(102,2,2,'Taipei Only',''),(114,2,2,'Home Delivery',''),(115,2,2,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,2,2,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,2,2,'2-3 天',''),(118,2,2,'2-3 天',''),(119,2,2,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,2,2,'2-3 天',''),(121,2,2,'2-3 天',''),(122,2,2,'2-3 天',''),(101,3,2,'Pickup in-store',''),(102,3,2,'Taipei Only',''),(114,3,2,'Home Delivery',''),(115,3,2,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,3,2,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,3,2,'2-3 天',''),(118,3,2,'2-3 天',''),(119,3,2,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,3,2,'2-3 天',''),(121,3,2,'2-3 天',''),(122,3,2,'2-3 天',''),(101,4,2,'Pickup in-store',''),(102,4,2,'Taipei Only',''),(114,4,2,'Home Delivery',''),(115,4,2,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,4,2,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,4,2,'2-3 天',''),(118,4,2,'2-3 天',''),(119,4,2,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,4,2,'2-3 天',''),(121,4,2,'2-3 天',''),(122,4,2,'2-3 天',''),(101,1,3,'店内取货',''),(102,1,3,'限台北内湖南港，量大可送货到府',''),(103,1,3,'Payment in Advance',''),(104,1,3,'店内付款',''),(105,1,3,'Payment in Advance',''),(106,1,3,'店内付款',''),(107,1,3,'Home Delivery',''),(108,1,3,'Home Delivery',''),(109,1,3,'Home Delivery',''),(110,1,3,'Payment on delivery',''),(111,1,3,'Payment on delivery',''),(112,1,3,'Payment on delivery',''),(113,1,3,'2-3 days',''),(114,1,3,'Home Delivery',''),(115,1,3,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,1,3,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,1,3,'2-3 天',''),(118,1,3,'2-3 天',''),(119,1,3,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,1,3,'2-3 天',''),(121,1,3,'2-3 天',''),(122,1,3,'2-3 天',''),(101,2,3,'店内取货',''),(102,2,3,'限台北内湖南港，量大可送货到府',''),(114,2,3,'Home Delivery',''),(115,2,3,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,2,3,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,2,3,'2-3 天',''),(118,2,3,'2-3 天',''),(119,2,3,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,2,3,'2-3 天',''),(121,2,3,'2-3 天',''),(122,2,3,'2-3 天',''),(101,3,3,'店内取货',''),(102,3,3,'限台北内湖南港，量大可送货到府',''),(114,3,3,'Home Delivery',''),(115,3,3,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,3,3,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,3,3,'2-3 天',''),(118,3,3,'2-3 天',''),(119,3,3,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,3,3,'2-3 天',''),(121,3,3,'2-3 天',''),(122,3,3,'2-3 天',''),(101,4,3,'店内取货',''),(102,4,3,'限台北内湖南港，量大可送货到府',''),(114,4,3,'Home Delivery',''),(115,4,3,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,4,3,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,4,3,'2-3 天',''),(118,4,3,'2-3 天',''),(119,4,3,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,4,3,'2-3 天',''),(121,4,3,'2-3 天',''),(122,4,3,'2-3 天',''),(101,1,4,'店舗受取り',''),(102,1,4,'Taipei Only',''),(103,1,4,'Payment in Advance',''),(104,1,4,'Payment on Pickup',''),(105,1,4,'Payment in Advance',''),(106,1,4,'Payment on Pickup',''),(107,1,4,'Home Delivery',''),(108,1,4,'Home Delivery',''),(109,1,4,'Home Delivery',''),(110,1,4,'Payment on delivery',''),(111,1,4,'Payment on delivery',''),(112,1,4,'Payment on delivery',''),(113,1,4,'2-3 days',''),(114,1,4,'Home Delivery',''),(115,1,4,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,1,4,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,1,4,'2-3 天',''),(118,1,4,'2-3 天',''),(119,1,4,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,1,4,'2-3 天',''),(121,1,4,'2-3 天',''),(122,1,4,'2-3 天',''),(101,2,4,'店舗受取り',''),(102,2,4,'Taipei Only',''),(114,2,4,'Home Delivery',''),(115,2,4,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,2,4,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,2,4,'2-3 天',''),(118,2,4,'2-3 天',''),(119,2,4,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,2,4,'2-3 天',''),(121,2,4,'2-3 天',''),(122,2,4,'2-3 天',''),(101,3,4,'店舗受取り',''),(102,3,4,'Taipei Only',''),(114,3,4,'Home Delivery',''),(115,3,4,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,3,4,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,3,4,'2-3 天',''),(118,3,4,'2-3 天',''),(119,3,4,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,3,4,'2-3 天',''),(121,3,4,'2-3 天',''),(122,3,4,'2-3 天',''),(101,4,4,'店舗受取り',''),(102,4,4,'Taipei Only',''),(114,4,4,'Home Delivery',''),(115,4,4,'2-3 days','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(116,4,4,'2-3 days','預計 2 日送達，您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),(117,4,4,'2-3 天',''),(118,4,4,'2-3 天',''),(119,4,4,'2-3 天','預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://eservice.7-11.com.tw/e-tracking/search.aspx\" target=\"_blank\">7-11 網站</a> 查看配送狀態。'),(120,4,4,'2-3 天',''),(121,4,4,'2-3 天',''),(122,4,4,'2-3 天','');
/*!40000 ALTER TABLE `ps_carrier_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_shop`
--

DROP TABLE IF EXISTS `ps_carrier_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_shop` (
  `id_carrier` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_shop`
--

LOCK TABLES `ps_carrier_shop` WRITE;
/*!40000 ALTER TABLE `ps_carrier_shop` DISABLE KEYS */;
INSERT INTO `ps_carrier_shop` VALUES (101,1),(102,1),(103,1),(104,1),(105,1),(106,1),(107,1),(108,1),(109,1),(110,1),(111,1),(112,1),(113,1),(114,1),(115,1),(116,1),(117,1),(118,1),(119,1),(120,1),(121,1),(122,1),(123,1),(101,2),(102,2),(114,2),(115,2),(116,2),(117,2),(118,2),(119,2),(121,2),(122,2),(123,2),(101,3),(102,3),(114,3),(115,3),(116,3),(117,3),(118,3),(119,3),(121,3),(122,3),(123,3),(101,4),(102,4),(114,4),(115,4),(116,4),(117,4),(118,4),(119,4),(120,4),(121,4),(122,4);
/*!40000 ALTER TABLE `ps_carrier_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_tax_rules_group_shop`
--

DROP TABLE IF EXISTS `ps_carrier_tax_rules_group_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_tax_rules_group_shop` (
  `id_carrier` int(11) unsigned NOT NULL,
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_tax_rules_group`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_tax_rules_group_shop`
--

LOCK TABLES `ps_carrier_tax_rules_group_shop` WRITE;
/*!40000 ALTER TABLE `ps_carrier_tax_rules_group_shop` DISABLE KEYS */;
INSERT INTO `ps_carrier_tax_rules_group_shop` VALUES (101,0,1),(101,0,2),(101,0,3),(101,0,4),(102,0,1),(102,0,2),(102,0,3),(102,0,4),(103,0,1),(104,0,1),(105,0,1),(106,0,1),(107,0,1),(108,0,1),(109,0,1),(110,0,1),(111,0,1),(112,0,1),(113,0,1),(114,0,1),(114,0,2),(114,0,3),(114,0,4),(115,0,1),(115,0,2),(115,0,3),(115,0,4),(116,0,1),(116,0,2),(116,0,3),(116,0,4),(117,0,2),(117,0,3),(117,0,4),(118,0,2),(118,0,3),(118,0,4),(119,0,2),(119,0,3),(119,0,4),(120,0,1),(120,0,2),(120,0,3),(120,0,4),(121,0,1),(121,0,2),(121,0,3),(121,0,4),(122,0,1),(122,0,2),(122,0,3),(122,0,4);
/*!40000 ALTER TABLE `ps_carrier_tax_rules_group_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_carrier_zone`
--

DROP TABLE IF EXISTS `ps_carrier_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_carrier_zone` (
  `id_carrier` int(10) unsigned NOT NULL,
  `id_zone` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_carrier`,`id_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_carrier_zone`
--

LOCK TABLES `ps_carrier_zone` WRITE;
/*!40000 ALTER TABLE `ps_carrier_zone` DISABLE KEYS */;
INSERT INTO `ps_carrier_zone` VALUES (101,9),(102,9),(103,9),(104,9),(105,9),(106,9),(107,9),(108,9),(109,9),(110,9),(111,9),(112,9),(113,9),(114,9),(115,12),(116,9),(117,12),(118,9),(119,12),(120,9),(121,9),(122,9);
/*!40000 ALTER TABLE `ps_carrier_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart`
--

DROP TABLE IF EXISTS `ps_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart` (
  `id_cart` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned NOT NULL DEFAULT '1',
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_carrier` int(10) unsigned NOT NULL,
  `delivery_option` text NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_address_delivery` int(10) unsigned NOT NULL,
  `id_address_invoice` int(10) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_guest` int(10) unsigned NOT NULL,
  `secure_key` varchar(32) NOT NULL DEFAULT '-1',
  `recyclable` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `gift` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `gift_message` text,
  `mobile_theme` tinyint(1) NOT NULL DEFAULT '0',
  `allow_seperated_package` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `checkout_session_data` mediumtext,
  PRIMARY KEY (`id_cart`),
  KEY `cart_customer` (`id_customer`),
  KEY `id_address_delivery` (`id_address_delivery`),
  KEY `id_address_invoice` (`id_address_invoice`),
  KEY `id_carrier` (`id_carrier`),
  KEY `id_lang` (`id_lang`),
  KEY `id_currency` (`id_currency`),
  KEY `id_guest` (`id_guest`),
  KEY `id_shop_group` (`id_shop_group`),
  KEY `id_shop_2` (`id_shop`,`date_upd`),
  KEY `id_shop` (`id_shop`,`date_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart`
--

LOCK TABLES `ps_cart` WRITE;
/*!40000 ALTER TABLE `ps_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_cart_rule`
--

DROP TABLE IF EXISTS `ps_cart_cart_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_cart_rule` (
  `id_cart` int(10) unsigned NOT NULL,
  `id_cart_rule` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart`,`id_cart_rule`),
  KEY `id_cart_rule` (`id_cart_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_cart_rule`
--

LOCK TABLES `ps_cart_cart_rule` WRITE;
/*!40000 ALTER TABLE `ps_cart_cart_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cart_cart_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_product`
--

DROP TABLE IF EXISTS `ps_cart_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_product` (
  `id_cart` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_address_delivery` int(10) unsigned NOT NULL DEFAULT '0',
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `id_product_attribute` int(10) unsigned NOT NULL DEFAULT '0',
  `id_customization` int(10) unsigned NOT NULL DEFAULT '0',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_cart`,`id_product`,`id_product_attribute`,`id_customization`,`id_address_delivery`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_cart_order` (`id_cart`,`date_add`,`id_product`,`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_product`
--

LOCK TABLES `ps_cart_product` WRITE;
/*!40000 ALTER TABLE `ps_cart_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cart_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule`
--

DROP TABLE IF EXISTS `ps_cart_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule` (
  `id_cart_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) unsigned NOT NULL DEFAULT '0',
  `date_from` datetime NOT NULL,
  `date_to` datetime NOT NULL,
  `description` text,
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `quantity_per_user` int(10) unsigned NOT NULL DEFAULT '0',
  `priority` int(10) unsigned NOT NULL DEFAULT '1',
  `partial_use` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `code` varchar(254) NOT NULL,
  `minimum_amount` decimal(17,2) NOT NULL DEFAULT '0.00',
  `minimum_amount_tax` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_amount_currency` int(10) unsigned NOT NULL DEFAULT '0',
  `minimum_amount_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `country_restriction` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `carrier_restriction` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `group_restriction` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `cart_rule_restriction` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `product_restriction` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `shop_restriction` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `free_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `reduction_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `reduction_amount` decimal(17,2) NOT NULL DEFAULT '0.00',
  `reduction_tax` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reduction_currency` int(10) unsigned NOT NULL DEFAULT '0',
  `reduction_product` int(10) NOT NULL DEFAULT '0',
  `reduction_exclude_special` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `gift_product` int(10) unsigned NOT NULL DEFAULT '0',
  `gift_product_attribute` int(10) unsigned NOT NULL DEFAULT '0',
  `highlight` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_cart_rule`),
  KEY `id_customer` (`id_customer`,`active`,`date_to`),
  KEY `group_restriction` (`group_restriction`,`active`,`date_to`),
  KEY `id_customer_2` (`id_customer`,`active`,`highlight`,`date_to`),
  KEY `group_restriction_2` (`group_restriction`,`active`,`highlight`,`date_to`),
  KEY `date_from` (`date_from`),
  KEY `date_to` (`date_to`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule`
--

LOCK TABLES `ps_cart_rule` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule` DISABLE KEYS */;
INSERT INTO `ps_cart_rule` VALUES (1,0,'2018-07-15 17:00:00','2019-08-31 00:00:00','全館7折限量（ 20 次）優惠，一個客戶只可使用一次。',19,1,1,1,'2018july',0.00,0,1,0,0,0,0,0,0,0,0,30.00,0.00,0,1,0,0,0,0,0,1,'2018-07-15 17:47:33','2018-10-28 22:46:38'),(2,0,'2018-07-28 23:00:00','2019-08-31 00:00:00','可使用總次數 100，單一客戶可使用 1 次。',98,10,1,1,'',0.00,0,1,0,0,0,0,0,1,0,0,15.00,0.00,0,1,-2,0,0,0,0,1,'2018-07-28 23:31:06','2018-10-28 22:42:22'),(3,0,'2018-07-29 09:00:00','2022-12-31 00:00:00','會員專屬，立即加入會員，前 1000 名可獲得優惠折扣碼，現抵 100 元。',999,1,1,1,'newmember',0.00,0,1,0,0,0,1,0,0,0,0,0.00,100.00,0,1,0,0,0,0,0,1,'2018-07-29 09:25:31','2018-10-28 22:46:46'),(4,0,'2018-07-29 09:00:00','2019-08-31 00:00:00','',1,1,1,1,'',0.00,0,1,0,0,0,0,0,1,0,0,20.00,0.00,0,1,-2,0,0,0,0,1,'2018-07-29 09:33:07','2018-10-28 22:52:17'),(5,0,'2018-07-29 09:00:00','2019-08-31 00:00:00','',1,1,1,1,'',0.00,0,1,0,0,0,0,0,1,0,0,0.00,0.00,0,1,-2,0,8,0,0,1,'2018-07-29 09:34:45','2018-10-28 22:51:08');
/*!40000 ALTER TABLE `ps_cart_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_carrier`
--

DROP TABLE IF EXISTS `ps_cart_rule_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_carrier` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_carrier` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_carrier`
--

LOCK TABLES `ps_cart_rule_carrier` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_carrier` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cart_rule_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_combination`
--

DROP TABLE IF EXISTS `ps_cart_rule_combination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_combination` (
  `id_cart_rule_1` int(10) unsigned NOT NULL,
  `id_cart_rule_2` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule_1`,`id_cart_rule_2`),
  KEY `id_cart_rule_1` (`id_cart_rule_1`),
  KEY `id_cart_rule_2` (`id_cart_rule_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_combination`
--

LOCK TABLES `ps_cart_rule_combination` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_combination` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cart_rule_combination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_country`
--

DROP TABLE IF EXISTS `ps_cart_rule_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_country` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_country`
--

LOCK TABLES `ps_cart_rule_country` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_country` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cart_rule_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_group`
--

DROP TABLE IF EXISTS `ps_cart_rule_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_group` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_group`
--

LOCK TABLES `ps_cart_rule_group` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_group` DISABLE KEYS */;
INSERT INTO `ps_cart_rule_group` VALUES (3,3);
/*!40000 ALTER TABLE `ps_cart_rule_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_lang`
--

DROP TABLE IF EXISTS `ps_cart_rule_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_lang` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(254) NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_lang`
--

LOCK TABLES `ps_cart_rule_lang` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_lang` DISABLE KEYS */;
INSERT INTO `ps_cart_rule_lang` VALUES (1,1,'全館優惠折扣碼 7折 限 20 名'),(1,2,'折扣'),(1,3,'折扣'),(1,4,'折扣'),(2,1,'任選「移動記」 3 件 85 折'),(2,2,'示範 - 任選 3 件 85 折'),(2,3,'示範 - 任選 3 件 85 折'),(2,4,'示範 - 任選 3 件 85 折'),(3,1,'「加入會員」優惠券'),(3,2,'加入會員贈送優惠折扣碼 newmember'),(3,3,'加入會員贈送優惠折扣碼 newmember'),(3,4,'加入會員贈送優惠折扣碼 newmember'),(4,1,'任選「清水斷崖」分類商品 滿 2 件 8 折'),(4,2,'示範 - 指定分類多階層 滿1件8折'),(4,3,'示範 - 指定分類多階層 滿1件8折'),(4,4,'示範 - 指定分類多階層 滿1件8折'),(5,1,'任選「清水斷崖」分類商品 滿 5 件 送「七星潭」明信片'),(5,2,'示範 - 多階層 指定分類 滿 5 件 6 折'),(5,3,'示範 - 多階層 指定分類 滿 5 件 6 折'),(5,4,'示範 - 多階層 指定分類 滿 5 件 6 折');
/*!40000 ALTER TABLE `ps_cart_rule_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_product_rule`
--

DROP TABLE IF EXISTS `ps_cart_rule_product_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_product_rule` (
  `id_product_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product_rule_group` int(10) unsigned NOT NULL,
  `type` enum('products','categories','attributes','manufacturers','suppliers') NOT NULL,
  PRIMARY KEY (`id_product_rule`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_product_rule`
--

LOCK TABLES `ps_cart_rule_product_rule` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_product_rule` DISABLE KEYS */;
INSERT INTO `ps_cart_rule_product_rule` VALUES (54,54,'products'),(62,62,'categories'),(64,64,'categories');
/*!40000 ALTER TABLE `ps_cart_rule_product_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_product_rule_group`
--

DROP TABLE IF EXISTS `ps_cart_rule_product_rule_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_product_rule_group` (
  `id_product_rule_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cart_rule` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_product_rule_group`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_product_rule_group`
--

LOCK TABLES `ps_cart_rule_product_rule_group` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_product_rule_group` DISABLE KEYS */;
INSERT INTO `ps_cart_rule_product_rule_group` VALUES (54,2,3),(62,5,5),(64,4,2);
/*!40000 ALTER TABLE `ps_cart_rule_product_rule_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_product_rule_value`
--

DROP TABLE IF EXISTS `ps_cart_rule_product_rule_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_product_rule_value` (
  `id_product_rule` int(10) unsigned NOT NULL,
  `id_item` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product_rule`,`id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_product_rule_value`
--

LOCK TABLES `ps_cart_rule_product_rule_value` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_product_rule_value` DISABLE KEYS */;
INSERT INTO `ps_cart_rule_product_rule_value` VALUES (54,1),(54,2),(54,3),(54,4),(62,17),(64,17);
/*!40000 ALTER TABLE `ps_cart_rule_product_rule_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cart_rule_shop`
--

DROP TABLE IF EXISTS `ps_cart_rule_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cart_rule_shop` (
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_cart_rule`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cart_rule_shop`
--

LOCK TABLES `ps_cart_rule_shop` WRITE;
/*!40000 ALTER TABLE `ps_cart_rule_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cart_rule_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_category`
--

DROP TABLE IF EXISTS `ps_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category` (
  `id_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parent` int(10) unsigned NOT NULL,
  `id_shop_default` int(10) unsigned NOT NULL DEFAULT '1',
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `nleft` int(10) unsigned NOT NULL DEFAULT '0',
  `nright` int(10) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `is_root_category` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_category`),
  KEY `category_parent` (`id_parent`),
  KEY `nleftrightactive` (`nleft`,`nright`,`active`),
  KEY `level_depth` (`level_depth`),
  KEY `nright` (`nright`),
  KEY `activenleft` (`active`,`nleft`),
  KEY `activenright` (`active`,`nright`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_category`
--

LOCK TABLES `ps_category` WRITE;
/*!40000 ALTER TABLE `ps_category` DISABLE KEYS */;
INSERT INTO `ps_category` VALUES (1,0,1,0,1,30,1,'2018-07-11 22:32:49','2018-07-11 22:32:49',0,0),(2,1,1,1,2,29,1,'2018-07-11 22:32:49','2020-03-09 23:40:31',0,1),(3,2,1,2,27,28,0,'2019-06-25 20:46:57','2019-07-02 14:37:06',0,0),(7,2,1,2,3,6,1,'2018-07-11 22:32:49','2019-07-02 14:38:13',1,0),(8,2,1,2,7,16,1,'2018-07-11 22:32:49','2019-07-02 14:39:01',2,0),(9,8,1,3,8,9,1,'2018-07-11 22:32:49','2019-08-15 13:07:14',0,0),(10,8,1,3,10,11,1,'2018-07-11 22:32:49','2019-08-15 13:07:14',1,0),(11,8,1,3,12,13,1,'2018-07-11 22:32:49','2018-07-13 17:41:02',2,0),(12,8,1,3,14,15,1,'2018-07-11 22:32:49','2018-07-13 17:41:46',3,0),(13,7,1,3,4,5,1,'2018-07-11 22:32:49','2018-12-09 23:24:35',0,0),(14,2,1,2,17,26,1,'2018-07-11 22:32:49','2019-12-27 16:26:31',3,0),(15,14,1,3,18,23,1,'2018-07-11 22:32:49','2019-12-27 20:25:46',0,0),(16,15,1,4,19,20,1,'2018-07-11 22:32:49','2018-07-13 17:47:03',0,0),(17,15,1,4,21,22,1,'2018-07-11 22:32:49','2018-07-13 17:48:50',1,0),(18,14,1,3,24,25,1,'2018-07-11 22:32:49','2019-03-20 23:51:47',1,0);
/*!40000 ALTER TABLE `ps_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_category_group`
--

DROP TABLE IF EXISTS `ps_category_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_group` (
  `id_category` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_category`,`id_group`),
  KEY `id_category` (`id_category`),
  KEY `id_group` (`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_category_group`
--

LOCK TABLES `ps_category_group` WRITE;
/*!40000 ALTER TABLE `ps_category_group` DISABLE KEYS */;
INSERT INTO `ps_category_group` VALUES (2,1),(2,2),(2,3),(3,1),(3,2),(3,3),(7,1),(7,2),(7,3),(8,1),(8,2),(8,3),(9,1),(9,2),(9,3),(10,1),(10,2),(10,3),(11,1),(11,2),(11,3),(12,1),(12,2),(12,3),(13,1),(13,2),(13,3),(14,1),(14,2),(14,3),(15,1),(15,2),(15,3),(16,1),(16,2),(16,3),(17,1),(17,2),(17,3),(18,1),(18,2),(18,3);
/*!40000 ALTER TABLE `ps_category_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_category_lang`
--

DROP TABLE IF EXISTS `ps_category_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_lang` (
  `id_category` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `link_rewrite` varchar(128) NOT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id_category`,`id_shop`,`id_lang`),
  KEY `category_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_category_lang`
--

LOCK TABLES `ps_category_lang` WRITE;
/*!40000 ALTER TABLE `ps_category_lang` DISABLE KEYS */;
INSERT INTO `ps_category_lang` VALUES (1,1,1,'Root','','root','','',''),(1,1,2,'Root','','root','','',''),(1,1,3,'Root','','root','','',''),(1,1,4,'ルート','','ルート','','',''),(1,2,1,'Root','','root','','',''),(1,2,2,'Root','','root','','',''),(1,2,3,'Root','','root','','',''),(1,2,4,'ルート','','ルート','','',''),(1,3,1,'Root','','root','','',''),(1,3,2,'Root','','root','','',''),(1,3,3,'Root','','root','','',''),(1,3,4,'ルート','','ルート','','',''),(1,4,1,'Root','','root','','',''),(1,4,2,'Root','','root','','',''),(1,4,3,'Root','','root','','',''),(1,4,4,'ルート','','ルート','','',''),(2,1,1,'所有商品','','all','','',''),(2,1,2,'All Products','','all','','',''),(2,1,3,'所有商品','','all','','',''),(2,1,4,'All Products','','all','','',''),(2,2,1,'所有商品','','all','','',''),(2,2,2,'All Products','','all','','',''),(2,2,3,'所有商品','','all','','',''),(2,2,4,'All Products','','all','','',''),(2,3,1,'所有商品','','all','','',''),(2,3,2,'All Products','','all','','',''),(2,3,3,'所有商品','','all','','',''),(2,3,4,'All Products','','all','','',''),(2,4,1,'所有商品','','all','','',''),(2,4,2,'All Products','','all','','',''),(2,4,3,'所有商品','','all','','',''),(2,4,4,'All Products','','all','','',''),(3,1,1,'系列','','collection','','',''),(3,1,2,'系列','','collection','','',''),(3,1,3,'系列','','collection','','',''),(3,1,4,'系列','','collection','','',''),(3,2,1,'系列','','collection','','',''),(3,2,2,'系列','','collection','','',''),(3,2,3,'系列','','collection','','',''),(3,2,4,'系列','','collection','','',''),(3,3,1,'系列','','collection','','',''),(3,3,2,'系列','','collection','','',''),(3,3,3,'系列','','collection','','',''),(3,3,4,'系列','','collection','','',''),(3,4,1,'系列','','collection','','',''),(3,4,2,'系列','','collection','','',''),(3,4,3,'系列','','collection','','',''),(3,4,4,'系列','','collection','','',''),(7,1,1,'作品','','project','','',''),(7,1,2,'Project','','project','','',''),(7,1,3,'作品','','project','','',''),(7,1,4,'作品','','project','','',''),(7,2,1,'作品','','project','','',''),(7,2,2,'Project','','project','','',''),(7,2,3,'作品','','project','','',''),(7,2,4,'Project','','project','','',''),(7,3,1,'作品','','project','','',''),(7,3,2,'Project','','project','','',''),(7,3,3,'作品','','project','','',''),(7,3,4,'Project','','project','','',''),(7,4,1,'作品','','project','','',''),(7,4,2,'Project','','project','','',''),(7,4,3,'作品','','project','','',''),(7,4,4,'Project','','project','','',''),(8,1,1,'衍生品','','souvenir','','',''),(8,1,2,'Souvenir','','souvenir','','',''),(8,1,3,'衍生品','','souvenir','','',''),(8,1,4,'アートグッズ','','souvenir','','',''),(8,2,1,'衍生品','','souvenir','','',''),(8,2,2,'Souvenir','','souvenir','','',''),(8,2,3,'衍生品','','souvenir','','',''),(8,2,4,'Souvenir','','souvenir','','',''),(8,3,1,'衍生品','','souvenir','','',''),(8,3,2,'Souvenir','','souvenir','','',''),(8,3,3,'衍生品','','souvenir','','',''),(8,3,4,'Souvenir','','souvenir','','',''),(8,4,1,'衍生品','','souvenir','','',''),(8,4,2,'Souvenir','','souvenir','','',''),(8,4,3,'衍生品','','souvenir','','',''),(8,4,4,'Souvenir','','souvenir','','',''),(9,1,1,'明信片','','postcard','','',''),(9,1,2,'Postcard','','postcard','','',''),(9,1,3,'明信片','','postcard','','',''),(9,1,4,'Postcard','','postcard','','',''),(9,2,1,'明信片','','postcard','','',''),(9,2,2,'Postcard','','postcard','','',''),(9,2,3,'明信片','','postcard','','',''),(9,2,4,'Postcard','','postcard','','',''),(9,3,1,'明信片','','postcard','','',''),(9,3,2,'Postcard','','postcard','','',''),(9,3,3,'明信片','','postcard','','',''),(9,3,4,'Postcard','','postcard','','',''),(9,4,1,'明信片','','postcard','','',''),(9,4,2,'Postcard','','postcard','','',''),(9,4,3,'明信片','','postcard','','',''),(9,4,4,'Postcard','','postcard','','',''),(10,1,1,'紙膠帶','','tape','','',''),(10,1,2,'Tape','','tape','','',''),(10,1,3,'纸胶带','','tape','','',''),(10,1,4,'Tape','','tape','','',''),(10,2,1,'紙膠帶','','tape','','',''),(10,2,2,'Tape','','tape','','',''),(10,2,3,'纸胶带','','tape','','',''),(10,2,4,'Tape','','tape','','',''),(10,3,1,'紙膠帶','','tape','','',''),(10,3,2,'Tape','','tape','','',''),(10,3,3,'纸胶带','','tape','','',''),(10,3,4,'Tape','','tape','','',''),(10,4,1,'紙膠帶','','tape','','',''),(10,4,2,'Tape','','tape','','',''),(10,4,3,'纸胶带','','tape','','',''),(10,4,4,'Tape','','tape','','',''),(11,1,1,'瑜珈褲','','leggings','','',''),(11,1,2,'Leggings','','leggings','','',''),(11,1,3,'瑜珈裤','','leggings','','',''),(11,1,4,'Leggings','','leggings','','',''),(11,2,1,'瑜珈褲','','leggings','','',''),(11,2,2,'Leggings','','leggings','','',''),(11,2,3,'瑜珈裤','','leggings','','',''),(11,2,4,'Leggings','','leggings','','',''),(11,3,1,'瑜珈褲','','leggings','','',''),(11,3,2,'Leggings','','leggings','','',''),(11,3,3,'瑜珈裤','','leggings','','',''),(11,3,4,'Leggings','','leggings','','',''),(11,4,1,'瑜珈褲','','leggings','','',''),(11,4,2,'Leggings','','leggings','','',''),(11,4,3,'瑜珈裤','','leggings','','',''),(11,4,4,'Leggings','','leggings','','',''),(12,1,1,'戒指','','ring','','',''),(12,1,2,'Ring','','ring','','',''),(12,1,3,'戒指','','ring','','',''),(12,1,4,'Ring','','ring','','',''),(12,2,1,'戒指','','ring','','',''),(12,2,2,'Ring','','ring','','',''),(12,2,3,'戒指','','ring','','',''),(12,2,4,'Ring','','ring','','',''),(12,3,1,'戒指','','ring','','',''),(12,3,2,'Ring','','ring','','',''),(12,3,3,'戒指','','ring','','',''),(12,3,4,'Ring','','ring','','',''),(12,4,1,'戒指','','ring','','',''),(12,4,2,'Ring','','ring','','',''),(12,4,3,'戒指','','ring','','',''),(12,4,4,'Ring','','ring','','',''),(13,1,1,'藝術家的書','','artistsbook','','',''),(13,1,2,'Artists Book','','artistsbook','','',''),(13,1,3,'艺术家的书','','artistsbook','','',''),(13,1,4,'Artists Book','','artistsbook','','',''),(13,2,1,'藝術家的書','','artistsbook','','',''),(13,2,2,'Artists Book','','artistsbook','','',''),(13,2,3,'艺术家的书','','artistsbook','','',''),(13,2,4,'Artists Book','','artistsbook','','',''),(13,3,1,'藝術家的書','','artistsbook','','',''),(13,3,2,'Artists Book','','artistsbook','','',''),(13,3,3,'艺术家的书','','artistsbook','','',''),(13,3,4,'Artists Book','','artistsbook','','',''),(13,4,1,'藝術家的書','','artistsbook','','',''),(13,4,2,'Artists Book','','artistsbook','','',''),(13,4,3,'艺术家的书','','artistsbook','','',''),(13,4,4,'Artists Book','','artistsbook','','',''),(14,1,1,'台灣','','taiwan','','',''),(14,1,2,'Taiwan','','taiwan','','',''),(14,1,3,'台湾','','taiwan','','',''),(14,1,4,'台湾','','taiwan','','',''),(14,2,1,'台灣','','taiwan','','',''),(14,2,2,'Taiwan','','taiwan','','',''),(14,2,3,'台湾','','taiwan','','',''),(14,2,4,'台湾','','taiwan','','',''),(14,3,1,'台灣','','taiwan','','',''),(14,3,2,'Taiwan','','taiwan','','',''),(14,3,3,'台湾','','taiwan','','',''),(14,3,4,'台湾','','taiwan','','',''),(14,4,1,'台灣','','taiwan','','',''),(14,4,2,'Taiwan','','taiwan','','',''),(14,4,3,'台湾','','taiwan','','',''),(14,4,4,'台湾','','taiwan','','',''),(15,1,1,'花蓮','','hualien','','',''),(15,1,2,'Hualien','<p><span style=\"color:#444444;font-family:\'Helvetica Neue\', Helvetica, Arial, \'PingFang TC\', \'Heiti TC\', \'微軟正黑體\', \'Microsoft JhengHei\', \'Noto Sans T Chinese\', \'Droid Sans Fallback\', sans-serif;font-size:14px;font-weight:600;\">▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓</span></p>','hualien','','',''),(15,1,3,'花莲','','hualien','','',''),(15,1,4,'花蓮','','hualien','','',''),(15,2,1,'花蓮','','hualien','','',''),(15,2,2,'Hualien','<p><span style=\"color:#444444;font-family:\'Helvetica Neue\', Helvetica, Arial, \'PingFang TC\', \'Heiti TC\', \'微軟正黑體\', \'Microsoft JhengHei\', \'Noto Sans T Chinese\', \'Droid Sans Fallback\', sans-serif;font-size:14px;font-weight:600;\">▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓</span></p>','hualien','','',''),(15,2,3,'花莲','','hualien','','',''),(15,2,4,'花蓮','','hualien','','',''),(15,3,1,'花蓮','','hualien','','',''),(15,3,2,'Hualien','<p><span style=\"color:#444444;font-family:\'Helvetica Neue\', Helvetica, Arial, \'PingFang TC\', \'Heiti TC\', \'微軟正黑體\', \'Microsoft JhengHei\', \'Noto Sans T Chinese\', \'Droid Sans Fallback\', sans-serif;font-size:14px;font-weight:600;\">▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓</span></p>','hualien','','',''),(15,3,3,'花莲','','hualien','','',''),(15,3,4,'花蓮','','hualien','','',''),(15,4,1,'花蓮','','hualien','','',''),(15,4,2,'Hualien','<p><span style=\"color:#444444;font-family:\'Helvetica Neue\', Helvetica, Arial, \'PingFang TC\', \'Heiti TC\', \'微軟正黑體\', \'Microsoft JhengHei\', \'Noto Sans T Chinese\', \'Droid Sans Fallback\', sans-serif;font-size:14px;font-weight:600;\">▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓</span></p>','hualien','','',''),(15,4,3,'花莲','','hualien','','',''),(15,4,4,'花蓮','','hualien','','',''),(16,1,1,'七星潭','','chihsingtan','','',''),(16,1,2,'Chihsingtan','','chihsingtan','','',''),(16,1,3,'七星潭','','chihsingtan','','',''),(16,1,4,'七星潭','','chihsingtan','','',''),(16,2,1,'七星潭','','chihsingtan','','',''),(16,2,2,'Chihsingtan','','chihsingtan','','',''),(16,2,3,'七星潭','','chihsingtan','','',''),(16,2,4,'七星潭','','chihsingtan','','',''),(16,3,1,'七星潭','','chihsingtan','','',''),(16,3,2,'Chihsingtan','','chihsingtan','','',''),(16,3,3,'七星潭','','chihsingtan','','',''),(16,3,4,'七星潭','','chihsingtan','','',''),(16,4,1,'七星潭','','chihsingtan','','',''),(16,4,2,'Chihsingtan','','chihsingtan','','',''),(16,4,3,'七星潭','','chihsingtan','','',''),(16,4,4,'七星潭','','chihsingtan','','',''),(17,1,1,'清水斷崖','','chingshuicliff','','',''),(17,1,2,'Chingshui Cliff','','chingshuicliff','','',''),(17,1,3,'清水断崖','','chingshuicliff','','',''),(17,1,4,'清水斷崖','','chingshuicliff','','',''),(17,2,1,'清水斷崖','','chingshuicliff','','',''),(17,2,2,'Chingshui Cliff','','chingshuicliff','','',''),(17,2,3,'清水断崖','','chingshuicliff','','',''),(17,2,4,'清水斷崖','','chingshuicliff','','',''),(17,3,1,'清水斷崖','','chingshuicliff','','',''),(17,3,2,'Chingshui Cliff','','chingshuicliff','','',''),(17,3,3,'清水断崖','','chingshuicliff','','',''),(17,3,4,'清水斷崖','','chingshuicliff','','',''),(17,4,1,'清水斷崖','','chingshuicliff','','',''),(17,4,2,'Chingshui Cliff','','chingshuicliff','','',''),(17,4,3,'清水断崖','','chingshuicliff','','',''),(17,4,4,'清水斷崖','','chingshuicliff','','',''),(18,1,1,'九份','','jiufen','','',''),(18,1,2,'Jiufen','','jiufen','','',''),(18,1,3,'九份','','jiufen','','',''),(18,1,4,'九份','','jiufen','','',''),(18,2,1,'九份','','九份','','',''),(18,2,2,'Jiufen','','jiufen','','',''),(18,2,3,'九份','','jiufen','','',''),(18,2,4,'九份','','jiufen','','',''),(18,3,1,'九份','','九份','','',''),(18,3,2,'Jiufen','','jiufen','','',''),(18,3,3,'九份','','jiufen','','',''),(18,3,4,'九份','','jiufen','','',''),(18,4,1,'九份','','九份','','',''),(18,4,2,'Jiufen','','jiufen','','',''),(18,4,3,'九份','','jiufen','','',''),(18,4,4,'九份','','jiufen','','','');
/*!40000 ALTER TABLE `ps_category_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_category_product`
--

DROP TABLE IF EXISTS `ps_category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_product` (
  `id_category` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_category`,`id_product`),
  KEY `id_product` (`id_product`),
  KEY `id_category` (`id_category`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_category_product`
--

LOCK TABLES `ps_category_product` WRITE;
/*!40000 ALTER TABLE `ps_category_product` DISABLE KEYS */;
INSERT INTO `ps_category_product` VALUES (2,1,0),(2,2,1),(2,3,2),(2,4,3),(2,5,4),(2,6,5),(2,8,6),(2,9,7),(2,10,8),(2,11,9),(2,12,10),(2,13,11),(2,14,12),(2,15,13),(9,6,0),(9,8,1),(10,9,0),(10,10,1),(10,11,2),(10,12,3),(11,13,0),(12,14,0),(12,15,1),(13,1,0),(13,2,1),(13,3,2),(13,4,3),(13,5,4),(16,3,0),(16,8,1),(16,9,2),(16,10,3),(16,14,4),(16,15,5),(17,6,0),(17,1,1),(17,3,2),(17,4,3),(17,5,4),(17,13,5),(18,11,0),(18,12,1),(18,2,2);
/*!40000 ALTER TABLE `ps_category_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_category_shop`
--

DROP TABLE IF EXISTS `ps_category_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_category_shop` (
  `id_category` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_category`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_category_shop`
--

LOCK TABLES `ps_category_shop` WRITE;
/*!40000 ALTER TABLE `ps_category_shop` DISABLE KEYS */;
INSERT INTO `ps_category_shop` VALUES (1,1,0),(1,2,0),(1,3,0),(1,4,0),(2,1,0),(2,2,0),(2,3,0),(2,4,0),(3,1,0),(3,2,1),(3,3,1),(3,4,1),(7,1,1),(8,1,2),(9,1,0),(10,1,1),(11,1,2),(12,1,3),(13,1,0),(14,1,3),(15,1,0),(16,1,0),(17,1,1),(18,1,1);
/*!40000 ALTER TABLE `ps_category_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms`
--

DROP TABLE IF EXISTS `ps_cms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms` (
  `id_cms` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cms_category` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `indexation` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_cms`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms`
--

LOCK TABLES `ps_cms` WRITE;
/*!40000 ALTER TABLE `ps_cms` DISABLE KEYS */;
INSERT INTO `ps_cms` VALUES (1,1,3,1,1),(2,1,5,1,1),(3,1,2,1,1),(4,1,0,1,1),(5,1,1,1,1),(6,1,4,1,1),(7,2,0,1,0);
/*!40000 ALTER TABLE `ps_cms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_category`
--

DROP TABLE IF EXISTS `ps_cms_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category` (
  `id_cms_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parent` int(10) unsigned NOT NULL,
  `level_depth` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cms_category`),
  KEY `category_parent` (`id_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_category`
--

LOCK TABLES `ps_cms_category` WRITE;
/*!40000 ALTER TABLE `ps_cms_category` DISABLE KEYS */;
INSERT INTO `ps_cms_category` VALUES (1,0,1,1,'2018-07-11 11:57:33','2018-07-11 11:57:33',0),(2,1,2,1,'2018-10-09 22:35:30','2018-10-09 22:35:30',0);
/*!40000 ALTER TABLE `ps_cms_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_category_lang`
--

DROP TABLE IF EXISTS `ps_cms_category_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category_lang` (
  `id_cms_category` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `name` varchar(128) NOT NULL,
  `description` text,
  `link_rewrite` varchar(128) NOT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id_cms_category`,`id_shop`,`id_lang`),
  KEY `category_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_category_lang`
--

LOCK TABLES `ps_cms_category_lang` WRITE;
/*!40000 ALTER TABLE `ps_cms_category_lang` DISABLE KEYS */;
INSERT INTO `ps_cms_category_lang` VALUES (1,1,1,'首頁','','首頁','','',''),(1,2,1,'首页','','首页','','',''),(1,3,1,'首页','','首页','','',''),(1,4,1,'首页','','首页','','',''),(1,1,2,'首頁','','首頁','','',''),(1,2,2,'首页','','首页','','',''),(1,3,2,'首页','','首页','','',''),(1,4,2,'首页','','首页','','',''),(1,1,3,'首頁','','首頁','','',''),(1,2,3,'首页','','首页','','',''),(1,3,3,'首页','','首页','','',''),(1,4,3,'首页','','首页','','',''),(1,1,4,'首頁','','首頁','','',''),(1,2,4,'首页','','首页','','',''),(1,3,4,'首页','','首页','','',''),(1,4,4,'首页','','首页','','',''),(2,1,1,'頁面分類1','','cat1','','',''),(2,2,1,'頁面分類1','','cat1','','',''),(2,3,1,'頁面分類1','','cat1','','',''),(2,4,1,'頁面分類1','','cat1','','','');
/*!40000 ALTER TABLE `ps_cms_category_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_category_shop`
--

DROP TABLE IF EXISTS `ps_cms_category_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_category_shop` (
  `id_cms_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_cms_category`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_category_shop`
--

LOCK TABLES `ps_cms_category_shop` WRITE;
/*!40000 ALTER TABLE `ps_cms_category_shop` DISABLE KEYS */;
INSERT INTO `ps_cms_category_shop` VALUES (1,1),(2,1),(1,2),(1,3),(1,4);
/*!40000 ALTER TABLE `ps_cms_category_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_lang`
--

DROP TABLE IF EXISTS `ps_cms_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_lang` (
  `id_cms` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `head_seo_title` varchar(255) DEFAULT NULL,
  `meta_description` varchar(512) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `link_rewrite` varchar(128) NOT NULL,
  PRIMARY KEY (`id_cms`,`id_shop`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_lang`
--

LOCK TABLES `ps_cms_lang` WRITE;
/*!40000 ALTER TABLE `ps_cms_lang` DISABLE KEYS */;
INSERT INTO `ps_cms_lang` VALUES (1,1,1,'購物說明','','','','<h1 style=\"text-align:center;padding-bottom:20px;\">購物說明</h1>\n<h2>購物方式</h2>\n<p>《商店名稱》提供方便快速的購物方式。無需加入會員即可直接購物，也可以使用「Facebook 登入」綁定帳號，方便查詢訂單。</p>\n<h2>購物步驟教學</h2>\n<p>將商品加入購物車　➜　（若有折扣碼要先輸入） 前往結帳　➜　Facebook 登入 或 填寫收件人資料　➜　 填寫指定地址 或 選擇超商取貨門市　➜　選擇付款方式　➜　立即結帳　➜　看到「訂單編號」才算完成購買喔！</p>\n<h2>付款方式</h2>\n<ol>\n<li>銀行轉帳（請於 ___ 日內付款）</li>\n<li>貨到付款\n<ul>\n<li>包裹送達指定地址後，直接支付現金給宅配人員。</li>\n<li>超商門市取貨付款。</li>\n</ul>\n</li>\n<li>線上刷卡（本網站使用 速買配 SmilePay 第三方支付平台系統，VISA、MASTER 及 JCB 信用卡皆可使用。）</li>\n</ol>\n<p>提醒您：若貨到付款未取/拒收件或未至指定門巿取貨達 2 次以上，未來將無法使用貨到付款服務，僅開放銀行轉帳、信用卡結帳。</p>\n<h2>配送方式</h2>\n<ol>\n<li>送到指定地址</li>\n<li>超商門市取貨</li>\n</ol>\n<h2>出貨時間</h2>\n<p>今日下單，___ 個工作天出貨，不含例假日。</p>\n<h2>超商取貨時間</h2>\n<p>超商訂單為出貨後2日下午4點過後即可至門市取件。若您逾期未至門市取貨，商品將會被退回，商品亦無法重新配送。</p>\n<h2>運費規則</h2>\n<p>單筆訂單滿 ___ 元（限台灣地區），即可享有免運優惠。</p>\n<div style=\"min-width:700px;\">\n<table class=\"table table-striped table-bordered\">\n<tbody>\n<tr><th>運送方式</th><th>配送天數</th><th>適用地區</th><th>運費</th><th>免運門檻</th></tr>\n<tr>\n<td>實體店</td>\n<td></td>\n<td></td>\n<td>免運費</td>\n<td></td>\n</tr>\n<tr>\n<td>當面交易</td>\n<td></td>\n<td></td>\n<td>免運費</td>\n<td></td>\n</tr>\n<tr>\n<td>7-11 超商純取貨</td>\n<td>2-3天</td>\n<td>台灣</td>\n<td>$999 以下 = $60<br /> $1000~3999 = $30<br /> $4000 以上 停用</td>\n<td></td>\n</tr>\n<tr>\n<td>7-11 超商取貨付款</td>\n<td>2-3天</td>\n<td>台灣</td>\n<td>$999 以下 = $60<br /> $1000~19999 = $30<br /> $20000 以上 停用</td>\n<td></td>\n</tr>\n<tr>\n<td>全家超商純取貨</td>\n<td>2-3天</td>\n<td>台灣</td>\n<td>$999 以下 = $60<br /> $1000~3999 = $30<br /> $4000 以上 停用</td>\n<td></td>\n</tr>\n<tr>\n<td>全家超商取貨付款</td>\n<td>2-3天</td>\n<td>台灣</td>\n<td>$999 以下 = $60<br /> $1000~19999 = $30<br /> $20000 以上 停用</td>\n<td></td>\n</tr>\n<tr>\n<td>黑貓宅配(常溫)</td>\n<td>2-3天</td>\n<td>台灣</td>\n<td>$999 以下 = $150<br /> $1000~3499 = $120</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>黑貓宅配(冷藏/冷凍)</td>\n<td>2-3天</td>\n<td>台灣</td>\n<td>$999 以下 = $190<br /> $1000~3499 = $160</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>黑貓貨到付現(常溫)</td>\n<td>2-3天</td>\n<td>台灣</td>\n<td>$999 以下 = $180<br /> $1000~3499 = $150</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>黑貓貨到付現(冷藏/冷凍)</td>\n<td>2-3天</td>\n<td>台灣</td>\n<td>$999 以下 = $210<br /> $1000~3499 = $180</td>\n<td>$3500</td>\n</tr>\n</tbody>\n</table>\n</div>','guide'),(1,2,1,'Guide','','','','','guide'),(1,3,1,'Guide','','','','<h1 style=\"text-align:center;padding-bottom:20px;\">购物说明</h1>\n<h2>购物方式</h2>\n<p>《商店名称》提供方便快速的购物方式。无需加入会员即可直接购物，也可以使用「Facebook 登入」绑定帐号，方便查询订单。</p>\n<h2>购物步骤教学</h2>\n<p>将商品加入购物车　➜　（若有折扣码要先输入） 前往结帐　➜　Facebook 登入 或 填写收件人资料　➜　 填写指定地址 或 选择超商取货门市　➜　选择付款方式　➜　立即结帐　➜　看到「订单编号」才算完成购买喔！</p>\n<h2>付款方式</h2>\n<ol>\n<li>银行转帐（请于 ___ 日内付款）</li>\n<li>货到付款\n<ul>\n<li>包裹送达指定地址后，直接支付现金给宅配人员。</li>\n<li>超商门市取货付款。</li>\n</ul>\n</li>\n<li>线上刷卡（本网站使用 速买配 SmilePay 第三方支付平台系统，VISA、MASTER 及 JCB 信用卡皆可使用。）</li>\n</ol>\n<p>提醒您：若货到付款未取/拒收件或未至指定门巿取货达 2 次以上，未来将无法使用货到付款服务，仅开放银行转帐、信用卡结帐。</p>\n<h2>配送方式</h2>\n<ol>\n<li>送到指定地址</li>\n<li>超商门市取货</li>\n</ol>\n<h2>出货时间</h2>\n<p>今日下单，___ 个工作天出货，不含例假日。</p>\n<h2>超商取货时间</h2>\n<p>超商订单为出货后2日下午4点过后即可至门市取件。若您逾期未至门市取货，商品将会被退回，商品亦无法重新配送。</p>\n<h2>运费规则</h2>\n<p>单笔订单满 ___ 元（限台湾地区），即可享有免运优惠。</p>\n<div style=\"min-width:700px;\">\n<table class=\"table table-striped table-bordered\">\n<tbody>\n<tr><th>运送方式</th><th>配送天数</th><th>适用地区</th><th>运费</th><th>免运门槛</th></tr>\n<tr>\n<td>实体店</td>\n<td></td>\n<td></td>\n<td>免运费</td>\n<td></td>\n</tr>\n<tr>\n<td>当面交易</td>\n<td></td>\n<td></td>\n<td>免运费</td>\n<td></td>\n</tr>\n<tr>\n<td>7-11 超商纯取货</td>\n<td>2-3天</td>\n<td>台湾</td>\n<td>$999 以下 = $60<br /> $1000~3999 = $30<br /> $4000 以上 停用</td>\n<td></td>\n</tr>\n<tr>\n<td>7-11 超商取货付款</td>\n<td>2-3天</td>\n<td>台湾</td>\n<td>$999 以下 = $60<br /> $1000~19999 = $30<br /> $20000 以上 停用</td>\n<td></td>\n</tr>\n<tr>\n<td>全家超商纯取货</td>\n<td>2-3天</td>\n<td>台湾</td>\n<td>$999 以下 = $60<br /> $1000~3999 = $30<br /> $4000 以上 停用</td>\n<td></td>\n</tr>\n<tr>\n<td>全家超商取货付款</td>\n<td>2-3天</td>\n<td>台湾</td>\n<td>$999 以下 = $60<br /> $1000~19999 = $30<br /> $20000 以上 停用</td>\n<td></td>\n</tr>\n<tr>\n<td>黑猫宅配(常温)</td>\n<td>2-3天</td>\n<td>台湾</td>\n<td>$999 以下 = $150<br /> $1000~3499 = $120</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>黑猫宅配(冷藏/冷冻)</td>\n<td>2-3天</td>\n<td>台湾</td>\n<td>$999 以下 = $190<br /> $1000~3499 = $160</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>黑猫货到付现(常温)</td>\n<td>2-3天</td>\n<td>台湾</td>\n<td>$999 以下 = $180<br /> $1000~3499 = $150</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>黑猫货到付现(冷藏/冷冻)</td>\n<td>2-3天</td>\n<td>台湾</td>\n<td>$999 以下 = $210<br /> $1000~3499 = $180</td>\n<td>$3500</td>\n</tr>\n</tbody>\n</table>\n</div>','delivery'),(1,4,1,'お買い物方法','','','','<h1 style=\"text-align:center;padding-bottom:20px;\">お買い物方法</h1>\n<h2>ご注文方法について</h2>\n<p>《ショップ》をご利用の際に、お客様情報の登録はFacebookでアカウント作成していただくと、お客様情報を毎回入力する手間がなく、簡単にご注文いただけます。会員登録せずに《ショップ》をご利用いただける「ゲスト購入」もございます。</p>\n<h2>お買い物の流れ</h2>\n<p>カートに商品を追加する　➜　（クーポンをお持ちのお客様はクーポンコードを入力し【適用】を押す）購入手続きへ　➜　「Facebookでアカウント作成」をクリックし、ページに従いお客様情報をご登録ください。「ゲスト購入する」の場合はご購入者の情報などを入力してください。　➜　 ご購入者の住所を入力してください。或は、コンビニ受取り店舗を選択する　➜　お支払い方法を選択する　➜　レジに進む　➜　注文番号と注文完了画面が表示されましたら、お手続きは完了です！</p>\n<h2>お支払い方法</h2>\n<ol>\n<li>銀行振込 ＿＿日以内にお支払い下さい。</li>\n<li>代金引換\n<ul>\n<li>商品受け取り時に配達員に現金をお支払いください。</li>\n<li>コンビニ受取り時支払い</li>\n</ul>\n</li>\n<li>クレジットカード（当ショップは SmilePay (スマイルペイ) の決済システムを利用しています。VISA、MASTER、JCB カードがご利用いただけます。）</li>\n</ol>\n<p>代金引換の受取拒否やコンビニの受取可能期間を過ぎた場合、2回になると、代金引換とコンビニを受取りのサービスを利用できなくなります。銀行振込とクレジットカードでお支払い下さい。</p>\n<h2>配送方法</h2>\n<ol>\n<li>指定住所受取り</li>\n<li>コンビニ受取り</li>\n</ol>\n<h2>配送時間</h2>\n<p>ご注文日から＿日発送します。日曜日‧祝日は発送を行っておりませんので。</p>\n<h2>コンビニ受取りについて</h2>\n<p>商品発送後二日後の午後四時から、指定コンビニで受取り可能です。商品の受取可能期間を過ぎた場合、自動的に返送となりキャンセルの処理をいたします。再発送はお受けすることができません。</p>\n<h2>送料について</h2>\n<p>＿＿ 元以上の購入で送料無料です。（台湾のみ）</p>\n<div style=\"min-width:700px;\">\n<table class=\"table table-striped table-bordered\">\n<tbody>\n<tr><th>配送方法</th><th>配送日数</th><th>対象国‧地域</th><th>送料</th><th>送料無料サービス</th></tr>\n<tr>\n<td>店舗</td>\n<td></td>\n<td></td>\n<td>送料無料</td>\n<td></td>\n</tr>\n<tr>\n<td>手渡し</td>\n<td></td>\n<td></td>\n<td>送料無料</td>\n<td></td>\n</tr>\n<tr>\n<td>セブン‐イレブン受取り</td>\n<td>2-3日</td>\n<td>台湾</td>\n<td>$999 以下 = $60<br /> $1000~3999 = $30<br /> $4000 以上 利用できません</td>\n<td></td>\n</tr>\n<tr>\n<td>セブン‐イレブン店舗受取り時支払い</td>\n<td>2-3日</td>\n<td>台湾</td>\n<td>$999 以下 = $60<br /> $1000~19999 = $30<br /> $20000 以上 利用できません</td>\n<td></td>\n</tr>\n<tr>\n<td>ファミリーマート受取り</td>\n<td>2-3日</td>\n<td>台湾</td>\n<td>$999 以下 = $60<br /> $1000~3999 = $30<br /> $4000 以上 利用できません</td>\n<td></td>\n</tr>\n<tr>\n<td>ファミリーマート店舗受取り時支払い</td>\n<td>2-3日</td>\n<td>台湾</td>\n<td>$999 以下 = $60<br /> $1000~19999 = $30<br /> $20000 以上 利用できません</td>\n<td></td>\n</tr>\n<tr>\n<td>宅急便(クロネコ)【常温】</td>\n<td>2-3日</td>\n<td>台湾</td>\n<td>$999 以下 = $150<br /> $1000~3499 = $120</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>宅急便(クロネコ)【冷蔵/冷凍】</td>\n<td>2-3日</td>\n<td>台湾</td>\n<td>$999 以下 = $190<br /> $1000~3499 = $160</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>宅急便(クロネコ)‐代金引換【常温】</td>\n<td>2-3日</td>\n<td>台湾</td>\n<td>$999 以下 = $180<br /> $1000~3499 = $150</td>\n<td>$3500</td>\n</tr>\n<tr>\n<td>宅急便(クロネコ)‐代金引換【冷蔵/冷凍】</td>\n<td>2-3日</td>\n<td>台湾</td>\n<td>$999 以下 = $210<br /> $1000~3499 = $180</td>\n<td>$3500</td>\n</tr>\n</tbody>\n</table>\n</div>','guide'),(2,1,1,'銷售及退款','','','','<h1 class=\"text-xs-center\" style=\"padding-bottom:20px;\">銷售及退款</h1>\n<div class=\"card-block\" style=\"padding:30px;border:1px solid #666;border-radius:10px;\">\n<h3>鑑賞期</h3>\n<ul style=\"list-style:square;\">\n<li>根據消費者保護法規定，「商店名稱」提供您七日鑑賞期之權益。</li>\n<li>鑑賞期期間，僅限申請一次退貨免運費。</li>\n<li>鑑賞期非試用期，所退回商品（贈品、隨貨附件）必須為全新狀態且完整包裝。並請另加外包裝袋，避免破壞原包裝。</li>\n<li>食品與衛生用品若一經拆封則無法享有七日鑑賞之權益，還請體諒。</li>\n</ul>\n<h3>退貨</h3>\n<ul style=\"list-style:square;\">\n<li>若收到商品與訂單內容不符、運輸過程造成商品毀損，我們將以新品更換原則處理。</li>\n<li>如退回商品非全新狀態、配件不全，需請您自費郵資補件，煩請留意以免影響您的退貨權益。。</li>\n<li>如因個人因素退貨或超商未取次數累計2次，我們將保留是否接受訂單的權利。</li>\n</ul>\n<h3>折扣碼</h3>\n<ul style=\"list-style:square;\">\n<li>折扣碼一經使用後，若自行取消訂單、超過付款期限被取消，將無法再次使用且無法補發，請謹慎使用。</li>\n</ul>\n</div>','sales-and-refunds'),(2,2,1,'Sales & Refund','','','','<h1 class=\"text-xs-center\" style=\"padding-bottom:20px;\">銷售及退款</h1>\n<div class=\"card-block\" style=\"padding:30px;border:1px solid #666;border-radius:10px;\">\n<h3>鑑賞期</h3>\n<ul style=\"list-style:square;\">\n<li>根據消費者保護法規定，《商店名稱》提供您七日鑑賞期之權益。</li>\n<li>鑑賞期期間，僅限申請一次退貨免運費。</li>\n<li>鑑賞期非試用期，所退回商品（贈品、隨貨附件）必須為全新狀態且完整包裝。並請另加外包裝袋，避免破壞原包裝。</li>\n<li>食品與衛生用品若一經拆封則無法享有七日鑑賞之權益，還請體諒。</li>\n</ul>\n<h3>退貨</h3>\n<ul style=\"list-style:square;\">\n<li>若收到商品與訂單內容不符、運輸過程造成商品毀損，我們將以新品更換原則處理。</li>\n<li>如退回商品非全新狀態、配件不全，需請您自費郵資補件，煩請留意以免影響您的退貨權益。。</li>\n<li>如因個人因素退貨或超商未取次數累計2次，我們將保留是否接受訂單的權利。</li>\n</ul>\n<h3>折扣碼</h3>\n<ul style=\"list-style:square;\">\n<li>折扣碼一經使用後，若自行取消訂單、超過付款期限被取消，將無法再次使用且無法補發，請謹慎使用。</li>\n</ul>\n</div>','sales-and-refunds'),(2,3,1,'Sales & Refund','','','','<h1 class=\"text-xs-center\" style=\"padding-bottom:20px;\">销售及退款</h1>\n<div class=\"card-block\" style=\"padding:30px;border:1px solid #666;border-radius:10px;\">\n<h3>鑑赏期</h3>\n<ul style=\"list-style:square;\">\n<li>根据消费者保护法规定，《商店名称》提供您七日鑑赏期之权益。</li>\n<li>鑑赏期期间，仅限申请一次退货免运费。</li>\n<li>鑑赏期非试用期，所退回商品（赠品、随货附件）必须为全新状态且完整包装。并请另加外包装袋，避免破坏原包装。</li>\n<li>食品与卫生用品若一经拆封则无法享有七日鑑赏之权益，还请体谅。</li>\n</ul>\n<h3>退货</h3>\n<ul style=\"list-style:square;\">\n<li>若收到商品与订单内容不符、运输过程造成商品毁损，我们将以新品更换原则处理。</li>\n<li>如退回商品非全新状态、配件不全，需请您自费邮资补件，烦请留意以免影响您的退货权益。。</li>\n<li>如因个人因素退货或超商未取次数累计2次，我们将保留是否接受订单的权利。</li>\n</ul>\n<h3>折扣码</h3>\n<ul style=\"list-style:square;\">\n<li>折扣码一经使用后，若自行取消订单、超过付款期限被取消，将无法再次使用且无法补发，请谨慎使用。</li>\n</ul>\n</div>','sales-and-refunds'),(2,4,1,'ご返品／ご返金','','','','<h1 class=\"text-xs-center\" style=\"padding-bottom:20px;\">ご返品／ご返金</h1>\n<div class=\"card-block\" style=\"padding:30px;border:1px solid #666;border-radius:10px;\">\n<h3>鑑賞期について</h3>\n<ul style=\"list-style:square;\">\n<li>台湾の消費者契約法により、《商店名稱》は鑑賞期をご提供しています。(鑑賞期：商品のお受け取りより「７日以内」に一回のみ、返品の時、送料無料をご利用いただけます。)</li>\n<li>鑑賞期間（商品到着7日以内）、一回のみ、返品送料無料をご利用いただけます。</li>\n<li>鑑賞期間は無料体験期ではありません。返品希望の場合、必ず商品到着後7日以内にメール/お問い合わせにてご連絡ください。商品の同梱物は、お届けされた時の状態のままでお返し頂きますようお願い致します。（箱・タグ・保証書や説明書など）</li>\n<li>食品や下着、肌に触れる衛生商品など、開封済みの場合は鑑賞期をご利用いただけませんので、ご注意ください。</li>\n</ul>\n<h3>返品について</h3>\n<ul style=\"list-style:square;\">\n<li>ご注文頂きました商品に、発送されてから到着時において、破損や商品違いがあった場合、到着後7日間以内にご連絡頂きますようお願い致します。当ショップにて返品・交換などが必要と判断した場合、ご連絡申し上げます。</li>\n<li>使用済みやパッケージ(袋・箱等)や付属品を紛失・破損してしまった商品返品はお受けできない場合がありますので、ご注意ください。</li>\n<li>お客様のご都合による返品やコンビニの受取可能期間を過ぎたなど、2回になる場合はキャンセル扱いとなる事がありますので、ご注意ください。</li>\n</ul>\n<h3>クーポンについて</h3>\n<ul style=\"list-style:square;\">\n<li>ご注文後のキャンセル、お支払い期日を過ぎると自動キャンセルとなった注文に使用したクーポンの再発行はできません。</li>\n</ul>\n</div>','sales-and-refunds'),(3,1,1,'隱私權政策','','','','<h1 style=\"text-align:center;padding-bottom:20px;\">隱私權政策</h1>\n<div class=\"gray-light-bg\" style=\"padding:36px 54px;\">\n<p class=\"gray text-xs-right\">上次修改日期：2019年02月07日</p>\n<h2 class=\"heading-border\" style=\"margin-top:50px;padding-bottom:5px;\">I. 歡迎來到「商店名稱」</h2>\n<p>感謝您使用我們的產品和服務（以下簡稱「商店名稱」）。</p>\n<p>「商店名稱」非常重視您的隱私，以下聲明將幫助您了解，在您使用本網站所提供的各項服務時，「商店名稱」處理您個人資料的各項原則。</p>\n<p>這份文件將會隨著網站功能的擴充，而做適當地調整與變更。</p>\n<h2 class=\"heading-border\" style=\"margin-top:50px;padding-bottom:5px;\">II. 個人資料的收集與使用</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>單純的瀏覽，「商店名稱」並不會蒐集任何有關個人的身份資料。</li>\n<li>「商店名稱」所提供的會員服務，會依需求請您提供姓名、聯絡手機、E-Mail、通訊住址等個人真實資料。</li>\n<li>當您透過電子郵件或聯絡我們詢問相關業務問題時，我們會保存您的通訊記錄，僅作為與您聯絡之用。</li>\n<li>「商店名稱」有義務保護個人隱私，非經您本人同意不會自行修改或刪除任何個人資料。</li>\n<li>個人資料僅限於提供於我們的相關服務，不會提供給第三方進行行銷。</li>\n<li>提供第三方（例如：提供物流、金流之廠商）的資料，可能包括詳細聯絡資料等的資料，我們鼓勵您瞭解這些第三方的隱私權政策。</li>\n</ul>\n<h2 class=\"heading-border\" style=\"margin-top:50px;padding-bottom:5px;\">III. Cookie 及其他技術</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>我們使用「Cookie」，這類技術可協助我們更充分瞭解使用者行為。</li>\n<li>我們和大多數網站一樣，會自動收集部分資訊，這類資訊包括網路 IP 位址、瀏覽器類型及語言、日期/時間及點選資料。</li>\n</ul>\n<h2 class=\"heading-border\" style=\"margin-top:50px;padding-bottom:5px;\">IV. 保護個人資料</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>「商店名稱」網站服務都會在資料傳輸期間，使用加密技術來保護您的個人資料。</li>\n<li>當您使用《商店名稱》各項服務時，任何儲存於本網站上之資料，會受到完善保護，以保障您的個人資料安全。</li>\n</ul>\n<h2 class=\"heading-border\" style=\"margin-top:50px;padding-bottom:5px;\">V. 自我資料安全保護措施</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>請妥善保管您的任何個人資料，切勿將個人資料提供給任何第三人，以保障您的權益。</li>\n</ul>\n<h2 class=\"heading-border\" style=\"margin-top:50px;padding-bottom:5px;\">VI. 隱私權諮詢</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>若您對於本網站的隱私權有任何問題，歡迎您提供寶貴意見給我們。「商店名稱」將會努力在合理適當的範圍內改善您所提出的建議，以便提供您更完善的服務。</li>\n</ul>\n</div>','privacy'),(3,2,1,'Privacy','','','','','privacy'),(3,3,1,'Privacy','','','','','privacy'),(3,4,1,'プライバシーポリシー','','','','<h1 style=\"text-align:center;padding-bottom:20px;\">プライバシーポリシー</h1>\n<div style=\"padding:36px 54px;background-color:#f6f6f6;\">\n<p style=\"text-align:right;color:#7a7a7a;\">最終改訂日：2019年02月07日</p>\n<h2 style=\"margin-top:50px;padding-bottom:5px;border-bottom:1px solid #ddd;\">I. はじめに</h2>\n<p>《商店名稱》 (以下当ショップとします)は、お客様の個人情報保護の重要性について認識し、個人情報の保護に関する法律を遵守すると共に、 以下のプライバシーポリシーに従い、適切な取扱い及び保護に努めます。</p>\n<h2 style=\"margin-top:50px;padding-bottom:5px;border-bottom:1px solid #ddd;\">II. 個人情報の収集と利用</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>当ショップで利用する場合、アカウントで登録されていない方、情報収集はしておりません。</li>\n<li>当ショップで収集する個人情報はお名前、お電話番号、メールアドレスなどです。</li>\n<li>当ショップでは商品のご購入、お問合せをされた際にお客様の個人情報を収集することがございます。</li>\n<li>お客様がご本人の個人情報の照会、修正、削除などをご希望される場合には、ご本人であることを確認の上、対応させていただきます。</li>\n<li>お客様に関する情報は、第三者に販売する業務は行っておりません。</li>\n<li>お客様の選択により、当ショップで第三者(決済・送金サービスや配送業者など)のサービスを利用できるようにする場合もありますので、その取引に関連するお客様の情報を、法律の規定に従い当該第三者と共有（共同利用）または当該第三者に提供します。</li>\n</ul>\n<h2 style=\"margin-top:50px;padding-bottom:5px;border-bottom:1px solid #ddd;\">III. Cookie（クッキー）その他の技術の利用</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>当ショップのサービスは、Cookie及びこれに類する技術を利用することがあります。これらの技術は、当ショップのサービスの利用状況等の把握に役立ち、サービス向上に資するものです。</li>\n<li>Cookie（クッキー）とは、サーバーコンピュータからお客様のブラウザに送信され、お客様が使用しているコンピュータのハードディスクに蓄積される情報です。</li>\n</ul>\n<h2 style=\"margin-top:50px;padding-bottom:5px;border-bottom:1px solid #ddd;\">IV. 個人情報保護</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>お客様が送信される個人情報やクレジットカード番号は、SSLによって暗号化され、万一通信中に第三者の目に触れる事があった場合でも、内容を読み取ることができないようになっています。また、送信された情報がサーバー運用者に届くまでの間に、データが改ざんされないことが保証されます。</li>\n<li>SSLを利用する事でより安全に情報を送信する事が可能となりますので、安心してご利用いただくことができます。</li>\n</ul>\n<h2 style=\"margin-top:50px;padding-bottom:5px;border-bottom:1px solid #ddd;\">V. 個人情報の管理</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>当ショップでは、お客様よりご提供いただきました個人情報を厳重に保管、管理し、個人情報の漏洩、滅失、毀損を防止するため、必要かつ適切な安全管理措置を講じます。なお、個人情報は他人に教えないなど注意して大切に管理しましょう。</li>\n</ul>\n<h2 style=\"margin-top:50px;padding-bottom:5px;border-bottom:1px solid #ddd;\">VI. 継続的改善について</h2>\n<ul style=\"list-style:lower-roman;\">\n<li>当ショップは、個人情報等の取扱いを継続的に改善するよう努めます。個人情報の取扱いに対する苦情、ご相談及び当ショップの個人情報保護方針に関してのお問合わせに対して窓口を定め、適切に対応いたします。</li>\n</ul>\n</div>','privacy'),(4,1,1,'品牌故事','','','','<h3>品牌核心</h3>\n<p>請寫下你的品牌核心、與眾不同之處。</p>\n<hr />\n<h3>品牌願景</h3>\n<p>請寫下你的品牌願景、想帶給這個世界什麼改變。</p>\n<hr />\n<h3>品牌價值</h3>\n<p>請寫下你的理念、精神哲學。</p>\n<hr />\n<h3>數據報告</h3>\n<p>產品來源、規格細節、安全性、包裝材質，相關檢測都可以一一清楚詳細說明。</p>\n<hr />\n<h3>獲獎肯定</h3>\n<p>如果你有受到專業認證或是投票的肯定，也值得給讀者知道。</p>\n<hr />','about'),(4,2,1,'About','','','','<h3>Brand Core</h3>\n<p>請寫下你的品牌核心、與眾不同之處。</p>\n<hr />\n<h3>Brand Vision</h3>\n<p>請寫下你的品牌願景、想帶給這個世界什麼改變。</p>\n<hr />\n<h3>Brand Value</h3>\n<p>請寫下你的品牌價值、經營理念、企業哲學。</p>','about'),(4,3,1,'About','','','','','about'),(4,4,1,'ブランドについて','','','','','about'),(5,1,1,'最新消息','','','','<h1>最新消息</h1>\n<p></p>\n<h3>活動快訊</h3>\n<hr />\n<h3>一起做公益</h3>\n<hr />\n<h3>參展紀錄</h3>','news'),(5,2,1,'News','','','','<h3>Event</h3>\n<hr />\n<h3>Charity</h3>\n<hr />\n<h3>Exhibition</h3>','news'),(5,3,1,'News','','','','','news'),(5,4,1,'新着情報','','','','','news'),(6,1,1,'常見問題','','','','<h1 style=\"text-align:center;padding-bottom:20px;\">常見問題</h1>\n<ul class=\"faq\" style=\"list-style:none;padding-left:0;\">\n<li>\n<div class=\"q\">還有哪邊可以購買呢？</div>\n<div class=\"a\">Pinkoi</div>\n</li>\n<li>\n<div class=\"q\">要如何得知最新活動相關消息？</div>\n<div class=\"a\">歡迎加入 Facebook 粉絲專頁並且設定「搶先看」，或是加入 Line 官方帳號：@___。</div>\n</li>\n<li>\n<div class=\"q\">如何更改訂購內容、收件地址或取消訂單？</div>\n<div class=\"a\">訂單送出後即無法修改訂單內容，如需修改，請於出貨前與客服聯繫取消，於首頁下方的「聯絡我們」表單中留言。提醒您，若您取消訂單後重新訂購，商品將依當時庫存數量為準！</div>\n</li>\n<li>\n<div class=\"q\">要如何查詢我的訂單狀態？</div>\n<div class=\"a\">進入訂單查詢，可以看到訂單處理進度（訂單狀態），「待付款」表示還沒付款，「已付款」表示已收到款項。如有重複刷卡請聯繫客服為您辦理刷退。</div>\n</li>\n<li>\n<div class=\"q\">處理進度（訂單狀態）說明</div>\n<div class=\"a\">\n<ul style=\"list-style:none;padding-left:0;\">\n<li>待付款：您的訂單已成立，但尚未核對款項。</li>\n<li>處理中：您使用貨到付款服務，等待商品包裝出貨。</li>\n<li>已付款：您已成功付款。</li>\n<li>已出貨：您的訂單已經出貨了！包裹追蹤碼會在 48 小時內更新到訂單狀態。</li>\n</ul>\n</div>\n</li>\n</ul>','qa'),(6,2,1,'Q&A','','','','','qa'),(6,3,1,'Q&A','','','','','qa'),(6,4,1,'よくあるご質問','','','','<h1 style=\"text-align:center;padding-bottom:20px;\">よくあるご質問</h1>\n<ul class=\"faq\" style=\"list-style:none;padding-left:0;\">\n<li>\n<div class=\"q\">どこで購入できますか？</div>\n<div class=\"a\">Pinkoi（ピンコイ）</div>\n</li>\n<li>\n<div class=\"q\">最新情報はどこでチェックできますか？</div>\n<div class=\"a\">フェイスブックで「いいね！」して、フォローし、「トップに表示」にしてください。または公式LINEアカウント＠＿＿お友達登録をお願いします。</div>\n</li>\n<li>\n<div class=\"q\">注文した商品の変更やキャンセルなど、できますか？</div>\n<div class=\"a\">注文した商品の変更はお受けできません。商品の変更したい場合は、一度全ての注文をキャンセルし、再度注文をお願いいたします。キャンセルになる場合、お問い合わせください。</div>\n</li>\n<li>\n<div class=\"q\">注文状況はどこで確認ができますか？</div>\n<div class=\"a\">注文状況は「注文履歴」からご確認ください。「未決済」の状態は入金まち、「決済済み」の状態は入金済 。もし、クレジットカードで二重払いになってしまった場合、お問い合わせください。</div>\n</li>\n<li>\n<div class=\"q\">注文状況について</div>\n<div class=\"a\">\n<ul style=\"list-style:none;padding-left:0;\">\n<li>入金待ち：ご入金待ちの状態です。ご入金が確認できた後、出荷準備をさせていただきます。</li>\n<li>処理中（注文受付）：ご注文の商品は出荷の準備中です。</li>\n<li>入金済：支払い手続きが完了しています。</li>\n<li>出荷完了：ご注文いただいた商品の発送が完了しております。商品の到着までお待ちください。お届けまでの配送状況につきましては、お荷物の問い合わせ番号からお調べいただけます。</li>\n</ul>\n</div>\n</li>\n</ul>','qa'),(7,1,1,'首頁櫥窗',NULL,'','','<div class=\"mt-2\">\n<div>\n<h3 class=\"display3-size\" style=\"margin-bottom:20px;display:inline-block;\">首頁櫥窗</h3>\n</div>\n{product:13,14,2|desktop-3|mobile-1} {product:13,14,2,3} {product:13,14,2,3,1,8|desktop-6|mobile-3|no-flag}</div>\n<p>?????☀ ☀ ☀ ☀ ☀</p>','shopwindow'),(7,2,1,'首頁櫥窗',NULL,'','','','shopwindow'),(7,3,1,'首頁櫥窗',NULL,'','','','shopwindow'),(7,4,1,'首頁櫥窗',NULL,'','','','shopwindow');
/*!40000 ALTER TABLE `ps_cms_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_role`
--

DROP TABLE IF EXISTS `ps_cms_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_role` (
  `id_cms_role` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `id_cms` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_cms_role`,`id_cms`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_role`
--

LOCK TABLES `ps_cms_role` WRITE;
/*!40000 ALTER TABLE `ps_cms_role` DISABLE KEYS */;
INSERT INTO `ps_cms_role` VALUES (1,'LEGAL_CONDITIONS',3),(6,'LEGAL_ENVIRONMENTAL',9),(2,'LEGAL_NOTICE',2),(5,'LEGAL_PRIVACY',7),(3,'LEGAL_REVOCATION',6),(4,'LEGAL_REVOCATION_FORM',0),(7,'LEGAL_SHIP_PAY',8);
/*!40000 ALTER TABLE `ps_cms_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_role_lang`
--

DROP TABLE IF EXISTS `ps_cms_role_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_role_lang` (
  `id_cms_role` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_cms_role`,`id_lang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_role_lang`
--

LOCK TABLES `ps_cms_role_lang` WRITE;
/*!40000 ALTER TABLE `ps_cms_role_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_cms_role_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_cms_shop`
--

DROP TABLE IF EXISTS `ps_cms_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_cms_shop` (
  `id_cms` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `indexed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '已索引 flag',
  PRIMARY KEY (`id_cms`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_cms_shop`
--

LOCK TABLES `ps_cms_shop` WRITE;
/*!40000 ALTER TABLE `ps_cms_shop` DISABLE KEYS */;
INSERT INTO `ps_cms_shop` VALUES (1,1,0),(2,1,0),(3,1,0),(4,1,0),(5,1,0),(6,1,0),(7,1,0);
/*!40000 ALTER TABLE `ps_cms_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_configuration`
--

DROP TABLE IF EXISTS `ps_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_configuration` (
  `id_configuration` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned DEFAULT NULL,
  `id_shop` int(11) unsigned DEFAULT NULL,
  `name` varchar(254) NOT NULL,
  `value` text,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_configuration`),
  KEY `name` (`name`),
  KEY `id_shop` (`id_shop`),
  KEY `id_shop_group` (`id_shop_group`)
) ENGINE=InnoDB AUTO_INCREMENT=888 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_configuration`
--

LOCK TABLES `ps_configuration` WRITE;
/*!40000 ALTER TABLE `ps_configuration` DISABLE KEYS */;
INSERT INTO `ps_configuration` VALUES (1,NULL,NULL,'PS_LANG_DEFAULT','1','2018-07-11 11:57:31','2018-07-12 09:29:04'),(2,NULL,NULL,'PS_VERSION_DB','1.7.4.0','2018-07-11 11:57:31','2018-07-11 11:57:31'),(3,NULL,NULL,'PS_INSTALL_VERSION','1.7.4.0','2018-07-11 11:57:31','2018-07-11 11:57:31'),(4,NULL,NULL,'PS_GROUP_FEATURE_ACTIVE','1','2018-07-11 11:57:34','2020-03-06 12:30:44'),(5,NULL,NULL,'PS_CARRIER_DEFAULT','-1','2018-07-11 11:57:35','2020-02-17 11:40:59'),(6,NULL,NULL,'PS_SEARCH_INDEXATION','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,NULL,NULL,'PS_CURRENCY_DEFAULT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,NULL,NULL,'PS_COUNTRY_DEFAULT','203','0000-00-00 00:00:00','2018-07-11 11:57:38'),(9,NULL,NULL,'PS_REWRITING_SETTINGS','1','0000-00-00 00:00:00','2018-07-11 11:57:38'),(10,NULL,NULL,'PS_ORDER_OUT_OF_STOCK','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,NULL,NULL,'PS_LAST_QTIES','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,NULL,NULL,'PS_CONDITIONS','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,NULL,NULL,'PS_RECYCLABLE_PACK','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,NULL,NULL,'PS_GIFT_WRAPPING','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,NULL,NULL,'PS_GIFT_WRAPPING_PRICE','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,NULL,NULL,'PS_STOCK_MANAGEMENT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,NULL,NULL,'PS_NAVIGATION_PIPE','>','0000-00-00 00:00:00','0000-00-00 00:00:00'),(18,NULL,NULL,'PS_PRODUCTS_PER_PAGE','12','0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,NULL,NULL,'PS_PURCHASE_MINIMUM','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(20,NULL,NULL,'PS_PRODUCTS_ORDER_WAY','0','0000-00-00 00:00:00','2020-03-18 22:17:14'),(21,NULL,NULL,'PS_PRODUCTS_ORDER_BY','4','0000-00-00 00:00:00','2020-03-18 22:12:04'),(22,NULL,NULL,'PS_DISPLAY_QTIES','0','0000-00-00 00:00:00','2018-12-31 19:50:20'),(23,NULL,NULL,'PS_SHIPPING_HANDLING','0','0000-00-00 00:00:00','2020-02-03 18:24:47'),(24,NULL,NULL,'PS_SHIPPING_FREE_PRICE','0','0000-00-00 00:00:00','2018-07-14 11:35:29'),(25,NULL,NULL,'PS_SHIPPING_FREE_WEIGHT','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,NULL,NULL,'PS_SHIPPING_METHOD','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,NULL,NULL,'PS_TAX','0','0000-00-00 00:00:00','2018-07-13 14:21:27'),(28,NULL,NULL,'PS_SHOP_ENABLE','1','0000-00-00 00:00:00','2020-04-03 19:13:13'),(29,NULL,NULL,'PS_NB_DAYS_NEW_PRODUCT','20','0000-00-00 00:00:00','0000-00-00 00:00:00'),(30,NULL,NULL,'PS_SSL_ENABLED','1','0000-00-00 00:00:00','2018-10-15 23:14:09'),(31,NULL,NULL,'PS_WEIGHT_UNIT','kg','0000-00-00 00:00:00','2018-07-27 18:46:07'),(32,NULL,NULL,'PS_BLOCK_CART_AJAX','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,NULL,NULL,'PS_ORDER_RETURN','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,NULL,NULL,'PS_ORDER_RETURN_NB_DAYS','14','0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,NULL,NULL,'PS_MAIL_TYPE','1','0000-00-00 00:00:00','2018-09-05 22:08:07'),(36,NULL,NULL,'PS_PRODUCT_PICTURE_MAX_SIZE','8388608','0000-00-00 00:00:00','0000-00-00 00:00:00'),(37,NULL,NULL,'PS_PRODUCT_PICTURE_WIDTH','64','0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,NULL,NULL,'PS_PRODUCT_PICTURE_HEIGHT','64','0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,NULL,NULL,'PS_INVOICE_PREFIX','#IN','0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,NULL,NULL,'PS_INVCE_INVOICE_ADDR_RULES','{\"avoid\":[]}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,NULL,NULL,'PS_INVCE_DELIVERY_ADDR_RULES','{\"avoid\":[]}','0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,NULL,NULL,'PS_DELIVERY_PREFIX','#DE','0000-00-00 00:00:00','0000-00-00 00:00:00'),(43,NULL,NULL,'PS_DELIVERY_NUMBER',NULL,'0000-00-00 00:00:00','2018-08-01 22:13:28'),(44,NULL,NULL,'PS_RETURN_PREFIX','#RE','0000-00-00 00:00:00','0000-00-00 00:00:00'),(45,NULL,NULL,'PS_INVOICE','0','0000-00-00 00:00:00','2018-08-01 21:49:21'),(46,NULL,NULL,'PS_PASSWD_TIME_BACK','360','0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,NULL,NULL,'PS_PASSWD_TIME_FRONT','360','0000-00-00 00:00:00','0000-00-00 00:00:00'),(48,NULL,NULL,'PS_PASSWD_RESET_VALIDITY','1440','0000-00-00 00:00:00','0000-00-00 00:00:00'),(49,NULL,NULL,'PS_DISP_UNAVAILABLE_ATTR','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(50,NULL,NULL,'PS_SEARCH_MINWORDLEN','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(51,NULL,NULL,'PS_SEARCH_BLACKLIST','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(52,NULL,NULL,'PS_SEARCH_WEIGHT_PNAME','6','0000-00-00 00:00:00','0000-00-00 00:00:00'),(53,NULL,NULL,'PS_SEARCH_WEIGHT_REF','10','0000-00-00 00:00:00','0000-00-00 00:00:00'),(54,NULL,NULL,'PS_SEARCH_WEIGHT_SHORTDESC','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(55,NULL,NULL,'PS_SEARCH_WEIGHT_DESC','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(56,NULL,NULL,'PS_SEARCH_WEIGHT_CNAME','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(57,NULL,NULL,'PS_SEARCH_WEIGHT_MNAME','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(58,NULL,NULL,'PS_SEARCH_WEIGHT_TAG','4','0000-00-00 00:00:00','0000-00-00 00:00:00'),(59,NULL,NULL,'PS_SEARCH_WEIGHT_ATTRIBUTE','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(60,NULL,NULL,'PS_SEARCH_WEIGHT_FEATURE','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(61,NULL,NULL,'PS_SEARCH_AJAX','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(62,NULL,NULL,'PS_TIMEZONE','Asia/Taipei','0000-00-00 00:00:00','2018-07-11 11:57:38'),(63,NULL,NULL,'PS_THEME_V11','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(64,NULL,NULL,'PRESTASTORE_LIVE',NULL,'0000-00-00 00:00:00','2018-09-27 19:30:43'),(65,NULL,NULL,'PS_TIN_ACTIVE','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(66,NULL,NULL,'PS_SHOW_ALL_MODULES','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(67,NULL,NULL,'PS_BACKUP_ALL','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(68,NULL,NULL,'PS_1_3_UPDATE_DATE','2011-12-27 10:20:42','0000-00-00 00:00:00','0000-00-00 00:00:00'),(69,NULL,NULL,'PS_PRICE_ROUND_MODE','2','0000-00-00 00:00:00','2018-07-13 15:25:18'),(70,NULL,NULL,'PS_1_3_2_UPDATE_DATE','2011-12-27 10:20:42','0000-00-00 00:00:00','0000-00-00 00:00:00'),(71,NULL,NULL,'PS_CONDITIONS_CMS_ID','2','0000-00-00 00:00:00','2018-07-13 14:37:16'),(72,NULL,NULL,'TRACKING_DIRECT_TRAFFIC','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(73,NULL,NULL,'PS_VOLUME_UNIT','l','0000-00-00 00:00:00','2018-07-27 18:46:07'),(74,NULL,NULL,'PS_CIPHER_ALGORITHM','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(75,NULL,NULL,'PS_ATTRIBUTE_CATEGORY_DISPLAY','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(76,NULL,NULL,'PS_CUSTOMER_SERVICE_FILE_UPLOAD','0','0000-00-00 00:00:00','2018-09-21 23:55:22'),(77,NULL,NULL,'PS_CUSTOMER_SERVICE_SIGNATURE','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(78,NULL,NULL,'PS_BLOCK_BESTSELLERS_DISPLAY','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(79,NULL,NULL,'PS_BLOCK_NEWPRODUCTS_DISPLAY','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(80,NULL,NULL,'PS_BLOCK_SPECIALS_DISPLAY','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(81,NULL,NULL,'PS_STOCK_MVT_REASON_DEFAULT','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(82,NULL,NULL,'PS_SPECIFIC_PRICE_PRIORITIES','id_shop;id_currency;id_country;id_group','0000-00-00 00:00:00','0000-00-00 00:00:00'),(83,NULL,NULL,'PS_TAX_DISPLAY','0','0000-00-00 00:00:00','2018-07-13 14:21:27'),(84,NULL,NULL,'PS_SMARTY_FORCE_COMPILE','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(85,NULL,NULL,'PS_DISTANCE_UNIT','km','0000-00-00 00:00:00','2018-07-27 18:46:07'),(86,NULL,NULL,'PS_STORES_DISPLAY_CMS','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(87,NULL,NULL,'SHOP_LOGO_WIDTH','1830','0000-00-00 00:00:00','2018-12-26 10:59:31'),(88,NULL,NULL,'SHOP_LOGO_HEIGHT','380','0000-00-00 00:00:00','2018-12-26 10:59:31'),(89,NULL,NULL,'EDITORIAL_IMAGE_WIDTH','530','0000-00-00 00:00:00','0000-00-00 00:00:00'),(90,NULL,NULL,'EDITORIAL_IMAGE_HEIGHT','228','0000-00-00 00:00:00','0000-00-00 00:00:00'),(91,NULL,NULL,'PS_STATSDATA_CUSTOMER_PAGESVIEWS','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(92,NULL,NULL,'PS_STATSDATA_PAGESVIEWS','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(93,NULL,NULL,'PS_STATSDATA_PLUGINS','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(94,NULL,NULL,'PS_GEOLOCATION_ENABLED','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(95,NULL,NULL,'PS_ALLOWED_COUNTRIES','AF;ZA;AX;AL;DZ;DE;AD;AO;AI;AQ;AG;AN;SA;AR;AM;AW;AU;AT;AZ;BS;BH;BD;BB;BY;BE;BZ;BJ;BM;BT;BO;BA;BW;BV;BR;BN;BG;BF;MM;BI;KY;KH;CM;CA;CV;CF;CL;CN;CX;CY;CC;CO;KM;CG;CD;CK;KR;KP;CR;CI;HR;CU;DK;DJ;DM;EG;IE;SV;AE;EC;ER;ES;EE;ET;FK;FO;FJ;FI;FR;GA;GM;GE;GS;GH;GI;GR;GD;GL;GP;GU;GT;GG;GN;GQ;GW;GY;GF;HT;HM;HN;HK;HU;IM;MU;VG;VI;IN;ID;IR;IQ;IS;IL;IT;JM;JP;JE;JO;KZ;KE;KG;KI;KW;LA;LS;LV;LB;LR;LY;LI;LT;LU;MO;MK;MG;MY;MW;MV;ML;MT;MP;MA;MH;MQ;MR;YT;MX;FM;MD;MC;MN;ME;MS;MZ;NA;NR;NP;NI;NE;NG;NU;NF;NO;NC;NZ;IO;OM;UG;UZ;PK;PW;PS;PA;PG;PY;NL;PE;PH;PN;PL;PF;PR;PT;QA;DO;CZ;RE;RO;GB;RU;RW;EH;BL;KN;SM;MF;PM;VA;VC;LC;SB;WS;AS;ST;SN;RS;SC;SL;SG;SK;SI;SO;SD;LK;SE;CH;SR;SJ;SZ;SY;TJ;TW;TZ;TD;TF;TH;TL;TG;TK;TO;TT;TN;TM;TC;TR;TV;UA;UY;US;VU;VE;VN;WF;YE;ZM;ZW','0000-00-00 00:00:00','0000-00-00 00:00:00'),(96,NULL,NULL,'PS_GEOLOCATION_BEHAVIOR','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(97,NULL,NULL,'PS_LOCALE_LANGUAGE','tw','0000-00-00 00:00:00','2018-07-11 11:57:38'),(98,NULL,NULL,'PS_LOCALE_COUNTRY','tw','0000-00-00 00:00:00','2018-07-11 11:57:38'),(99,NULL,NULL,'PS_ATTACHMENT_MAXIMUM_SIZE','8','0000-00-00 00:00:00','0000-00-00 00:00:00'),(100,NULL,NULL,'PS_SMARTY_CACHE','1','0000-00-00 00:00:00','2020-03-06 12:30:44'),(101,NULL,NULL,'PS_DIMENSION_UNIT','cm','0000-00-00 00:00:00','2018-07-27 18:46:07'),(102,NULL,NULL,'PS_GUEST_CHECKOUT_ENABLED','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(103,NULL,NULL,'PS_DISPLAY_SUPPLIERS',NULL,'0000-00-00 00:00:00','2018-10-15 23:14:09'),(104,NULL,NULL,'PS_DISPLAY_BEST_SELLERS','1','0000-00-00 00:00:00','2018-10-15 23:14:09'),(105,NULL,NULL,'PS_CATALOG_MODE','0','0000-00-00 00:00:00','2018-09-18 15:56:31'),(106,NULL,NULL,'PS_GEOLOCATION_WHITELIST','127;209.185.108;209.185.253;209.85.238;209.85.238.11;209.85.238.4;216.239.33.96;216.239.33.97;216.239.33.98;216.239.33.99;216.239.37.98;216.239.37.99;216.239.39.98;216.239.39.99;216.239.41.96;216.239.41.97;216.239.41.98;216.239.41.99;216.239.45.4;216.239.46;216.239.51.96;216.239.51.97;216.239.51.98;216.239.51.99;216.239.53.98;216.239.53.99;216.239.57.96;91.240.109;216.239.57.97;216.239.57.98;216.239.57.99;216.239.59.98;216.239.59.99;216.33.229.163;64.233.173.193;64.233.173.194;64.233.173.195;64.233.173.196;64.233.173.197;64.233.173.198;64.233.173.199;64.233.173.200;64.233.173.201;64.233.173.202;64.233.173.203;64.233.173.204;64.233.173.205;64.233.173.206;64.233.173.207;64.233.173.208;64.233.173.209;64.233.173.210;64.233.173.211;64.233.173.212;64.233.173.213;64.233.173.214;64.233.173.215;64.233.173.216;64.233.173.217;64.233.173.218;64.233.173.219;64.233.173.220;64.233.173.221;64.233.173.222;64.233.173.223;64.233.173.224;64.233.173.225;64.233.173.226;64.233.173.227;64.233.173.228;64.233.173.229;64.233.173.230;64.233.173.231;64.233.173.232;64.233.173.233;64.233.173.234;64.233.173.235;64.233.173.236;64.233.173.237;64.233.173.238;64.233.173.239;64.233.173.240;64.233.173.241;64.233.173.242;64.233.173.243;64.233.173.244;64.233.173.245;64.233.173.246;64.233.173.247;64.233.173.248;64.233.173.249;64.233.173.250;64.233.173.251;64.233.173.252;64.233.173.253;64.233.173.254;64.233.173.255;64.68.80;64.68.81;64.68.82;64.68.83;64.68.84;64.68.85;64.68.86;64.68.87;64.68.88;64.68.89;64.68.90.1;64.68.90.10;64.68.90.11;64.68.90.12;64.68.90.129;64.68.90.13;64.68.90.130;64.68.90.131;64.68.90.132;64.68.90.133;64.68.90.134;64.68.90.135;64.68.90.136;64.68.90.137;64.68.90.138;64.68.90.139;64.68.90.14;64.68.90.140;64.68.90.141;64.68.90.142;64.68.90.143;64.68.90.144;64.68.90.145;64.68.90.146;64.68.90.147;64.68.90.148;64.68.90.149;64.68.90.15;64.68.90.150;64.68.90.151;64.68.90.152;64.68.90.153;64.68.90.154;64.68.90.155;64.68.90.156;64.68.90.157;64.68.90.158;64.68.90.159;64.68.90.16;64.68.90.160;64.68.90.161;64.68.90.162;64.68.90.163;64.68.90.164;64.68.90.165;64.68.90.166;64.68.90.167;64.68.90.168;64.68.90.169;64.68.90.17;64.68.90.170;64.68.90.171;64.68.90.172;64.68.90.173;64.68.90.174;64.68.90.175;64.68.90.176;64.68.90.177;64.68.90.178;64.68.90.179;64.68.90.18;64.68.90.180;64.68.90.181;64.68.90.182;64.68.90.183;64.68.90.184;64.68.90.185;64.68.90.186;64.68.90.187;64.68.90.188;64.68.90.189;64.68.90.19;64.68.90.190;64.68.90.191;64.68.90.192;64.68.90.193;64.68.90.194;64.68.90.195;64.68.90.196;64.68.90.197;64.68.90.198;64.68.90.199;64.68.90.2;64.68.90.20;64.68.90.200;64.68.90.201;64.68.90.202;64.68.90.203;64.68.90.204;64.68.90.205;64.68.90.206;64.68.90.207;64.68.90.208;64.68.90.21;64.68.90.22;64.68.90.23;64.68.90.24;64.68.90.25;64.68.90.26;64.68.90.27;64.68.90.28;64.68.90.29;64.68.90.3;64.68.90.30;64.68.90.31;64.68.90.32;64.68.90.33;64.68.90.34;64.68.90.35;64.68.90.36;64.68.90.37;64.68.90.38;64.68.90.39;64.68.90.4;64.68.90.40;64.68.90.41;64.68.90.42;64.68.90.43;64.68.90.44;64.68.90.45;64.68.90.46;64.68.90.47;64.68.90.48;64.68.90.49;64.68.90.5;64.68.90.50;64.68.90.51;64.68.90.52;64.68.90.53;64.68.90.54;64.68.90.55;64.68.90.56;64.68.90.57;64.68.90.58;64.68.90.59;64.68.90.6;64.68.90.60;64.68.90.61;64.68.90.62;64.68.90.63;64.68.90.64;64.68.90.65;64.68.90.66;64.68.90.67;64.68.90.68;64.68.90.69;64.68.90.7;64.68.90.70;64.68.90.71;64.68.90.72;64.68.90.73;64.68.90.74;64.68.90.75;64.68.90.76;64.68.90.77;64.68.90.78;64.68.90.79;64.68.90.8;64.68.90.80;64.68.90.9;64.68.91;64.68.92;66.249.64;66.249.65;66.249.66;66.249.67;66.249.68;66.249.69;66.249.70;66.249.71;66.249.72;66.249.73;66.249.78;66.249.79;72.14.199;8.6.48','0000-00-00 00:00:00','0000-00-00 00:00:00'),(107,NULL,NULL,'PS_LOGS_BY_EMAIL','5','0000-00-00 00:00:00','0000-00-00 00:00:00'),(108,NULL,NULL,'PS_COOKIE_CHECKIP',NULL,'0000-00-00 00:00:00','2018-09-27 19:30:43'),(109,NULL,NULL,'PS_USE_ECOTAX','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(110,NULL,NULL,'PS_CANONICAL_REDIRECT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(111,NULL,NULL,'PS_IMG_UPDATE_TIME','1583675550','0000-00-00 00:00:00','2020-03-08 21:52:30'),(112,NULL,NULL,'PS_BACKUP_DROP_TABLE','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(113,NULL,NULL,'PS_OS_CHEQUE','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(114,NULL,NULL,'PS_OS_PAYMENT','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(115,NULL,NULL,'PS_OS_PREPARATION','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(116,NULL,NULL,'PS_OS_SHIPPING','4','0000-00-00 00:00:00','0000-00-00 00:00:00'),(117,NULL,NULL,'PS_OS_DELIVERED','5','0000-00-00 00:00:00','0000-00-00 00:00:00'),(118,NULL,NULL,'PS_OS_CANCELED','6','0000-00-00 00:00:00','0000-00-00 00:00:00'),(119,NULL,NULL,'PS_OS_REFUND','7','0000-00-00 00:00:00','0000-00-00 00:00:00'),(120,NULL,NULL,'PS_OS_ERROR','8','0000-00-00 00:00:00','0000-00-00 00:00:00'),(121,NULL,NULL,'PS_OS_OUTOFSTOCK','9','0000-00-00 00:00:00','0000-00-00 00:00:00'),(122,NULL,NULL,'PS_OS_BANKWIRE','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(123,NULL,NULL,'PS_OS_WS_PAYMENT','11','0000-00-00 00:00:00','0000-00-00 00:00:00'),(124,NULL,NULL,'PS_OS_OUTOFSTOCK_PAID','9','0000-00-00 00:00:00','0000-00-00 00:00:00'),(125,NULL,NULL,'PS_OS_OUTOFSTOCK_UNPAID','12','0000-00-00 00:00:00','0000-00-00 00:00:00'),(126,NULL,NULL,'PS_OS_COD_VALIDATION','13','0000-00-00 00:00:00','0000-00-00 00:00:00'),(127,NULL,NULL,'PS_LEGACY_IMAGES','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(128,NULL,NULL,'PS_IMAGE_QUALITY','png_all','0000-00-00 00:00:00','2018-09-23 14:27:19'),(129,NULL,NULL,'PS_PNG_QUALITY','7','0000-00-00 00:00:00','2018-09-23 14:27:19'),(130,NULL,NULL,'PS_JPEG_QUALITY','90','0000-00-00 00:00:00','2018-09-23 14:27:19'),(131,NULL,NULL,'PS_COOKIE_LIFETIME_FO','480','0000-00-00 00:00:00','0000-00-00 00:00:00'),(132,NULL,NULL,'PS_COOKIE_LIFETIME_BO','480','0000-00-00 00:00:00','0000-00-00 00:00:00'),(133,NULL,NULL,'PS_RESTRICT_DELIVERED_COUNTRIES','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(134,NULL,NULL,'PS_SHOW_NEW_ORDERS','1','0000-00-00 00:00:00','2018-09-27 19:30:43'),(135,NULL,NULL,'PS_SHOW_NEW_CUSTOMERS','1','0000-00-00 00:00:00','2018-09-27 19:30:43'),(136,NULL,NULL,'PS_SHOW_NEW_MESSAGES','1','0000-00-00 00:00:00','2018-09-27 19:30:43'),(137,NULL,NULL,'PS_FEATURE_FEATURE_ACTIVE','1','0000-00-00 00:00:00','2020-03-06 12:30:44'),(138,NULL,NULL,'PS_COMBINATION_FEATURE_ACTIVE','1','0000-00-00 00:00:00','2020-03-06 12:30:44'),(139,NULL,NULL,'PS_SPECIFIC_PRICE_FEATURE_ACTIVE','1','0000-00-00 00:00:00','2020-03-15 02:52:01'),(140,NULL,NULL,'PS_VIRTUAL_PROD_FEATURE_ACTIVE','1','0000-00-00 00:00:00','2018-07-11 11:57:44'),(141,NULL,NULL,'PS_CUSTOMIZATION_FEATURE_ACTIVE','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(142,NULL,NULL,'PS_CART_RULE_FEATURE_ACTIVE','1','0000-00-00 00:00:00','2019-12-26 10:37:01'),(143,NULL,NULL,'PS_PACK_FEATURE_ACTIVE',NULL,'0000-00-00 00:00:00','2020-04-15 22:30:38'),(144,NULL,NULL,'PS_ALIAS_FEATURE_ACTIVE',NULL,'0000-00-00 00:00:00','2018-10-29 17:32:57'),(145,NULL,NULL,'PS_TAX_ADDRESS_TYPE','id_address_delivery','0000-00-00 00:00:00','0000-00-00 00:00:00'),(146,NULL,NULL,'PS_SHOP_DEFAULT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(147,NULL,NULL,'PS_CARRIER_DEFAULT_SORT','1','0000-00-00 00:00:00','2018-07-14 09:19:59'),(148,NULL,NULL,'PS_STOCK_MVT_INC_REASON_DEFAULT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(149,NULL,NULL,'PS_STOCK_MVT_DEC_REASON_DEFAULT','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(150,NULL,NULL,'PS_ADVANCED_STOCK_MANAGEMENT','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(151,NULL,NULL,'PS_STOCK_MVT_TRANSFER_TO','7','0000-00-00 00:00:00','0000-00-00 00:00:00'),(152,NULL,NULL,'PS_STOCK_MVT_TRANSFER_FROM','6','0000-00-00 00:00:00','0000-00-00 00:00:00'),(153,NULL,NULL,'PS_CARRIER_DEFAULT_ORDER','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(154,NULL,NULL,'PS_STOCK_MVT_SUPPLY_ORDER','8','0000-00-00 00:00:00','0000-00-00 00:00:00'),(155,NULL,NULL,'PS_STOCK_CUSTOMER_ORDER_CANCEL_REASON','9','0000-00-00 00:00:00','0000-00-00 00:00:00'),(156,NULL,NULL,'PS_STOCK_CUSTOMER_RETURN_REASON','10','0000-00-00 00:00:00','0000-00-00 00:00:00'),(157,NULL,NULL,'PS_STOCK_MVT_INC_EMPLOYEE_EDITION','11','0000-00-00 00:00:00','0000-00-00 00:00:00'),(158,NULL,NULL,'PS_STOCK_MVT_DEC_EMPLOYEE_EDITION','12','0000-00-00 00:00:00','0000-00-00 00:00:00'),(159,NULL,NULL,'PS_STOCK_CUSTOMER_ORDER_REASON','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(160,NULL,NULL,'PS_UNIDENTIFIED_GROUP','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(161,NULL,NULL,'PS_GUEST_GROUP','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(162,NULL,NULL,'PS_CUSTOMER_GROUP','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(163,NULL,NULL,'PS_SMARTY_CONSOLE','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(164,NULL,NULL,'PS_INVOICE_MODEL','invoice','0000-00-00 00:00:00','0000-00-00 00:00:00'),(165,NULL,NULL,'PS_LIMIT_UPLOAD_IMAGE_VALUE','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(166,NULL,NULL,'PS_LIMIT_UPLOAD_FILE_VALUE','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(167,NULL,NULL,'MB_PAY_TO_EMAIL','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(168,NULL,NULL,'MB_SECRET_WORD','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(169,NULL,NULL,'MB_HIDE_LOGIN','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(170,NULL,NULL,'MB_ID_LOGO','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(171,NULL,NULL,'MB_ID_LOGO_WALLET','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(172,NULL,NULL,'MB_PARAMETERS','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(173,NULL,NULL,'MB_PARAMETERS_2','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(174,NULL,NULL,'MB_DISPLAY_MODE','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(175,NULL,NULL,'MB_CANCEL_URL','http://www.yoursite.com','0000-00-00 00:00:00','0000-00-00 00:00:00'),(176,NULL,NULL,'MB_LOCAL_METHODS','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(177,NULL,NULL,'MB_INTER_METHODS','5','0000-00-00 00:00:00','0000-00-00 00:00:00'),(178,NULL,NULL,'BANK_WIRE_CURRENCIES','2,1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(179,NULL,NULL,'CHEQUE_CURRENCIES','2,1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(180,NULL,NULL,'PRODUCTS_VIEWED_NBR','24','0000-00-00 00:00:00','2020-03-09 23:48:30'),(181,NULL,NULL,'BLOCK_CATEG_DHTML','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(182,NULL,NULL,'BLOCK_CATEG_MAX_DEPTH','3','0000-00-00 00:00:00','2018-07-12 23:04:21'),(183,NULL,NULL,'MANUFACTURER_DISPLAY_FORM','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(184,NULL,NULL,'MANUFACTURER_DISPLAY_TEXT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(185,NULL,NULL,'MANUFACTURER_DISPLAY_TEXT_NB','5','0000-00-00 00:00:00','0000-00-00 00:00:00'),(186,NULL,NULL,'NEW_PRODUCTS_NBR','4','0000-00-00 00:00:00','2018-07-11 14:33:56'),(187,NULL,NULL,'PS_TOKEN_ENABLE','1','0000-00-00 00:00:00','2018-10-15 23:14:09'),(188,NULL,NULL,'PS_STATS_RENDER','graphnvd3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(189,NULL,NULL,'PS_STATS_OLD_CONNECT_AUTO_CLEAN','never','0000-00-00 00:00:00','0000-00-00 00:00:00'),(190,NULL,NULL,'PS_STATS_GRID_RENDER','gridhtml','0000-00-00 00:00:00','0000-00-00 00:00:00'),(191,NULL,NULL,'BLOCKTAGS_NBR','10','0000-00-00 00:00:00','0000-00-00 00:00:00'),(192,NULL,NULL,'CHECKUP_DESCRIPTIONS_LT','100','0000-00-00 00:00:00','0000-00-00 00:00:00'),(193,NULL,NULL,'CHECKUP_DESCRIPTIONS_GT','400','0000-00-00 00:00:00','0000-00-00 00:00:00'),(194,NULL,NULL,'CHECKUP_IMAGES_LT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(195,NULL,NULL,'CHECKUP_IMAGES_GT','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(196,NULL,NULL,'CHECKUP_SALES_LT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(197,NULL,NULL,'CHECKUP_SALES_GT','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(198,NULL,NULL,'CHECKUP_STOCK_LT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(199,NULL,NULL,'CHECKUP_STOCK_GT','3','0000-00-00 00:00:00','0000-00-00 00:00:00'),(200,NULL,NULL,'FOOTER_CMS','0_3|0_4','0000-00-00 00:00:00','0000-00-00 00:00:00'),(201,NULL,NULL,'FOOTER_BLOCK_ACTIVATION','0_3|0_4','0000-00-00 00:00:00','0000-00-00 00:00:00'),(202,NULL,NULL,'FOOTER_POWEREDBY','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(203,NULL,NULL,'BLOCKADVERT_LINK','http://www.prestashop.com','0000-00-00 00:00:00','0000-00-00 00:00:00'),(204,NULL,NULL,'BLOCKSTORE_IMG','store.jpg','0000-00-00 00:00:00','0000-00-00 00:00:00'),(205,NULL,NULL,'BLOCKADVERT_IMG_EXT','jpg','0000-00-00 00:00:00','0000-00-00 00:00:00'),(206,NULL,NULL,'MOD_BLOCKTOPMENU_ITEMS','CAT7,CAT8,CAT14,LNK1','0000-00-00 00:00:00','2019-08-15 12:48:39'),(207,NULL,NULL,'MOD_BLOCKTOPMENU_SEARCH','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(208,NULL,NULL,'BLOCKSOCIAL_FACEBOOK','https://www.facebook.com','0000-00-00 00:00:00','2018-10-08 22:12:51'),(209,NULL,NULL,'BLOCKSOCIAL_TWITTER',NULL,'0000-00-00 00:00:00','2018-07-11 11:58:45'),(210,NULL,NULL,'BLOCKSOCIAL_RSS',NULL,'0000-00-00 00:00:00','2018-07-11 11:58:45'),(211,NULL,NULL,'BLOCKCONTACTINFOS_COMPANY','Your company','0000-00-00 00:00:00','0000-00-00 00:00:00'),(212,NULL,NULL,'BLOCKCONTACTINFOS_ADDRESS','Address line 1\nCity\nCountry','0000-00-00 00:00:00','0000-00-00 00:00:00'),(213,NULL,NULL,'BLOCKCONTACTINFOS_PHONE','0123-456-789','0000-00-00 00:00:00','0000-00-00 00:00:00'),(214,NULL,NULL,'BLOCKCONTACTINFOS_EMAIL','pub@prestashop.com','0000-00-00 00:00:00','0000-00-00 00:00:00'),(217,NULL,NULL,'SUPPLIER_DISPLAY_TEXT','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(218,NULL,NULL,'SUPPLIER_DISPLAY_TEXT_NB','5','0000-00-00 00:00:00','0000-00-00 00:00:00'),(219,NULL,NULL,'SUPPLIER_DISPLAY_FORM','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(220,NULL,NULL,'BLOCK_CATEG_NBR_COLUMN_FOOTER','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(221,NULL,NULL,'UPGRADER_BACKUPDB_FILENAME','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(222,NULL,NULL,'UPGRADER_BACKUPFILES_FILENAME','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(223,NULL,NULL,'BLOCKREINSURANCE_NBBLOCKS','5','0000-00-00 00:00:00','0000-00-00 00:00:00'),(224,NULL,NULL,'HOMESLIDER_WIDTH','535','0000-00-00 00:00:00','0000-00-00 00:00:00'),(225,NULL,NULL,'HOMESLIDER_SPEED','5000','0000-00-00 00:00:00','2018-07-11 11:58:38'),(226,NULL,NULL,'HOMESLIDER_PAUSE','7700','0000-00-00 00:00:00','0000-00-00 00:00:00'),(227,NULL,NULL,'HOMESLIDER_LOOP','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(228,NULL,NULL,'PS_BASE_DISTANCE_UNIT','里','0000-00-00 00:00:00','2018-07-13 14:35:07'),(229,NULL,NULL,'PS_SHOP_DOMAIN','test.tekapo.cart:8080','0000-00-00 00:00:00','2018-07-11 11:57:38'),(230,NULL,NULL,'PS_SHOP_DOMAIN_SSL','test.tekapo.cart','0000-00-00 00:00:00','2018-07-11 11:57:38'),(231,NULL,NULL,'PS_SHOP_NAME','My TekapoCart Store','0000-00-00 00:00:00','2020-03-09 12:07:15'),(232,NULL,NULL,'PS_SHOP_EMAIL','admin@example.com','0000-00-00 00:00:00','2018-07-11 11:57:39'),(233,NULL,NULL,'PS_MAIL_METHOD','2','0000-00-00 00:00:00','2019-12-26 09:52:23'),(234,NULL,NULL,'PS_SHOP_ACTIVITY',NULL,'0000-00-00 00:00:00','2018-10-15 23:14:09'),(235,NULL,NULL,'PS_LOGO','logo.jpg','0000-00-00 00:00:00','2020-02-24 23:11:53'),(236,NULL,NULL,'PS_FAVICON','favicon_32_1.png','0000-00-00 00:00:00','2020-03-08 03:15:04'),(237,NULL,NULL,'PS_STORES_ICON','logo_stores.png','0000-00-00 00:00:00','0000-00-00 00:00:00'),(238,NULL,NULL,'PS_ROOT_CATEGORY','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(239,NULL,NULL,'PS_HOME_CATEGORY','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(240,NULL,NULL,'PS_CONFIGURATION_AGREMENT','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(241,NULL,NULL,'PS_MAIL_SERVER','smtp.gmail.com','0000-00-00 00:00:00','2019-12-22 18:12:21'),(242,NULL,NULL,'PS_MAIL_USER','e.tekapo@gmail.com','0000-00-00 00:00:00','2019-12-22 18:12:21'),(243,NULL,NULL,'PS_MAIL_PASSWD',NULL,'0000-00-00 00:00:00','2019-12-28 20:52:30'),(244,NULL,NULL,'PS_MAIL_SMTP_ENCRYPTION','tls','0000-00-00 00:00:00','2018-09-12 01:38:31'),(245,NULL,NULL,'PS_MAIL_SMTP_PORT','587','0000-00-00 00:00:00','2018-09-12 01:38:31'),(246,NULL,NULL,'PS_MAIL_COLOR','#db3484','0000-00-00 00:00:00','0000-00-00 00:00:00'),(247,NULL,NULL,'NW_SALT','mtLr3E6UYAB4JqYe','0000-00-00 00:00:00','2018-07-11 11:58:34'),(248,NULL,NULL,'PS_PAYMENT_LOGO_CMS_ID','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(249,NULL,NULL,'HOME_FEATURED_NBR','8','0000-00-00 00:00:00','0000-00-00 00:00:00'),(250,NULL,NULL,'SEK_MIN_OCCURENCES','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(251,NULL,NULL,'SEK_FILTER_KW','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(252,NULL,NULL,'PS_ALLOW_MOBILE_DEVICE','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(253,NULL,NULL,'PS_CUSTOMER_CREATION_EMAIL','0','0000-00-00 00:00:00','2019-12-24 13:00:41'),(254,NULL,NULL,'PS_SMARTY_CONSOLE_KEY','SMARTY_DEBUG','0000-00-00 00:00:00','0000-00-00 00:00:00'),(255,NULL,NULL,'PS_DASHBOARD_USE_PUSH','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(256,NULL,NULL,'PS_ATTRIBUTE_ANCHOR_SEPARATOR','-','0000-00-00 00:00:00','0000-00-00 00:00:00'),(257,NULL,NULL,'CONF_AVERAGE_PRODUCT_MARGIN','40','0000-00-00 00:00:00','0000-00-00 00:00:00'),(258,NULL,NULL,'PS_DASHBOARD_SIMULATION','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(259,NULL,NULL,'PS_USE_HTMLPURIFIER','1','0000-00-00 00:00:00','2018-10-15 23:14:09'),(260,NULL,NULL,'PS_SMARTY_CACHING_TYPE','filesystem','0000-00-00 00:00:00','0000-00-00 00:00:00'),(261,NULL,NULL,'PS_SMARTY_LOCAL',NULL,'0000-00-00 00:00:00','2020-03-06 12:30:44'),(262,NULL,NULL,'PS_SMARTY_CLEAR_CACHE','everytime','0000-00-00 00:00:00','0000-00-00 00:00:00'),(263,NULL,NULL,'PS_DETECT_LANG','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(264,NULL,NULL,'PS_DETECT_COUNTRY','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(265,NULL,NULL,'PS_ROUND_TYPE','1','0000-00-00 00:00:00','2018-07-13 15:25:03'),(266,NULL,NULL,'PS_PRICE_DISPLAY_PRECISION','2','0000-00-00 00:00:00','2018-07-13 15:25:03'),(267,NULL,NULL,'PS_LOG_EMAILS',NULL,'0000-00-00 00:00:00','2019-12-28 20:52:30'),(268,NULL,NULL,'PS_CUSTOMER_OPTIN','0','0000-00-00 00:00:00','2018-07-12 09:15:30'),(269,NULL,NULL,'PS_CUSTOMER_BIRTHDATE','0','0000-00-00 00:00:00','2018-07-12 09:11:56'),(270,NULL,NULL,'PS_PACK_STOCK_TYPE','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(271,NULL,NULL,'PS_LOG_MODULE_PERFS_MODULO','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(272,NULL,NULL,'PS_DISALLOW_HISTORY_REORDERING',NULL,'0000-00-00 00:00:00','2018-07-11 14:37:40'),(273,NULL,NULL,'PS_DISPLAY_PRODUCT_WEIGHT','0','0000-00-00 00:00:00','0000-00-00 00:00:00'),(274,NULL,NULL,'PS_PRODUCT_WEIGHT_PRECISION','2','0000-00-00 00:00:00','0000-00-00 00:00:00'),(275,NULL,NULL,'PS_ACTIVE_CRONJOB_EXCHANGE_RATE','1','0000-00-00 00:00:00','2018-07-30 16:07:21'),(276,NULL,NULL,'PS_ORDER_RECALCULATE_SHIPPING','1','0000-00-00 00:00:00','0000-00-00 00:00:00'),(277,NULL,NULL,'PS_MAINTENANCE_TEXT','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(278,NULL,NULL,'PS_PRODUCT_SHORT_DESC_LIMIT','800','0000-00-00 00:00:00','0000-00-00 00:00:00'),(279,NULL,NULL,'PS_LABEL_IN_STOCK_PRODUCTS','In Stock','0000-00-00 00:00:00','0000-00-00 00:00:00'),(280,NULL,NULL,'PS_LABEL_OOS_PRODUCTS_BOA','Product available for orders','0000-00-00 00:00:00','0000-00-00 00:00:00'),(281,NULL,NULL,'PS_LABEL_OOS_PRODUCTS_BOD','Out-of-Stock','0000-00-00 00:00:00','0000-00-00 00:00:00'),(282,NULL,NULL,'PS_SSL_ENABLED_EVERYWHERE','1','2018-07-11 11:57:38','2018-10-15 23:14:09'),(283,NULL,NULL,'DASHACTIVITY_CART_ACTIVE','30','2018-07-11 11:58:19','2018-07-11 11:58:19'),(284,NULL,NULL,'DASHACTIVITY_CART_ABANDONED_MIN','24','2018-07-11 11:58:19','2018-07-11 11:58:19'),(285,NULL,NULL,'DASHACTIVITY_CART_ABANDONED_MAX','48','2018-07-11 11:58:19','2018-07-11 11:58:19'),(286,NULL,NULL,'DASHACTIVITY_VISITOR_ONLINE','30','2018-07-11 11:58:19','2018-07-11 11:58:19'),(287,NULL,NULL,'PS_DASHGOALS_CURRENT_YEAR','2018','2018-07-11 11:58:21','2018-07-11 11:58:21'),(288,NULL,NULL,'DASHPRODUCT_NBR_SHOW_LAST_ORDER','10','2018-07-11 11:58:22','2018-07-11 11:58:22'),(289,NULL,NULL,'DASHPRODUCT_NBR_SHOW_BEST_SELLER','10','2018-07-11 11:58:22','2018-07-11 11:58:22'),(290,NULL,NULL,'DASHPRODUCT_NBR_SHOW_MOST_VIEWED','10','2018-07-11 11:58:22','2018-07-11 11:58:22'),(291,NULL,NULL,'DASHPRODUCT_NBR_SHOW_TOP_SEARCH','10','2018-07-11 11:58:22','2018-07-11 11:58:22'),(292,NULL,NULL,'BANNER_IMG',NULL,'2018-07-11 11:58:26','2018-07-11 11:58:26'),(293,NULL,NULL,'BANNER_LINK',NULL,'2018-07-11 11:58:26','2018-07-11 11:58:26'),(294,NULL,NULL,'BANNER_DESC',NULL,'2018-07-11 11:58:26','2018-07-11 11:58:26'),(295,NULL,NULL,'BLOCK_CATEG_ROOT_CATEGORY','0','2018-07-11 11:58:27','2018-07-12 23:04:21'),(296,NULL,NULL,'CONF_PS_CHECKPAYMENT_FIXED','0.2','2018-07-11 11:58:28','2018-07-11 11:58:28'),(297,NULL,NULL,'CONF_PS_CHECKPAYMENT_VAR','2','2018-07-11 11:58:28','2018-07-11 11:58:28'),(298,NULL,NULL,'CONF_PS_CHECKPAYMENT_FIXED_FOREIGN','0.2','2018-07-11 11:58:28','2018-07-11 11:58:28'),(299,NULL,NULL,'CONF_PS_CHECKPAYMENT_VAR_FOREIGN','2','2018-07-11 11:58:28','2018-07-11 11:58:28'),(300,NULL,NULL,'PS_NEWSLETTER_RAND','1121608291545472679','2018-07-11 11:58:34','2018-07-11 14:34:03'),(301,NULL,NULL,'NW_CONDITIONS',NULL,'2018-07-11 11:58:34','2018-07-11 11:58:34'),(302,NULL,NULL,'PS_LAYERED_SHOW_QTIES','1','2018-07-11 11:58:36','2018-07-11 11:58:36'),(303,NULL,NULL,'PS_LAYERED_FULL_TREE','1','2018-07-11 11:58:36','2018-07-11 11:58:36'),(304,NULL,NULL,'PS_LAYERED_FILTER_PRICE_USETAX','0','2018-07-11 11:58:36','2019-01-24 00:38:46'),(305,NULL,NULL,'PS_LAYERED_FILTER_CATEGORY_DEPTH','1','2018-07-11 11:58:36','2018-07-11 11:58:36'),(306,NULL,NULL,'PS_LAYERED_FILTER_PRICE_ROUNDING','1','2018-07-11 11:58:36','2018-07-11 11:58:36'),(307,NULL,NULL,'PS_LAYERED_INDEXED','1','2018-07-11 11:58:36','2018-07-11 11:58:36'),(308,NULL,NULL,'HOME_FEATURED_CAT','2','2018-07-11 11:58:37','2018-07-11 11:58:37'),(309,NULL,NULL,'HOMESLIDER_PAUSE_ON_HOVER','1','2018-07-11 11:58:38','2018-07-11 11:58:38'),(310,NULL,NULL,'HOMESLIDER_WRAP','1','2018-07-11 11:58:38','2018-09-14 01:19:21'),(311,NULL,NULL,'PS_SC_TWITTER','1','2018-07-11 11:58:43','2018-07-12 17:36:17'),(312,NULL,NULL,'PS_SC_FACEBOOK','1','2018-07-11 11:58:43','2018-07-12 17:36:17'),(313,NULL,NULL,'PS_SC_GOOGLE','0','2018-07-11 11:58:43','2019-12-30 15:08:10'),(314,NULL,NULL,'PS_SC_PINTEREST','1','2018-07-11 11:58:43','2018-07-11 11:58:43'),(315,NULL,NULL,'BLOCKSOCIAL_YOUTUBE',NULL,'2018-07-11 11:58:45','2018-07-11 11:58:45'),(316,NULL,NULL,'BLOCKSOCIAL_GOOGLE_PLUS',NULL,'2018-07-11 11:58:45','2018-07-11 11:58:45'),(317,NULL,NULL,'BLOCKSOCIAL_PINTEREST',NULL,'2018-07-11 11:58:45','2018-07-11 11:58:45'),(318,NULL,NULL,'BLOCKSOCIAL_VIMEO',NULL,'2018-07-11 11:58:45','2018-07-11 11:58:45'),(319,NULL,NULL,'BLOCKSOCIAL_INSTAGRAM','https://instagram.com','2018-07-11 11:58:45','2018-10-08 21:07:12'),(320,NULL,NULL,'BANK_WIRE_PAYMENT_INVITE',NULL,'2018-07-11 11:58:47','2019-11-19 19:04:41'),(321,NULL,NULL,'CONF_PS_WIREPAYMENT_FIXED','0.2','2018-07-11 11:58:47','2018-07-11 11:58:47'),(322,NULL,NULL,'CONF_PS_WIREPAYMENT_VAR','2','2018-07-11 11:58:47','2018-07-11 11:58:47'),(323,NULL,NULL,'CONF_PS_WIREPAYMENT_FIXED_FOREIGN','0.2','2018-07-11 11:58:47','2018-07-11 11:58:47'),(324,NULL,NULL,'CONF_PS_WIREPAYMENT_VAR_FOREIGN','2','2018-07-11 11:58:47','2018-07-11 11:58:47'),(325,NULL,NULL,'GF_INSTALL_CALC','0','2018-07-11 11:59:18','2018-07-11 12:33:31'),(326,NULL,NULL,'GF_CURRENT_LEVEL','1','2018-07-11 11:59:18','2018-07-11 11:59:18'),(327,NULL,NULL,'GF_CURRENT_LEVEL_PERCENT','0','2018-07-11 11:59:18','2018-07-11 12:33:31'),(328,NULL,NULL,'GF_NOTIFICATION','0','2018-07-11 11:59:18','2018-07-11 12:33:31'),(335,NULL,NULL,'GF_NOT_VIEWED_BADGE','122','2018-07-11 12:31:30','2018-07-11 12:31:40'),(336,NULL,NULL,'ONBOARDINGV2_CURRENT_STEP','0','2018-07-11 12:31:34','2018-07-11 12:33:59'),(337,NULL,NULL,'ONBOARDINGV2_SHUT_DOWN','1','2018-07-11 12:32:21','2018-07-11 12:32:54'),(343,NULL,NULL,'PS_BLOCK_BESTSELLERS_TO_DISPLAY','5','2018-07-11 12:51:21','2018-07-11 12:51:21'),(344,NULL,NULL,'BLOCKSPECIALS_SPECIALS_NBR','4','2018-07-11 12:51:27','2018-07-11 12:51:27'),(345,NULL,NULL,'CONF_PS_CASHONDELIVERY_FIXED','0.2','2018-07-11 12:53:02','2018-07-11 12:53:02'),(346,NULL,NULL,'CONF_PS_CASHONDELIVERY_VAR','2','2018-07-11 12:53:02','2018-07-11 12:53:02'),(347,NULL,NULL,'CONF_PS_CASHONDELIVERY_FIXED_FOREIGN','0.2','2018-07-11 12:53:02','2018-07-11 12:53:02'),(348,NULL,NULL,'CONF_PS_CASHONDELIVERY_VAR_FOREIGN','2','2018-07-11 12:53:02','2018-07-11 12:53:02'),(349,NULL,NULL,'PS_FOLLOWUP_SECURE_KEY',NULL,'2018-07-11 12:53:38','2018-07-11 12:53:38'),(350,NULL,NULL,'PS_FOLLOW_UP_ENABLE_1','1','2018-07-11 12:53:38','2019-08-18 01:19:43'),(351,NULL,NULL,'PS_FOLLOW_UP_ENABLE_2','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(352,NULL,NULL,'PS_FOLLOW_UP_ENABLE_3','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(353,NULL,NULL,'PS_FOLLOW_UP_ENABLE_4','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(354,NULL,NULL,'PS_FOLLOW_UP_AMOUNT_1','10','2018-07-11 12:53:38','2019-08-18 01:19:43'),(355,NULL,NULL,'PS_FOLLOW_UP_AMOUNT_2','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(356,NULL,NULL,'PS_FOLLOW_UP_AMOUNT_3','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(357,NULL,NULL,'PS_FOLLOW_UP_AMOUNT_4','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(358,NULL,NULL,'PS_FOLLOW_UP_DAYS_1','10','2018-07-11 12:53:38','2019-08-18 01:19:43'),(359,NULL,NULL,'PS_FOLLOW_UP_DAYS_2','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(360,NULL,NULL,'PS_FOLLOW_UP_DAYS_3','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(361,NULL,NULL,'PS_FOLLOW_UP_DAYS_4','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(362,NULL,NULL,'PS_FOLLOW_UP_THRESHOLD_3','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(363,NULL,NULL,'PS_FOLLOW_UP_DAYS_THRESHOLD_4','0','2018-07-11 12:53:38','2018-07-11 12:53:38'),(364,NULL,NULL,'PS_FOLLOW_UP_CLEAN_DB','1','2018-07-11 12:53:38','2019-08-17 21:43:59'),(365,NULL,NULL,'CROSSSELLING_DISPLAY_PRICE','1','2018-07-11 12:54:08','2018-07-11 12:54:08'),(366,NULL,NULL,'CROSSSELLING_NBR','8','2018-07-11 12:54:08','2018-07-11 12:54:08'),(375,NULL,NULL,'MA_MERCHANT_ORDER','1','2018-07-11 14:36:50','2018-07-11 14:36:50'),(376,NULL,NULL,'MA_MERCHANT_OOS','0','2018-07-11 14:36:50','2018-12-09 15:42:21'),(377,NULL,NULL,'MA_CUSTOMER_QTY','1','2018-07-11 14:36:50','2018-07-11 14:36:50'),(378,NULL,NULL,'MA_ORDER_EDIT','1','2018-07-11 14:36:50','2018-07-11 14:36:50'),(379,NULL,NULL,'MA_RETURN_SLIP','1','2018-07-11 14:36:50','2018-07-11 14:36:50'),(380,NULL,NULL,'MA_MERCHANT_MAILS','admin@example.com','2018-07-11 14:36:50','2018-07-11 14:36:50'),(381,NULL,NULL,'MA_LAST_QTIES','3','2018-07-11 14:36:50','2018-07-11 14:36:50'),(382,NULL,NULL,'MA_MERCHANT_COVERAGE','0','2018-07-11 14:36:50','2018-07-11 14:36:50'),(383,NULL,NULL,'MA_PRODUCT_COVERAGE','0','2018-07-11 14:36:50','2018-07-11 14:36:50'),(389,NULL,NULL,'PS_FINAL_SUMMARY_ENABLED','0','2018-07-11 14:37:40','2018-07-12 08:58:59'),(390,NULL,NULL,'BRAND_DISPLAY_TYPE','brand_form','2018-07-11 14:39:29','2018-08-21 16:15:45'),(391,NULL,NULL,'BRAND_DISPLAY_TEXT_NB','5','2018-07-11 14:39:29','2018-07-11 14:39:29'),(392,NULL,NULL,'SUPPLIER_DISPLAY_TYPE','supplier_text','2018-07-11 14:39:35','2018-07-11 14:39:35'),(395,NULL,NULL,'PS_PIXEL_ID',NULL,'2018-07-11 15:02:47','2018-07-11 15:02:47'),(396,NULL,NULL,'PS_CCCJS_VERSION','1611','2018-07-11 22:21:25','2020-03-18 22:17:14'),(397,NULL,NULL,'PS_CCCCSS_VERSION','1612','2018-07-11 22:21:25','2020-03-18 22:17:14'),(398,NULL,NULL,'PS_ALLOW_ACCENTED_CHARS_URL','1','2018-07-11 22:42:14','2018-07-12 08:51:11'),(399,NULL,NULL,'PS_HTACCESS_DISABLE_MULTIVIEWS','0','2018-07-11 22:42:14','2018-07-11 22:42:14'),(400,NULL,NULL,'PS_HTACCESS_DISABLE_MODSEC','0','2018-07-11 22:42:14','2018-07-11 22:42:14'),(401,NULL,NULL,'PS_ROUTE_product_rule','{category}/{id}{/:id_product_attribute}/{rewrite}{/:ean13}','2018-07-11 22:42:14','2018-09-27 15:42:46'),(402,NULL,NULL,'PS_ROUTE_category_rule',NULL,'2018-07-11 22:42:14','2018-07-11 22:42:14'),(403,NULL,NULL,'PS_ROUTE_layered_rule',NULL,'2018-07-11 22:42:14','2018-07-11 22:42:14'),(404,NULL,NULL,'PS_ROUTE_supplier_rule','supplier/{id}__{rewrite}','2018-07-11 22:42:14','2018-07-12 23:42:53'),(405,NULL,NULL,'PS_ROUTE_manufacturer_rule','brand/{id}_{rewrite}','2018-07-11 22:42:14','2018-07-12 23:42:53'),(406,NULL,NULL,'PS_ROUTE_cms_rule','page/{id}-{rewrite}','2018-07-11 22:42:14','2018-07-12 23:42:53'),(407,NULL,NULL,'PS_ROUTE_cms_category_rule','page/category/{id}-{rewrite}','2018-07-11 22:42:14','2018-07-12 23:42:53'),(408,NULL,NULL,'PS_ROUTE_module','module/{module}{/:controller}','2018-07-11 22:42:14','2018-07-11 22:42:14'),(409,NULL,NULL,'PS_SHIP_WHEN_AVAILABLE','0','2018-07-12 08:58:59','2018-07-12 08:58:59'),(410,NULL,NULL,'PS_GIFT_WRAPPING_TAX_RULES_GROUP','0','2018-07-12 08:58:59','2018-07-12 08:58:59'),(411,NULL,NULL,'PS_QTY_DISCOUNT_ON_COMBINATION','0','2018-07-12 09:06:54','2018-07-12 09:06:54'),(412,NULL,NULL,'PS_FORCE_FRIENDLY_PRODUCT','0','2018-07-12 09:06:54','2018-07-12 09:06:54'),(413,NULL,NULL,'PS_PRODUCT_ACTIVATION_DEFAULT','0','2018-07-12 09:06:54','2018-07-12 09:06:54'),(414,NULL,NULL,'PS_DISPLAY_DISCOUNT_PRICE','1','2018-07-12 09:06:54','2018-07-30 11:14:14'),(415,NULL,NULL,'PS_LABEL_DELIVERY_TIME_AVAILABLE',NULL,'2018-07-12 09:06:54','2018-07-12 09:06:54'),(416,NULL,NULL,'PS_LABEL_DELIVERY_TIME_OOSBOA',NULL,'2018-07-12 09:06:54','2018-07-12 09:06:54'),(417,NULL,NULL,'PS_CART_FOLLOWING','1','2018-07-12 09:11:56','2018-07-27 20:26:23'),(418,NULL,NULL,'PS_B2B_ENABLE','0','2018-07-12 09:11:56','2018-07-12 09:11:56'),(419,NULL,NULL,'PS_SEARCH_START','0','2018-07-12 09:24:15','2018-07-12 09:24:15'),(420,NULL,NULL,'PS_SEARCH_END','0','2018-07-12 09:24:15','2018-07-12 09:24:15'),(421,NULL,NULL,'BANK_WIRE_DETAILS','1XX-XXXX-XXXX-XXXXX','2018-07-12 09:42:57','2019-11-19 18:58:03'),(422,NULL,NULL,'BANK_WIRE_OWNER','OO股份有限公司','2018-07-12 09:42:57','2018-07-12 09:42:57'),(423,NULL,NULL,'BANK_WIRE_ADDRESS','OO銀行-XX分行','2018-07-12 09:42:57','2018-07-12 09:42:57'),(424,NULL,NULL,'BANK_WIRE_RESERVATION_DAYS','3','2018-07-12 09:42:57','2018-07-12 09:42:57'),(425,NULL,NULL,'BANK_WIRE_CUSTOM_TEXT',NULL,'2018-07-12 09:42:57','2018-07-12 09:42:57'),(426,NULL,NULL,'BLOCKSOCIAL_LINE',NULL,'2018-07-12 17:35:24','2018-12-09 20:47:06'),(427,NULL,NULL,'BLOCKSOCIAL_WEIBO','https://weibo.com','2018-07-12 17:35:24','2018-10-08 21:07:12'),(429,NULL,NULL,'PS_SC_LINE','1','2018-07-12 17:36:17','2018-07-12 17:36:17'),(430,NULL,NULL,'PS_SC_WEIBO','1','2018-07-12 17:36:17','2018-07-12 17:36:17'),(431,NULL,NULL,'PS_SHOP_DETAILS','Mon：14:00-21:30\r\nTue-Sun：11:30-21:30\r\n月曜日：14:00-21:30\r\n火曜～日曜：11:30-21:30','2018-07-12 18:39:42','2019-12-03 18:44:24'),(432,NULL,NULL,'PS_SHOP_ADDR1','信義路五段7號','2018-07-12 18:39:42','2018-09-07 00:29:53'),(433,NULL,NULL,'PS_SHOP_ADDR2',NULL,'2018-07-12 18:39:42','2018-07-12 18:44:06'),(434,NULL,NULL,'PS_SHOP_CODE','114','2018-07-12 18:39:42','2018-09-06 23:00:01'),(435,NULL,NULL,'PS_SHOP_CITY','台北市','2018-07-12 18:39:42','2018-09-06 23:00:20'),(436,NULL,NULL,'PS_SHOP_COUNTRY_ID','203','2018-07-12 18:39:42','2018-07-12 18:39:42'),(437,NULL,NULL,'PS_SHOP_COUNTRY','台灣','2018-07-12 18:39:42','2018-10-15 23:12:07'),(438,NULL,NULL,'PS_SHOP_PHONE','0928888888','2018-07-12 18:39:42','2018-07-12 18:42:24'),(439,NULL,NULL,'PS_SHOP_FAX',NULL,'2018-07-12 18:39:42','2018-07-12 18:39:42'),(440,NULL,NULL,'BLOCK_CATEG_SORT_WAY','0','2018-07-12 23:04:21','2018-07-12 23:04:21'),(441,NULL,NULL,'BLOCK_CATEG_SORT','0','2018-07-12 23:04:21','2018-07-12 23:04:21'),(442,NULL,NULL,'SIMPLICITY_FB_APP_ID',NULL,'2018-07-13 01:40:39','2019-12-29 00:55:07'),(443,NULL,NULL,'SMILEPAY_C2CUP_711_CARRIER_ID','103','2018-07-13 03:44:36','2018-07-14 11:21:17'),(444,NULL,NULL,'SMILEPAY_C2CUP_711_CARRIER_ID_REF','103','2018-07-13 03:44:36','2018-07-13 03:44:36'),(445,NULL,NULL,'SMILEPAY_C2CUP_FAMI_CARRIER_ID','105','2018-07-13 03:44:36','2018-07-14 11:21:26'),(446,NULL,NULL,'SMILEPAY_C2CUP_FAMI_CARRIER_ID_REF','105','2018-07-13 03:44:36','2018-07-13 03:44:36'),(449,NULL,NULL,'CONF_SMILEPAY_C2C_FIXED','0.2','2018-07-13 03:44:51','2018-07-13 03:44:51'),(450,NULL,NULL,'CONF_SMILEPAY_C2C_VAR','2','2018-07-13 03:44:51','2018-07-13 03:44:51'),(451,NULL,NULL,'CONF_SMILEPAY_C2C_FIXED_FOREIGN','0.2','2018-07-13 03:44:51','2018-07-13 03:44:51'),(452,NULL,NULL,'CONF_SMILEPAY_C2C_VAR_FOREIGN','2','2018-07-13 03:44:51','2018-07-13 03:44:51'),(453,NULL,NULL,'SMILEPAY_C2CP_711_CARRIER_ID','104','2018-07-13 03:44:51','2018-07-14 11:21:21'),(454,NULL,NULL,'SMILEPAY_C2CP_711_CARRIER_ID_REF','104','2018-07-13 03:44:51','2018-07-13 03:44:51'),(455,NULL,NULL,'SMILEPAY_C2CP_FAMI_CARRIER_ID','106','2018-07-13 03:44:51','2018-07-14 11:21:31'),(456,NULL,NULL,'SMILEPAY_C2CP_FAMI_CARRIER_ID_REF','106','2018-07-13 03:44:51','2018-07-13 03:44:51'),(457,NULL,NULL,'CONF_SMILEPAY_IBON_FIXED','0.2','2018-07-13 03:44:59','2018-07-13 03:44:59'),(458,NULL,NULL,'CONF_SMILEPAY_IBON_VAR','2','2018-07-13 03:44:59','2018-07-13 03:44:59'),(459,NULL,NULL,'CONF_SMILEPAY_IBON_FIXED_FOREIGN','0.2','2018-07-13 03:44:59','2018-07-13 03:44:59'),(460,NULL,NULL,'CONF_SMILEPAY_IBON_VAR_FOREIGN','2','2018-07-13 03:44:59','2018-07-13 03:44:59'),(461,NULL,NULL,'CONF_SMILEPAY_FAMIPORT_FIXED','0.2','2018-07-13 03:45:05','2018-07-13 03:45:05'),(462,NULL,NULL,'CONF_SMILEPAY_FAMIPORT_VAR','2','2018-07-13 03:45:05','2018-07-13 03:45:05'),(463,NULL,NULL,'CONF_SMILEPAY_FAMIPORT_FIXED_FOREIGN','0.2','2018-07-13 03:45:05','2018-07-13 03:45:05'),(464,NULL,NULL,'CONF_SMILEPAY_FAMIPORT_VAR_FOREIGN','2','2018-07-13 03:45:05','2018-07-13 03:45:05'),(471,NULL,NULL,'CONF_SMILEPAY_EZCAT_FIXED','0.2','2018-07-13 03:45:20','2018-07-13 03:45:20'),(472,NULL,NULL,'CONF_SMILEPAY_EZCAT_VAR','2','2018-07-13 03:45:20','2018-07-13 03:45:20'),(473,NULL,NULL,'CONF_SMILEPAY_EZCAT_FIXED_FOREIGN','0.2','2018-07-13 03:45:20','2018-07-13 03:45:20'),(474,NULL,NULL,'CONF_SMILEPAY_EZCAT_VAR_FOREIGN','2','2018-07-13 03:45:20','2018-07-13 03:45:20'),(481,NULL,NULL,'CONF_SMILEPAY_CSV_FIXED','0.2','2018-07-13 03:45:29','2018-07-13 03:45:29'),(482,NULL,NULL,'CONF_SMILEPAY_CSV_VAR','2','2018-07-13 03:45:29','2018-07-13 03:45:29'),(483,NULL,NULL,'CONF_SMILEPAY_CSV_FIXED_FOREIGN','0.2','2018-07-13 03:45:29','2018-07-13 03:45:29'),(484,NULL,NULL,'CONF_SMILEPAY_CSV_VAR_FOREIGN','2','2018-07-13 03:45:29','2018-07-13 03:45:29'),(485,NULL,NULL,'CONF_SMILEPAY_CREDIT_FIXED','0.2','2018-07-13 03:45:37','2018-07-13 03:45:37'),(486,NULL,NULL,'CONF_SMILEPAY_CREDIT_VAR','2','2018-07-13 03:45:37','2018-07-13 03:45:37'),(487,NULL,NULL,'CONF_SMILEPAY_CREDIT_FIXED_FOREIGN','0.2','2018-07-13 03:45:37','2018-07-13 03:45:37'),(488,NULL,NULL,'CONF_SMILEPAY_CREDIT_VAR_FOREIGN','2','2018-07-13 03:45:37','2018-07-13 03:45:37'),(489,NULL,NULL,'CONF_SMILEPAY_ATM_FIXED','0.2','2018-07-13 03:45:43','2018-07-13 03:45:43'),(490,NULL,NULL,'CONF_SMILEPAY_ATM_VAR','2','2018-07-13 03:45:43','2018-07-13 03:45:43'),(491,NULL,NULL,'CONF_SMILEPAY_ATM_FIXED_FOREIGN','0.2','2018-07-13 03:45:43','2018-07-13 03:45:43'),(492,NULL,NULL,'CONF_SMILEPAY_ATM_VAR_FOREIGN','2','2018-07-13 03:45:43','2018-07-13 03:45:43'),(499,NULL,NULL,'PRICE_DISPLAY_METHOD','1','2018-07-13 14:32:13','2018-07-13 14:32:13'),(500,NULL,NULL,'PS_REFERRERS_CACHE_LIKE',' \'2018-06-11 00:00:00\' AND \'2018-07-11 23:59:59\' ','2018-07-13 17:33:59','2018-07-13 17:33:59'),(501,NULL,NULL,'PS_REFERRERS_CACHE_DATE','2018-07-13 17:33:59','2018-07-13 17:33:59','2018-07-13 17:33:59'),(511,NULL,NULL,'SMILEPAY_c2cup_DCVC','0000','2018-07-14 12:40:43','2018-07-14 12:40:43'),(512,NULL,NULL,'SMILEPAY_c2cup_Rvg2c','1','2018-07-14 12:40:43','2018-07-14 12:40:43'),(513,NULL,NULL,'SMILEPAY_c2cup_VKey','0000','2018-07-14 12:40:43','2019-02-24 20:09:34'),(549,NULL,NULL,'SIMPLICITY_CMSBLOCK_ID',NULL,'2018-07-15 02:10:57','2019-08-30 17:01:07'),(550,NULL,NULL,'updatev_cmshomepage','1.4.1','2018-07-15 02:11:01','2018-07-15 02:11:01'),(551,NULL,NULL,'PS_LAST_VERSION_CHECK','1534677915','2018-07-20 03:14:19','2018-08-19 19:25:15'),(552,NULL,NULL,'PS_UPGRADE_CHANNEL','major','2018-07-20 03:14:22','2018-07-20 03:14:22'),(553,NULL,NULL,'PS_AUTOUP_UPDATE_DEFAULT_THEME','1','2018-07-20 03:14:22','2018-07-20 03:14:22'),(554,NULL,NULL,'PS_AUTOUP_CHANGE_DEFAULT_THEME','0','2018-07-20 03:14:22','2018-07-20 03:14:22'),(555,NULL,NULL,'PS_AUTOUP_KEEP_MAILS','0','2018-07-20 03:14:22','2018-07-20 03:14:22'),(556,NULL,NULL,'PS_AUTOUP_CUSTOM_MOD_DESACT','1','2018-07-20 03:14:22','2018-07-20 03:14:22'),(557,NULL,NULL,'PS_AUTOUP_MANUAL_MODE','0','2018-07-20 03:14:22','2018-07-20 03:14:22'),(558,NULL,NULL,'PS_AUTOUP_PERFORMANCE','1','2018-07-20 03:14:22','2018-07-20 03:14:22'),(559,NULL,NULL,'PS_DISPLAY_ERRORS','0','2018-07-20 03:14:22','2018-07-20 03:14:22'),(560,NULL,NULL,'PS_MAIL_EMAIL_MESSAGE','1','2018-07-28 04:58:21','2018-09-11 14:52:02'),(561,NULL,NULL,'PS_MAIL_DOMAIN',NULL,'2018-07-28 04:58:21','2019-12-22 19:39:00'),(562,NULL,NULL,'PS_INVOICE_TAXES_BREAKDOWN','0','2018-08-01 21:49:21','2018-08-01 21:49:21'),(563,NULL,NULL,'PS_PDF_IMG_INVOICE','0','2018-08-01 21:49:21','2018-08-01 21:49:21'),(564,NULL,NULL,'PS_INVOICE_USE_YEAR','0','2018-08-01 21:49:21','2018-08-01 21:49:21'),(565,NULL,NULL,'PS_INVOICE_RESET','0','2018-08-01 21:49:21','2018-08-01 21:49:21'),(566,NULL,NULL,'PS_INVOICE_YEAR_POS','0','2018-08-01 21:49:21','2018-08-01 21:49:21'),(567,NULL,NULL,'PS_INVOICE_START_NUMBER','0','2018-08-01 21:49:21','2018-08-01 21:49:21'),(568,NULL,NULL,'PS_INVOICE_LEGAL_FREE_TEXT',NULL,'2018-08-01 21:49:21','2018-08-01 21:49:21'),(569,NULL,NULL,'PS_INVOICE_FREE_TEXT',NULL,'2018-08-01 21:49:21','2018-08-01 21:49:21'),(570,NULL,NULL,'PS_PDF_USE_CACHE','0','2018-08-01 21:49:21','2018-08-01 21:49:21'),(571,NULL,NULL,'SIMPLICITY_FB_MESSAGING_TOKEN','85523ba310509e4a6db0471c502b9c1f','2018-08-19 17:38:03','2018-08-19 17:38:03'),(576,NULL,NULL,'SIMPLICITY_FB_PAGE_ID','2','2018-08-19 17:38:03','2018-08-25 01:06:45'),(577,NULL,NULL,'SIMPLICITY_FB_PAGE_TOKEN','3','2018-08-19 17:38:03','2018-08-25 01:06:45'),(589,NULL,NULL,'SIMPLICITY_HEADERBAR_HTML',NULL,'2018-08-26 16:46:00','2018-08-26 16:46:00'),(590,NULL,NULL,'GSITEMAP_PRIORITY_HOME','1','2018-08-26 23:26:44','2018-08-26 23:26:44'),(591,NULL,NULL,'GSITEMAP_PRIORITY_PRODUCT','0.9','2018-08-26 23:26:44','2018-08-26 23:26:44'),(592,NULL,NULL,'GSITEMAP_PRIORITY_CATEGORY','0.8','2018-08-26 23:26:44','2018-08-26 23:26:44'),(595,NULL,NULL,'GSITEMAP_PRIORITY_CMS','0.5','2018-08-26 23:26:44','2018-08-26 23:26:44'),(596,NULL,NULL,'GSITEMAP_FREQUENCY','weekly','2018-08-26 23:26:44','2018-08-26 23:26:44'),(597,NULL,NULL,'GSITEMAP_INDEX_CHECK',NULL,'2018-08-26 23:30:27','2018-08-26 23:30:27'),(598,NULL,NULL,'GSITEMAP_CHECK_IMAGE_FILE',NULL,'2018-08-26 23:30:27','2018-08-26 23:30:27'),(599,NULL,NULL,'GSITEMAP_DISABLE_LINKS',NULL,'2018-08-26 23:30:27','2018-10-10 19:54:53'),(600,NULL,NULL,'GSITEMAP_LAST_EXPORT','Sun, 10 Feb 2019 17:47:37 +0800','2018-08-26 23:30:28','2019-02-10 17:47:37'),(601,NULL,NULL,'SIMPLICITY_FB_MESSAGING_TEST_IP','1','2018-09-07 16:46:00','2018-09-11 01:00:15'),(602,NULL,NULL,'SIMPLICITY_FB_MESSAGING_ACTIVE','0','2018-09-07 16:46:00','2018-09-07 16:26:56'),(603,NULL,NULL,'PS_LOGO_MAIL','logo_mail.jpg','2018-09-13 01:33:40','2019-07-03 12:29:21'),(604,NULL,NULL,'PS_IMAGE_GENERATION_METHOD','0','2018-09-13 02:57:01','2018-09-26 16:50:49'),(605,NULL,NULL,'PS_HIGHT_DPI','0','2018-09-13 02:57:01','2018-09-20 15:29:54'),(606,NULL,NULL,'CONF_PAYPAL_FIXED','0.2','2018-09-18 15:05:37','2018-09-18 15:05:37'),(607,NULL,NULL,'CONF_PAYPAL_VAR','2','2018-09-18 15:05:37','2018-09-18 15:05:37'),(608,NULL,NULL,'CONF_PAYPAL_FIXED_FOREIGN','0.2','2018-09-18 15:05:37','2018-09-18 15:05:37'),(609,NULL,NULL,'CONF_PAYPAL_VAR_FOREIGN','2','2018-09-18 15:05:37','2018-09-18 15:05:37'),(610,NULL,NULL,'PAYPAL_OS_WAITING','23','2018-09-18 15:05:37','2018-09-18 15:05:37'),(611,NULL,NULL,'PAYPAL_BRAINTREE_OS_AWAITING','24','2018-09-18 15:05:37','2018-09-18 15:05:37'),(612,NULL,NULL,'PAYPAL_BRAINTREE_OS_AWAITING_VALIDATION','25','2018-09-18 15:05:37','2018-09-18 15:05:37'),(613,NULL,NULL,'PAYPAL_MERCHANT_ID_SANDBOX',NULL,'2018-09-18 15:05:37','2018-09-18 15:05:37'),(614,NULL,NULL,'PAYPAL_MERCHANT_ID_LIVE',NULL,'2018-09-18 15:05:37','2019-12-24 02:06:05'),(615,NULL,NULL,'PAYPAL_USERNAME_SANDBOX',NULL,'2018-09-18 15:05:37','2018-09-18 15:05:37'),(616,NULL,NULL,'PAYPAL_PSWD_SANDBOX',NULL,'2018-09-18 15:05:37','2018-09-18 15:05:37'),(617,NULL,NULL,'PAYPAL_SIGNATURE_SANDBOX',NULL,'2018-09-18 15:05:37','2018-09-18 15:05:37'),(618,NULL,NULL,'PAYPAL_SANDBOX_ACCESS','0','2018-09-18 15:05:37','2018-09-18 15:05:37'),(619,NULL,NULL,'PAYPAL_USERNAME_LIVE',NULL,'2018-09-18 15:05:37','2019-12-24 02:06:05'),(620,NULL,NULL,'PAYPAL_PSWD_LIVE',NULL,'2018-09-18 15:05:37','2019-12-24 02:06:05'),(621,NULL,NULL,'PAYPAL_SIGNATURE_LIVE',NULL,'2018-09-18 15:05:37','2019-12-26 10:24:54'),(622,NULL,NULL,'PAYPAL_LIVE_ACCESS','0','2018-09-18 15:05:37','2019-12-24 02:06:05'),(623,NULL,NULL,'PAYPAL_SANDBOX','0','2018-09-18 15:05:37','2019-02-12 20:12:03'),(624,NULL,NULL,'PAYPAL_API_INTENT','authorization','2018-09-18 15:05:37','2019-02-12 20:13:34'),(625,NULL,NULL,'PAYPAL_API_ADVANTAGES','0','2018-09-18 15:05:37','2019-12-25 10:58:11'),(626,NULL,NULL,'PAYPAL_API_CARD','0','2018-09-18 15:05:37','2019-12-24 02:01:02'),(627,NULL,NULL,'PAYPAL_METHOD',NULL,'2018-09-18 15:05:37','2019-02-25 16:36:43'),(628,NULL,NULL,'PAYPAL_EXPRESS_CHECKOUT_SHORTCUT',NULL,'2018-09-18 15:05:37','2019-12-24 03:06:18'),(629,NULL,NULL,'PAYPAL_EXPRESS_CHECKOUT_SHORTCUT_CART',NULL,'2018-09-18 15:05:37','2019-12-24 03:06:18'),(630,NULL,NULL,'PAYPAL_CRON_TIME','2018-09-18 15:09:37','2018-09-18 15:05:37','2018-09-18 15:05:37'),(631,NULL,NULL,'PAYPAL_BY_BRAINTREE','0','2018-09-18 15:05:37','2018-09-18 15:05:37'),(632,NULL,NULL,'PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT','1','2018-09-18 15:05:37','2019-02-25 16:36:43'),(633,NULL,NULL,'PAYPAL_VAULTING','0','2018-09-18 15:05:37','2018-09-18 15:05:37'),(635,NULL,NULL,'SIMPLICITY_IMAGE_USE_CROP','0','2018-09-20 15:00:00','2018-09-26 16:50:37'),(636,NULL,NULL,'CONTACTFORM_SEND_CONFIRMATION_EMAIL','0','2018-09-27 01:29:03','2018-09-27 01:29:03'),(637,NULL,NULL,'CONTACTFORM_SEND_NOTIFICATION_EMAIL','0','2018-09-27 01:29:03','2018-09-27 01:29:03'),(639,NULL,NULL,'SIMPLICITY_GTM_GUA_SITE_SPEED_SAMPLE_RATE','10','2018-09-27 23:44:54','2019-02-25 22:08:50'),(640,NULL,NULL,'SIMPLICITY_GTM_GUA_ECOMM_PRODID','1','2018-09-27 23:44:54','2018-09-27 23:44:54'),(641,NULL,NULL,'SIMPLICITY_GTM_GUA_ECOMM_PAGETYPE','2','2018-09-27 23:44:54','2018-09-27 23:44:54'),(642,NULL,NULL,'SIMPLICITY_GTM_GUA_ECOMM_TOTALVALUE','3','2018-09-27 23:44:54','2018-09-27 23:44:54'),(643,NULL,NULL,'SIMPLICITY_GTM_GUA_ECOMM_CATEGORY','4','2018-09-27 23:44:54','2018-09-27 23:44:54'),(644,NULL,NULL,'SIMPLICITY_GTM_EXCLUDED_ORDER_STATES','6,8,7','2018-09-27 23:44:54','2018-09-28 02:15:47'),(645,NULL,NULL,'SIMPLICITY_GTM_REFUND_ORDER_STATES','6,7','2018-09-27 23:44:54','2018-09-27 23:44:54'),(651,NULL,NULL,'SIMPLICITY_GTM_DO_NOT_TRACK','1','2018-09-28 02:15:47','2018-10-09 17:48:00'),(652,NULL,NULL,'SIMPLICITY_GTM_ID',NULL,'2018-09-28 02:15:47','2020-03-02 20:58:23'),(653,NULL,NULL,'SIMPLICITY_GTM_GUA_ID',NULL,'2018-09-28 02:15:47','2020-03-02 21:04:30'),(657,NULL,NULL,'SIMPLICITY_GTM_GUA_DYNAMIC_REMARKETING',NULL,'2018-09-28 02:15:47','2018-09-28 02:15:47'),(660,NULL,NULL,'SIMPLICITY_GTM_GUA_MERCHANT_VARIANT','v','2018-09-28 02:15:47','2020-03-02 21:03:01'),(662,NULL,NULL,'SIMPLICITY_GTM_ADWORDS_ID',NULL,'2018-09-28 02:15:47','2018-09-28 02:19:12'),(663,NULL,NULL,'SIMPLICITY_GTM_ADWORDS_LABEL',NULL,'2018-09-28 02:15:47','2018-09-28 02:19:12'),(665,NULL,NULL,'SIMPLICITY_GTM_FACEBOOK_ID',NULL,'2018-09-28 02:15:47','2018-09-28 02:15:47'),(668,NULL,NULL,'SIMPLICITY_GTM_FACEBOOK_CATALOG_VARIANT','v','2018-09-28 02:15:47','2020-03-02 21:01:37'),(676,NULL,NULL,'BLOCKSOCIAL_FLICKR','https://www.flickr.com','2018-10-08 11:08:32','2018-10-08 21:07:12'),(677,NULL,NULL,'BLOCKSOCIAL_ETSY','https://www.etsy.com','2018-10-08 11:08:32','2018-10-08 21:07:12'),(678,NULL,NULL,'SIMPLICITY_GTM_NO_BO_TRACKING',NULL,'2018-10-09 18:01:38','2018-10-09 18:01:38'),(679,NULL,NULL,'PS_MULTISHOP_FEATURE_ACTIVE',NULL,'2018-10-15 23:12:39','2018-10-15 23:14:09'),(683,1,1,'PS_REFERRERS_CACHE_LIKE',' \'2018-01-01 00:00:00\' AND \'2018-10-09 23:59:59\' ','2018-10-19 02:17:03','2018-10-19 02:17:03'),(684,1,1,'PS_REFERRERS_CACHE_DATE','2018-10-19 02:17:03','2018-10-19 02:17:03','2018-10-19 02:17:03'),(685,NULL,NULL,'PS_FAVICON_IPHONE','favicon_120_1.png','2018-10-19 18:00:00','2020-03-08 03:15:04'),(686,NULL,NULL,'PS_FAVICON_IPAD','favicon_152_1.png','2018-10-19 18:00:00','2020-03-08 03:15:04'),(687,NULL,NULL,'PS_FAVICON_IPAD_RETINA','favicon_167_1.png','2018-10-19 18:00:00','2020-03-08 03:15:04'),(688,NULL,NULL,'PS_FAVICON_IPHONE_RETINA','favicon_180_1.png','2018-10-19 18:00:00','2020-03-08 03:15:04'),(689,NULL,NULL,'PS_FAVICON_ANDROID','favicon_192_1.png','2018-10-19 18:00:00','2020-03-08 03:15:04'),(690,NULL,NULL,'PS_FAVICON_MICROSOFT','favicon_310_1.png','2018-10-19 18:00:00','2020-03-08 03:15:04'),(691,NULL,NULL,'TC_THEME_COLOR_SIMPLICITY','#67C8C2','2018-10-19 18:00:00','2018-10-19 18:00:00'),(692,NULL,NULL,'TC_THEME_COLOR_SIMPLICITY_BLACK','#000','2018-10-19 18:00:00','2018-10-19 18:00:00'),(693,NULL,NULL,'TC_THEME_COLOR_SIMPLICITY_BLUE','#2fb5d2','2018-10-19 18:00:00','2018-10-19 18:00:00'),(694,NULL,NULL,'TC_THEME_COLOR_SIMPLICITY_PINK','#F0648F','2018-10-19 18:00:00','2018-10-19 18:00:00'),(695,NULL,NULL,'PS_MAINTENANCE_IP',NULL,'2018-10-22 22:43:34','2018-10-22 22:43:34'),(697,1,1,'PS_MAINTENANCE_TEXT',NULL,'2018-10-22 23:11:12','2018-10-22 23:11:12'),(698,1,1,'PS_SSL_ENABLED','1','2018-10-22 23:55:14','2018-10-23 00:18:14'),(699,1,1,'PS_SSL_ENABLED_EVERYWHERE','1','2018-10-22 23:55:14','2018-10-23 00:18:14'),(700,1,1,'PS_TOKEN_ENABLE','1','2018-10-22 23:55:14','2018-10-23 00:18:14'),(701,NULL,NULL,'PS_ALLOW_HTML_IFRAME','1','2018-10-22 23:55:14','2018-10-23 00:18:14'),(702,1,1,'PS_USE_HTMLPURIFIER','1','2018-10-22 23:55:14','2018-10-23 00:18:14'),(703,1,1,'PS_DISPLAY_SUPPLIERS',NULL,'2018-10-22 23:55:14','2018-10-23 00:18:14'),(704,1,1,'PS_DISPLAY_BEST_SELLERS','1','2018-10-22 23:55:14','2018-10-23 00:18:14'),(706,1,1,'PS_SHOP_ACTIVITY',NULL,'2018-10-22 23:55:14','2018-10-23 00:18:14'),(711,1,1,'SIMPLICITY_GTM_GUA_DYNAMIC_REMARKETING',NULL,'2018-10-26 13:43:20','2018-10-26 15:23:00'),(712,1,1,'SIMPLICITY_GTM_ADWORDS_ID',NULL,'2018-10-26 13:43:20','2018-10-26 15:23:00'),(713,1,1,'SIMPLICITY_GTM_ADWORDS_LABEL',NULL,'2018-10-26 13:43:20','2018-10-26 15:23:00'),(714,1,1,'SIMPLICITY_GTM_FACEBOOK_ID',NULL,'2018-10-26 14:09:03','2018-10-26 14:09:03'),(717,1,1,'BANK_WIRE_ADDRESS','OO銀行-XX分行','2018-10-28 19:39:41','2018-10-28 19:39:58'),(719,NULL,NULL,'PS_SEARCH_WEIGHT_CMS_META_TITLE','5','2018-10-30 15:25:28','2018-10-30 15:25:28'),(720,NULL,NULL,'PS_SEARCH_WEIGHT_CMS_CONTENT','5','2018-10-30 15:26:33','2018-10-30 15:26:33'),(721,1,1,'PS_SMARTY_CACHE','1','2018-11-10 20:54:38','2018-11-10 21:38:50'),(722,1,1,'PS_SMARTY_LOCAL',NULL,'2018-11-10 20:54:38','2018-11-10 21:38:50'),(723,1,1,'PS_COMBINATION_FEATURE_ACTIVE','1','2018-11-10 20:54:38','2018-11-10 21:38:50'),(724,1,1,'PS_FEATURE_FEATURE_ACTIVE','1','2018-11-10 20:54:38','2018-11-10 21:38:50'),(725,1,1,'PS_GROUP_FEATURE_ACTIVE','1','2018-11-10 20:54:38','2018-11-10 21:38:50'),(731,NULL,NULL,'PS_CSS_THEME_CACHE',NULL,'2018-11-10 20:56:48','2020-03-06 12:30:44'),(732,NULL,NULL,'PS_JS_THEME_CACHE',NULL,'2018-11-10 21:05:39','2020-03-06 12:30:44'),(733,NULL,NULL,'PS_MEDIA_SERVER_1',NULL,'2018-11-11 10:47:41','2018-11-13 10:32:18'),(734,NULL,NULL,'PS_MEDIA_SERVER_2',NULL,'2018-11-11 10:47:41','2018-11-11 10:47:41'),(735,NULL,NULL,'PS_MEDIA_SERVER_3',NULL,'2018-11-11 10:47:41','2018-11-11 10:47:41'),(736,NULL,NULL,'PS_MEDIA_SERVERS','0','2018-11-11 10:47:41','2018-11-13 10:32:18'),(737,NULL,NULL,'TC_GCP_KEY','/var/bak/cdn_key.json','2018-11-11 11:11:11','2018-11-11 11:11:11'),(738,1,1,'PRODUCTS_VIEWED_NBR','24','2018-11-14 01:11:53','2018-11-14 01:11:53'),(739,1,1,'MOD_BLOCKTOPMENU_ITEMS','CAT7,CAT8,CAT14','2018-11-14 07:20:57','2018-11-14 07:21:33'),(740,1,1,'GSITEMAP_LAST_EXPORT','Wed, 14 Nov 2018 08:58:32 +0800','2018-11-14 08:58:32','2018-11-14 08:58:32'),(749,NULL,NULL,'HOME_FEATURED_LABEL',NULL,'2018-11-15 13:53:20','2018-11-15 13:53:20'),(751,NULL,NULL,'PS_BLOCK_BESTSELLERS_LABEL',NULL,'2018-11-17 16:02:11','2018-11-17 16:02:11'),(752,NULL,NULL,'PS_NB_LABEL',NULL,'2018-11-17 16:09:57','2018-11-17 16:09:57'),(753,NULL,NULL,'BLOCKSPECIALS_LABEL',NULL,'2018-11-17 16:17:39','2018-11-17 16:17:39'),(754,NULL,NULL,'BLOCKSOCIAL_PINKOI','https://www.pinkoi.com','2018-12-09 17:40:32','2018-12-09 17:40:32'),(755,NULL,NULL,'BLOCKSOCIAL_LINKEDIN','https://www.linkedin.com','2018-12-09 17:40:32','2018-12-09 17:40:32'),(756,NULL,NULL,'SIMPLICITY_IGFEED_CLIENT_ID',NULL,'2019-01-24 16:19:25','2019-08-30 17:05:06'),(757,NULL,NULL,'SIMPLICITY_IGFEED_CLIENT_SECRET',NULL,'2019-01-24 16:19:25','2019-08-30 17:05:06'),(758,NULL,NULL,'SIMPLICITY_IGFEED_ACCESS_TOKEN',NULL,'2019-01-24 16:19:25','2019-08-30 17:04:24'),(759,NULL,NULL,'SIMPLICITY_IGFEED_IMAGE_NUM','12','2019-01-24 16:19:25','2019-02-24 14:07:34'),(761,NULL,NULL,'SIMPLICITY_IGFEED_REFRESH','day','2019-01-24 16:19:25','2019-01-26 00:53:35'),(763,NULL,NULL,'PAYPAL_EXPRESS_CHECKOUT','1','2019-02-12 19:50:19','2019-02-25 16:36:43'),(764,NULL,NULL,'PAYPAL_CONFIG_BRAND',NULL,'2019-02-12 19:52:20','2019-02-12 19:52:20'),(765,NULL,NULL,'GS_PRODUCT_TYPE',NULL,'2019-02-28 00:55:01','2019-02-28 00:55:01'),(766,NULL,NULL,'GS_DESCRIPTION','short','2019-02-28 00:55:01','2019-02-28 00:55:01'),(767,NULL,NULL,'GS_SHIPPING_MODE','fixed','2019-02-28 00:55:01','2019-02-28 00:55:01'),(768,NULL,NULL,'GS_SHIPPING_PRICE_FIXED','1','2019-02-28 00:55:01','2019-02-28 00:55:01'),(769,NULL,NULL,'GS_SHIPPING_PRICE','0.00','2019-02-28 00:55:01','2019-02-28 00:55:01'),(770,NULL,NULL,'GS_SHIPPING_COUNTRY','UK','2019-02-28 00:55:01','2019-02-28 00:55:01'),(771,NULL,NULL,'GS_SHIPPING_COUNTRIES',NULL,'2019-02-28 00:55:01','2019-02-28 01:48:03'),(772,NULL,NULL,'GS_CARRIERS_EXCLUDED',NULL,'2019-02-28 00:55:01','2019-02-28 01:48:03'),(773,NULL,NULL,'GS_IMG_TYPE','large_default','2019-02-28 00:55:01','2019-02-28 00:55:01'),(774,NULL,NULL,'GS_MPN_TYPE','reference','2019-02-28 00:55:01','2019-02-28 00:55:01'),(775,NULL,NULL,'GS_GENDER',NULL,'2019-02-28 00:55:01','2019-02-28 00:55:01'),(776,NULL,NULL,'GS_AGE_GROUP',NULL,'2019-02-28 00:55:01','2019-02-28 00:55:01'),(777,NULL,NULL,'GS_ATTRIBUTES','0','2019-02-28 00:55:01','2019-02-28 00:55:01'),(778,NULL,NULL,'GS_COLOR',NULL,'2019-02-28 00:55:01','2019-02-28 00:55:01'),(779,NULL,NULL,'GS_MATERIAL',NULL,'2019-02-28 00:55:01','2019-02-28 00:55:01'),(780,NULL,NULL,'GS_PATTERN',NULL,'2019-02-28 00:55:01','2019-02-28 00:55:01'),(781,NULL,NULL,'GS_SIZE',NULL,'2019-02-28 00:55:01','2019-02-28 00:55:01'),(782,NULL,NULL,'GS_EXPORT_MIN_PRICE','0.00','2019-02-28 00:55:01','2019-02-28 00:55:01'),(783,NULL,NULL,'GS_NO_GTIN','1','2019-02-28 00:55:01','2019-02-28 01:48:03'),(784,NULL,NULL,'GS_NO_BRAND','1','2019-02-28 00:55:01','2019-02-28 01:48:03'),(785,NULL,NULL,'GS_ID_EXISTS_TAG','1','2019-02-28 00:55:01','2019-02-28 01:48:03'),(786,NULL,NULL,'GS_EXPORT_NAP',NULL,'2019-02-28 00:55:01','2019-02-28 01:48:03'),(787,NULL,NULL,'GS_QUANTITY','1','2019-02-28 00:55:01','2019-02-28 01:48:03'),(788,NULL,NULL,'GS_FEATURED_PRODUCTS','1','2019-02-28 00:55:01','2019-02-28 01:48:03'),(789,NULL,NULL,'GS_GEN_FILE_IN_ROOT','1','2019-02-28 00:55:01','2019-02-28 01:48:03'),(790,NULL,NULL,'GS_FILE_PREFIX',NULL,'2019-02-28 00:55:01','2019-02-28 00:55:01'),(791,NULL,NULL,'CATEGORYPRODUCTS_DISPLAY_PRICE','1','2019-03-20 17:31:03','2019-03-20 17:31:03'),(792,NULL,NULL,'CATEGORYPRODUCTS_DISPLAY_PRODUCTS','16','2019-03-20 17:31:03','2019-03-20 17:31:03'),(793,NULL,NULL,'CATEGORYPRODUCTS_DISPLAY_CURRENT','0','2019-03-20 22:22:19','2019-03-20 22:22:36'),(794,NULL,NULL,'CONF_ECPAY_FIXED','0.2','2019-07-03 20:45:17','2019-07-03 20:45:17'),(795,NULL,NULL,'CONF_ECPAY_VAR','2','2019-07-03 20:45:17','2019-07-03 20:45:17'),(796,NULL,NULL,'CONF_ECPAY_FIXED_FOREIGN','0.2','2019-07-03 20:45:17','2019-07-03 20:45:17'),(797,NULL,NULL,'CONF_ECPAY_VAR_FOREIGN','2','2019-07-03 20:45:17','2019-07-03 20:45:17'),(798,NULL,NULL,'ecpay_merchant_id','2000132','2019-07-03 20:47:18','2019-07-03 20:47:18'),(799,NULL,NULL,'ecpay_hash_key','5294y06JbISpM5x9','2019-07-03 20:47:18','2019-07-03 20:47:18'),(800,NULL,NULL,'ecpay_hash_iv','v77hoKGq4kWxNNIS','2019-07-03 20:47:18','2019-07-03 20:47:18'),(801,NULL,NULL,'ecpay_payment_credit','on','2019-07-03 20:47:18','2019-07-03 20:47:18'),(802,NULL,NULL,'ecpay_payment_credit_03','on','2019-07-03 20:47:18','2019-07-03 20:47:18'),(803,NULL,NULL,'ecpay_payment_webatm','on','2019-07-03 20:47:18','2020-02-16 23:31:39'),(804,NULL,NULL,'ecpay_payment_atm','on','2019-07-03 20:47:18','2019-07-03 20:47:18'),(805,NULL,NULL,'ecpay_payment_cvs','on','2019-07-03 20:47:18','2020-02-16 23:31:39'),(806,NULL,NULL,'ecpay_payment_barcode','on','2019-07-03 20:47:18','2020-02-16 23:31:39'),(807,NULL,NULL,'ecpay_payment_credit_06','on','2019-07-03 20:47:25','2019-07-03 20:47:25'),(808,NULL,NULL,'ecpay_payment_credit_12','on','2019-07-03 20:47:25','2019-07-03 20:47:25'),(809,NULL,NULL,'ecpay_payment_credit_18','on','2019-07-03 20:47:25','2020-02-16 23:31:39'),(810,NULL,NULL,'ecpay_payment_credit_24','on','2019-07-03 20:47:25','2020-02-16 23:31:39'),(811,NULL,NULL,'PS_WEBSERVICE',NULL,'2019-07-21 08:22:19','2020-04-15 23:22:14'),(812,NULL,NULL,'PS_WEBSERVICE_CGI_HOST',NULL,'2019-07-21 08:22:19','2020-04-15 23:22:14'),(813,NULL,NULL,'SIMPLICITY_DARK_MODE','0','2019-08-10 18:05:24','2019-08-10 18:06:29'),(814,NULL,NULL,'SIMPLICITY_LOGO_DISPLAY_TYPE','image','2019-08-10 19:20:41','2019-08-12 21:41:01'),(815,NULL,NULL,'SIMPLICITY_LOGO_DISPLAY_TEXT',NULL,'2019-08-10 19:20:41','2019-08-12 21:41:01'),(816,NULL,NULL,'SIMPLICITY_LOGO_DISPLAY_FONT',NULL,'2019-08-10 19:20:41','2019-08-30 16:10:52'),(817,NULL,NULL,'SIMPLICITY_LOGO_BODY_BG_CSS',NULL,'2019-08-10 19:20:41','2019-08-21 13:21:14'),(818,NULL,NULL,'SIMPLICITY_LOGO_MOBILE_TYPE','0','2019-08-12 22:48:06','2019-08-30 16:11:07'),(819,NULL,NULL,'NW_VOUCHER_CODE',NULL,'2019-08-15 10:52:37','2019-11-22 16:22:22'),(820,NULL,NULL,'NW_CONFIRMATION_EMAIL',NULL,'2019-08-15 10:59:57','2019-11-22 16:22:22'),(821,NULL,NULL,'NW_VERIFICATION_EMAIL',NULL,'2019-08-15 10:59:57','2019-11-22 16:22:22'),(822,NULL,NULL,'PS_BO_ALLOW_EMPLOYEE_FORM_LANG','0','2019-08-15 15:08:34','2019-08-15 15:21:26'),(823,NULL,NULL,'PS_FOLLOW_UP_SMTP_USER',NULL,'2019-08-18 01:01:07','2019-08-18 10:29:57'),(824,NULL,NULL,'PS_FOLLOW_UP_SMTP_PASSWD',NULL,'2019-08-18 01:01:07','2019-08-18 10:29:50'),(825,NULL,NULL,'SIMPLICITY_LOGO_MAX_WIDTH_CSS','w20','2019-08-20 20:10:13','2019-08-20 21:24:51'),(826,NULL,NULL,'SIMPLICITY_FOOTERBAR_HTML',NULL,'2019-08-30 18:00:26','2019-08-30 18:00:26'),(827,NULL,NULL,'PAYPAL_REQUIREMENTS','0','2019-10-08 15:05:37','2019-10-08 15:05:37'),(828,NULL,NULL,'PAYPAL_CONNECTION_EC_CONFIGURED','0','2019-10-09 17:49:46','2019-12-26 10:24:54'),(829,NULL,NULL,'PS_MAIL_THEME','modern','2019-10-11 15:08:37','2019-10-11 15:08:37'),(830,NULL,NULL,'PS_CONTACT_INFO_DISPLAY_EMAIL','0','2019-12-09 15:07:01','2020-03-21 22:11:12'),(831,NULL,NULL,'SIMPLICITY_FB_APP_SECRET',NULL,'2019-12-11 12:46:26','2019-12-30 21:24:54'),(832,NULL,NULL,'SIMPLICITY_G_APP_ID',NULL,'2019-12-30 15:31:13','2020-03-06 00:39:33'),(833,NULL,NULL,'SIMPLICITY_G_APP_SECRET',NULL,'2019-12-30 15:31:13','2020-03-06 00:39:33'),(834,NULL,NULL,'ezship_su_id',NULL,'2020-01-09 18:43:26','2020-01-29 00:11:14'),(835,NULL,NULL,'ezship_secret',NULL,'2020-01-09 18:43:26','2020-01-09 22:02:23'),(840,NULL,NULL,'ecpay_logistics_merchant_id',NULL,'2020-01-18 18:09:04','2020-01-27 22:06:22'),(841,NULL,NULL,'ecpay_logistics_hash_key',NULL,'2020-01-18 18:09:04','2020-01-27 22:06:22'),(842,NULL,NULL,'ecpay_logistics_hash_iv',NULL,'2020-01-18 18:09:04','2020-01-27 22:06:22'),(843,NULL,NULL,'ecpay_sender_name',NULL,'2020-01-18 18:09:04','2020-01-18 18:14:15'),(844,NULL,NULL,'ecpay_sender_cellphone',NULL,'2020-01-18 18:09:04','2020-01-18 18:14:15'),(845,NULL,NULL,'ecpay_sender_address',NULL,'2020-01-18 18:09:04','2020-01-19 00:15:37'),(846,NULL,NULL,'ecpay_sender_postcode',NULL,'2020-01-18 18:09:04','2020-01-18 23:19:13'),(848,NULL,NULL,'ezship_confirm_order','0','2020-01-23 12:02:02','2020-04-17 12:15:47'),(849,NULL,NULL,'ezship_enable_pod','0','2020-01-23 16:57:55','2020-04-17 11:30:10'),(850,NULL,NULL,'ecpay_logistics_type','c2c','2020-01-23 18:38:12','2020-01-27 22:05:21'),(851,NULL,NULL,'PAYPAL_CUSTOMIZE_ORDER_STATUS','0','2020-01-28 13:55:59','2020-01-28 13:55:59'),(852,NULL,NULL,'PAYPAL_OS_REFUNDED','7','2020-01-28 13:55:59','2020-01-28 13:55:59'),(853,NULL,NULL,'PAYPAL_OS_CANCELED','6','2020-01-28 13:55:59','2020-01-28 13:55:59'),(854,NULL,NULL,'PAYPAL_OS_ACCEPTED','2','2020-01-28 13:55:59','2020-01-28 13:55:59'),(855,NULL,NULL,'PAYPAL_OS_CAPTURE_CANCELED','6','2020-01-28 13:55:59','2020-01-28 13:55:59'),(856,NULL,NULL,'PAYPAL_OS_ACCEPTED_TWO','2','2020-01-28 13:55:59','2020-01-28 13:55:59'),(857,NULL,NULL,'PAYPAL_OS_WAITING_VALIDATION','23','2020-01-28 13:55:59','2020-01-28 13:55:59'),(858,NULL,NULL,'PAYPAL_OS_PROCESSING','23','2020-01-28 13:55:59','2020-01-28 13:55:59'),(859,NULL,NULL,'PAYPAL_OS_VALIDATION_ERROR','8','2020-01-28 13:55:59','2020-01-28 13:55:59'),(860,NULL,NULL,'PAYPAL_OS_REFUNDED_PAYPAL','7','2020-01-28 13:55:59','2020-01-28 13:55:59'),(861,NULL,NULL,'tc_711_sender_location','0','2020-01-30 02:01:17','2020-01-30 02:01:17'),(862,NULL,NULL,'tc_711_island_fee','40','2020-01-30 02:01:17','2020-01-30 02:31:35'),(863,NULL,NULL,'tc_711_penghu_store_ids','153869,195081,900795,951106,188201,941833,909574,113883,151391,922201,941202,930545,113506,880590,892571,901891,900762,987806,142869,184140,981750,166740','2020-01-30 02:01:17','2020-01-30 02:01:17'),(864,NULL,NULL,'PS_LOGO_WIDTH','1830','2020-02-24 22:29:20','2020-02-24 23:11:53'),(865,NULL,NULL,'PS_LOGO_SMALL','logo_small.jpg','2020-02-24 22:35:10','2020-02-24 23:11:53'),(866,NULL,NULL,'PS_LOGO_SMALL_WIDTH','450','2020-02-24 22:35:10','2020-02-24 22:35:10'),(867,NULL,NULL,'SIMPLICITY_GTM_SECRET',NULL,'2020-03-02 22:19:38','2020-03-02 22:19:38'),(868,NULL,NULL,'TC_SEARCH_SHOW_TAGS_IN_PRODUCT','1','2020-03-06 18:36:10','2020-03-06 18:42:33'),(869,NULL,NULL,'PS_FAVICON_PWA','favicon_144_1.png','2020-03-08 03:10:51','2020-03-08 03:15:04'),(870,NULL,NULL,'PS_FAVICON_PWAL','favicon_512_1.png','2020-03-08 03:10:51','2020-03-08 03:15:04'),(871,NULL,NULL,'SIMPLICITY_PWA_MODE',NULL,'2020-03-09 18:55:18','2020-03-15 20:34:44'),(872,NULL,NULL,'PS_CATALOG_MODE_WITH_PRICES','0','2020-03-18 21:00:13','2020-03-18 21:00:13'),(873,NULL,NULL,'TC_SEARCH_SHOW_SORT_IN_LISTING','0','2020-03-18 23:25:44','2020-03-19 00:20:16'),(874,NULL,NULL,'SIMPLICITY_URL_REDIRECT_BLOCK',NULL,'2020-03-26 00:52:04','2020-03-27 11:24:39'),(875,NULL,NULL,'tc_sender_address',NULL,'2020-04-09 19:27:15','2020-04-18 16:26:07'),(876,NULL,NULL,'tc_sender_postcode',NULL,'2020-04-09 19:27:15','2020-04-18 16:26:07'),(877,NULL,NULL,'tc_home_free_shipping_same_city','','2020-04-09 19:27:15','2020-04-18 16:41:34'),(878,NULL,NULL,'tc_home_free_shipping_island',NULL,'2020-04-09 19:27:15','2020-04-09 20:07:23'),(879,NULL,NULL,'tc_home_island_enable','1','2020-04-09 19:27:15','2020-04-18 16:32:11'),(880,NULL,NULL,'tc_home_island_fee','','2020-04-09 19:27:15','2020-04-18 16:34:43'),(881,NULL,NULL,'tc_parcel_pickup_time_enable','1','2020-04-09 19:27:15','2020-04-18 16:32:29'),(882,NULL,NULL,'tc_home_same_city_fee','','2020-04-11 13:39:41','2020-04-18 16:40:30'),(885,NULL,NULL,'tc_parcel_pickup_date_enable','1','2020-04-12 23:16:08','2020-04-18 16:32:29'),(886,NULL,NULL,'tc_parcel_pickup_date_begin','3','2020-04-12 23:16:08','2020-04-13 02:15:30'),(887,NULL,NULL,'tc_parcel_pickup_date_disable',NULL,'2020-04-12 23:16:08','2020-04-13 01:29:08');
/*!40000 ALTER TABLE `ps_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_configuration_kpi`
--

DROP TABLE IF EXISTS `ps_configuration_kpi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_configuration_kpi` (
  `id_configuration_kpi` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned DEFAULT NULL,
  `id_shop` int(11) unsigned DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `value` text,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_configuration_kpi`),
  KEY `name` (`name`),
  KEY `id_shop` (`id_shop`),
  KEY `id_shop_group` (`id_shop_group`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_configuration_kpi`
--

LOCK TABLES `ps_configuration_kpi` WRITE;
/*!40000 ALTER TABLE `ps_configuration_kpi` DISABLE KEYS */;
INSERT INTO `ps_configuration_kpi` VALUES (1,NULL,NULL,'DASHGOALS_TRAFFIC_01_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(2,NULL,NULL,'DASHGOALS_CONVERSION_01_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(3,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_01_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(4,NULL,NULL,'DASHGOALS_TRAFFIC_02_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(5,NULL,NULL,'DASHGOALS_CONVERSION_02_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(6,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_02_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(7,NULL,NULL,'DASHGOALS_TRAFFIC_03_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(8,NULL,NULL,'DASHGOALS_CONVERSION_03_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(9,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_03_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(10,NULL,NULL,'DASHGOALS_TRAFFIC_04_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(11,NULL,NULL,'DASHGOALS_CONVERSION_04_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(12,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_04_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(13,NULL,NULL,'DASHGOALS_TRAFFIC_05_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(14,NULL,NULL,'DASHGOALS_CONVERSION_05_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(15,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_05_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(16,NULL,NULL,'DASHGOALS_TRAFFIC_06_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(17,NULL,NULL,'DASHGOALS_CONVERSION_06_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(18,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_06_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(19,NULL,NULL,'DASHGOALS_TRAFFIC_07_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(20,NULL,NULL,'DASHGOALS_CONVERSION_07_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(21,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_07_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(22,NULL,NULL,'DASHGOALS_TRAFFIC_08_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(23,NULL,NULL,'DASHGOALS_CONVERSION_08_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(24,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_08_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(25,NULL,NULL,'DASHGOALS_TRAFFIC_09_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(26,NULL,NULL,'DASHGOALS_CONVERSION_09_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(27,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_09_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(28,NULL,NULL,'DASHGOALS_TRAFFIC_10_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(29,NULL,NULL,'DASHGOALS_CONVERSION_10_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(30,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_10_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(31,NULL,NULL,'DASHGOALS_TRAFFIC_11_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(32,NULL,NULL,'DASHGOALS_CONVERSION_11_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(33,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_11_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(34,NULL,NULL,'DASHGOALS_TRAFFIC_12_2018','600','2018-07-11 11:58:21','2018-07-11 11:58:21'),(35,NULL,NULL,'DASHGOALS_CONVERSION_12_2018','2','2018-07-11 11:58:21','2018-07-11 11:58:21'),(36,NULL,NULL,'DASHGOALS_AVG_CART_VALUE_12_2018','80','2018-07-11 11:58:21','2018-07-11 11:58:21'),(37,NULL,NULL,'TOP_CATEGORY',NULL,'2018-07-11 12:32:21','2018-07-11 12:32:21'),(38,NULL,NULL,'TOP_CATEGORY_EXPIRE',NULL,'2018-07-11 12:32:21','2018-07-11 12:32:21'),(39,NULL,NULL,'PRODUCTS_PER_CATEGORY','2','2018-07-11 12:32:21','2018-07-11 12:32:21'),(40,NULL,NULL,'PRODUCTS_PER_CATEGORY_EXPIRE','1531287141','2018-07-11 12:32:21','2018-07-11 12:32:21'),(41,NULL,NULL,'DISABLED_CATEGORIES','0','2018-07-11 12:32:21','2018-07-11 12:32:21'),(42,NULL,NULL,'DISABLED_CATEGORIES_EXPIRE','1531290741','2018-07-11 12:32:21','2018-07-11 12:32:21'),(43,NULL,NULL,'EMPTY_CATEGORIES','0','2018-07-11 12:32:21','2018-07-11 12:32:21'),(44,NULL,NULL,'EMPTY_CATEGORIES_EXPIRE','1531290741','2018-07-11 12:32:21','2018-07-11 12:32:21'),(45,NULL,NULL,'ORDERS_PER_CUSTOMER','0','2018-07-11 13:12:36','2018-07-11 13:12:36'),(46,NULL,NULL,'ORDERS_PER_CUSTOMER_EXPIRE','1531372356','2018-07-11 13:12:36','2018-07-11 13:12:36'),(47,NULL,NULL,'NEWSLETTER_REGISTRATIONS','0','2018-07-11 13:12:36','2018-07-11 13:12:36'),(48,NULL,NULL,'NEWSLETTER_REGISTRATIONS_EXPIRE','1531307556','2018-07-11 13:12:36','2018-07-11 13:12:36'),(49,NULL,NULL,'CUSTOMER_MAIN_GENDER',NULL,'2018-07-11 13:12:36','2018-07-11 13:12:36'),(50,NULL,NULL,'CUSTOMER_MAIN_GENDER_EXPIRE',NULL,'2018-07-11 13:12:36','2018-07-11 13:12:36'),(51,NULL,NULL,'AVG_CUSTOMER_AGE',NULL,'2018-07-11 13:12:36','2018-07-11 13:12:36'),(52,NULL,NULL,'AVG_CUSTOMER_AGE_EXPIRE',NULL,'2018-07-11 13:12:36','2018-07-11 13:12:36'),(53,NULL,NULL,'ABANDONED_CARTS','0','2018-07-11 13:13:43','2018-07-11 13:13:43'),(54,NULL,NULL,'ABANDONED_CARTS_EXPIRE','1531289623','2018-07-11 13:13:43','2018-07-11 13:13:43'),(55,NULL,NULL,'CONVERSION_RATE','0%','2018-07-11 13:13:43','2018-07-11 13:13:43'),(56,NULL,NULL,'CONVERSION_RATE_EXPIRE','1531324800','2018-07-11 13:13:43','2018-07-11 13:13:43'),(57,NULL,NULL,'NETPROFIT_VISIT','NT$0.00','2018-07-11 13:13:43','2018-07-11 13:13:43'),(58,NULL,NULL,'NETPROFIT_VISIT_EXPIRE','1531324800','2018-07-11 13:13:43','2018-07-11 13:13:43'),(59,NULL,NULL,'AVG_ORDER_VALUE','NT$0.00','2018-07-11 13:13:43','2018-07-11 13:13:43'),(60,NULL,NULL,'AVG_ORDER_VALUE_EXPIRE','1531324800','2018-07-11 13:13:43','2018-07-11 13:13:43'),(61,NULL,NULL,'MAIN_COUNTRY',NULL,'2018-07-11 23:04:50','2018-07-11 23:04:50'),(62,NULL,NULL,'MAIN_COUNTRY_EXPIRE',NULL,'2018-07-11 23:04:50','2018-07-11 23:04:50'),(63,NULL,NULL,'FRONTOFFICE_TRANSLATIONS','0%','2018-07-11 23:04:50','2018-07-11 23:04:50'),(64,NULL,NULL,'FRONTOFFICE_TRANSLATIONS_EXPIRE','1531321610','2018-07-11 23:04:50','2018-07-11 23:04:50'),(65,NULL,NULL,'ENABLED_LANGUAGES','1','2018-07-11 23:04:51','2018-07-11 23:04:51'),(66,NULL,NULL,'ENABLED_LANGUAGES_EXPIRE','1531321551','2018-07-11 23:04:51','2018-07-11 23:04:51'),(67,NULL,NULL,'AVG_MSG_RESPONSE_TIME','0 hours','2018-07-11 23:08:02','2018-07-11 23:08:02'),(68,NULL,NULL,'AVG_MSG_RESPONSE_TIME_EXPIRE','1531336082','2018-07-11 23:08:02','2018-07-11 23:08:02'),(69,NULL,NULL,'PENDING_MESSAGES','0','2018-07-11 23:08:02','2018-07-11 23:08:02'),(70,NULL,NULL,'PENDING_MESSAGES_EXPIRE','1531321982','2018-07-11 23:08:02','2018-07-11 23:08:02'),(71,NULL,NULL,'MESSAGES_PER_THREAD','0','2018-07-11 23:08:02','2018-07-11 23:08:02'),(72,NULL,NULL,'MESSAGES_PER_THREAD_EXPIRE','1531364882','2018-07-11 23:08:02','2018-07-11 23:08:02'),(73,1,1,'AVG_ORDER_VALUE','NT$0','2018-10-27 15:00:08','2018-10-27 15:00:08'),(74,1,1,'AVG_ORDER_VALUE_EXPIRE','1540656000','2018-10-27 15:00:08','2018-10-27 15:00:08'),(75,1,1,'ABANDONED_CARTS','0','2018-10-27 15:00:08','2018-10-27 15:00:08'),(76,1,1,'ABANDONED_CARTS_EXPIRE','1540627208','2018-10-27 15:00:08','2018-10-27 15:00:08'),(77,1,1,'CONVERSION_RATE','0%','2018-10-27 15:00:08','2018-10-27 15:00:08'),(78,1,1,'CONVERSION_RATE_EXPIRE','1540656000','2018-10-27 15:00:08','2018-10-27 15:00:08'),(79,1,1,'MESSAGES_PER_THREAD','0','2018-10-27 16:04:29','2018-10-27 16:04:29'),(80,1,1,'MESSAGES_PER_THREAD_EXPIRE','1540670669','2018-10-27 16:04:29','2018-10-27 16:04:29'),(81,1,1,'PENDING_MESSAGES','5','2018-10-27 16:04:29','2018-10-27 16:04:29'),(82,1,1,'PENDING_MESSAGES_EXPIRE','1540627769','2018-10-27 16:04:29','2018-10-27 16:04:29'),(83,1,1,'AVG_MSG_RESPONSE_TIME','0 hours','2018-10-27 16:04:29','2018-10-27 16:04:29'),(84,1,1,'AVG_MSG_RESPONSE_TIME_EXPIRE','1540641869','2018-10-27 16:04:29','2018-10-27 16:04:29');
/*!40000 ALTER TABLE `ps_configuration_kpi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_configuration_kpi_lang`
--

DROP TABLE IF EXISTS `ps_configuration_kpi_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_configuration_kpi_lang` (
  `id_configuration_kpi` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` text,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_configuration_kpi`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_configuration_kpi_lang`
--

LOCK TABLES `ps_configuration_kpi_lang` WRITE;
/*!40000 ALTER TABLE `ps_configuration_kpi_lang` DISABLE KEYS */;
INSERT INTO `ps_configuration_kpi_lang` VALUES (37,1,'Art','2018-07-11 12:32:21'),(37,2,NULL,NULL),(37,3,NULL,NULL),(37,4,NULL,NULL),(38,1,'1531369941','2018-07-11 12:32:21'),(38,2,NULL,NULL),(38,3,NULL,NULL),(38,4,NULL,NULL),(49,1,'無客戶','2018-07-11 13:12:36'),(49,2,NULL,NULL),(49,3,NULL,NULL),(49,4,NULL,NULL),(50,1,'1531372356','2018-07-11 13:12:36'),(50,2,NULL,NULL),(50,3,NULL,NULL),(50,4,NULL,NULL),(51,1,'0 years','2018-07-11 13:12:36'),(51,2,NULL,NULL),(51,3,NULL,NULL),(51,4,NULL,NULL),(52,1,'1531372356','2018-07-11 13:12:36'),(52,2,NULL,NULL),(52,3,NULL,NULL),(52,4,NULL,NULL),(61,1,'No orders','2018-07-11 23:04:50'),(62,1,'1531407890','2018-07-11 23:04:50');
/*!40000 ALTER TABLE `ps_configuration_kpi_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_configuration_lang`
--

DROP TABLE IF EXISTS `ps_configuration_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_configuration_lang` (
  `id_configuration` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` text,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_configuration`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_configuration_lang`
--

LOCK TABLES `ps_configuration_lang` WRITE;
/*!40000 ALTER TABLE `ps_configuration_lang` DISABLE KEYS */;
INSERT INTO `ps_configuration_lang` VALUES (39,1,'#IN',NULL),(39,2,'#IN',NULL),(39,3,'#IN',NULL),(39,4,'PS#-',NULL),(42,1,'#DE',NULL),(42,2,'#DE',NULL),(42,3,'#DE',NULL),(42,4,'RE#-',NULL),(44,1,'#RE',NULL),(44,2,'#RE',NULL),(44,3,'#RE',NULL),(44,4,'#RE',NULL),(51,1,'a|about|above|after|again|against|all|am|an|and|any|are|aren|as|at|be|because|been|before|being|below|between|both|but|by|can|cannot|could|couldn|did|didn|do|does|doesn|doing|don|down|during|each|few|for|from|further|had|hadn|has|hasn|have|haven|having|he|ll|her|here|hers|herself|him|himself|his|how|ve|if|in|into|is|isn|it|its|itself|let|me|more|most|mustn|my|myself|no|nor|not|of|off|on|once|only|or|other|ought|our|ours|ourselves|out|over|own|same|shan|she|should|shouldn|so|some|such|than|that|the|their|theirs|them|themselves|then|there|these|they|re|this|those|through|to|too|under|until|up|very|was|wasn|we|were|weren|what|when|where|which|while|who|whom|why|with|won|would|wouldn|you|your|yours|yourself|yourselves',NULL),(51,2,'a|about|above|after|again|against|all|am|an|and|any|are|aren|as|at|be|because|been|before|being|below|between|both|but|by|can|cannot|could|couldn|did|didn|do|does|doesn|doing|don|down|during|each|few|for|from|further|had|hadn|has|hasn|have|haven|having|he|ll|her|here|hers|herself|him|himself|his|how|ve|if|in|into|is|isn|it|its|itself|let|me|more|most|mustn|my|myself|no|nor|not|of|off|on|once|only|or|other|ought|our|ours|ourselves|out|over|own|same|shan|she|should|shouldn|so|some|such|than|that|the|their|theirs|them|themselves|then|there|these|they|re|this|those|through|to|too|under|until|up|very|was|wasn|we|were|weren|what|when|where|which|while|who|whom|why|with|won|would|wouldn|you|your|yours|yourself|yourselves',NULL),(51,3,'a|about|above|after|again|against|all|am|an|and|any|are|aren|as|at|be|because|been|before|being|below|between|both|but|by|can|cannot|could|couldn|did|didn|do|does|doesn|doing|don|down|during|each|few|for|from|further|had|hadn|has|hasn|have|haven|having|he|ll|her|here|hers|herself|him|himself|his|how|ve|if|in|into|is|isn|it|its|itself|let|me|more|most|mustn|my|myself|no|nor|not|of|off|on|once|only|or|other|ought|our|ours|ourselves|out|over|own|same|shan|she|should|shouldn|so|some|such|than|that|the|their|theirs|them|themselves|then|there|these|they|re|this|those|through|to|too|under|until|up|very|was|wasn|we|were|weren|what|when|where|which|while|who|whom|why|with|won|would|wouldn|you|your|yours|yourself|yourselves',NULL),(51,4,'a|about|above|after|again|against|all|am|an|and|any|are|aren|as|at|be|because|been|before|being|below|between|both|but|by|can|cannot|could|couldn|did|didn|do|does|doesn|doing|don|down|during|each|few|for|from|further|had|hadn|has|hasn|have|haven|having|he|ll|her|here|hers|herself|him|himself|his|how|ve|if|in|into|is|isn|it|its|itself|let|me|more|most|mustn|my|myself|no|nor|not|of|off|on|once|only|or|other|ought|our|ours|ourselves|out|over|own|same|shan|she|should|shouldn|so|some|such|than|that|the|their|theirs|them|themselves|then|there|these|they|re|this|those|through|to|too|under|until|up|very|was|wasn|we|were|weren|what|when|where|which|while|who|whom|why|with|won|would|wouldn|you|your|yours|yourself|yourselves',NULL),(77,1,'Dear Customer,\r\n\r\nRegards,\r\nCustomer service','2018-09-22 00:19:59'),(77,2,'Dear Customer,\r\n\r\nRegards,\r\nCustomer service',NULL),(77,3,'Dear Customer,\r\n\r\nRegards,\r\nCustomer service',NULL),(77,4,'Dear Customer,\r\n\r\nRegards,\r\nCustomer service',NULL),(277,1,'<p>我們正在進行維護作業，造成不便敬請見諒。我們很快就會回來，感謝您的耐心等候。</p>\n<p>We are currently updating our shop and will be back really soon. Thanks for your patience.</p>','2020-04-03 19:13:13'),(277,2,'<p>We are currently updating our shop and will be back really soon. Thanks for your patience.</p>','2020-04-03 19:13:13'),(277,3,'We are currently updating our shop and will be back really soon.\nThanks for your patience.','2020-04-03 19:13:13'),(277,4,'<p>We are currently updating our shop and will be back really soon. Thanks for your patience.</p>','2020-04-03 19:13:13'),(279,1,NULL,'2020-03-18 22:17:14'),(279,2,NULL,'2020-03-18 22:17:14'),(279,3,NULL,'2020-03-18 22:17:14'),(279,4,NULL,'2020-03-18 22:17:14'),(280,1,'補貨中','2018-07-30 11:15:24'),(280,2,NULL,'2020-03-18 22:17:14'),(280,3,NULL,'2020-03-18 22:17:14'),(280,4,NULL,'2020-03-18 22:17:14'),(281,1,'缺貨',NULL),(281,2,'Out-of-Stock',NULL),(281,3,'Out-of-Stock',NULL),(281,4,'Out-of-Stock',NULL),(292,1,'sample.png','2020-02-23 17:50:38'),(292,2,'sample.png','2020-02-23 17:49:18'),(292,3,'sample.png','2020-02-23 17:54:59'),(292,4,'sample.png','2018-07-11 22:16:02'),(293,1,'','2018-07-11 11:58:26'),(293,2,'','2018-07-11 11:58:26'),(293,3,'','2018-07-11 11:58:26'),(293,4,'','2018-07-11 22:16:02'),(294,1,'','2020-02-23 17:57:38'),(294,2,'','2018-07-11 11:58:26'),(294,3,'','2018-07-11 11:58:26'),(294,4,'','2018-07-11 22:16:02'),(301,1,'','2019-11-22 16:12:28'),(301,2,'','2018-07-11 11:58:34'),(301,3,'','2018-07-11 11:58:34'),(301,4,'','2018-07-11 11:58:34'),(415,1,NULL,'2020-03-18 22:17:14'),(415,2,NULL,'2020-03-18 22:17:14'),(415,3,NULL,'2020-03-18 22:17:14'),(415,4,NULL,'2020-03-18 22:17:14'),(416,1,NULL,'2020-03-18 22:17:14'),(416,2,NULL,'2020-03-18 22:17:14'),(416,3,NULL,'2020-03-18 22:17:14'),(416,4,NULL,'2020-03-18 22:17:14'),(425,1,'轉帳匯款完成之後，請從「聯絡我們」表單回傳：\r\n■ 訂單編號\r\n■ 付款日期\r\n■ 帳號末五碼 或 臨櫃匯款人姓名','2019-02-06 22:15:57'),(425,2,'After you complete the payment, please go to contact page and provide us:\r\n■ Order number\r\n■ Payment date\r\n■ Last five digits of your bank account','2019-11-19 19:04:41'),(425,3,'转帐汇款完成之后，请从「联络我们」表单回传：\r\n■ 订单编号\r\n■ 付款日期\r\n■ 帐号末五码 或 临柜汇款人姓名','2019-07-01 19:31:09'),(425,4,'振込み完了の場合、注文履歴に振込み指定日と振込をされた口座番号の末尾5桁を記入してください。\r\n(銀行(または郵便局)カウンターでの現金振り込みの場合はご依頼人の氏名を記入してください)\r\n','2019-07-01 19:35:32'),(568,1,'','2018-08-01 21:49:21'),(568,2,'','2018-08-01 21:49:21'),(568,3,'','2018-08-01 21:49:21'),(568,4,'','2018-08-01 21:49:21'),(569,1,'','2018-08-01 21:49:21'),(569,2,'','2018-08-01 21:49:21'),(569,3,'','2018-08-01 21:49:21'),(569,4,'','2018-08-01 21:49:21'),(589,1,'<div style=\"background:#b31a20;color:#ffffff;height:50px;line-height:50px;text-align:center;\">全館購物滿 1099元 免運費</div>','2018-09-06 19:37:03'),(589,2,'','2019-03-20 18:19:21'),(589,3,'','2019-03-20 18:19:21'),(589,4,'<div style=\"background:#b31a20;color:#ffffff;height:50px;line-height:50px;text-align:center;\">全品1099元以上の購入で送料無料</div>','2019-07-03 14:07:34'),(697,1,'<p>We are currently updating our shop and will be back really soon. Thanks for your patience.</p>','2018-10-22 23:11:12'),(718,1,'轉帳匯款完成之後，請從訂單紀錄回傳下方資訊：\r\n1. 付款日期\r\n2. 帳號末五碼 或 臨櫃匯款人姓名\r\n謝謝','2018-11-02 01:32:38'),(749,1,'編輯精選','2019-02-03 20:48:27'),(749,2,'Editor\'s Picks','2019-02-03 20:48:27'),(749,3,'Editor\'s Picks','2019-02-03 20:48:27'),(749,4,'おすすめ商品','2019-07-02 14:59:25'),(751,1,'熱賣商品','2019-02-08 19:21:29'),(751,2,'Best Sellers','2019-02-08 20:36:23'),(751,3,'Best Sellers','2019-02-08 20:36:23'),(751,4,'人気商品','2019-03-20 23:19:03'),(752,1,'新品上架','2018-11-17 16:12:01'),(752,2,'New Products','2018-11-17 16:12:01'),(752,3,'New Products','2018-11-17 16:12:01'),(752,4,'新作','2019-03-20 23:42:56'),(753,1,'特價商品','2018-11-17 16:17:24'),(753,2,'Price drop','2018-11-17 16:17:24'),(753,3,'Price drop','2018-11-17 16:17:24'),(753,4,'セール','2019-03-20 23:40:44'),(826,1,'','2019-08-30 18:00:40'),(826,2,'','2019-08-30 18:00:26'),(826,3,'','2019-08-30 18:00:26'),(826,4,'','2019-08-30 18:00:26');
/*!40000 ALTER TABLE `ps_configuration_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_connections`
--

DROP TABLE IF EXISTS `ps_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_connections` (
  `id_connections` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned NOT NULL DEFAULT '1',
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_guest` int(10) unsigned NOT NULL,
  `id_page` int(10) unsigned NOT NULL,
  `ip_address` bigint(20) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_connections`),
  KEY `id_guest` (`id_guest`),
  KEY `date_add` (`date_add`),
  KEY `id_page` (`id_page`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_connections`
--

LOCK TABLES `ps_connections` WRITE;
/*!40000 ALTER TABLE `ps_connections` DISABLE KEYS */;
INSERT INTO `ps_connections` VALUES (1,1,1,1,1,2130706433,'2020-04-20 08:57:56',''),(2,1,1,2,1,2130706433,'2020-04-20 08:57:56',''),(3,1,1,3,1,2130706433,'2020-04-20 08:58:05',''),(4,1,1,4,1,2130706433,'2020-04-20 08:58:05',''),(5,1,1,5,1,2130706433,'2020-04-20 08:59:17','');
/*!40000 ALTER TABLE `ps_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_connections_page`
--

DROP TABLE IF EXISTS `ps_connections_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_connections_page` (
  `id_connections` int(10) unsigned NOT NULL,
  `id_page` int(10) unsigned NOT NULL,
  `time_start` datetime NOT NULL,
  `time_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id_connections`,`id_page`,`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_connections_page`
--

LOCK TABLES `ps_connections_page` WRITE;
/*!40000 ALTER TABLE `ps_connections_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_connections_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_connections_source`
--

DROP TABLE IF EXISTS `ps_connections_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_connections_source` (
  `id_connections_source` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_connections` int(10) unsigned NOT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  `request_uri` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_connections_source`),
  KEY `connections` (`id_connections`),
  KEY `orderby` (`date_add`),
  KEY `http_referer` (`http_referer`),
  KEY `request_uri` (`request_uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_connections_source`
--

LOCK TABLES `ps_connections_source` WRITE;
/*!40000 ALTER TABLE `ps_connections_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_connections_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_contact`
--

DROP TABLE IF EXISTS `ps_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_contact` (
  `id_contact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `customer_service` tinyint(1) NOT NULL DEFAULT '0',
  `position` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_contact`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_contact`
--

LOCK TABLES `ps_contact` WRITE;
/*!40000 ALTER TABLE `ps_contact` DISABLE KEYS */;
INSERT INTO `ps_contact` VALUES (1,'admin@example.com',1,0);
/*!40000 ALTER TABLE `ps_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_contact_lang`
--

DROP TABLE IF EXISTS `ps_contact_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_contact_lang` (
  `id_contact` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id_contact`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_contact_lang`
--

LOCK TABLES `ps_contact_lang` WRITE;
/*!40000 ALTER TABLE `ps_contact_lang` DISABLE KEYS */;
INSERT INTO `ps_contact_lang` VALUES (1,1,'商店客服','關於商品或訂購問題'),(1,2,'Customer Service','If a technical problem occurs on this website'),(1,3,'Customer Service','If a technical problem occurs on this website'),(1,4,'Customer Service','ウェブサイトで技術的問題が発生したら');
/*!40000 ALTER TABLE `ps_contact_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_contact_shop`
--

DROP TABLE IF EXISTS `ps_contact_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_contact_shop` (
  `id_contact` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_contact`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_contact_shop`
--

LOCK TABLES `ps_contact_shop` WRITE;
/*!40000 ALTER TABLE `ps_contact_shop` DISABLE KEYS */;
INSERT INTO `ps_contact_shop` VALUES (1,1);
/*!40000 ALTER TABLE `ps_contact_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_country`
--

DROP TABLE IF EXISTS `ps_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_country` (
  `id_country` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_zone` int(10) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL DEFAULT '0',
  `iso_code` varchar(3) NOT NULL,
  `call_prefix` int(10) NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `contains_states` tinyint(1) NOT NULL DEFAULT '0',
  `need_identification_number` tinyint(1) NOT NULL DEFAULT '0',
  `need_zip_code` tinyint(1) NOT NULL DEFAULT '1',
  `zip_code_format` varchar(12) NOT NULL DEFAULT '',
  `display_tax_label` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_country`),
  KEY `country_iso_code` (`iso_code`),
  KEY `country_` (`id_zone`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_country`
--

LOCK TABLES `ps_country` WRITE;
/*!40000 ALTER TABLE `ps_country` DISABLE KEYS */;
INSERT INTO `ps_country` VALUES (1,1,0,'DE',49,0,0,0,1,'NNNNN',1),(2,1,0,'AT',43,0,0,0,1,'NNNN',1),(3,1,0,'BE',32,0,0,0,1,'NNNN',1),(4,2,0,'CA',1,0,1,0,1,'LNL NLN',0),(5,11,7,'CN',86,1,0,0,1,'NNNNNN',0),(6,1,0,'ES',34,0,0,1,1,'NNNNN',1),(7,1,0,'FI',358,0,0,0,1,'NNNNN',1),(8,1,0,'FR',33,0,0,0,1,'NNNNN',1),(9,1,0,'GR',30,0,0,0,1,'NNNNN',1),(10,1,0,'IT',39,0,1,0,1,'NNNNN',1),(11,10,0,'JP',81,1,0,0,1,'NNN-NNNN',0),(12,1,0,'LU',352,0,0,0,1,'NNNN',1),(13,1,0,'NL',31,0,0,0,1,'NNNN LL',1),(14,1,0,'PL',48,0,0,0,1,'NN-NNN',1),(15,1,0,'PT',351,0,0,0,1,'NNNN-NNN',1),(16,1,0,'CZ',420,0,0,0,1,'NNN NN',1),(17,1,0,'GB',44,0,0,0,1,'',1),(18,1,0,'SE',46,0,0,0,1,'NNN NN',1),(19,7,0,'CH',41,0,0,0,1,'NNNN',1),(20,1,0,'DK',45,0,0,0,1,'NNNN',1),(21,2,3,'US',1,1,1,0,1,'NNNNN',0),(22,3,6,'HK',852,1,0,0,1,'',0),(23,7,0,'NO',47,0,0,0,1,'NNNN',1),(24,5,0,'AU',61,0,1,0,1,'NNNN',1),(25,3,0,'SG',65,1,0,0,1,'NNNNNN',0),(26,1,0,'IE',353,0,0,0,0,'',1),(27,5,0,'NZ',64,0,0,0,1,'NNNN',1),(28,3,0,'KR',82,0,0,0,1,'NNN-NNN',1),(29,3,0,'IL',972,0,0,0,1,'NNNNNNN',1),(30,4,0,'ZA',27,0,0,0,1,'NNNN',1),(31,4,0,'NG',234,0,0,0,1,'',1),(32,4,0,'CI',225,0,0,0,1,'',1),(33,4,0,'TG',228,0,0,0,1,'',1),(34,6,0,'BO',591,0,0,0,1,'',1),(35,4,0,'MU',230,0,0,0,1,'',1),(36,1,0,'RO',40,0,0,0,1,'NNNNNN',1),(37,1,0,'SK',421,0,0,0,1,'NNN NN',1),(38,4,0,'DZ',213,0,0,0,1,'NNNNN',1),(39,2,0,'AS',0,0,0,0,1,'',1),(40,7,0,'AD',376,0,0,0,1,'CNNN',1),(41,4,0,'AO',244,0,0,0,0,'',1),(42,8,0,'AI',0,0,0,0,1,'',1),(43,2,0,'AG',0,0,0,0,1,'',1),(44,6,0,'AR',54,0,1,0,1,'LNNNNLLL',1),(45,3,0,'AM',374,0,0,0,1,'NNNN',1),(46,8,0,'AW',297,0,0,0,1,'',1),(47,3,0,'AZ',994,0,0,0,1,'CNNNN',1),(48,2,0,'BS',0,0,0,0,1,'',1),(49,3,0,'BH',973,0,0,0,1,'',1),(50,3,0,'BD',880,0,0,0,1,'NNNN',1),(51,2,0,'BB',0,0,0,0,1,'CNNNNN',1),(52,7,0,'BY',0,0,0,0,1,'NNNNNN',1),(53,8,0,'BZ',501,0,0,0,0,'',1),(54,4,0,'BJ',229,0,0,0,0,'',1),(55,2,0,'BM',0,0,0,0,1,'',1),(56,3,0,'BT',975,0,0,0,1,'',1),(57,4,0,'BW',267,0,0,0,1,'',1),(58,6,0,'BR',55,0,0,0,1,'NNNNN-NNN',1),(59,3,0,'BN',673,0,0,0,1,'LLNNNN',1),(60,4,0,'BF',226,0,0,0,1,'',1),(61,3,0,'MM',95,0,0,0,1,'',1),(62,4,0,'BI',257,0,0,0,1,'',1),(63,3,0,'KH',855,0,0,0,1,'NNNNN',1),(64,4,0,'CM',237,0,0,0,1,'',1),(65,4,0,'CV',238,0,0,0,1,'NNNN',1),(66,4,0,'CF',236,0,0,0,1,'',1),(67,4,0,'TD',235,0,0,0,1,'',1),(68,6,0,'CL',56,0,0,0,1,'NNN-NNNN',1),(69,6,0,'CO',57,0,0,0,1,'NNNNNN',1),(70,4,0,'KM',269,0,0,0,1,'',1),(71,4,0,'CD',242,0,0,0,1,'',1),(72,4,0,'CG',243,0,0,0,1,'',1),(73,8,0,'CR',506,0,0,0,1,'NNNNN',1),(74,7,0,'HR',385,0,0,0,1,'NNNNN',1),(75,8,0,'CU',53,0,0,0,1,'',1),(76,1,0,'CY',357,0,0,0,1,'NNNN',1),(77,4,0,'DJ',253,0,0,0,1,'',1),(78,8,0,'DM',0,0,0,0,1,'',1),(79,8,0,'DO',0,0,0,0,1,'',1),(80,3,0,'TL',670,0,0,0,1,'',1),(81,6,0,'EC',593,0,0,0,1,'CNNNNNN',1),(82,4,0,'EG',20,0,0,0,1,'NNNNN',1),(83,8,0,'SV',503,0,0,0,1,'',1),(84,4,0,'GQ',240,0,0,0,1,'',1),(85,4,0,'ER',291,0,0,0,1,'',1),(86,1,0,'EE',372,0,0,0,1,'NNNNN',1),(87,4,0,'ET',251,0,0,0,1,'',1),(88,8,0,'FK',0,0,0,0,1,'LLLL NLL',1),(89,7,0,'FO',298,0,0,0,1,'',1),(90,5,0,'FJ',679,0,0,0,1,'',1),(91,4,0,'GA',241,0,0,0,1,'',1),(92,4,0,'GM',220,0,0,0,1,'',1),(93,3,0,'GE',995,0,0,0,1,'NNNN',1),(94,4,0,'GH',233,0,0,0,1,'',1),(95,8,0,'GD',0,0,0,0,1,'',1),(96,7,0,'GL',299,0,0,0,1,'',1),(97,7,0,'GI',350,0,0,0,1,'',1),(98,8,0,'GP',590,0,0,0,1,'',1),(99,5,0,'GU',0,0,0,0,1,'',1),(100,8,0,'GT',502,0,0,0,1,'',1),(101,7,0,'GG',0,0,0,0,1,'LLN NLL',1),(102,4,0,'GN',224,0,0,0,1,'',1),(103,4,0,'GW',245,0,0,0,1,'',1),(104,6,0,'GY',592,0,0,0,1,'',1),(105,8,0,'HT',509,0,0,0,1,'',1),(106,5,0,'HM',0,0,0,0,1,'',1),(107,7,0,'VA',379,0,0,0,1,'NNNNN',1),(108,8,0,'HN',504,0,0,0,1,'',1),(109,7,0,'IS',354,0,0,0,1,'NNN',1),(110,3,0,'IN',91,0,0,0,1,'NNN NNN',1),(111,3,0,'ID',62,0,1,0,1,'NNNNN',1),(112,3,0,'IR',98,0,0,0,1,'NNNNN-NNNNN',1),(113,3,0,'IQ',964,0,0,0,1,'NNNNN',1),(114,7,0,'IM',0,0,0,0,1,'CN NLL',1),(115,8,0,'JM',0,0,0,0,1,'',1),(116,7,0,'JE',0,0,0,0,1,'CN NLL',1),(117,3,0,'JO',962,0,0,0,1,'',1),(118,3,0,'KZ',7,0,0,0,1,'NNNNNN',1),(119,4,0,'KE',254,0,0,0,1,'',1),(120,5,0,'KI',686,0,0,0,1,'',1),(121,3,0,'KP',850,0,0,0,1,'',1),(122,3,0,'KW',965,0,0,0,1,'',1),(123,3,0,'KG',996,0,0,0,1,'',1),(124,3,0,'LA',856,0,0,0,1,'',1),(125,1,0,'LV',371,0,0,0,1,'C-NNNN',1),(126,3,0,'LB',961,0,0,0,1,'',1),(127,4,0,'LS',266,0,0,0,1,'',1),(128,4,0,'LR',231,0,0,0,1,'',1),(129,4,0,'LY',218,0,0,0,1,'',1),(130,1,0,'LI',423,0,0,0,1,'NNNN',1),(131,1,0,'LT',370,0,0,0,1,'NNNNN',1),(132,3,0,'MO',853,0,0,0,0,'',1),(133,7,0,'MK',389,0,0,0,1,'',1),(134,4,0,'MG',261,0,0,0,1,'',1),(135,4,0,'MW',265,0,0,0,1,'',1),(136,3,0,'MY',60,1,0,0,1,'NNNNN',0),(137,3,0,'MV',960,0,0,0,1,'',1),(138,4,0,'ML',223,0,0,0,1,'',1),(139,1,0,'MT',356,0,0,0,1,'LLL NNNN',1),(140,5,0,'MH',692,0,0,0,1,'',1),(141,8,0,'MQ',596,0,0,0,1,'',1),(142,4,0,'MR',222,0,0,0,1,'',1),(143,1,0,'HU',36,0,0,0,1,'NNNN',1),(144,4,0,'YT',262,0,0,0,1,'',1),(145,2,0,'MX',52,0,1,1,1,'NNNNN',1),(146,5,0,'FM',691,0,0,0,1,'',1),(147,7,0,'MD',373,0,0,0,1,'C-NNNN',1),(148,7,0,'MC',377,0,0,0,1,'980NN',1),(149,3,0,'MN',976,0,0,0,1,'',1),(150,7,0,'ME',382,0,0,0,1,'NNNNN',1),(151,8,0,'MS',0,0,0,0,1,'',1),(152,4,0,'MA',212,0,0,0,1,'NNNNN',1),(153,4,0,'MZ',258,0,0,0,1,'',1),(154,4,0,'NA',264,0,0,0,1,'',1),(155,5,0,'NR',674,0,0,0,1,'',1),(156,3,0,'NP',977,0,0,0,1,'',1),(157,8,0,'AN',599,0,0,0,1,'',1),(158,5,0,'NC',687,0,0,0,1,'',1),(159,8,0,'NI',505,0,0,0,1,'NNNNNN',1),(160,4,0,'NE',227,0,0,0,1,'',1),(161,5,0,'NU',683,0,0,0,1,'',1),(162,5,0,'NF',0,0,0,0,1,'',1),(163,5,0,'MP',0,0,0,0,1,'',1),(164,3,0,'OM',968,0,0,0,1,'',1),(165,3,0,'PK',92,0,0,0,1,'',1),(166,5,0,'PW',680,0,0,0,1,'',1),(167,3,0,'PS',0,0,0,0,1,'',1),(168,8,0,'PA',507,0,0,0,1,'NNNNNN',1),(169,5,0,'PG',675,0,0,0,1,'',1),(170,6,0,'PY',595,0,0,0,1,'',1),(171,6,0,'PE',51,0,0,0,1,'',1),(172,3,0,'PH',63,0,0,0,1,'NNNN',1),(173,5,0,'PN',0,0,0,0,1,'LLLL NLL',1),(174,8,0,'PR',0,0,0,0,1,'NNNNN',1),(175,3,0,'QA',974,0,0,0,1,'',1),(176,4,0,'RE',262,0,0,0,1,'',1),(177,7,0,'RU',7,0,0,0,1,'NNNNNN',1),(178,4,0,'RW',250,0,0,0,1,'',1),(179,8,0,'BL',0,0,0,0,1,'',1),(180,8,0,'KN',0,0,0,0,1,'',1),(181,8,0,'LC',0,0,0,0,1,'',1),(182,8,0,'MF',0,0,0,0,1,'',1),(183,8,0,'PM',508,0,0,0,1,'',1),(184,8,0,'VC',0,0,0,0,1,'',1),(185,5,0,'WS',685,0,0,0,1,'',1),(186,7,0,'SM',378,0,0,0,1,'NNNNN',1),(187,4,0,'ST',239,0,0,0,1,'',1),(188,3,0,'SA',966,0,0,0,1,'',1),(189,4,0,'SN',221,0,0,0,1,'',1),(190,7,0,'RS',381,0,0,0,1,'NNNNN',1),(191,4,0,'SC',248,0,0,0,1,'',1),(192,4,0,'SL',232,0,0,0,1,'',1),(193,1,0,'SI',386,0,0,0,1,'C-NNNN',1),(194,5,0,'SB',677,0,0,0,1,'',1),(195,4,0,'SO',252,0,0,0,1,'',1),(196,8,0,'GS',0,0,0,0,1,'LLLL NLL',1),(197,3,0,'LK',94,0,0,0,1,'NNNNN',1),(198,4,0,'SD',249,0,0,0,1,'',1),(199,8,0,'SR',597,0,0,0,1,'',1),(200,7,0,'SJ',0,0,0,0,1,'',1),(201,4,0,'SZ',268,0,0,0,1,'',1),(202,3,0,'SY',963,0,0,0,1,'',1),(203,9,1,'TW',886,1,0,0,1,'',0),(204,3,0,'TJ',992,0,0,0,1,'',1),(205,4,0,'TZ',255,0,0,0,1,'',1),(206,3,0,'TH',66,0,0,0,1,'NNNNN',1),(207,5,0,'TK',690,0,0,0,1,'',1),(208,5,0,'TO',676,0,0,0,1,'',1),(209,6,0,'TT',0,0,0,0,1,'',1),(210,4,0,'TN',216,0,0,0,1,'',1),(211,7,0,'TR',90,0,0,0,1,'NNNNN',1),(212,3,0,'TM',993,0,0,0,1,'',1),(213,8,0,'TC',0,0,0,0,1,'LLLL NLL',1),(214,5,0,'TV',688,0,0,0,1,'',1),(215,4,0,'UG',256,0,0,0,1,'',1),(216,1,0,'UA',380,0,0,0,1,'NNNNN',1),(217,3,0,'AE',971,0,0,0,1,'',1),(218,6,0,'UY',598,0,0,0,1,'',1),(219,3,0,'UZ',998,0,0,0,1,'',1),(220,5,0,'VU',678,0,0,0,1,'',1),(221,6,0,'VE',58,0,0,0,1,'',1),(222,3,0,'VN',84,0,0,0,1,'NNNNNN',1),(223,2,0,'VG',0,0,0,0,1,'CNNNN',1),(224,2,0,'VI',0,0,0,0,1,'',1),(225,5,0,'WF',681,0,0,0,1,'',1),(226,4,0,'EH',0,0,0,0,1,'',1),(227,3,0,'YE',967,0,0,0,1,'',1),(228,4,0,'ZM',260,0,0,0,1,'',1),(229,4,0,'ZW',263,0,0,0,1,'',1),(230,7,0,'AL',355,0,0,0,1,'NNNN',1),(231,3,0,'AF',93,0,0,0,1,'NNNN',1),(232,5,0,'AQ',0,0,0,0,1,'',1),(233,1,0,'BA',387,0,0,0,1,'',1),(234,5,0,'BV',0,0,0,0,1,'',1),(235,5,0,'IO',0,0,0,0,1,'LLLL NLL',1),(236,1,0,'BG',359,0,0,0,1,'NNNN',1),(237,8,0,'KY',0,0,0,0,1,'',1),(238,3,0,'CX',0,0,0,0,1,'',1),(239,3,0,'CC',0,0,0,0,1,'',1),(240,5,0,'CK',682,0,0,0,1,'',1),(241,6,0,'GF',594,0,0,0,1,'',1),(242,5,0,'PF',689,0,0,0,1,'',1),(243,5,0,'TF',0,0,0,0,1,'',1),(244,7,0,'AX',0,0,0,0,1,'NNNNN',1),(245,12,1,'CVS',886,1,0,0,0,'',0);
/*!40000 ALTER TABLE `ps_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_country_lang`
--

DROP TABLE IF EXISTS `ps_country_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_country_lang` (
  `id_country` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id_country`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_country_lang`
--

LOCK TABLES `ps_country_lang` WRITE;
/*!40000 ALTER TABLE `ps_country_lang` DISABLE KEYS */;
INSERT INTO `ps_country_lang` VALUES (1,1,'Germany'),(1,2,'Germany'),(1,3,'Germany'),(1,4,'Germany'),(2,1,'Austria'),(2,2,'Austria'),(2,3,'Austria'),(2,4,'Austria'),(3,1,'Belgium'),(3,2,'Belgium'),(3,3,'Belgium'),(3,4,'Belgium'),(4,1,'Canada'),(4,2,'Canada'),(4,3,'Canada'),(4,4,'Canada'),(5,1,'中國'),(5,2,'China'),(5,3,'China'),(5,4,'中国'),(6,1,'Spain'),(6,2,'Spain'),(6,3,'Spain'),(6,4,'Spain'),(7,1,'Finland'),(7,2,'Finland'),(7,3,'Finland'),(7,4,'Finland'),(8,1,'France'),(8,2,'France'),(8,3,'France'),(8,4,'France'),(9,1,'Greece'),(9,2,'Greece'),(9,3,'Greece'),(9,4,'Greece'),(10,1,'Italy'),(10,2,'Italy'),(10,3,'Italy'),(10,4,'Italy'),(11,1,'日本'),(11,2,'Japan'),(11,3,'Japan'),(11,4,'日本'),(12,1,'Luxemburg'),(12,2,'Luxembourg'),(12,3,'Luxemburg'),(12,4,'Luxemburg'),(13,1,'Netherlands'),(13,2,'Netherlands'),(13,3,'Netherlands'),(13,4,'Netherlands'),(14,1,'Poland'),(14,2,'Poland'),(14,3,'Poland'),(14,4,'Poland'),(15,1,'Portugal'),(15,2,'Portugal'),(15,3,'Portugal'),(15,4,'Portugal'),(16,1,'Czech Republic'),(16,2,'Czech Republic'),(16,3,'Czech Republic'),(16,4,'Czech Republic'),(17,1,'United Kingdom'),(17,2,'United Kingdom'),(17,3,'United Kingdom'),(17,4,'United Kingdom'),(18,1,'Sweden'),(18,2,'Sweden'),(18,3,'Sweden'),(18,4,'Sweden'),(19,1,'Switzerland'),(19,2,'Switzerland'),(19,3,'Switzerland'),(19,4,'Switzerland'),(20,1,'Denmark'),(20,2,'Denmark'),(20,3,'Denmark'),(20,4,'Denmark'),(21,1,'美國'),(21,2,'United States'),(21,3,'United States'),(21,4,'アメリカ'),(22,1,'香港'),(22,2,'Hong Kong'),(22,3,'Hong Kong'),(22,4,'香港'),(23,1,'Norway'),(23,2,'Norway'),(23,3,'Norway'),(23,4,'Norway'),(24,1,'Australia'),(24,2,'Australia'),(24,3,'Australia'),(24,4,'Australia'),(25,1,'新加坡'),(25,2,'Singapore'),(25,3,'Singapore'),(25,4,'シンガポール'),(26,1,'Ireland'),(26,2,'Ireland'),(26,3,'Ireland'),(26,4,'Ireland'),(27,1,'New Zealand'),(27,2,'New Zealand'),(27,3,'New Zealand'),(27,4,'New Zealand'),(28,1,'South Korea'),(28,2,'South Korea'),(28,3,'South Korea'),(28,4,'South Korea'),(29,1,'Israel'),(29,2,'Israel'),(29,3,'Israel'),(29,4,'Israel'),(30,1,'South Africa'),(30,2,'South Africa'),(30,3,'South Africa'),(30,4,'South Africa'),(31,1,'Nigeria'),(31,2,'Nigeria'),(31,3,'Nigeria'),(31,4,'Nigeria'),(32,1,'Ivory Coast'),(32,2,'Côte D’Ivoire'),(32,3,'Ivory Coast'),(32,4,'Ivory Coast'),(33,1,'Togo'),(33,2,'Togo'),(33,3,'Togo'),(33,4,'Togo'),(34,1,'Bolivia'),(34,2,'Bolivia'),(34,3,'Bolivia'),(34,4,'Bolivia'),(35,1,'Mauritius'),(35,2,'Mauritius'),(35,3,'Mauritius'),(35,4,'Mauritius'),(36,1,'Romania'),(36,2,'Romania'),(36,3,'Romania'),(36,4,'Romania'),(37,1,'Slovakia'),(37,2,'Slovakia'),(37,3,'Slovakia'),(37,4,'Slovakia'),(38,1,'Algeria'),(38,2,'Algeria'),(38,3,'Algeria'),(38,4,'Algeria'),(39,1,'American Samoa'),(39,2,'American Samoa'),(39,3,'American Samoa'),(39,4,'American Samoa'),(40,1,'Andorra'),(40,2,'Andorra'),(40,3,'Andorra'),(40,4,'Andorra'),(41,1,'Angola'),(41,2,'Angola'),(41,3,'Angola'),(41,4,'Angola'),(42,1,'Anguilla'),(42,2,'Anguilla'),(42,3,'Anguilla'),(42,4,'Anguilla'),(43,1,'Antigua and Barbuda'),(43,2,'Antigua & Barbuda'),(43,3,'Antigua and Barbuda'),(43,4,'Antigua and Barbuda'),(44,1,'Argentina'),(44,2,'Argentina'),(44,3,'Argentina'),(44,4,'Argentina'),(45,1,'Armenia'),(45,2,'Armenia'),(45,3,'Armenia'),(45,4,'Armenia'),(46,1,'Aruba'),(46,2,'Aruba'),(46,3,'Aruba'),(46,4,'Aruba'),(47,1,'Azerbaijan'),(47,2,'Azerbaijan'),(47,3,'Azerbaijan'),(47,4,'Azerbaijan'),(48,1,'Bahamas'),(48,2,'Bahamas'),(48,3,'Bahamas'),(48,4,'Bahamas'),(49,1,'Bahrain'),(49,2,'Bahrain'),(49,3,'Bahrain'),(49,4,'Bahrain'),(50,1,'Bangladesh'),(50,2,'Bangladesh'),(50,3,'Bangladesh'),(50,4,'Bangladesh'),(51,1,'Barbados'),(51,2,'Barbados'),(51,3,'Barbados'),(51,4,'Barbados'),(52,1,'Belarus'),(52,2,'Belarus'),(52,3,'Belarus'),(52,4,'Belarus'),(53,1,'Belize'),(53,2,'Belize'),(53,3,'Belize'),(53,4,'Belize'),(54,1,'Benin'),(54,2,'Benin'),(54,3,'Benin'),(54,4,'Benin'),(55,1,'Bermuda'),(55,2,'Bermuda'),(55,3,'Bermuda'),(55,4,'Bermuda'),(56,1,'Bhutan'),(56,2,'Bhutan'),(56,3,'Bhutan'),(56,4,'Bhutan'),(57,1,'Botswana'),(57,2,'Botswana'),(57,3,'Botswana'),(57,4,'Botswana'),(58,1,'Brazil'),(58,2,'Brazil'),(58,3,'Brazil'),(58,4,'Brazil'),(59,1,'Brunei'),(59,2,'Brunei'),(59,3,'Brunei'),(59,4,'Brunei'),(60,1,'Burkina Faso'),(60,2,'Burkina Faso'),(60,3,'Burkina Faso'),(60,4,'Burkina Faso'),(61,1,'Burma (Myanmar)'),(61,2,'Myanmar (Burma)'),(61,3,'Burma (Myanmar)'),(61,4,'Burma (Myanmar)'),(62,1,'Burundi'),(62,2,'Burundi'),(62,3,'Burundi'),(62,4,'Burundi'),(63,1,'Cambodia'),(63,2,'Cambodia'),(63,3,'Cambodia'),(63,4,'Cambodia'),(64,1,'Cameroon'),(64,2,'Cameroon'),(64,3,'Cameroon'),(64,4,'Cameroon'),(65,1,'Cape Verde'),(65,2,'Cape Verde'),(65,3,'Cape Verde'),(65,4,'Cape Verde'),(66,1,'Central African Republic'),(66,2,'Central African Republic'),(66,3,'Central African Republic'),(66,4,'Central African Republic'),(67,1,'Chad'),(67,2,'Chad'),(67,3,'Chad'),(67,4,'Chad'),(68,1,'Chile'),(68,2,'Chile'),(68,3,'Chile'),(68,4,'Chile'),(69,1,'Colombia'),(69,2,'Colombia'),(69,3,'Colombia'),(69,4,'Colombia'),(70,1,'Comoros'),(70,2,'Comoros'),(70,3,'Comoros'),(70,4,'Comoros'),(71,1,'Congo, Dem. Republic'),(71,2,'Congo - Kinshasa'),(71,3,'Congo, Dem. Republic'),(71,4,'Congo, Dem. Republic'),(72,1,'Congo, Republic'),(72,2,'Congo - Brazzaville'),(72,3,'Congo, Republic'),(72,4,'Congo, Republic'),(73,1,'Costa Rica'),(73,2,'Costa Rica'),(73,3,'Costa Rica'),(73,4,'Costa Rica'),(74,1,'Croatia'),(74,2,'Croatia'),(74,3,'Croatia'),(74,4,'Croatia'),(75,1,'Cuba'),(75,2,'Cuba'),(75,3,'Cuba'),(75,4,'Cuba'),(76,1,'Cyprus'),(76,2,'Cyprus'),(76,3,'Cyprus'),(76,4,'Cyprus'),(77,1,'Djibouti'),(77,2,'Djibouti'),(77,3,'Djibouti'),(77,4,'Djibouti'),(78,1,'Dominica'),(78,2,'Dominica'),(78,3,'Dominica'),(78,4,'Dominica'),(79,1,'Dominican Republic'),(79,2,'Dominican Republic'),(79,3,'Dominican Republic'),(79,4,'Dominican Republic'),(80,1,'East Timor'),(80,2,'Timor-Leste'),(80,3,'East Timor'),(80,4,'East Timor'),(81,1,'Ecuador'),(81,2,'Ecuador'),(81,3,'Ecuador'),(81,4,'Ecuador'),(82,1,'Egypt'),(82,2,'Egypt'),(82,3,'Egypt'),(82,4,'Egypt'),(83,1,'El Salvador'),(83,2,'El Salvador'),(83,3,'El Salvador'),(83,4,'El Salvador'),(84,1,'Equatorial Guinea'),(84,2,'Equatorial Guinea'),(84,3,'Equatorial Guinea'),(84,4,'Equatorial Guinea'),(85,1,'Eritrea'),(85,2,'Eritrea'),(85,3,'Eritrea'),(85,4,'Eritrea'),(86,1,'Estonia'),(86,2,'Estonia'),(86,3,'Estonia'),(86,4,'Estonia'),(87,1,'Ethiopia'),(87,2,'Ethiopia'),(87,3,'Ethiopia'),(87,4,'Ethiopia'),(88,1,'Falkland Islands'),(88,2,'Falkland Islands'),(88,3,'Falkland Islands'),(88,4,'Falkland Islands'),(89,1,'Faroe Islands'),(89,2,'Faroe Islands'),(89,3,'Faroe Islands'),(89,4,'Faroe Islands'),(90,1,'Fiji'),(90,2,'Fiji'),(90,3,'Fiji'),(90,4,'Fiji'),(91,1,'Gabon'),(91,2,'Gabon'),(91,3,'Gabon'),(91,4,'Gabon'),(92,1,'Gambia'),(92,2,'Gambia'),(92,3,'Gambia'),(92,4,'Gambia'),(93,1,'Georgia'),(93,2,'Georgia'),(93,3,'Georgia'),(93,4,'Georgia'),(94,1,'Ghana'),(94,2,'Ghana'),(94,3,'Ghana'),(94,4,'Ghana'),(95,1,'Grenada'),(95,2,'Grenada'),(95,3,'Grenada'),(95,4,'Grenada'),(96,1,'Greenland'),(96,2,'Greenland'),(96,3,'Greenland'),(96,4,'Greenland'),(97,1,'Gibraltar'),(97,2,'Gibraltar'),(97,3,'Gibraltar'),(97,4,'Gibraltar'),(98,1,'Guadeloupe'),(98,2,'Guadeloupe'),(98,3,'Guadeloupe'),(98,4,'Guadeloupe'),(99,1,'Guam'),(99,2,'Guam'),(99,3,'Guam'),(99,4,'Guam'),(100,1,'Guatemala'),(100,2,'Guatemala'),(100,3,'Guatemala'),(100,4,'Guatemala'),(101,1,'Guernsey'),(101,2,'Guernsey'),(101,3,'Guernsey'),(101,4,'Guernsey'),(102,1,'Guinea'),(102,2,'Guinea'),(102,3,'Guinea'),(102,4,'Guinea'),(103,1,'Guinea-Bissau'),(103,2,'Guinea-Bissau'),(103,3,'Guinea-Bissau'),(103,4,'Guinea-Bissau'),(104,1,'Guyana'),(104,2,'Guyana'),(104,3,'Guyana'),(104,4,'Guyana'),(105,1,'Haiti'),(105,2,'Haiti'),(105,3,'Haiti'),(105,4,'Haiti'),(106,1,'Heard Island and McDonald Islands'),(106,2,'Heard & McDonald Islands'),(106,3,'Heard Island and McDonald Islands'),(106,4,'Heard Island and McDonald Islands'),(107,1,'Vatican City State'),(107,2,'Vatican City'),(107,3,'Vatican City State'),(107,4,'Vatican City State'),(108,1,'Honduras'),(108,2,'Honduras'),(108,3,'Honduras'),(108,4,'Honduras'),(109,1,'Iceland'),(109,2,'Iceland'),(109,3,'Iceland'),(109,4,'Iceland'),(110,1,'India'),(110,2,'India'),(110,3,'India'),(110,4,'India'),(111,1,'Indonesia'),(111,2,'Indonesia'),(111,3,'Indonesia'),(111,4,'Indonesia'),(112,1,'Iran'),(112,2,'Iran'),(112,3,'Iran'),(112,4,'Iran'),(113,1,'Iraq'),(113,2,'Iraq'),(113,3,'Iraq'),(113,4,'Iraq'),(114,1,'Man Island'),(114,2,'Isle Of Man'),(114,3,'Man Island'),(114,4,'Man Island'),(115,1,'Jamaica'),(115,2,'Jamaica'),(115,3,'Jamaica'),(115,4,'Jamaica'),(116,1,'Jersey'),(116,2,'Jersey'),(116,3,'Jersey'),(116,4,'Jersey'),(117,1,'Jordan'),(117,2,'Jordan'),(117,3,'Jordan'),(117,4,'Jordan'),(118,1,'Kazakhstan'),(118,2,'Kazakhstan'),(118,3,'Kazakhstan'),(118,4,'Kazakhstan'),(119,1,'Kenya'),(119,2,'Kenya'),(119,3,'Kenya'),(119,4,'Kenya'),(120,1,'Kiribati'),(120,2,'Kiribati'),(120,3,'Kiribati'),(120,4,'Kiribati'),(121,1,'Korea, Dem. Republic of'),(121,2,'North Korea'),(121,3,'Korea, Dem. Republic of'),(121,4,'Korea, Dem. Republic of'),(122,1,'Kuwait'),(122,2,'Kuwait'),(122,3,'Kuwait'),(122,4,'Kuwait'),(123,1,'Kyrgyzstan'),(123,2,'Kyrgyzstan'),(123,3,'Kyrgyzstan'),(123,4,'Kyrgyzstan'),(124,1,'Laos'),(124,2,'Laos'),(124,3,'Laos'),(124,4,'Laos'),(125,1,'Latvia'),(125,2,'Latvia'),(125,3,'Latvia'),(125,4,'Latvia'),(126,1,'Lebanon'),(126,2,'Lebanon'),(126,3,'Lebanon'),(126,4,'Lebanon'),(127,1,'Lesotho'),(127,2,'Lesotho'),(127,3,'Lesotho'),(127,4,'Lesotho'),(128,1,'Liberia'),(128,2,'Liberia'),(128,3,'Liberia'),(128,4,'Liberia'),(129,1,'Libya'),(129,2,'Libya'),(129,3,'Libya'),(129,4,'Libya'),(130,1,'Liechtenstein'),(130,2,'Liechtenstein'),(130,3,'Liechtenstein'),(130,4,'Liechtenstein'),(131,1,'Lithuania'),(131,2,'Lithuania'),(131,3,'Lithuania'),(131,4,'Lithuania'),(132,1,'Macau'),(132,2,'Macau SAR China'),(132,3,'Macau'),(132,4,'Macau'),(133,1,'Macedonia'),(133,2,'Macedonia'),(133,3,'Macedonia'),(133,4,'Macedonia'),(134,1,'Madagascar'),(134,2,'Madagascar'),(134,3,'Madagascar'),(134,4,'Madagascar'),(135,1,'Malawi'),(135,2,'Malawi'),(135,3,'Malawi'),(135,4,'Malawi'),(136,1,'馬來西亞'),(136,2,'Malaysia'),(136,3,'Malaysia'),(136,4,'マレーシア'),(137,1,'Maldives'),(137,2,'Maldives'),(137,3,'Maldives'),(137,4,'Maldives'),(138,1,'Mali'),(138,2,'Mali'),(138,3,'Mali'),(138,4,'Mali'),(139,1,'Malta'),(139,2,'Malta'),(139,3,'Malta'),(139,4,'Malta'),(140,1,'Marshall Islands'),(140,2,'Marshall Islands'),(140,3,'Marshall Islands'),(140,4,'Marshall Islands'),(141,1,'Martinique'),(141,2,'Martinique'),(141,3,'Martinique'),(141,4,'Martinique'),(142,1,'Mauritania'),(142,2,'Mauritania'),(142,3,'Mauritania'),(142,4,'Mauritania'),(143,1,'Hungary'),(143,2,'Hungary'),(143,3,'Hungary'),(143,4,'Hungary'),(144,1,'Mayotte'),(144,2,'Mayotte'),(144,3,'Mayotte'),(144,4,'Mayotte'),(145,1,'Mexico'),(145,2,'Mexico'),(145,3,'Mexico'),(145,4,'Mexico'),(146,1,'Micronesia'),(146,2,'Micronesia'),(146,3,'Micronesia'),(146,4,'Micronesia'),(147,1,'Moldova'),(147,2,'Moldova'),(147,3,'Moldova'),(147,4,'Moldova'),(148,1,'Monaco'),(148,2,'Monaco'),(148,3,'Monaco'),(148,4,'Monaco'),(149,1,'Mongolia'),(149,2,'Mongolia'),(149,3,'Mongolia'),(149,4,'Mongolia'),(150,1,'Montenegro'),(150,2,'Montenegro'),(150,3,'Montenegro'),(150,4,'Montenegro'),(151,1,'Montserrat'),(151,2,'Montserrat'),(151,3,'Montserrat'),(151,4,'Montserrat'),(152,1,'Morocco'),(152,2,'Morocco'),(152,3,'Morocco'),(152,4,'Morocco'),(153,1,'Mozambique'),(153,2,'Mozambique'),(153,3,'Mozambique'),(153,4,'Mozambique'),(154,1,'Namibia'),(154,2,'Namibia'),(154,3,'Namibia'),(154,4,'Namibia'),(155,1,'Nauru'),(155,2,'Nauru'),(155,3,'Nauru'),(155,4,'Nauru'),(156,1,'Nepal'),(156,2,'Nepal'),(156,3,'Nepal'),(156,4,'Nepal'),(157,1,'Netherlands Antilles'),(157,2,'Netherlands Antilles'),(157,3,'Netherlands Antilles'),(157,4,'Netherlands Antilles'),(158,1,'New Caledonia'),(158,2,'New Caledonia'),(158,3,'New Caledonia'),(158,4,'New Caledonia'),(159,1,'Nicaragua'),(159,2,'Nicaragua'),(159,3,'Nicaragua'),(159,4,'Nicaragua'),(160,1,'Niger'),(160,2,'Niger'),(160,3,'Niger'),(160,4,'Niger'),(161,1,'Niue'),(161,2,'Niue'),(161,3,'Niue'),(161,4,'Niue'),(162,1,'Norfolk Island'),(162,2,'Norfolk Island'),(162,3,'Norfolk Island'),(162,4,'Norfolk Island'),(163,1,'Northern Mariana Islands'),(163,2,'Northern Mariana Islands'),(163,3,'Northern Mariana Islands'),(163,4,'Northern Mariana Islands'),(164,1,'Oman'),(164,2,'Oman'),(164,3,'Oman'),(164,4,'Oman'),(165,1,'Pakistan'),(165,2,'Pakistan'),(165,3,'Pakistan'),(165,4,'Pakistan'),(166,1,'Palau'),(166,2,'Palau'),(166,3,'Palau'),(166,4,'Palau'),(167,1,'Palestinian Territories'),(167,2,'Palestinian Territories'),(167,3,'Palestinian Territories'),(167,4,'Palestinian Territories'),(168,1,'Panama'),(168,2,'Panama'),(168,3,'Panama'),(168,4,'Panama'),(169,1,'Papua New Guinea'),(169,2,'Papua New Guinea'),(169,3,'Papua New Guinea'),(169,4,'Papua New Guinea'),(170,1,'Paraguay'),(170,2,'Paraguay'),(170,3,'Paraguay'),(170,4,'Paraguay'),(171,1,'Peru'),(171,2,'Peru'),(171,3,'Peru'),(171,4,'Peru'),(172,1,'Philippines'),(172,2,'Philippines'),(172,3,'Philippines'),(172,4,'Philippines'),(173,1,'Pitcairn'),(173,2,'Pitcairn Islands'),(173,3,'Pitcairn'),(173,4,'Pitcairn'),(174,1,'Puerto Rico'),(174,2,'Puerto Rico'),(174,3,'Puerto Rico'),(174,4,'Puerto Rico'),(175,1,'Qatar'),(175,2,'Qatar'),(175,3,'Qatar'),(175,4,'Qatar'),(176,1,'Reunion Island'),(176,2,'Réunion'),(176,3,'Reunion Island'),(176,4,'Reunion Island'),(177,1,'Russian Federation'),(177,2,'Russia'),(177,3,'Russian Federation'),(177,4,'Russian Federation'),(178,1,'Rwanda'),(178,2,'Rwanda'),(178,3,'Rwanda'),(178,4,'Rwanda'),(179,1,'Saint Barthelemy'),(179,2,'St. Barthélemy'),(179,3,'Saint Barthelemy'),(179,4,'Saint Barthelemy'),(180,1,'Saint Kitts and Nevis'),(180,2,'St. Kitts & Nevis'),(180,3,'Saint Kitts and Nevis'),(180,4,'Saint Kitts and Nevis'),(181,1,'Saint Lucia'),(181,2,'St. Lucia'),(181,3,'Saint Lucia'),(181,4,'Saint Lucia'),(182,1,'Saint Martin'),(182,2,'St. Martin'),(182,3,'Saint Martin'),(182,4,'Saint Martin'),(183,1,'Saint Pierre and Miquelon'),(183,2,'St. Pierre & Miquelon'),(183,3,'Saint Pierre and Miquelon'),(183,4,'Saint Pierre and Miquelon'),(184,1,'Saint Vincent and the Grenadines'),(184,2,'St. Vincent & Grenadines'),(184,3,'Saint Vincent and the Grenadines'),(184,4,'Saint Vincent and the Grenadines'),(185,1,'Samoa'),(185,2,'Samoa'),(185,3,'Samoa'),(185,4,'Samoa'),(186,1,'San Marino'),(186,2,'San Marino'),(186,3,'San Marino'),(186,4,'San Marino'),(187,1,'São Tomé and Príncipe'),(187,2,'São Tomé & Príncipe'),(187,3,'São Tomé and Príncipe'),(187,4,'São Tomé and Príncipe'),(188,1,'Saudi Arabia'),(188,2,'Saudi Arabia'),(188,3,'Saudi Arabia'),(188,4,'Saudi Arabia'),(189,1,'Senegal'),(189,2,'Senegal'),(189,3,'Senegal'),(189,4,'Senegal'),(190,1,'Serbia'),(190,2,'Serbia'),(190,3,'Serbia'),(190,4,'Serbia'),(191,1,'Seychelles'),(191,2,'Seychelles'),(191,3,'Seychelles'),(191,4,'Seychelles'),(192,1,'Sierra Leone'),(192,2,'Sierra Leone'),(192,3,'Sierra Leone'),(192,4,'Sierra Leone'),(193,1,'Slovenia'),(193,2,'Slovenia'),(193,3,'Slovenia'),(193,4,'Slovenia'),(194,1,'Solomon Islands'),(194,2,'Solomon Islands'),(194,3,'Solomon Islands'),(194,4,'Solomon Islands'),(195,1,'Somalia'),(195,2,'Somalia'),(195,3,'Somalia'),(195,4,'Somalia'),(196,1,'South Georgia and the South Sandwich Islands'),(196,2,'South Georgia & South Sandwich Islands'),(196,3,'South Georgia and the South Sandwich Islands'),(196,4,'South Georgia and the South Sandwich Islands'),(197,1,'Sri Lanka'),(197,2,'Sri Lanka'),(197,3,'Sri Lanka'),(197,4,'Sri Lanka'),(198,1,'Sudan'),(198,2,'Sudan'),(198,3,'Sudan'),(198,4,'Sudan'),(199,1,'Suriname'),(199,2,'Suriname'),(199,3,'Suriname'),(199,4,'Suriname'),(200,1,'Svalbard and Jan Mayen'),(200,2,'Svalbard & Jan Mayen'),(200,3,'Svalbard and Jan Mayen'),(200,4,'Svalbard and Jan Mayen'),(201,1,'Swaziland'),(201,2,'Swaziland'),(201,3,'Swaziland'),(201,4,'Swaziland'),(202,1,'Syria'),(202,2,'Syria'),(202,3,'Syria'),(202,4,'Syria'),(203,1,'台灣'),(203,2,'Taiwan'),(203,3,'Taiwan'),(203,4,'台湾'),(204,1,'Tajikistan'),(204,2,'Tajikistan'),(204,3,'Tajikistan'),(204,4,'Tajikistan'),(205,1,'Tanzania'),(205,2,'Tanzania'),(205,3,'Tanzania'),(205,4,'Tanzania'),(206,1,'Thailand'),(206,2,'Thailand'),(206,3,'Thailand'),(206,4,'Thailand'),(207,1,'Tokelau'),(207,2,'Tokelau'),(207,3,'Tokelau'),(207,4,'Tokelau'),(208,1,'Tonga'),(208,2,'Tonga'),(208,3,'Tonga'),(208,4,'Tonga'),(209,1,'Trinidad and Tobago'),(209,2,'Trinidad & Tobago'),(209,3,'Trinidad and Tobago'),(209,4,'Trinidad and Tobago'),(210,1,'Tunisia'),(210,2,'Tunisia'),(210,3,'Tunisia'),(210,4,'Tunisia'),(211,1,'Turkey'),(211,2,'Turkey'),(211,3,'Turkey'),(211,4,'Turkey'),(212,1,'Turkmenistan'),(212,2,'Turkmenistan'),(212,3,'Turkmenistan'),(212,4,'Turkmenistan'),(213,1,'Turks and Caicos Islands'),(213,2,'Turks & Caicos Islands'),(213,3,'Turks and Caicos Islands'),(213,4,'Turks and Caicos Islands'),(214,1,'Tuvalu'),(214,2,'Tuvalu'),(214,3,'Tuvalu'),(214,4,'Tuvalu'),(215,1,'Uganda'),(215,2,'Uganda'),(215,3,'Uganda'),(215,4,'Uganda'),(216,1,'Ukraine'),(216,2,'Ukraine'),(216,3,'Ukraine'),(216,4,'Ukraine'),(217,1,'United Arab Emirates'),(217,2,'United Arab Emirates'),(217,3,'United Arab Emirates'),(217,4,'United Arab Emirates'),(218,1,'Uruguay'),(218,2,'Uruguay'),(218,3,'Uruguay'),(218,4,'Uruguay'),(219,1,'Uzbekistan'),(219,2,'Uzbekistan'),(219,3,'Uzbekistan'),(219,4,'Uzbekistan'),(220,1,'Vanuatu'),(220,2,'Vanuatu'),(220,3,'Vanuatu'),(220,4,'Vanuatu'),(221,1,'Venezuela'),(221,2,'Venezuela'),(221,3,'Venezuela'),(221,4,'Venezuela'),(222,1,'Vietnam'),(222,2,'Vietnam'),(222,3,'Vietnam'),(222,4,'Vietnam'),(223,1,'Virgin Islands (British)'),(223,2,'British Virgin Islands'),(223,3,'Virgin Islands (British)'),(223,4,'Virgin Islands (British)'),(224,1,'Virgin Islands (U.S.)'),(224,2,'U.S. Virgin Islands'),(224,3,'Virgin Islands (U.S.)'),(224,4,'Virgin Islands (U.S.)'),(225,1,'Wallis and Futuna'),(225,2,'Wallis & Futuna'),(225,3,'Wallis and Futuna'),(225,4,'Wallis and Futuna'),(226,1,'Western Sahara'),(226,2,'Western Sahara'),(226,3,'Western Sahara'),(226,4,'Western Sahara'),(227,1,'Yemen'),(227,2,'Yemen'),(227,3,'Yemen'),(227,4,'Yemen'),(228,1,'Zambia'),(228,2,'Zambia'),(228,3,'Zambia'),(228,4,'Zambia'),(229,1,'Zimbabwe'),(229,2,'Zimbabwe'),(229,3,'Zimbabwe'),(229,4,'Zimbabwe'),(230,1,'Albania'),(230,2,'Albania'),(230,3,'Albania'),(230,4,'Albania'),(231,1,'Afghanistan'),(231,2,'Afghanistan'),(231,3,'Afghanistan'),(231,4,'Afghanistan'),(232,1,'Antarctica'),(232,2,'Antarctica'),(232,3,'Antarctica'),(232,4,'Antarctica'),(233,1,'Bosnia and Herzegovina'),(233,2,'Bosnia & Herzegovina'),(233,3,'Bosnia and Herzegovina'),(233,4,'Bosnia and Herzegovina'),(234,1,'Bouvet Island'),(234,2,'Bouvet Island'),(234,3,'Bouvet Island'),(234,4,'Bouvet Island'),(235,1,'British Indian Ocean Territory'),(235,2,'British Indian Ocean Territory'),(235,3,'British Indian Ocean Territory'),(235,4,'British Indian Ocean Territory'),(236,1,'Bulgaria'),(236,2,'Bulgaria'),(236,3,'Bulgaria'),(236,4,'Bulgaria'),(237,1,'Cayman Islands'),(237,2,'Cayman Islands'),(237,3,'Cayman Islands'),(237,4,'Cayman Islands'),(238,1,'Christmas Island'),(238,2,'Christmas Island'),(238,3,'Christmas Island'),(238,4,'Christmas Island'),(239,1,'Cocos (Keeling) Islands'),(239,2,'Cocos (Keeling) Islands'),(239,3,'Cocos (Keeling) Islands'),(239,4,'Cocos (Keeling) Islands'),(240,1,'Cook Islands'),(240,2,'Cook Islands'),(240,3,'Cook Islands'),(240,4,'Cook Islands'),(241,1,'French Guiana'),(241,2,'French Guiana'),(241,3,'French Guiana'),(241,4,'French Guiana'),(242,1,'French Polynesia'),(242,2,'French Polynesia'),(242,3,'French Polynesia'),(242,4,'French Polynesia'),(243,1,'French Southern Territories'),(243,2,'French Southern Territories'),(243,3,'French Southern Territories'),(243,4,'French Southern Territories'),(244,1,'Åland Islands'),(244,2,'Åland Islands'),(244,3,'Åland Islands'),(244,4,'Åland Islands'),(245,1,'* 超商取貨'),(245,2,'超商'),(245,3,'超商'),(245,4,'超商');
/*!40000 ALTER TABLE `ps_country_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_country_shop`
--

DROP TABLE IF EXISTS `ps_country_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_country_shop` (
  `id_country` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_country`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_country_shop`
--

LOCK TABLES `ps_country_shop` WRITE;
/*!40000 ALTER TABLE `ps_country_shop` DISABLE KEYS */;
INSERT INTO `ps_country_shop` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1),(52,1),(53,1),(54,1),(55,1),(56,1),(57,1),(58,1),(59,1),(60,1),(61,1),(62,1),(63,1),(64,1),(65,1),(66,1),(67,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1),(76,1),(77,1),(78,1),(79,1),(80,1),(81,1),(82,1),(83,1),(84,1),(85,1),(86,1),(87,1),(88,1),(89,1),(90,1),(91,1),(92,1),(93,1),(94,1),(95,1),(96,1),(97,1),(98,1),(99,1),(100,1),(101,1),(102,1),(103,1),(104,1),(105,1),(106,1),(107,1),(108,1),(109,1),(110,1),(111,1),(112,1),(113,1),(114,1),(115,1),(116,1),(117,1),(118,1),(119,1),(120,1),(121,1),(122,1),(123,1),(124,1),(125,1),(126,1),(127,1),(128,1),(129,1),(130,1),(131,1),(132,1),(133,1),(134,1),(135,1),(136,1),(137,1),(138,1),(139,1),(140,1),(141,1),(142,1),(143,1),(144,1),(145,1),(146,1),(147,1),(148,1),(149,1),(150,1),(151,1),(152,1),(153,1),(154,1),(155,1),(156,1),(157,1),(158,1),(159,1),(160,1),(161,1),(162,1),(163,1),(164,1),(165,1),(166,1),(167,1),(168,1),(169,1),(170,1),(171,1),(172,1),(173,1),(174,1),(175,1),(176,1),(177,1),(178,1),(179,1),(180,1),(181,1),(182,1),(183,1),(184,1),(185,1),(186,1),(187,1),(188,1),(189,1),(190,1),(191,1),(192,1),(193,1),(194,1),(195,1),(196,1),(197,1),(198,1),(199,1),(200,1),(201,1),(202,1),(203,1),(204,1),(205,1),(206,1),(207,1),(208,1),(209,1),(210,1),(211,1),(212,1),(213,1),(214,1),(215,1),(216,1),(217,1),(218,1),(219,1),(220,1),(221,1),(222,1),(223,1),(224,1),(225,1),(226,1),(227,1),(228,1),(229,1),(230,1),(231,1),(232,1),(233,1),(234,1),(235,1),(236,1),(237,1),(238,1),(239,1),(240,1),(241,1),(242,1),(243,1),(244,1),(245,1),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,2),(25,2),(26,2),(27,2),(28,2),(29,2),(30,2),(31,2),(32,2),(33,2),(34,2),(35,2),(36,2),(37,2),(38,2),(39,2),(40,2),(41,2),(42,2),(43,2),(44,2),(45,2),(46,2),(47,2),(48,2),(49,2),(50,2),(51,2),(52,2),(53,2),(54,2),(55,2),(56,2),(57,2),(58,2),(59,2),(60,2),(61,2),(62,2),(63,2),(64,2),(65,2),(66,2),(67,2),(68,2),(69,2),(70,2),(71,2),(72,2),(73,2),(74,2),(75,2),(76,2),(77,2),(78,2),(79,2),(80,2),(81,2),(82,2),(83,2),(84,2),(85,2),(86,2),(87,2),(88,2),(89,2),(90,2),(91,2),(92,2),(93,2),(94,2),(95,2),(96,2),(97,2),(98,2),(99,2),(100,2),(101,2),(102,2),(103,2),(104,2),(105,2),(106,2),(107,2),(108,2),(109,2),(110,2),(111,2),(112,2),(113,2),(114,2),(115,2),(116,2),(117,2),(118,2),(119,2),(120,2),(121,2),(122,2),(123,2),(124,2),(125,2),(126,2),(127,2),(128,2),(129,2),(130,2),(131,2),(132,2),(133,2),(134,2),(135,2),(136,2),(137,2),(138,2),(139,2),(140,2),(141,2),(142,2),(143,2),(144,2),(145,2),(146,2),(147,2),(148,2),(149,2),(150,2),(151,2),(152,2),(153,2),(154,2),(155,2),(156,2),(157,2),(158,2),(159,2),(160,2),(161,2),(162,2),(163,2),(164,2),(165,2),(166,2),(167,2),(168,2),(169,2),(170,2),(171,2),(172,2),(173,2),(174,2),(175,2),(176,2),(177,2),(178,2),(179,2),(180,2),(181,2),(182,2),(183,2),(184,2),(185,2),(186,2),(187,2),(188,2),(189,2),(190,2),(191,2),(192,2),(193,2),(194,2),(195,2),(196,2),(197,2),(198,2),(199,2),(200,2),(201,2),(202,2),(203,2),(204,2),(205,2),(206,2),(207,2),(208,2),(209,2),(210,2),(211,2),(212,2),(213,2),(214,2),(215,2),(216,2),(217,2),(218,2),(219,2),(220,2),(221,2),(222,2),(223,2),(224,2),(225,2),(226,2),(227,2),(228,2),(229,2),(230,2),(231,2),(232,2),(233,2),(234,2),(235,2),(236,2),(237,2),(238,2),(239,2),(240,2),(241,2),(242,2),(243,2),(244,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),(11,3),(12,3),(13,3),(14,3),(15,3),(16,3),(17,3),(18,3),(19,3),(20,3),(21,3),(22,3),(23,3),(24,3),(25,3),(26,3),(27,3),(28,3),(29,3),(30,3),(31,3),(32,3),(33,3),(34,3),(35,3),(36,3),(37,3),(38,3),(39,3),(40,3),(41,3),(42,3),(43,3),(44,3),(45,3),(46,3),(47,3),(48,3),(49,3),(50,3),(51,3),(52,3),(53,3),(54,3),(55,3),(56,3),(57,3),(58,3),(59,3),(60,3),(61,3),(62,3),(63,3),(64,3),(65,3),(66,3),(67,3),(68,3),(69,3),(70,3),(71,3),(72,3),(73,3),(74,3),(75,3),(76,3),(77,3),(78,3),(79,3),(80,3),(81,3),(82,3),(83,3),(84,3),(85,3),(86,3),(87,3),(88,3),(89,3),(90,3),(91,3),(92,3),(93,3),(94,3),(95,3),(96,3),(97,3),(98,3),(99,3),(100,3),(101,3),(102,3),(103,3),(104,3),(105,3),(106,3),(107,3),(108,3),(109,3),(110,3),(111,3),(112,3),(113,3),(114,3),(115,3),(116,3),(117,3),(118,3),(119,3),(120,3),(121,3),(122,3),(123,3),(124,3),(125,3),(126,3),(127,3),(128,3),(129,3),(130,3),(131,3),(132,3),(133,3),(134,3),(135,3),(136,3),(137,3),(138,3),(139,3),(140,3),(141,3),(142,3),(143,3),(144,3),(145,3),(146,3),(147,3),(148,3),(149,3),(150,3),(151,3),(152,3),(153,3),(154,3),(155,3),(156,3),(157,3),(158,3),(159,3),(160,3),(161,3),(162,3),(163,3),(164,3),(165,3),(166,3),(167,3),(168,3),(169,3),(170,3),(171,3),(172,3),(173,3),(174,3),(175,3),(176,3),(177,3),(178,3),(179,3),(180,3),(181,3),(182,3),(183,3),(184,3),(185,3),(186,3),(187,3),(188,3),(189,3),(190,3),(191,3),(192,3),(193,3),(194,3),(195,3),(196,3),(197,3),(198,3),(199,3),(200,3),(201,3),(202,3),(203,3),(204,3),(205,3),(206,3),(207,3),(208,3),(209,3),(210,3),(211,3),(212,3),(213,3),(214,3),(215,3),(216,3),(217,3),(218,3),(219,3),(220,3),(221,3),(222,3),(223,3),(224,3),(225,3),(226,3),(227,3),(228,3),(229,3),(230,3),(231,3),(232,3),(233,3),(234,3),(235,3),(236,3),(237,3),(238,3),(239,3),(240,3),(241,3),(242,3),(243,3),(244,3),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(8,4),(9,4),(10,4),(11,4),(12,4),(13,4),(14,4),(15,4),(16,4),(17,4),(18,4),(19,4),(20,4),(21,4),(22,4),(23,4),(24,4),(25,4),(26,4),(27,4),(28,4),(29,4),(30,4),(31,4),(32,4),(33,4),(34,4),(35,4),(36,4),(37,4),(38,4),(39,4),(40,4),(41,4),(42,4),(43,4),(44,4),(45,4),(46,4),(47,4),(48,4),(49,4),(50,4),(51,4),(52,4),(53,4),(54,4),(55,4),(56,4),(57,4),(58,4),(59,4),(60,4),(61,4),(62,4),(63,4),(64,4),(65,4),(66,4),(67,4),(68,4),(69,4),(70,4),(71,4),(72,4),(73,4),(74,4),(75,4),(76,4),(77,4),(78,4),(79,4),(80,4),(81,4),(82,4),(83,4),(84,4),(85,4),(86,4),(87,4),(88,4),(89,4),(90,4),(91,4),(92,4),(93,4),(94,4),(95,4),(96,4),(97,4),(98,4),(99,4),(100,4),(101,4),(102,4),(103,4),(104,4),(105,4),(106,4),(107,4),(108,4),(109,4),(110,4),(111,4),(112,4),(113,4),(114,4),(115,4),(116,4),(117,4),(118,4),(119,4),(120,4),(121,4),(122,4),(123,4),(124,4),(125,4),(126,4),(127,4),(128,4),(129,4),(130,4),(131,4),(132,4),(133,4),(134,4),(135,4),(136,4),(137,4),(138,4),(139,4),(140,4),(141,4),(142,4),(143,4),(144,4),(145,4),(146,4),(147,4),(148,4),(149,4),(150,4),(151,4),(152,4),(153,4),(154,4),(155,4),(156,4),(157,4),(158,4),(159,4),(160,4),(161,4),(162,4),(163,4),(164,4),(165,4),(166,4),(167,4),(168,4),(169,4),(170,4),(171,4),(172,4),(173,4),(174,4),(175,4),(176,4),(177,4),(178,4),(179,4),(180,4),(181,4),(182,4),(183,4),(184,4),(185,4),(186,4),(187,4),(188,4),(189,4),(190,4),(191,4),(192,4),(193,4),(194,4),(195,4),(196,4),(197,4),(198,4),(199,4),(200,4),(201,4),(202,4),(203,4),(204,4),(205,4),(206,4),(207,4),(208,4),(209,4),(210,4),(211,4),(212,4),(213,4),(214,4),(215,4),(216,4),(217,4),(218,4),(219,4),(220,4),(221,4),(222,4),(223,4),(224,4),(225,4),(226,4),(227,4),(228,4),(229,4),(230,4),(231,4),(232,4),(233,4),(234,4),(235,4),(236,4),(237,4),(238,4),(239,4),(240,4),(241,4),(242,4),(243,4),(244,4);
/*!40000 ALTER TABLE `ps_country_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_currency`
--

DROP TABLE IF EXISTS `ps_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_currency` (
  `id_currency` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `iso_code` varchar(3) NOT NULL DEFAULT '0',
  `numeric_iso_code` varchar(3) NOT NULL DEFAULT '0',
  `precision` int(2) NOT NULL DEFAULT '6',
  `conversion_rate` decimal(13,6) NOT NULL,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_currency`),
  KEY `currency_iso_code` (`iso_code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_currency`
--

LOCK TABLES `ps_currency` WRITE;
/*!40000 ALTER TABLE `ps_currency` DISABLE KEYS */;
INSERT INTO `ps_currency` VALUES (1,'新臺幣','TWD','0',0,1.000000,0,1),(2,'日圓','JPY','0',0,3.478374,0,0),(3,'美元','USD','0',2,0.032513,0,1),(4,'新加坡幣','SGD','0',2,0.044959,0,0),(5,'馬來西亞令吉','MYR','0',0,0.136343,0,0),(6,'港幣','HKD','0',0,0.255046,0,1),(7,'人民幣','CNY','0',2,0.232285,0,1);
/*!40000 ALTER TABLE `ps_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_currency_lang`
--

DROP TABLE IF EXISTS `ps_currency_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_currency_lang` (
  `id_currency` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL,
  PRIMARY KEY (`id_currency`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_currency_lang`
--

LOCK TABLES `ps_currency_lang` WRITE;
/*!40000 ALTER TABLE `ps_currency_lang` DISABLE KEYS */;
INSERT INTO `ps_currency_lang` VALUES (1,1,'新臺幣','NT$'),(1,2,'New Taiwan Dollar','NT$'),(1,3,'新臺幣','NT$'),(1,4,'新台湾ドル','NT$'),(2,1,'日圓','¥'),(2,2,'日圓','¥'),(2,3,'日圓','¥'),(2,4,'日圓','¥'),(3,1,'美元','US$'),(3,2,'美元','US$'),(3,3,'美元','US$'),(3,4,'美元','US$'),(4,1,'新加坡幣','S$'),(4,2,'新加坡幣','S$'),(4,3,'新加坡幣','S$'),(4,4,'新加坡幣','S$'),(5,1,'馬來西亞令吉','RM'),(5,2,'馬來西亞令吉','RM'),(5,3,'馬來西亞令吉','RM'),(5,4,'馬來西亞令吉','RM'),(6,1,'港幣','HK$'),(6,2,'港幣','HK$'),(6,3,'港幣','HK$'),(6,4,'港幣','HK$'),(7,1,'人民幣','¥'),(7,2,'人民幣','¥'),(7,3,'人民幣','¥'),(7,4,'人民幣','¥');
/*!40000 ALTER TABLE `ps_currency_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_currency_shop`
--

DROP TABLE IF EXISTS `ps_currency_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_currency_shop` (
  `id_currency` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `conversion_rate` decimal(13,6) NOT NULL,
  PRIMARY KEY (`id_currency`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_currency_shop`
--

LOCK TABLES `ps_currency_shop` WRITE;
/*!40000 ALTER TABLE `ps_currency_shop` DISABLE KEYS */;
INSERT INTO `ps_currency_shop` VALUES (1,1,1.000000),(1,2,1.000000),(1,3,1.000000),(1,4,1.000000),(2,1,3.478374),(2,2,3.691822),(2,3,3.691822),(2,4,3.691822),(3,1,0.032513),(3,2,0.032673),(3,3,0.032673),(3,4,0.032673),(4,1,0.044959),(4,2,0.044639),(4,3,0.044639),(4,4,0.044639),(5,1,0.136343),(5,2,0.135168),(5,3,0.135168),(5,4,0.135168),(6,1,0.255046),(6,2,0.255183),(6,3,0.255183),(6,4,0.255183),(7,1,0.232285),(7,2,0.224434),(7,3,0.224434),(7,4,0.224434);
/*!40000 ALTER TABLE `ps_currency_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customer`
--

DROP TABLE IF EXISTS `ps_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer` (
  `id_customer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) unsigned NOT NULL DEFAULT '1',
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_gender` int(10) unsigned NOT NULL,
  `id_default_group` int(10) unsigned NOT NULL DEFAULT '1',
  `id_lang` int(10) unsigned DEFAULT NULL,
  `id_risk` int(10) unsigned NOT NULL DEFAULT '1',
  `company` varchar(255) DEFAULT NULL,
  `siret` varchar(14) DEFAULT NULL,
  `ape` varchar(5) DEFAULT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  `last_passwd_gen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `birthday` date DEFAULT NULL,
  `newsletter` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ip_registration_newsletter` varchar(15) DEFAULT NULL,
  `newsletter_date_add` datetime DEFAULT NULL,
  `optin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `website` varchar(128) DEFAULT NULL,
  `outstanding_allow_amount` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `show_public_prices` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `max_payment_days` int(10) unsigned NOT NULL DEFAULT '60',
  `secure_key` varchar(32) NOT NULL DEFAULT '-1',
  `note` text,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_guest` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `reset_password_token` varchar(40) DEFAULT NULL,
  `reset_password_validity` datetime DEFAULT NULL,
  PRIMARY KEY (`id_customer`),
  KEY `customer_email` (`email`),
  KEY `customer_login` (`email`,`passwd`),
  KEY `id_customer_passwd` (`id_customer`,`passwd`),
  KEY `id_gender` (`id_gender`),
  KEY `id_shop_group` (`id_shop_group`),
  KEY `id_shop` (`id_shop`,`date_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customer`
--

LOCK TABLES `ps_customer` WRITE;
/*!40000 ALTER TABLE `ps_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customer_group`
--

DROP TABLE IF EXISTS `ps_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer_group` (
  `id_customer` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_customer`,`id_group`),
  KEY `customer_login` (`id_group`),
  KEY `id_customer` (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customer_group`
--

LOCK TABLES `ps_customer_group` WRITE;
/*!40000 ALTER TABLE `ps_customer_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customer_message`
--

DROP TABLE IF EXISTS `ps_customer_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer_message` (
  `id_customer_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer_thread` int(11) DEFAULT NULL,
  `id_employee` int(10) unsigned DEFAULT NULL,
  `message` mediumtext NOT NULL,
  `file_name` varchar(18) DEFAULT NULL,
  `ip_address` varchar(16) DEFAULT NULL,
  `user_agent` varchar(128) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `private` tinyint(4) NOT NULL DEFAULT '0',
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `system` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否為系統訊息',
  PRIMARY KEY (`id_customer_message`),
  KEY `id_customer_thread` (`id_customer_thread`),
  KEY `id_employee` (`id_employee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customer_message`
--

LOCK TABLES `ps_customer_message` WRITE;
/*!40000 ALTER TABLE `ps_customer_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_customer_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customer_message_sync_imap`
--

DROP TABLE IF EXISTS `ps_customer_message_sync_imap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer_message_sync_imap` (
  `md5_header` varbinary(32) NOT NULL,
  KEY `md5_header_index` (`md5_header`(4))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customer_message_sync_imap`
--

LOCK TABLES `ps_customer_message_sync_imap` WRITE;
/*!40000 ALTER TABLE `ps_customer_message_sync_imap` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_customer_message_sync_imap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customer_thread`
--

DROP TABLE IF EXISTS `ps_customer_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customer_thread` (
  `id_customer_thread` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_lang` int(10) unsigned NOT NULL,
  `id_contact` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned DEFAULT NULL,
  `id_order` int(10) unsigned DEFAULT NULL,
  `id_product` int(10) unsigned DEFAULT NULL,
  `status` enum('open','closed','pending1','pending2') NOT NULL DEFAULT 'open',
  `email` varchar(255) NOT NULL,
  `token` varchar(12) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_customer_thread`),
  KEY `id_shop` (`id_shop`),
  KEY `id_lang` (`id_lang`),
  KEY `id_contact` (`id_contact`),
  KEY `id_customer` (`id_customer`),
  KEY `id_order` (`id_order`),
  KEY `id_product` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customer_thread`
--

LOCK TABLES `ps_customer_thread` WRITE;
/*!40000 ALTER TABLE `ps_customer_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_customer_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customization`
--

DROP TABLE IF EXISTS `ps_customization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customization` (
  `id_customization` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product_attribute` int(10) unsigned NOT NULL DEFAULT '0',
  `id_address_delivery` int(10) unsigned NOT NULL DEFAULT '0',
  `id_cart` int(10) unsigned NOT NULL,
  `id_product` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `quantity_refunded` int(11) NOT NULL DEFAULT '0',
  `quantity_returned` int(11) NOT NULL DEFAULT '0',
  `in_cart` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_customization`,`id_cart`,`id_product`,`id_address_delivery`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_cart_product` (`id_cart`,`id_product`,`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customization`
--

LOCK TABLES `ps_customization` WRITE;
/*!40000 ALTER TABLE `ps_customization` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_customization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customization_field`
--

DROP TABLE IF EXISTS `ps_customization_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customization_field` (
  `id_customization_field` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL,
  `required` tinyint(1) NOT NULL,
  `is_module` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_customization_field`),
  KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customization_field`
--

LOCK TABLES `ps_customization_field` WRITE;
/*!40000 ALTER TABLE `ps_customization_field` DISABLE KEYS */;
INSERT INTO `ps_customization_field` VALUES (1,12,1,0,0,0),(2,12,0,0,0,0);
/*!40000 ALTER TABLE `ps_customization_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customization_field_lang`
--

DROP TABLE IF EXISTS `ps_customization_field_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customization_field_lang` (
  `id_customization_field` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_customization_field`,`id_lang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customization_field_lang`
--

LOCK TABLES `ps_customization_field_lang` WRITE;
/*!40000 ALTER TABLE `ps_customization_field_lang` DISABLE KEYS */;
INSERT INTO `ps_customization_field_lang` VALUES (1,1,1,'刻字'),(1,2,1,''),(1,4,1,''),(2,1,1,'圖案'),(2,2,1,''),(2,4,1,'');
/*!40000 ALTER TABLE `ps_customization_field_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_customized_data`
--

DROP TABLE IF EXISTS `ps_customized_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_customized_data` (
  `id_customization` int(10) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL,
  `index` int(3) NOT NULL,
  `value` varchar(255) NOT NULL,
  `id_module` int(10) NOT NULL DEFAULT '0',
  `price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `weight` decimal(20,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`id_customization`,`type`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_customized_data`
--

LOCK TABLES `ps_customized_data` WRITE;
/*!40000 ALTER TABLE `ps_customized_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_customized_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_date_range`
--

DROP TABLE IF EXISTS `ps_date_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_date_range` (
  `id_date_range` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `time_start` datetime NOT NULL,
  `time_end` datetime NOT NULL,
  PRIMARY KEY (`id_date_range`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_date_range`
--

LOCK TABLES `ps_date_range` WRITE;
/*!40000 ALTER TABLE `ps_date_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_date_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_delivery`
--

DROP TABLE IF EXISTS `ps_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_delivery` (
  `id_delivery` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned DEFAULT NULL,
  `id_shop_group` int(10) unsigned DEFAULT NULL,
  `id_carrier` int(10) unsigned NOT NULL,
  `id_range_price` int(10) unsigned DEFAULT NULL,
  `id_range_weight` int(10) unsigned DEFAULT NULL,
  `id_zone` int(10) unsigned NOT NULL,
  `price` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id_delivery`),
  KEY `id_zone` (`id_zone`),
  KEY `id_carrier` (`id_carrier`,`id_zone`),
  KEY `id_range_price` (`id_range_price`),
  KEY `id_range_weight` (`id_range_weight`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_delivery`
--

LOCK TABLES `ps_delivery` WRITE;
/*!40000 ALTER TABLE `ps_delivery` DISABLE KEYS */;
INSERT INTO `ps_delivery` VALUES (222,NULL,NULL,103,7,NULL,9,60.000000),(223,NULL,NULL,103,38,NULL,9,30.000000),(224,NULL,NULL,104,9,NULL,9,60.000000),(225,NULL,NULL,104,10,NULL,9,30.000000),(226,NULL,NULL,105,34,NULL,9,60.000000),(227,NULL,NULL,105,35,NULL,9,30.000000),(228,NULL,NULL,106,36,NULL,9,60.000000),(229,NULL,NULL,106,37,NULL,9,30.000000),(230,NULL,NULL,107,19,NULL,9,150.000000),(231,NULL,NULL,107,25,NULL,9,120.000000),(232,NULL,NULL,107,26,NULL,9,0.000000),(233,NULL,NULL,108,39,NULL,9,190.000000),(234,NULL,NULL,108,40,NULL,9,160.000000),(235,NULL,NULL,108,41,NULL,9,0.000000),(236,NULL,NULL,109,42,NULL,9,190.000000),(237,NULL,NULL,109,43,NULL,9,160.000000),(238,NULL,NULL,109,44,NULL,9,0.000000),(239,NULL,NULL,110,21,NULL,9,180.000000),(240,NULL,NULL,110,32,NULL,9,150.000000),(241,NULL,NULL,110,33,NULL,9,0.000000),(242,NULL,NULL,111,29,NULL,9,210.000000),(243,NULL,NULL,111,30,NULL,9,180.000000),(244,NULL,NULL,111,31,NULL,9,0.000000),(245,NULL,NULL,112,23,NULL,9,210.000000),(246,NULL,NULL,112,27,NULL,9,180.000000),(247,NULL,NULL,112,28,NULL,9,0.000000),(248,NULL,NULL,113,11,NULL,9,35.000000),(249,NULL,NULL,113,12,NULL,9,0.000000),(251,NULL,NULL,114,45,NULL,9,200.000000),(254,NULL,NULL,115,46,NULL,12,60.000000),(256,NULL,NULL,116,47,NULL,9,0.000000),(257,NULL,NULL,117,48,NULL,12,60.000000),(258,NULL,NULL,118,49,NULL,9,60.000000),(259,NULL,NULL,119,50,NULL,12,60.000000),(261,NULL,NULL,120,51,NULL,9,90.000000),(262,NULL,NULL,120,52,NULL,9,0.000000),(263,NULL,NULL,121,53,NULL,9,160.000000),(264,NULL,NULL,121,54,NULL,9,0.000000),(265,NULL,NULL,122,55,NULL,9,200.000000),(266,NULL,NULL,122,56,NULL,9,0.000000);
/*!40000 ALTER TABLE `ps_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_emailsubscription`
--

DROP TABLE IF EXISTS `ps_emailsubscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_emailsubscription` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `id_shop_group` int(10) unsigned NOT NULL DEFAULT '1',
  `email` varchar(255) NOT NULL,
  `newsletter_date_add` datetime DEFAULT NULL,
  `ip_registration_newsletter` varchar(15) NOT NULL,
  `http_referer` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `id_lang` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_emailsubscription`
--

LOCK TABLES `ps_emailsubscription` WRITE;
/*!40000 ALTER TABLE `ps_emailsubscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_emailsubscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_employee`
--

DROP TABLE IF EXISTS `ps_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_employee` (
  `id_employee` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_profile` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL DEFAULT '0',
  `lastname` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  `last_passwd_gen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stats_date_from` date DEFAULT NULL,
  `stats_date_to` date DEFAULT NULL,
  `stats_compare_from` date DEFAULT NULL,
  `stats_compare_to` date DEFAULT NULL,
  `stats_compare_option` int(1) unsigned NOT NULL DEFAULT '1',
  `preselect_date_range` varchar(32) DEFAULT NULL,
  `bo_color` varchar(32) DEFAULT NULL,
  `bo_theme` varchar(32) DEFAULT NULL,
  `bo_css` varchar(64) DEFAULT NULL,
  `default_tab` int(10) unsigned NOT NULL DEFAULT '0',
  `bo_width` int(10) unsigned NOT NULL DEFAULT '0',
  `bo_menu` tinyint(1) NOT NULL DEFAULT '1',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `optin` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `id_last_order` int(10) unsigned NOT NULL DEFAULT '0',
  `id_last_customer_message` int(10) unsigned NOT NULL DEFAULT '0',
  `id_last_customer` int(10) unsigned NOT NULL DEFAULT '0',
  `last_connection_date` date DEFAULT NULL,
  `reset_password_token` varchar(40) DEFAULT NULL,
  `reset_password_validity` datetime DEFAULT NULL,
  PRIMARY KEY (`id_employee`),
  KEY `employee_login` (`email`,`passwd`),
  KEY `id_employee_passwd` (`id_employee`,`passwd`),
  KEY `id_profile` (`id_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_employee`
--

LOCK TABLES `ps_employee` WRITE;
/*!40000 ALTER TABLE `ps_employee` DISABLE KEYS */;
INSERT INTO `ps_employee` VALUES (1,1,1,'管','理員','admin@example.com','$2y$10$VdeZo1fw.gdf4yCkyLowKuZ74d.TKH79JJBZL0ahGjZCQSOc4YSbW','2018-07-10 21:57:39','2020-04-01','2020-04-30','0000-00-00','0000-00-00',1,'year','','default','theme.css',1,0,1,1,0,0,0,10,'2020-04-20','','0000-00-00 00:00:00'),(2,4,1,'設計','獅','design@example.com','$2y$10$vQVCqjg48YmKDMtOYmB/KuAJ.3Wy0wsqe6hmKkOvjKuCWfu8aEOt6','2019-08-15 01:46:33','2019-07-15','2019-08-15',NULL,NULL,1,'','','default','theme.css',53,0,1,0,0,0,0,0,NULL,'',NULL),(3,2,1,'上架','人員','product@example.com','$2y$10$o39clHq9MqzmKlYYyuhbiurUkAf8cTKKXK9yULz2xGUHoExGBe2tq','2019-08-15 02:37:22','2019-07-15','2019-08-15',NULL,NULL,1,'','','default','theme.css',10,0,1,0,0,0,0,0,NULL,'',NULL),(4,3,1,'出貨','人員','order@example.com','$2y$10$rs10Lak49YMejqwin3ogL.ur/4WBmP/fbASrTWDtJKaaK1QlizQ2u','2019-08-15 02:42:01','2019-07-15','2019-08-15',NULL,NULL,1,'','','default','theme.css',4,0,1,0,0,0,0,0,NULL,'',NULL);
/*!40000 ALTER TABLE `ps_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_employee_shop`
--

DROP TABLE IF EXISTS `ps_employee_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_employee_shop` (
  `id_employee` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_employee`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_employee_shop`
--

LOCK TABLES `ps_employee_shop` WRITE;
/*!40000 ALTER TABLE `ps_employee_shop` DISABLE KEYS */;
INSERT INTO `ps_employee_shop` VALUES (1,1),(2,1),(3,1),(4,1),(1,2),(1,3),(1,4);
/*!40000 ALTER TABLE `ps_employee_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_fbmessenger_message`
--

DROP TABLE IF EXISTS `ps_fbmessenger_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fbmessenger_message` (
  `id_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_subscription` int(10) unsigned DEFAULT NULL,
  `type` tinyint(1) unsigned DEFAULT NULL,
  `app_id` int(10) unsigned DEFAULT NULL,
  `ref` varchar(100) DEFAULT NULL,
  `message_id` varchar(100) DEFAULT NULL,
  `message_text` text,
  `click` int(10) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_message`),
  KEY `id_subscription` (`id_subscription`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_fbmessenger_message`
--

LOCK TABLES `ps_fbmessenger_message` WRITE;
/*!40000 ALTER TABLE `ps_fbmessenger_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_fbmessenger_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_fbmessenger_subscription`
--

DROP TABLE IF EXISTS `ps_fbmessenger_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_fbmessenger_subscription` (
  `id_subscription` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cart` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned DEFAULT NULL,
  `order_date_add` datetime DEFAULT NULL,
  `ref` varchar(255) NOT NULL COMMENT '輔 ref',
  `user_ref` varchar(255) NOT NULL COMMENT '主 ref',
  `token` varchar(50) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_subscription`),
  KEY `id_cart` (`id_cart`),
  KEY `id_order` (`id_order`),
  KEY `user_ref` (`user_ref`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_fbmessenger_subscription`
--

LOCK TABLES `ps_fbmessenger_subscription` WRITE;
/*!40000 ALTER TABLE `ps_fbmessenger_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_fbmessenger_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_feature`
--

DROP TABLE IF EXISTS `ps_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature` (
  `id_feature` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_feature`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_feature`
--

LOCK TABLES `ps_feature` WRITE;
/*!40000 ALTER TABLE `ps_feature` DISABLE KEYS */;
INSERT INTO `ps_feature` VALUES (1,0);
/*!40000 ALTER TABLE `ps_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_feature_lang`
--

DROP TABLE IF EXISTS `ps_feature_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_lang` (
  `id_feature` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_feature`,`id_lang`),
  KEY `id_lang` (`id_lang`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_feature_lang`
--

LOCK TABLES `ps_feature_lang` WRITE;
/*!40000 ALTER TABLE `ps_feature_lang` DISABLE KEYS */;
INSERT INTO `ps_feature_lang` VALUES (1,1,'規格1'),(1,2,'規格1'),(1,3,'規格1'),(1,4,'規格1');
/*!40000 ALTER TABLE `ps_feature_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_feature_product`
--

DROP TABLE IF EXISTS `ps_feature_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_product` (
  `id_feature` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_feature_value` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_feature`,`id_product`,`id_feature_value`),
  KEY `id_feature_value` (`id_feature_value`),
  KEY `id_product` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_feature_product`
--

LOCK TABLES `ps_feature_product` WRITE;
/*!40000 ALTER TABLE `ps_feature_product` DISABLE KEYS */;
INSERT INTO `ps_feature_product` VALUES (1,12,1);
/*!40000 ALTER TABLE `ps_feature_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_feature_shop`
--

DROP TABLE IF EXISTS `ps_feature_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_shop` (
  `id_feature` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_feature`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_feature_shop`
--

LOCK TABLES `ps_feature_shop` WRITE;
/*!40000 ALTER TABLE `ps_feature_shop` DISABLE KEYS */;
INSERT INTO `ps_feature_shop` VALUES (1,1);
/*!40000 ALTER TABLE `ps_feature_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_feature_value`
--

DROP TABLE IF EXISTS `ps_feature_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_value` (
  `id_feature_value` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_feature` int(10) unsigned NOT NULL,
  `custom` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_feature_value`),
  KEY `feature` (`id_feature`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_feature_value`
--

LOCK TABLES `ps_feature_value` WRITE;
/*!40000 ALTER TABLE `ps_feature_value` DISABLE KEYS */;
INSERT INTO `ps_feature_value` VALUES (1,1,0),(2,1,0);
/*!40000 ALTER TABLE `ps_feature_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_feature_value_lang`
--

DROP TABLE IF EXISTS `ps_feature_value_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_feature_value_lang` (
  `id_feature_value` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_feature_value`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_feature_value_lang`
--

LOCK TABLES `ps_feature_value_lang` WRITE;
/*!40000 ALTER TABLE `ps_feature_value_lang` DISABLE KEYS */;
INSERT INTO `ps_feature_value_lang` VALUES (1,1,'規格數值1'),(1,2,'規格數值1'),(1,3,'規格數值1'),(1,4,'規格數值1'),(2,1,'規格數值2'),(2,2,'規格數值2'),(2,3,'規格數值2'),(2,4,'規格數值2');
/*!40000 ALTER TABLE `ps_feature_value_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_ganalytics`
--

DROP TABLE IF EXISTS `ps_ganalytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ganalytics` (
  `id_google_analytics` int(11) NOT NULL AUTO_INCREMENT,
  `id_order` int(11) NOT NULL,
  `id_customer` int(10) NOT NULL,
  `id_shop` int(11) NOT NULL,
  `sent` tinyint(1) DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  PRIMARY KEY (`id_google_analytics`),
  KEY `id_order` (`id_order`),
  KEY `sent` (`sent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_ganalytics`
--

LOCK TABLES `ps_ganalytics` WRITE;
/*!40000 ALTER TABLE `ps_ganalytics` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_ganalytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_ganalytics_data`
--

DROP TABLE IF EXISTS `ps_ganalytics_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_ganalytics_data` (
  `id_cart` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  `data` text,
  PRIMARY KEY (`id_cart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_ganalytics_data`
--

LOCK TABLES `ps_ganalytics_data` WRITE;
/*!40000 ALTER TABLE `ps_ganalytics_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_ganalytics_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_gender`
--

DROP TABLE IF EXISTS `ps_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gender` (
  `id_gender` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_gender`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_gender`
--

LOCK TABLES `ps_gender` WRITE;
/*!40000 ALTER TABLE `ps_gender` DISABLE KEYS */;
INSERT INTO `ps_gender` VALUES (1,0),(2,1);
/*!40000 ALTER TABLE `ps_gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_gender_lang`
--

DROP TABLE IF EXISTS `ps_gender_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gender_lang` (
  `id_gender` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_gender`,`id_lang`),
  KEY `id_gender` (`id_gender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_gender_lang`
--

LOCK TABLES `ps_gender_lang` WRITE;
/*!40000 ALTER TABLE `ps_gender_lang` DISABLE KEYS */;
INSERT INTO `ps_gender_lang` VALUES (1,1,'先生'),(1,2,'Mr.'),(1,3,'先生'),(1,4,'男性'),(2,1,'小姐'),(2,2,'Ms.'),(2,3,'女士'),(2,4,'女性');
/*!40000 ALTER TABLE `ps_gender_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_group`
--

DROP TABLE IF EXISTS `ps_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_group` (
  `id_group` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reduction` decimal(17,2) NOT NULL DEFAULT '0.00',
  `price_display_method` tinyint(4) NOT NULL DEFAULT '0',
  `show_prices` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_group`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_group`
--

LOCK TABLES `ps_group` WRITE;
/*!40000 ALTER TABLE `ps_group` DISABLE KEYS */;
INSERT INTO `ps_group` VALUES (1,0.00,1,1,'2018-07-11 11:57:34','2019-08-08 23:10:42'),(2,0.00,1,1,'2018-07-11 11:57:34','2019-08-08 23:09:11'),(3,0.00,1,1,'2018-07-11 11:57:34','2018-07-13 14:32:13');
/*!40000 ALTER TABLE `ps_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_group_lang`
--

DROP TABLE IF EXISTS `ps_group_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_group_lang` (
  `id_group` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_group`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_group_lang`
--

LOCK TABLES `ps_group_lang` WRITE;
/*!40000 ALTER TABLE `ps_group_lang` DISABLE KEYS */;
INSERT INTO `ps_group_lang` VALUES (1,1,'訪客'),(1,2,'Visitor'),(1,3,'访客'),(1,4,'Visitor'),(2,1,'訪客（有購物車記錄）'),(2,2,'Visitor (With Cart)'),(2,3,'访客（有购物车记录）'),(2,4,'Visitor (With Cart)'),(3,1,'會員'),(3,2,'Member'),(3,3,'会员'),(3,4,'Member');
/*!40000 ALTER TABLE `ps_group_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_group_reduction`
--

DROP TABLE IF EXISTS `ps_group_reduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_group_reduction` (
  `id_group_reduction` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `id_group` int(10) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  `reduction` decimal(4,3) NOT NULL,
  PRIMARY KEY (`id_group_reduction`),
  UNIQUE KEY `id_group` (`id_group`,`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_group_reduction`
--

LOCK TABLES `ps_group_reduction` WRITE;
/*!40000 ALTER TABLE `ps_group_reduction` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_group_reduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_group_shop`
--

DROP TABLE IF EXISTS `ps_group_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_group_shop` (
  `id_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_group`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_group_shop`
--

LOCK TABLES `ps_group_shop` WRITE;
/*!40000 ALTER TABLE `ps_group_shop` DISABLE KEYS */;
INSERT INTO `ps_group_shop` VALUES (1,1),(2,1),(3,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(1,4),(2,4),(3,4);
/*!40000 ALTER TABLE `ps_group_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_gshoppingflux`
--

DROP TABLE IF EXISTS `ps_gshoppingflux`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gshoppingflux` (
  `id_gcategory` int(11) unsigned NOT NULL,
  `export` int(11) unsigned NOT NULL,
  `condition` varchar(12) NOT NULL,
  `availability` varchar(12) NOT NULL,
  `gender` varchar(8) NOT NULL,
  `age_group` varchar(8) NOT NULL,
  `color` varchar(64) NOT NULL,
  `material` varchar(64) NOT NULL,
  `pattern` varchar(64) NOT NULL,
  `size` varchar(64) NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  KEY `id_gcategory` (`id_gcategory`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_gshoppingflux`
--

LOCK TABLES `ps_gshoppingflux` WRITE;
/*!40000 ALTER TABLE `ps_gshoppingflux` DISABLE KEYS */;
INSERT INTO `ps_gshoppingflux` VALUES (1,1,'','','','','','','','',1),(2,1,'new','in stock','','','','','','',1),(7,1,'','','','','','','','',1),(8,1,'','','','','','','','',1),(9,1,'','','','','','','','',1),(10,1,'','','','','','','','',1),(11,1,'','','','','','','','',1),(12,1,'','','','','','','','',1),(13,1,'','','','','','','','',1),(14,1,'','','','','','','','',1),(15,1,'','','','','','','','',1),(16,1,'','','','','','','','',1),(17,1,'','','','','','','','',1),(18,1,'','','','','','','','',1),(1,1,'','','','','','','','',2),(2,1,'new','in stock','','','','','','',2),(1,1,'','','','','','','','',3),(2,1,'new','in stock','','','','','','',3),(1,1,'','','','','','','','',4),(2,1,'new','in stock','','','','','','',4),(3,1,'','','','','','','','',1),(3,1,'','','','','','','','',2),(3,1,'','','','','','','','',3),(3,1,'','','','','','','','',4);
/*!40000 ALTER TABLE `ps_gshoppingflux` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_gshoppingflux_lang`
--

DROP TABLE IF EXISTS `ps_gshoppingflux_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gshoppingflux_lang` (
  `id_gcategory` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `gcategory` varchar(255) NOT NULL,
  KEY `id_gcategory` (`id_gcategory`,`id_lang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_gshoppingflux_lang`
--

LOCK TABLES `ps_gshoppingflux_lang` WRITE;
/*!40000 ALTER TABLE `ps_gshoppingflux_lang` DISABLE KEYS */;
INSERT INTO `ps_gshoppingflux_lang` VALUES (1,1,1,''),(1,2,1,''),(1,3,1,''),(1,4,1,''),(2,1,1,'Google Category Example &gt; Google Sub-Category Example'),(2,2,1,'Google Category Example &gt; Google Sub-Category Example'),(2,3,1,'Google Category Example &gt; Google Sub-Category Example'),(2,4,1,'Google Category Example &gt; Google Sub-Category Example'),(7,1,1,''),(7,2,1,''),(7,3,1,''),(7,4,1,''),(8,1,1,''),(8,2,1,''),(8,3,1,''),(8,4,1,''),(9,1,1,''),(9,2,1,''),(9,3,1,''),(9,4,1,''),(10,1,1,''),(10,2,1,''),(10,3,1,''),(10,4,1,''),(11,1,1,''),(11,2,1,''),(11,3,1,''),(11,4,1,''),(12,1,1,''),(12,2,1,''),(12,3,1,''),(12,4,1,''),(13,1,1,''),(13,2,1,''),(13,3,1,''),(13,4,1,''),(14,1,1,''),(14,2,1,''),(14,3,1,''),(14,4,1,''),(15,1,1,''),(15,2,1,''),(15,3,1,''),(15,4,1,''),(16,1,1,''),(16,2,1,''),(16,3,1,''),(16,4,1,''),(17,1,1,''),(17,2,1,''),(17,3,1,''),(17,4,1,''),(18,1,1,''),(18,2,1,''),(18,3,1,''),(18,4,1,''),(1,1,2,''),(1,2,2,''),(1,3,2,''),(1,4,2,''),(2,1,2,'Google Category Example &gt; Google Sub-Category Example'),(2,2,2,'Google Category Example &gt; Google Sub-Category Example'),(2,3,2,'Google Category Example &gt; Google Sub-Category Example'),(2,4,2,'Google Category Example &gt; Google Sub-Category Example'),(1,1,3,''),(1,2,3,''),(1,3,3,''),(1,4,3,''),(2,1,3,'Google Category Example &gt; Google Sub-Category Example'),(2,2,3,'Google Category Example &gt; Google Sub-Category Example'),(2,3,3,'Google Category Example &gt; Google Sub-Category Example'),(2,4,3,'Google Category Example &gt; Google Sub-Category Example'),(1,1,4,''),(1,2,4,''),(1,3,4,''),(1,4,4,''),(2,1,4,'Google Category Example &gt; Google Sub-Category Example'),(2,2,4,'Google Category Example &gt; Google Sub-Category Example'),(2,3,4,'Google Category Example &gt; Google Sub-Category Example'),(2,4,4,'Google Category Example &gt; Google Sub-Category Example'),(3,1,1,''),(3,2,1,''),(3,3,1,''),(3,4,1,''),(3,1,2,''),(3,2,2,''),(3,3,2,''),(3,4,2,''),(3,1,3,''),(3,2,3,''),(3,3,3,''),(3,4,3,''),(3,1,4,''),(3,2,4,''),(3,3,4,''),(3,4,4,'');
/*!40000 ALTER TABLE `ps_gshoppingflux_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_gshoppingflux_lc`
--

DROP TABLE IF EXISTS `ps_gshoppingflux_lc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gshoppingflux_lc` (
  `id_glang` int(11) unsigned NOT NULL,
  `id_currency` varchar(255) NOT NULL,
  `tax_included` tinyint(1) NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  KEY `id_glang` (`id_glang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_gshoppingflux_lc`
--

LOCK TABLES `ps_gshoppingflux_lc` WRITE;
/*!40000 ALTER TABLE `ps_gshoppingflux_lc` DISABLE KEYS */;
INSERT INTO `ps_gshoppingflux_lc` VALUES (1,'1',1,1),(2,'1',1,1),(3,'1',1,1),(4,'1',1,1),(1,'1',1,2),(2,'1',1,2),(3,'1',1,2),(4,'1',1,2),(1,'1',1,3),(2,'1',1,3),(3,'1',1,3),(4,'1',1,3),(1,'1',1,4),(2,'1',1,4),(3,'1',1,4),(4,'1',1,4);
/*!40000 ALTER TABLE `ps_gshoppingflux_lc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_gsitemap_sitemap`
--

DROP TABLE IF EXISTS `ps_gsitemap_sitemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gsitemap_sitemap` (
  `link` varchar(255) DEFAULT NULL,
  `id_shop` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_gsitemap_sitemap`
--

LOCK TABLES `ps_gsitemap_sitemap` WRITE;
/*!40000 ALTER TABLE `ps_gsitemap_sitemap` DISABLE KEYS */;
INSERT INTO `ps_gsitemap_sitemap` VALUES ('1_tw_0_sitemap.xml',1),('1_en_0_sitemap.xml',1),('1_jp_0_sitemap.xml',1);
/*!40000 ALTER TABLE `ps_gsitemap_sitemap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_gtm_client`
--

DROP TABLE IF EXISTS `ps_gtm_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gtm_client` (
  `id_customer` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `id_client` varchar(50) NOT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_customer`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_gtm_client`
--

LOCK TABLES `ps_gtm_client` WRITE;
/*!40000 ALTER TABLE `ps_gtm_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_gtm_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_gtm_order`
--

DROP TABLE IF EXISTS `ps_gtm_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_gtm_order` (
  `id_order` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `via` varchar(10) DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_gtm_order`
--

LOCK TABLES `ps_gtm_order` WRITE;
/*!40000 ALTER TABLE `ps_gtm_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_gtm_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_guest`
--

DROP TABLE IF EXISTS `ps_guest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_guest` (
  `id_guest` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_operating_system` int(10) unsigned DEFAULT NULL,
  `id_web_browser` int(10) unsigned DEFAULT NULL,
  `id_customer` int(10) unsigned DEFAULT NULL,
  `javascript` tinyint(1) DEFAULT '0',
  `screen_resolution_x` smallint(5) unsigned DEFAULT NULL,
  `screen_resolution_y` smallint(5) unsigned DEFAULT NULL,
  `screen_color` tinyint(3) unsigned DEFAULT NULL,
  `sun_java` tinyint(1) DEFAULT NULL,
  `adobe_flash` tinyint(1) DEFAULT NULL,
  `adobe_director` tinyint(1) DEFAULT NULL,
  `apple_quicktime` tinyint(1) DEFAULT NULL,
  `real_player` tinyint(1) DEFAULT NULL,
  `windows_media` tinyint(1) DEFAULT NULL,
  `accept_language` varchar(8) DEFAULT NULL,
  `mobile_theme` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_guest`),
  KEY `id_customer` (`id_customer`),
  KEY `id_operating_system` (`id_operating_system`),
  KEY `id_web_browser` (`id_web_browser`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_guest`
--

LOCK TABLES `ps_guest` WRITE;
/*!40000 ALTER TABLE `ps_guest` DISABLE KEYS */;
INSERT INTO `ps_guest` VALUES (1,7,11,0,0,0,0,0,0,0,0,0,0,0,'zh',0),(2,7,11,0,0,0,0,0,0,0,0,0,0,0,'zh',0),(3,7,11,0,0,0,0,0,0,0,0,0,0,0,'zh',0),(4,7,11,0,0,0,0,0,0,0,0,0,0,0,'zh',0),(5,7,11,0,0,0,0,0,0,0,0,0,0,0,'zh',0);
/*!40000 ALTER TABLE `ps_guest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_homeslider`
--

DROP TABLE IF EXISTS `ps_homeslider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_homeslider` (
  `id_homeslider_slides` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_homeslider_slides`,`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_homeslider`
--

LOCK TABLES `ps_homeslider` WRITE;
/*!40000 ALTER TABLE `ps_homeslider` DISABLE KEYS */;
INSERT INTO `ps_homeslider` VALUES (5,1),(7,1),(8,1);
/*!40000 ALTER TABLE `ps_homeslider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_homeslider_slides`
--

DROP TABLE IF EXISTS `ps_homeslider_slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_homeslider_slides` (
  `id_homeslider_slides` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_homeslider_slides`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_homeslider_slides`
--

LOCK TABLES `ps_homeslider_slides` WRITE;
/*!40000 ALTER TABLE `ps_homeslider_slides` DISABLE KEYS */;
INSERT INTO `ps_homeslider_slides` VALUES (5,0,1),(7,0,1),(8,0,0);
/*!40000 ALTER TABLE `ps_homeslider_slides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_homeslider_slides_lang`
--

DROP TABLE IF EXISTS `ps_homeslider_slides_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_homeslider_slides_lang` (
  `id_homeslider_slides` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `legend` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id_homeslider_slides`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_homeslider_slides_lang`
--

LOCK TABLES `ps_homeslider_slides_lang` WRITE;
/*!40000 ALTER TABLE `ps_homeslider_slides_lang` DISABLE KEYS */;
INSERT INTO `ps_homeslider_slides_lang` VALUES (5,1,'','','','https://www.tekapo.io','1.png'),(5,2,'','','','https://www.tekapo.io','1.png'),(5,3,'','','','https://www.tekapo.io','1.png'),(5,4,'','','','https://www.tekapo.io','1.png'),(7,1,'','','','https://www.tekapo.io','2.png'),(7,2,'','','','https://www.tekapo.io','2.png'),(7,3,'','','','https://www.tekapo.io','2.png'),(7,4,'','','','https://www.tekapo.io','2.png'),(8,1,'','<div style=\"text-align:center;\"><a href=\"#\" style=\"color:#2fb5d2;font-weight:bold;\">＼TekapoCart 誕生！ ／<br />限時活動正式開跑</a>\n<div style=\"margin-top:12px;\"><a href=\"#\" style=\"background-color:#f3cb54;color:#fff;padding:8px 23px;border-radius:50px;\">完整活動看這裡 <i class=\"material-icons\" style=\"border-radius:50px;background-color:#2fb5d2;\">navigate_next</i></a></div>\n</div>','','https://www.tekapo.io','3.png'),(8,2,'','','','https://www.tekapo.io','3.png'),(8,3,'','','','https://www.tekapo.io','3.png'),(8,4,'','','','https://www.tekapo.io','3.png');
/*!40000 ALTER TABLE `ps_homeslider_slides_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_hook`
--

DROP TABLE IF EXISTS `ps_hook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_hook` (
  `id_hook` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `title` varchar(64) NOT NULL,
  `description` text,
  `position` tinyint(1) NOT NULL DEFAULT '1',
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_hook`),
  UNIQUE KEY `hook_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_hook`
--

LOCK TABLES `ps_hook` WRITE;
/*!40000 ALTER TABLE `ps_hook` DISABLE KEYS */;
INSERT INTO `ps_hook` VALUES (1,'actionValidateOrder','New orders','',1,0),(2,'displayMaintenance','Maintenance Page','This hook displays new elements on the maintenance page',1,0),(3,'displayProductPageDrawer','Product Page Drawer','This hook displays content in the right sidebar of the product page',1,0),(4,'actionPaymentConfirmation','Payment confirmation','This hook displays new elements after the payment is validated',1,0),(5,'displayPaymentReturn','Payment return','',1,0),(6,'actionUpdateQuantity','Quantity update','Quantity is updated only when a customer effectively places their order',1,0),(7,'displayRightColumn','分類頁、活動頁 右側欄','預設模組：分類連結、Faceted search',1,31),(8,'displayWrapperTop','Main wrapper section (top)','This hook displays new elements in the top of the main wrapper',1,0),(9,'displayWrapperBottom','全站 頁尾滿版','預設模組：無',1,6),(10,'displayContentWrapperTop','Content wrapper section (top)','This hook displays new elements in the top of the content wrapper',1,0),(11,'displayContentWrapperBottom','Content wrapper section (bottom)','This hook displays new elements in the bottom of the content wrapper',1,0),(12,'displayLeftColumn','分類頁、活動頁 左側欄','預設模組：分類連結、Faceted search',1,30),(13,'displayHome','首頁 主內容','預設模組：推薦分類商品區塊、圖片區塊、文字區塊',1,20),(14,'Header','Pages html head section','This hook adds additional elements in the head section of your pages (head section of html)',1,0),(15,'actionCartSave','Cart creation and update','This hook is displayed when a product is added to the cart or if the cart\'s content is modified',1,0),(16,'actionAuthentication','Successful customer authentication','This hook is displayed after a customer successfully signs in',1,0),(17,'actionProductAdd','Product creation','This hook is displayed after a product is created',1,0),(18,'actionProductUpdate','Product update','This hook is displayed after a product has been updated',1,0),(19,'displayAfterBodyOpeningTag','Very top of pages','Use this hook for advertisement or modals you want to load first',1,0),(20,'displayBeforeBodyClosingTag','Very bottom of pages','Use this hook for your modals or any content you want to load at the very end',1,0),(21,'displayTop','全站 頁首中區','預設模組：無',1,4),(22,'displayNavFullWidth','全站 頁首滿版','預設模組：無',1,5),(23,'displayRightColumnProduct','商品頁 右側欄','預設模組：分類連結',1,41),(24,'actionProductDelete','Product deletion','This hook is called when a product is deleted',1,0),(25,'actionObjectProductInCartDeleteBefore','Cart product removal','This hook is called before a product is removed from a cart',1,0),(26,'actionObjectProductInCartDeleteAfter','Cart product removal','This hook is called after a product is removed from a cart',1,0),(27,'displayFooterProduct','商品頁 頁尾','預設模組：交叉銷售、已瀏覽商品區塊',1,42),(28,'displayInvoice','Invoice','This hook displays new blocks on the invoice (order)',1,0),(29,'actionOrderStatusUpdate','Order status update - Event','This hook launches modules when the status of an order changes',1,0),(30,'displayAdminOrder','Display new elements in the Back Office, tab AdminOrder','This hook launches modules when the AdminOrder tab is displayed in the Back Office',1,0),(31,'displayAdminOrderTabOrder','Display new elements in Back Office, AdminOrder, panel Order','This hook launches modules when the AdminOrder tab is displayed in the Back Office and extends / override Order panel tabs',1,0),(32,'displayAdminOrderTabShip','Display new elements in Back Office, AdminOrder, panel Shipping','This hook launches modules when the AdminOrder tab is displayed in the Back Office and extends / override Shipping panel tabs',1,0),(33,'displayAdminOrderContentOrder','Display new elements in Back Office, AdminOrder, panel Order','This hook launches modules when the AdminOrder tab is displayed in the Back Office and extends / override Order panel content',1,0),(34,'displayAdminOrderContentShip','Display new elements in Back Office, AdminOrder, panel Shipping','This hook launches modules when the AdminOrder tab is displayed in the Back Office and extends / override Shipping panel content',1,0),(35,'displayFooter','全站 頁尾','預設模組：連結列表、聯絡資訊',1,8),(36,'displayPDFInvoice','PDF Invoice','This hook allows you to display additional information on PDF invoices',1,0),(37,'displayInvoiceLegalFreeText','PDF Invoice - Legal Free Text','This hook allows you to modify the legal free text on PDF invoices',1,0),(38,'displayAdminCustomers','Display new elements in the Back Office, tab AdminCustomers','This hook launches modules when the AdminCustomers tab is displayed in the Back Office',1,0),(39,'displayAdminCustomersAddressesItemAction','Display new elements in the Back Office, tab AdminCustomers, Add','This hook launches modules when the Addresses list into the AdminCustomers tab is displayed in the Back Office',1,0),(40,'displayOrderConfirmation','Order confirmation page','This hook is called within an order\'s confirmation page',1,0),(41,'actionCustomerAccountAdd','Successful customer account creation','This hook is called when a new customer creates an account successfully',1,0),(42,'actionCustomerAccountUpdate','Successful customer account update','This hook is called when a customer updates its account successfully',1,0),(43,'displayCustomerAccount','Customer account displayed in Front Office','This hook displays new elements on the customer account page',1,0),(44,'actionOrderSlipAdd','Order slip creation','This hook is called when a new credit slip is added regarding client order',1,0),(45,'displayShoppingCartFooter','Shopping cart footer','This hook displays some specific information on the shopping cart\'s page',1,0),(46,'displayCreateAccountEmailFormBottom','Customer authentication form','This hook displays some information on the bottom of the email form',1,0),(47,'displayAuthenticateFormBottom','Customer authentication form','This hook displays some information on the bottom of the authentication form',1,0),(48,'displayCustomerAccountForm','Customer account creation form','This hook displays some information on the form to create a customer account',1,0),(49,'displayAdminStatsModules','Stats - Modules','',1,0),(50,'displayAdminStatsGraphEngine','Graph engines','',1,0),(51,'actionOrderReturn','Returned product','This hook is displayed when a customer returns a product ',1,0),(52,'displayProductAdditionalInfo','商品頁 額外資訊','預設模組：社群分享連結',1,41),(53,'displayBackOfficeHome','Administration panel homepage','This hook is displayed on the admin panel\'s homepage',1,0),(54,'displayAdminStatsGridEngine','Grid engines','',1,0),(55,'actionWatermark','Watermark','',1,0),(56,'actionProductCancel','Product cancelled','This hook is called when you cancel a product in an order',1,0),(57,'displayLeftColumnProduct','商品頁 左側欄','預設模組：分類連結',1,40),(58,'actionProductOutOfStock','Out-of-stock product','This hook displays new action buttons if a product is out of stock',1,0),(59,'actionProductAttributeUpdate','Product attribute update','This hook is displayed when a product\'s attribute is updated',1,0),(60,'displayCarrierList','Extra carrier (module mode)','',1,0),(61,'displayShoppingCart','Shopping cart - Additional button','This hook displays new action buttons within the shopping cart',1,0),(62,'actionCarrierUpdate','Carrier Update','This hook is called when a carrier is updated',1,0),(63,'actionOrderStatusPostUpdate','Post update of order status','',1,0),(64,'displayCustomerAccountFormTop','Block above the form for create an account','This hook is displayed above the customer\'s account creation form',1,0),(65,'displayBackOfficeHeader','Administration panel header','This hook is displayed in the header of the admin panel',1,0),(66,'displayBackOfficeTop','Administration panel hover the tabs','This hook is displayed on the roll hover of the tabs within the admin panel',1,0),(67,'displayAdminEndContent','Administration end of content','This hook is displayed at the end of the main content, before the footer',1,0),(68,'displayBackOfficeFooter','Administration panel footer','This hook is displayed within the admin panel\'s footer',1,0),(69,'actionProductAttributeDelete','Product attribute deletion','This hook is displayed when a product\'s attribute is deleted',1,0),(70,'actionCarrierProcess','Carrier process','',1,0),(71,'displayBeforeCarrier','Before carriers list','This hook is displayed before the carrier list in Front Office',1,0),(72,'displayAfterCarrier','After carriers list','This hook is displayed after the carrier list in Front Office',1,0),(73,'displayOrderDetail','Order detail','This hook is displayed within the order\'s details in Front Office',1,0),(74,'actionPaymentCCAdd','Payment CC added','',1,0),(75,'actionCategoryAdd','Category creation','This hook is displayed when a category is created',1,0),(76,'actionCategoryUpdate','Category modification','This hook is displayed when a category is modified',1,0),(77,'actionCategoryDelete','Category deletion','This hook is displayed when a category is deleted',1,0),(78,'displayPaymentTop','Top of payment page','This hook is displayed at the top of the payment page',1,0),(79,'actionHtaccessCreate','After htaccess creation','This hook is displayed after the htaccess creation',1,0),(80,'actionAdminMetaSave','After saving the configuration in AdminMeta','This hook is displayed after saving the configuration in AdminMeta',1,0),(81,'displayAttributeGroupForm','Add fields to the form \'attribute group\'','This hook adds fields to the form \'attribute group\'',1,0),(82,'actionAttributeGroupSave','Saving an attribute group','This hook is called while saving an attributes group',1,0),(83,'actionAttributeGroupDelete','Deleting attribute group','This hook is called while deleting an attributes  group',1,0),(84,'displayFeatureForm','Add fields to the form \'feature\'','This hook adds fields to the form \'feature\'',1,0),(85,'actionFeatureSave','Saving attributes\' features','This hook is called while saving an attributes features',1,0),(86,'actionFeatureDelete','Deleting attributes\' features','This hook is called while deleting an attributes features',1,0),(87,'actionProductSave','Saving products','This hook is called while saving products',1,0),(88,'displayAttributeGroupPostProcess','On post-process in admin attribute group','This hook is called on post-process in admin attribute group',1,0),(89,'displayFeaturePostProcess','On post-process in admin feature','This hook is called on post-process in admin feature',1,0),(90,'displayFeatureValueForm','Add fields to the form \'feature value\'','This hook adds fields to the form \'feature value\'',1,0),(91,'displayFeatureValuePostProcess','On post-process in admin feature value','This hook is called on post-process in admin feature value',1,0),(92,'actionFeatureValueDelete','Deleting attributes\' features\' values','This hook is called while deleting an attributes features value',1,0),(93,'actionFeatureValueSave','Saving an attributes features value','This hook is called while saving an attributes features value',1,0),(94,'displayAttributeForm','Add fields to the form \'attribute value\'','This hook adds fields to the form \'attribute value\'',1,0),(95,'actionAttributePostProcess','On post-process in admin feature value','This hook is called on post-process in admin feature value',1,0),(96,'actionAttributeDelete','Deleting an attributes features value','This hook is called while deleting an attributes features value',1,0),(97,'actionAttributeSave','Saving an attributes features value','This hook is called while saving an attributes features value',1,0),(98,'actionTaxManager','Tax Manager Factory','',1,0),(99,'displayMyAccountBlock','My account block','This hook displays extra information within the \'my account\' block\"',1,0),(100,'actionModuleInstallBefore','actionModuleInstallBefore','',1,0),(101,'actionModuleInstallAfter','actionModuleInstallAfter','',1,0),(102,'displayTopColumn','Top column blocks','This hook displays new elements in the top of columns',1,0),(103,'displayBackOfficeCategory','Display new elements in the Back Office, tab AdminCategories','This hook launches modules when the AdminCategories tab is displayed in the Back Office',1,0),(104,'displayProductListFunctionalButtons','Display new elements in the Front Office, products list','This hook launches modules when the products list is displayed in the Front Office',1,0),(105,'displayNav','Navigation','',1,0),(106,'displayOverrideTemplate','Change the default template of current controller','',1,0),(107,'actionAdminLoginControllerSetMedia','Set media on admin login page header','This hook is called after adding media to admin login page header',1,0),(108,'actionOrderEdited','Order edited','This hook is called when an order is edited',1,0),(109,'actionEmailAddBeforeContent','Add extra content before mail content','This hook is called just before fetching mail template',1,0),(110,'actionEmailAddAfterContent','Add extra content after mail content','This hook is called just after fetching mail template',1,0),(111,'sendMailAlterTemplateVars','Alter template vars on the fly','This hook is called when Mail::send() is called',1,0),(112,'displayCartExtraProductActions','Extra buttons in shopping cart','This hook adds extra buttons to the product lines, in the shopping cart',1,0),(113,'displayPaymentByBinaries','Payment form generated by binaries','This hook displays form generated by binaries during the checkout',1,0),(114,'additionalCustomerFormFields','Add fields to the Customer form','This hook returns an array of FormFields to add them to the customer registration form',1,0),(115,'addWebserviceResources','Add extra webservice resource','This hook is called when webservice resources list in webservice controller',1,0),(116,'displayCustomerLoginFormAfter','Display elements after login form','This hook displays new elements after the login form',1,0),(117,'actionClearCache','Clear smarty cache','This hook is called when smarty\'s cache is cleared',1,0),(118,'actionClearCompileCache','Clear smarty compile cache','This hook is called when smarty\'s compile cache is cleared',1,0),(119,'actionClearSf2Cache','Clear Sf2 cache','This hook is called when the Symfony cache is cleared',1,0),(120,'actionValidateCustomerAddressForm','Customer address form validation','This hook is called when a customer submit its address form',1,0),(121,'displayCarrierExtraContent','Display additional content for a carrier (e.g pickup points)','This hook calls only the module related to the carrier, in order to add options when needed',1,0),(122,'validateCustomerFormFields','Customer registration form validation','This hook is called to a module when it has sent additional fields with additionalCustomerFormFields',1,0),(123,'displayProductExtraContent','Display extra content on the product page','This hook expects ProductExtraContent instances, which will be properly displayed by the template on the product page',1,0),(124,'filterCmsContent','Filter the content page','This hook is called just before fetching content page',1,0),(125,'filterCmsCategoryContent','Filter the content page category','This hook is called just before fetching content page category',1,0),(126,'filterProductContent','Filter the content page product','This hook is called just before fetching content page product',1,0),(127,'filterCategoryContent','Filter the content page category','This hook is called just before fetching content page category',1,0),(128,'filterManufacturerContent','Filter the content page manufacturer','This hook is called just before fetching content page manufacturer',1,0),(129,'filterSupplierContent','Filter the content page supplier','This hook is called just before fetching content page supplier',1,0),(130,'filterHtmlContent','Filter HTML field before rending a page','This hook is called just before fetching a page on HTML field',1,0),(131,'displayDashboardTop','Dashboard Top','Displays the content in the dashboard\'s top area',1,0),(132,'actionUpdateLangAfter','Update \"lang\" tables','Update \"lang\" tables after adding or updating a language',1,0),(133,'actionOutputHTMLBefore','Before HTML output','This hook is used to filter the whole HTML page before it is rendered (only front)',1,0),(134,'displayAfterProductThumbs','Display extra content below product thumbs','This hook displays new elements below product images ex. additional media',1,0),(135,'actionDispatcherBefore','Before dispatch','This hook is called at the beginning of the dispatch method of the Dispatcher',1,0),(136,'actionDispatcherAfter','After dispatch','This hook is called at the end of the dispatch method of the Dispatcher',1,0),(137,'filterProductSearch','Filter search products result','This hook is called in order to allow to modify search product result',1,0),(138,'actionProductSearchAfter','Event triggered after search product completed','This hook is called after the product search. Parameters are already filter',1,0),(139,'actionEmailSendBefore','Before sending an email','This hook is used to filter the content or the metadata of an email before sending it or even prevent its sending',1,0),(140,'displayAdminProductsMainStepLeftColumnMiddle','Display new elements in back office product page, left column of','This hook launches modules when the back office product page is displayed',1,0),(141,'displayAdminProductsMainStepLeftColumnBottom','Display new elements in back office product page, left column of','This hook launches modules when the back office product page is displayed',1,0),(142,'displayAdminProductsMainStepRightColumnBottom','Display new elements in back office product page, right column o','This hook launches modules when the back office product page is displayed',1,0),(143,'displayAdminProductsQuantitiesStepBottom','Display new elements in back office product page, Quantities/Com','This hook launches modules when the back office product page is displayed',1,0),(144,'displayAdminProductsPriceStepBottom','Display new elements in back office product page, Price tab','This hook launches modules when the back office product page is displayed',1,0),(145,'displayAdminProductsOptionsStepTop','Display new elements in back office product page, Options tab','This hook launches modules when the back office product page is displayed',1,0),(146,'displayAdminProductsOptionsStepBottom','Display new elements in back office product page, Options tab','This hook launches modules when the back office product page is displayed',1,0),(147,'displayAdminProductsSeoStepBottom','Display new elements in back office product page, SEO tab','This hook launches modules when the back office product page is displayed',1,0),(148,'displayAdminProductsShippingStepBottom','Display new elements in back office product page, Shipping tab','This hook launches modules when the back office product page is displayed',1,0),(149,'displayAdminProductsCombinationBottom','Display new elements in back office product page, Combination ta','This hook launches modules when the back office product page is displayed',1,0),(150,'displayDashboardToolbarTopMenu','Display new elements in back office page with a dashboard, on to','This hook launches modules when a page with a dashboard is displayed',1,0),(151,'displayDashboardToolbarIcons','Display new elements in back office page with dashboard, on icon','This hook launches modules when the back office with dashboard is displayed',1,0),(152,'actionBuildFrontEndObject','Manage elements added to the \"prestashop\" javascript object','This hook allows you to customize the \"prestashop\" javascript object that is included in all front office pages',1,0),(153,'actionFrontControllerAfterInit','Perform actions after front office controller initialization','This hook is launched after the initialization of all front office controllers',1,0),(154,'actionAdministrationPageForm','Manage Administration Page form fields','This hook adds, update or remove fields of the Administration Page form',1,0),(155,'actionAdministrationPageFormSave','Processing Administration page form','This hook is called when the Administration Page form is processed',1,0),(156,'actionPerformancePageForm','Manage Performance Page form fields','This hook adds, update or remove fields of the Performance Page form',1,0),(157,'actionPerformancePageFormSave','Processing Performance page form','This hook is called when the Performance Page form is processed',1,0),(158,'actionMaintenancePageForm','Manage Maintenance Page form fields','This hook adds, update or remove fields of the Maintenance Page form',1,0),(159,'actionMaintenancePageFormSave','Processing Maintenance page form','This hook is called when the Maintenance Page form is processed',1,0),(160,'registerGDPRConsent','registerGDPRConsent','',1,0),(161,'dashboardZoneOne','dashboardZoneOne','',1,0),(162,'dashboardData','dashboardData','',1,0),(163,'actionObjectOrderAddAfter','actionObjectOrderAddAfter','',1,0),(164,'actionObjectCustomerAddAfter','actionObjectCustomerAddAfter','',1,0),(165,'actionObjectCustomerMessageAddAfter','actionObjectCustomerMessageAddAfter','',1,0),(166,'actionObjectCustomerThreadAddAfter','actionObjectCustomerThreadAddAfter','',1,0),(167,'actionObjectOrderReturnAddAfter','actionObjectOrderReturnAddAfter','',1,0),(168,'actionAdminControllerSetMedia','actionAdminControllerSetMedia','',1,0),(169,'dashboardZoneTwo','dashboardZoneTwo','',1,0),(170,'actionSearch','actionSearch','',1,0),(171,'actionObjectLanguageAddAfter','actionObjectLanguageAddAfter','',1,0),(172,'paymentOptions','paymentOptions','',1,0),(173,'displayNav1','全站 頁首左區','預設模組：Logo、主選單',1,2),(174,'actionAdminStoresControllerUpdate_optionsAfter','actionAdminStoresControllerUpdate_optionsAfter','',1,0),(175,'actionAdminCurrenciesControllerSaveAfter','actionAdminCurrenciesControllerSaveAfter','',1,0),(176,'actionModuleRegisterHookAfter','actionModuleRegisterHookAfter','',1,0),(177,'actionModuleUnRegisterHookAfter','actionModuleUnRegisterHookAfter','',1,0),(178,'actionShopDataDuplication','actionShopDataDuplication','',1,0),(179,'displayFooterBefore','全站 頁尾上方','預設模組：訂閱電子報、官方社群連結',1,7),(180,'displayAdminCustomersForm','displayAdminCustomersForm','',1,0),(181,'actionDeleteGDPRCustomer','actionDeleteGDPRCustomer','',1,0),(182,'actionExportGDPRData','actionExportGDPRData','',1,0),(183,'productSearchProvider','productSearchProvider','',1,0),(184,'displayOrderConfirmation2','displayOrderConfirmation2','',1,0),(185,'displayCrossSellingShoppingCart','displayCrossSellingShoppingCart','',1,0),(186,'actionAdminGroupsControllerSaveAfter','actionAdminGroupsControllerSaveAfter','',1,0),(187,'actionObjectCategoryUpdateAfter','actionObjectCategoryUpdateAfter','',1,0),(188,'actionObjectCategoryDeleteAfter','actionObjectCategoryDeleteAfter','',1,0),(189,'actionObjectCategoryAddAfter','actionObjectCategoryAddAfter','',1,0),(190,'actionObjectCmsUpdateAfter','actionObjectCmsUpdateAfter','',1,0),(191,'actionObjectCmsDeleteAfter','actionObjectCmsDeleteAfter','',1,0),(192,'actionObjectCmsAddAfter','actionObjectCmsAddAfter','',1,0),(193,'actionObjectSupplierUpdateAfter','actionObjectSupplierUpdateAfter','',1,0),(194,'actionObjectSupplierDeleteAfter','actionObjectSupplierDeleteAfter','',1,0),(195,'actionObjectSupplierAddAfter','actionObjectSupplierAddAfter','',1,0),(196,'actionObjectManufacturerUpdateAfter','actionObjectManufacturerUpdateAfter','',1,0),(197,'actionObjectManufacturerDeleteAfter','actionObjectManufacturerDeleteAfter','',1,0),(198,'actionObjectManufacturerAddAfter','actionObjectManufacturerAddAfter','',1,0),(199,'actionObjectProductUpdateAfter','actionObjectProductUpdateAfter','',1,0),(200,'actionObjectProductDeleteAfter','actionObjectProductDeleteAfter','',1,0),(201,'actionObjectProductAddAfter','actionObjectProductAddAfter','',1,0),(202,'displaySearch','displaySearch','',1,0),(203,'displayAdminNavBarBeforeEnd','displayAdminNavBarBeforeEnd','',1,0),(204,'displayAdminAfterHeader','displayAdminAfterHeader','',1,0),(205,'displayNav2','全站 頁首右區','預設模組：搜索欄、語言選擇區塊、貨幣區塊、登入連結、購物車',1,3),(206,'displayReassurance','','',1,0),(207,'actionAdminMetaControllerUpdate_optionsAfter','actionAdminMetaControllerUpdate_optionsAfter','',1,0),(208,'actionAdminPerformanceControllerSaveAfter','actionAdminPerformanceControllerSaveAfter','',1,0),(209,'actionObjectCarrierAddAfter','actionObjectCarrierAddAfter','',1,0),(210,'actionObjectContactAddAfter','actionObjectContactAddAfter','',1,0),(211,'actionAdminThemesControllerUpdate_optionsAfter','actionAdminThemesControllerUpdate_optionsAfter','',1,0),(212,'actionObjectShopUpdateAfter','actionObjectShopUpdateAfter','',1,0),(213,'actionAdminPreferencesControllerUpdate_optionsAfter','actionAdminPreferencesControllerUpdate_optionsAfter','',1,0),(214,'actionObjectShopAddAfter','actionObjectShopAddAfter','',1,0),(215,'actionObjectShopGroupAddAfter','actionObjectShopGroupAddAfter','',1,0),(216,'actionObjectCartAddAfter','actionObjectCartAddAfter','',1,0),(217,'actionObjectEmployeeAddAfter','actionObjectEmployeeAddAfter','',1,0),(218,'actionObjectImageAddAfter','actionObjectImageAddAfter','',1,0),(219,'actionObjectCartRuleAddAfter','actionObjectCartRuleAddAfter','',1,0),(220,'actionAdminStoresControllerSaveAfter','actionAdminStoresControllerSaveAfter','',1,0),(221,'actionAdminWebserviceControllerSaveAfter','actionAdminWebserviceControllerSaveAfter','',1,0),(222,'actionObjectSpecificPriceCoreDeleteAfter','actionObjectSpecificPriceCoreDeleteAfter','',1,0),(223,'actionObjectSpecificPriceCoreAddAfter','actionObjectSpecificPriceCoreAddAfter','',1,0),(224,'actionObjectSpecificPriceCoreUpdateAfter','actionObjectSpecificPriceCoreUpdateAfter','',1,0),(225,'actionProductCoverage','actionProductCoverage','',1,0),(226,'displayPaymentEu','displayPaymentEu','Hook to display payment options',1,0),(227,'displayProductPriceBlock','displayProductPriceBlock','',1,0),(228,'displayCheckoutSubtotalDetails','displayCheckoutSubtotalDetails','',1,0),(229,'displayFooterAfter','全站 頁尾下方','',1,9),(230,'advancedPaymentOptions','advancedPaymentOptions','',1,0),(231,'displayCartTotalPriceLabel','displayCartTotalPriceLabel','',1,0),(232,'displayCMSPrintButton','displayCMSPrintButton','',1,0),(233,'displayCMSDisputeInformation','displayCMSDisputeInformation','',1,0),(234,'termsAndConditions','termsAndConditions','',1,0),(235,'displayCheckoutSummaryTop','displayCheckoutSummaryTop','',1,0),(236,'actionFrontControllerSetMedia','actionFrontControllerSetMedia','',1,0),(237,'actionAjaxDieProductControllerdisplayAjaxQuickviewBefore','actionAjaxDieProductControllerdisplayAjaxQuickviewBefore','',1,0),(238,'displayBanner','全站 頁首頂端','預設模組：頁首置頂區塊、圖片輪播',1,1),(239,'displayCheckoutStepOneNotLogged','結帳頁第一步未登入情況','',1,0),(240,'displayOrderConfirmation1','displayOrderConfirmation1','',1,0),(241,'displayCheckoutButtonBefore','displayCheckoutButtonBefore','',1,0),(242,'gSitemapAppendUrls','GSitemap Append URLs','This hook allows a module to add URLs to a generated sitemap',1,0),(243,'actionObjectCurrencyAddAfter','actionObjectCurrencyAddAfter','',1,0),(244,'actionCartUpdateQuantityBefore','actionCartUpdateQuantityBefore','',1,0),(245,'displayCustomerLoginLink','頁首登入按鈕','',1,0),(246,'displayLeftColumnContact','聯絡我們 左側欄','',1,20),(247,'displayHomeAfter','首頁 主內容下方滿版','',1,21),(248,'actionListMailThemes','List the available email themes and layouts','This hook allows to add/remove available email themes (ThemeInterface) and/or to add/remove their layouts (LayoutInterface)',1,0),(249,'actionGetMailThemeFolder','Define the folder of an email theme','This hook allows to change the folder of an email theme (useful if you theme is in a module for example)',1,0),(250,'actionBuildMailLayoutVariables','Build the variables used in email layout rendering','This hook allows to change the variables used when an email layout is rendered',1,0),(251,'actionGetMailLayoutTransformations','Define the transformation to apply on layout','This hook allows to add/remove TransformationInterface used to generate an email layout',1,0),(252,'actionSqlRequestFormBuilderModifier','Modify sql request identifiable object form','This hook allows to modify sql request identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(253,'actionCustomerFormBuilderModifier','Modify customer identifiable object form','This hook allows to modify customer identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(254,'actionLanguageFormBuilderModifier','Modify language identifiable object form','This hook allows to modify language identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(255,'actionCurrencyFormBuilderModifier','Modify currency identifiable object form','This hook allows to modify currency identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(256,'actionWebserviceKeyFormBuilderModifier','Modify webservice key identifiable object form','This hook allows to modify webservice key identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(257,'actionMetaFormBuilderModifier','Modify meta identifiable object form','This hook allows to modify meta identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(258,'actionCategoryFormBuilderModifier','Modify category identifiable object form','This hook allows to modify category identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(259,'actionRootCategoryFormBuilderModifier','Modify root category identifiable object form','This hook allows to modify root category identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(260,'actionContactFormBuilderModifier','Modify contact identifiable object form','This hook allows to modify contact identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(261,'actionCmsPageCategoryFormBuilderModifier','Modify cms page category identifiable object form','This hook allows to modify cms page category identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(262,'actionTaxFormBuilderModifier','Modify tax identifiable object form','This hook allows to modify tax identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(263,'actionManufacturerFormBuilderModifier','Modify manufacturer identifiable object form','This hook allows to modify manufacturer identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(264,'actionEmployeeFormBuilderModifier','Modify employee identifiable object form','This hook allows to modify employee identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(265,'actionProfileFormBuilderModifier','Modify profile identifiable object form','This hook allows to modify profile identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(266,'actionCmsPageFormBuilderModifier','Modify cms page identifiable object form','This hook allows to modify cms page identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(267,'actionManufacturerAddressFormBuilderModifier','Modify manufacturer address identifiable object form','This hook allows to modify manufacturer address identifiable object forms content by modifying form builder data or FormBuilder itself',1,0),(268,'actionBeforeUpdateSqlRequestFormHandler','Modify sql request identifiable object data before updating it','This hook allows to modify sql request identifiable object forms data before it was updated',1,0),(269,'actionBeforeUpdateCustomerFormHandler','Modify customer identifiable object data before updating it','This hook allows to modify customer identifiable object forms data before it was updated',1,0),(270,'actionBeforeUpdateLanguageFormHandler','Modify language identifiable object data before updating it','This hook allows to modify language identifiable object forms data before it was updated',1,0),(271,'actionBeforeUpdateCurrencyFormHandler','Modify currency identifiable object data before updating it','This hook allows to modify currency identifiable object forms data before it was updated',1,0),(272,'actionBeforeUpdateWebserviceKeyFormHandler','Modify webservice key identifiable object data before updating i','This hook allows to modify webservice key identifiable object forms data before it was updated',1,0),(273,'actionBeforeUpdateMetaFormHandler','Modify meta identifiable object data before updating it','This hook allows to modify meta identifiable object forms data before it was updated',1,0),(274,'actionBeforeUpdateCategoryFormHandler','Modify category identifiable object data before updating it','This hook allows to modify category identifiable object forms data before it was updated',1,0),(275,'actionBeforeUpdateRootCategoryFormHandler','Modify root category identifiable object data before updating it','This hook allows to modify root category identifiable object forms data before it was updated',1,0),(276,'actionBeforeUpdateContactFormHandler','Modify contact identifiable object data before updating it','This hook allows to modify contact identifiable object forms data before it was updated',1,0),(277,'actionBeforeUpdateCmsPageCategoryFormHandler','Modify cms page category identifiable object data before updatin','This hook allows to modify cms page category identifiable object forms data before it was updated',1,0),(278,'actionBeforeUpdateTaxFormHandler','Modify tax identifiable object data before updating it','This hook allows to modify tax identifiable object forms data before it was updated',1,0),(279,'actionBeforeUpdateManufacturerFormHandler','Modify manufacturer identifiable object data before updating it','This hook allows to modify manufacturer identifiable object forms data before it was updated',1,0),(280,'actionBeforeUpdateEmployeeFormHandler','Modify employee identifiable object data before updating it','This hook allows to modify employee identifiable object forms data before it was updated',1,0),(281,'actionBeforeUpdateProfileFormHandler','Modify profile identifiable object data before updating it','This hook allows to modify profile identifiable object forms data before it was updated',1,0),(282,'actionBeforeUpdateCmsPageFormHandler','Modify cms page identifiable object data before updating it','This hook allows to modify cms page identifiable object forms data before it was updated',1,0),(283,'actionBeforeUpdateManufacturerAddressFormHandler','Modify manufacturer address identifiable object data before upda','This hook allows to modify manufacturer address identifiable object forms data before it was updated',1,0),(284,'actionAfterUpdateSqlRequestFormHandler','Modify sql request identifiable object data after updating it','This hook allows to modify sql request identifiable object forms data after it was updated',1,0),(285,'actionAfterUpdateCustomerFormHandler','Modify customer identifiable object data after updating it','This hook allows to modify customer identifiable object forms data after it was updated',1,0),(286,'actionAfterUpdateLanguageFormHandler','Modify language identifiable object data after updating it','This hook allows to modify language identifiable object forms data after it was updated',1,0),(287,'actionAfterUpdateCurrencyFormHandler','Modify currency identifiable object data after updating it','This hook allows to modify currency identifiable object forms data after it was updated',1,0),(288,'actionAfterUpdateWebserviceKeyFormHandler','Modify webservice key identifiable object data after updating it','This hook allows to modify webservice key identifiable object forms data after it was updated',1,0),(289,'actionAfterUpdateMetaFormHandler','Modify meta identifiable object data after updating it','This hook allows to modify meta identifiable object forms data after it was updated',1,0),(290,'actionAfterUpdateCategoryFormHandler','Modify category identifiable object data after updating it','This hook allows to modify category identifiable object forms data after it was updated',1,0),(291,'actionAfterUpdateRootCategoryFormHandler','Modify root category identifiable object data after updating it','This hook allows to modify root category identifiable object forms data after it was updated',1,0),(292,'actionAfterUpdateContactFormHandler','Modify contact identifiable object data after updating it','This hook allows to modify contact identifiable object forms data after it was updated',1,0),(293,'actionAfterUpdateCmsPageCategoryFormHandler','Modify cms page category identifiable object data after updating','This hook allows to modify cms page category identifiable object forms data after it was updated',1,0),(294,'actionAfterUpdateTaxFormHandler','Modify tax identifiable object data after updating it','This hook allows to modify tax identifiable object forms data after it was updated',1,0),(295,'actionAfterUpdateManufacturerFormHandler','Modify manufacturer identifiable object data after updating it','This hook allows to modify manufacturer identifiable object forms data after it was updated',1,0),(296,'actionAfterUpdateEmployeeFormHandler','Modify employee identifiable object data after updating it','This hook allows to modify employee identifiable object forms data after it was updated',1,0),(297,'actionAfterUpdateProfileFormHandler','Modify profile identifiable object data after updating it','This hook allows to modify profile identifiable object forms data after it was updated',1,0),(298,'actionAfterUpdateCmsPageFormHandler','Modify cms page identifiable object data after updating it','This hook allows to modify cms page identifiable object forms data after it was updated',1,0),(299,'actionAfterUpdateManufacturerAddressFormHandler','Modify manufacturer address identifiable object data after updat','This hook allows to modify manufacturer address identifiable object forms data after it was updated',1,0),(300,'actionBeforeCreateSqlRequestFormHandler','Modify sql request identifiable object data before creating it','This hook allows to modify sql request identifiable object forms data before it was created',1,0),(301,'actionBeforeCreateCustomerFormHandler','Modify customer identifiable object data before creating it','This hook allows to modify customer identifiable object forms data before it was created',1,0),(302,'actionBeforeCreateLanguageFormHandler','Modify language identifiable object data before creating it','This hook allows to modify language identifiable object forms data before it was created',1,0),(303,'actionBeforeCreateCurrencyFormHandler','Modify currency identifiable object data before creating it','This hook allows to modify currency identifiable object forms data before it was created',1,0),(304,'actionBeforeCreateWebserviceKeyFormHandler','Modify webservice key identifiable object data before creating i','This hook allows to modify webservice key identifiable object forms data before it was created',1,0),(305,'actionBeforeCreateMetaFormHandler','Modify meta identifiable object data before creating it','This hook allows to modify meta identifiable object forms data before it was created',1,0),(306,'actionBeforeCreateCategoryFormHandler','Modify category identifiable object data before creating it','This hook allows to modify category identifiable object forms data before it was created',1,0),(307,'actionBeforeCreateRootCategoryFormHandler','Modify root category identifiable object data before creating it','This hook allows to modify root category identifiable object forms data before it was created',1,0),(308,'actionBeforeCreateContactFormHandler','Modify contact identifiable object data before creating it','This hook allows to modify contact identifiable object forms data before it was created',1,0),(309,'actionBeforeCreateCmsPageCategoryFormHandler','Modify cms page category identifiable object data before creatin','This hook allows to modify cms page category identifiable object forms data before it was created',1,0),(310,'actionBeforeCreateTaxFormHandler','Modify tax identifiable object data before creating it','This hook allows to modify tax identifiable object forms data before it was created',1,0),(311,'actionBeforeCreateManufacturerFormHandler','Modify manufacturer identifiable object data before creating it','This hook allows to modify manufacturer identifiable object forms data before it was created',1,0),(312,'actionBeforeCreateEmployeeFormHandler','Modify employee identifiable object data before creating it','This hook allows to modify employee identifiable object forms data before it was created',1,0),(313,'actionBeforeCreateProfileFormHandler','Modify profile identifiable object data before creating it','This hook allows to modify profile identifiable object forms data before it was created',1,0),(314,'actionBeforeCreateCmsPageFormHandler','Modify cms page identifiable object data before creating it','This hook allows to modify cms page identifiable object forms data before it was created',1,0),(315,'actionBeforeCreateManufacturerAddressFormHandler','Modify manufacturer address identifiable object data before crea','This hook allows to modify manufacturer address identifiable object forms data before it was created',1,0),(316,'actionAfterCreateSqlRequestFormHandler','Modify sql request identifiable object data after creating it','This hook allows to modify sql request identifiable object forms data after it was created',1,0),(317,'actionAfterCreateCustomerFormHandler','Modify customer identifiable object data after creating it','This hook allows to modify customer identifiable object forms data after it was created',1,0),(318,'actionAfterCreateLanguageFormHandler','Modify language identifiable object data after creating it','This hook allows to modify language identifiable object forms data after it was created',1,0),(319,'actionAfterCreateCurrencyFormHandler','Modify currency identifiable object data after creating it','This hook allows to modify currency identifiable object forms data after it was created',1,0),(320,'actionAfterCreateWebserviceKeyFormHandler','Modify webservice key identifiable object data after creating it','This hook allows to modify webservice key identifiable object forms data after it was created',1,0),(321,'actionAfterCreateMetaFormHandler','Modify meta identifiable object data after creating it','This hook allows to modify meta identifiable object forms data after it was created',1,0),(322,'actionAfterCreateCategoryFormHandler','Modify category identifiable object data after creating it','This hook allows to modify category identifiable object forms data after it was created',1,0),(323,'actionAfterCreateRootCategoryFormHandler','Modify root category identifiable object data after creating it','This hook allows to modify root category identifiable object forms data after it was created',1,0),(324,'actionAfterCreateContactFormHandler','Modify contact identifiable object data after creating it','This hook allows to modify contact identifiable object forms data after it was created',1,0),(325,'actionAfterCreateCmsPageCategoryFormHandler','Modify cms page category identifiable object data after creating','This hook allows to modify cms page category identifiable object forms data after it was created',1,0),(326,'actionAfterCreateTaxFormHandler','Modify tax identifiable object data after creating it','This hook allows to modify tax identifiable object forms data after it was created',1,0),(327,'actionAfterCreateManufacturerFormHandler','Modify manufacturer identifiable object data after creating it','This hook allows to modify manufacturer identifiable object forms data after it was created',1,0),(328,'actionAfterCreateEmployeeFormHandler','Modify employee identifiable object data after creating it','This hook allows to modify employee identifiable object forms data after it was created',1,0),(329,'actionAfterCreateProfileFormHandler','Modify profile identifiable object data after creating it','This hook allows to modify profile identifiable object forms data after it was created',1,0),(330,'actionAfterCreateCmsPageFormHandler','Modify cms page identifiable object data after creating it','This hook allows to modify cms page identifiable object forms data after it was created',1,0),(331,'actionAfterCreateManufacturerAddressFormHandler','Modify manufacturer address identifiable object data after creat','This hook allows to modify manufacturer address identifiable object forms data after it was created',1,0),(332,'actionShippingPreferencesPageForm','Modify shipping preferences page options form content','This hook allows to modify shipping preferences page options form FormBuilder',1,0),(333,'actionOrdersInvoicesByDateForm','Modify orders invoices by date options form content','This hook allows to modify orders invoices by date options form FormBuilder',1,0),(334,'actionOrdersInvoicesByStatusForm','Modify orders invoices by status options form content','This hook allows to modify orders invoices by status options form FormBuilder',1,0),(335,'actionOrdersInvoicesOptionsForm','Modify orders invoices options options form content','This hook allows to modify orders invoices options options form FormBuilder',1,0),(336,'actionCustomerPreferencesPageForm','Modify customer preferences page options form content','This hook allows to modify customer preferences page options form FormBuilder',1,0),(337,'actionOrderPreferencesPageForm','Modify order preferences page options form content','This hook allows to modify order preferences page options form FormBuilder',1,0),(338,'actionProductPreferencesPageForm','Modify product preferences page options form content','This hook allows to modify product preferences page options form FormBuilder',1,0),(339,'actionGeneralPageForm','Modify general page options form content','This hook allows to modify general page options form FormBuilder',1,0),(340,'actionLogsPageForm','Modify logs page options form content','This hook allows to modify logs page options form FormBuilder',1,0),(341,'actionOrderDeliverySlipOptionsForm','Modify order delivery slip options options form content','This hook allows to modify order delivery slip options options form FormBuilder',1,0),(342,'actionOrderDeliverySlipPdfForm','Modify order delivery slip pdf options form content','This hook allows to modify order delivery slip pdf options form FormBuilder',1,0),(343,'actionGeolocationPageForm','Modify geolocation page options form content','This hook allows to modify geolocation page options form FormBuilder',1,0),(344,'actionLocalizationPageForm','Modify localization page options form content','This hook allows to modify localization page options form FormBuilder',1,0),(345,'actionPaymentPreferencesForm','Modify payment preferences options form content','This hook allows to modify payment preferences options form FormBuilder',1,0),(346,'actionEmailConfigurationForm','Modify email configuration options form content','This hook allows to modify email configuration options form FormBuilder',1,0),(347,'actionRequestSqlForm','Modify request sql options form content','This hook allows to modify request sql options form FormBuilder',1,0),(348,'actionBackupForm','Modify backup options form content','This hook allows to modify backup options form FormBuilder',1,0),(349,'actionWebservicePageForm','Modify webservice page options form content','This hook allows to modify webservice page options form FormBuilder',1,0),(350,'actionMetaPageForm','Modify meta page options form content','This hook allows to modify meta page options form FormBuilder',1,0),(351,'actionEmployeeForm','Modify employee options form content','This hook allows to modify employee options form FormBuilder',1,0),(352,'actionCurrencyForm','Modify currency options form content','This hook allows to modify currency options form FormBuilder',1,0),(353,'actionShopLogoForm','Modify shop logo options form content','This hook allows to modify shop logo options form FormBuilder',1,0),(354,'actionTaxForm','Modify tax options form content','This hook allows to modify tax options form FormBuilder',1,0),(355,'actionMailThemeForm','Modify mail theme options form content','This hook allows to modify mail theme options form FormBuilder',1,0),(356,'actionPerformancePageSave','Modify performance page options form saved data','This hook allows to modify data of performance page options form after it was saved',1,0),(357,'actionMaintenancePageSave','Modify maintenance page options form saved data','This hook allows to modify data of maintenance page options form after it was saved',1,0),(358,'actionAdministrationPageSave','Modify administration page options form saved data','This hook allows to modify data of administration page options form after it was saved',1,0),(359,'actionShippingPreferencesPageSave','Modify shipping preferences page options form saved data','This hook allows to modify data of shipping preferences page options form after it was saved',1,0),(360,'actionOrdersInvoicesByDateSave','Modify orders invoices by date options form saved data','This hook allows to modify data of orders invoices by date options form after it was saved',1,0),(361,'actionOrdersInvoicesByStatusSave','Modify orders invoices by status options form saved data','This hook allows to modify data of orders invoices by status options form after it was saved',1,0),(362,'actionOrdersInvoicesOptionsSave','Modify orders invoices options options form saved data','This hook allows to modify data of orders invoices options options form after it was saved',1,0),(363,'actionCustomerPreferencesPageSave','Modify customer preferences page options form saved data','This hook allows to modify data of customer preferences page options form after it was saved',1,0),(364,'actionOrderPreferencesPageSave','Modify order preferences page options form saved data','This hook allows to modify data of order preferences page options form after it was saved',1,0),(365,'actionProductPreferencesPageSave','Modify product preferences page options form saved data','This hook allows to modify data of product preferences page options form after it was saved',1,0),(366,'actionGeneralPageSave','Modify general page options form saved data','This hook allows to modify data of general page options form after it was saved',1,0),(367,'actionLogsPageSave','Modify logs page options form saved data','This hook allows to modify data of logs page options form after it was saved',1,0),(368,'actionOrderDeliverySlipOptionsSave','Modify order delivery slip options options form saved data','This hook allows to modify data of order delivery slip options options form after it was saved',1,0),(369,'actionOrderDeliverySlipPdfSave','Modify order delivery slip pdf options form saved data','This hook allows to modify data of order delivery slip pdf options form after it was saved',1,0),(370,'actionGeolocationPageSave','Modify geolocation page options form saved data','This hook allows to modify data of geolocation page options form after it was saved',1,0),(371,'actionLocalizationPageSave','Modify localization page options form saved data','This hook allows to modify data of localization page options form after it was saved',1,0),(372,'actionPaymentPreferencesSave','Modify payment preferences options form saved data','This hook allows to modify data of payment preferences options form after it was saved',1,0),(373,'actionEmailConfigurationSave','Modify email configuration options form saved data','This hook allows to modify data of email configuration options form after it was saved',1,0),(374,'actionRequestSqlSave','Modify request sql options form saved data','This hook allows to modify data of request sql options form after it was saved',1,0),(375,'actionBackupSave','Modify backup options form saved data','This hook allows to modify data of backup options form after it was saved',1,0),(376,'actionWebservicePageSave','Modify webservice page options form saved data','This hook allows to modify data of webservice page options form after it was saved',1,0),(377,'actionMetaPageSave','Modify meta page options form saved data','This hook allows to modify data of meta page options form after it was saved',1,0),(378,'actionEmployeeSave','Modify employee options form saved data','This hook allows to modify data of employee options form after it was saved',1,0),(379,'actionCurrencySave','Modify currency options form saved data','This hook allows to modify data of currency options form after it was saved',1,0),(380,'actionShopLogoSave','Modify shop logo options form saved data','This hook allows to modify data of shop logo options form after it was saved',1,0),(381,'actionTaxSave','Modify tax options form saved data','This hook allows to modify data of tax options form after it was saved',1,0),(382,'actionMailThemeSave','Modify mail theme options form saved data','This hook allows to modify data of mail theme options form after it was saved',1,0),(383,'actionCategoryGridDefinitionModifier','Modify category grid definition','This hook allows to alter category grid columns, actions and filters',1,0),(384,'actionEmployeeGridDefinitionModifier','Modify employee grid definition','This hook allows to alter employee grid columns, actions and filters',1,0),(385,'actionContactGridDefinitionModifier','Modify contact grid definition','This hook allows to alter contact grid columns, actions and filters',1,0),(386,'actionCustomerGridDefinitionModifier','Modify customer grid definition','This hook allows to alter customer grid columns, actions and filters',1,0),(387,'actionLanguageGridDefinitionModifier','Modify language grid definition','This hook allows to alter language grid columns, actions and filters',1,0),(388,'actionCurrencyGridDefinitionModifier','Modify currency grid definition','This hook allows to alter currency grid columns, actions and filters',1,0),(389,'actionSupplierGridDefinitionModifier','Modify supplier grid definition','This hook allows to alter supplier grid columns, actions and filters',1,0),(390,'actionProfileGridDefinitionModifier','Modify profile grid definition','This hook allows to alter profile grid columns, actions and filters',1,0),(391,'actionCmsPageCategoryGridDefinitionModifier','Modify cms page category grid definition','This hook allows to alter cms page category grid columns, actions and filters',1,0),(392,'actionTaxGridDefinitionModifier','Modify tax grid definition','This hook allows to alter tax grid columns, actions and filters',1,0),(393,'actionManufacturerGridDefinitionModifier','Modify manufacturer grid definition','This hook allows to alter manufacturer grid columns, actions and filters',1,0),(394,'actionManufacturerAddressGridDefinitionModifier','Modify manufacturer address grid definition','This hook allows to alter manufacturer address grid columns, actions and filters',1,0),(395,'actionCmsPageGridDefinitionModifier','Modify cms page grid definition','This hook allows to alter cms page grid columns, actions and filters',1,0),(396,'actionBackupGridQueryBuilderModifier','Modify backup grid query builder','This hook allows to alter Doctrine query builder for backup grid',1,0),(397,'actionCategoryGridQueryBuilderModifier','Modify category grid query builder','This hook allows to alter Doctrine query builder for category grid',1,0),(398,'actionEmployeeGridQueryBuilderModifier','Modify employee grid query builder','This hook allows to alter Doctrine query builder for employee grid',1,0),(399,'actionContactGridQueryBuilderModifier','Modify contact grid query builder','This hook allows to alter Doctrine query builder for contact grid',1,0),(400,'actionCustomerGridQueryBuilderModifier','Modify customer grid query builder','This hook allows to alter Doctrine query builder for customer grid',1,0),(401,'actionLanguageGridQueryBuilderModifier','Modify language grid query builder','This hook allows to alter Doctrine query builder for language grid',1,0),(402,'actionCurrencyGridQueryBuilderModifier','Modify currency grid query builder','This hook allows to alter Doctrine query builder for currency grid',1,0),(403,'actionSupplierGridQueryBuilderModifier','Modify supplier grid query builder','This hook allows to alter Doctrine query builder for supplier grid',1,0),(404,'actionProfileGridQueryBuilderModifier','Modify profile grid query builder','This hook allows to alter Doctrine query builder for profile grid',1,0),(405,'actionCmsPageCategoryGridQueryBuilderModifier','Modify cms page category grid query builder','This hook allows to alter Doctrine query builder for cms page category grid',1,0),(406,'actionTaxGridQueryBuilderModifier','Modify tax grid query builder','This hook allows to alter Doctrine query builder for tax grid',1,0),(407,'actionManufacturerGridQueryBuilderModifier','Modify manufacturer grid query builder','This hook allows to alter Doctrine query builder for manufacturer grid',1,0),(408,'actionManufacturerAddressGridQueryBuilderModifier','Modify manufacturer address grid query builder','This hook allows to alter Doctrine query builder for manufacturer address grid',1,0),(409,'actionCmsPageGridQueryBuilderModifier','Modify cms page grid query builder','This hook allows to alter Doctrine query builder for cms page grid',1,0),(410,'actionLogsGridDataModifier','Modify logs grid data','This hook allows to modify logs grid data',1,0),(411,'actionEmailLogsGridDataModifier','Modify email logs grid data','This hook allows to modify email logs grid data',1,0),(412,'actionSqlRequestGridDataModifier','Modify sql request grid data','This hook allows to modify sql request grid data',1,0),(413,'actionBackupGridDataModifier','Modify backup grid data','This hook allows to modify backup grid data',1,0),(414,'actionWebserviceKeyGridDataModifier','Modify webservice key grid data','This hook allows to modify webservice key grid data',1,0),(415,'actionMetaGridDataModifier','Modify meta grid data','This hook allows to modify meta grid data',1,0),(416,'actionCategoryGridDataModifier','Modify category grid data','This hook allows to modify category grid data',1,0),(417,'actionEmployeeGridDataModifier','Modify employee grid data','This hook allows to modify employee grid data',1,0),(418,'actionContactGridDataModifier','Modify contact grid data','This hook allows to modify contact grid data',1,0),(419,'actionCustomerGridDataModifier','Modify customer grid data','This hook allows to modify customer grid data',1,0),(420,'actionLanguageGridDataModifier','Modify language grid data','This hook allows to modify language grid data',1,0),(421,'actionCurrencyGridDataModifier','Modify currency grid data','This hook allows to modify currency grid data',1,0),(422,'actionSupplierGridDataModifier','Modify supplier grid data','This hook allows to modify supplier grid data',1,0),(423,'actionProfileGridDataModifier','Modify profile grid data','This hook allows to modify profile grid data',1,0),(424,'actionCmsPageCategoryGridDataModifier','Modify cms page category grid data','This hook allows to modify cms page category grid data',1,0),(425,'actionTaxGridDataModifier','Modify tax grid data','This hook allows to modify tax grid data',1,0),(426,'actionManufacturerGridDataModifier','Modify manufacturer grid data','This hook allows to modify manufacturer grid data',1,0),(427,'actionManufacturerAddressGridDataModifier','Modify manufacturer address grid data','This hook allows to modify manufacturer address grid data',1,0),(428,'actionCmsPageGridDataModifier','Modify cms page grid data','This hook allows to modify cms page grid data',1,0),(429,'actionCategoryGridFilterFormModifier','Modify category grid filters','This hook allows to modify filters for category grid',1,0),(430,'actionEmployeeGridFilterFormModifier','Modify employee grid filters','This hook allows to modify filters for employee grid',1,0),(431,'actionContactGridFilterFormModifier','Modify contact grid filters','This hook allows to modify filters for contact grid',1,0),(432,'actionCustomerGridFilterFormModifier','Modify customer grid filters','This hook allows to modify filters for customer grid',1,0),(433,'actionLanguageGridFilterFormModifier','Modify language grid filters','This hook allows to modify filters for language grid',1,0),(434,'actionCurrencyGridFilterFormModifier','Modify currency grid filters','This hook allows to modify filters for currency grid',1,0),(435,'actionSupplierGridFilterFormModifier','Modify supplier grid filters','This hook allows to modify filters for supplier grid',1,0),(436,'actionProfileGridFilterFormModifier','Modify profile grid filters','This hook allows to modify filters for profile grid',1,0),(437,'actionCmsPageCategoryGridFilterFormModifier','Modify cms page category grid filters','This hook allows to modify filters for cms page category grid',1,0),(438,'actionTaxGridFilterFormModifier','Modify tax grid filters','This hook allows to modify filters for tax grid',1,0),(439,'actionManufacturerGridFilterFormModifier','Modify manufacturer grid filters','This hook allows to modify filters for manufacturer grid',1,0),(440,'actionManufacturerAddressGridFilterFormModifier','Modify manufacturer address grid filters','This hook allows to modify filters for manufacturer address grid',1,0),(441,'actionCmsPageGridFilterFormModifier','Modify cms page grid filters','This hook allows to modify filters for cms page grid',1,0),(442,'actionCategoryGridPresenterModifier','Modify category grid template data','This hook allows to modify data which is about to be used in template for category grid',1,0),(443,'actionEmployeeGridPresenterModifier','Modify employee grid template data','This hook allows to modify data which is about to be used in template for employee grid',1,0),(444,'actionContactGridPresenterModifier','Modify contact grid template data','This hook allows to modify data which is about to be used in template for contact grid',1,0),(445,'actionCustomerGridPresenterModifier','Modify customer grid template data','This hook allows to modify data which is about to be used in template for customer grid',1,0),(446,'actionLanguageGridPresenterModifier','Modify language grid template data','This hook allows to modify data which is about to be used in template for language grid',1,0),(447,'actionCurrencyGridPresenterModifier','Modify currency grid template data','This hook allows to modify data which is about to be used in template for currency grid',1,0),(448,'actionSupplierGridPresenterModifier','Modify supplier grid template data','This hook allows to modify data which is about to be used in template for supplier grid',1,0),(449,'actionProfileGridPresenterModifier','Modify profile grid template data','This hook allows to modify data which is about to be used in template for profile grid',1,0),(450,'actionCmsPageCategoryGridPresenterModifier','Modify cms page category grid template data','This hook allows to modify data which is about to be used in template for cms page category grid',1,0),(451,'actionTaxGridPresenterModifier','Modify tax grid template data','This hook allows to modify data which is about to be used in template for tax grid',1,0),(452,'actionManufacturerGridPresenterModifier','Modify manufacturer grid template data','This hook allows to modify data which is about to be used in template for manufacturer grid',1,0),(453,'actionManufacturerAddressGridPresenterModifier','Modify manufacturer address grid template data','This hook allows to modify data which is about to be used in template for manufacturer address grid',1,0),(454,'actionCmsPageGridPresenterModifier','Modify cms page grid template data','This hook allows to modify data which is about to be used in template for cms page grid',1,0),(455,'displayAdminCartsView','displayAdminCartsView','',1,0);
/*!40000 ALTER TABLE `ps_hook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_hook_alias`
--

DROP TABLE IF EXISTS `ps_hook_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_hook_alias` (
  `id_hook_alias` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alias` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id_hook_alias`),
  UNIQUE KEY `alias` (`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_hook_alias`
--

LOCK TABLES `ps_hook_alias` WRITE;
/*!40000 ALTER TABLE `ps_hook_alias` DISABLE KEYS */;
INSERT INTO `ps_hook_alias` VALUES (1,'newOrder','actionValidateOrder'),(2,'paymentConfirm','actionPaymentConfirmation'),(3,'paymentReturn','displayPaymentReturn'),(4,'updateQuantity','actionUpdateQuantity'),(5,'rightColumn','displayRightColumn'),(6,'leftColumn','displayLeftColumn'),(7,'home','displayHome'),(8,'displayHeader','Header'),(9,'cart','actionCartSave'),(10,'authentication','actionAuthentication'),(11,'addproduct','actionProductAdd'),(12,'updateproduct','actionProductUpdate'),(13,'top','displayTop'),(14,'extraRight','displayRightColumnProduct'),(15,'deleteproduct','actionProductDelete'),(16,'productfooter','displayFooterProduct'),(17,'invoice','displayInvoice'),(18,'updateOrderStatus','actionOrderStatusUpdate'),(19,'adminOrder','displayAdminOrder'),(20,'footer','displayFooter'),(21,'PDFInvoice','displayPDFInvoice'),(22,'adminCustomers','displayAdminCustomers'),(23,'orderConfirmation','displayOrderConfirmation'),(24,'createAccount','actionCustomerAccountAdd'),(25,'customerAccount','displayCustomerAccount'),(26,'orderSlip','actionOrderSlipAdd'),(27,'shoppingCart','displayShoppingCartFooter'),(28,'createAccountForm','displayCustomerAccountForm'),(29,'AdminStatsModules','displayAdminStatsModules'),(30,'GraphEngine','displayAdminStatsGraphEngine'),(31,'orderReturn','actionOrderReturn'),(32,'productActions','displayProductAdditionalInfo'),(33,'displayProductButtons','displayProductAdditionalInfo'),(34,'backOfficeHome','displayBackOfficeHome'),(35,'GridEngine','displayAdminStatsGridEngine'),(36,'watermark','actionWatermark'),(37,'cancelProduct','actionProductCancel'),(38,'extraLeft','displayLeftColumnProduct'),(39,'productOutOfStock','actionProductOutOfStock'),(40,'updateProductAttribute','actionProductAttributeUpdate'),(41,'extraCarrier','displayCarrierList'),(42,'shoppingCartExtra','displayShoppingCart'),(43,'updateCarrier','actionCarrierUpdate'),(44,'postUpdateOrderStatus','actionOrderStatusPostUpdate'),(45,'createAccountTop','displayCustomerAccountFormTop'),(46,'backOfficeHeader','displayBackOfficeHeader'),(47,'backOfficeTop','displayBackOfficeTop'),(48,'backOfficeFooter','displayBackOfficeFooter'),(49,'deleteProductAttribute','actionProductAttributeDelete'),(50,'processCarrier','actionCarrierProcess'),(51,'beforeCarrier','displayBeforeCarrier'),(52,'orderDetailDisplayed','displayOrderDetail'),(53,'paymentCCAdded','actionPaymentCCAdd'),(54,'categoryAddition','actionCategoryAdd'),(55,'categoryUpdate','actionCategoryUpdate'),(56,'categoryDeletion','actionCategoryDelete'),(57,'paymentTop','displayPaymentTop'),(58,'afterCreateHtaccess','actionHtaccessCreate'),(59,'afterSaveAdminMeta','actionAdminMetaSave'),(60,'attributeGroupForm','displayAttributeGroupForm'),(61,'afterSaveAttributeGroup','actionAttributeGroupSave'),(62,'afterDeleteAttributeGroup','actionAttributeGroupDelete'),(63,'featureForm','displayFeatureForm'),(64,'afterSaveFeature','actionFeatureSave'),(65,'afterDeleteFeature','actionFeatureDelete'),(66,'afterSaveProduct','actionProductSave'),(67,'postProcessAttributeGroup','displayAttributeGroupPostProcess'),(68,'postProcessFeature','displayFeaturePostProcess'),(69,'featureValueForm','displayFeatureValueForm'),(70,'postProcessFeatureValue','displayFeatureValuePostProcess'),(71,'afterDeleteFeatureValue','actionFeatureValueDelete'),(72,'afterSaveFeatureValue','actionFeatureValueSave'),(73,'attributeForm','displayAttributeForm'),(74,'postProcessAttribute','actionAttributePostProcess'),(75,'afterDeleteAttribute','actionAttributeDelete'),(76,'afterSaveAttribute','actionAttributeSave'),(77,'taxManager','actionTaxManager'),(78,'myAccountBlock','displayMyAccountBlock'),(79,'actionBeforeCartUpdateQty','actionCartUpdateQuantityBefore'),(80,'actionBeforeAjaxDie','actionAjaxDieBefore'),(81,'actionBeforeAuthentication','actionAuthenticationBefore'),(82,'actionBeforeSubmitAccount','actionSubmitAccountBefore'),(83,'actionAfterDeleteProductInCart','actionDeleteProductInCartAfter');
/*!40000 ALTER TABLE `ps_hook_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_hook_module`
--

DROP TABLE IF EXISTS `ps_hook_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_hook_module` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_hook` int(10) unsigned NOT NULL,
  `position` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id_module`,`id_hook`,`id_shop`),
  KEY `id_hook` (`id_hook`),
  KEY `id_module` (`id_module`),
  KEY `position` (`id_shop`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_hook_module`
--

LOCK TABLES `ps_hook_module` WRITE;
/*!40000 ALTER TABLE `ps_hook_module` DISABLE KEYS */;
INSERT INTO `ps_hook_module` VALUES (1,1,160,1),(2,1,161,1),(2,1,162,1),(2,1,163,1),(2,1,164,1),(2,1,165,1),(2,1,166,1),(2,1,167,1),(2,1,168,1),(3,1,63,1),(3,1,169,1),(5,1,170,1),(6,1,50,1),(7,1,54,1),(8,1,171,1),(9,1,12,1),(9,1,57,1),(11,1,174,1),(11,1,246,1),(12,1,175,1),(15,1,178,1),(16,1,41,1),(16,1,114,1),(16,1,181,1),(16,1,182,1),(17,1,75,1),(17,1,76,1),(17,1,77,1),(17,1,81,1),(17,1,82,1),(17,1,83,1),(17,1,84,1),(17,1,85,1),(17,1,86,1),(17,1,87,1),(17,1,88,1),(17,1,89,1),(17,1,90,1),(17,1,91,1),(17,1,92,1),(17,1,93,1),(17,1,94,1),(17,1,95,1),(17,1,96,1),(17,1,97,1),(17,1,183,1),(18,1,13,1),(18,1,17,1),(18,1,18,1),(18,1,24,1),(18,1,186,1),(19,1,14,1),(21,1,35,1),(21,1,132,1),(22,1,187,1),(22,1,188,1),(22,1,189,1),(22,1,190,1),(22,1,191,1),(22,1,192,1),(22,1,193,1),(22,1,194,1),(22,1,195,1),(22,1,196,1),(22,1,197,1),(22,1,198,1),(22,1,199,1),(22,1,200,1),(22,1,201,1),(23,1,202,1),(23,1,205,1),(24,1,52,1),(28,1,5,1),(28,1,73,1),(32,1,49,1),(39,1,16,1),(39,1,20,1),(57,1,179,1),(58,1,222,1),(58,1,223,1),(58,1,224,1),(61,1,27,1),(68,1,1,1),(68,1,6,1),(68,1,43,1),(68,1,51,1),(68,1,58,1),(68,1,59,1),(68,1,69,1),(68,1,99,1),(68,1,108,1),(68,1,225,1),(69,1,15,1),(69,1,30,1),(69,1,40,1),(69,1,56,1),(69,1,65,1),(69,1,70,1),(73,1,7,1),(78,1,78,1),(78,1,236,1),(78,1,237,1),(79,1,173,1),(82,1,116,1),(82,1,239,1),(82,1,245,1),(95,1,241,1),(96,1,238,1),(98,1,29,1),(98,1,37,1),(98,1,44,1),(98,1,45,1),(98,1,206,1),(98,1,243,1),(98,1,244,1),(98,1,455,1),(102,1,62,1),(104,1,229,1),(105,1,31,1),(105,1,33,1),(105,1,172,1),(106,1,121,1),(107,1,73,1),(109,1,169,1),(110,1,73,1),(3,1,162,2),(3,1,168,2),(4,1,169,2),(5,1,163,2),(8,1,13,2),(16,1,160,2),(16,1,179,2),(17,1,12,2),(18,1,76,2),(19,1,178,2),(19,1,238,2),(20,1,205,2),(21,1,45,2),(22,1,173,2),(23,1,14,2),(28,1,172,2),(33,1,49,2),(39,1,41,2),(57,1,17,2),(57,1,18,2),(57,1,24,2),(57,1,63,2),(68,1,181,2),(68,1,182,2),(69,1,27,2),(71,1,52,2),(71,1,199,2),(71,1,200,2),(72,1,196,2),(72,1,197,2),(72,1,198,2),(73,1,193,2),(73,1,194,2),(73,1,195,2),(78,1,40,2),(80,1,176,2),(80,1,177,2),(81,1,132,2),(95,1,1,2),(98,1,5,2),(98,1,30,2),(98,1,43,2),(98,1,65,2),(98,1,99,2),(100,1,20,2),(100,1,29,2),(100,1,31,2),(100,1,33,2),(102,1,188,2),(102,1,189,2),(105,1,73,2),(106,1,70,2),(109,1,121,2),(4,1,162,3),(4,1,168,3),(5,1,169,3),(12,1,205,3),(15,1,13,3),(22,1,76,3),(22,1,178,3),(25,1,14,3),(26,1,179,3),(41,1,49,3),(58,1,17,3),(58,1,18,3),(58,1,24,3),(61,1,63,3),(68,1,160,3),(95,1,63,3),(98,1,27,3),(98,1,31,3),(98,1,33,3),(98,1,40,3),(98,1,172,3),(100,1,65,3),(105,1,5,3),(106,1,73,3),(107,1,70,3),(110,1,121,3),(5,1,162,4),(6,1,168,4),(14,1,205,4),(42,1,49,4),(62,1,17,4),(62,1,18,4),(62,1,24,4),(68,1,14,4),(98,1,63,4),(100,1,40,4),(101,1,13,4),(102,1,178,4),(103,1,27,4),(106,1,31,4),(106,1,33,4),(108,1,172,4),(109,1,70,4),(109,1,73,4),(111,1,121,4),(21,1,13,5),(25,1,205,5),(43,1,49,5),(68,1,24,5),(69,1,14,5),(98,1,168,5),(103,1,17,5),(103,1,18,5),(106,1,40,5),(108,1,31,5),(108,1,33,5),(110,1,70,5),(111,1,73,5),(112,1,121,5),(48,1,49,6),(103,1,24,6),(107,1,31,6),(107,1,33,6),(107,1,40,6),(111,1,70,6),(112,1,73,6),(113,1,121,6),(51,1,49,7),(78,1,14,7),(109,1,31,7),(109,1,33,7),(109,1,40,7),(112,1,70,7),(113,1,73,7),(114,1,121,7),(82,1,14,8),(110,1,31,8),(110,1,33,8),(110,1,40,8),(113,1,70,8),(114,1,73,8),(98,1,14,9),(111,1,31,9),(111,1,33,9),(111,1,40,9),(114,1,70,9),(28,1,31,10),(28,1,33,10),(100,1,14,10),(112,1,40,10),(101,1,14,11),(112,1,31,11),(112,1,33,11),(113,1,40,11),(112,1,14,12),(113,1,31,12),(113,1,33,12),(114,1,40,12),(114,1,31,13),(114,1,33,13),(1,2,160,1),(2,2,161,1),(2,2,162,1),(2,2,163,1),(2,2,164,1),(2,2,165,1),(2,2,166,1),(2,2,167,1),(2,2,168,1),(3,2,63,1),(3,2,169,1),(5,2,170,1),(6,2,50,1),(7,2,54,1),(8,2,171,1),(9,2,12,1),(9,2,57,1),(11,2,174,1),(11,2,246,1),(12,2,175,1),(15,2,178,1),(16,2,41,1),(16,2,114,1),(16,2,179,1),(16,2,181,1),(16,2,182,1),(17,2,75,1),(17,2,76,1),(17,2,77,1),(17,2,81,1),(17,2,82,1),(17,2,83,1),(17,2,84,1),(17,2,85,1),(17,2,86,1),(17,2,87,1),(17,2,88,1),(17,2,89,1),(17,2,90,1),(17,2,91,1),(17,2,92,1),(17,2,93,1),(17,2,94,1),(17,2,95,1),(17,2,96,1),(17,2,97,1),(17,2,183,1),(18,2,13,1),(18,2,17,1),(18,2,18,1),(18,2,24,1),(18,2,186,1),(19,2,14,1),(21,2,35,1),(21,2,132,1),(22,2,187,1),(22,2,188,1),(22,2,189,1),(22,2,190,1),(22,2,191,1),(22,2,192,1),(22,2,193,1),(22,2,194,1),(22,2,195,1),(22,2,196,1),(22,2,197,1),(22,2,198,1),(22,2,199,1),(22,2,200,1),(22,2,201,1),(23,2,202,1),(23,2,205,1),(24,2,52,1),(28,2,5,1),(28,2,73,1),(39,2,16,1),(39,2,20,1),(57,2,13,1),(58,2,13,1),(58,2,222,1),(58,2,223,1),(58,2,224,1),(61,2,27,1),(62,2,13,1),(68,2,1,1),(68,2,6,1),(68,2,43,1),(68,2,51,1),(68,2,58,1),(68,2,59,1),(68,2,69,1),(68,2,99,1),(68,2,108,1),(68,2,225,1),(69,2,15,1),(69,2,30,1),(69,2,40,1),(69,2,56,1),(69,2,65,1),(69,2,70,1),(72,2,7,1),(78,2,78,1),(78,2,236,1),(78,2,237,1),(79,2,173,1),(82,2,116,1),(82,2,239,1),(82,2,245,1),(95,2,241,1),(96,2,238,1),(98,2,29,1),(98,2,37,1),(98,2,44,1),(98,2,45,1),(98,2,206,1),(98,2,243,1),(98,2,244,1),(98,2,455,1),(102,2,62,1),(105,2,31,1),(105,2,33,1),(105,2,172,1),(106,2,121,1),(107,2,73,1),(109,2,169,1),(110,2,73,1),(3,2,162,2),(3,2,168,2),(4,2,169,2),(5,2,163,2),(8,2,13,2),(16,2,160,2),(17,2,12,2),(18,2,76,2),(19,2,178,2),(19,2,238,2),(20,2,205,2),(21,2,45,2),(22,2,173,2),(23,2,14,2),(26,2,179,2),(28,2,172,2),(32,2,49,2),(39,2,41,2),(57,2,17,2),(57,2,18,2),(57,2,24,2),(57,2,63,2),(68,2,181,2),(68,2,182,2),(69,2,27,2),(71,2,52,2),(71,2,199,2),(71,2,200,2),(72,2,196,2),(72,2,197,2),(72,2,198,2),(73,2,7,2),(73,2,193,2),(73,2,194,2),(73,2,195,2),(78,2,40,2),(80,2,176,2),(80,2,177,2),(81,2,132,2),(95,2,1,2),(98,2,5,2),(98,2,30,2),(98,2,43,2),(98,2,65,2),(98,2,99,2),(100,2,20,2),(100,2,29,2),(100,2,31,2),(100,2,33,2),(102,2,188,2),(102,2,189,2),(105,2,73,2),(106,2,70,2),(109,2,121,2),(4,2,162,3),(4,2,168,3),(5,2,169,3),(12,2,205,3),(15,2,13,3),(22,2,76,3),(22,2,178,3),(25,2,14,3),(33,2,49,3),(58,2,17,3),(58,2,18,3),(58,2,24,3),(61,2,63,3),(68,2,160,3),(71,2,27,3),(95,2,63,3),(98,2,31,3),(98,2,33,3),(98,2,40,3),(98,2,172,3),(100,2,65,3),(105,2,5,3),(106,2,73,3),(107,2,70,3),(110,2,121,3),(5,2,162,4),(6,2,168,4),(14,2,205,4),(62,2,17,4),(62,2,18,4),(62,2,24,4),(68,2,14,4),(94,2,13,4),(98,2,27,4),(98,2,63,4),(100,2,40,4),(102,2,178,4),(106,2,31,4),(106,2,33,4),(108,2,172,4),(109,2,70,4),(109,2,73,4),(111,2,121,4),(25,2,205,5),(68,2,24,5),(69,2,14,5),(98,2,168,5),(101,2,13,5),(103,2,17,5),(103,2,18,5),(103,2,27,5),(106,2,40,5),(108,2,31,5),(108,2,33,5),(110,2,70,5),(111,2,73,5),(112,2,121,5),(21,2,13,6),(41,2,49,6),(103,2,24,6),(107,2,31,6),(107,2,33,6),(107,2,40,6),(111,2,70,6),(112,2,73,6),(113,2,121,6),(42,2,49,7),(78,2,14,7),(109,2,31,7),(109,2,33,7),(109,2,40,7),(112,2,70,7),(113,2,73,7),(114,2,121,7),(43,2,49,8),(82,2,14,8),(110,2,31,8),(110,2,33,8),(110,2,40,8),(113,2,70,8),(114,2,73,8),(48,2,49,9),(98,2,14,9),(111,2,31,9),(111,2,33,9),(111,2,40,9),(114,2,70,9),(28,2,31,10),(28,2,33,10),(100,2,14,10),(112,2,40,10),(51,2,49,11),(101,2,14,11),(112,2,31,11),(112,2,33,11),(113,2,40,11),(112,2,14,12),(113,2,31,12),(113,2,33,12),(114,2,40,12),(114,2,31,13),(114,2,33,13),(1,3,160,1),(2,3,161,1),(2,3,162,1),(2,3,163,1),(2,3,164,1),(2,3,165,1),(2,3,166,1),(2,3,167,1),(2,3,168,1),(3,3,63,1),(3,3,169,1),(5,3,170,1),(6,3,50,1),(7,3,54,1),(8,3,171,1),(9,3,12,1),(9,3,57,1),(11,3,174,1),(11,3,246,1),(12,3,175,1),(15,3,178,1),(16,3,41,1),(16,3,114,1),(16,3,179,1),(16,3,181,1),(16,3,182,1),(17,3,75,1),(17,3,76,1),(17,3,77,1),(17,3,81,1),(17,3,82,1),(17,3,83,1),(17,3,84,1),(17,3,85,1),(17,3,86,1),(17,3,87,1),(17,3,88,1),(17,3,89,1),(17,3,90,1),(17,3,91,1),(17,3,92,1),(17,3,93,1),(17,3,94,1),(17,3,95,1),(17,3,96,1),(17,3,97,1),(17,3,183,1),(18,3,13,1),(18,3,17,1),(18,3,18,1),(18,3,24,1),(18,3,186,1),(19,3,14,1),(21,3,35,1),(21,3,132,1),(22,3,187,1),(22,3,188,1),(22,3,189,1),(22,3,190,1),(22,3,191,1),(22,3,192,1),(22,3,193,1),(22,3,194,1),(22,3,195,1),(22,3,196,1),(22,3,197,1),(22,3,198,1),(22,3,199,1),(22,3,200,1),(22,3,201,1),(23,3,202,1),(23,3,205,1),(24,3,52,1),(28,3,5,1),(28,3,73,1),(39,3,16,1),(39,3,20,1),(57,3,13,1),(58,3,13,1),(58,3,222,1),(58,3,223,1),(58,3,224,1),(61,3,27,1),(62,3,13,1),(68,3,1,1),(68,3,6,1),(68,3,43,1),(68,3,51,1),(68,3,58,1),(68,3,59,1),(68,3,69,1),(68,3,99,1),(68,3,108,1),(68,3,225,1),(69,3,15,1),(69,3,30,1),(69,3,40,1),(69,3,56,1),(69,3,65,1),(69,3,70,1),(72,3,7,1),(78,3,78,1),(78,3,236,1),(78,3,237,1),(79,3,173,1),(82,3,116,1),(82,3,239,1),(82,3,245,1),(95,3,241,1),(96,3,238,1),(98,3,29,1),(98,3,37,1),(98,3,44,1),(98,3,45,1),(98,3,206,1),(98,3,243,1),(98,3,244,1),(98,3,455,1),(102,3,62,1),(105,3,31,1),(105,3,33,1),(105,3,172,1),(106,3,121,1),(107,3,73,1),(109,3,169,1),(110,3,73,1),(3,3,162,2),(3,3,168,2),(4,3,169,2),(5,3,163,2),(8,3,13,2),(16,3,160,2),(17,3,12,2),(18,3,76,2),(19,3,178,2),(19,3,238,2),(20,3,205,2),(21,3,45,2),(22,3,173,2),(23,3,14,2),(26,3,179,2),(28,3,172,2),(32,3,49,2),(39,3,41,2),(57,3,17,2),(57,3,18,2),(57,3,24,2),(57,3,63,2),(68,3,181,2),(68,3,182,2),(69,3,27,2),(71,3,52,2),(71,3,199,2),(71,3,200,2),(72,3,196,2),(72,3,197,2),(72,3,198,2),(73,3,7,2),(73,3,193,2),(73,3,194,2),(73,3,195,2),(78,3,40,2),(80,3,176,2),(80,3,177,2),(81,3,132,2),(95,3,1,2),(98,3,5,2),(98,3,30,2),(98,3,43,2),(98,3,65,2),(98,3,99,2),(100,3,20,2),(100,3,29,2),(100,3,31,2),(100,3,33,2),(102,3,188,2),(102,3,189,2),(105,3,73,2),(106,3,70,2),(109,3,121,2),(4,3,162,3),(4,3,168,3),(5,3,169,3),(12,3,205,3),(15,3,13,3),(22,3,76,3),(22,3,178,3),(25,3,14,3),(33,3,49,3),(58,3,17,3),(58,3,18,3),(58,3,24,3),(61,3,63,3),(68,3,160,3),(71,3,27,3),(95,3,63,3),(98,3,31,3),(98,3,33,3),(98,3,40,3),(98,3,172,3),(100,3,65,3),(105,3,5,3),(106,3,73,3),(107,3,70,3),(110,3,121,3),(5,3,162,4),(6,3,168,4),(14,3,205,4),(62,3,17,4),(62,3,18,4),(62,3,24,4),(68,3,14,4),(94,3,13,4),(98,3,27,4),(98,3,63,4),(100,3,40,4),(102,3,178,4),(106,3,31,4),(106,3,33,4),(108,3,172,4),(109,3,70,4),(109,3,73,4),(111,3,121,4),(25,3,205,5),(68,3,24,5),(69,3,14,5),(98,3,168,5),(101,3,13,5),(103,3,17,5),(103,3,18,5),(103,3,27,5),(106,3,40,5),(108,3,31,5),(108,3,33,5),(110,3,70,5),(111,3,73,5),(112,3,121,5),(21,3,13,6),(41,3,49,6),(103,3,24,6),(107,3,31,6),(107,3,33,6),(107,3,40,6),(111,3,70,6),(112,3,73,6),(113,3,121,6),(42,3,49,7),(78,3,14,7),(109,3,31,7),(109,3,33,7),(109,3,40,7),(112,3,70,7),(113,3,73,7),(114,3,121,7),(43,3,49,8),(82,3,14,8),(110,3,31,8),(110,3,33,8),(110,3,40,8),(113,3,70,8),(114,3,73,8),(48,3,49,9),(98,3,14,9),(111,3,31,9),(111,3,33,9),(111,3,40,9),(114,3,70,9),(28,3,31,10),(28,3,33,10),(100,3,14,10),(112,3,40,10),(51,3,49,11),(101,3,14,11),(112,3,31,11),(112,3,33,11),(113,3,40,11),(112,3,14,12),(113,3,31,12),(113,3,33,12),(114,3,40,12),(114,3,31,13),(114,3,33,13),(1,4,160,1),(2,4,161,1),(2,4,162,1),(2,4,163,1),(2,4,164,1),(2,4,165,1),(2,4,166,1),(2,4,167,1),(2,4,168,1),(3,4,63,1),(3,4,169,1),(5,4,170,1),(6,4,50,1),(7,4,54,1),(8,4,171,1),(9,4,12,1),(9,4,57,1),(11,4,174,1),(11,4,246,1),(12,4,175,1),(15,4,178,1),(16,4,41,1),(16,4,114,1),(16,4,179,1),(16,4,181,1),(16,4,182,1),(17,4,75,1),(17,4,76,1),(17,4,77,1),(17,4,81,1),(17,4,82,1),(17,4,83,1),(17,4,84,1),(17,4,85,1),(17,4,86,1),(17,4,87,1),(17,4,88,1),(17,4,89,1),(17,4,90,1),(17,4,91,1),(17,4,92,1),(17,4,93,1),(17,4,94,1),(17,4,95,1),(17,4,96,1),(17,4,97,1),(17,4,183,1),(18,4,13,1),(18,4,17,1),(18,4,18,1),(18,4,24,1),(18,4,186,1),(19,4,14,1),(21,4,35,1),(21,4,132,1),(22,4,187,1),(22,4,188,1),(22,4,189,1),(22,4,190,1),(22,4,191,1),(22,4,192,1),(22,4,193,1),(22,4,194,1),(22,4,195,1),(22,4,196,1),(22,4,197,1),(22,4,198,1),(22,4,199,1),(22,4,200,1),(22,4,201,1),(23,4,202,1),(23,4,205,1),(24,4,52,1),(28,4,5,1),(28,4,73,1),(39,4,16,1),(39,4,20,1),(57,4,13,1),(58,4,13,1),(58,4,222,1),(58,4,223,1),(58,4,224,1),(61,4,27,1),(62,4,13,1),(68,4,1,1),(68,4,6,1),(68,4,43,1),(68,4,51,1),(68,4,58,1),(68,4,59,1),(68,4,69,1),(68,4,99,1),(68,4,108,1),(68,4,225,1),(69,4,15,1),(69,4,30,1),(69,4,40,1),(69,4,56,1),(69,4,65,1),(69,4,70,1),(72,4,7,1),(78,4,78,1),(78,4,236,1),(78,4,237,1),(79,4,173,1),(82,4,116,1),(82,4,239,1),(82,4,245,1),(95,4,241,1),(96,4,238,1),(98,4,29,1),(98,4,37,1),(98,4,44,1),(98,4,45,1),(98,4,206,1),(98,4,243,1),(98,4,244,1),(98,4,455,1),(102,4,62,1),(105,4,31,1),(105,4,33,1),(105,4,172,1),(106,4,121,1),(107,4,73,1),(109,4,169,1),(110,4,73,1),(3,4,162,2),(3,4,168,2),(4,4,169,2),(5,4,163,2),(8,4,13,2),(16,4,160,2),(17,4,12,2),(18,4,76,2),(19,4,178,2),(19,4,238,2),(20,4,205,2),(21,4,45,2),(22,4,173,2),(23,4,14,2),(26,4,179,2),(28,4,172,2),(32,4,49,2),(39,4,41,2),(57,4,17,2),(57,4,18,2),(57,4,24,2),(57,4,63,2),(68,4,181,2),(68,4,182,2),(69,4,27,2),(71,4,52,2),(71,4,199,2),(71,4,200,2),(72,4,196,2),(72,4,197,2),(72,4,198,2),(73,4,7,2),(73,4,193,2),(73,4,194,2),(73,4,195,2),(78,4,40,2),(80,4,176,2),(80,4,177,2),(81,4,132,2),(95,4,1,2),(98,4,5,2),(98,4,30,2),(98,4,43,2),(98,4,65,2),(98,4,99,2),(100,4,20,2),(100,4,29,2),(100,4,31,2),(100,4,33,2),(102,4,188,2),(102,4,189,2),(105,4,73,2),(106,4,70,2),(109,4,121,2),(4,4,162,3),(4,4,168,3),(5,4,169,3),(12,4,205,3),(15,4,13,3),(22,4,76,3),(22,4,178,3),(25,4,14,3),(33,4,49,3),(58,4,17,3),(58,4,18,3),(58,4,24,3),(61,4,63,3),(68,4,160,3),(71,4,27,3),(95,4,63,3),(98,4,31,3),(98,4,33,3),(98,4,40,3),(98,4,172,3),(100,4,65,3),(105,4,5,3),(106,4,73,3),(107,4,70,3),(110,4,121,3),(5,4,162,4),(6,4,168,4),(14,4,205,4),(62,4,17,4),(62,4,18,4),(62,4,24,4),(68,4,14,4),(94,4,13,4),(98,4,27,4),(98,4,63,4),(100,4,40,4),(102,4,178,4),(106,4,31,4),(106,4,33,4),(108,4,172,4),(109,4,70,4),(109,4,73,4),(111,4,121,4),(25,4,205,5),(68,4,24,5),(69,4,14,5),(98,4,168,5),(101,4,13,5),(103,4,17,5),(103,4,18,5),(103,4,27,5),(106,4,40,5),(108,4,31,5),(108,4,33,5),(110,4,70,5),(111,4,73,5),(112,4,121,5),(21,4,13,6),(41,4,49,6),(103,4,24,6),(107,4,31,6),(107,4,33,6),(107,4,40,6),(111,4,70,6),(112,4,73,6),(113,4,121,6),(42,4,49,7),(78,4,14,7),(109,4,31,7),(109,4,33,7),(109,4,40,7),(112,4,70,7),(113,4,73,7),(114,4,121,7),(43,4,49,8),(82,4,14,8),(110,4,31,8),(110,4,33,8),(110,4,40,8),(113,4,70,8),(114,4,73,8),(48,4,49,9),(98,4,14,9),(111,4,31,9),(111,4,33,9),(111,4,40,9),(114,4,70,9),(28,4,31,10),(28,4,33,10),(100,4,14,10),(112,4,40,10),(51,4,49,11),(101,4,14,11),(112,4,31,11),(112,4,33,11),(113,4,40,11),(112,4,14,12),(113,4,31,12),(113,4,33,12),(114,4,40,12),(114,4,31,13),(114,4,33,13);
/*!40000 ALTER TABLE `ps_hook_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_hook_module_exceptions`
--

DROP TABLE IF EXISTS `ps_hook_module_exceptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_hook_module_exceptions` (
  `id_hook_module_exceptions` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_module` int(10) unsigned NOT NULL,
  `id_hook` int(10) unsigned NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_hook_module_exceptions`),
  KEY `id_module` (`id_module`),
  KEY `id_hook` (`id_hook`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_hook_module_exceptions`
--

LOCK TABLES `ps_hook_module_exceptions` WRITE;
/*!40000 ALTER TABLE `ps_hook_module_exceptions` DISABLE KEYS */;
INSERT INTO `ps_hook_module_exceptions` VALUES (1,1,19,238,'address'),(2,1,19,238,'addresses'),(3,1,19,238,'attachment'),(4,1,19,238,'bestsales'),(5,1,19,238,'cart'),(6,1,19,238,'category'),(7,1,19,238,'cms'),(8,1,19,238,'contact'),(9,1,19,238,'discount'),(10,1,19,238,'getfile'),(11,1,19,238,'guesttracking'),(12,1,19,238,'history'),(13,1,19,238,'identity'),(14,1,19,238,'myaccount'),(15,1,19,238,'newproducts'),(16,1,19,238,'order'),(17,1,19,238,'orderconfirmation'),(18,1,19,238,'orderdetail'),(19,1,19,238,'orderfollow'),(20,1,19,238,'orderreturn'),(21,1,19,238,'orderslip'),(22,1,19,238,'pagenotfound'),(23,1,19,238,'pdfinvoice'),(24,1,19,238,'pdforderreturn'),(25,1,19,238,'pdforderslip'),(26,1,19,238,'pricesdrop'),(27,1,19,238,'product'),(28,1,19,238,'search'),(29,1,19,238,'viewedproducts');
/*!40000 ALTER TABLE `ps_hook_module_exceptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_image`
--

DROP TABLE IF EXISTS `ps_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_image` (
  `id_image` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `position` smallint(2) unsigned NOT NULL DEFAULT '0',
  `cover` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_image`),
  UNIQUE KEY `id_product_cover` (`id_product`,`cover`),
  UNIQUE KEY `idx_product_image` (`id_image`,`id_product`,`cover`),
  KEY `image_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_image`
--

LOCK TABLES `ps_image` WRITE;
/*!40000 ALTER TABLE `ps_image` DISABLE KEYS */;
INSERT INTO `ps_image` VALUES (1,1,1,NULL),(2,1,2,1),(3,2,1,1),(6,4,1,1),(7,6,1,1),(10,9,1,1),(11,3,1,1),(12,10,1,1),(13,11,1,NULL),(14,11,2,NULL),(15,11,3,NULL),(16,11,4,1),(17,12,1,1),(18,12,2,NULL),(19,14,1,1),(20,15,1,1),(21,13,1,1),(22,13,2,NULL),(23,13,3,NULL),(28,2,2,NULL),(29,2,3,NULL),(30,2,5,NULL),(31,2,4,NULL),(32,8,1,1),(33,15,2,NULL),(34,15,3,NULL),(35,15,4,NULL),(36,15,5,NULL);
/*!40000 ALTER TABLE `ps_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_image_lang`
--

DROP TABLE IF EXISTS `ps_image_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_image_lang` (
  `id_image` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `legend` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_image`,`id_lang`),
  KEY `id_image` (`id_image`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_image_lang`
--

LOCK TABLES `ps_image_lang` WRITE;
/*!40000 ALTER TABLE `ps_image_lang` DISABLE KEYS */;
INSERT INTO `ps_image_lang` VALUES (1,1,''),(1,2,''),(1,3,''),(1,4,''),(2,1,''),(2,2,''),(2,3,''),(2,4,''),(3,1,''),(3,2,''),(3,3,''),(3,4,''),(6,1,''),(6,2,''),(6,3,''),(6,4,''),(7,1,''),(7,2,''),(7,3,''),(7,4,''),(10,1,''),(10,2,''),(10,3,''),(10,4,''),(11,1,''),(11,2,''),(11,3,''),(11,4,''),(12,1,''),(12,2,''),(12,3,''),(12,4,''),(13,1,''),(13,2,''),(13,3,''),(13,4,''),(14,1,''),(14,2,''),(14,3,''),(14,4,''),(15,1,''),(15,2,''),(15,3,''),(15,4,''),(16,1,''),(16,2,''),(16,3,''),(16,4,''),(17,1,''),(17,2,''),(17,3,''),(17,4,''),(18,1,''),(18,2,''),(18,3,''),(18,4,''),(19,1,''),(19,2,''),(19,3,''),(19,4,''),(20,1,''),(20,2,''),(20,3,''),(20,4,''),(21,1,''),(21,2,''),(21,3,''),(21,4,''),(22,1,''),(22,2,''),(22,3,''),(22,4,''),(23,1,''),(23,2,''),(23,3,''),(23,4,''),(28,1,''),(28,2,''),(28,3,''),(28,4,''),(29,1,''),(29,2,'波面剛古紙'),(29,3,''),(29,4,''),(30,1,''),(30,2,'炫光紙'),(30,3,''),(30,4,''),(31,1,''),(31,2,'トーメイあらじま'),(31,3,''),(31,4,''),(32,1,''),(32,2,''),(32,3,''),(32,4,''),(33,1,''),(33,2,''),(33,3,''),(33,4,''),(34,1,''),(34,2,''),(34,3,''),(34,4,''),(35,1,''),(35,2,''),(35,3,''),(35,4,''),(36,1,''),(36,2,''),(36,3,''),(36,4,'');
/*!40000 ALTER TABLE `ps_image_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_image_shop`
--

DROP TABLE IF EXISTS `ps_image_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_image_shop` (
  `id_product` int(10) unsigned NOT NULL,
  `id_image` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `cover` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_image`,`id_shop`),
  UNIQUE KEY `id_product` (`id_product`,`id_shop`,`cover`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_image_shop`
--

LOCK TABLES `ps_image_shop` WRITE;
/*!40000 ALTER TABLE `ps_image_shop` DISABLE KEYS */;
INSERT INTO `ps_image_shop` VALUES (1,1,1,NULL),(1,2,1,1),(2,28,1,NULL),(2,29,1,NULL),(2,30,1,NULL),(2,31,1,NULL),(2,3,1,1),(3,11,1,1),(4,6,1,1),(6,7,1,1),(8,32,1,1),(9,10,1,1),(10,12,1,1),(11,13,1,NULL),(11,14,1,NULL),(11,15,1,NULL),(11,16,1,1),(12,18,1,NULL),(12,17,1,1),(13,22,1,NULL),(13,23,1,NULL),(13,21,1,1),(14,19,1,1),(15,33,1,NULL),(15,34,1,NULL),(15,35,1,NULL),(15,36,1,NULL),(15,20,1,1);
/*!40000 ALTER TABLE `ps_image_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_image_type`
--

DROP TABLE IF EXISTS `ps_image_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_image_type` (
  `id_image_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `width` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL,
  `products` tinyint(1) NOT NULL DEFAULT '1',
  `categories` tinyint(1) NOT NULL DEFAULT '1',
  `manufacturers` tinyint(1) NOT NULL DEFAULT '1',
  `suppliers` tinyint(1) NOT NULL DEFAULT '1',
  `stores` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_image_type`),
  KEY `image_type_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_image_type`
--

LOCK TABLES `ps_image_type` WRITE;
/*!40000 ALTER TABLE `ps_image_type` DISABLE KEYS */;
INSERT INTO `ps_image_type` VALUES (1,'cart_default',125,125,0,0,0,0,0),(2,'small_default',300,300,1,1,1,1,0),(3,'medium_default',452,452,0,0,1,1,0),(4,'home_default',500,500,1,0,0,0,0),(5,'large_default',800,800,1,0,1,1,0),(6,'category_default',141,180,0,1,0,0,0),(7,'stores_default',170,115,0,0,0,0,1);
/*!40000 ALTER TABLE `ps_image_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_import_match`
--

DROP TABLE IF EXISTS `ps_import_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_import_match` (
  `id_import_match` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `match` text NOT NULL,
  `skip` int(2) NOT NULL,
  PRIMARY KEY (`id_import_match`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_import_match`
--

LOCK TABLES `ps_import_match` WRITE;
/*!40000 ALTER TABLE `ps_import_match` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_import_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_info`
--

DROP TABLE IF EXISTS `ps_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_info` (
  `id_info` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_info`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_info`
--

LOCK TABLES `ps_info` WRITE;
/*!40000 ALTER TABLE `ps_info` DISABLE KEYS */;
INSERT INTO `ps_info` VALUES (1);
/*!40000 ALTER TABLE `ps_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_info_lang`
--

DROP TABLE IF EXISTS `ps_info_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_info_lang` (
  `id_info` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_info`,`id_lang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_info_lang`
--

LOCK TABLES `ps_info_lang` WRITE;
/*!40000 ALTER TABLE `ps_info_lang` DISABLE KEYS */;
INSERT INTO `ps_info_lang` VALUES (1,1,1,'<p>手工縫製一本隨身畫冊．在路上邊走邊畫</p>\n<p class=\"gray-darker\">書冊體積小，輕便易攜帶，能收取到繪畫者面對大自然時最感動的線條和筆觸；其頁面接續頁面的結構易於表述時間，呈現宛如記憶綿延的連續動態想像。書冊需要近觀、徒手翻頁的特質，則提供了較為私密、親近人身體的感官體驗。</p>\n<p>在 HTML 編輯器用 Bootstrap Grid 實作 RWD：</p>\n<div class=\"row\" style=\"margin-bottom:10px;\">\n<div class=\"col-xs-12 col-lg-3\">\n<div class=\"row\">\n<div class=\"col-xs-6 col-lg-12\"><img src=\"https://demo.tekapo.io/img/cms/sample/grid-sample.jpg\" alt=\"移動記《山脈》 清水斷崖\" style=\"width:100%;margin:10px 0;\" /></div>\n<div class=\"col-xs-6 col-lg-12\"><img src=\"https://demo.tekapo.io/img/cms/sample/grid-sample.jpg\" alt=\"移動記《山脈》 清水斷崖\" style=\"width:100%;margin:10px 0;\" /></div>\n</div>\n</div>\n<div class=\"col-xs-12 col-lg-6\"><img src=\"https://demo.tekapo.io/img/cms/sample/grid-sample.jpg\" alt=\"移動記《山脈》 清水斷崖\" style=\"width:100%;margin:10px 0;\" /></div>\n<div class=\"col-xs-6 col-lg-3\"><img src=\"https://demo.tekapo.io/img/cms/sample/grid-sample.jpg\" alt=\"移動記《山脈》 清水斷崖\" style=\"width:100%;margin:10px 0;\" /></div>\n</div>'),(1,1,2,'<h3>移動記</h3>\n<p><strong class=\"dark\">手工縫製一本隨身畫冊．在路上邊走邊畫</strong></p>\n<p>書冊體積小，輕便易攜帶，能收取到繪畫者面對大自然時最感動的線條和筆觸；其頁面接續頁面的結構易於表述時間，呈現宛如記憶綿延的連續動態想像。書冊需要近觀、徒手翻頁的特質，則提供了較為私密、親近人身體的感官體驗。</p>'),(1,1,3,'<h3>移動記</h3>\n<p><strong class=\"dark\">手工縫製一本隨身畫冊．在路上邊走邊畫</strong></p>\n<p>書冊體積小，輕便易攜帶，能收取到繪畫者面對大自然時最感動的線條和筆觸；其頁面接續頁面的結構易於表述時間，呈現宛如記憶綿延的連續動態想像。書冊需要近觀、徒手翻頁的特質，則提供了較為私密、親近人身體的感官體驗。</p>'),(1,1,4,'<h3>移動記</h3>\n<p><strong class=\"dark\">手工縫製一本隨身畫冊．在路上邊走邊畫</strong></p>\n<p>書冊體積小，輕便易攜帶，能收取到繪畫者面對大自然時最感動的線條和筆觸；其頁面接續頁面的結構易於表述時間，呈現宛如記憶綿延的連續動態想像。書冊需要近觀、徒手翻頁的特質，則提供了較為私密、親近人身體的感官體驗。</p>');
/*!40000 ALTER TABLE `ps_info_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_info_shop`
--

DROP TABLE IF EXISTS `ps_info_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_info_shop` (
  `id_info` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_info`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_info_shop`
--

LOCK TABLES `ps_info_shop` WRITE;
/*!40000 ALTER TABLE `ps_info_shop` DISABLE KEYS */;
INSERT INTO `ps_info_shop` VALUES (1,1);
/*!40000 ALTER TABLE `ps_info_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_lang`
--

DROP TABLE IF EXISTS `ps_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lang` (
  `id_lang` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `iso_code` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `language_code` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `date_format_lite` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `date_format_full` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `is_rtl` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_lang`
--

LOCK TABLES `ps_lang` WRITE;
/*!40000 ALTER TABLE `ps_lang` DISABLE KEYS */;
INSERT INTO `ps_lang` VALUES (1,'繁體中文',1,'tw','zh-tw','zh-TW','Y-m-d','Y-m-d H:i:s',0),(2,'English',1,'en','en-us','en-US','m/d/Y','m/d/Y H:i:s',0),(3,'簡体中文',0,'zh','zh-cn','zh-CN','Y-m-d','Y-m-d H:i:s',0),(4,'日本語',1,'jp','ja-jp','ja-JP','Y-m-d','Y-m-d H:i:s',0);
/*!40000 ALTER TABLE `ps_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_lang_shop`
--

DROP TABLE IF EXISTS `ps_lang_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_lang_shop` (
  `id_lang` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  PRIMARY KEY (`id_lang`,`id_shop`),
  KEY `IDX_2F43BFC7BA299860` (`id_lang`),
  KEY `IDX_2F43BFC7274A50A0` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_lang_shop`
--

LOCK TABLES `ps_lang_shop` WRITE;
/*!40000 ALTER TABLE `ps_lang_shop` DISABLE KEYS */;
INSERT INTO `ps_lang_shop` VALUES (1,1),(1,2),(1,3),(1,4),(2,1),(2,2),(2,3),(2,4),(3,1),(3,2),(3,3),(3,4),(4,1),(4,2),(4,3),(4,4);
/*!40000 ALTER TABLE `ps_lang_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_category`
--

DROP TABLE IF EXISTS `ps_layered_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_category` (
  `id_layered_category` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL,
  `id_category` int(10) unsigned NOT NULL,
  `id_value` int(10) unsigned DEFAULT '0',
  `type` enum('category','id_feature','id_attribute_group','quantity','condition','manufacturer','weight','price') NOT NULL,
  `position` int(10) unsigned NOT NULL,
  `filter_type` int(10) unsigned NOT NULL DEFAULT '0',
  `filter_show_limit` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_layered_category`),
  KEY `id_category` (`id_category`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_category`
--

LOCK TABLES `ps_layered_category` WRITE;
/*!40000 ALTER TABLE `ps_layered_category` DISABLE KEYS */;
INSERT INTO `ps_layered_category` VALUES (1,1,2,NULL,'price',1,0,0),(2,1,2,1,'id_attribute_group',2,0,0),(3,1,2,2,'id_attribute_group',3,0,0),(4,1,2,3,'id_attribute_group',4,0,0),(5,1,7,NULL,'price',1,0,0),(6,1,7,1,'id_attribute_group',2,0,0),(7,1,7,2,'id_attribute_group',3,0,0),(8,1,7,3,'id_attribute_group',4,0,0),(9,1,8,NULL,'price',1,0,0),(10,1,8,1,'id_attribute_group',2,0,0),(11,1,8,2,'id_attribute_group',3,0,0),(12,1,8,3,'id_attribute_group',4,0,0),(13,1,14,NULL,'price',1,0,0),(14,1,14,1,'id_attribute_group',2,0,0),(15,1,14,2,'id_attribute_group',3,0,0),(16,1,14,3,'id_attribute_group',4,0,0);
/*!40000 ALTER TABLE `ps_layered_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_filter`
--

DROP TABLE IF EXISTS `ps_layered_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_filter` (
  `id_layered_filter` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `filters` longtext,
  `n_categories` int(10) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_layered_filter`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_filter`
--

LOCK TABLES `ps_layered_filter` WRITE;
/*!40000 ALTER TABLE `ps_layered_filter` DISABLE KEYS */;
INSERT INTO `ps_layered_filter` VALUES (1,'我的模板 2018-07-11','a:6:{s:9:\"shop_list\";a:1:{i:0;i:1;}s:10:\"categories\";a:4:{i:0;i:2;i:1;i:7;i:2;i:8;i:3;i:14;}s:30:\"layered_selection_price_slider\";a:2:{s:11:\"filter_type\";i:0;s:17:\"filter_show_limit\";i:0;}s:22:\"layered_selection_ag_1\";a:2:{s:11:\"filter_type\";i:0;s:17:\"filter_show_limit\";i:0;}s:22:\"layered_selection_ag_2\";a:2:{s:11:\"filter_type\";i:0;s:17:\"filter_show_limit\";i:0;}s:22:\"layered_selection_ag_3\";a:2:{s:11:\"filter_type\";i:0;s:17:\"filter_show_limit\";i:0;}}',4,'2019-08-18 23:04:44');
/*!40000 ALTER TABLE `ps_layered_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_filter_block`
--

DROP TABLE IF EXISTS `ps_layered_filter_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_filter_block` (
  `hash` char(32) NOT NULL DEFAULT '',
  `data` text,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_filter_block`
--

LOCK TABLES `ps_layered_filter_block` WRITE;
/*!40000 ALTER TABLE `ps_layered_filter_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_layered_filter_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_filter_shop`
--

DROP TABLE IF EXISTS `ps_layered_filter_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_filter_shop` (
  `id_layered_filter` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_layered_filter`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_filter_shop`
--

LOCK TABLES `ps_layered_filter_shop` WRITE;
/*!40000 ALTER TABLE `ps_layered_filter_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_layered_filter_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_indexable_attribute_group`
--

DROP TABLE IF EXISTS `ps_layered_indexable_attribute_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_indexable_attribute_group` (
  `id_attribute_group` int(11) NOT NULL,
  `indexable` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_attribute_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_indexable_attribute_group`
--

LOCK TABLES `ps_layered_indexable_attribute_group` WRITE;
/*!40000 ALTER TABLE `ps_layered_indexable_attribute_group` DISABLE KEYS */;
INSERT INTO `ps_layered_indexable_attribute_group` VALUES (1,1),(2,1),(3,1);
/*!40000 ALTER TABLE `ps_layered_indexable_attribute_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_indexable_attribute_group_lang_value`
--

DROP TABLE IF EXISTS `ps_layered_indexable_attribute_group_lang_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_indexable_attribute_group_lang_value` (
  `id_attribute_group` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `url_name` varchar(128) DEFAULT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_attribute_group`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_indexable_attribute_group_lang_value`
--

LOCK TABLES `ps_layered_indexable_attribute_group_lang_value` WRITE;
/*!40000 ALTER TABLE `ps_layered_indexable_attribute_group_lang_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_layered_indexable_attribute_group_lang_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_indexable_attribute_lang_value`
--

DROP TABLE IF EXISTS `ps_layered_indexable_attribute_lang_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_indexable_attribute_lang_value` (
  `id_attribute` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `url_name` varchar(128) DEFAULT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_attribute`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_indexable_attribute_lang_value`
--

LOCK TABLES `ps_layered_indexable_attribute_lang_value` WRITE;
/*!40000 ALTER TABLE `ps_layered_indexable_attribute_lang_value` DISABLE KEYS */;
INSERT INTO `ps_layered_indexable_attribute_lang_value` VALUES (6,1,'波面剛古紙',''),(6,2,'波面剛古紙',''),(6,3,'波面剛古紙',''),(6,4,'コンケラーコンツァ',''),(7,1,'トーメイあらじま',''),(7,2,'トーメイあらじま',''),(7,3,'トーメイあらじま',''),(7,4,'トーメイあらじま',''),(8,1,'炫光紙',''),(8,2,'炫光紙',''),(8,3,'炫光紙',''),(8,4,'キュリアス-メタル',''),(9,1,'湖綠',''),(9,2,'湖綠',''),(9,3,'湖綠',''),(9,4,'ライトグリーン',''),(10,1,'海藍',''),(10,2,'海藍',''),(10,3,'海藍',''),(10,4,'シーブルー',''),(11,1,'血紅',''),(11,2,'血紅',''),(11,3,'血紅',''),(11,4,'レッド',''),(12,1,'日金',''),(12,2,'日金',''),(12,3,'日金',''),(12,4,'イエロー','');
/*!40000 ALTER TABLE `ps_layered_indexable_attribute_lang_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_indexable_feature`
--

DROP TABLE IF EXISTS `ps_layered_indexable_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_indexable_feature` (
  `id_feature` int(11) NOT NULL,
  `indexable` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_feature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_indexable_feature`
--

LOCK TABLES `ps_layered_indexable_feature` WRITE;
/*!40000 ALTER TABLE `ps_layered_indexable_feature` DISABLE KEYS */;
INSERT INTO `ps_layered_indexable_feature` VALUES (1,1),(2,1),(3,1),(4,1),(5,1);
/*!40000 ALTER TABLE `ps_layered_indexable_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_indexable_feature_lang_value`
--

DROP TABLE IF EXISTS `ps_layered_indexable_feature_lang_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_indexable_feature_lang_value` (
  `id_feature` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `url_name` varchar(128) NOT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_feature`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_indexable_feature_lang_value`
--

LOCK TABLES `ps_layered_indexable_feature_lang_value` WRITE;
/*!40000 ALTER TABLE `ps_layered_indexable_feature_lang_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_layered_indexable_feature_lang_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_indexable_feature_value_lang_value`
--

DROP TABLE IF EXISTS `ps_layered_indexable_feature_value_lang_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_indexable_feature_value_lang_value` (
  `id_feature_value` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `url_name` varchar(128) DEFAULT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_feature_value`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_indexable_feature_value_lang_value`
--

LOCK TABLES `ps_layered_indexable_feature_value_lang_value` WRITE;
/*!40000 ALTER TABLE `ps_layered_indexable_feature_value_lang_value` DISABLE KEYS */;
INSERT INTO `ps_layered_indexable_feature_value_lang_value` VALUES (1,1,'',''),(1,2,'',''),(1,3,'',''),(1,4,'',''),(2,1,'',''),(2,2,'',''),(2,3,'',''),(2,4,'','');
/*!40000 ALTER TABLE `ps_layered_indexable_feature_value_lang_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_price_index`
--

DROP TABLE IF EXISTS `ps_layered_price_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_price_index` (
  `id_product` int(11) NOT NULL,
  `id_currency` int(11) NOT NULL,
  `id_shop` int(11) NOT NULL,
  `price_min` decimal(11,5) NOT NULL,
  `price_max` decimal(11,5) NOT NULL,
  `id_country` int(11) NOT NULL,
  PRIMARY KEY (`id_product`,`id_currency`,`id_shop`,`id_country`),
  KEY `id_currency` (`id_currency`),
  KEY `price_min` (`price_min`),
  KEY `price_max` (`price_max`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_price_index`
--

LOCK TABLES `ps_layered_price_index` WRITE;
/*!40000 ALTER TABLE `ps_layered_price_index` DISABLE KEYS */;
INSERT INTO `ps_layered_price_index` VALUES (1,1,1,9000.00000,9000.00000,203),(1,1,2,0.00000,0.00000,203),(1,1,3,0.00000,0.00000,203),(1,1,4,0.00000,0.00000,203),(1,3,1,293.00000,293.00000,203),(1,3,2,0.00000,0.00000,203),(1,3,3,0.00000,0.00000,203),(1,3,4,0.00000,0.00000,203),(1,6,1,2295.00000,2295.00000,203),(1,6,2,0.00000,0.00000,203),(1,6,3,0.00000,0.00000,203),(1,6,4,0.00000,0.00000,203),(1,7,1,2091.00000,2091.00000,203),(1,7,2,0.00000,0.00000,203),(1,7,3,0.00000,0.00000,203),(1,7,4,0.00000,0.00000,203),(2,1,1,23330.00000,23330.00000,203),(2,1,2,0.00000,0.00000,203),(2,1,3,0.00000,0.00000,203),(2,1,4,0.00000,0.00000,203),(2,3,1,759.00000,759.00000,203),(2,3,2,0.00000,0.00000,203),(2,3,3,0.00000,0.00000,203),(2,3,4,0.00000,0.00000,203),(2,6,1,5950.00000,5950.00000,203),(2,6,2,0.00000,0.00000,203),(2,6,3,0.00000,0.00000,203),(2,6,4,0.00000,0.00000,203),(2,7,1,5419.00000,5419.00000,203),(2,7,2,0.00000,0.00000,203),(2,7,3,0.00000,0.00000,203),(2,7,4,0.00000,0.00000,203),(3,1,1,1500.00000,1500.00000,203),(3,1,2,0.00000,0.00000,203),(3,1,3,0.00000,0.00000,203),(3,1,4,0.00000,0.00000,203),(3,3,1,49.00000,49.00000,203),(3,3,2,0.00000,0.00000,203),(3,3,3,0.00000,0.00000,203),(3,3,4,0.00000,0.00000,203),(3,6,1,383.00000,383.00000,203),(3,6,2,0.00000,0.00000,203),(3,6,3,0.00000,0.00000,203),(3,6,4,0.00000,0.00000,203),(3,7,1,348.00000,348.00000,203),(3,7,2,0.00000,0.00000,203),(3,7,3,0.00000,0.00000,203),(3,7,4,0.00000,0.00000,203),(4,1,1,10000.00000,10000.00000,203),(4,1,2,0.00000,0.00000,203),(4,1,3,0.00000,0.00000,203),(4,1,4,0.00000,0.00000,203),(4,3,1,325.00000,325.00000,203),(4,3,2,0.00000,0.00000,203),(4,3,3,0.00000,0.00000,203),(4,3,4,0.00000,0.00000,203),(4,6,1,2550.00000,2550.00000,203),(4,6,2,0.00000,0.00000,203),(4,6,3,0.00000,0.00000,203),(4,6,4,0.00000,0.00000,203),(4,7,1,2323.00000,2323.00000,203),(4,7,2,0.00000,0.00000,203),(4,7,3,0.00000,0.00000,203),(4,7,4,0.00000,0.00000,203),(5,1,1,0.00000,0.00000,203),(5,1,2,0.00000,0.00000,203),(5,1,3,0.00000,0.00000,203),(5,1,4,0.00000,0.00000,203),(5,3,1,0.00000,0.00000,203),(5,3,2,0.00000,0.00000,203),(5,3,3,0.00000,0.00000,203),(5,3,4,0.00000,0.00000,203),(5,6,1,0.00000,0.00000,203),(5,6,2,0.00000,0.00000,203),(5,6,3,0.00000,0.00000,203),(5,6,4,0.00000,0.00000,203),(5,7,1,0.00000,0.00000,203),(5,7,2,0.00000,0.00000,203),(5,7,3,0.00000,0.00000,203),(5,7,4,0.00000,0.00000,203),(6,1,1,50.00000,50.00000,203),(6,1,2,0.00000,0.00000,203),(6,1,3,0.00000,0.00000,203),(6,1,4,0.00000,0.00000,203),(6,3,1,2.00000,2.00000,203),(6,3,2,0.00000,0.00000,203),(6,3,3,0.00000,0.00000,203),(6,3,4,0.00000,0.00000,203),(6,6,1,13.00000,13.00000,203),(6,6,2,0.00000,0.00000,203),(6,6,3,0.00000,0.00000,203),(6,6,4,0.00000,0.00000,203),(6,7,1,12.00000,12.00000,203),(6,7,2,0.00000,0.00000,203),(6,7,3,0.00000,0.00000,203),(6,7,4,0.00000,0.00000,203),(8,1,1,20.00000,20.00000,203),(8,1,2,0.00000,0.00000,203),(8,1,3,0.00000,0.00000,203),(8,1,4,0.00000,0.00000,203),(8,3,1,1.00000,1.00000,203),(8,3,2,0.00000,0.00000,203),(8,3,3,0.00000,0.00000,203),(8,3,4,0.00000,0.00000,203),(8,6,1,5.00000,5.00000,203),(8,6,2,0.00000,0.00000,203),(8,6,3,0.00000,0.00000,203),(8,6,4,0.00000,0.00000,203),(8,7,1,5.00000,5.00000,203),(8,7,2,0.00000,0.00000,203),(8,7,3,0.00000,0.00000,203),(8,7,4,0.00000,0.00000,203),(9,1,1,180.00000,180.00000,203),(9,1,2,0.00000,0.00000,203),(9,1,3,0.00000,0.00000,203),(9,1,4,0.00000,0.00000,203),(9,3,1,6.00000,6.00000,203),(9,3,2,0.00000,0.00000,203),(9,3,3,0.00000,0.00000,203),(9,3,4,0.00000,0.00000,203),(9,6,1,46.00000,46.00000,203),(9,6,2,0.00000,0.00000,203),(9,6,3,0.00000,0.00000,203),(9,6,4,0.00000,0.00000,203),(9,7,1,42.00000,42.00000,203),(9,7,2,0.00000,0.00000,203),(9,7,3,0.00000,0.00000,203),(9,7,4,0.00000,0.00000,203),(10,1,1,180.00000,180.00000,203),(10,1,2,0.00000,0.00000,203),(10,1,3,0.00000,0.00000,203),(10,1,4,0.00000,0.00000,203),(10,3,1,6.00000,6.00000,203),(10,3,2,0.00000,0.00000,203),(10,3,3,0.00000,0.00000,203),(10,3,4,0.00000,0.00000,203),(10,6,1,46.00000,46.00000,203),(10,6,2,0.00000,0.00000,203),(10,6,3,0.00000,0.00000,203),(10,6,4,0.00000,0.00000,203),(10,7,1,42.00000,42.00000,203),(10,7,2,0.00000,0.00000,203),(10,7,3,0.00000,0.00000,203),(10,7,4,0.00000,0.00000,203),(11,1,1,300.00000,300.00000,203),(11,1,2,0.00000,0.00000,203),(11,1,3,0.00000,0.00000,203),(11,1,4,0.00000,0.00000,203),(11,3,1,10.00000,10.00000,203),(11,3,2,0.00000,0.00000,203),(11,3,3,0.00000,0.00000,203),(11,3,4,0.00000,0.00000,203),(11,6,1,77.00000,77.00000,203),(11,6,2,0.00000,0.00000,203),(11,6,3,0.00000,0.00000,203),(11,6,4,0.00000,0.00000,203),(11,7,1,70.00000,70.00000,203),(11,7,2,0.00000,0.00000,203),(11,7,3,0.00000,0.00000,203),(11,7,4,0.00000,0.00000,203),(12,1,1,150.00000,150.00000,203),(12,1,2,0.00000,0.00000,203),(12,1,3,0.00000,0.00000,203),(12,1,4,0.00000,0.00000,203),(12,3,1,5.00000,5.00000,203),(12,3,2,0.00000,0.00000,203),(12,3,3,0.00000,0.00000,203),(12,3,4,0.00000,0.00000,203),(12,6,1,38.00000,38.00000,203),(12,6,2,0.00000,0.00000,203),(12,6,3,0.00000,0.00000,203),(12,6,4,0.00000,0.00000,203),(12,7,1,35.00000,35.00000,203),(12,7,2,0.00000,0.00000,203),(12,7,3,0.00000,0.00000,203),(12,7,4,0.00000,0.00000,203),(13,1,1,1800.00000,1800.00000,203),(13,1,2,0.00000,0.00000,203),(13,1,3,0.00000,0.00000,203),(13,1,4,0.00000,0.00000,203),(13,3,1,59.00000,59.00000,203),(13,3,2,0.00000,0.00000,203),(13,3,3,0.00000,0.00000,203),(13,3,4,0.00000,0.00000,203),(13,6,1,459.00000,459.00000,203),(13,6,2,0.00000,0.00000,203),(13,6,3,0.00000,0.00000,203),(13,6,4,0.00000,0.00000,203),(13,7,1,418.00000,418.00000,203),(13,7,2,0.00000,0.00000,203),(13,7,3,0.00000,0.00000,203),(13,7,4,0.00000,0.00000,203),(14,1,1,1700.00000,1700.00000,203),(14,1,2,0.00000,0.00000,203),(14,1,3,0.00000,0.00000,203),(14,1,4,0.00000,0.00000,203),(14,3,1,55.00000,55.00000,203),(14,3,2,0.00000,0.00000,203),(14,3,3,0.00000,0.00000,203),(14,3,4,0.00000,0.00000,203),(14,6,1,434.00000,434.00000,203),(14,6,2,0.00000,0.00000,203),(14,6,3,0.00000,0.00000,203),(14,6,4,0.00000,0.00000,203),(14,7,1,395.00000,395.00000,203),(14,7,2,0.00000,0.00000,203),(14,7,3,0.00000,0.00000,203),(14,7,4,0.00000,0.00000,203),(15,1,1,50050.00000,50050.00000,203),(15,1,2,0.00000,0.00000,203),(15,1,3,0.00000,0.00000,203),(15,1,4,0.00000,0.00000,203),(15,3,1,1627.00000,1627.00000,203),(15,3,2,0.00000,0.00000,203),(15,3,3,0.00000,0.00000,203),(15,3,4,0.00000,0.00000,203),(15,6,1,12765.00000,12765.00000,203),(15,6,2,0.00000,0.00000,203),(15,6,3,0.00000,0.00000,203),(15,6,4,0.00000,0.00000,203),(15,7,1,11626.00000,11626.00000,203),(15,7,2,0.00000,0.00000,203),(15,7,3,0.00000,0.00000,203),(15,7,4,0.00000,0.00000,203),(16,1,1,1000.00000,1000.00000,203),(16,1,2,0.00000,0.00000,203),(16,1,3,0.00000,0.00000,203),(16,1,4,0.00000,0.00000,203),(16,3,1,33.00000,33.00000,203),(16,3,2,0.00000,0.00000,203),(16,3,3,0.00000,0.00000,203),(16,3,4,0.00000,0.00000,203),(16,6,1,255.00000,255.00000,203),(16,6,2,0.00000,0.00000,203),(16,6,3,0.00000,0.00000,203),(16,6,4,0.00000,0.00000,203),(16,7,1,232.00000,232.00000,203),(16,7,2,0.00000,0.00000,203),(16,7,3,0.00000,0.00000,203),(16,7,4,0.00000,0.00000,203),(17,1,1,1000.00000,1000.00000,203),(17,1,2,0.00000,0.00000,203),(17,1,3,0.00000,0.00000,203),(17,1,4,0.00000,0.00000,203),(17,3,1,33.00000,33.00000,203),(17,3,2,0.00000,0.00000,203),(17,3,3,0.00000,0.00000,203),(17,3,4,0.00000,0.00000,203),(17,6,1,255.00000,255.00000,203),(17,6,2,0.00000,0.00000,203),(17,6,3,0.00000,0.00000,203),(17,6,4,0.00000,0.00000,203),(17,7,1,232.00000,232.00000,203),(17,7,2,0.00000,0.00000,203),(17,7,3,0.00000,0.00000,203),(17,7,4,0.00000,0.00000,203),(18,1,1,1000.00000,1000.00000,203),(18,1,2,0.00000,0.00000,203),(18,1,3,0.00000,0.00000,203),(18,1,4,0.00000,0.00000,203),(18,3,1,33.00000,33.00000,203),(18,3,2,0.00000,0.00000,203),(18,3,3,0.00000,0.00000,203),(18,3,4,0.00000,0.00000,203),(18,6,1,255.00000,255.00000,203),(18,6,2,0.00000,0.00000,203),(18,6,3,0.00000,0.00000,203),(18,6,4,0.00000,0.00000,203),(18,7,1,232.00000,232.00000,203),(18,7,2,0.00000,0.00000,203),(18,7,3,0.00000,0.00000,203),(18,7,4,0.00000,0.00000,203),(19,1,1,1000.00000,1000.00000,203),(19,1,2,0.00000,0.00000,203),(19,1,3,0.00000,0.00000,203),(19,1,4,0.00000,0.00000,203),(19,3,1,33.00000,33.00000,203),(19,3,2,0.00000,0.00000,203),(19,3,3,0.00000,0.00000,203),(19,3,4,0.00000,0.00000,203),(19,6,1,255.00000,255.00000,203),(19,6,2,0.00000,0.00000,203),(19,6,3,0.00000,0.00000,203),(19,6,4,0.00000,0.00000,203),(19,7,1,232.00000,232.00000,203),(19,7,2,0.00000,0.00000,203),(19,7,3,0.00000,0.00000,203),(19,7,4,0.00000,0.00000,203),(20,1,1,1000.00000,1000.00000,203),(20,1,2,0.00000,0.00000,203),(20,1,3,0.00000,0.00000,203),(20,1,4,0.00000,0.00000,203),(20,3,1,33.00000,33.00000,203),(20,3,2,0.00000,0.00000,203),(20,3,3,0.00000,0.00000,203),(20,3,4,0.00000,0.00000,203),(20,6,1,255.00000,255.00000,203),(20,6,2,0.00000,0.00000,203),(20,6,3,0.00000,0.00000,203),(20,6,4,0.00000,0.00000,203),(20,7,1,232.00000,232.00000,203),(20,7,2,0.00000,0.00000,203),(20,7,3,0.00000,0.00000,203),(20,7,4,0.00000,0.00000,203),(21,1,1,1000.00000,1000.00000,203),(21,1,2,0.00000,0.00000,203),(21,1,3,0.00000,0.00000,203),(21,1,4,0.00000,0.00000,203),(21,3,1,33.00000,33.00000,203),(21,3,2,0.00000,0.00000,203),(21,3,3,0.00000,0.00000,203),(21,3,4,0.00000,0.00000,203),(21,6,1,255.00000,255.00000,203),(21,6,2,0.00000,0.00000,203),(21,6,3,0.00000,0.00000,203),(21,6,4,0.00000,0.00000,203),(21,7,1,232.00000,232.00000,203),(21,7,2,0.00000,0.00000,203),(21,7,3,0.00000,0.00000,203),(21,7,4,0.00000,0.00000,203),(22,1,1,1000.00000,1000.00000,203),(22,1,2,0.00000,0.00000,203),(22,1,3,0.00000,0.00000,203),(22,1,4,0.00000,0.00000,203),(22,3,1,33.00000,33.00000,203),(22,3,2,0.00000,0.00000,203),(22,3,3,0.00000,0.00000,203),(22,3,4,0.00000,0.00000,203),(22,6,1,255.00000,255.00000,203),(22,6,2,0.00000,0.00000,203),(22,6,3,0.00000,0.00000,203),(22,6,4,0.00000,0.00000,203),(22,7,1,232.00000,232.00000,203),(22,7,2,0.00000,0.00000,203),(22,7,3,0.00000,0.00000,203),(22,7,4,0.00000,0.00000,203),(23,1,1,1000.00000,1000.00000,203),(23,1,2,0.00000,0.00000,203),(23,1,3,0.00000,0.00000,203),(23,1,4,0.00000,0.00000,203),(23,3,1,33.00000,33.00000,203),(23,3,2,0.00000,0.00000,203),(23,3,3,0.00000,0.00000,203),(23,3,4,0.00000,0.00000,203),(23,6,1,255.00000,255.00000,203),(23,6,2,0.00000,0.00000,203),(23,6,3,0.00000,0.00000,203),(23,6,4,0.00000,0.00000,203),(23,7,1,232.00000,232.00000,203),(23,7,2,0.00000,0.00000,203),(23,7,3,0.00000,0.00000,203),(23,7,4,0.00000,0.00000,203),(24,1,1,1111.00000,1111.00000,203),(24,1,2,0.00000,0.00000,203),(24,1,3,0.00000,0.00000,203),(24,1,4,0.00000,0.00000,203),(24,3,1,36.00000,36.00000,203),(24,3,2,0.00000,0.00000,203),(24,3,3,0.00000,0.00000,203),(24,3,4,0.00000,0.00000,203),(24,6,1,283.00000,283.00000,203),(24,6,2,0.00000,0.00000,203),(24,6,3,0.00000,0.00000,203),(24,6,4,0.00000,0.00000,203),(24,7,1,258.00000,258.00000,203),(24,7,2,0.00000,0.00000,203),(24,7,3,0.00000,0.00000,203),(24,7,4,0.00000,0.00000,203),(25,1,1,1111.00000,1111.00000,203),(25,1,2,0.00000,0.00000,203),(25,1,3,0.00000,0.00000,203),(25,1,4,0.00000,0.00000,203),(25,3,1,36.00000,36.00000,203),(25,3,2,0.00000,0.00000,203),(25,3,3,0.00000,0.00000,203),(25,3,4,0.00000,0.00000,203),(25,6,1,283.00000,283.00000,203),(25,6,2,0.00000,0.00000,203),(25,6,3,0.00000,0.00000,203),(25,6,4,0.00000,0.00000,203),(25,7,1,258.00000,258.00000,203),(25,7,2,0.00000,0.00000,203),(25,7,3,0.00000,0.00000,203),(25,7,4,0.00000,0.00000,203),(26,1,1,1111.00000,1111.00000,203),(26,1,2,0.00000,0.00000,203),(26,1,3,0.00000,0.00000,203),(26,1,4,0.00000,0.00000,203),(26,3,1,36.00000,36.00000,203),(26,3,2,0.00000,0.00000,203),(26,3,3,0.00000,0.00000,203),(26,3,4,0.00000,0.00000,203),(26,6,1,283.00000,283.00000,203),(26,6,2,0.00000,0.00000,203),(26,6,3,0.00000,0.00000,203),(26,6,4,0.00000,0.00000,203),(26,7,1,258.00000,258.00000,203),(26,7,2,0.00000,0.00000,203),(26,7,3,0.00000,0.00000,203),(26,7,4,0.00000,0.00000,203),(27,1,1,1111.00000,1111.00000,203),(27,1,2,0.00000,0.00000,203),(27,1,3,0.00000,0.00000,203),(27,1,4,0.00000,0.00000,203),(27,3,1,36.00000,36.00000,203),(27,3,2,0.00000,0.00000,203),(27,3,3,0.00000,0.00000,203),(27,3,4,0.00000,0.00000,203),(27,6,1,283.00000,283.00000,203),(27,6,2,0.00000,0.00000,203),(27,6,3,0.00000,0.00000,203),(27,6,4,0.00000,0.00000,203),(27,7,1,258.00000,258.00000,203),(27,7,2,0.00000,0.00000,203),(27,7,3,0.00000,0.00000,203),(27,7,4,0.00000,0.00000,203),(28,1,1,1111.00000,1111.00000,203),(28,1,2,0.00000,0.00000,203),(28,1,3,0.00000,0.00000,203),(28,1,4,0.00000,0.00000,203),(28,3,1,36.00000,36.00000,203),(28,3,2,0.00000,0.00000,203),(28,3,3,0.00000,0.00000,203),(28,3,4,0.00000,0.00000,203),(28,6,1,283.00000,283.00000,203),(28,6,2,0.00000,0.00000,203),(28,6,3,0.00000,0.00000,203),(28,6,4,0.00000,0.00000,203),(28,7,1,258.00000,258.00000,203),(28,7,2,0.00000,0.00000,203),(28,7,3,0.00000,0.00000,203),(28,7,4,0.00000,0.00000,203),(29,1,1,1111.00000,1111.00000,203),(29,1,2,0.00000,0.00000,203),(29,1,3,0.00000,0.00000,203),(29,1,4,0.00000,0.00000,203),(29,3,1,36.00000,36.00000,203),(29,3,2,0.00000,0.00000,203),(29,3,3,0.00000,0.00000,203),(29,3,4,0.00000,0.00000,203),(29,6,1,283.00000,283.00000,203),(29,6,2,0.00000,0.00000,203),(29,6,3,0.00000,0.00000,203),(29,6,4,0.00000,0.00000,203),(29,7,1,258.00000,258.00000,203),(29,7,2,0.00000,0.00000,203),(29,7,3,0.00000,0.00000,203),(29,7,4,0.00000,0.00000,203),(30,1,1,1111.00000,1111.00000,203),(30,1,2,0.00000,0.00000,203),(30,1,3,0.00000,0.00000,203),(30,1,4,0.00000,0.00000,203),(30,3,1,36.00000,36.00000,203),(30,3,2,0.00000,0.00000,203),(30,3,3,0.00000,0.00000,203),(30,3,4,0.00000,0.00000,203),(30,6,1,283.00000,283.00000,203),(30,6,2,0.00000,0.00000,203),(30,6,3,0.00000,0.00000,203),(30,6,4,0.00000,0.00000,203),(30,7,1,258.00000,258.00000,203),(30,7,2,0.00000,0.00000,203),(30,7,3,0.00000,0.00000,203),(30,7,4,0.00000,0.00000,203),(31,1,1,1111.00000,1111.00000,203),(31,1,2,0.00000,0.00000,203),(31,1,3,0.00000,0.00000,203),(31,1,4,0.00000,0.00000,203),(31,3,1,36.00000,36.00000,203),(31,3,2,0.00000,0.00000,203),(31,3,3,0.00000,0.00000,203),(31,3,4,0.00000,0.00000,203),(31,6,1,283.00000,283.00000,203),(31,6,2,0.00000,0.00000,203),(31,6,3,0.00000,0.00000,203),(31,6,4,0.00000,0.00000,203),(31,7,1,258.00000,258.00000,203),(31,7,2,0.00000,0.00000,203),(31,7,3,0.00000,0.00000,203),(31,7,4,0.00000,0.00000,203),(32,1,1,1111.00000,1111.00000,203),(32,1,2,0.00000,0.00000,203),(32,1,3,0.00000,0.00000,203),(32,1,4,0.00000,0.00000,203),(32,3,1,36.00000,36.00000,203),(32,3,2,0.00000,0.00000,203),(32,3,3,0.00000,0.00000,203),(32,3,4,0.00000,0.00000,203),(32,6,1,283.00000,283.00000,203),(32,6,2,0.00000,0.00000,203),(32,6,3,0.00000,0.00000,203),(32,6,4,0.00000,0.00000,203),(32,7,1,258.00000,258.00000,203),(32,7,2,0.00000,0.00000,203),(32,7,3,0.00000,0.00000,203),(32,7,4,0.00000,0.00000,203),(33,1,1,1111.00000,1111.00000,203),(33,1,2,0.00000,0.00000,203),(33,1,3,0.00000,0.00000,203),(33,1,4,0.00000,0.00000,203),(33,3,1,36.00000,36.00000,203),(33,3,2,0.00000,0.00000,203),(33,3,3,0.00000,0.00000,203),(33,3,4,0.00000,0.00000,203),(33,6,1,283.00000,283.00000,203),(33,6,2,0.00000,0.00000,203),(33,6,3,0.00000,0.00000,203),(33,6,4,0.00000,0.00000,203),(33,7,1,258.00000,258.00000,203),(33,7,2,0.00000,0.00000,203),(33,7,3,0.00000,0.00000,203),(33,7,4,0.00000,0.00000,203),(34,1,1,1111.00000,1111.00000,203),(34,1,2,0.00000,0.00000,203),(34,1,3,0.00000,0.00000,203),(34,1,4,0.00000,0.00000,203),(34,3,1,36.00000,36.00000,203),(34,3,2,0.00000,0.00000,203),(34,3,3,0.00000,0.00000,203),(34,3,4,0.00000,0.00000,203),(34,6,1,283.00000,283.00000,203),(34,6,2,0.00000,0.00000,203),(34,6,3,0.00000,0.00000,203),(34,6,4,0.00000,0.00000,203),(34,7,1,258.00000,258.00000,203),(34,7,2,0.00000,0.00000,203),(34,7,3,0.00000,0.00000,203),(34,7,4,0.00000,0.00000,203),(35,1,1,1111.00000,1111.00000,203),(35,1,2,0.00000,0.00000,203),(35,1,3,0.00000,0.00000,203),(35,1,4,0.00000,0.00000,203),(35,3,1,36.00000,36.00000,203),(35,3,2,0.00000,0.00000,203),(35,3,3,0.00000,0.00000,203),(35,3,4,0.00000,0.00000,203),(35,6,1,283.00000,283.00000,203),(35,6,2,0.00000,0.00000,203),(35,6,3,0.00000,0.00000,203),(35,6,4,0.00000,0.00000,203),(35,7,1,258.00000,258.00000,203),(35,7,2,0.00000,0.00000,203),(35,7,3,0.00000,0.00000,203),(35,7,4,0.00000,0.00000,203),(36,1,1,1111.00000,1111.00000,203),(36,1,2,0.00000,0.00000,203),(36,1,3,0.00000,0.00000,203),(36,1,4,0.00000,0.00000,203),(36,3,1,36.00000,36.00000,203),(36,3,2,0.00000,0.00000,203),(36,3,3,0.00000,0.00000,203),(36,3,4,0.00000,0.00000,203),(36,6,1,283.00000,283.00000,203),(36,6,2,0.00000,0.00000,203),(36,6,3,0.00000,0.00000,203),(36,6,4,0.00000,0.00000,203),(36,7,1,258.00000,258.00000,203),(36,7,2,0.00000,0.00000,203),(36,7,3,0.00000,0.00000,203),(36,7,4,0.00000,0.00000,203),(37,1,1,1111.00000,1111.00000,203),(37,1,2,0.00000,0.00000,203),(37,1,3,0.00000,0.00000,203),(37,1,4,0.00000,0.00000,203),(37,3,1,36.00000,36.00000,203),(37,3,2,0.00000,0.00000,203),(37,3,3,0.00000,0.00000,203),(37,3,4,0.00000,0.00000,203),(37,6,1,283.00000,283.00000,203),(37,6,2,0.00000,0.00000,203),(37,6,3,0.00000,0.00000,203),(37,6,4,0.00000,0.00000,203),(37,7,1,258.00000,258.00000,203),(37,7,2,0.00000,0.00000,203),(37,7,3,0.00000,0.00000,203),(37,7,4,0.00000,0.00000,203),(38,1,1,1111.00000,1111.00000,203),(38,1,2,0.00000,0.00000,203),(38,1,3,0.00000,0.00000,203),(38,1,4,0.00000,0.00000,203),(38,3,1,36.00000,36.00000,203),(38,3,2,0.00000,0.00000,203),(38,3,3,0.00000,0.00000,203),(38,3,4,0.00000,0.00000,203),(38,6,1,283.00000,283.00000,203),(38,6,2,0.00000,0.00000,203),(38,6,3,0.00000,0.00000,203),(38,6,4,0.00000,0.00000,203),(38,7,1,258.00000,258.00000,203),(38,7,2,0.00000,0.00000,203),(38,7,3,0.00000,0.00000,203),(38,7,4,0.00000,0.00000,203),(39,1,1,1111.00000,1111.00000,203),(39,1,2,0.00000,0.00000,203),(39,1,3,0.00000,0.00000,203),(39,1,4,0.00000,0.00000,203),(39,3,1,36.00000,36.00000,203),(39,3,2,0.00000,0.00000,203),(39,3,3,0.00000,0.00000,203),(39,3,4,0.00000,0.00000,203),(39,6,1,283.00000,283.00000,203),(39,6,2,0.00000,0.00000,203),(39,6,3,0.00000,0.00000,203),(39,6,4,0.00000,0.00000,203),(39,7,1,258.00000,258.00000,203),(39,7,2,0.00000,0.00000,203),(39,7,3,0.00000,0.00000,203),(39,7,4,0.00000,0.00000,203),(40,1,1,1111.00000,1111.00000,203),(40,1,2,0.00000,0.00000,203),(40,1,3,0.00000,0.00000,203),(40,1,4,0.00000,0.00000,203),(40,3,1,36.00000,36.00000,203),(40,3,2,0.00000,0.00000,203),(40,3,3,0.00000,0.00000,203),(40,3,4,0.00000,0.00000,203),(40,6,1,283.00000,283.00000,203),(40,6,2,0.00000,0.00000,203),(40,6,3,0.00000,0.00000,203),(40,6,4,0.00000,0.00000,203),(40,7,1,258.00000,258.00000,203),(40,7,2,0.00000,0.00000,203),(40,7,3,0.00000,0.00000,203),(40,7,4,0.00000,0.00000,203),(41,1,1,1111.00000,1111.00000,203),(41,1,2,0.00000,0.00000,203),(41,1,3,0.00000,0.00000,203),(41,1,4,0.00000,0.00000,203),(41,3,1,36.00000,36.00000,203),(41,3,2,0.00000,0.00000,203),(41,3,3,0.00000,0.00000,203),(41,3,4,0.00000,0.00000,203),(41,6,1,283.00000,283.00000,203),(41,6,2,0.00000,0.00000,203),(41,6,3,0.00000,0.00000,203),(41,6,4,0.00000,0.00000,203),(41,7,1,258.00000,258.00000,203),(41,7,2,0.00000,0.00000,203),(41,7,3,0.00000,0.00000,203),(41,7,4,0.00000,0.00000,203),(42,1,1,1111.00000,1111.00000,203),(42,1,2,0.00000,0.00000,203),(42,1,3,0.00000,0.00000,203),(42,1,4,0.00000,0.00000,203),(42,3,1,36.00000,36.00000,203),(42,3,2,0.00000,0.00000,203),(42,3,3,0.00000,0.00000,203),(42,3,4,0.00000,0.00000,203),(42,6,1,283.00000,283.00000,203),(42,6,2,0.00000,0.00000,203),(42,6,3,0.00000,0.00000,203),(42,6,4,0.00000,0.00000,203),(42,7,1,258.00000,258.00000,203),(42,7,2,0.00000,0.00000,203),(42,7,3,0.00000,0.00000,203),(42,7,4,0.00000,0.00000,203),(43,1,1,1111.00000,1111.00000,203),(43,1,2,0.00000,0.00000,203),(43,1,3,0.00000,0.00000,203),(43,1,4,0.00000,0.00000,203),(43,3,1,36.00000,36.00000,203),(43,3,2,0.00000,0.00000,203),(43,3,3,0.00000,0.00000,203),(43,3,4,0.00000,0.00000,203),(43,6,1,283.00000,283.00000,203),(43,6,2,0.00000,0.00000,203),(43,6,3,0.00000,0.00000,203),(43,6,4,0.00000,0.00000,203),(43,7,1,258.00000,258.00000,203),(43,7,2,0.00000,0.00000,203),(43,7,3,0.00000,0.00000,203),(43,7,4,0.00000,0.00000,203),(44,1,1,1111.00000,1111.00000,203),(44,1,2,0.00000,0.00000,203),(44,1,3,0.00000,0.00000,203),(44,1,4,0.00000,0.00000,203),(44,3,1,36.00000,36.00000,203),(44,3,2,0.00000,0.00000,203),(44,3,3,0.00000,0.00000,203),(44,3,4,0.00000,0.00000,203),(44,6,1,283.00000,283.00000,203),(44,6,2,0.00000,0.00000,203),(44,6,3,0.00000,0.00000,203),(44,6,4,0.00000,0.00000,203),(44,7,1,258.00000,258.00000,203),(44,7,2,0.00000,0.00000,203),(44,7,3,0.00000,0.00000,203),(44,7,4,0.00000,0.00000,203),(45,1,1,1111.00000,1111.00000,203),(45,1,2,0.00000,0.00000,203),(45,1,3,0.00000,0.00000,203),(45,1,4,0.00000,0.00000,203),(45,3,1,36.00000,36.00000,203),(45,3,2,0.00000,0.00000,203),(45,3,3,0.00000,0.00000,203),(45,3,4,0.00000,0.00000,203),(45,6,1,283.00000,283.00000,203),(45,6,2,0.00000,0.00000,203),(45,6,3,0.00000,0.00000,203),(45,6,4,0.00000,0.00000,203),(45,7,1,258.00000,258.00000,203),(45,7,2,0.00000,0.00000,203),(45,7,3,0.00000,0.00000,203),(45,7,4,0.00000,0.00000,203),(46,1,1,1111.00000,1111.00000,203),(46,1,2,0.00000,0.00000,203),(46,1,3,0.00000,0.00000,203),(46,1,4,0.00000,0.00000,203),(46,3,1,36.00000,36.00000,203),(46,3,2,0.00000,0.00000,203),(46,3,3,0.00000,0.00000,203),(46,3,4,0.00000,0.00000,203),(46,6,1,283.00000,283.00000,203),(46,6,2,0.00000,0.00000,203),(46,6,3,0.00000,0.00000,203),(46,6,4,0.00000,0.00000,203),(46,7,1,258.00000,258.00000,203),(46,7,2,0.00000,0.00000,203),(46,7,3,0.00000,0.00000,203),(46,7,4,0.00000,0.00000,203),(47,1,1,1111.00000,1111.00000,203),(47,1,2,0.00000,0.00000,203),(47,1,3,0.00000,0.00000,203),(47,1,4,0.00000,0.00000,203),(47,3,1,36.00000,36.00000,203),(47,3,2,0.00000,0.00000,203),(47,3,3,0.00000,0.00000,203),(47,3,4,0.00000,0.00000,203),(47,6,1,283.00000,283.00000,203),(47,6,2,0.00000,0.00000,203),(47,6,3,0.00000,0.00000,203),(47,6,4,0.00000,0.00000,203),(47,7,1,258.00000,258.00000,203),(47,7,2,0.00000,0.00000,203),(47,7,3,0.00000,0.00000,203),(47,7,4,0.00000,0.00000,203),(48,1,1,1111.00000,1111.00000,203),(48,1,2,0.00000,0.00000,203),(48,1,3,0.00000,0.00000,203),(48,1,4,0.00000,0.00000,203),(48,3,1,36.00000,36.00000,203),(48,3,2,0.00000,0.00000,203),(48,3,3,0.00000,0.00000,203),(48,3,4,0.00000,0.00000,203),(48,6,1,283.00000,283.00000,203),(48,6,2,0.00000,0.00000,203),(48,6,3,0.00000,0.00000,203),(48,6,4,0.00000,0.00000,203),(48,7,1,258.00000,258.00000,203),(48,7,2,0.00000,0.00000,203),(48,7,3,0.00000,0.00000,203),(48,7,4,0.00000,0.00000,203),(49,1,1,1111.00000,1111.00000,203),(49,1,2,0.00000,0.00000,203),(49,1,3,0.00000,0.00000,203),(49,1,4,0.00000,0.00000,203),(49,3,1,36.00000,36.00000,203),(49,3,2,0.00000,0.00000,203),(49,3,3,0.00000,0.00000,203),(49,3,4,0.00000,0.00000,203),(49,6,1,283.00000,283.00000,203),(49,6,2,0.00000,0.00000,203),(49,6,3,0.00000,0.00000,203),(49,6,4,0.00000,0.00000,203),(49,7,1,258.00000,258.00000,203),(49,7,2,0.00000,0.00000,203),(49,7,3,0.00000,0.00000,203),(49,7,4,0.00000,0.00000,203),(50,1,1,1111.00000,1111.00000,203),(50,1,2,0.00000,0.00000,203),(50,1,3,0.00000,0.00000,203),(50,1,4,0.00000,0.00000,203),(50,3,1,36.00000,36.00000,203),(50,3,2,0.00000,0.00000,203),(50,3,3,0.00000,0.00000,203),(50,3,4,0.00000,0.00000,203),(50,6,1,283.00000,283.00000,203),(50,6,2,0.00000,0.00000,203),(50,6,3,0.00000,0.00000,203),(50,6,4,0.00000,0.00000,203),(50,7,1,258.00000,258.00000,203),(50,7,2,0.00000,0.00000,203),(50,7,3,0.00000,0.00000,203),(50,7,4,0.00000,0.00000,203),(51,1,1,1111.00000,1111.00000,203),(51,1,2,0.00000,0.00000,203),(51,1,3,0.00000,0.00000,203),(51,1,4,0.00000,0.00000,203),(51,3,1,36.00000,36.00000,203),(51,3,2,0.00000,0.00000,203),(51,3,3,0.00000,0.00000,203),(51,3,4,0.00000,0.00000,203),(51,6,1,283.00000,283.00000,203),(51,6,2,0.00000,0.00000,203),(51,6,3,0.00000,0.00000,203),(51,6,4,0.00000,0.00000,203),(51,7,1,258.00000,258.00000,203),(51,7,2,0.00000,0.00000,203),(51,7,3,0.00000,0.00000,203),(51,7,4,0.00000,0.00000,203),(52,1,1,1111.00000,1111.00000,203),(52,1,2,0.00000,0.00000,203),(52,1,3,0.00000,0.00000,203),(52,1,4,0.00000,0.00000,203),(52,3,1,36.00000,36.00000,203),(52,3,2,0.00000,0.00000,203),(52,3,3,0.00000,0.00000,203),(52,3,4,0.00000,0.00000,203),(52,6,1,283.00000,283.00000,203),(52,6,2,0.00000,0.00000,203),(52,6,3,0.00000,0.00000,203),(52,6,4,0.00000,0.00000,203),(52,7,1,258.00000,258.00000,203),(52,7,2,0.00000,0.00000,203),(52,7,3,0.00000,0.00000,203),(52,7,4,0.00000,0.00000,203),(53,1,1,1111.00000,1111.00000,203),(53,1,2,0.00000,0.00000,203),(53,1,3,0.00000,0.00000,203),(53,1,4,0.00000,0.00000,203),(53,3,1,36.00000,36.00000,203),(53,3,2,0.00000,0.00000,203),(53,3,3,0.00000,0.00000,203),(53,3,4,0.00000,0.00000,203),(53,6,1,283.00000,283.00000,203),(53,6,2,0.00000,0.00000,203),(53,6,3,0.00000,0.00000,203),(53,6,4,0.00000,0.00000,203),(53,7,1,258.00000,258.00000,203),(53,7,2,0.00000,0.00000,203),(53,7,3,0.00000,0.00000,203),(53,7,4,0.00000,0.00000,203),(54,1,1,1111.00000,1111.00000,203),(54,1,2,0.00000,0.00000,203),(54,1,3,0.00000,0.00000,203),(54,1,4,0.00000,0.00000,203),(54,3,1,36.00000,36.00000,203),(54,3,2,0.00000,0.00000,203),(54,3,3,0.00000,0.00000,203),(54,3,4,0.00000,0.00000,203),(54,6,1,283.00000,283.00000,203),(54,6,2,0.00000,0.00000,203),(54,6,3,0.00000,0.00000,203),(54,6,4,0.00000,0.00000,203),(54,7,1,258.00000,258.00000,203),(54,7,2,0.00000,0.00000,203),(54,7,3,0.00000,0.00000,203),(54,7,4,0.00000,0.00000,203),(55,1,1,1111.00000,1111.00000,203),(55,1,2,0.00000,0.00000,203),(55,1,3,0.00000,0.00000,203),(55,1,4,0.00000,0.00000,203),(55,3,1,36.00000,36.00000,203),(55,3,2,0.00000,0.00000,203),(55,3,3,0.00000,0.00000,203),(55,3,4,0.00000,0.00000,203),(55,6,1,283.00000,283.00000,203),(55,6,2,0.00000,0.00000,203),(55,6,3,0.00000,0.00000,203),(55,6,4,0.00000,0.00000,203),(55,7,1,258.00000,258.00000,203),(55,7,2,0.00000,0.00000,203),(55,7,3,0.00000,0.00000,203),(55,7,4,0.00000,0.00000,203),(56,1,1,1111.00000,1111.00000,203),(56,1,2,0.00000,0.00000,203),(56,1,3,0.00000,0.00000,203),(56,1,4,0.00000,0.00000,203),(56,3,1,36.00000,36.00000,203),(56,3,2,0.00000,0.00000,203),(56,3,3,0.00000,0.00000,203),(56,3,4,0.00000,0.00000,203),(56,6,1,283.00000,283.00000,203),(56,6,2,0.00000,0.00000,203),(56,6,3,0.00000,0.00000,203),(56,6,4,0.00000,0.00000,203),(56,7,1,258.00000,258.00000,203),(56,7,2,0.00000,0.00000,203),(56,7,3,0.00000,0.00000,203),(56,7,4,0.00000,0.00000,203),(57,1,1,1111.00000,1111.00000,203),(57,1,2,0.00000,0.00000,203),(57,1,3,0.00000,0.00000,203),(57,1,4,0.00000,0.00000,203),(57,3,1,36.00000,36.00000,203),(57,3,2,0.00000,0.00000,203),(57,3,3,0.00000,0.00000,203),(57,3,4,0.00000,0.00000,203),(57,6,1,283.00000,283.00000,203),(57,6,2,0.00000,0.00000,203),(57,6,3,0.00000,0.00000,203),(57,6,4,0.00000,0.00000,203),(57,7,1,258.00000,258.00000,203),(57,7,2,0.00000,0.00000,203),(57,7,3,0.00000,0.00000,203),(57,7,4,0.00000,0.00000,203),(58,1,1,1111.00000,1111.00000,203),(58,1,2,0.00000,0.00000,203),(58,1,3,0.00000,0.00000,203),(58,1,4,0.00000,0.00000,203),(58,3,1,36.00000,36.00000,203),(58,3,2,0.00000,0.00000,203),(58,3,3,0.00000,0.00000,203),(58,3,4,0.00000,0.00000,203),(58,6,1,283.00000,283.00000,203),(58,6,2,0.00000,0.00000,203),(58,6,3,0.00000,0.00000,203),(58,6,4,0.00000,0.00000,203),(58,7,1,258.00000,258.00000,203),(58,7,2,0.00000,0.00000,203),(58,7,3,0.00000,0.00000,203),(58,7,4,0.00000,0.00000,203),(59,1,1,1111.00000,1111.00000,203),(59,1,2,0.00000,0.00000,203),(59,1,3,0.00000,0.00000,203),(59,1,4,0.00000,0.00000,203),(59,3,1,36.00000,36.00000,203),(59,3,2,0.00000,0.00000,203),(59,3,3,0.00000,0.00000,203),(59,3,4,0.00000,0.00000,203),(59,6,1,283.00000,283.00000,203),(59,6,2,0.00000,0.00000,203),(59,6,3,0.00000,0.00000,203),(59,6,4,0.00000,0.00000,203),(59,7,1,258.00000,258.00000,203),(59,7,2,0.00000,0.00000,203),(59,7,3,0.00000,0.00000,203),(59,7,4,0.00000,0.00000,203),(60,1,1,1111.00000,1111.00000,203),(60,1,2,0.00000,0.00000,203),(60,1,3,0.00000,0.00000,203),(60,1,4,0.00000,0.00000,203),(60,3,1,36.00000,36.00000,203),(60,3,2,0.00000,0.00000,203),(60,3,3,0.00000,0.00000,203),(60,3,4,0.00000,0.00000,203),(60,6,1,283.00000,283.00000,203),(60,6,2,0.00000,0.00000,203),(60,6,3,0.00000,0.00000,203),(60,6,4,0.00000,0.00000,203),(60,7,1,258.00000,258.00000,203),(60,7,2,0.00000,0.00000,203),(60,7,3,0.00000,0.00000,203),(60,7,4,0.00000,0.00000,203),(61,1,1,1111.00000,1111.00000,203),(61,1,2,0.00000,0.00000,203),(61,1,3,0.00000,0.00000,203),(61,1,4,0.00000,0.00000,203),(61,3,1,36.00000,36.00000,203),(61,3,2,0.00000,0.00000,203),(61,3,3,0.00000,0.00000,203),(61,3,4,0.00000,0.00000,203),(61,6,1,283.00000,283.00000,203),(61,6,2,0.00000,0.00000,203),(61,6,3,0.00000,0.00000,203),(61,6,4,0.00000,0.00000,203),(61,7,1,258.00000,258.00000,203),(61,7,2,0.00000,0.00000,203),(61,7,3,0.00000,0.00000,203),(61,7,4,0.00000,0.00000,203),(62,1,1,1111.00000,1111.00000,203),(62,1,2,0.00000,0.00000,203),(62,1,3,0.00000,0.00000,203),(62,1,4,0.00000,0.00000,203),(62,3,1,36.00000,36.00000,203),(62,3,2,0.00000,0.00000,203),(62,3,3,0.00000,0.00000,203),(62,3,4,0.00000,0.00000,203),(62,6,1,283.00000,283.00000,203),(62,6,2,0.00000,0.00000,203),(62,6,3,0.00000,0.00000,203),(62,6,4,0.00000,0.00000,203),(62,7,1,258.00000,258.00000,203),(62,7,2,0.00000,0.00000,203),(62,7,3,0.00000,0.00000,203),(62,7,4,0.00000,0.00000,203),(63,1,1,1111.00000,1111.00000,203),(63,1,2,0.00000,0.00000,203),(63,1,3,0.00000,0.00000,203),(63,1,4,0.00000,0.00000,203),(63,3,1,36.00000,36.00000,203),(63,3,2,0.00000,0.00000,203),(63,3,3,0.00000,0.00000,203),(63,3,4,0.00000,0.00000,203),(63,6,1,283.00000,283.00000,203),(63,6,2,0.00000,0.00000,203),(63,6,3,0.00000,0.00000,203),(63,6,4,0.00000,0.00000,203),(63,7,1,258.00000,258.00000,203),(63,7,2,0.00000,0.00000,203),(63,7,3,0.00000,0.00000,203),(63,7,4,0.00000,0.00000,203),(64,1,1,1111.00000,1111.00000,203),(64,1,2,0.00000,0.00000,203),(64,1,3,0.00000,0.00000,203),(64,1,4,0.00000,0.00000,203),(64,3,1,36.00000,36.00000,203),(64,3,2,0.00000,0.00000,203),(64,3,3,0.00000,0.00000,203),(64,3,4,0.00000,0.00000,203),(64,6,1,283.00000,283.00000,203),(64,6,2,0.00000,0.00000,203),(64,6,3,0.00000,0.00000,203),(64,6,4,0.00000,0.00000,203),(64,7,1,258.00000,258.00000,203),(64,7,2,0.00000,0.00000,203),(64,7,3,0.00000,0.00000,203),(64,7,4,0.00000,0.00000,203),(65,1,1,1799.00000,1799.00000,203),(65,1,2,0.00000,0.00000,203),(65,1,3,0.00000,0.00000,203),(65,1,4,0.00000,0.00000,203),(65,3,1,58.00000,58.00000,203),(65,3,2,0.00000,0.00000,203),(65,3,3,0.00000,0.00000,203),(65,3,4,0.00000,0.00000,203),(65,6,1,459.00000,459.00000,203),(65,6,2,0.00000,0.00000,203),(65,6,3,0.00000,0.00000,203),(65,6,4,0.00000,0.00000,203),(65,7,1,418.00000,418.00000,203),(65,7,2,0.00000,0.00000,203),(65,7,3,0.00000,0.00000,203),(65,7,4,0.00000,0.00000,203),(66,1,1,1799.00000,1799.00000,203),(66,1,2,0.00000,0.00000,203),(66,1,3,0.00000,0.00000,203),(66,1,4,0.00000,0.00000,203),(66,3,1,58.00000,58.00000,203),(66,3,2,0.00000,0.00000,203),(66,3,3,0.00000,0.00000,203),(66,3,4,0.00000,0.00000,203),(66,6,1,459.00000,459.00000,203),(66,6,2,0.00000,0.00000,203),(66,6,3,0.00000,0.00000,203),(66,6,4,0.00000,0.00000,203),(66,7,1,418.00000,418.00000,203),(66,7,2,0.00000,0.00000,203),(66,7,3,0.00000,0.00000,203),(66,7,4,0.00000,0.00000,203),(67,1,1,1799.00000,1799.00000,203),(67,1,2,0.00000,0.00000,203),(67,1,3,0.00000,0.00000,203),(67,1,4,0.00000,0.00000,203),(67,3,1,58.00000,58.00000,203),(67,3,2,0.00000,0.00000,203),(67,3,3,0.00000,0.00000,203),(67,3,4,0.00000,0.00000,203),(67,6,1,459.00000,459.00000,203),(67,6,2,0.00000,0.00000,203),(67,6,3,0.00000,0.00000,203),(67,6,4,0.00000,0.00000,203),(67,7,1,418.00000,418.00000,203),(67,7,2,0.00000,0.00000,203),(67,7,3,0.00000,0.00000,203),(67,7,4,0.00000,0.00000,203),(68,1,1,1799.00000,1799.00000,203),(68,1,2,0.00000,0.00000,203),(68,1,3,0.00000,0.00000,203),(68,1,4,0.00000,0.00000,203),(68,3,1,58.00000,58.00000,203),(68,3,2,0.00000,0.00000,203),(68,3,3,0.00000,0.00000,203),(68,3,4,0.00000,0.00000,203),(68,6,1,459.00000,459.00000,203),(68,6,2,0.00000,0.00000,203),(68,6,3,0.00000,0.00000,203),(68,6,4,0.00000,0.00000,203),(68,7,1,418.00000,418.00000,203),(68,7,2,0.00000,0.00000,203),(68,7,3,0.00000,0.00000,203),(68,7,4,0.00000,0.00000,203),(69,1,1,1799.00000,1799.00000,203),(69,1,2,0.00000,0.00000,203),(69,1,3,0.00000,0.00000,203),(69,1,4,0.00000,0.00000,203),(69,3,1,58.00000,58.00000,203),(69,3,2,0.00000,0.00000,203),(69,3,3,0.00000,0.00000,203),(69,3,4,0.00000,0.00000,203),(69,6,1,459.00000,459.00000,203),(69,6,2,0.00000,0.00000,203),(69,6,3,0.00000,0.00000,203),(69,6,4,0.00000,0.00000,203),(69,7,1,418.00000,418.00000,203),(69,7,2,0.00000,0.00000,203),(69,7,3,0.00000,0.00000,203),(69,7,4,0.00000,0.00000,203),(70,1,1,1799.00000,1799.00000,203),(70,1,2,0.00000,0.00000,203),(70,1,3,0.00000,0.00000,203),(70,1,4,0.00000,0.00000,203),(70,3,1,58.00000,58.00000,203),(70,3,2,0.00000,0.00000,203),(70,3,3,0.00000,0.00000,203),(70,3,4,0.00000,0.00000,203),(70,6,1,459.00000,459.00000,203),(70,6,2,0.00000,0.00000,203),(70,6,3,0.00000,0.00000,203),(70,6,4,0.00000,0.00000,203),(70,7,1,418.00000,418.00000,203),(70,7,2,0.00000,0.00000,203),(70,7,3,0.00000,0.00000,203),(70,7,4,0.00000,0.00000,203),(71,1,1,1799.00000,1799.00000,203),(71,1,2,0.00000,0.00000,203),(71,1,3,0.00000,0.00000,203),(71,1,4,0.00000,0.00000,203),(71,3,1,58.00000,58.00000,203),(71,3,2,0.00000,0.00000,203),(71,3,3,0.00000,0.00000,203),(71,3,4,0.00000,0.00000,203),(71,6,1,459.00000,459.00000,203),(71,6,2,0.00000,0.00000,203),(71,6,3,0.00000,0.00000,203),(71,6,4,0.00000,0.00000,203),(71,7,1,418.00000,418.00000,203),(71,7,2,0.00000,0.00000,203),(71,7,3,0.00000,0.00000,203),(71,7,4,0.00000,0.00000,203),(72,1,1,1799.00000,1799.00000,203),(72,1,2,0.00000,0.00000,203),(72,1,3,0.00000,0.00000,203),(72,1,4,0.00000,0.00000,203),(72,3,1,58.00000,58.00000,203),(72,3,2,0.00000,0.00000,203),(72,3,3,0.00000,0.00000,203),(72,3,4,0.00000,0.00000,203),(72,6,1,459.00000,459.00000,203),(72,6,2,0.00000,0.00000,203),(72,6,3,0.00000,0.00000,203),(72,6,4,0.00000,0.00000,203),(72,7,1,418.00000,418.00000,203),(72,7,2,0.00000,0.00000,203),(72,7,3,0.00000,0.00000,203),(72,7,4,0.00000,0.00000,203),(73,1,1,1799.00000,1799.00000,203),(73,1,2,0.00000,0.00000,203),(73,1,3,0.00000,0.00000,203),(73,1,4,0.00000,0.00000,203),(73,3,1,58.00000,58.00000,203),(73,3,2,0.00000,0.00000,203),(73,3,3,0.00000,0.00000,203),(73,3,4,0.00000,0.00000,203),(73,6,1,459.00000,459.00000,203),(73,6,2,0.00000,0.00000,203),(73,6,3,0.00000,0.00000,203),(73,6,4,0.00000,0.00000,203),(73,7,1,418.00000,418.00000,203),(73,7,2,0.00000,0.00000,203),(73,7,3,0.00000,0.00000,203),(73,7,4,0.00000,0.00000,203),(74,1,1,1799.00000,1799.00000,203),(74,1,2,0.00000,0.00000,203),(74,1,3,0.00000,0.00000,203),(74,1,4,0.00000,0.00000,203),(74,3,1,58.00000,58.00000,203),(74,3,2,0.00000,0.00000,203),(74,3,3,0.00000,0.00000,203),(74,3,4,0.00000,0.00000,203),(74,6,1,459.00000,459.00000,203),(74,6,2,0.00000,0.00000,203),(74,6,3,0.00000,0.00000,203),(74,6,4,0.00000,0.00000,203),(74,7,1,418.00000,418.00000,203),(74,7,2,0.00000,0.00000,203),(74,7,3,0.00000,0.00000,203),(74,7,4,0.00000,0.00000,203),(75,1,1,1799.00000,1799.00000,203),(75,1,2,0.00000,0.00000,203),(75,1,3,0.00000,0.00000,203),(75,1,4,0.00000,0.00000,203),(75,3,1,58.00000,58.00000,203),(75,3,2,0.00000,0.00000,203),(75,3,3,0.00000,0.00000,203),(75,3,4,0.00000,0.00000,203),(75,6,1,459.00000,459.00000,203),(75,6,2,0.00000,0.00000,203),(75,6,3,0.00000,0.00000,203),(75,6,4,0.00000,0.00000,203),(75,7,1,418.00000,418.00000,203),(75,7,2,0.00000,0.00000,203),(75,7,3,0.00000,0.00000,203),(75,7,4,0.00000,0.00000,203),(76,1,1,1799.00000,1799.00000,203),(76,1,2,0.00000,0.00000,203),(76,1,3,0.00000,0.00000,203),(76,1,4,0.00000,0.00000,203),(76,3,1,58.00000,58.00000,203),(76,3,2,0.00000,0.00000,203),(76,3,3,0.00000,0.00000,203),(76,3,4,0.00000,0.00000,203),(76,6,1,459.00000,459.00000,203),(76,6,2,0.00000,0.00000,203),(76,6,3,0.00000,0.00000,203),(76,6,4,0.00000,0.00000,203),(76,7,1,418.00000,418.00000,203),(76,7,2,0.00000,0.00000,203),(76,7,3,0.00000,0.00000,203),(76,7,4,0.00000,0.00000,203),(77,1,1,1799.00000,1799.00000,203),(77,1,2,0.00000,0.00000,203),(77,1,3,0.00000,0.00000,203),(77,1,4,0.00000,0.00000,203),(77,3,1,58.00000,58.00000,203),(77,3,2,0.00000,0.00000,203),(77,3,3,0.00000,0.00000,203),(77,3,4,0.00000,0.00000,203),(77,6,1,459.00000,459.00000,203),(77,6,2,0.00000,0.00000,203),(77,6,3,0.00000,0.00000,203),(77,6,4,0.00000,0.00000,203),(77,7,1,418.00000,418.00000,203),(77,7,2,0.00000,0.00000,203),(77,7,3,0.00000,0.00000,203),(77,7,4,0.00000,0.00000,203),(78,1,1,1799.00000,1799.00000,203),(78,1,2,0.00000,0.00000,203),(78,1,3,0.00000,0.00000,203),(78,1,4,0.00000,0.00000,203),(78,3,1,58.00000,58.00000,203),(78,3,2,0.00000,0.00000,203),(78,3,3,0.00000,0.00000,203),(78,3,4,0.00000,0.00000,203),(78,6,1,459.00000,459.00000,203),(78,6,2,0.00000,0.00000,203),(78,6,3,0.00000,0.00000,203),(78,6,4,0.00000,0.00000,203),(78,7,1,418.00000,418.00000,203),(78,7,2,0.00000,0.00000,203),(78,7,3,0.00000,0.00000,203),(78,7,4,0.00000,0.00000,203),(79,1,1,1799.00000,1799.00000,203),(79,1,2,0.00000,0.00000,203),(79,1,3,0.00000,0.00000,203),(79,1,4,0.00000,0.00000,203),(79,3,1,58.00000,58.00000,203),(79,3,2,0.00000,0.00000,203),(79,3,3,0.00000,0.00000,203),(79,3,4,0.00000,0.00000,203),(79,6,1,459.00000,459.00000,203),(79,6,2,0.00000,0.00000,203),(79,6,3,0.00000,0.00000,203),(79,6,4,0.00000,0.00000,203),(79,7,1,418.00000,418.00000,203),(79,7,2,0.00000,0.00000,203),(79,7,3,0.00000,0.00000,203),(79,7,4,0.00000,0.00000,203),(80,1,1,1799.00000,1799.00000,203),(80,1,2,0.00000,0.00000,203),(80,1,3,0.00000,0.00000,203),(80,1,4,0.00000,0.00000,203),(80,3,1,58.00000,58.00000,203),(80,3,2,0.00000,0.00000,203),(80,3,3,0.00000,0.00000,203),(80,3,4,0.00000,0.00000,203),(80,6,1,459.00000,459.00000,203),(80,6,2,0.00000,0.00000,203),(80,6,3,0.00000,0.00000,203),(80,6,4,0.00000,0.00000,203),(80,7,1,418.00000,418.00000,203),(80,7,2,0.00000,0.00000,203),(80,7,3,0.00000,0.00000,203),(80,7,4,0.00000,0.00000,203),(81,1,1,1799.00000,1799.00000,203),(81,1,2,0.00000,0.00000,203),(81,1,3,0.00000,0.00000,203),(81,1,4,0.00000,0.00000,203),(81,3,1,58.00000,58.00000,203),(81,3,2,0.00000,0.00000,203),(81,3,3,0.00000,0.00000,203),(81,3,4,0.00000,0.00000,203),(81,6,1,459.00000,459.00000,203),(81,6,2,0.00000,0.00000,203),(81,6,3,0.00000,0.00000,203),(81,6,4,0.00000,0.00000,203),(81,7,1,418.00000,418.00000,203),(81,7,2,0.00000,0.00000,203),(81,7,3,0.00000,0.00000,203),(81,7,4,0.00000,0.00000,203),(82,1,1,1799.00000,1799.00000,203),(82,1,2,0.00000,0.00000,203),(82,1,3,0.00000,0.00000,203),(82,1,4,0.00000,0.00000,203),(82,3,1,58.00000,58.00000,203),(82,3,2,0.00000,0.00000,203),(82,3,3,0.00000,0.00000,203),(82,3,4,0.00000,0.00000,203),(82,6,1,459.00000,459.00000,203),(82,6,2,0.00000,0.00000,203),(82,6,3,0.00000,0.00000,203),(82,6,4,0.00000,0.00000,203),(82,7,1,418.00000,418.00000,203),(82,7,2,0.00000,0.00000,203),(82,7,3,0.00000,0.00000,203),(82,7,4,0.00000,0.00000,203),(83,1,1,1799.00000,1799.00000,203),(83,1,2,0.00000,0.00000,203),(83,1,3,0.00000,0.00000,203),(83,1,4,0.00000,0.00000,203),(83,3,1,58.00000,58.00000,203),(83,3,2,0.00000,0.00000,203),(83,3,3,0.00000,0.00000,203),(83,3,4,0.00000,0.00000,203),(83,6,1,459.00000,459.00000,203),(83,6,2,0.00000,0.00000,203),(83,6,3,0.00000,0.00000,203),(83,6,4,0.00000,0.00000,203),(83,7,1,418.00000,418.00000,203),(83,7,2,0.00000,0.00000,203),(83,7,3,0.00000,0.00000,203),(83,7,4,0.00000,0.00000,203),(84,1,1,1799.00000,1799.00000,203),(84,1,2,0.00000,0.00000,203),(84,1,3,0.00000,0.00000,203),(84,1,4,0.00000,0.00000,203),(84,3,1,58.00000,58.00000,203),(84,3,2,0.00000,0.00000,203),(84,3,3,0.00000,0.00000,203),(84,3,4,0.00000,0.00000,203),(84,6,1,459.00000,459.00000,203),(84,6,2,0.00000,0.00000,203),(84,6,3,0.00000,0.00000,203),(84,6,4,0.00000,0.00000,203),(84,7,1,418.00000,418.00000,203),(84,7,2,0.00000,0.00000,203),(84,7,3,0.00000,0.00000,203),(84,7,4,0.00000,0.00000,203),(85,1,1,1799.00000,1799.00000,203),(85,1,2,0.00000,0.00000,203),(85,1,3,0.00000,0.00000,203),(85,1,4,0.00000,0.00000,203),(85,3,1,58.00000,58.00000,203),(85,3,2,0.00000,0.00000,203),(85,3,3,0.00000,0.00000,203),(85,3,4,0.00000,0.00000,203),(85,6,1,459.00000,459.00000,203),(85,6,2,0.00000,0.00000,203),(85,6,3,0.00000,0.00000,203),(85,6,4,0.00000,0.00000,203),(85,7,1,418.00000,418.00000,203),(85,7,2,0.00000,0.00000,203),(85,7,3,0.00000,0.00000,203),(85,7,4,0.00000,0.00000,203),(86,1,1,1799.00000,1799.00000,203),(86,1,2,0.00000,0.00000,203),(86,1,3,0.00000,0.00000,203),(86,1,4,0.00000,0.00000,203),(86,3,1,58.00000,58.00000,203),(86,3,2,0.00000,0.00000,203),(86,3,3,0.00000,0.00000,203),(86,3,4,0.00000,0.00000,203),(86,6,1,459.00000,459.00000,203),(86,6,2,0.00000,0.00000,203),(86,6,3,0.00000,0.00000,203),(86,6,4,0.00000,0.00000,203),(86,7,1,418.00000,418.00000,203),(86,7,2,0.00000,0.00000,203),(86,7,3,0.00000,0.00000,203),(86,7,4,0.00000,0.00000,203),(87,1,1,1799.00000,1799.00000,203),(87,1,2,0.00000,0.00000,203),(87,1,3,0.00000,0.00000,203),(87,1,4,0.00000,0.00000,203),(87,3,1,58.00000,58.00000,203),(87,3,2,0.00000,0.00000,203),(87,3,3,0.00000,0.00000,203),(87,3,4,0.00000,0.00000,203),(87,6,1,459.00000,459.00000,203),(87,6,2,0.00000,0.00000,203),(87,6,3,0.00000,0.00000,203),(87,6,4,0.00000,0.00000,203),(87,7,1,418.00000,418.00000,203),(87,7,2,0.00000,0.00000,203),(87,7,3,0.00000,0.00000,203),(87,7,4,0.00000,0.00000,203),(88,1,1,1989.00000,1989.00000,203),(88,1,2,0.00000,0.00000,203),(88,1,3,0.00000,0.00000,203),(88,1,4,0.00000,0.00000,203),(88,3,1,65.00000,65.00000,203),(88,3,2,0.00000,0.00000,203),(88,3,3,0.00000,0.00000,203),(88,3,4,0.00000,0.00000,203),(88,6,1,507.00000,507.00000,203),(88,6,2,0.00000,0.00000,203),(88,6,3,0.00000,0.00000,203),(88,6,4,0.00000,0.00000,203),(88,7,1,462.00000,462.00000,203),(88,7,2,0.00000,0.00000,203),(88,7,3,0.00000,0.00000,203),(88,7,4,0.00000,0.00000,203),(89,1,1,1989.00000,1989.00000,203),(89,1,2,0.00000,0.00000,203),(89,1,3,0.00000,0.00000,203),(89,1,4,0.00000,0.00000,203),(89,3,1,65.00000,65.00000,203),(89,3,2,0.00000,0.00000,203),(89,3,3,0.00000,0.00000,203),(89,3,4,0.00000,0.00000,203),(89,6,1,507.00000,507.00000,203),(89,6,2,0.00000,0.00000,203),(89,6,3,0.00000,0.00000,203),(89,6,4,0.00000,0.00000,203),(89,7,1,462.00000,462.00000,203),(89,7,2,0.00000,0.00000,203),(89,7,3,0.00000,0.00000,203),(89,7,4,0.00000,0.00000,203),(90,1,1,1989.00000,1989.00000,203),(90,1,2,0.00000,0.00000,203),(90,1,3,0.00000,0.00000,203),(90,1,4,0.00000,0.00000,203),(90,3,1,65.00000,65.00000,203),(90,3,2,0.00000,0.00000,203),(90,3,3,0.00000,0.00000,203),(90,3,4,0.00000,0.00000,203),(90,6,1,507.00000,507.00000,203),(90,6,2,0.00000,0.00000,203),(90,6,3,0.00000,0.00000,203),(90,6,4,0.00000,0.00000,203),(90,7,1,462.00000,462.00000,203),(90,7,2,0.00000,0.00000,203),(90,7,3,0.00000,0.00000,203),(90,7,4,0.00000,0.00000,203),(91,1,1,1989.00000,1989.00000,203),(91,1,2,0.00000,0.00000,203),(91,1,3,0.00000,0.00000,203),(91,1,4,0.00000,0.00000,203),(91,3,1,65.00000,65.00000,203),(91,3,2,0.00000,0.00000,203),(91,3,3,0.00000,0.00000,203),(91,3,4,0.00000,0.00000,203),(91,6,1,507.00000,507.00000,203),(91,6,2,0.00000,0.00000,203),(91,6,3,0.00000,0.00000,203),(91,6,4,0.00000,0.00000,203),(91,7,1,462.00000,462.00000,203),(91,7,2,0.00000,0.00000,203),(91,7,3,0.00000,0.00000,203),(91,7,4,0.00000,0.00000,203),(92,1,1,1989.00000,1989.00000,203),(92,1,2,0.00000,0.00000,203),(92,1,3,0.00000,0.00000,203),(92,1,4,0.00000,0.00000,203),(92,3,1,65.00000,65.00000,203),(92,3,2,0.00000,0.00000,203),(92,3,3,0.00000,0.00000,203),(92,3,4,0.00000,0.00000,203),(92,6,1,507.00000,507.00000,203),(92,6,2,0.00000,0.00000,203),(92,6,3,0.00000,0.00000,203),(92,6,4,0.00000,0.00000,203),(92,7,1,462.00000,462.00000,203),(92,7,2,0.00000,0.00000,203),(92,7,3,0.00000,0.00000,203),(92,7,4,0.00000,0.00000,203),(93,1,1,1989.00000,1989.00000,203),(93,1,2,0.00000,0.00000,203),(93,1,3,0.00000,0.00000,203),(93,1,4,0.00000,0.00000,203),(93,3,1,65.00000,65.00000,203),(93,3,2,0.00000,0.00000,203),(93,3,3,0.00000,0.00000,203),(93,3,4,0.00000,0.00000,203),(93,6,1,507.00000,507.00000,203),(93,6,2,0.00000,0.00000,203),(93,6,3,0.00000,0.00000,203),(93,6,4,0.00000,0.00000,203),(93,7,1,462.00000,462.00000,203),(93,7,2,0.00000,0.00000,203),(93,7,3,0.00000,0.00000,203),(93,7,4,0.00000,0.00000,203),(94,1,1,1989.00000,1989.00000,203),(94,1,2,0.00000,0.00000,203),(94,1,3,0.00000,0.00000,203),(94,1,4,0.00000,0.00000,203),(94,3,1,65.00000,65.00000,203),(94,3,2,0.00000,0.00000,203),(94,3,3,0.00000,0.00000,203),(94,3,4,0.00000,0.00000,203),(94,6,1,507.00000,507.00000,203),(94,6,2,0.00000,0.00000,203),(94,6,3,0.00000,0.00000,203),(94,6,4,0.00000,0.00000,203),(94,7,1,462.00000,462.00000,203),(94,7,2,0.00000,0.00000,203),(94,7,3,0.00000,0.00000,203),(94,7,4,0.00000,0.00000,203),(95,1,1,1989.00000,1989.00000,203),(95,1,2,0.00000,0.00000,203),(95,1,3,0.00000,0.00000,203),(95,1,4,0.00000,0.00000,203),(95,3,1,65.00000,65.00000,203),(95,3,2,0.00000,0.00000,203),(95,3,3,0.00000,0.00000,203),(95,3,4,0.00000,0.00000,203),(95,6,1,507.00000,507.00000,203),(95,6,2,0.00000,0.00000,203),(95,6,3,0.00000,0.00000,203),(95,6,4,0.00000,0.00000,203),(95,7,1,462.00000,462.00000,203),(95,7,2,0.00000,0.00000,203),(95,7,3,0.00000,0.00000,203),(95,7,4,0.00000,0.00000,203),(96,1,1,1989.00000,1989.00000,203),(96,1,2,0.00000,0.00000,203),(96,1,3,0.00000,0.00000,203),(96,1,4,0.00000,0.00000,203),(96,3,1,65.00000,65.00000,203),(96,3,2,0.00000,0.00000,203),(96,3,3,0.00000,0.00000,203),(96,3,4,0.00000,0.00000,203),(96,6,1,507.00000,507.00000,203),(96,6,2,0.00000,0.00000,203),(96,6,3,0.00000,0.00000,203),(96,6,4,0.00000,0.00000,203),(96,7,1,462.00000,462.00000,203),(96,7,2,0.00000,0.00000,203),(96,7,3,0.00000,0.00000,203),(96,7,4,0.00000,0.00000,203),(97,1,1,1989.00000,1989.00000,203),(97,1,2,0.00000,0.00000,203),(97,1,3,0.00000,0.00000,203),(97,1,4,0.00000,0.00000,203),(97,3,1,65.00000,65.00000,203),(97,3,2,0.00000,0.00000,203),(97,3,3,0.00000,0.00000,203),(97,3,4,0.00000,0.00000,203),(97,6,1,507.00000,507.00000,203),(97,6,2,0.00000,0.00000,203),(97,6,3,0.00000,0.00000,203),(97,6,4,0.00000,0.00000,203),(97,7,1,462.00000,462.00000,203),(97,7,2,0.00000,0.00000,203),(97,7,3,0.00000,0.00000,203),(97,7,4,0.00000,0.00000,203),(98,1,1,1989.00000,1989.00000,203),(98,1,2,0.00000,0.00000,203),(98,1,3,0.00000,0.00000,203),(98,1,4,0.00000,0.00000,203),(98,3,1,65.00000,65.00000,203),(98,3,2,0.00000,0.00000,203),(98,3,3,0.00000,0.00000,203),(98,3,4,0.00000,0.00000,203),(98,6,1,507.00000,507.00000,203),(98,6,2,0.00000,0.00000,203),(98,6,3,0.00000,0.00000,203),(98,6,4,0.00000,0.00000,203),(98,7,1,462.00000,462.00000,203),(98,7,2,0.00000,0.00000,203),(98,7,3,0.00000,0.00000,203),(98,7,4,0.00000,0.00000,203),(99,1,1,1989.00000,1989.00000,203),(99,1,2,0.00000,0.00000,203),(99,1,3,0.00000,0.00000,203),(99,1,4,0.00000,0.00000,203),(99,3,1,65.00000,65.00000,203),(99,3,2,0.00000,0.00000,203),(99,3,3,0.00000,0.00000,203),(99,3,4,0.00000,0.00000,203),(99,6,1,507.00000,507.00000,203),(99,6,2,0.00000,0.00000,203),(99,6,3,0.00000,0.00000,203),(99,6,4,0.00000,0.00000,203),(99,7,1,462.00000,462.00000,203),(99,7,2,0.00000,0.00000,203),(99,7,3,0.00000,0.00000,203),(99,7,4,0.00000,0.00000,203),(100,1,1,1190.00000,1190.00000,203),(100,1,2,0.00000,0.00000,203),(100,1,3,0.00000,0.00000,203),(100,1,4,0.00000,0.00000,203),(100,3,1,39.00000,39.00000,203),(100,3,2,0.00000,0.00000,203),(100,3,3,0.00000,0.00000,203),(100,3,4,0.00000,0.00000,203),(100,6,1,304.00000,304.00000,203),(100,6,2,0.00000,0.00000,203),(100,6,3,0.00000,0.00000,203),(100,6,4,0.00000,0.00000,203),(100,7,1,276.00000,276.00000,203),(100,7,2,0.00000,0.00000,203),(100,7,3,0.00000,0.00000,203),(100,7,4,0.00000,0.00000,203),(101,1,1,1200.00000,1200.00000,203),(101,1,2,0.00000,0.00000,203),(101,1,3,0.00000,0.00000,203),(101,1,4,0.00000,0.00000,203),(101,3,1,39.00000,39.00000,203),(101,3,2,0.00000,0.00000,203),(101,3,3,0.00000,0.00000,203),(101,3,4,0.00000,0.00000,203),(101,6,1,306.00000,306.00000,203),(101,6,2,0.00000,0.00000,203),(101,6,3,0.00000,0.00000,203),(101,6,4,0.00000,0.00000,203),(101,7,1,279.00000,279.00000,203),(101,7,2,0.00000,0.00000,203),(101,7,3,0.00000,0.00000,203),(101,7,4,0.00000,0.00000,203),(102,1,1,260.00000,260.00000,203),(102,1,2,0.00000,0.00000,203),(102,1,3,0.00000,0.00000,203),(102,1,4,0.00000,0.00000,203),(102,3,1,8.00000,8.00000,203),(102,3,2,0.00000,0.00000,203),(102,3,3,0.00000,0.00000,203),(102,3,4,0.00000,0.00000,203),(102,6,1,66.00000,66.00000,203),(102,6,2,0.00000,0.00000,203),(102,6,3,0.00000,0.00000,203),(102,6,4,0.00000,0.00000,203),(102,7,1,60.00000,60.00000,203),(102,7,2,0.00000,0.00000,203),(102,7,3,0.00000,0.00000,203),(102,7,4,0.00000,0.00000,203),(103,1,1,796.00000,796.00000,203),(103,1,2,0.00000,0.00000,203),(103,1,3,0.00000,0.00000,203),(103,1,4,0.00000,0.00000,203),(103,3,1,26.00000,26.00000,203),(103,3,2,0.00000,0.00000,203),(103,3,3,0.00000,0.00000,203),(103,3,4,0.00000,0.00000,203),(103,6,1,203.00000,203.00000,203),(103,6,2,0.00000,0.00000,203),(103,6,3,0.00000,0.00000,203),(103,6,4,0.00000,0.00000,203),(103,7,1,185.00000,185.00000,203),(103,7,2,0.00000,0.00000,203),(103,7,3,0.00000,0.00000,203),(103,7,4,0.00000,0.00000,203),(104,1,1,796.00000,796.00000,203),(104,1,2,0.00000,0.00000,203),(104,1,3,0.00000,0.00000,203),(104,1,4,0.00000,0.00000,203),(104,3,1,26.00000,26.00000,203),(104,3,2,0.00000,0.00000,203),(104,3,3,0.00000,0.00000,203),(104,3,4,0.00000,0.00000,203),(104,6,1,203.00000,203.00000,203),(104,6,2,0.00000,0.00000,203),(104,6,3,0.00000,0.00000,203),(104,6,4,0.00000,0.00000,203),(104,7,1,185.00000,185.00000,203),(104,7,2,0.00000,0.00000,203),(104,7,3,0.00000,0.00000,203),(104,7,4,0.00000,0.00000,203),(105,1,1,796.00000,796.00000,203),(105,1,2,0.00000,0.00000,203),(105,1,3,0.00000,0.00000,203),(105,1,4,0.00000,0.00000,203),(105,3,1,26.00000,26.00000,203),(105,3,2,0.00000,0.00000,203),(105,3,3,0.00000,0.00000,203),(105,3,4,0.00000,0.00000,203),(105,6,1,203.00000,203.00000,203),(105,6,2,0.00000,0.00000,203),(105,6,3,0.00000,0.00000,203),(105,6,4,0.00000,0.00000,203),(105,7,1,185.00000,185.00000,203),(105,7,2,0.00000,0.00000,203),(105,7,3,0.00000,0.00000,203),(105,7,4,0.00000,0.00000,203),(106,1,1,796.00000,796.00000,203),(106,1,2,0.00000,0.00000,203),(106,1,3,0.00000,0.00000,203),(106,1,4,0.00000,0.00000,203),(106,3,1,26.00000,26.00000,203),(106,3,2,0.00000,0.00000,203),(106,3,3,0.00000,0.00000,203),(106,3,4,0.00000,0.00000,203),(106,6,1,203.00000,203.00000,203),(106,6,2,0.00000,0.00000,203),(106,6,3,0.00000,0.00000,203),(106,6,4,0.00000,0.00000,203),(106,7,1,185.00000,185.00000,203),(106,7,2,0.00000,0.00000,203),(106,7,3,0.00000,0.00000,203),(106,7,4,0.00000,0.00000,203);
/*!40000 ALTER TABLE `ps_layered_price_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_layered_product_attribute`
--

DROP TABLE IF EXISTS `ps_layered_product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_layered_product_attribute` (
  `id_attribute` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_attribute_group` int(10) unsigned NOT NULL DEFAULT '0',
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_attribute`,`id_product`,`id_shop`),
  UNIQUE KEY `id_attribute_group` (`id_attribute_group`,`id_attribute`,`id_product`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_layered_product_attribute`
--

LOCK TABLES `ps_layered_product_attribute` WRITE;
/*!40000 ALTER TABLE `ps_layered_product_attribute` DISABLE KEYS */;
INSERT INTO `ps_layered_product_attribute` VALUES (1,13,1,1),(2,13,1,1),(3,13,1,1),(4,13,1,1),(5,13,1,1),(6,2,2,1),(7,2,2,1),(8,2,2,1),(9,15,3,1),(10,15,3,1),(11,15,3,1),(12,15,3,1);
/*!40000 ALTER TABLE `ps_layered_product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_link_block`
--

DROP TABLE IF EXISTS `ps_link_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_link_block` (
  `id_link_block` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_hook` int(1) unsigned DEFAULT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `content` text,
  PRIMARY KEY (`id_link_block`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_link_block`
--

LOCK TABLES `ps_link_block` WRITE;
/*!40000 ALTER TABLE `ps_link_block` DISABLE KEYS */;
INSERT INTO `ps_link_block` VALUES (1,35,1,'{\"cms\":[false],\"static\":[false],\"product\":[\"prices-drop\",\"new-products\"]}'),(2,35,2,'{\"cms\":[\"4\",\"5\",\"3\"],\"product\":[false],\"static\":[false]}'),(3,35,3,'{\"cms\":[\"1\",\"6\",\"2\"],\"product\":[false],\"static\":[false]}'),(4,35,4,'{\"cms\":[false],\"static\":[false],\"product\":[false]}');
/*!40000 ALTER TABLE `ps_link_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_link_block_lang`
--

DROP TABLE IF EXISTS `ps_link_block_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_link_block_lang` (
  `id_link_block` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `custom_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_link_block`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_link_block_lang`
--

LOCK TABLES `ps_link_block_lang` WRITE;
/*!40000 ALTER TABLE `ps_link_block_lang` DISABLE KEYS */;
INSERT INTO `ps_link_block_lang` VALUES (1,1,'商品','[{\"title\":\"\\u700f\\u89bd\\u8a18\\u9304\",\"url\":\"\\/viewed-products\"}]'),(1,2,'Shop & Buy','[{\"title\":\"Viewed Products\",\"url\":\"\\/viewed-products\"}]'),(1,3,'单件商品',NULL),(1,4,'商品','[{\"title\":\"Viewed Products\",\"url\":\"\\/viewed-products\"}]'),(2,1,'商店','[]'),(2,2,'Store','[]'),(2,3,'Store','[]'),(2,4,'ショップについて','[]'),(3,1,'購物協助','[]'),(3,2,'Shopping Help','[]'),(3,3,'Shopping Help','[]'),(3,4,'購入について','[]'),(4,1,'消費者服務','[{\"title\":\"\\u806f\\u7d61\\u6211\\u5011\",\"url\":\"\\/contact\"},{\"title\":\"Facebook Messenger\",\"url\":\"https:\\/\\/www.facebook.com\\/messages\\/t\\/TekapoCart\"},{\"title\":\"\\u8a02\\u55ae\\u67e5\\u8a62\",\"url\":\"\\/order-tracking\"}]'),(4,2,'Customer Service','[{\"title\":\"Contact Us\",\"url\":\"\\/en\\/contact\"},{\"title\":\"Facebook Messenger\",\"url\":\"https:\\/\\/www.facebook.com\\/messages\\/t\\/TekapoCart\"},{\"title\":\"Order Tracking\",\"url\":\"\\/en\\/guest-tracking\"}]'),(4,3,'Customer Service','[{\"title\":\"\\u8054\\u7edc\\u6211\\u4eec\",\"url\":\"\\/cn\\/contact\"},{\"title\":\"Facebook Messenger\",\"url\":\"https:\\/\\/www.facebook.com\\/messages\\/t\\/TekapoCart\"},{\"title\":\"\\u8ba2\\u5355\\u67e5\\u8be2\",\"url\":\"\\/cn\\/guest-tracking\"}]'),(4,4,'サービスについて','[{\"title\":\"\\u304a\\u554f\\u3044\\u5408\\u308f\\u305b\",\"url\":\"\\/jp\\/contact\"},{\"title\":\"FaceBook\\u30e1\\u30c3\\u30bb\\u30fc\\u30b8\",\"url\":\"https:\\/\\/www.facebook.com\\/messages\\/t\\/TekapoCart\"},{\"title\":\"Order Tracking\",\"url\":\"\\/jp\\/guest-tracking\"}]');
/*!40000 ALTER TABLE `ps_link_block_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_link_block_shop`
--

DROP TABLE IF EXISTS `ps_link_block_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_link_block_shop` (
  `id_link_block` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_link_block`,`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_link_block_shop`
--

LOCK TABLES `ps_link_block_shop` WRITE;
/*!40000 ALTER TABLE `ps_link_block_shop` DISABLE KEYS */;
INSERT INTO `ps_link_block_shop` VALUES (1,1),(2,1),(3,1),(4,1);
/*!40000 ALTER TABLE `ps_link_block_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_linksmenutop`
--

DROP TABLE IF EXISTS `ps_linksmenutop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_linksmenutop` (
  `id_linksmenutop` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL,
  `new_window` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_linksmenutop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_linksmenutop`
--

LOCK TABLES `ps_linksmenutop` WRITE;
/*!40000 ALTER TABLE `ps_linksmenutop` DISABLE KEYS */;
INSERT INTO `ps_linksmenutop` VALUES (1,1,0);
/*!40000 ALTER TABLE `ps_linksmenutop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_linksmenutop_lang`
--

DROP TABLE IF EXISTS `ps_linksmenutop_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_linksmenutop_lang` (
  `id_linksmenutop` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `label` varchar(128) NOT NULL,
  `link` varchar(128) NOT NULL,
  KEY `id_linksmenutop` (`id_linksmenutop`,`id_lang`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_linksmenutop_lang`
--

LOCK TABLES `ps_linksmenutop_lang` WRITE;
/*!40000 ALTER TABLE `ps_linksmenutop_lang` DISABLE KEYS */;
INSERT INTO `ps_linksmenutop_lang` VALUES (1,1,1,'聯絡我們','https://test.tekapo.cart/contact'),(1,2,1,'Contact','https://test.tekapo.cart/en/contact'),(1,3,1,'Contact','https://test.tekapo.cart/cn/contact'),(1,4,1,'Contact','https://test.tekapo.cart/jp/contact');
/*!40000 ALTER TABLE `ps_linksmenutop_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_log`
--

DROP TABLE IF EXISTS `ps_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_log` (
  `id_log` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `severity` tinyint(1) NOT NULL,
  `error_code` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `object_type` varchar(32) DEFAULT NULL,
  `object_id` int(10) unsigned DEFAULT NULL,
  `id_employee` int(10) unsigned DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_log`
--

LOCK TABLES `ps_log` WRITE;
/*!40000 ALTER TABLE `ps_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_log_email`
--

DROP TABLE IF EXISTS `ps_log_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_log_email` (
  `id_log_email` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_email_type` int(10) unsigned NOT NULL,
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned DEFAULT NULL,
  `id_cart` int(10) unsigned DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_log_email`),
  KEY `date_add` (`date_add`),
  KEY `id_cart` (`id_cart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_log_email`
--

LOCK TABLES `ps_log_email` WRITE;
/*!40000 ALTER TABLE `ps_log_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_log_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_mail`
--

DROP TABLE IF EXISTS `ps_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_mail` (
  `id_mail` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `recipient` varchar(126) NOT NULL,
  `template` varchar(62) NOT NULL,
  `subject` varchar(254) NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `date_add` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_mail`),
  KEY `recipient` (`recipient`(10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_mail`
--

LOCK TABLES `ps_mail` WRITE;
/*!40000 ALTER TABLE `ps_mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_mailalert_customer_oos`
--

DROP TABLE IF EXISTS `ps_mailalert_customer_oos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_mailalert_customer_oos` (
  `id_customer` int(10) unsigned NOT NULL,
  `customer_email` varchar(128) NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_customer`,`customer_email`,`id_product`,`id_product_attribute`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_mailalert_customer_oos`
--

LOCK TABLES `ps_mailalert_customer_oos` WRITE;
/*!40000 ALTER TABLE `ps_mailalert_customer_oos` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_mailalert_customer_oos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_manufacturer`
--

DROP TABLE IF EXISTS `ps_manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer` (
  `id_manufacturer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_manufacturer`
--

LOCK TABLES `ps_manufacturer` WRITE;
/*!40000 ALTER TABLE `ps_manufacturer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_manufacturer_lang`
--

DROP TABLE IF EXISTS `ps_manufacturer_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer_lang` (
  `id_manufacturer` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `description` text,
  `short_description` text,
  `meta_title` varchar(255) NOT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id_manufacturer`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_manufacturer_lang`
--

LOCK TABLES `ps_manufacturer_lang` WRITE;
/*!40000 ALTER TABLE `ps_manufacturer_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_manufacturer_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_manufacturer_shop`
--

DROP TABLE IF EXISTS `ps_manufacturer_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_manufacturer_shop` (
  `id_manufacturer` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_manufacturer`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_manufacturer_shop`
--

LOCK TABLES `ps_manufacturer_shop` WRITE;
/*!40000 ALTER TABLE `ps_manufacturer_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_manufacturer_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_memcached_servers`
--

DROP TABLE IF EXISTS `ps_memcached_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_memcached_servers` (
  `id_memcached_server` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(254) NOT NULL,
  `port` int(11) unsigned NOT NULL,
  `weight` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_memcached_server`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_memcached_servers`
--

LOCK TABLES `ps_memcached_servers` WRITE;
/*!40000 ALTER TABLE `ps_memcached_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_memcached_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_message`
--

DROP TABLE IF EXISTS `ps_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_message` (
  `id_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cart` int(10) unsigned DEFAULT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_employee` int(10) unsigned DEFAULT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `message` text NOT NULL,
  `private` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_message`),
  KEY `message_order` (`id_order`),
  KEY `id_cart` (`id_cart`),
  KEY `id_customer` (`id_customer`),
  KEY `id_employee` (`id_employee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_message`
--

LOCK TABLES `ps_message` WRITE;
/*!40000 ALTER TABLE `ps_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_message_readed`
--

DROP TABLE IF EXISTS `ps_message_readed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_message_readed` (
  `id_message` int(10) unsigned NOT NULL,
  `id_employee` int(10) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_message`,`id_employee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_message_readed`
--

LOCK TABLES `ps_message_readed` WRITE;
/*!40000 ALTER TABLE `ps_message_readed` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_message_readed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_meta`
--

DROP TABLE IF EXISTS `ps_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_meta` (
  `id_meta` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page` varchar(64) NOT NULL,
  `configurable` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_meta`),
  UNIQUE KEY `page` (`page`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_meta`
--

LOCK TABLES `ps_meta` WRITE;
/*!40000 ALTER TABLE `ps_meta` DISABLE KEYS */;
INSERT INTO `ps_meta` VALUES (1,'pagenotfound',1),(2,'best-sales',1),(3,'contact',1),(4,'index',1),(5,'manufacturer',0),(6,'new-products',1),(7,'password',0),(8,'prices-drop',1),(9,'sitemap',0),(10,'supplier',0),(11,'address',0),(12,'addresses',0),(13,'authentication',0),(14,'cart',1),(15,'discount',0),(16,'history',0),(17,'identity',0),(18,'my-account',0),(19,'order-follow',0),(20,'order-slip',0),(21,'order',0),(22,'search',1),(23,'stores',0),(24,'guest-tracking',0),(25,'order-confirmation',0),(26,'product',0),(27,'category',0),(28,'cms',0),(29,'module-cheque-payment',0),(30,'module-cheque-validation',0),(31,'module-bankwire-validation',0),(32,'module-bankwire-payment',0),(33,'module-cashondelivery-validation',0),(36,'module-ps_emailsubscription-verification',0),(37,'module-ps_emailsubscription-subscription',0),(38,'module-ps_shoppingcart-ajax',0),(39,'module-ps_wirepayment-payment',0),(40,'module-ps_wirepayment-validation',0),(43,'module-ps_emailalerts-account',0),(49,'module-paypal-payment',0),(50,'module-paypal-validation',0),(51,'viewed-products',1),(52,'order-detail',0);
/*!40000 ALTER TABLE `ps_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_meta_lang`
--

DROP TABLE IF EXISTS `ps_meta_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_meta_lang` (
  `id_meta` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_lang` int(10) unsigned NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `url_rewrite` varchar(254) NOT NULL,
  PRIMARY KEY (`id_meta`,`id_shop`,`id_lang`),
  KEY `id_shop` (`id_shop`),
  KEY `id_lang` (`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_meta_lang`
--

LOCK TABLES `ps_meta_lang` WRITE;
/*!40000 ALTER TABLE `ps_meta_lang` DISABLE KEYS */;
INSERT INTO `ps_meta_lang` VALUES (1,1,1,'404 錯誤','找不到此頁','','page-not-found'),(1,1,2,'404 error','This page cannot be found','','page-not-found'),(1,1,3,'404 error','This page cannot be found','','page-not-found'),(1,1,4,'404エラー','ページが見つかりませんでした。','','page-not-found'),(1,2,1,'404 錯誤','找不到此頁','','page-not-found'),(1,2,2,'404 error','This page cannot be found','','page-not-found'),(1,2,3,'404 error','This page cannot be found','','page-not-found'),(1,2,4,'404エラー','ページが見つかりませんでした。','','page-not-found'),(1,3,1,'404 錯誤','找不到此頁','','page-not-found'),(1,3,2,'404 error','This page cannot be found','','page-not-found'),(1,3,3,'404 error','This page cannot be found','','page-not-found'),(1,3,4,'404エラー','ページが見つかりませんでした。','','page-not-found'),(1,4,1,'404 錯誤','找不到此頁','','page-not-found'),(1,4,2,'404 error','This page cannot be found','','page-not-found'),(1,4,3,'404 error','This page cannot be found','','page-not-found'),(1,4,4,'404エラー','ページが見つかりませんでした。','','page-not-found'),(2,1,1,'熱賣商品','近期熱賣商品','','best-sales'),(2,1,2,'Best sellers','Our best sellers','','best-sales'),(2,1,3,'Best sellers','Our best sellers','','best-sales'),(2,1,4,'ベストセラー','当店のベストセラー','','best-sales'),(2,2,1,'熱賣商品','近期熱賣商品','','best-sales'),(2,2,2,'Best sellers','Our best sellers','','best-sales'),(2,2,3,'Best sellers','Our best sellers','','best-sales'),(2,2,4,'ベストセラー','当店のベストセラー','','best-sales'),(2,3,1,'熱賣商品','近期熱賣商品','','best-sales'),(2,3,2,'Best sellers','Our best sellers','','best-sales'),(2,3,3,'Best sellers','Our best sellers','','best-sales'),(2,3,4,'ベストセラー','当店のベストセラー','','best-sales'),(2,4,1,'熱賣商品','近期熱賣商品','','best-sales'),(2,4,2,'Best sellers','Our best sellers','','best-sales'),(2,4,3,'Best sellers','Our best sellers','','best-sales'),(2,4,4,'ベストセラー','当店のベストセラー','','best-sales'),(3,1,1,'聯絡我們','歡迎透過「聯絡我們」詢問，我們會盡快答覆您。','','contact'),(3,1,2,'Contact','Use our form to contact us','','contact'),(3,1,3,'Contact','Use our form to contact us','','contact'),(3,1,4,'お問い合わせ','ご質問は問合せフォームをご利用ください。','','contact'),(3,2,1,'聯絡我們','歡迎透過「聯絡我們」詢問，我們會盡快答覆您。','','contact'),(3,2,2,'Contact','Use our form to contact us','','contact'),(3,2,3,'Contact','Use our form to contact us','','contact'),(3,2,4,'Contact','ご質問は問合せフォームをご利用ください。','','contact'),(3,3,1,'聯絡我們','歡迎透過「聯絡我們」詢問，我們會盡快答覆您。','','contact'),(3,3,2,'Contact','Use our form to contact us','','contact'),(3,3,3,'Contact','Use our form to contact us','','contact'),(3,3,4,'Contact','ご質問は問合せフォームをご利用ください。','','contact'),(3,4,1,'聯絡我們','歡迎透過表單詢問，我們會盡快答覆您。','','contact'),(3,4,2,'Contact','Use our form to contact us','','contact'),(3,4,3,'Contact','Use our form to contact us','','contact'),(3,4,4,'Contact','ご質問は問合せフォームをご利用ください。','','contact'),(4,1,1,'我的 TekapoCart 商店','本站於 _TIME_ 建立，全站 A+ SSL 加密，顧客可以安心的購物網站。','',''),(4,1,2,'My TekapoCart Shop','Started on _TIME_. A secure and reliable online store.','',''),(4,1,3,'','Software maintained by TekapoCart','',''),(4,1,4,'','Software maintained by TekapoCart','',''),(4,2,1,'我的 TekapoCart Shop','本站於 _TIME_ 建立，全站 A+ SSL 加密，顧客可以安心的購物網站。','',''),(4,2,2,'My TekapoCart Shop','Started on _TIME_. A secure and reliable online store.','',''),(4,2,3,'','Software maintained by TekapoCart','',''),(4,2,4,'','Software maintained by TekapoCart','',''),(4,3,1,'我的 TekapoCart Shop','本站於 _TIME_ 建立，全站 A+ SSL 加密，顧客可以安心的購物網站。','',''),(4,3,2,'My TekapoCart Shop','Started on _TIME_. A secure and reliable online store.','',''),(4,3,3,'','Software maintained by TekapoCart','',''),(4,3,4,'','Software maintained by TekapoCart','',''),(4,4,1,'我的 TekapoCart Shop','本站於 _TIME_ 建立，全站 A+ SSL 加密，顧客可以安心的購物網站。','',''),(4,4,2,'My TekapoCart Shop','Started on _TIME_. A secure and reliable online store.','',''),(4,4,3,'','Software maintained by TekapoCart','',''),(4,4,4,'','Software maintained by TekapoCart','',''),(5,1,1,'Brands','Brands list','','brands'),(5,1,2,'Brands','Brands list','','brands'),(5,1,3,'Brands','Brands list','','brands'),(5,1,4,'Brands','Brands list','','brands'),(6,1,1,'新品上架','質感新鮮品','','new-products'),(6,1,2,'New Products','Our new products','','new-products'),(6,1,3,'New Products','Our new products','','new-products'),(6,1,4,'新作','新着商品','','new-products'),(6,3,1,'新品上架','質感新鮮品','','new-products'),(7,1,1,'忘記密碼','輸入您用於登錄的電郵地址以接收具有新密碼的電子郵件','','password-recovery'),(7,1,2,'Forgot Password','Enter your e-mail address used to register in goal to get e-mail with your new password','','password-recovery'),(7,1,3,'Forgot Password','Enter your e-mail address used to register in goal to get e-mail with your new password','','password-recovery'),(7,1,4,'Forgot Password','Enter your e-mail address used to register in goal to get e-mail with your new password','','password-recovery'),(8,1,1,'特價商品','限時限量折扣專區','','prices-drop'),(8,1,2,'Prices drop','Our special products','','prices-drop'),(8,1,3,'Prices drop','Our special products','','prices-drop'),(8,1,4,'セール','Our special products','','prices-drop'),(8,3,1,'特價商品','限時限量折扣專區','','prices-drop'),(9,1,1,'網站導覽','再次搜索','','網站導覽'),(9,1,2,'Sitemap','Lost ? Find what your are looking for','','网站地图'),(9,1,3,'站点地图','Lost ? Find what your are looking for','','网站地图'),(9,1,4,'Sitemap','お探しのものが見つかりませんか？','','网站地图'),(10,1,1,'供應商','供應商列表','','supplier'),(10,1,2,'Supplier','Suppliers list','','supplier'),(10,1,3,'Supplier','Suppliers list','','supplier'),(10,1,4,'Supplier','サプライヤー一覧','','supplier'),(11,1,1,'配送資訊','','','address'),(11,1,2,'Delivery Info','','','address'),(11,1,3,'Delivery Info','','','address'),(11,1,4,'Delivery Info','','','address'),(11,2,1,'配送資訊','','','address'),(11,2,2,'Delivery Info','','','address'),(11,2,3,'Delivery Info','','','address'),(11,2,4,'Delivery Info','','','address'),(11,3,1,'配送資訊','','','address'),(11,3,2,'Delivery Info','','','address'),(11,3,3,'Delivery Info','','','address'),(11,3,4,'Delivery Info','','','address'),(11,4,1,'配送資訊','','','address'),(11,4,2,'Delivery Info','','','address'),(11,4,3,'Delivery Info','','','address'),(11,4,4,'Delivery Info','','','address'),(12,1,1,'配送資訊','','','addresses'),(12,1,2,'Delivery Info','','','addresses'),(12,1,3,'Delivery Info','','','addresses'),(12,1,4,'Delivery Info','','','addresses'),(12,2,1,'配送資訊','','','addresses'),(12,2,2,'Delivery Info','','','addresses'),(12,2,3,'Delivery Info','','','addresses'),(12,2,4,'Delivery Info','','','addresses'),(12,3,1,'配送資訊','','','addresses'),(12,3,2,'Delivery Info','','','addresses'),(12,3,3,'Delivery Info','','','addresses'),(12,3,4,'Delivery Info','','','addresses'),(12,4,1,'配送資訊','','','addresses'),(12,4,2,'Delivery Info','','','addresses'),(12,4,3,'Delivery Info','','','addresses'),(12,4,4,'Delivery Info','','','addresses'),(13,1,1,'登入','','','login'),(13,1,2,'Login','','','login'),(13,1,3,'登录','','','login'),(13,1,4,'Login','','','login'),(13,2,1,'登入','','','login'),(13,2,2,'Login','','','login'),(13,2,3,'登录','','','login'),(13,2,4,'Login','','','login'),(13,3,1,'登入','','','login'),(13,3,2,'Login','','','login'),(13,3,3,'登录','','','login'),(13,3,4,'Login','','','login'),(13,4,1,'登入','','','login'),(13,4,2,'Login','','','login'),(13,4,3,'登录','','','login'),(13,4,4,'Login','','','login'),(14,1,1,'購物車','','','cart'),(14,1,2,'Cart','','','cart'),(14,1,3,'购物车','','','cart'),(14,1,4,'Cart','','','cart'),(14,2,1,'購物車','','','cart'),(14,2,2,'Cart','','','cart'),(14,2,3,'购物车','','','cart'),(14,2,4,'Cart','','','cart'),(14,3,1,'購物車','','','cart'),(14,3,2,'Cart','','','cart'),(14,3,3,'购物车','','','cart'),(14,3,4,'Cart','','','cart'),(14,4,1,'購物車','','','cart'),(14,4,2,'Cart','','','cart'),(14,4,3,'购物车','','','cart'),(14,4,4,'Cart','','','cart'),(15,1,1,'優惠券','','','discount'),(15,1,2,'Discount','','','discount'),(15,1,3,'折扣','','','discount'),(15,1,4,'割引','','','discount'),(15,2,1,'優惠券','','','discount'),(15,2,2,'Discount','','','discount'),(15,2,3,'折扣','','','discount'),(15,2,4,'割引','','','discount'),(15,3,1,'優惠券','','','discount'),(15,3,2,'Discount','','','discount'),(15,3,3,'折扣','','','discount'),(15,3,4,'割引','','','discount'),(15,4,1,'優惠券','','','discount'),(15,4,2,'Discount','','','discount'),(15,4,3,'折扣','','','discount'),(15,4,4,'割引','','','discount'),(16,1,1,'訂單記錄','','','order-history'),(16,1,2,'Order History','','','order-history'),(16,1,3,'Order History','','','order-history'),(16,1,4,'Order History','','','order-history'),(16,2,1,'訂單記錄','','','order-history'),(16,2,2,'Order History','','','order-history'),(16,2,3,'Order History','','','order-history'),(16,2,4,'Order History','','','order-history'),(16,3,1,'訂單記錄','','','order-history'),(16,3,2,'Order History','','','order-history'),(16,3,3,'Order History','','','order-history'),(16,3,4,'Order History','','','order-history'),(16,4,1,'訂單記錄','','','order-history'),(16,4,2,'Order History','','','order-history'),(16,4,3,'Order History','','','order-history'),(16,4,4,'Order History','','','order-history'),(17,1,1,'個人資料','','','identity'),(17,1,2,'Personal Info','','','identity'),(17,1,3,'Personal Info','','','identity'),(17,1,4,'Personal Info','','','identity'),(17,2,1,'個人資料','','','identity'),(17,2,2,'Personal Info','','','identity'),(17,2,3,'Personal Info','','','identity'),(17,2,4,'Personal Info','','','identity'),(17,3,1,'個人資料','','','identity'),(17,3,2,'Personal Info','','','identity'),(17,3,3,'Personal Info','','','identity'),(17,3,4,'Personal Info','','','identity'),(17,4,1,'個人資料','','','identity'),(17,4,2,'Personal Info','','','identity'),(17,4,3,'Personal Info','','','identity'),(17,4,4,'Personal Info','','','identity'),(18,1,1,'會員中心','','','my-account'),(18,1,2,'My Account','','','my-account'),(18,1,3,'My Account','','','my-account'),(18,1,4,'My Account','','','my-account'),(18,2,1,'會員中心','','','my-account'),(18,2,2,'My Account','','','my-account'),(18,2,3,'My Account','','','my-account'),(18,2,4,'My Account','','','my-account'),(18,3,1,'會員中心','','','my-account'),(18,3,2,'My Account','','','my-account'),(18,3,3,'My Account','','','my-account'),(18,3,4,'My Account','','','my-account'),(18,4,1,'會員中心','','','my-account'),(18,4,2,'My Account','','','my-account'),(18,4,3,'My Account','','','my-account'),(18,4,4,'My Account','','','my-account'),(19,1,1,'訂單追蹤','','','order-follow'),(19,1,2,'Order Follow','','','order-follow'),(19,1,3,'Order Follow','','','order-follow'),(19,1,4,'注文対応','','','order-follow'),(19,2,1,'訂單追蹤','','','order-follow'),(19,2,2,'Order Follow','','','order-follow'),(19,2,3,'Order Follow','','','order-follow'),(19,2,4,'注文対応','','','order-follow'),(19,3,1,'訂單追蹤','','','order-follow'),(19,3,2,'Order Follow','','','order-follow'),(19,3,3,'Order Follow','','','order-follow'),(19,3,4,'注文対応','','','order-follow'),(19,4,1,'訂單追蹤','','','order-follow'),(19,4,2,'Order Follow','','','order-follow'),(19,4,3,'Order Follow','','','order-follow'),(19,4,4,'注文対応','','','order-follow'),(20,1,1,'折讓單','','','order-slip'),(20,1,2,'Order Slip','','','order-slip'),(20,1,3,'Order Slip','','','order-slip'),(20,1,4,'Order Slip','','','order-slip'),(20,2,1,'折讓單','','','order-slip'),(20,2,2,'Order Slip','','','order-slip'),(20,2,3,'Order Slip','','','order-slip'),(20,2,4,'Order Slip','','','order-slip'),(20,3,1,'折讓單','','','order-slip'),(20,3,2,'Order Slip','','','order-slip'),(20,3,3,'Order Slip','','','order-slip'),(20,3,4,'Order Slip','','','order-slip'),(20,4,1,'折讓單','','','order-slip'),(20,4,2,'Order Slip','','','order-slip'),(20,4,3,'Order Slip','','','order-slip'),(20,4,4,'Order Slip','','','order-slip'),(21,1,1,'訂單','','','order'),(21,1,2,'Order','','','order'),(21,1,3,'购买','','','订单'),(21,1,4,'Order','','','order'),(21,2,1,'訂單','','','order'),(21,2,2,'Order','','','order'),(21,2,3,'购买','','','订单'),(21,2,4,'Order','','','order'),(21,3,1,'訂單','','','order'),(21,3,2,'Order','','','order'),(21,3,3,'购买','','','订单'),(21,3,4,'Order','','','order'),(21,4,1,'訂單','','','order'),(21,4,2,'Order','','','order'),(21,4,3,'购买','','','订单'),(21,4,4,'Order','','','order'),(22,1,1,'搜尋結果','用關鍵字搜尋','','search'),(22,1,2,'Search','','','search'),(22,1,3,'搜索','','','search'),(22,1,4,'Search','','','search'),(22,2,1,'搜尋結果','用關鍵字搜尋','','search'),(22,2,2,'Search','','','search'),(22,2,3,'搜索','','','search'),(22,2,4,'Search','','','search'),(22,3,1,'搜尋結果','用關鍵字搜尋','','search'),(22,3,2,'Search','','','search'),(22,3,3,'搜索','','','search'),(22,3,4,'Search','','','search'),(22,4,1,'搜尋結果','用關鍵字搜尋','','search'),(22,4,2,'Search','','','search'),(22,4,3,'搜索','','','search'),(22,4,4,'Search','','','search'),(23,1,1,'商店','','','商店'),(23,1,2,'Store','','','stores'),(23,1,3,'Store','','','stores'),(23,1,4,'Store','','','店舗'),(24,1,1,'訂單查詢','','','order-tracking'),(24,1,2,'Order Tracking','','','order-tracking'),(24,1,3,'Order Tracking','','','order-tracking'),(24,1,4,'Order Tracking','','','order-tracking'),(24,2,1,'訂單查詢','','','order-tracking'),(24,2,2,'Order Tracking','','','order-tracking'),(24,2,3,'Order Tracking','','','order-tracking'),(24,2,4,'Order Tracking','','','order-tracking'),(24,3,1,'訂單查詢','','','order-tracking'),(24,3,2,'Order Tracking','','','order-tracking'),(24,3,3,'Order Tracking','','','order-tracking'),(24,3,4,'Order Tracking','','','order-tracking'),(24,4,1,'訂單查詢','','','order-tracking'),(24,4,2,'Order Tracking','','','order-tracking'),(24,4,3,'Order Tracking','','','order-tracking'),(24,4,4,'Order Tracking','','','order-tracking'),(25,1,1,'訂單確認','','','order-confirmation'),(25,1,2,'Order Confirmation','','','order-confirmation'),(25,1,3,'Order Confirmation','','','order-confirmation'),(25,1,4,'Order Confirmation','','','order-confirmation'),(25,2,1,'訂單確認','','','order-confirmation'),(25,2,2,'Order Confirmation','','','order-confirmation'),(25,2,3,'Order Confirmation','','','order-confirmation'),(25,2,4,'Order Confirmation','','','order-confirmation'),(25,3,1,'訂單確認','','','order-confirmation'),(25,3,2,'Order Confirmation','','','order-confirmation'),(25,3,3,'Order Confirmation','','','order-confirmation'),(25,3,4,'Order Confirmation','','','order-confirmation'),(25,4,1,'訂單確認','','','order-confirmation'),(25,4,2,'Order Confirmation','','','order-confirmation'),(25,4,3,'Order Confirmation','','','order-confirmation'),(25,4,4,'Order Confirmation','','','order-confirmation'),(26,1,1,'商品頁','','','product'),(26,1,2,'Product','','','product'),(26,1,3,'Product','','','product'),(26,1,4,'Product','','','product'),(27,1,1,'商品分類','','','category'),(27,1,2,'Category','','','category'),(27,1,3,'Category','','','category'),(27,1,4,'Category','','','category'),(28,1,1,'自訂頁面','','','cms'),(28,1,2,'Cms','','','cms'),(28,1,3,'Cms','','','cms'),(28,1,4,'Cms','','','cms'),(36,1,1,'','','',''),(36,1,2,'','','',''),(36,1,3,'','','',''),(36,1,4,'','','',''),(37,1,1,'','','',''),(37,1,2,'','','',''),(37,1,3,'','','',''),(37,1,4,'','','',''),(38,1,1,'','','',''),(38,1,2,'','','',''),(38,1,3,'','','',''),(38,1,4,'','','',''),(39,1,1,'','','',''),(39,1,2,'','','',''),(39,1,3,'','','',''),(39,1,4,'','','',''),(40,1,1,'','','',''),(40,1,2,'','','',''),(40,1,3,'','','',''),(40,1,4,'','','',''),(43,1,1,'','','',''),(43,1,2,'','','',''),(43,1,3,'','','',''),(43,1,4,'','','',''),(45,1,1,'','','',''),(45,1,2,'','','',''),(45,1,3,'','','',''),(45,1,4,'','','',''),(46,1,1,'','','',''),(46,1,2,'','','',''),(46,1,3,'','','',''),(46,1,4,'','','',''),(47,1,1,'','','',''),(47,1,2,'','','',''),(47,1,3,'','','',''),(47,1,4,'','','',''),(48,1,1,'','','',''),(48,1,2,'','','',''),(48,1,3,'','','',''),(48,1,4,'','','',''),(49,1,1,'','','',''),(49,1,2,'','','',''),(49,1,3,'','','',''),(49,1,4,'','','',''),(50,1,1,'','','',''),(50,1,2,'','','',''),(50,1,3,'','','',''),(50,1,4,'','','',''),(51,1,1,'瀏覽紀錄','','','viewed-products'),(51,1,2,'Recently Viewed','','','viewed-products'),(51,1,3,'Recently Viewed','','','viewed-products'),(51,1,4,'最近チェックした商品','','','viewed-products'),(51,2,1,'瀏覽紀錄','','','viewed-products'),(51,2,2,'Recently Viewed','','','viewed-products'),(51,2,3,'Recently Viewed','','','viewed-products'),(51,2,4,'最近チェックした商品','','','viewed-products'),(51,3,1,'瀏覽紀錄','','','viewed-products'),(51,3,2,'Recently Viewed','','','viewed-products'),(51,3,3,'Recently Viewed','','','viewed-products'),(51,3,4,'最近チェックした商品','','','viewed-products'),(51,4,1,'瀏覽紀錄','','','viewed-products'),(51,4,2,'Recently Viewed','','','viewed-products'),(51,4,3,'Recently Viewed','','','viewed-products'),(51,4,4,'最近チェックした商品','','','viewed-products'),(52,1,1,'訂單明細','','','order-detail'),(52,1,2,'Order Details','','','order-detail'),(52,1,3,'订单详细','','','order-detail'),(52,1,4,'注文明細','','','order-detail'),(52,2,1,'訂單明細','','','order-detail'),(52,2,2,'Order Details','','','order-detail'),(52,2,3,'订单详细','','','order-detail'),(52,2,4,'注文明細','','','order-detail'),(52,3,1,'訂單明細','','','order-detail'),(52,3,2,'Order Details','','','order-detail'),(52,3,3,'订单详细','','','order-detail'),(52,3,4,'注文明細','','','order-detail'),(52,4,1,'訂單明細','','','order-detail'),(52,4,2,'Order Details','','','order-detail'),(52,4,3,'订单详细','','','order-detail'),(52,4,4,'注文明細','','','order-detail');
/*!40000 ALTER TABLE `ps_meta_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module`
--

DROP TABLE IF EXISTS `ps_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module` (
  `id_module` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `version` varchar(8) NOT NULL,
  PRIMARY KEY (`id_module`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module`
--

LOCK TABLES `ps_module` WRITE;
/*!40000 ALTER TABLE `ps_module` DISABLE KEYS */;
INSERT INTO `ps_module` VALUES (1,'contactform',1,'4.1.1'),(2,'dashactivity',1,'2.0.2'),(3,'dashtrends',1,'2.0.2'),(4,'dashgoals',1,'2.0.2'),(5,'dashproducts',1,'2.0.4'),(6,'graphnvd3',1,'2.0.1'),(7,'gridhtml',1,'2.0.0'),(8,'ps_banner',1,'2.1.0'),(9,'ps_categorytree',1,'2.0.0'),(11,'ps_contactinfo',1,'3.1.0'),(12,'ps_currencyselector',1,'2.0.0'),(14,'ps_customersignin',1,'2.0.2'),(15,'ps_customtext',1,'4.1.0'),(16,'ps_emailsubscription',1,'2.3.0'),(17,'ps_facetedsearch',1,'2.2.0'),(18,'ps_featuredproducts',1,'2.0.0'),(19,'ps_imageslider',1,'3.0.0'),(20,'ps_languageselector',1,'2.0.2'),(21,'ps_linklist',1,'2.1.5'),(22,'ps_mainmenu',1,'2.1.1'),(23,'ps_searchbar',1,'2.0.1'),(24,'ps_sharebuttons',1,'2.0.1'),(25,'ps_shoppingcart',1,'2.0.1'),(26,'ps_socialfollow',1,'2.0.0'),(27,'ps_themecusto',1,'1.0.10'),(28,'ps_wirepayment',1,'2.0.4'),(32,'statsbestcustomers',1,'2.0.2'),(33,'statsbestproducts',1,'2.0.0'),(35,'statsbestvouchers',1,'2.0.0'),(36,'statscarrier',1,'2.0.0'),(39,'statsdata',1,'2.0.0'),(41,'statsforecast',1,'2.0.3'),(42,'statslive',1,'2.0.2'),(43,'statsnewsletter',1,'2.0.2'),(48,'statssales',1,'2.0.0'),(51,'statsvisits',1,'2.0.2'),(57,'ps_bestsellers',1,'1.0.3'),(58,'ps_specials',1,'1.0.1'),(60,'ps_reminder',1,'2.0.0'),(61,'ps_crossselling',1,'2.0.0'),(62,'ps_newproducts',1,'1.0.1'),(68,'ps_emailalerts',1,'2.1.0'),(69,'ps_googleanalytics',1,'3.1.1'),(71,'ps_viewedproduct',1,'1.1.0'),(72,'ps_brandlist',1,'1.0.2'),(73,'ps_supplierlist',1,'1.0.3'),(77,'pscleaner',1,'2.0.0'),(78,'pspixel',1,'1.0.5'),(79,'simplicity_logo',1,'1.0.0'),(80,'ps_customeraccountlinks',1,'3.1.0'),(81,'blockreassurance',1,'3.0.1'),(82,'simplicity_sociallogin',1,'1.0.0'),(87,'smilepay_ibon',1,'2.2.5'),(88,'smilepay_famiport',1,'2.2.5'),(91,'smilepay_csv',1,'2.2.5'),(94,'simplicity_cmsblock',1,'1.0.0'),(95,'simplicity_fbmessaging',1,'1.0.0'),(96,'simplicity_headerbar',1,'1.0.0'),(97,'gsitemap',1,'4.1.0'),(98,'paypal',1,'5.0.1'),(100,'simplicity_gtm',1,'1.0.0'),(101,'simplicity_igfeed',1,'1.0.0'),(102,'gshoppingflux',1,'1.7.2'),(103,'ps_categoryproducts',1,'1.0.4'),(104,'simplicity_footerbar',1,'1.0.0'),(105,'ecpay',1,'1.0.0831'),(106,'ezship',1,'1.0'),(107,'ezship_home',1,'1.0'),(108,'tc_pod',1,'1.0'),(109,'ecpay_711',1,'1.0'),(110,'ecpay_tcat',1,'1.0'),(111,'tc_711',1,'1.0'),(112,'tc_home',1,'1.0'),(113,'tc_home2',1,'1.0'),(114,'tc_home3',1,'1.0');
/*!40000 ALTER TABLE `ps_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module_access`
--

DROP TABLE IF EXISTS `ps_module_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_access` (
  `id_profile` int(10) unsigned NOT NULL,
  `id_authorization_role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_profile`,`id_authorization_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module_access`
--

LOCK TABLES `ps_module_access` WRITE;
/*!40000 ALTER TABLE `ps_module_access` DISABLE KEYS */;
INSERT INTO `ps_module_access` VALUES (1,453),(1,454),(1,455),(1,456),(1,457),(1,458),(1,459),(1,460),(1,461),(1,462),(1,463),(1,464),(1,469),(1,470),(1,471),(1,472),(1,473),(1,474),(1,475),(1,476),(1,477),(1,478),(1,479),(1,480),(1,481),(1,482),(1,483),(1,484),(1,485),(1,486),(1,487),(1,488),(1,489),(1,490),(1,491),(1,492),(1,497),(1,498),(1,499),(1,500),(1,501),(1,502),(1,503),(1,504),(1,509),(1,510),(1,511),(1,512),(1,513),(1,514),(1,515),(1,516),(1,517),(1,518),(1,519),(1,520),(1,521),(1,522),(1,523),(1,524),(1,525),(1,526),(1,527),(1,528),(1,529),(1,530),(1,531),(1,532),(1,533),(1,534),(1,535),(1,536),(1,537),(1,538),(1,539),(1,540),(1,545),(1,546),(1,547),(1,548),(1,549),(1,550),(1,551),(1,552),(1,553),(1,554),(1,555),(1,556),(1,557),(1,558),(1,559),(1,560),(1,561),(1,562),(1,563),(1,564),(1,565),(1,566),(1,567),(1,568),(1,581),(1,582),(1,583),(1,584),(1,597),(1,598),(1,599),(1,600),(1,601),(1,602),(1,603),(1,604),(1,625),(1,626),(1,627),(1,628),(1,633),(1,634),(1,635),(1,636),(1,637),(1,638),(1,639),(1,640),(1,661),(1,662),(1,663),(1,664),(1,673),(1,674),(1,675),(1,676),(1,709),(1,710),(1,711),(1,712),(1,713),(1,714),(1,715),(1,716),(1,721),(1,722),(1,723),(1,724),(1,725),(1,726),(1,727),(1,728),(1,729),(1,730),(1,731),(1,732),(1,757),(1,758),(1,759),(1,760),(1,761),(1,762),(1,763),(1,764),(1,769),(1,770),(1,771),(1,772),(1,773),(1,774),(1,775),(1,776),(1,777),(1,778),(1,779),(1,780),(1,789),(1,790),(1,791),(1,792),(1,793),(1,794),(1,795),(1,796),(1,797),(1,798),(1,799),(1,800),(1,801),(1,802),(1,803),(1,804),(1,805),(1,806),(1,807),(1,808),(1,809),(1,810),(1,811),(1,812),(1,813),(1,814),(1,815),(1,816),(1,873),(1,874),(1,875),(1,876),(1,877),(1,878),(1,879),(1,880),(1,885),(1,886),(1,887),(1,888),(1,889),(1,890),(1,891),(1,892),(1,893),(1,894),(1,895),(1,896),(1,901),(1,902),(1,903),(1,904),(1,905),(1,906),(1,907),(1,908),(1,909),(1,910),(1,911),(1,912),(1,913),(1,914),(1,915),(1,916),(1,917),(1,918),(1,919),(1,920),(1,921),(1,922),(1,923),(1,924),(1,973),(1,974),(1,975),(1,976),(1,977),(1,978),(1,979),(1,980),(1,981),(1,982),(1,983),(1,984),(1,985),(1,986),(1,987),(1,988),(1,989),(1,990),(1,991),(1,992),(1,993),(1,994),(1,995),(1,996),(1,997),(1,998),(1,999),(1,1000),(1,1001),(1,1002),(1,1003),(1,1004),(1,1005),(1,1006),(1,1007),(1,1008),(2,722),(2,723);
/*!40000 ALTER TABLE `ps_module_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module_carrier`
--

DROP TABLE IF EXISTS `ps_module_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_carrier` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_reference` int(11) NOT NULL,
  PRIMARY KEY (`id_module`,`id_shop`,`id_reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module_carrier`
--

LOCK TABLES `ps_module_carrier` WRITE;
/*!40000 ALTER TABLE `ps_module_carrier` DISABLE KEYS */;
INSERT INTO `ps_module_carrier` VALUES (28,1,101),(28,1,102),(28,1,114),(28,1,115),(28,1,116),(28,1,117),(28,1,118),(28,1,119),(28,1,120),(28,1,121),(28,1,122),(98,1,101),(98,1,102),(98,1,114),(98,1,117),(98,1,120),(98,1,121),(98,1,122),(104,1,101),(104,1,102),(104,1,103),(104,1,105),(104,1,107),(104,1,108),(104,1,109),(104,1,113),(104,1,114),(104,2,101),(104,2,102),(104,2,114),(104,3,101),(104,3,102),(104,3,114),(104,4,101),(104,4,102),(104,4,114),(105,1,101),(105,1,114),(105,1,117),(105,1,118),(105,1,119),(105,1,120),(105,1,121),(105,1,122),(108,1,115),(108,1,116),(108,1,117),(108,1,120),(108,1,121),(108,1,122),(108,2,101),(108,2,102),(108,2,114),(108,3,101),(108,3,102),(108,3,114),(108,4,101),(108,4,102),(108,4,114);
/*!40000 ALTER TABLE `ps_module_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module_country`
--

DROP TABLE IF EXISTS `ps_module_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_country` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_country` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_module`,`id_shop`,`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module_country`
--

LOCK TABLES `ps_module_country` WRITE;
/*!40000 ALTER TABLE `ps_module_country` DISABLE KEYS */;
INSERT INTO `ps_module_country` VALUES (28,1,203),(28,1,245),(28,2,203),(28,2,245),(28,2,246),(28,3,203),(28,3,245),(28,3,246),(28,4,203),(28,4,245),(28,4,246),(98,1,5),(98,1,11),(98,1,21),(98,1,22),(98,1,25),(98,1,136),(98,1,203),(98,1,245),(98,2,5),(98,2,11),(98,2,21),(98,2,22),(98,2,25),(98,2,136),(98,2,203),(98,2,245),(98,2,246),(98,3,5),(98,3,11),(98,3,21),(98,3,22),(98,3,25),(98,3,136),(98,3,203),(98,3,245),(98,3,246),(98,4,5),(98,4,11),(98,4,21),(98,4,22),(98,4,25),(98,4,136),(98,4,203),(98,4,245),(98,4,246),(104,1,5),(104,1,11),(104,1,21),(104,1,22),(104,1,25),(104,1,136),(104,1,203),(104,2,5),(104,2,11),(104,2,21),(104,2,22),(104,2,25),(104,2,136),(104,2,203),(104,3,5),(104,3,11),(104,3,21),(104,3,22),(104,3,25),(104,3,136),(104,3,203),(104,4,5),(104,4,11),(104,4,21),(104,4,22),(104,4,25),(104,4,136),(104,4,203),(105,1,203),(105,1,245),(105,2,245),(105,2,246),(105,3,245),(105,3,246),(105,4,245),(105,4,246),(108,1,203),(108,1,245),(108,2,5),(108,2,11),(108,2,21),(108,2,22),(108,2,25),(108,2,136),(108,2,203),(108,2,245),(108,2,246),(108,3,5),(108,3,11),(108,3,21),(108,3,22),(108,3,25),(108,3,136),(108,3,203),(108,3,245),(108,3,246),(108,4,5),(108,4,11),(108,4,21),(108,4,22),(108,4,25),(108,4,136),(108,4,203),(108,4,245),(108,4,246);
/*!40000 ALTER TABLE `ps_module_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module_currency`
--

DROP TABLE IF EXISTS `ps_module_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_currency` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_currency` int(11) NOT NULL,
  PRIMARY KEY (`id_module`,`id_shop`,`id_currency`),
  KEY `id_module` (`id_module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module_currency`
--

LOCK TABLES `ps_module_currency` WRITE;
/*!40000 ALTER TABLE `ps_module_currency` DISABLE KEYS */;
INSERT INTO `ps_module_currency` VALUES (28,1,1),(28,2,1),(28,3,1),(28,4,1),(98,1,-1),(98,2,-1),(98,3,-1),(98,4,-1),(104,1,1),(104,1,3),(104,1,6),(104,1,7),(104,2,1),(104,2,2),(104,2,3),(104,2,4),(104,2,5),(104,2,6),(104,2,7),(104,3,1),(104,3,2),(104,3,3),(104,3,4),(104,3,5),(104,3,6),(104,3,7),(104,4,1),(104,4,2),(104,4,3),(104,4,4),(104,4,5),(104,4,6),(104,4,7),(105,1,1),(108,1,1),(108,2,1),(108,2,2),(108,2,3),(108,2,4),(108,2,5),(108,2,6),(108,2,7),(108,3,1),(108,3,2),(108,3,3),(108,3,4),(108,3,5),(108,3,6),(108,3,7),(108,4,1),(108,4,2),(108,4,3),(108,4,4),(108,4,5),(108,4,6),(108,4,7);
/*!40000 ALTER TABLE `ps_module_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module_group`
--

DROP TABLE IF EXISTS `ps_module_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_group` (
  `id_module` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_group` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_module`,`id_shop`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module_group`
--

LOCK TABLES `ps_module_group` WRITE;
/*!40000 ALTER TABLE `ps_module_group` DISABLE KEYS */;
INSERT INTO `ps_module_group` VALUES (1,1,1),(1,1,2),(1,1,3),(1,2,1),(1,2,2),(1,2,3),(1,3,1),(1,3,2),(1,3,3),(1,4,1),(1,4,2),(1,4,3),(2,1,1),(2,1,2),(2,1,3),(2,2,1),(2,2,2),(2,2,3),(2,3,1),(2,3,2),(2,3,3),(2,4,1),(2,4,2),(2,4,3),(3,1,1),(3,1,2),(3,1,3),(3,2,1),(3,2,2),(3,2,3),(3,3,1),(3,3,2),(3,3,3),(3,4,1),(3,4,2),(3,4,3),(4,1,1),(4,1,2),(4,1,3),(4,2,1),(4,2,2),(4,2,3),(4,3,1),(4,3,2),(4,3,3),(4,4,1),(4,4,2),(4,4,3),(5,1,1),(5,1,2),(5,1,3),(5,2,1),(5,2,2),(5,2,3),(5,3,1),(5,3,2),(5,3,3),(5,4,1),(5,4,2),(5,4,3),(6,1,1),(6,1,2),(6,1,3),(6,2,1),(6,2,2),(6,2,3),(6,3,1),(6,3,2),(6,3,3),(6,4,1),(6,4,2),(6,4,3),(7,1,1),(7,1,2),(7,1,3),(7,2,1),(7,2,2),(7,2,3),(7,3,1),(7,3,2),(7,3,3),(7,4,1),(7,4,2),(7,4,3),(8,1,1),(8,1,2),(8,1,3),(8,2,1),(8,2,2),(8,2,3),(8,3,1),(8,3,2),(8,3,3),(8,4,1),(8,4,2),(8,4,3),(9,1,1),(9,1,2),(9,1,3),(9,2,1),(9,2,2),(9,2,3),(9,3,1),(9,3,2),(9,3,3),(9,4,1),(9,4,2),(9,4,3),(11,1,1),(11,1,2),(11,1,3),(11,2,1),(11,2,2),(11,2,3),(11,3,1),(11,3,2),(11,3,3),(11,4,1),(11,4,2),(11,4,3),(12,1,1),(12,1,2),(12,1,3),(12,2,1),(12,2,2),(12,2,3),(12,3,1),(12,3,2),(12,3,3),(12,4,1),(12,4,2),(12,4,3),(14,1,1),(14,1,2),(14,1,3),(14,2,1),(14,2,2),(14,2,3),(14,3,1),(14,3,2),(14,3,3),(14,4,1),(14,4,2),(14,4,3),(15,1,1),(15,1,2),(15,1,3),(15,2,1),(15,2,2),(15,2,3),(15,3,1),(15,3,2),(15,3,3),(15,4,1),(15,4,2),(15,4,3),(16,1,1),(16,1,2),(16,1,3),(16,2,1),(16,2,2),(16,2,3),(16,3,1),(16,3,2),(16,3,3),(16,4,1),(16,4,2),(16,4,3),(17,1,1),(17,1,2),(17,1,3),(17,2,1),(17,2,2),(17,2,3),(17,3,1),(17,3,2),(17,3,3),(17,4,1),(17,4,2),(17,4,3),(18,1,1),(18,1,2),(18,1,3),(18,2,1),(18,2,2),(18,2,3),(18,3,1),(18,3,2),(18,3,3),(18,4,1),(18,4,2),(18,4,3),(19,1,1),(19,1,2),(19,1,3),(19,2,1),(19,2,2),(19,2,3),(19,3,1),(19,3,2),(19,3,3),(19,4,1),(19,4,2),(19,4,3),(20,1,1),(20,1,2),(20,1,3),(20,2,1),(20,2,2),(20,2,3),(20,3,1),(20,3,2),(20,3,3),(20,4,1),(20,4,2),(20,4,3),(21,1,1),(21,1,2),(21,1,3),(21,2,1),(21,2,2),(21,2,3),(21,3,1),(21,3,2),(21,3,3),(21,4,1),(21,4,2),(21,4,3),(22,1,1),(22,1,2),(22,1,3),(22,2,1),(22,2,2),(22,2,3),(22,3,1),(22,3,2),(22,3,3),(22,4,1),(22,4,2),(22,4,3),(23,1,1),(23,1,2),(23,1,3),(23,2,1),(23,2,2),(23,2,3),(23,3,1),(23,3,2),(23,3,3),(23,4,1),(23,4,2),(23,4,3),(24,1,1),(24,1,2),(24,1,3),(24,2,1),(24,2,2),(24,2,3),(24,3,1),(24,3,2),(24,3,3),(24,4,1),(24,4,2),(24,4,3),(25,1,1),(25,1,2),(25,1,3),(25,2,1),(25,2,2),(25,2,3),(25,3,1),(25,3,2),(25,3,3),(25,4,1),(25,4,2),(25,4,3),(26,1,1),(26,1,2),(26,1,3),(26,2,1),(26,2,2),(26,2,3),(26,3,1),(26,3,2),(26,3,3),(26,4,1),(26,4,2),(26,4,3),(27,1,1),(27,1,2),(27,1,3),(27,2,1),(27,2,2),(27,2,3),(27,3,1),(27,3,2),(27,3,3),(27,4,1),(27,4,2),(27,4,3),(28,1,1),(28,1,2),(28,1,3),(28,2,1),(28,2,2),(28,2,3),(28,3,1),(28,3,2),(28,3,3),(28,4,1),(28,4,2),(28,4,3),(32,1,1),(32,1,2),(32,1,3),(32,2,1),(32,2,2),(32,2,3),(32,3,1),(32,3,2),(32,3,3),(32,4,1),(32,4,2),(32,4,3),(33,1,1),(33,1,2),(33,1,3),(33,2,1),(33,2,2),(33,2,3),(33,3,1),(33,3,2),(33,3,3),(33,4,1),(33,4,2),(33,4,3),(39,1,1),(39,1,2),(39,1,3),(39,2,1),(39,2,2),(39,2,3),(39,3,1),(39,3,2),(39,3,3),(39,4,1),(39,4,2),(39,4,3),(41,1,1),(41,1,2),(41,1,3),(41,2,1),(41,2,2),(41,2,3),(41,3,1),(41,3,2),(41,3,3),(41,4,1),(41,4,2),(41,4,3),(42,1,1),(42,1,2),(42,1,3),(42,2,1),(42,2,2),(42,2,3),(42,3,1),(42,3,2),(42,3,3),(42,4,1),(42,4,2),(42,4,3),(43,1,1),(43,1,2),(43,1,3),(43,2,1),(43,2,2),(43,2,3),(43,3,1),(43,3,2),(43,3,3),(43,4,1),(43,4,2),(43,4,3),(48,1,1),(48,1,2),(48,1,3),(48,2,1),(48,2,2),(48,2,3),(48,3,1),(48,3,2),(48,3,3),(48,4,1),(48,4,2),(48,4,3),(51,1,1),(51,1,2),(51,1,3),(51,2,1),(51,2,2),(51,2,3),(51,3,1),(51,3,2),(51,3,3),(51,4,1),(51,4,2),(51,4,3),(57,1,1),(57,1,2),(57,1,3),(57,2,1),(57,2,2),(57,2,3),(57,3,1),(57,3,2),(57,3,3),(57,4,1),(57,4,2),(57,4,3),(58,1,1),(58,1,2),(58,1,3),(58,2,1),(58,2,2),(58,2,3),(58,3,1),(58,3,2),(58,3,3),(58,4,1),(58,4,2),(58,4,3),(60,1,1),(60,1,2),(60,1,3),(60,2,1),(60,2,2),(60,2,3),(60,3,1),(60,3,2),(60,3,3),(60,4,1),(60,4,2),(60,4,3),(61,1,1),(61,1,2),(61,1,3),(61,2,1),(61,2,2),(61,2,3),(61,3,1),(61,3,2),(61,3,3),(61,4,1),(61,4,2),(61,4,3),(62,1,1),(62,1,2),(62,1,3),(62,2,1),(62,2,2),(62,2,3),(62,3,1),(62,3,2),(62,3,3),(62,4,1),(62,4,2),(62,4,3),(68,1,1),(68,1,2),(68,1,3),(68,2,1),(68,2,2),(68,2,3),(68,3,1),(68,3,2),(68,3,3),(68,4,1),(68,4,2),(68,4,3),(69,1,2),(69,1,3),(69,2,1),(69,2,2),(69,2,3),(69,3,1),(69,3,2),(69,3,3),(69,4,1),(69,4,2),(69,4,3),(71,1,1),(71,1,2),(71,1,3),(71,2,1),(71,2,2),(71,2,3),(71,3,1),(71,3,2),(71,3,3),(71,4,1),(71,4,2),(71,4,3),(72,1,1),(72,1,2),(72,1,3),(72,2,1),(72,2,2),(72,2,3),(72,3,1),(72,3,2),(72,3,3),(72,4,1),(72,4,2),(72,4,3),(73,1,1),(73,1,2),(73,1,3),(73,2,1),(73,2,2),(73,2,3),(73,3,1),(73,3,2),(73,3,3),(73,4,1),(73,4,2),(73,4,3),(77,1,1),(77,1,2),(77,1,3),(77,2,1),(77,2,2),(77,2,3),(77,3,1),(77,3,2),(77,3,3),(77,4,1),(77,4,2),(77,4,3),(78,1,2),(78,1,3),(78,2,1),(78,2,2),(78,2,3),(78,3,1),(78,3,2),(78,3,3),(78,4,1),(78,4,2),(78,4,3),(79,1,1),(79,1,2),(79,1,3),(79,2,1),(79,2,2),(79,2,3),(79,3,1),(79,3,2),(79,3,3),(79,4,1),(79,4,2),(79,4,3),(80,1,1),(80,1,2),(80,1,3),(80,2,1),(80,2,2),(80,2,3),(80,3,1),(80,3,2),(80,3,3),(80,4,1),(80,4,2),(80,4,3),(81,1,2),(81,1,3),(81,2,1),(81,2,2),(81,2,3),(81,3,1),(81,3,2),(81,3,3),(81,4,1),(81,4,2),(81,4,3),(82,1,1),(82,1,2),(82,1,3),(82,2,1),(82,2,2),(82,2,3),(82,3,1),(82,3,2),(82,3,3),(82,4,1),(82,4,2),(82,4,3),(94,1,1),(94,1,2),(94,1,3),(94,2,1),(94,2,2),(94,2,3),(94,3,1),(94,3,2),(94,3,3),(94,4,1),(94,4,2),(94,4,3),(95,1,1),(95,1,2),(95,1,3),(95,2,1),(95,2,2),(95,2,3),(95,3,1),(95,3,2),(95,3,3),(95,4,1),(95,4,2),(95,4,3),(96,1,1),(96,1,2),(96,1,3),(96,2,1),(96,2,2),(96,2,3),(96,3,1),(96,3,2),(96,3,3),(96,4,1),(96,4,2),(96,4,3),(97,1,1),(97,1,2),(97,1,3),(97,2,1),(97,2,2),(97,2,3),(97,3,1),(97,3,2),(97,3,3),(97,4,1),(97,4,2),(97,4,3),(98,1,1),(98,1,2),(98,1,3),(98,2,1),(98,2,2),(98,2,3),(98,3,1),(98,3,2),(98,3,3),(98,4,1),(98,4,2),(98,4,3),(100,1,1),(100,1,2),(100,1,3),(100,2,1),(100,2,2),(100,2,3),(100,3,1),(100,3,2),(100,3,3),(100,4,1),(100,4,2),(100,4,3),(101,1,1),(101,1,2),(101,1,3),(101,2,1),(101,2,2),(101,2,3),(101,3,1),(101,3,2),(101,3,3),(101,4,1),(101,4,2),(101,4,3),(102,1,1),(102,1,2),(102,1,3),(102,2,1),(102,2,2),(102,2,3),(102,3,1),(102,3,2),(102,3,3),(102,4,1),(102,4,2),(102,4,3),(103,1,1),(103,1,2),(103,1,3),(103,2,1),(103,2,2),(103,2,3),(103,3,1),(103,3,2),(103,3,3),(103,4,1),(103,4,2),(103,4,3),(104,1,1),(104,1,2),(104,1,3),(104,2,1),(104,2,2),(104,2,3),(104,3,1),(104,3,2),(104,3,3),(104,4,1),(104,4,2),(104,4,3),(105,1,1),(105,1,2),(105,1,3),(105,2,1),(105,2,2),(105,2,3),(105,3,1),(105,3,2),(105,3,3),(105,4,1),(105,4,2),(105,4,3),(106,1,1),(106,1,2),(106,1,3),(106,2,1),(106,2,2),(106,2,3),(106,3,1),(106,3,2),(106,3,3),(106,4,1),(106,4,2),(106,4,3),(107,1,1),(107,1,2),(107,1,3),(107,2,1),(107,2,2),(107,2,3),(107,3,1),(107,3,2),(107,3,3),(107,4,1),(107,4,2),(107,4,3),(108,1,1),(108,1,2),(108,1,3),(108,2,1),(108,2,2),(108,2,3),(108,3,1),(108,3,2),(108,3,3),(108,4,1),(108,4,2),(108,4,3),(109,1,1),(109,1,2),(109,1,3),(109,2,1),(109,2,2),(109,2,3),(109,3,1),(109,3,2),(109,3,3),(109,4,1),(109,4,2),(109,4,3),(110,1,1),(110,1,2),(110,1,3),(110,2,1),(110,2,2),(110,2,3),(110,3,1),(110,3,2),(110,3,3),(110,4,1),(110,4,2),(110,4,3),(111,1,1),(111,1,2),(111,1,3),(111,2,1),(111,2,2),(111,2,3),(111,3,1),(111,3,2),(111,3,3),(111,4,1),(111,4,2),(111,4,3),(112,1,1),(112,1,2),(112,1,3),(112,2,1),(112,2,2),(112,2,3),(112,3,1),(112,3,2),(112,3,3),(112,4,1),(112,4,2),(112,4,3),(113,1,1),(113,1,2),(113,1,3),(113,2,1),(113,2,2),(113,2,3),(113,3,1),(113,3,2),(113,3,3),(113,4,1),(113,4,2),(113,4,3),(114,1,1),(114,1,2),(114,1,3),(114,2,1),(114,2,2),(114,2,3),(114,3,1),(114,3,2),(114,3,3),(114,4,1),(114,4,2),(114,4,3);
/*!40000 ALTER TABLE `ps_module_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module_history`
--

DROP TABLE IF EXISTS `ps_module_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_employee` int(11) NOT NULL,
  `id_module` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module_history`
--

LOCK TABLES `ps_module_history` WRITE;
/*!40000 ALTER TABLE `ps_module_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_module_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module_preference`
--

DROP TABLE IF EXISTS `ps_module_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_preference` (
  `id_module_preference` int(11) NOT NULL AUTO_INCREMENT,
  `id_employee` int(11) NOT NULL,
  `module` varchar(255) NOT NULL,
  `interest` tinyint(1) DEFAULT NULL,
  `favorite` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_module_preference`),
  UNIQUE KEY `employee_module` (`id_employee`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module_preference`
--

LOCK TABLES `ps_module_preference` WRITE;
/*!40000 ALTER TABLE `ps_module_preference` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_module_preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_module_shop`
--

DROP TABLE IF EXISTS `ps_module_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_module_shop` (
  `id_module` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `enable_device` tinyint(1) NOT NULL DEFAULT '7',
  PRIMARY KEY (`id_module`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_module_shop`
--

LOCK TABLES `ps_module_shop` WRITE;
/*!40000 ALTER TABLE `ps_module_shop` DISABLE KEYS */;
INSERT INTO `ps_module_shop` VALUES (1,1,7),(1,2,7),(1,3,7),(1,4,7),(5,1,7),(5,2,7),(5,3,7),(5,4,7),(8,1,7),(8,2,7),(8,3,7),(8,4,7),(9,1,7),(9,2,7),(9,3,7),(9,4,7),(11,1,7),(11,2,7),(11,3,7),(11,4,7),(12,1,7),(12,2,7),(12,3,7),(12,4,7),(14,1,7),(14,2,7),(14,3,7),(14,4,7),(15,1,7),(15,2,7),(15,3,7),(15,4,7),(16,1,7),(16,2,7),(16,3,7),(16,4,7),(17,1,7),(17,2,7),(17,3,7),(17,4,7),(18,1,7),(18,2,7),(18,3,7),(18,4,7),(19,1,7),(19,2,7),(19,3,7),(19,4,7),(20,1,7),(20,2,7),(20,3,7),(20,4,7),(21,1,7),(21,2,7),(21,3,7),(21,4,7),(22,1,7),(22,2,7),(22,3,7),(22,4,7),(23,1,7),(23,2,7),(23,3,7),(23,4,7),(24,1,7),(24,2,7),(24,3,7),(24,4,7),(25,1,7),(25,2,7),(25,3,7),(25,4,7),(26,1,7),(26,2,7),(26,3,7),(26,4,7),(27,1,7),(27,2,7),(27,3,7),(27,4,7),(28,1,7),(28,2,7),(28,3,7),(28,4,7),(32,1,7),(32,2,7),(32,3,7),(32,4,7),(33,1,7),(33,2,7),(33,3,7),(33,4,7),(39,1,7),(39,2,7),(39,3,7),(39,4,7),(41,1,7),(41,2,7),(41,3,7),(41,4,7),(42,1,7),(42,2,7),(42,3,7),(42,4,7),(43,1,7),(43,2,7),(43,3,7),(43,4,7),(48,1,7),(48,2,7),(48,3,7),(48,4,7),(51,1,7),(51,2,7),(51,3,7),(51,4,7),(57,1,7),(57,2,7),(57,3,7),(57,4,7),(58,2,7),(58,3,7),(58,4,7),(60,1,7),(60,2,7),(60,3,7),(60,4,7),(61,1,7),(61,2,7),(61,3,7),(61,4,7),(62,2,7),(62,3,7),(62,4,7),(68,1,7),(68,2,7),(68,3,7),(68,4,7),(69,1,7),(69,2,7),(69,3,7),(69,4,7),(71,1,7),(71,2,7),(71,3,7),(71,4,7),(77,1,7),(77,2,7),(77,3,7),(77,4,7),(78,1,7),(78,2,7),(78,3,7),(78,4,7),(79,1,7),(79,2,7),(79,3,7),(79,4,7),(80,1,7),(80,2,7),(80,3,7),(80,4,7),(81,1,7),(81,2,7),(81,3,7),(81,4,7),(82,1,7),(82,2,7),(82,3,7),(82,4,7),(94,1,7),(94,2,7),(94,3,7),(94,4,7),(95,1,7),(95,2,7),(95,3,7),(95,4,7),(96,1,7),(96,2,7),(96,3,7),(96,4,7),(97,1,7),(97,2,7),(97,3,7),(97,4,7),(98,1,7),(98,2,7),(98,3,7),(98,4,7),(100,1,7),(100,2,7),(100,3,7),(100,4,7),(101,1,7),(102,1,7),(103,1,7),(104,1,7),(105,1,7),(105,2,7),(105,3,7),(105,4,7),(106,1,7),(106,2,7),(106,3,7),(106,4,7),(107,1,7),(107,2,7),(107,3,7),(107,4,7),(108,1,7),(108,2,7),(108,3,7),(108,4,7),(109,1,7),(109,2,7),(109,3,7),(109,4,7),(110,1,7),(110,2,7),(110,3,7),(110,4,7),(111,1,7),(111,2,7),(111,3,7),(111,4,7),(112,1,7),(113,1,7),(114,1,7);
/*!40000 ALTER TABLE `ps_module_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_operating_system`
--

DROP TABLE IF EXISTS `ps_operating_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_operating_system` (
  `id_operating_system` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_operating_system`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_operating_system`
--

LOCK TABLES `ps_operating_system` WRITE;
/*!40000 ALTER TABLE `ps_operating_system` DISABLE KEYS */;
INSERT INTO `ps_operating_system` VALUES (1,'Windows XP'),(2,'Windows Vista'),(3,'Windows 7'),(4,'Windows 8'),(5,'Windows 8.1'),(6,'Windows 10'),(7,'MacOsX'),(8,'Linux'),(9,'Android');
/*!40000 ALTER TABLE `ps_operating_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_carrier`
--

DROP TABLE IF EXISTS `ps_order_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_carrier` (
  `id_order_carrier` int(11) NOT NULL AUTO_INCREMENT,
  `id_order` int(11) unsigned NOT NULL,
  `id_carrier` int(11) unsigned NOT NULL,
  `id_order_invoice` int(11) unsigned DEFAULT NULL,
  `weight` decimal(20,6) DEFAULT NULL,
  `shipping_cost_tax_excl` decimal(20,6) DEFAULT NULL,
  `shipping_cost_tax_incl` decimal(20,6) DEFAULT NULL,
  `tracking_number` varchar(64) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_carrier`),
  KEY `id_order` (`id_order`),
  KEY `id_carrier` (`id_carrier`),
  KEY `id_order_invoice` (`id_order_invoice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_carrier`
--

LOCK TABLES `ps_order_carrier` WRITE;
/*!40000 ALTER TABLE `ps_order_carrier` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_cart_rule`
--

DROP TABLE IF EXISTS `ps_order_cart_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_cart_rule` (
  `id_order_cart_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned NOT NULL,
  `id_cart_rule` int(10) unsigned NOT NULL,
  `id_order_invoice` int(10) unsigned DEFAULT '0',
  `name` varchar(254) NOT NULL,
  `value` decimal(17,2) NOT NULL DEFAULT '0.00',
  `value_tax_excl` decimal(17,2) NOT NULL DEFAULT '0.00',
  `free_shipping` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_order_cart_rule`),
  KEY `id_order` (`id_order`),
  KEY `id_cart_rule` (`id_cart_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_cart_rule`
--

LOCK TABLES `ps_order_cart_rule` WRITE;
/*!40000 ALTER TABLE `ps_order_cart_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_cart_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_detail`
--

DROP TABLE IF EXISTS `ps_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_detail` (
  `id_order_detail` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned NOT NULL,
  `id_order_invoice` int(11) DEFAULT NULL,
  `id_warehouse` int(10) unsigned DEFAULT '0',
  `id_shop` int(11) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `product_attribute_id` int(10) unsigned DEFAULT NULL,
  `id_customization` int(10) unsigned DEFAULT '0',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `product_quantity_in_stock` int(10) NOT NULL DEFAULT '0',
  `product_quantity_refunded` int(10) unsigned NOT NULL DEFAULT '0',
  `product_quantity_return` int(10) unsigned NOT NULL DEFAULT '0',
  `product_quantity_reinjected` int(10) unsigned NOT NULL DEFAULT '0',
  `product_price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `reduction_percent` decimal(10,2) NOT NULL DEFAULT '0.00',
  `reduction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `reduction_amount_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `reduction_amount_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `group_reduction` decimal(10,2) NOT NULL DEFAULT '0.00',
  `product_quantity_discount` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `product_ean13` varchar(13) DEFAULT NULL,
  `product_isbn` varchar(32) DEFAULT NULL,
  `product_upc` varchar(12) DEFAULT NULL,
  `product_reference` varchar(64) DEFAULT NULL,
  `product_supplier_reference` varchar(64) DEFAULT NULL,
  `product_weight` decimal(20,6) NOT NULL,
  `id_tax_rules_group` int(11) unsigned DEFAULT '0',
  `tax_computation_method` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tax_name` varchar(16) NOT NULL,
  `tax_rate` decimal(10,3) NOT NULL DEFAULT '0.000',
  `ecotax` decimal(21,6) NOT NULL DEFAULT '0.000000',
  `ecotax_tax_rate` decimal(5,3) NOT NULL DEFAULT '0.000',
  `discount_quantity_applied` tinyint(1) NOT NULL DEFAULT '0',
  `download_hash` varchar(255) DEFAULT NULL,
  `download_nb` int(10) unsigned DEFAULT '0',
  `download_deadline` datetime DEFAULT NULL,
  `total_price_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_price_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `unit_price_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `unit_price_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_shipping_price_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_shipping_price_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `purchase_supplier_price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `original_product_price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `original_wholesale_price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`id_order_detail`),
  KEY `order_detail_order` (`id_order`),
  KEY `product_id` (`product_id`,`product_attribute_id`),
  KEY `product_attribute_id` (`product_attribute_id`),
  KEY `id_tax_rules_group` (`id_tax_rules_group`),
  KEY `id_order_id_order_detail` (`id_order`,`id_order_detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_detail`
--

LOCK TABLES `ps_order_detail` WRITE;
/*!40000 ALTER TABLE `ps_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_detail_tax`
--

DROP TABLE IF EXISTS `ps_order_detail_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_detail_tax` (
  `id_order_detail` int(11) NOT NULL,
  `id_tax` int(11) NOT NULL,
  `unit_amount` decimal(16,6) NOT NULL DEFAULT '0.000000',
  `total_amount` decimal(16,6) NOT NULL DEFAULT '0.000000',
  KEY `id_order_detail` (`id_order_detail`),
  KEY `id_tax` (`id_tax`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_detail_tax`
--

LOCK TABLES `ps_order_detail_tax` WRITE;
/*!40000 ALTER TABLE `ps_order_detail_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_detail_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_history`
--

DROP TABLE IF EXISTS `ps_order_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_history` (
  `id_order_history` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_employee` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `id_order_state` int(10) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_history`),
  KEY `order_history_order` (`id_order`),
  KEY `id_employee` (`id_employee`),
  KEY `id_order_state` (`id_order_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_history`
--

LOCK TABLES `ps_order_history` WRITE;
/*!40000 ALTER TABLE `ps_order_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_invoice`
--

DROP TABLE IF EXISTS `ps_order_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_invoice` (
  `id_order_invoice` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `delivery_number` int(11) NOT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `total_discount_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_discount_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_paid_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_paid_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_products` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_products_wt` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_shipping_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_shipping_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `shipping_tax_computation_method` int(10) unsigned NOT NULL,
  `total_wrapping_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_wrapping_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `shop_address` text,
  `note` text,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_invoice`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_invoice`
--

LOCK TABLES `ps_order_invoice` WRITE;
/*!40000 ALTER TABLE `ps_order_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_invoice_payment`
--

DROP TABLE IF EXISTS `ps_order_invoice_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_invoice_payment` (
  `id_order_invoice` int(11) unsigned NOT NULL,
  `id_order_payment` int(11) unsigned NOT NULL,
  `id_order` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_order_invoice`,`id_order_payment`),
  KEY `order_payment` (`id_order_payment`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_invoice_payment`
--

LOCK TABLES `ps_order_invoice_payment` WRITE;
/*!40000 ALTER TABLE `ps_order_invoice_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_invoice_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_invoice_tax`
--

DROP TABLE IF EXISTS `ps_order_invoice_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_invoice_tax` (
  `id_order_invoice` int(11) NOT NULL,
  `type` varchar(15) NOT NULL,
  `id_tax` int(11) NOT NULL,
  `amount` decimal(10,6) NOT NULL DEFAULT '0.000000',
  KEY `id_tax` (`id_tax`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_invoice_tax`
--

LOCK TABLES `ps_order_invoice_tax` WRITE;
/*!40000 ALTER TABLE `ps_order_invoice_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_invoice_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_message`
--

DROP TABLE IF EXISTS `ps_order_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_message` (
  `id_order_message` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_message`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='預設訊息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_message`
--

LOCK TABLES `ps_order_message` WRITE;
/*!40000 ALTER TABLE `ps_order_message` DISABLE KEYS */;
INSERT INTO `ps_order_message` VALUES (1,'2018-09-21 23:55:06');
/*!40000 ALTER TABLE `ps_order_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_message_lang`
--

DROP TABLE IF EXISTS `ps_order_message_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_message_lang` (
  `id_order_message` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id_order_message`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_message_lang`
--

LOCK TABLES `ps_order_message_lang` WRITE;
/*!40000 ALTER TABLE `ps_order_message_lang` DISABLE KEYS */;
INSERT INTO `ps_order_message_lang` VALUES (1,1,'7-11 已出貨','您好，包裹已寄出，7-11交貨便追蹤號碼：OOOOOOOO，預計2日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤 ，方可取貨。感謝支持！'),(1,2,'7-11 已出貨','您好，包裹已寄出，7-11交貨便追蹤號碼：OOOOOOOO，預計2日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤 ，方可取貨。感謝支持！'),(1,3,'7-11 已出貨','您好，包裹已寄出，7-11交貨便追蹤號碼：OOOOOOOO，預計2日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤 ，方可取貨。感謝支持！'),(1,4,'7-11 已出貨','您好，包裹已寄出，7-11交貨便追蹤號碼：OOOOOOOO，預計2日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤 ，方可取貨。感謝支持！');
/*!40000 ALTER TABLE `ps_order_message_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_payment`
--

DROP TABLE IF EXISTS `ps_order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_payment` (
  `id_order_payment` int(11) NOT NULL AUTO_INCREMENT,
  `order_reference` varchar(16) DEFAULT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `conversion_rate` decimal(13,6) NOT NULL DEFAULT '1.000000',
  `transaction_id` varchar(254) DEFAULT NULL,
  `card_number` varchar(254) DEFAULT NULL,
  `card_brand` varchar(254) DEFAULT NULL,
  `card_expiration` char(7) DEFAULT NULL,
  `card_holder` varchar(254) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_order_payment`),
  KEY `order_reference` (`order_reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_payment`
--

LOCK TABLES `ps_order_payment` WRITE;
/*!40000 ALTER TABLE `ps_order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_return`
--

DROP TABLE IF EXISTS `ps_order_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_return` (
  `id_order_return` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `question` text NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_order_return`),
  KEY `order_return_customer` (`id_customer`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_return`
--

LOCK TABLES `ps_order_return` WRITE;
/*!40000 ALTER TABLE `ps_order_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_return_detail`
--

DROP TABLE IF EXISTS `ps_order_return_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_return_detail` (
  `id_order_return` int(10) unsigned NOT NULL,
  `id_order_detail` int(10) unsigned NOT NULL,
  `id_customization` int(10) unsigned NOT NULL DEFAULT '0',
  `product_quantity` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_order_return`,`id_order_detail`,`id_customization`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_return_detail`
--

LOCK TABLES `ps_order_return_detail` WRITE;
/*!40000 ALTER TABLE `ps_order_return_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_return_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_return_state`
--

DROP TABLE IF EXISTS `ps_order_return_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_return_state` (
  `id_order_return_state` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `color` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_order_return_state`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_return_state`
--

LOCK TABLES `ps_order_return_state` WRITE;
/*!40000 ALTER TABLE `ps_order_return_state` DISABLE KEYS */;
INSERT INTO `ps_order_return_state` VALUES (1,'#4169E1'),(2,'#8A2BE2'),(3,'#32CD32'),(4,'#DC143C'),(5,'#108510');
/*!40000 ALTER TABLE `ps_order_return_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_return_state_lang`
--

DROP TABLE IF EXISTS `ps_order_return_state_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_return_state_lang` (
  `id_order_return_state` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id_order_return_state`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_return_state_lang`
--

LOCK TABLES `ps_order_return_state_lang` WRITE;
/*!40000 ALTER TABLE `ps_order_return_state_lang` DISABLE KEYS */;
INSERT INTO `ps_order_return_state_lang` VALUES (1,1,'等待確認'),(1,2,'Waiting for confirmation'),(1,3,'Waiting for confirmation'),(1,4,'確認待ち'),(2,1,'等待包裹'),(2,2,'Waiting for package'),(2,3,'Waiting for package'),(2,4,'梱包作業待ち'),(3,1,'包裹已收到'),(3,2,'Package received'),(3,3,'Package received'),(3,4,'受取完了'),(4,1,'退貨被拒絕'),(4,2,'Return denied'),(4,3,'Return denied'),(4,4,'返品拒否'),(5,1,'退貨完成'),(5,2,'Return completed'),(5,3,'Return completed'),(5,4,'返品完了');
/*!40000 ALTER TABLE `ps_order_return_state_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_slip`
--

DROP TABLE IF EXISTS `ps_order_slip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_slip` (
  `id_order_slip` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `conversion_rate` decimal(13,6) NOT NULL DEFAULT '1.000000',
  `id_customer` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `total_products_tax_excl` decimal(20,6) DEFAULT NULL,
  `total_products_tax_incl` decimal(20,6) DEFAULT NULL,
  `total_shipping_tax_excl` decimal(20,6) DEFAULT NULL,
  `total_shipping_tax_incl` decimal(20,6) DEFAULT NULL,
  `shipping_cost` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `amount` decimal(10,2) NOT NULL,
  `shipping_cost_amount` decimal(10,2) NOT NULL,
  `partial` tinyint(1) NOT NULL,
  `order_slip_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_order_slip`),
  KEY `order_slip_customer` (`id_customer`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_slip`
--

LOCK TABLES `ps_order_slip` WRITE;
/*!40000 ALTER TABLE `ps_order_slip` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_slip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_slip_detail`
--

DROP TABLE IF EXISTS `ps_order_slip_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_slip_detail` (
  `id_order_slip` int(10) unsigned NOT NULL,
  `id_order_detail` int(10) unsigned NOT NULL,
  `product_quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `unit_price_tax_excl` decimal(20,6) DEFAULT NULL,
  `unit_price_tax_incl` decimal(20,6) DEFAULT NULL,
  `total_price_tax_excl` decimal(20,6) DEFAULT NULL,
  `total_price_tax_incl` decimal(20,6) DEFAULT NULL,
  `amount_tax_excl` decimal(20,6) DEFAULT NULL,
  `amount_tax_incl` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`id_order_slip`,`id_order_detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_slip_detail`
--

LOCK TABLES `ps_order_slip_detail` WRITE;
/*!40000 ALTER TABLE `ps_order_slip_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_slip_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_slip_detail_tax`
--

DROP TABLE IF EXISTS `ps_order_slip_detail_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_slip_detail_tax` (
  `id_order_slip_detail` int(11) unsigned NOT NULL,
  `id_tax` int(11) unsigned NOT NULL,
  `unit_amount` decimal(16,6) NOT NULL DEFAULT '0.000000',
  `total_amount` decimal(16,6) NOT NULL DEFAULT '0.000000',
  KEY `id_order_slip_detail` (`id_order_slip_detail`),
  KEY `id_tax` (`id_tax`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_slip_detail_tax`
--

LOCK TABLES `ps_order_slip_detail_tax` WRITE;
/*!40000 ALTER TABLE `ps_order_slip_detail_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_order_slip_detail_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_state`
--

DROP TABLE IF EXISTS `ps_order_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_state` (
  `id_order_state` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice` tinyint(1) unsigned DEFAULT '0',
  `send_email` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `module_name` varchar(255) DEFAULT NULL,
  `color` varchar(32) DEFAULT NULL,
  `unremovable` tinyint(1) unsigned NOT NULL,
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `logable` tinyint(1) NOT NULL DEFAULT '0',
  `delivery` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `shipped` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `paid` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pdf_invoice` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pdf_delivery` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sort` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_order_state`),
  KEY `module_name` (`module_name`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_state`
--

LOCK TABLES `ps_order_state` WRITE;
/*!40000 ALTER TABLE `ps_order_state` DISABLE KEYS */;
INSERT INTO `ps_order_state` VALUES (1,0,0,'ps_checkpayment','#FDA729',1,0,0,0,0,0,0,0,0,4),(2,1,0,'','#f37382',1,0,1,0,0,1,1,0,0,31),(3,1,0,'','#f37382',1,0,1,1,0,1,0,0,0,61),(4,1,1,'','#1aa3d9',1,0,1,1,1,1,0,0,0,62),(5,1,0,'','#92c325',1,0,1,1,1,1,0,0,0,64),(6,0,1,'','#666e7f',1,0,0,0,0,0,0,0,0,91),(7,1,1,'','#666e7f',1,0,0,0,0,0,0,0,0,82),(8,0,1,'','#666e7f',1,0,0,0,0,0,0,0,0,92),(9,1,0,'','#f37382',1,0,0,0,0,1,0,0,0,33),(10,0,0,'ps_wirepayment','#FDA729',1,0,0,0,0,0,0,0,0,5),(11,1,0,'','#FDA729',1,0,1,0,0,1,0,0,1,0),(12,0,0,'','#FDA729',1,0,0,0,0,0,0,0,0,21),(13,0,0,'ps_cashondelivery','#8992C4',1,0,0,0,0,0,0,0,1,0),(14,0,0,'smilepay_c2c','#8992C4',1,0,0,0,0,0,0,0,0,1),(17,0,0,'smilepay_EZCAT','#8992C4',1,0,0,0,0,0,0,0,0,2),(19,0,0,'smilepay_credit','#FDA729',1,0,0,0,0,0,0,0,0,7),(20,0,0,'smilepay_atm','#FDA729',1,0,0,0,0,0,0,0,0,6),(21,1,0,'','#666e7f',1,0,0,0,0,0,0,0,0,94),(22,1,0,'','#92c325',1,0,0,0,0,0,0,0,0,81),(23,0,0,'paypal','#4169E1',1,0,0,0,0,0,0,0,0,17),(24,0,0,'paypal','#4169E1',1,0,0,0,0,0,0,0,0,18),(25,0,0,'','#4169E1',1,0,0,0,0,0,0,0,0,3),(26,0,0,'','#3b5aa1',1,0,0,0,0,0,0,0,1,0),(27,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,0,7),(28,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,0,8),(29,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,0,9),(30,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,0,10),(31,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,1,11),(32,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,0,12),(33,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,1,13),(34,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,1,14),(35,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,1,15),(36,0,0,'ecpay','#FDA729',1,0,0,0,0,0,0,0,1,16),(37,1,0,'','#92c325',1,0,1,1,1,1,0,0,0,65),(38,0,0,'','#666e7f',1,0,0,0,0,0,0,0,0,93);
/*!40000 ALTER TABLE `ps_order_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_order_state_lang`
--

DROP TABLE IF EXISTS `ps_order_state_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_order_state_lang` (
  `id_order_state` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `template` varchar(64) NOT NULL,
  PRIMARY KEY (`id_order_state`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_order_state_lang`
--

LOCK TABLES `ps_order_state_lang` WRITE;
/*!40000 ALTER TABLE `ps_order_state_lang` DISABLE KEYS */;
INSERT INTO `ps_order_state_lang` VALUES (1,1,'待付款','cheque'),(1,2,'Awaiting for payment','cheque'),(1,3,'待付款','cheque'),(1,4,'入金待ち','cheque'),(2,1,'已付款','payment'),(2,2,'Payment accepted','payment'),(2,3,'已付款','payment'),(2,4,'入金済','payment'),(3,1,'準備出貨','preparation'),(3,2,'Processing in progress','preparation'),(3,3,'准备出货','preparation'),(3,4,'出荷準備中','preparation'),(4,1,'已出貨','shipped'),(4,2,'Shipped','shipped'),(4,3,'已出货','shipped'),(4,4,'出荷','shipped'),(5,1,'已送達門市',''),(5,2,'CVS Store Delivered',''),(5,3,'已送达门市',''),(5,4,'コンビニ受取配達完了',''),(6,1,'已取消','order_canceled'),(6,2,'Canceled','order_canceled'),(6,3,'已取消','order_canceled'),(6,4,'キャンセル','order_canceled'),(7,1,'已退款','refund'),(7,2,'Refund','refund'),(7,3,'已退款','refund'),(7,4,'返金完了','refund'),(8,1,'付款失敗','payment_error'),(8,2,'Payment error','payment_error'),(8,3,'付款失败','payment_error'),(8,4,'支払い失敗','payment_error'),(9,1,'已付款（無庫存）','outofstock'),(9,2,'On backorder (paid)','outofstock'),(9,3,'已付款（无库存）','outofstock'),(9,4,'入金済（商品取り寄せ中）','outofstock'),(10,1,'待付款（轉帳匯款）','bankwire'),(10,2,'Awaiting for Bank transfer payment','bankwire'),(10,3,'待付款（转帐汇款）','bankwire'),(10,4,'入金待ち（銀行振込）','bankwire'),(11,1,'已付款（遠端付款）','payment'),(11,2,'Remote payment accepted','payment'),(11,3,'已付款（远端付款）','payment'),(11,4,'確認済（リモートペイメント）','payment'),(12,1,'待付款（無庫存）','outofstock'),(12,2,'Awaiting payment (On backorder)','outofstock'),(12,3,'待付款（无库存）','outofstock'),(12,4,'入金待ち（在庫切れ）','outofstock'),(13,1,'已付款（貨到付款）','cashondelivery'),(13,2,'Cash on delivery payment accepted','cashondelivery'),(13,3,'已付款（货到付款）','cashondelivery'),(13,4,'確認済（リモートペイメント）','cashondelivery'),(14,1,'處理中（貨到付款）',''),(14,2,'Payment upon pickup in progress',''),(14,3,'处理中（货到付款）',''),(14,4,'注文受付（受取り時支払い）',''),(17,1,'處理中（貨到付現）',''),(17,2,'Cash on home delivery in progress',''),(17,3,'处理中（货到付现）',''),(17,4,'注文受付（宅急便 クロネコ-代金引換）',''),(19,1,'待付款（SmilePay 信用卡）',''),(19,2,'Awaiting for SmilePay Credit card payment',''),(19,3,'待付款（SmilePay 信用卡）',''),(19,4,'支払い中（SmilePay クレジットカード）',''),(20,1,'待付款（ATM 虛擬帳號）',''),(20,2,'Awaiting for ATM payment',''),(20,3,'待付款（ATM 虚拟帐号）',''),(20,4,'支払い中（ATM）',''),(21,1,'退貨處理中',''),(21,2,'Return in progress',''),(21,3,'退货处理中',''),(21,4,'返品待ち',''),(22,1,'已歸檔',''),(22,2,'Archived',''),(22,3,'已归档',''),(22,4,'処理完了',''),(23,1,'待付款（PayPal）',''),(23,2,'Awaiting for PayPal payment',''),(23,3,'待付款（PayPal）',''),(23,4,'Awaiting for PayPal payment',''),(24,1,'待付款（Braintree）',''),(24,2,'Awaiting for Braintree payment',''),(24,3,'待付款（Braintree）',''),(24,4,'Awaiting for Braintree payment',''),(25,1,'等待驗證（Braintree）',''),(25,2,'Awaiting for Braintree validation',''),(25,3,'等待验证（Braintree）',''),(25,4,'Awaiting for Braintree validation',''),(26,1,'售完','outofstock'),(26,2,'Sold out','outofstock'),(26,3,'售完','outofstock'),(26,4,'Sold out','outofstock'),(27,1,'待付款（信用卡）',''),(27,2,'Awaiting for Credit card payment',''),(27,3,'待付款（信用卡）',''),(27,4,'クレジットカード 支払い中',''),(28,1,'待付款（信用卡3期） ',''),(28,2,'Awaiting for Credit card (3 instalments) payment',''),(28,3,'待付款（信用卡3期） ',''),(28,4,'支払い中（クレジットカード3期）',''),(29,1,'待付款（信用卡6期） ',''),(29,2,'Awaiting for Credit card (6 instalments) payment',''),(29,3,'待付款（信用卡6期） ',''),(29,4,'支払い中（クレジットカード6期）',''),(30,1,'待付款（信用卡12期） ',''),(30,2,'Awaiting for Credit card (12 instalments) payment',''),(30,3,'待付款（信用卡12期） ',''),(30,4,'支払い中（クレジットカード12期）',''),(31,1,'待付款（信用卡18期） ',''),(31,2,'Awaiting for Credit card (18 instalments) payment',''),(31,3,'待付款（ECPay 信用卡18期） ',''),(31,4,'支払い中（クレジットカード18期）',''),(32,1,'待付款（信用卡24期） ',''),(32,2,'Awaiting for Credit card (24 instalments) payment',''),(32,3,'待付款（信用卡24期） ',''),(32,4,'支払い中（クレジットカード24期）',''),(33,1,'待付款（ECPay WebATM）',''),(33,2,'Awaiting for WebATM payment',''),(33,3,'待付款（WebATM）',''),(33,4,'支払い中（WebATM）',''),(34,1,'待付款（ECPay ATM）',''),(34,2,'Awaiting for ATM payment',''),(34,3,'待付款（ATM）',''),(34,4,'支払い中（ATM）',''),(35,1,'待付款（ECPay 超商條碼）',''),(35,2,'Awaiting for Barcode payment',''),(35,3,'待付款（超商条码）',''),(35,4,'支払い中（Barcode）',''),(36,1,'待付款（ECPay 超商代碼）',''),(36,2,'Awaiting for CVS payment',''),(36,3,'待付款（超商代码）',''),(36,4,'支払い中（CVS）',''),(37,1,'已取件',''),(37,2,'Picked up',''),(37,3,'已取件',''),(37,4,'已取件',''),(38,1,'未取件',''),(38,2,'Not picked up',''),(38,3,'未取件',''),(38,4,'未取件','');
/*!40000 ALTER TABLE `ps_order_state_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_orders`
--

DROP TABLE IF EXISTS `ps_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_orders` (
  `id_order` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reference` varchar(16) DEFAULT NULL,
  `id_shop_group` int(11) unsigned NOT NULL DEFAULT '1',
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_carrier` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_cart` int(10) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `id_address_delivery` int(10) unsigned NOT NULL,
  `id_address_invoice` int(10) unsigned NOT NULL,
  `current_state` int(10) unsigned NOT NULL,
  `secure_key` varchar(32) NOT NULL DEFAULT '-1',
  `payment` varchar(255) NOT NULL,
  `conversion_rate` decimal(13,6) NOT NULL DEFAULT '1.000000',
  `module` varchar(255) DEFAULT NULL,
  `recyclable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `gift` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `gift_message` text,
  `mobile_theme` tinyint(1) NOT NULL DEFAULT '0',
  `shipping_number` varchar(64) DEFAULT NULL,
  `total_discounts` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_discounts_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_discounts_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_paid` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_paid_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_paid_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_paid_real` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_products` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_products_wt` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_shipping` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_shipping_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_shipping_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `carrier_tax_rate` decimal(10,3) NOT NULL DEFAULT '0.000',
  `total_wrapping` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_wrapping_tax_incl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `total_wrapping_tax_excl` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `round_mode` tinyint(1) NOT NULL DEFAULT '2',
  `round_type` tinyint(1) NOT NULL DEFAULT '1',
  `invoice_number` int(10) unsigned NOT NULL DEFAULT '0',
  `delivery_number` int(10) unsigned NOT NULL DEFAULT '0',
  `invoice_date` datetime NOT NULL,
  `delivery_date` datetime NOT NULL,
  `valid` int(1) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `payment_message` text COMMENT '後台訂單付款訊息',
  PRIMARY KEY (`id_order`),
  KEY `reference` (`reference`),
  KEY `id_customer` (`id_customer`),
  KEY `id_cart` (`id_cart`),
  KEY `invoice_number` (`invoice_number`),
  KEY `id_carrier` (`id_carrier`),
  KEY `id_lang` (`id_lang`),
  KEY `id_currency` (`id_currency`),
  KEY `id_address_delivery` (`id_address_delivery`),
  KEY `id_address_invoice` (`id_address_invoice`),
  KEY `id_shop_group` (`id_shop_group`),
  KEY `current_state` (`current_state`),
  KEY `id_shop` (`id_shop`),
  KEY `date_add` (`date_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_orders`
--

LOCK TABLES `ps_orders` WRITE;
/*!40000 ALTER TABLE `ps_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_pack`
--

DROP TABLE IF EXISTS `ps_pack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pack` (
  `id_product_pack` int(10) unsigned NOT NULL,
  `id_product_item` int(10) unsigned NOT NULL,
  `id_product_attribute_item` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_product_pack`,`id_product_item`,`id_product_attribute_item`),
  KEY `product_item` (`id_product_item`,`id_product_attribute_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_pack`
--

LOCK TABLES `ps_pack` WRITE;
/*!40000 ALTER TABLE `ps_pack` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_pack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_page`
--

DROP TABLE IF EXISTS `ps_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_page` (
  `id_page` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_page_type` int(10) unsigned NOT NULL,
  `id_object` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_page`),
  KEY `id_page_type` (`id_page_type`),
  KEY `id_object` (`id_object`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_page`
--

LOCK TABLES `ps_page` WRITE;
/*!40000 ALTER TABLE `ps_page` DISABLE KEYS */;
INSERT INTO `ps_page` VALUES (1,3,NULL);
/*!40000 ALTER TABLE `ps_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_page_type`
--

DROP TABLE IF EXISTS `ps_page_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_page_type` (
  `id_page_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_page_type`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_page_type`
--

LOCK TABLES `ps_page_type` WRITE;
/*!40000 ALTER TABLE `ps_page_type` DISABLE KEYS */;
INSERT INTO `ps_page_type` VALUES (26,'addresses'),(5,'authentication'),(10,'cart'),(8,'category'),(29,'changeStore'),(4,'cms'),(14,'contact'),(16,'discount'),(20,'guest-tracking'),(11,'history'),(17,'identity'),(1,'index'),(12,'my-account'),(27,'myaccount'),(7,'order'),(15,'order-confirmation'),(13,'order-detail'),(22,'order-follow'),(24,'orderconfirmation'),(23,'orderdetail'),(3,'pagenotfound'),(18,'prices-drop'),(6,'product'),(9,'search'),(2,'sitemap'),(28,'updateStore'),(21,'verification'),(19,'viewed-products'),(25,'viewedproducts');
/*!40000 ALTER TABLE `ps_page_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_page_viewed`
--

DROP TABLE IF EXISTS `ps_page_viewed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_page_viewed` (
  `id_page` int(10) unsigned NOT NULL,
  `id_shop_group` int(10) unsigned NOT NULL DEFAULT '1',
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `id_date_range` int(10) unsigned NOT NULL,
  `counter` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_page`,`id_date_range`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_page_viewed`
--

LOCK TABLES `ps_page_viewed` WRITE;
/*!40000 ALTER TABLE `ps_page_viewed` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_page_viewed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_pagenotfound`
--

DROP TABLE IF EXISTS `ps_pagenotfound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_pagenotfound` (
  `id_pagenotfound` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `id_shop_group` int(10) unsigned NOT NULL DEFAULT '1',
  `request_uri` varchar(256) NOT NULL,
  `http_referer` varchar(256) NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_pagenotfound`),
  KEY `date_add` (`date_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_pagenotfound`
--

LOCK TABLES `ps_pagenotfound` WRITE;
/*!40000 ALTER TABLE `ps_pagenotfound` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_pagenotfound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_paypal_capture`
--

DROP TABLE IF EXISTS `ps_paypal_capture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_capture` (
  `id_paypal_capture` int(11) NOT NULL AUTO_INCREMENT,
  `id_capture` varchar(55) DEFAULT NULL,
  `id_paypal_order` int(11) DEFAULT NULL,
  `capture_amount` float DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_paypal_capture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_paypal_capture`
--

LOCK TABLES `ps_paypal_capture` WRITE;
/*!40000 ALTER TABLE `ps_paypal_capture` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_paypal_capture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_paypal_customer`
--

DROP TABLE IF EXISTS `ps_paypal_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_customer` (
  `id_paypal_customer` int(11) NOT NULL AUTO_INCREMENT,
  `id_customer` int(11) DEFAULT NULL,
  `reference` varchar(55) DEFAULT NULL,
  `method` varchar(55) DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_upd` datetime DEFAULT NULL,
  PRIMARY KEY (`id_paypal_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_paypal_customer`
--

LOCK TABLES `ps_paypal_customer` WRITE;
/*!40000 ALTER TABLE `ps_paypal_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_paypal_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_paypal_order`
--

DROP TABLE IF EXISTS `ps_paypal_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_order` (
  `id_paypal_order` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned NOT NULL,
  `id_cart` int(10) unsigned NOT NULL,
  `id_transaction` varchar(255) NOT NULL,
  `id_payment` varchar(255) NOT NULL,
  `client_token` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `total_paid` decimal(10,2) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `total_prestashop` decimal(10,2) NOT NULL,
  `method` varchar(255) NOT NULL,
  `payment_tool` varchar(255) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `sandbox` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id_paypal_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_paypal_order`
--

LOCK TABLES `ps_paypal_order` WRITE;
/*!40000 ALTER TABLE `ps_paypal_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_paypal_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_paypal_processlogger`
--

DROP TABLE IF EXISTS `ps_paypal_processlogger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_processlogger` (
  `id_paypal_processlogger` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned NOT NULL,
  `id_cart` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `id_transaction` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `log` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sandbox` tinyint(1) unsigned NOT NULL,
  `tools` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_add` datetime NOT NULL,
  `date_transaction` datetime NOT NULL,
  PRIMARY KEY (`id_paypal_processlogger`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_paypal_processlogger`
--

LOCK TABLES `ps_paypal_processlogger` WRITE;
/*!40000 ALTER TABLE `ps_paypal_processlogger` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_paypal_processlogger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_paypal_vaulting`
--

DROP TABLE IF EXISTS `ps_paypal_vaulting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_paypal_vaulting` (
  `id_paypal_vaulting` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) unsigned NOT NULL,
  `rememberedCards` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sandbox` tinyint(1) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_paypal_vaulting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_paypal_vaulting`
--

LOCK TABLES `ps_paypal_vaulting` WRITE;
/*!40000 ALTER TABLE `ps_paypal_vaulting` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_paypal_vaulting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product`
--

DROP TABLE IF EXISTS `ps_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product` (
  `id_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_supplier` int(10) unsigned DEFAULT NULL,
  `id_manufacturer` int(10) unsigned DEFAULT NULL,
  `id_category_default` int(10) unsigned DEFAULT NULL,
  `id_shop_default` int(10) unsigned NOT NULL DEFAULT '1',
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `on_sale` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `online_only` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ean13` varchar(13) DEFAULT NULL,
  `isbn` varchar(32) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `ecotax` decimal(17,6) NOT NULL DEFAULT '0.000000',
  `quantity` int(10) NOT NULL DEFAULT '0',
  `minimal_quantity` int(10) unsigned NOT NULL DEFAULT '1',
  `low_stock_threshold` int(10) DEFAULT NULL,
  `low_stock_alert` tinyint(1) NOT NULL DEFAULT '0',
  `price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `wholesale_price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `unity` varchar(255) DEFAULT NULL,
  `unit_price_ratio` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `additional_shipping_cost` decimal(20,2) NOT NULL DEFAULT '0.00',
  `reference` varchar(64) DEFAULT NULL,
  `supplier_reference` varchar(64) DEFAULT NULL,
  `location` varchar(64) DEFAULT NULL,
  `width` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `height` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `depth` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `weight` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `out_of_stock` int(10) unsigned NOT NULL DEFAULT '2',
  `additional_delivery_times` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `quantity_discount` tinyint(1) DEFAULT '0',
  `customizable` tinyint(2) NOT NULL DEFAULT '0',
  `uploadable_files` tinyint(4) NOT NULL DEFAULT '0',
  `text_fields` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `redirect_type` enum('','404','301-product','302-product','301-category','302-category') NOT NULL DEFAULT '',
  `id_type_redirected` int(10) unsigned NOT NULL DEFAULT '0',
  `available_for_order` tinyint(1) NOT NULL DEFAULT '1',
  `available_date` date DEFAULT NULL,
  `show_condition` tinyint(1) NOT NULL DEFAULT '0',
  `condition` enum('new','used','refurbished') NOT NULL DEFAULT 'new',
  `show_price` tinyint(1) NOT NULL DEFAULT '1',
  `indexed` tinyint(1) NOT NULL DEFAULT '0',
  `visibility` enum('both','catalog','search','none') NOT NULL DEFAULT 'both',
  `cache_is_pack` tinyint(1) NOT NULL DEFAULT '0',
  `cache_has_attachments` tinyint(1) NOT NULL DEFAULT '0',
  `is_virtual` tinyint(1) NOT NULL DEFAULT '0',
  `cache_default_attribute` int(10) unsigned DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `advanced_stock_management` tinyint(1) NOT NULL DEFAULT '0',
  `pack_stock_type` int(11) unsigned NOT NULL DEFAULT '3',
  `state` int(11) unsigned NOT NULL DEFAULT '1',
  `sticker` varchar(32) NOT NULL COMMENT '貼紙',
  PRIMARY KEY (`id_product`),
  KEY `product_supplier` (`id_supplier`),
  KEY `product_manufacturer` (`id_manufacturer`,`id_product`),
  KEY `id_category_default` (`id_category_default`),
  KEY `indexed` (`indexed`),
  KEY `date_add` (`date_add`),
  KEY `state` (`state`,`date_upd`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product`
--

LOCK TABLES `ps_product` WRITE;
/*!40000 ALTER TABLE `ps_product` DISABLE KEYS */;
INSERT INTO `ps_product` VALUES (1,0,0,13,1,0,0,0,'','','',0.000000,0,1,NULL,0,10000.000000,0.000000,'本',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 15:18:52','2020-04-15 22:30:37',0,3,1,''),(2,0,0,13,1,0,0,0,'','','',0.000000,0,1,NULL,0,23100.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,6,'2018-06-17 18:32:17','2020-03-21 00:45:00',0,3,1,''),(3,0,0,13,1,0,0,0,'','','',0.000000,0,1,NULL,0,1500.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 18:35:12','2020-03-21 00:45:00',0,3,1,''),(4,0,0,13,1,0,0,0,'','','',0.000000,0,1,NULL,0,10000.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 18:35:23','2020-03-20 13:36:45',0,3,1,''),(5,0,0,13,1,0,0,0,'','','',0.000000,0,1,NULL,0,0.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,0,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 18:38:03','2020-03-20 13:36:52',0,3,1,''),(6,0,0,9,1,0,0,0,'','','',0.000000,0,1,NULL,0,50.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 18:38:11','2020-03-20 13:36:46',0,3,1,''),(8,0,0,9,1,0,0,0,'','','',0.000000,0,5,NULL,0,20.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 18:38:21','2020-03-20 13:36:46',0,3,1,''),(9,0,0,10,1,0,0,0,'','','',0.000000,0,1,NULL,0,180.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 18:38:25','2020-03-20 13:36:46',0,3,1,''),(10,0,0,10,1,0,0,0,'','','',0.000000,0,1,NULL,0,180.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 18:38:30','2020-03-20 13:36:46',0,3,1,''),(11,0,0,10,1,0,0,0,'','','',0.000000,0,1,NULL,0,300.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,0,'2018-06-17 18:38:37','2020-04-09 20:35:29',0,3,1,''),(12,0,0,10,1,0,0,0,'','','',0.000000,0,1,NULL,0,150.000000,0.000000,'',0.000000,0.00,'T123456-789(b)','','',0.000000,0.000000,0.000000,0.000000,2,1,0,1,1,1,1,'404',0,1,'2018-11-30',1,'used',1,1,'both',0,0,0,0,'2018-06-17 18:38:42','2020-03-20 13:36:47',0,3,1,''),(13,0,0,11,1,0,0,0,'','','',0.000000,0,1,NULL,0,1800.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,0,3,'2018-06-17 18:38:47','2020-03-20 13:36:47',0,3,1,''),(14,0,0,12,1,0,0,0,'','','',0.000000,0,1,NULL,0,1800.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,1,0,'2019-10-04 13:39:05','2020-03-20 13:36:47',0,3,1,''),(15,0,0,12,1,0,0,0,'','','',0.000000,0,1,NULL,0,50000.000000,0.000000,'',0.000000,0.00,'','','',0.000000,0.000000,0.000000,0.000000,2,1,0,0,0,0,1,'404',0,1,'0000-00-00',1,'new',1,1,'both',0,0,0,9,'2019-10-04 13:39:05','2020-04-14 23:20:31',0,3,1,'');
/*!40000 ALTER TABLE `ps_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_attachment`
--

DROP TABLE IF EXISTS `ps_product_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attachment` (
  `id_product` int(10) unsigned NOT NULL,
  `id_attachment` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_attachment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_attachment`
--

LOCK TABLES `ps_product_attachment` WRITE;
/*!40000 ALTER TABLE `ps_product_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_product_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_attribute`
--

DROP TABLE IF EXISTS `ps_product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attribute` (
  `id_product_attribute` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `reference` varchar(64) DEFAULT NULL,
  `supplier_reference` varchar(64) DEFAULT NULL,
  `location` varchar(64) DEFAULT NULL,
  `ean13` varchar(13) DEFAULT NULL,
  `isbn` varchar(32) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `wholesale_price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `ecotax` decimal(17,6) NOT NULL DEFAULT '0.000000',
  `quantity` int(10) NOT NULL DEFAULT '0',
  `weight` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `unit_price_impact` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `default_on` tinyint(1) unsigned DEFAULT NULL,
  `minimal_quantity` int(10) unsigned NOT NULL DEFAULT '1',
  `low_stock_threshold` int(10) DEFAULT NULL,
  `low_stock_alert` tinyint(1) NOT NULL DEFAULT '0',
  `available_date` date DEFAULT NULL,
  PRIMARY KEY (`id_product_attribute`),
  UNIQUE KEY `product_default` (`id_product`,`default_on`),
  KEY `product_attribute_product` (`id_product`),
  KEY `reference` (`reference`),
  KEY `supplier_reference` (`supplier_reference`),
  KEY `id_product_id_product_attribute` (`id_product_attribute`,`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_attribute`
--

LOCK TABLES `ps_product_attribute` WRITE;
/*!40000 ALTER TABLE `ps_product_attribute` DISABLE KEYS */;
INSERT INTO `ps_product_attribute` VALUES (1,13,'','','','','','',0.000000,0.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(2,13,'','','','','','',0.000000,0.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(3,13,'','','','','','',0.000000,0.000000,0.000000,0,0.000000,0.000000,1,1,NULL,0,'0000-00-00'),(4,13,'','','','','','',0.000000,0.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(5,13,'','','','','','',0.000000,0.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(6,2,'','','','','','',0.000000,230.000000,0.000000,0,0.000000,0.000000,1,1,NULL,0,'0000-00-00'),(7,2,'','','','','','',0.000000,2300.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(8,2,'','','','','','',0.000000,23100.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(9,15,'','','','','','',0.000000,50.000000,0.000000,0,0.000000,0.000000,1,1,NULL,0,'0000-00-00'),(10,15,'','','','','','',0.000000,0.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(11,15,'','','','','','',0.000000,100.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(12,15,'','','','','','',0.000000,0.000000,0.000000,0,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00');
/*!40000 ALTER TABLE `ps_product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_attribute_combination`
--

DROP TABLE IF EXISTS `ps_product_attribute_combination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attribute_combination` (
  `id_attribute` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_attribute`,`id_product_attribute`),
  KEY `id_product_attribute` (`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_attribute_combination`
--

LOCK TABLES `ps_product_attribute_combination` WRITE;
/*!40000 ALTER TABLE `ps_product_attribute_combination` DISABLE KEYS */;
INSERT INTO `ps_product_attribute_combination` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12);
/*!40000 ALTER TABLE `ps_product_attribute_combination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_attribute_image`
--

DROP TABLE IF EXISTS `ps_product_attribute_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attribute_image` (
  `id_product_attribute` int(10) unsigned NOT NULL,
  `id_image` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product_attribute`,`id_image`),
  KEY `id_image` (`id_image`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_attribute_image`
--

LOCK TABLES `ps_product_attribute_image` WRITE;
/*!40000 ALTER TABLE `ps_product_attribute_image` DISABLE KEYS */;
INSERT INTO `ps_product_attribute_image` VALUES (9,20),(9,33),(12,34),(10,35),(11,36);
/*!40000 ALTER TABLE `ps_product_attribute_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_attribute_shop`
--

DROP TABLE IF EXISTS `ps_product_attribute_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_attribute_shop` (
  `id_product` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `wholesale_price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `ecotax` decimal(17,6) NOT NULL DEFAULT '0.000000',
  `weight` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `unit_price_impact` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `default_on` tinyint(1) unsigned DEFAULT NULL,
  `minimal_quantity` int(10) unsigned NOT NULL DEFAULT '1',
  `low_stock_threshold` int(10) DEFAULT NULL,
  `low_stock_alert` tinyint(1) NOT NULL DEFAULT '0',
  `available_date` date DEFAULT NULL,
  PRIMARY KEY (`id_product_attribute`,`id_shop`),
  UNIQUE KEY `id_product` (`id_product`,`id_shop`,`default_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_attribute_shop`
--

LOCK TABLES `ps_product_attribute_shop` WRITE;
/*!40000 ALTER TABLE `ps_product_attribute_shop` DISABLE KEYS */;
INSERT INTO `ps_product_attribute_shop` VALUES (13,1,1,0.000000,0.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(13,2,1,0.000000,0.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(13,3,1,0.000000,0.000000,0.000000,0.000000,0.000000,1,1,NULL,0,'0000-00-00'),(13,4,1,0.000000,0.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(13,5,1,0.000000,0.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(2,6,1,0.000000,230.000000,0.000000,0.000000,0.000000,1,1,NULL,0,'0000-00-00'),(2,7,1,0.000000,2300.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(2,8,1,0.000000,23100.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(15,9,1,0.000000,50.000000,0.000000,0.000000,0.000000,1,1,NULL,0,'0000-00-00'),(15,10,1,0.000000,0.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(15,11,1,0.000000,100.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00'),(15,12,1,0.000000,0.000000,0.000000,0.000000,0.000000,NULL,1,NULL,0,'0000-00-00');
/*!40000 ALTER TABLE `ps_product_attribute_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_carrier`
--

DROP TABLE IF EXISTS `ps_product_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_carrier` (
  `id_product` int(10) unsigned NOT NULL,
  `id_carrier_reference` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_carrier_reference`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_carrier`
--

LOCK TABLES `ps_product_carrier` WRITE;
/*!40000 ALTER TABLE `ps_product_carrier` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_product_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_country_tax`
--

DROP TABLE IF EXISTS `ps_product_country_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_country_tax` (
  `id_product` int(11) NOT NULL,
  `id_country` int(11) NOT NULL,
  `id_tax` int(11) NOT NULL,
  PRIMARY KEY (`id_product`,`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_country_tax`
--

LOCK TABLES `ps_product_country_tax` WRITE;
/*!40000 ALTER TABLE `ps_product_country_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_product_country_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_download`
--

DROP TABLE IF EXISTS `ps_product_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_download` (
  `id_product_download` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(10) unsigned NOT NULL,
  `display_filename` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_expiration` datetime DEFAULT NULL,
  `nb_days_accessible` int(10) unsigned DEFAULT NULL,
  `nb_downloadable` int(10) unsigned DEFAULT '1',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_shareable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_product_download`),
  UNIQUE KEY `id_product` (`id_product`),
  KEY `product_active` (`id_product`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_download`
--

LOCK TABLES `ps_product_download` WRITE;
/*!40000 ALTER TABLE `ps_product_download` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_product_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_group_reduction_cache`
--

DROP TABLE IF EXISTS `ps_product_group_reduction_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_group_reduction_cache` (
  `id_product` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `reduction` decimal(4,3) NOT NULL,
  PRIMARY KEY (`id_product`,`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_group_reduction_cache`
--

LOCK TABLES `ps_product_group_reduction_cache` WRITE;
/*!40000 ALTER TABLE `ps_product_group_reduction_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_product_group_reduction_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_lang`
--

DROP TABLE IF EXISTS `ps_product_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_lang` (
  `id_product` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_lang` int(10) unsigned NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description_short` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `link_rewrite` varchar(128) NOT NULL,
  `meta_description` varchar(512) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_title` varchar(128) DEFAULT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `available_now` varchar(255) DEFAULT NULL,
  `available_later` varchar(255) DEFAULT NULL,
  `delivery_in_stock` varchar(255) DEFAULT NULL,
  `delivery_out_stock` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_product`,`id_shop`,`id_lang`),
  KEY `id_lang` (`id_lang`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_lang`
--

LOCK TABLES `ps_product_lang` WRITE;
/*!40000 ALTER TABLE `ps_product_lang` DISABLE KEYS */;
INSERT INTO `ps_product_lang` VALUES (1,1,1,'<p>Reproduction published in 2010 <br /> First edition of 20<br /> Full color digital offset printing by Chyaulun with HP indigo 5000 (Hp electrolnk)<br /> 130 gsm white fine art paper - inner page<br /> 187.5 kg Egyptian gold Zipang metallic paper - cover<br /> Black uncoated woodfree paper - cover<br /> Section sewn Coptic binding with exposed spine, larger hole and flat back cover by Yoshosu<br /> 15 cm W x 21 cm H <br /> 143 pages + cover</p>\n<p>複製畫冊於2010年出版<br /> 初版20本<br /> 全彩 HP indigo 數位平版印刷 印刷者僑倫<br /> 厚磅數美術紙內頁，埃及金ジパング紙封面，內襯黑色道林紙<br /> 科普特裝訂 裝訂者盧亭璇<br /> 寬 15 公分 x 長 21 公分<br /> 143頁內頁裸露書背，並有較大的洞口使疊頁之間間隔較窄 ，外加方背封面</p>\n<p>ISBN 978-957-41-7331-0</p>\n<p></p>\n<p><span>In Collection</span> <span>典藏</span></p>\n<ul>\n<li><span>National Central Library 國家圖書館 - Taipei, Taiwan <br /> </span></li>\n<li><span>Taipei National University of the Arts Library 國立臺北藝術大學圖書館 - Taipei, Taiwan <br /> </span></li>\n<li><span>Bank Street Arts - Sheffield, UK <br /> </span></li>\n<li><span>Private Collectors</span></li>\n</ul>\n<p><span>Related Fair</span> <span>展會</span></p>\n<ul>\n<li><span>2015，「Liuyingchieh Books : CODEX V 國際雙年展」，Craneway Pavilion，Richmond，CA，USA</span></li>\n<li><span>2017，「Liuyingchieh Books : CODEX VI 國際雙年展」，Craneway Pavilion，Richmond，CA，USA</span></li>\n</ul>\n<p><span>Related Group Exhibition</span> <span>聯展</span></p>\n<ul>\n<li><span>2013，「4th Sheffield International Artist\'s Book Prize and Exhibition 第四屆雪菲爾國際藝術家的書評選展」，Bank Street Arts，Sheffield，英國</span></li>\n</ul>\n<p><span>Related Solo Exhibition</span> <span>個展</span></p>\n<ul>\n<li><span>2012，「移動記之旅」，清大藝術工坊，新竹，台灣 </span></li>\n<li><span>2014，「Torres del Paine 2004-2014」，書香醒園藝術空間，台北，台灣</span></li>\n<li><span>2016，「移動記─藝術家的書」，國立台灣圖書館雙和藝廊，中和，台灣</span></li>\n</ul>','','travelbook1','','','','《移動記 I ：Venezia，台灣》','','','',''),(1,1,2,'<p>Published in September, 2010.<br />Reproduction of a hand drawn book.<br /><br />Jan.-Feb. 2002, I went to Venice for 2 weeks. That was the first time I stayed in a youth hostel. I was shocked, when I saw bathroom without door curtain in female dorm, when I saw naked body between bedroom and bathroom.<br /><br />I started to draw on this book since September 2002, the beginning of this book is about my memories from Venice youth hostel at Giudecca, and a blonde hair roommate.<br /><br />After several monthes, I started to draw my travel diaries/road comics/road movies book when I traveled around Taiwan by train: Fangliao , Pinghsi - Sandiaoling - Yilan - Hualien - Chingshui Cliff - Alishan ... (枋寮，平溪 - 三貂嶺 - 宜蘭 - 花蓮 - 清水斷崖 - 阿里山 ...)<br /><br />Statement:<br /><br />Interested in preserving the duration of memory, I use books to be the carrier of my creations; through the characteristic of page flipping, showing the movement of time and space, resulting in continuous dynamic imagination.<br /><br />The motivation of my travel is to fulfill the image creation mode with books as the carrier, through the moving of the real body, trying to let my real life imitate my duration of memory.<br /><br />On the road, I opened my book and accumulated my strokes page by page. Pages carry the fragments of time, page flipping creates the flux of becoming, books show the duration of the entire life.<br /><br />\"Creative journey\" is really intended to let the external journey imitate the internal imagination. However, the state of travel itself also lets the creator in contact with unexpected strong stimulation. Experience of these incidents will not disappear overnight. After a long period of precipitation, memories of the last trip will become the base of the next trip; reality and imagination will imitate and promote each other.<br /><br />Through the mode of growth and stacking, repetition and extension to structure the image. Intend to show a spiritual depth instead of the virtual image of three-dimensional distance. Frames in the pages show the sequences of time and space; montage the complex, staggered time and space to express dreams and memories.<br /><br />The binding forms of the carrier become the visual elements throughout the entire artwork; the spread of the book is the moment now, the left pages link to the past and the right pages undertake the future.<br /><br />熱衷於保存記憶的綿延狀態，於是選擇以書冊為創作載體；透過書頁的翻頁特質，呈現時空的轉移，造成連續性的動態想像。<br /><br />旅行的動機是為了成全以書冊為載體的圖像創作模式，透過身體的真正移動，讓真實生活模仿記憶的綿延。<br /><br />在旅途中，翻開書冊，逐頁累積筆觸。書頁承載了片段時刻，翻頁造成變化之流，書冊呈現生命整體的綿延狀態。<br /><br />「創作之旅」確實意圖讓外部旅程模仿內部想像。然而，旅行狀態本身，同時也讓創作者不斷接觸意料之外的強烈刺激。這些意外的經歷並不會隔夜就消失；經過長時間沈澱，上一段旅行的回憶，成為下一段旅行的基底，現實與想像互相模仿、交互推進。<br /><br />透過生長與堆疊、重複與延伸的模式來結構畫面。意圖以心靈空間深度取代三度空間距離的虛像。書頁中的分格，呈現對於純粹繪畫過於複雜的時空序列；以蒙太奇手法並置複雜、交錯的時空，表現夢境、回憶的特質。<br /><br />創作載體之裝訂形式，成為貫穿整本書冊的視覺元素；書冊被攤開的雙頁即是當下，對於左翻書而言，左頁聯繫著過去，右頁承接未來。<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />劉穎捷 2002 2003 = 移動記 Travel Book I （Venezia, 台灣）<br /><br />Memories： Venice<br />*Youth hostel<br />*Bedroom（Dorm bed）<br />*Bathroom（Without door）<br />*Traveler<br />*Roomate（Blonde hair）<br />*Body（Naked）<br />*Wave<br />*Gondola<br /><br />移動記 Road book（旅行寫生 Travel sketch）：台灣 Taiwan<br />*親吻岩 Kissing Stone（鵝鑾鼻 Eluanbi）<br />*從枋寮上車之後 Fangliao<br />*松山車站→平溪線 Pinghsi Line（綠樹）<br />*三貂嶺車站 Sandiaoling Train Station→宜蘭 Yilan（藍海）<br />*第411號列車 Ordinary express train No.411（Stop running）<br />*花蓮 Hualien：一步又一步，接近清水斷崖之中<br />*幸福水泥．和仁 Heren<br />*清水斷崖 Chingshui Cliff（Moonrise）<br />*太平洋日出 Pacific Ocean : Sunrise<br />*奮起湖 Fenqihu（阿里山小火車 Alishan Railway）<br />*花東縱谷 East Rift Valley<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Full color digital lithography printing by HP indigo 5000.<br />Coptic binding with special hole and flat back cover(hand bound by book artist Yoshosu, 9 signatures, section sewn, open flat).<br />130 gsm white fine art paper.<br />187.5 kg Egyptian gold Zipang(ジパング) metallic paper.<br />Black uncoated woodfree paper.<br />14.8 cm x 21 cm.<br />143 pages + cover.<br />Limited first edition of 20, numbered. This listing is for № 14.<br /><br />ISBN 978-957-41-7331-0<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />In Collection 典藏<br />◆ National Central Library 國家圖書館 - Taipei, Taiwan<br />◆ Taipei National University of the Arts Library 國立臺北藝術大學圖書館 - Taipei, Taiwan<br />◆ Bank Street Arts - Sheffield, UK<br />◆ Private Collectors<br /><br />Related Fair 展會<br />◆ 2015，「Liuyingchieh Books : CODEX V 國際雙年展」，Craneway Pavilion，Richmond，CA，USA<br />◆ 2017，「Liuyingchieh Books : CODEX VI 國際雙年展」，Craneway Pavilion，Richmond，CA，USA<br /><br />Related Group Exhibition 聯展<br />◆ 2013，「4th Sheffield International Artist\'s Book Prize and Exhibition 第四屆雪菲爾國際藝術家的書評選展」，Bank Street Arts，Sheffield，英國<br /><br />Related Solo Exhibition 個展<br />◆ 2012，「移動記之旅」，清大藝術工坊，新竹，台灣<br />◆ 2014，「Torres del Paine 2004-2014」，書香醒園藝術空間，台北，台灣<br />◆ 2016，「移動記─藝術家的書」，國立台灣圖書館雙和藝廊，中和，台灣<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Original artwork remains the property of Ying-Chieh Liu and the buyer is not entitled to reproduction rights.<br /><br />© Ying-Chieh Liu</p>','','travelbook1','','','','Travel Book I : Venice, Taiwan','','','',''),(1,1,3,'<p>Reproduction published in 2010 <br /> First edition of 20<br /> Full color digital offset printing by Chyaulun with HP indigo 5000 (Hp electrolnk)<br /> 130 gsm white fine art paper - inner page<br /> 187.5 kg Egyptian gold Zipang metallic paper - cover<br /> Black uncoated woodfree paper - cover<br /> Section sewn Coptic binding with exposed spine, larger hole and flat back cover by Yoshosu<br /> 15 cm W x 21 cm H <br /> 143 pages + cover</p>\n<p>複製画册于2010年出版<br /> 初版20本<br /> 全彩 HP indigo 数位平版印刷 印刷者侨伦<br /> 厚磅数美术纸内页，埃及金ジパング纸封面，内衬黑色道林纸<br /> 科普特装订 装订者卢亭璇<br /> 宽 15 公分 x 长 21 公分<br /> 143页内页裸露书背，并有较大的洞口使叠页之间间隔较窄 ，外加方背封面</p>\n<p>ISBN 978-957-41-7331-0</p>\n<p></p>\n<p><span>In Collection</span> <span>典藏</span></p>\n<ul>\n<li><span>National Central Library 国家图书馆 - Taipei, Taiwan <br /> </span></li>\n<li><span>Taipei National University of the Arts Library 国立臺北艺术大学图书馆 - Taipei, Taiwan <br /> </span></li>\n<li><span>Bank Street Arts - Sheffield, UK <br /> </span></li>\n<li><span>Private Collectors</span></li>\n</ul>\n<p><span>Related Fair</span> <span>展会</span></p>\n<ul>\n<li><span>2015，「Liuyingchieh Books : CODEX V 国际双年展」，Craneway Pavilion，Richmond，CA，USA</span></li>\n<li><span>2017，「Liuyingchieh Books : CODEX VI 国际双年展」，Craneway Pavilion，Richmond，CA，USA</span></li>\n</ul>\n<p><span>Related Group Exhibition</span> <span>联展</span></p>\n<ul>\n<li><span>2013，「4th Sheffield International Artist\'s Book Prize and Exhibition 第四届雪菲尔国际艺术家的书评选展」，Bank Street Arts，Sheffield，英国</span></li>\n</ul>\n<p><span>Related Solo Exhibition</span> <span>个展</span></p>\n<ul>\n<li><span>2012，「移动记之旅」，清大艺术工坊，新竹，台湾 </span></li>\n<li><span>2014，「Torres del Paine 2004-2014」，书香醒园艺术空间，台北，台湾</span></li>\n<li><span>2016，「移动记─艺术家的书」，国立台湾图书馆双和艺廊，中和，台湾</span></li>\n</ul>','','travelbook1','','','','《移动记 I ：Venezia，台湾》','','','',''),(1,1,4,'<p>Published in September, 2010.<br />Reproduction of a hand drawn book.<br /><br />Jan.-Feb. 2002, I went to Venice for 2 weeks. That was the first time I stayed in a youth hostel. I was shocked, when I saw bathroom without door curtain in female dorm, when I saw naked body between bedroom and bathroom.<br /><br />I started to draw on this book since September 2002, the beginning of this book is about my memories from Venice youth hostel at Giudecca, and a blonde hair roommate.<br /><br />After several monthes, I started to draw my travel diaries/road comics/road movies book when I traveled around Taiwan by train: Fangliao , Pinghsi - Sandiaoling - Yilan - Hualien - Chingshui Cliff - Alishan ... (枋寮，平溪 - 三貂嶺 - 宜蘭 - 花蓮 - 清水斷崖 - 阿里山 ...)<br /><br />Statement:<br /><br />Interested in preserving the duration of memory, I use books to be the carrier of my creations; through the characteristic of page flipping, showing the movement of time and space, resulting in continuous dynamic imagination.<br /><br />The motivation of my travel is to fulfill the image creation mode with books as the carrier, through the moving of the real body, trying to let my real life imitate my duration of memory.<br /><br />On the road, I opened my book and accumulated my strokes page by page. Pages carry the fragments of time, page flipping creates the flux of becoming, books show the duration of the entire life.<br /><br />\"Creative journey\" is really intended to let the external journey imitate the internal imagination. However, the state of travel itself also lets the creator in contact with unexpected strong stimulation. Experience of these incidents will not disappear overnight. After a long period of precipitation, memories of the last trip will become the base of the next trip; reality and imagination will imitate and promote each other.<br /><br />Through the mode of growth and stacking, repetition and extension to structure the image. Intend to show a spiritual depth instead of the virtual image of three-dimensional distance. Frames in the pages show the sequences of time and space; montage the complex, staggered time and space to express dreams and memories.<br /><br />The binding forms of the carrier become the visual elements throughout the entire artwork; the spread of the book is the moment now, the left pages link to the past and the right pages undertake the future.<br /><br />熱衷於保存記憶的綿延狀態，於是選擇以書冊為創作載體；透過書頁的翻頁特質，呈現時空的轉移，造成連續性的動態想像。<br /><br />旅行的動機是為了成全以書冊為載體的圖像創作模式，透過身體的真正移動，讓真實生活模仿記憶的綿延。<br /><br />在旅途中，翻開書冊，逐頁累積筆觸。書頁承載了片段時刻，翻頁造成變化之流，書冊呈現生命整體的綿延狀態。<br /><br />「創作之旅」確實意圖讓外部旅程模仿內部想像。然而，旅行狀態本身，同時也讓創作者不斷接觸意料之外的強烈刺激。這些意外的經歷並不會隔夜就消失；經過長時間沈澱，上一段旅行的回憶，成為下一段旅行的基底，現實與想像互相模仿、交互推進。<br /><br />透過生長與堆疊、重複與延伸的模式來結構畫面。意圖以心靈空間深度取代三度空間距離的虛像。書頁中的分格，呈現對於純粹繪畫過於複雜的時空序列；以蒙太奇手法並置複雜、交錯的時空，表現夢境、回憶的特質。<br /><br />創作載體之裝訂形式，成為貫穿整本書冊的視覺元素；書冊被攤開的雙頁即是當下，對於左翻書而言，左頁聯繫著過去，右頁承接未來。<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />劉穎捷 2002 2003 = 移動記 Travel Book I （Venezia, 台灣）<br /><br />Memories： Venice<br />*Youth hostel<br />*Bedroom（Dorm bed）<br />*Bathroom（Without door）<br />*Traveler<br />*Roomate（Blonde hair）<br />*Body（Naked）<br />*Wave<br />*Gondola<br /><br />移動記 Road book（旅行寫生 Travel sketch）：台灣 Taiwan<br />*親吻岩 Kissing Stone（鵝鑾鼻 Eluanbi）<br />*從枋寮上車之後 Fangliao<br />*松山車站→平溪線 Pinghsi Line（綠樹）<br />*三貂嶺車站 Sandiaoling Train Station→宜蘭 Yilan（藍海）<br />*第411號列車 Ordinary express train No.411（Stop running）<br />*花蓮 Hualien：一步又一步，接近清水斷崖之中<br />*幸福水泥．和仁 Heren<br />*清水斷崖 Chingshui Cliff（Moonrise）<br />*太平洋日出 Pacific Ocean : Sunrise<br />*奮起湖 Fenqihu（阿里山小火車 Alishan Railway）<br />*花東縱谷 East Rift Valley<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Full color digital lithography printing by HP indigo 5000.<br />Coptic binding with special hole and flat back cover(hand bound by book artist Yoshosu, 9 signatures, section sewn, open flat).<br />130 gsm white fine art paper.<br />187.5 kg Egyptian gold Zipang(ジパング) metallic paper.<br />Black uncoated woodfree paper.<br />14.8 cm x 21 cm.<br />143 pages + cover.<br />Limited first edition of 20, numbered. This listing is for № 14.<br /><br />ISBN 978-957-41-7331-0<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />In Collection 典藏<br />◆ National Central Library 國家圖書館 - Taipei, Taiwan<br />◆ Taipei National University of the Arts Library 國立臺北藝術大學圖書館 - Taipei, Taiwan<br />◆ Bank Street Arts - Sheffield, UK<br />◆ Private Collectors<br /><br />Related Fair 展會<br />◆ 2015，「Liuyingchieh Books : CODEX V 國際雙年展」，Craneway Pavilion，Richmond，CA，USA<br />◆ 2017，「Liuyingchieh Books : CODEX VI 國際雙年展」，Craneway Pavilion，Richmond，CA，USA<br /><br />Related Group Exhibition 聯展<br />◆ 2013，「4th Sheffield International Artist\'s Book Prize and Exhibition 第四屆雪菲爾國際藝術家的書評選展」，Bank Street Arts，Sheffield，英國<br /><br />Related Solo Exhibition 個展<br />◆ 2012，「移動記之旅」，清大藝術工坊，新竹，台灣<br />◆ 2014，「Torres del Paine 2004-2014」，書香醒園藝術空間，台北，台灣<br />◆ 2016，「移動記─藝術家的書」，國立台灣圖書館雙和藝廊，中和，台灣<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Original artwork remains the property of Ying-Chieh Liu and the buyer is not entitled to reproduction rights.<br /><br />© Ying-Chieh Liu</p>','','travelbook1','','','','Travel Book I : Venice, Taiwan','','','',''),(2,1,1,'','','travelbook4','','','','移動記四《The Significant Travel》','','','',''),(2,1,2,'','','travelbook4','','','','移動記四《The Significant Travel》','','','',''),(2,1,3,'','','travelbook4','','','','移動記四《The Significant Travel》','','','',''),(2,1,4,'','','travelbook4','','','','移動記四《The Significant Travel》','','','',''),(3,1,1,'','','travelbook11','','','','移動記十一《海．洋》','','','',''),(3,1,2,'','','travelbook11','','','','移動記十一《海．洋》','','','',''),(3,1,3,'','','travelbook11','','','','移動記十一《海．洋》','','','',''),(3,1,4,'','','travelbook11','','','','移動記十一《海．洋》','','','',''),(4,1,1,'','','travelbook12','','','','移動記十二《山脈》','','','',''),(4,1,2,'<p><span style=\"font-family:\'-apple-system\', \'system-ui\', \'Segoe UI\', Roboto, Helvetica, Arial, sans-serif;font-size:14px;\">手工縫製一本隨身畫冊，在路上邊走邊畫。</span><br style=\"font-family:\'-apple-system\', \'system-ui\', \'Segoe UI\', Roboto, Helvetica, Arial, sans-serif;font-size:14px;\" /><br style=\"font-family:\'-apple-system\', \'system-ui\', \'Segoe UI\', Roboto, Helvetica, Arial, sans-serif;font-size:14px;\" /><span style=\"font-family:\'-apple-system\', \'system-ui\', \'Segoe UI\', Roboto, Helvetica, Arial, sans-serif;font-size:14px;\">書冊體積小，輕便易攜帶，能收取到繪畫者面對大自然時最感動的線條和筆觸；其頁面接續頁面的結構易於表述時間，呈現宛如記憶綿延的連續動態想像。書冊需要近觀、徒手翻頁的特質，則提供了較為私密、親近人身體的感官體驗。</span></p>','','travelbook12','','','','移動記十二《山脈》','','','',''),(4,1,3,'','','travelbook12','','','','移動記十二《山脈》','','','',''),(4,1,4,'','','travelbook12','','','','移動記十二《山脈》','','','',''),(5,1,1,'<br />','<br />','地球山水冊頁ㄌㄏㄌㄑㄏㄌ','','','','地球山水冊頁—ㄌㄏㄌㄑㄏㄌ 地球山水冊頁—ㄌㄏㄌㄑㄏㄌ 地球山水冊頁—ㄌㄏㄌㄑㄏㄌ','','','',''),(5,1,2,'','','earthlandscapealbum','','','','地球山水冊頁—ㄌㄏㄌㄑㄏㄌ','','','',''),(5,1,3,'','','link','','','','','','','',''),(5,1,4,'','','link','','','','地球山水冊頁—ㄌㄏㄌㄑㄏㄌ#','','','',''),(6,1,1,'<p>Travel Sketch : 2015 清水斷崖 Ching-Shui Cliff Taiwan<br />from Travel Book 11 《海‧洋》 (\"O-cean\")<br /><br />-------------------------------------<br /><br />240g 象牙卡精印<br />105 x 148 mm<br />燙金+燙銀<br /><br />240g Ivory card.<br />105 x 148 mm.<br />Full color offset printing.<br />Gold hot foil stamping.<br />Silver hot foil stamping.<br /><br />-------------------------------------<br /><br />© Ying-Chieh Liu<br />產地/製造方式<br />台灣 手工製作</p>','','goldfoil','','','','清水斷崖（燙金）','','','',''),(6,1,2,'<p>Set of 4 Postcards = Travel Sketches from Travel Book 11 《海．洋》 (\"O-cean\")<br /><br />清水斷崖 Ching-Shui Cliff <br />&amp;<br />七星潭 Chihsingtan Beach<br />@<br />Hualien Taiwan<br /><br />240g Ivory card and metallic card.<br />105 x 148 mm.<br />Full color offset printing.<br />Gold hot foil stamping.<br />Silver hot foil stamping.<br /><br />© Ying-Chieh Liu</p>','','goldfoil','','','','清水斷崖（燙金）','','','',''),(6,1,3,'<p>Travel Sketch : 2015 清水断崖 Ching-Shui Cliff Taiwan<br />from Travel Book 11 《海‧洋》 (\"O-cean\")<br /><br />-------------------------------------<br /><br />240g 象牙卡精印<br />105 x 148 mm<br />烫金+烫银<br /><br />240g Ivory card.<br />105 x 148 mm.<br />Full color offset printing.<br />Gold hot foil stamping.<br />Silver hot foil stamping.<br /><br />-------------------------------------<br /><br />© Ying-Chieh Liu<br />产地/製造方式<br />台湾 手工製作</p>','','goldfoil','','','','清水斷崖（燙金）','','','',''),(6,1,4,'<p>Set of 4 Postcards = Travel Sketches from Travel Book 11 《海．洋》 (\"O-cean\")<br /><br />清水斷崖 Ching-Shui Cliff <br />&amp;<br />七星潭 Chihsingtan Beach<br />@<br />Hualien Taiwan<br /><br />240g Ivory card and metallic card.<br />105 x 148 mm.<br />Full color offset printing.<br />Gold hot foil stamping.<br />Silver hot foil stamping.<br /><br />© Ying-Chieh Liu</p>','','goldfoil','','','','清水斷崖（燙金）','','','',''),(8,1,1,'<p>?<br />Travel Sketches from Travel Book 11 《海．洋》 (\"O-cean\")<br /><br />清水斷崖 Ching-Shui Cliff <br />&amp;<br />七星潭 Chihsingtan Beach<br />@<br />Hualien Taiwan<br /><br />240g Ivory card and metallic card.<br />105 x 148 mm.<br />Full color offset printing.<br />Gold hot foil stamping.<br />Silver hot foil stamping.<br /><br />© Ying-Chieh Liu</p>','','ivorycard','','','','七星潭','','','',''),(8,1,2,'<p>Travel Sketches from Travel Book 11 《海．洋》 (\"O-cean\")<br /><br />清水斷崖 Ching-Shui Cliff <br />&amp;<br />七星潭 Chihsingtan Beach<br />@<br />Hualien Taiwan<br /><br />240g Ivory card and metallic card.<br />105 x 148 mm.<br />Full color offset printing.<br />Gold hot foil stamping.<br />Silver hot foil stamping.<br /><br />© Ying-Chieh Liu</p>','','ivorycard','','','','七星潭','','','',''),(8,1,3,'<p>Travel Sketches from Travel Book 11 《海．洋》 (\"O-cean\")<br /><br />清水斷崖 Ching-Shui Cliff <br />&amp;<br />七星潭 Chihsingtan Beach<br />@<br />Hualien Taiwan<br /><br />240g Ivory card and metallic card.<br />105 x 148 mm.<br />Full color offset printing.<br />Gold hot foil stamping.<br />Silver hot foil stamping.<br /><br />© Ying-Chieh Liu</p>','','七星潭','','','','七星潭','','','',''),(8,1,4,'<p>Travel Sketches from Travel Book 11 《海．洋》 (\"O-cean\")<br /><br />清水斷崖 Ching-Shui Cliff <br />&amp;<br />七星潭 Chihsingtan Beach<br />@<br />Hualien Taiwan<br /><br />240g Ivory card and metallic card.<br />105 x 148 mm.<br />Full color offset printing.<br />Gold hot foil stamping.<br />Silver hot foil stamping.<br /><br />© Ying-Chieh Liu</p>','','七星潭','','','','七星潭','','','',''),(9,1,1,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Designed from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 25 mm wide × 10 m long (10 cm loop)<br /><br />Second edition of 66 (June 2017 printed by Yuanpao)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 30 printed in July, 2016, by Tain, Taiwan.<br />Second edition of 66 printed in June, 2017, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','ocean','','','','海．洋','','','',''),(9,1,2,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Designed from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 25 mm wide × 10 m long (10 cm loop)<br /><br />Second edition of 66 (June 2017 printed by Yuanpao)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 30 printed in July, 2016, by Tain, Taiwan.<br />Second edition of 66 printed in June, 2017, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','ocean','','','','O-cean','','','',''),(9,1,3,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Designed from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海滩，花莲）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 25 mm wide × 10 m long (10 cm loop)<br /><br />Second edition of 66 (June 2017 printed by Yuanpao)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 30 printed in July, 2016, by Tain, Taiwan.<br />Second edition of 66 printed in June, 2017, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','ocean','','','','海．洋','','','',''),(9,1,4,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Designed from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 25 mm wide × 10 m long (10 cm loop)<br /><br />Second edition of 66 (June 2017 printed by Yuanpao)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 30 printed in July, 2016, by Tain, Taiwan.<br />Second edition of 66 printed in June, 2017, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','ocean','','','','O-cean','','','',''),(10,1,1,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Designed from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Japanese Washi paper<br /><br />Set of 2 Rolls :<br />1 roll = 25 mm wide × 10 m long (10 cm loop)<br /><br />First edition of 30 (July 2016 printed by Tain)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 30 printed in July, 2016, by Tain, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','wave','','','','海．洋：淼','','','',''),(10,1,2,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Designed from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Japanese Washi paper<br /><br />Set of 2 Rolls :<br />1 roll = 25 mm wide × 10 m long (10 cm loop)<br /><br />First edition of 30 (July 2016 printed by Tain)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 30 printed in July, 2016, by Tain, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','wave','','','','O-cean','','','',''),(10,1,3,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Designed from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Japanese Washi paper<br /><br />Set of 2 Rolls :<br />1 roll = 25 mm wide × 10 m long (10 cm loop)<br /><br />First edition of 30 (July 2016 printed by Tain)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 30 printed in July, 2016, by Tain, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','wave','','','','海．洋：淼','','','',''),(10,1,4,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Designed from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Japanese Washi paper<br /><br />Set of 2 Rolls :<br />1 roll = 25 mm wide × 10 m long (10 cm loop)<br /><br />First edition of 30 (July 2016 printed by Tain)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 30 printed in July, 2016, by Tain, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','wave','','','','O-cean','','','',''),(11,1,1,'<p>內心山水交錯台灣風景寫生和紙膠帶，<br />繪畫內容來自 Liuyingchieh 原創作品<br />移動記系列之四《The Significant Travel》 <a class=\"m-richtext-el m-richtext-link\" href=\"https://www.pinkoi.com/product/1Y432PEL\" target=\"_blank\" rel=\"noreferrer noopener\">www.pinkoi.com/product/1Y432PEL</a><br /><br />山水手卷卷首卷尾無縫接軌無限循環~<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />✐寫生地點:<br />台灣 (九份/陽明山冷水坑/花蓮/三芝淺水灣/新竹內灣/故宮博物院/書桌前)<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />使用台灣和紙精印<br /><br />初版108捲 每捲編號 (2016.9原寶承印)<br /><br />一捲 = 45 mm 寬 x 10 m 長 (90 cm 循環)<br /><br />Made in Taiwan<br /><br />© Ying-Chieh Liu<br />產地/製造方式<br />台灣</p>','','significanttravel45','','','','The Significant Travel (45mm)','','','',''),(11,1,2,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Taiwanese landscape + Inner landscape masking tape from Liuyingchieh\'s original painting Travel Book Series 4 《The Significant Travel》 : <a href=\"http://www.etsy.com/listing/57177974/the-significant-travel-travel-sketchbook\" target=\"_blank\" rel=\"noreferrer noopener\">http://www.etsy.com/listing/57177974</a><br /><br />山水手卷卷首卷尾無縫接軌無限循環~<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />✐寫生地點：<br />九份<br />陽明山冷水坑<br />花蓮<br />三芝淺水灣<br />新竹內灣<br />故宮博物院<br />書桌前<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 45 mm wide × 10 m long (90 cm loop)<br /><br />First edition of 108 (September 2016 printed by Yuanpao)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 108 printed in September, 2016, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','significanttravel45','','','','The Significant Travel (45mm)','','','',''),(11,1,3,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Taiwanese landscape + Inner landscape masking tape from Liuyingchieh\'s original painting Travel Book Series 4 《The Significant Travel》 : <a href=\"http://www.etsy.com/listing/57177974/the-significant-travel-travel-sketchbook\" target=\"_blank\" rel=\"noreferrer noopener\">http://www.etsy.com/listing/57177974</a><br /><br />山水手卷卷首卷尾無縫接軌無限循環~<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />✐寫生地點：<br />九份<br />陽明山冷水坑<br />花蓮<br />三芝淺水灣<br />新竹內灣<br />故宮博物院<br />書桌前<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 45 mm wide × 10 m long (90 cm loop)<br /><br />First edition of 108 (September 2016 printed by Yuanpao)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 108 printed in September, 2016, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','significanttravel45','','','','The Significant Travel (45mm)','','','',''),(11,1,4,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Taiwanese landscape + Inner landscape masking tape from Liuyingchieh\'s original painting Travel Book Series 4 《The Significant Travel》 : <a href=\"http://www.etsy.com/listing/57177974/the-significant-travel-travel-sketchbook\" target=\"_blank\" rel=\"noreferrer noopener\">http://www.etsy.com/listing/57177974</a><br /><br />山水手卷卷首卷尾無縫接軌無限循環~<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />✐寫生地點：<br />九份<br />陽明山冷水坑<br />花蓮<br />三芝淺水灣<br />新竹內灣<br />故宮博物院<br />書桌前<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 45 mm wide × 10 m long (90 cm loop)<br /><br />First edition of 108 (September 2016 printed by Yuanpao)<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 108 printed in September, 2016, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','significanttravel45','','','','The Significant Travel (45mm)','','','',''),(12,1,1,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Taiwanese landscape + Inner landscape masking tape from Liuyingchieh\'s original painting Travel Book Series 4 《The Significant Travel》 : <a href=\"http://www.etsy.com/listing/57177974/the-significant-travel-travel-sketchbook\" target=\"_blank\" rel=\"noreferrer noopener\">http://www.etsy.com/listing/57177974</a><br /><br />山水手卷卷首卷尾無縫接軌無限循環~<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />✐寫生地點：<br />九份<br />陽明山冷水坑<br />花蓮<br />三芝淺水灣<br />新竹內灣<br />故宮博物院<br />書桌前<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 15 mm wide × 10 m long (30 cm loop)<br /><br />Second edition of 200* (July 2016 printed by Yuanpao)<br /><br />*each one numbered on the back round sticker<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 20 printed in December, 2015, by Dergi, Taiwan. (sold out)<br />Second edition of 200 printed in July, 2016, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','significanttravel15','','','','The Significant Travel (15mm)','','此商品為預購商品','',''),(12,1,2,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Taiwanese landscape + Inner landscape masking tape from Liuyingchieh\'s original painting Travel Book Series 4 《The Significant Travel》 : <a href=\"http://www.etsy.com/listing/57177974/the-significant-travel-travel-sketchbook\" target=\"_blank\" rel=\"noreferrer noopener\">http://www.etsy.com/listing/57177974</a><br /><br />山水手卷卷首卷尾無縫接軌無限循環~<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />✐寫生地點：<br />九份<br />陽明山冷水坑<br />花蓮<br />三芝淺水灣<br />新竹內灣<br />故宮博物院<br />書桌前<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 15 mm wide × 10 m long (30 cm loop)<br /><br />Second edition of 200* (July 2016 printed by Yuanpao)<br /><br />*each one numbered on the back round sticker<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 20 printed in December, 2015, by Dergi, Taiwan. (sold out)<br />Second edition of 200 printed in July, 2016, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','significanttravel15','','','','The Significant Travel (15mm)','','','',''),(12,1,3,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Taiwanese landscape + Inner landscape masking tape from Liuyingchieh\'s original painting Travel Book Series 4 《The Significant Travel》 : <a href=\"http://www.etsy.com/listing/57177974/the-significant-travel-travel-sketchbook\" target=\"_blank\" rel=\"noreferrer noopener\">http://www.etsy.com/listing/57177974</a><br /><br />山水手卷卷首卷尾無縫接軌無限循環~<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />✐寫生地點：<br />九份<br />陽明山冷水坑<br />花蓮<br />三芝淺水灣<br />新竹內灣<br />故宮博物院<br />書桌前<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 15 mm wide × 10 m long (30 cm loop)<br /><br />Second edition of 200* (July 2016 printed by Yuanpao)<br /><br />*each one numbered on the back round sticker<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 20 printed in December, 2015, by Dergi, Taiwan. (sold out)<br />Second edition of 200 printed in July, 2016, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','significanttravel15','','','','The Significant Travel (15mm)','','','',''),(12,1,4,'<p>^___^<br /><br />NEW! SEALED! ONE OF A KIND!<br /><br />Taiwanese landscape + Inner landscape masking tape from Liuyingchieh\'s original painting Travel Book Series 4 《The Significant Travel》 : <a href=\"http://www.etsy.com/listing/57177974/the-significant-travel-travel-sketchbook\" target=\"_blank\" rel=\"noreferrer noopener\">http://www.etsy.com/listing/57177974</a><br /><br />山水手卷卷首卷尾無縫接軌無限循環~<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />✐寫生地點：<br />九份<br />陽明山冷水坑<br />花蓮<br />三芝淺水灣<br />新竹內灣<br />故宮博物院<br />書桌前<br /><br />▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░<br /><br />Taiwanese Washi paper<br /><br />1 roll = 15 mm wide × 10 m long (30 cm loop)<br /><br />Second edition of 200* (July 2016 printed by Yuanpao)<br /><br />*each one numbered on the back round sticker<br /><br />Made in Taiwan<br /><br />✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿°º°✿¨¨¨¨¨¨✿<br /><br />First edition of 20 printed in December, 2015, by Dergi, Taiwan. (sold out)<br />Second edition of 200 printed in July, 2016, by Yuanpao, Taiwan.<br /><br />© Ying-Chieh Liu</p>','','significanttravel15','','','','The Significant Travel (15mm)','','','',''),(13,1,1,'<p>:▏ :▏ :▏:▏ Travel Light ╳ Liuyingchieh :▏ :▏ :▏ :▏吸濕排汗彈性機能褲<br />材質：88 % 聚酯纖維〔輕量吸濕排汗原紗（moisture wicking fabric）〕＋ 12 % 彈性纖維〔四向彈力（4 way stretch）〕、高品質無毒數位熱昇華墨水<br /><br /><img class=\"m-richtext-el m-richtext-img\" src=\"https://img1.etsystatic.com/133/0/5326321/il_fullxfull.1032940305_c4rw.jpg\" alt=\"il_fullxfull.1032940305_c4rw.jpg\" /><br />室內戶外運動 ? 輕裝旅行 ? 日常穿著 ? 均適宜<br />　⚡⚡⚡⚡⚡　保護你不感冒，滿身大汗也不怕吹風～㊣ <br /><img class=\"m-richtext-el m-richtext-img\" src=\"https://img1.etsystatic.com/137/0/5326321/il_fullxfull.1071529753_1oiq.jpg\" alt=\"il_fullxfull.1071529753_1oiq.jpg\" /><br />獨一無二的布料圖案來自 Liuyingchieh 書冊繪畫作品<br />移動記十一《海 ‧ 洋》 2015 清水斷崖匯德遊憩區寫生 <br />寫生地點是在蘇花公路匯德步道<br /><img class=\"m-richtext-el m-richtext-img\" src=\"https://img0.etsystatic.com/115/0/5326321/il_fullxfull.1055945788_79fo.jpg\" alt=\"il_fullxfull.1055945788_79fo.jpg\" /><br /><br />瑜珈動作示範照片提供： 玩瑜珈教室 © Frankie Wang<br />好榮幸【清水斷崖瑜珈褲】可以陪伴瑜珈高手做出高難度動作！<br /><br /><br /><br />:▏ :▏ :▏:▏ Travel Light ╳ Liuyingchieh :▏ :▏ :▏ :▏<br />清水斷崖 吸濕排汗彈性機能褲<br />產地/製造方式<br />台灣設計　㊣　加拿大製作</p>','','yoga','','','','清水斷崖','','','',''),(13,1,2,'<p>Summer 2016.<br /><br />For sport, dancing, yoga, spinning, outdoor, running, hiking, travel light, daily use.<br /><br />88% polyester 12% spandex performance wear fabric, moisture wicking, 4 way stretch, anti microbial.<br />Eco-friendly non-toxic high quality digital sublimation printed.<br />Made to order for your size, XS, S, M, L, XL.<br /><br />:▏ :▏ :▏ :▏ Travel Light ╳ Liuyingchieh :▏ :▏ :▏ :▏<br /><br />Designed in Taiwan - Manufactured in Canada<br /><br />Designed from my original artwork. The one of a kind pattern on the fabric is from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2015, a spread of a travel sketch with pen and ink, in Ching-Shui Cliff, Hualien, Taiwan （清水斷崖，花蓮）, a series of mountain coastal cliffs with rocky pebble beach and clear waves face to the Pacific Ocean.<br /><br />Top Photo by 玩瑜珈教室 © Frankie Wang<br /><br />© Ying-Chieh Liu</p>','','yoga','','','','清水斷崖','','','',''),(13,1,3,'<p>:▏ :▏ :▏:▏ Travel Light ╳ Liuyingchieh :▏ :▏ :▏ :▏吸湿排汗弹性机能裤<br />材质：88 % 聚酯纤维〔轻量吸湿排汗原纱（moisture wicking fabric）〕＋ 12 % 弹性纤维〔四向弹力（4 way stretch）〕、高品质无毒数位热昇华墨水<br /><br /><img class=\"m-richtext-el m-richtext-img\" src=\"https://img1.etsystatic.com/133/0/5326321/il_fullxfull.1032940305_c4rw.jpg\" alt=\"il_fullxfull.1032940305_c4rw.jpg\" /><br />室内户外运动 ? 轻装旅行 ? 日常穿着 ? 均适宜<br />　⚡⚡⚡⚡⚡　保护你不感冒，满身大汗也不怕吹风～㊣ <br /><img class=\"m-richtext-el m-richtext-img\" src=\"https://img1.etsystatic.com/137/0/5326321/il_fullxfull.1071529753_1oiq.jpg\" alt=\"il_fullxfull.1071529753_1oiq.jpg\" /><br />独一无二的布料图案来自 Liuyingchieh 书册绘画作品<br />移动记十一《海 ‧ 洋》 2015 清水断崖汇德游憩区写生 <br />写生地点是在苏花公路汇德步道<br /><img class=\"m-richtext-el m-richtext-img\" src=\"https://img0.etsystatic.com/115/0/5326321/il_fullxfull.1055945788_79fo.jpg\" alt=\"il_fullxfull.1055945788_79fo.jpg\" /><br /><br />瑜珈动作示范照片提供： 玩瑜珈教室 © Frankie Wang<br />好荣幸【清水断崖瑜珈裤】可以陪伴瑜珈高手做出高难度动作！<br /><br /><br /><br />:▏ :▏ :▏:▏ Travel Light ╳ Liuyingchieh :▏ :▏ :▏ :▏<br />清水断崖 吸湿排汗弹性机能裤<br />产地/製造方式<br />台湾设计　㊣　加拿大製作</p>','','yoga','','','','清水斷崖','','','',''),(13,1,4,'<p>Summer 2016.<br /><br />For sport, dancing, yoga, spinning, outdoor, running, hiking, travel light, daily use.<br /><br />88% polyester 12% spandex performance wear fabric, moisture wicking, 4 way stretch, anti microbial.<br />Eco-friendly non-toxic high quality digital sublimation printed.<br />Made to order for your size, XS, S, M, L, XL.<br /><br />:▏ :▏ :▏ :▏ Travel Light ╳ Liuyingchieh :▏ :▏ :▏ :▏<br /><br />Designed in Taiwan - Manufactured in Canada<br /><br />Designed from my original artwork. The one of a kind pattern on the fabric is from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2015, a spread of a travel sketch with pen and ink, in Ching-Shui Cliff, Hualien, Taiwan （清水斷崖，花蓮）, a series of mountain coastal cliffs with rocky pebble beach and clear waves face to the Pacific Ocean.<br /><br />Top Photo by 玩瑜珈教室 © Frankie Wang<br /><br />© Ying-Chieh Liu</p>','','yoga','','','','清水断崖（箔押し）','','','',''),(14,1,1,'<p>銀 / Ying / 戒 / Chieh / #153<br />〈海．洋〉 (O-cean)<br /><br />Inspired by the ocean, the eastern coast of Taiwan. Design from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />3D Printed + Handmade Original = Each One Slightly Different<br /><br />Integrally formed, sturdy, for daily use purpose.<br /><br />Ring size: <br />US 4<br /><br />Band width:<br />2~3 mm<br /><br />Sterling silver (925) * + ☆　★<br /><br />© Ying-Chieh Liu</p>\n<p>銀 / Ying / 戒 / Chieh / #153<br />〈海．洋〉 (O-cean)<br /><br />Inspired by the ocean, the eastern coast of Taiwan. Design from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />3D Printed + Handmade Original = Each One Slightly Different<br /><br />Integrally formed, sturdy, for daily use purpose.<br /><br />Ring size: <br />US 4<br /><br />Band width:<br />2~3 mm<br /><br />Sterling silver (925) * + ☆　★<br /><br />© Ying-Chieh Liu</p>','','silver','','','','海．洋','','','',''),(14,1,2,'<p>銀 / Ying / 戒 / Chieh / #153<br />〈海．洋〉 (O-cean)<br /><br />Inspired by the ocean, the eastern coast of Taiwan. Design from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />3D Printed + Handmade Original = Each One Slightly Different<br /><br />Integrally formed, sturdy, for daily use purpose.<br /><br />Ring size: <br />US 4<br /><br />Band width:<br />2~3 mm<br /><br />Sterling silver (925) * + ☆　★<br /><br />© Ying-Chieh Liu</p>','','silver','','','','O-cean','','','',''),(14,1,3,'<p>銀 / Ying / 戒 / Chieh / #153<br />〈海．洋〉 (O-cean)<br /><br />Inspired by the ocean, the eastern coast of Taiwan. Design from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />3D Printed + Handmade Original = Each One Slightly Different<br /><br />Integrally formed, sturdy, for daily use purpose.<br /><br />Ring size: <br />US 4<br /><br />Band width:<br />2~3 mm<br /><br />Sterling silver (925) * + ☆　★<br /><br />© Ying-Chieh Liu</p>','','silver','','','','海．洋','','','',''),(14,1,4,'<p>銀 / Ying / 戒 / Chieh / #153<br />〈海．洋〉 (O-cean)<br /><br />Inspired by the ocean, the eastern coast of Taiwan. Design from my original drawing / artist\'s book \"Travel Book 11 : O-cean\" （《海．洋》） in 2014, a spread of a travel sketch with pen and ink, in Chishingtan Beach, Hualien, Taiwan （七星潭海灘，花蓮）, a rocky pebble beach with clear waves face to the Pacific Ocean.<br /><br />3D Printed + Handmade Original = Each One Slightly Different<br /><br />Integrally formed, sturdy, for daily use purpose.<br /><br />Ring size: <br />US 4<br /><br />Band width:<br />2~3 mm<br /><br />Sterling silver (925) * + ☆　★<br /><br />© Ying-Chieh Liu</p>','','silver','','','','O-cean','','','',''),(15,1,1,'','','enamel','','','','海．洋（琺瑯）','','','',''),(15,1,2,'','','enamel','','','','海．洋（琺瑯）','','','',''),(15,1,3,'','','enamel','','','','海．洋（琺瑯）','','','',''),(15,1,4,'','','enamel','','','','海．洋（琺瑯）','','','','');
/*!40000 ALTER TABLE `ps_product_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_sale`
--

DROP TABLE IF EXISTS `ps_product_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_sale` (
  `id_product` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `sale_nbr` int(10) unsigned NOT NULL DEFAULT '0',
  `date_upd` date DEFAULT NULL,
  PRIMARY KEY (`id_product`),
  KEY `quantity` (`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_sale`
--

LOCK TABLES `ps_product_sale` WRITE;
/*!40000 ALTER TABLE `ps_product_sale` DISABLE KEYS */;
INSERT INTO `ps_product_sale` VALUES (2,1,1,'2018-09-07'),(3,1,1,'2018-09-08'),(4,1,1,'2018-10-11'),(6,4,4,'2018-09-21'),(8,4,4,'2018-09-18'),(9,5,5,'2018-12-08'),(10,13,12,'2020-02-17'),(11,13,9,'2019-07-10'),(12,2,2,'2020-04-19'),(14,2,2,'2018-09-22');
/*!40000 ALTER TABLE `ps_product_sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_shop`
--

DROP TABLE IF EXISTS `ps_product_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_shop` (
  `id_product` int(10) unsigned NOT NULL,
  `id_shop` int(10) unsigned NOT NULL,
  `id_category_default` int(10) unsigned DEFAULT NULL,
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `on_sale` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `online_only` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ecotax` decimal(17,6) NOT NULL DEFAULT '0.000000',
  `minimal_quantity` int(10) unsigned NOT NULL DEFAULT '1',
  `low_stock_threshold` int(10) DEFAULT NULL,
  `low_stock_alert` tinyint(1) NOT NULL DEFAULT '0',
  `price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `wholesale_price` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `unity` varchar(255) DEFAULT NULL,
  `unit_price_ratio` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `additional_shipping_cost` decimal(20,2) NOT NULL DEFAULT '0.00',
  `customizable` tinyint(2) NOT NULL DEFAULT '0',
  `uploadable_files` tinyint(4) NOT NULL DEFAULT '0',
  `text_fields` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `redirect_type` enum('','404','301-product','302-product','301-category','302-category') NOT NULL DEFAULT '',
  `id_type_redirected` int(10) unsigned NOT NULL DEFAULT '0',
  `available_for_order` tinyint(1) NOT NULL DEFAULT '1',
  `available_date` date DEFAULT NULL,
  `show_condition` tinyint(1) NOT NULL DEFAULT '1',
  `condition` enum('new','used','refurbished') NOT NULL DEFAULT 'new',
  `show_price` tinyint(1) NOT NULL DEFAULT '1',
  `indexed` tinyint(1) NOT NULL DEFAULT '0',
  `visibility` enum('both','catalog','search','none') NOT NULL DEFAULT 'both',
  `cache_default_attribute` int(10) unsigned DEFAULT NULL,
  `advanced_stock_management` tinyint(1) NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `pack_stock_type` int(11) unsigned NOT NULL DEFAULT '3',
  PRIMARY KEY (`id_product`,`id_shop`),
  KEY `id_category_default` (`id_category_default`),
  KEY `date_add` (`date_add`,`active`,`visibility`),
  KEY `indexed` (`indexed`,`active`,`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_shop`
--

LOCK TABLES `ps_product_shop` WRITE;
/*!40000 ALTER TABLE `ps_product_shop` DISABLE KEYS */;
INSERT INTO `ps_product_shop` VALUES (1,1,13,0,0,0,0.000000,1,NULL,0,10000.000000,0.000000,'本',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 15:18:52','2020-04-15 22:30:37',3),(2,1,13,0,0,0,0.000000,1,NULL,0,23100.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',6,0,'2018-06-17 18:32:17','2020-03-21 00:45:00',3),(3,1,13,0,0,0,0.000000,1,NULL,0,1500.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 18:35:12','2020-03-21 00:45:00',3),(4,1,13,0,0,0,0.000000,1,NULL,0,10000.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 18:35:23','2020-03-20 13:36:45',3),(5,1,13,0,0,0,0.000000,1,NULL,0,0.000000,0.000000,'',0.000000,0.00,0,0,0,0,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 18:38:03','2020-03-20 13:36:52',3),(6,1,9,0,0,0,0.000000,1,NULL,0,50.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 18:38:11','2020-03-20 13:36:46',3),(8,1,9,0,0,0,0.000000,5,NULL,0,20.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 18:38:21','2020-03-20 13:36:46',3),(9,1,10,0,0,0,0.000000,1,NULL,0,180.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 18:38:25','2020-03-20 13:36:46',3),(10,1,10,0,0,0,0.000000,1,NULL,0,180.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 18:38:30','2020-03-20 13:36:46',3),(11,1,10,0,0,0,0.000000,1,NULL,0,300.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2018-06-17 18:38:37','2020-04-09 20:35:29',3),(12,1,10,0,0,0,0.000000,1,NULL,0,150.000000,0.000000,'',0.000000,0.00,1,1,1,1,'404',0,1,'2018-11-30',1,'used',1,1,'both',0,0,'2018-06-17 18:38:42','2020-03-20 13:36:47',3),(13,1,11,0,0,0,0.000000,1,NULL,0,1800.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',3,0,'2018-06-17 18:38:47','2020-03-20 13:36:47',3),(14,1,12,0,0,0,0.000000,1,NULL,0,1800.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',0,'new',1,1,'both',0,0,'2019-10-04 13:39:05','2020-03-20 13:36:47',3),(15,1,12,0,0,0,0.000000,1,NULL,0,50000.000000,0.000000,'',0.000000,0.00,0,0,0,1,'404',0,1,'0000-00-00',1,'new',1,1,'both',9,0,'2019-10-04 13:39:05','2020-04-14 23:20:31',3);
/*!40000 ALTER TABLE `ps_product_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_supplier`
--

DROP TABLE IF EXISTS `ps_product_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_supplier` (
  `id_product_supplier` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL DEFAULT '0',
  `id_supplier` int(11) unsigned NOT NULL,
  `product_supplier_reference` varchar(64) DEFAULT NULL,
  `product_supplier_price_te` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `id_currency` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_product_supplier`),
  UNIQUE KEY `id_product` (`id_product`,`id_product_attribute`,`id_supplier`),
  KEY `id_supplier` (`id_supplier`,`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_supplier`
--

LOCK TABLES `ps_product_supplier` WRITE;
/*!40000 ALTER TABLE `ps_product_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_product_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_product_tag`
--

DROP TABLE IF EXISTS `ps_product_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_product_tag` (
  `id_product` int(10) unsigned NOT NULL,
  `id_tag` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_tag`),
  KEY `id_tag` (`id_tag`),
  KEY `id_lang` (`id_lang`,`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_product_tag`
--

LOCK TABLES `ps_product_tag` WRITE;
/*!40000 ALTER TABLE `ps_product_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_product_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_profile`
--

DROP TABLE IF EXISTS `ps_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_profile` (
  `id_profile` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_profile`
--

LOCK TABLES `ps_profile` WRITE;
/*!40000 ALTER TABLE `ps_profile` DISABLE KEYS */;
INSERT INTO `ps_profile` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `ps_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_profile_lang`
--

DROP TABLE IF EXISTS `ps_profile_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_profile_lang` (
  `id_lang` int(10) unsigned NOT NULL,
  `id_profile` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id_profile`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_profile_lang`
--

LOCK TABLES `ps_profile_lang` WRITE;
/*!40000 ALTER TABLE `ps_profile_lang` DISABLE KEYS */;
INSERT INTO `ps_profile_lang` VALUES (1,1,'超級管理員'),(2,1,'超级管理员'),(3,1,'超级管理员'),(4,1,'超级管理员'),(1,2,'商品'),(2,2,'商品'),(3,2,'商品'),(4,2,'商品'),(1,3,'訂單/客戶/客服'),(2,3,'訂單/客戶/客服'),(3,3,'訂單/客戶/客服'),(4,3,'訂單/客戶/客服'),(1,4,'設計'),(2,4,'設計'),(3,4,'設計'),(4,4,'設計');
/*!40000 ALTER TABLE `ps_profile_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_quick_access`
--

DROP TABLE IF EXISTS `ps_quick_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quick_access` (
  `id_quick_access` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `new_window` tinyint(1) NOT NULL DEFAULT '0',
  `link` varchar(255) NOT NULL,
  PRIMARY KEY (`id_quick_access`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_quick_access`
--

LOCK TABLES `ps_quick_access` WRITE;
/*!40000 ALTER TABLE `ps_quick_access` DISABLE KEYS */;
INSERT INTO `ps_quick_access` VALUES (2,0,'index.php/sell/catalog/products/16?-k');
/*!40000 ALTER TABLE `ps_quick_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_quick_access_lang`
--

DROP TABLE IF EXISTS `ps_quick_access_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_quick_access_lang` (
  `id_quick_access` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_quick_access`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_quick_access_lang`
--

LOCK TABLES `ps_quick_access_lang` WRITE;
/*!40000 ALTER TABLE `ps_quick_access_lang` DISABLE KEYS */;
INSERT INTO `ps_quick_access_lang` VALUES (2,1,'新增商品'),(2,2,'新增商品'),(2,3,'新增商品'),(2,4,'新增商品');
/*!40000 ALTER TABLE `ps_quick_access_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_range_price`
--

DROP TABLE IF EXISTS `ps_range_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_range_price` (
  `id_range_price` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_carrier` int(10) unsigned NOT NULL,
  `delimiter1` decimal(20,6) NOT NULL,
  `delimiter2` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id_range_price`),
  UNIQUE KEY `id_carrier` (`id_carrier`,`delimiter1`,`delimiter2`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_range_price`
--

LOCK TABLES `ps_range_price` WRITE;
/*!40000 ALTER TABLE `ps_range_price` DISABLE KEYS */;
INSERT INTO `ps_range_price` VALUES (7,103,0.000000,1000.000000),(38,103,1000.000000,4000.000000),(9,104,0.000000,1000.000000),(10,104,1000.000000,20000.000000),(34,105,0.000000,1000.000000),(35,105,1000.000000,5000.000000),(36,106,0.000000,1000.000000),(37,106,1000.000000,20000.000000),(19,107,0.000000,1000.000000),(25,107,1000.000000,3500.000000),(26,107,3500.000000,20000.000000),(39,108,0.000000,1000.000000),(40,108,1000.000000,3500.000000),(41,108,3500.000000,20000.000000),(42,109,0.000000,1000.000000),(43,109,1000.000000,3500.000000),(44,109,3500.000000,20000.000000),(21,110,0.000000,1000.000000),(32,110,1000.000000,3500.000000),(33,110,3500.000000,20000.000000),(29,111,0.000000,1000.000000),(30,111,1000.000000,3500.000000),(31,111,3500.000000,20000.000000),(23,112,0.000000,1000.000000),(27,112,1000.000000,3500.000000),(28,112,3500.000000,20000.000000),(11,113,0.000000,1000.000000),(12,113,1000.000000,20000.000000),(45,114,0.000000,1000.000000),(46,115,0.000000,1000.000000),(47,116,0.000000,1000.000000),(48,117,0.000000,1000.000000),(49,118,0.000000,1000.000000),(50,119,0.000000,1000.000000),(51,120,0.000000,3000.000000),(52,120,3000.000000,30000.000000),(53,121,0.000000,3000.000000),(54,121,3000.000000,30000.000000),(55,122,0.000000,3000.000000),(56,122,3000.000000,30000.000000);
/*!40000 ALTER TABLE `ps_range_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_range_weight`
--

DROP TABLE IF EXISTS `ps_range_weight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_range_weight` (
  `id_range_weight` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_carrier` int(10) unsigned NOT NULL,
  `delimiter1` decimal(20,6) NOT NULL,
  `delimiter2` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id_range_weight`),
  UNIQUE KEY `id_carrier` (`id_carrier`,`delimiter1`,`delimiter2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_range_weight`
--

LOCK TABLES `ps_range_weight` WRITE;
/*!40000 ALTER TABLE `ps_range_weight` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_range_weight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_referrer`
--

DROP TABLE IF EXISTS `ps_referrer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_referrer` (
  `id_referrer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `passwd` varchar(255) DEFAULT NULL,
  `http_referer_regexp` varchar(64) DEFAULT NULL,
  `http_referer_like` varchar(64) DEFAULT NULL,
  `request_uri_regexp` varchar(64) DEFAULT NULL,
  `request_uri_like` varchar(64) DEFAULT NULL,
  `http_referer_regexp_not` varchar(64) DEFAULT NULL,
  `http_referer_like_not` varchar(64) DEFAULT NULL,
  `request_uri_regexp_not` varchar(64) DEFAULT NULL,
  `request_uri_like_not` varchar(64) DEFAULT NULL,
  `base_fee` decimal(5,2) NOT NULL DEFAULT '0.00',
  `percent_fee` decimal(5,2) NOT NULL DEFAULT '0.00',
  `click_fee` decimal(5,2) NOT NULL DEFAULT '0.00',
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_referrer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_referrer`
--

LOCK TABLES `ps_referrer` WRITE;
/*!40000 ALTER TABLE `ps_referrer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_referrer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_referrer_cache`
--

DROP TABLE IF EXISTS `ps_referrer_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_referrer_cache` (
  `id_connections_source` int(11) unsigned NOT NULL,
  `id_referrer` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_connections_source`,`id_referrer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_referrer_cache`
--

LOCK TABLES `ps_referrer_cache` WRITE;
/*!40000 ALTER TABLE `ps_referrer_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_referrer_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_referrer_shop`
--

DROP TABLE IF EXISTS `ps_referrer_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_referrer_shop` (
  `id_referrer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(10) unsigned NOT NULL DEFAULT '1',
  `cache_visitors` int(11) DEFAULT NULL,
  `cache_visits` int(11) DEFAULT NULL,
  `cache_pages` int(11) DEFAULT NULL,
  `cache_registrations` int(11) DEFAULT NULL,
  `cache_orders` int(11) DEFAULT NULL,
  `cache_sales` decimal(17,2) DEFAULT NULL,
  `cache_reg_rate` decimal(5,4) DEFAULT NULL,
  `cache_order_rate` decimal(5,4) DEFAULT NULL,
  PRIMARY KEY (`id_referrer`,`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_referrer_shop`
--

LOCK TABLES `ps_referrer_shop` WRITE;
/*!40000 ALTER TABLE `ps_referrer_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_referrer_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_request_sql`
--

DROP TABLE IF EXISTS `ps_request_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_request_sql` (
  `id_request_sql` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `sql` text NOT NULL,
  PRIMARY KEY (`id_request_sql`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_request_sql`
--

LOCK TABLES `ps_request_sql` WRITE;
/*!40000 ALTER TABLE `ps_request_sql` DISABLE KEYS */;
INSERT INTO `ps_request_sql` VALUES (1,'LOG','SELECT * FROM ps_log;'),(2,'FbMessenger Subscription','SELECT * FROM ps_fbmessenger_subscription;'),(3,'FbMessenger Message','SELECT * FROM ps_fbmessenger_message;'),(4,'Email Subscription','SELECT * FROM ps_emailsubscription;'),(5,'7 日內購物車未結會員','SELECT c.id_cart, c.id_lang, cu.id_customer, c.id_shop, cu.firstname, cu.lastname, cu.email FROM ps_cart c LEFT JOIN ps_orders o ON (o.id_cart = c.id_cart) RIGHT JOIN ps_customer cu ON (cu.id_customer = c.id_customer) WHERE DATE_SUB(CURDATE(),INTERVAL 7 DAY) <= c.date_add AND o.id_order IS NULL AND c.id_shop IN (1) GROUP BY cu.id_customer'),(6,'7 日內完成訂單會員','SELECT o.id_order, c.id_cart, o.id_lang, o.id_shop, cu.id_customer, cu.firstname, cu.lastname, cu.email FROM ps_orders o LEFT JOIN ps_customer cu ON (cu.id_customer = o.id_customer) LEFT JOIN ps_cart c ON (c.id_cart = o.id_cart) WHERE o.valid = 1 AND c.date_add >= DATE_SUB(CURDATE(),INTERVAL 7 DAY) AND cu.is_guest = 0 AND o.id_shop IN (1)'),(7,'90 日內單筆消費達 $1000 會員','SELECT SUM(o.total_paid) total, c.id_cart, o.id_lang, cu.id_customer, cu.id_shop, cu.firstname, cu.lastname, cu.email FROM ps_orders o LEFT JOIN ps_customer cu ON (cu.id_customer = o.id_customer) LEFT JOIN ps_cart c ON (c.id_cart = o.id_cart) WHERE o.valid = 1 AND DATE_SUB(CURDATE(),INTERVAL 90 DAY) <= o.date_add AND cu.is_guest = 0 AND o.id_shop IN (1) GROUP BY o.id_customer HAVING total >= 1000'),(8,'90 日內無訂單會員','SELECT o.id_lang, c.id_cart, cu.id_customer, cu.id_shop, cu.firstname, cu.lastname, cu.email, (SELECT COUNT(o.id_order) FROM ps_orders o WHERE o.id_customer = cu.id_customer AND o.valid = 1) nb_orders FROM ps_customer cu LEFT JOIN ps_orders o ON (o.id_customer = cu.id_customer) LEFT JOIN ps_cart c ON (c.id_cart = o.id_cart) WHERE cu.id_customer NOT IN (SELECT o.id_customer FROM ps_orders o WHERE DATE_SUB(CURDATE(),INTERVAL 90 DAY) <= o.date_add) AND cu.is_guest = 0 AND cu.id_shop IN (1) GROUP BY cu.id_customer HAVING nb_orders >= 1'),(9,'訂單明細匯出','SELECT\r\na.id_order,\r\na.reference,\r\nCONCAT(c.`lastname`, \' \', c.`firstname`) AS `customer`, \r\naddress.address1,\r\naddress.city,\r\naddress.postcode,\r\ncountry_lang.name as cname,\r\naddress.phone_mobile, \r\naddress.company, \r\naddress.vat_number, \r\nosl.`name` AS `osname`, \r\na.payment AS payment_name,\r\ncarrier.name as carrier_name,\r\nmessage.message as message,\r\na.id_currency, \r\nTRIM(TRAILING \'.\' FROM TRIM(TRAILING \'0\' FROM a.total_products)) AS total_products,\r\nTRIM(TRAILING \'.\' FROM TRIM(TRAILING \'0\' FROM a.total_shipping)) AS total_shipping,\r\nTRIM(TRAILING \'.\' FROM TRIM(TRAILING \'0\' FROM a.total_paid)) AS total_paid,\r\na.date_add,\r\nod.product_name,\r\nod.product_reference,\r\nod.product_quantity,\r\nTRIM(TRAILING \'.\' FROM TRIM(TRAILING \'0\' FROM od.product_price)) AS product_price\r\nFROM `ps_orders` AS a\r\nLEFT JOIN `ps_customer` c ON (c.`id_customer` = a.`id_customer`) \r\nINNER JOIN `ps_address` address ON address.id_address = a.id_address_delivery \r\nINNER JOIN `ps_country` country ON address.id_country = country.id_country \r\nINNER JOIN `ps_country_lang` country_lang ON (country.`id_country` = country_lang.`id_country` AND country_lang.`id_lang` = 1) \r\nINNER JOIN `ps_carrier` carrier ON carrier.id_carrier = a.id_carrier \r\nLEFT JOIN `ps_order_state` os ON (os.`id_order_state` = a.`current_state`) \r\nLEFT JOIN `ps_order_state_lang` osl ON (os.`id_order_state` = osl.`id_order_state` AND osl.`id_lang` = 1)\r\nLEFT JOIN `ps_order_detail` od ON (a.`id_order` = od.`id_order`)\r\nLEFT JOIN `ps_message` message ON (a.`id_order` = message.`id_order`)\r\nWHERE a.date_add BETWEEN \'2019-11-01\' AND NOW()\r\nORDER BY a.id_order'),(10,'客戶','SELECT c.id_customer, c.firstname, c.lastname, c.email, c.active, c.newsletter, c.optin, c.date_add, gl.name as social_title, s.name as shop_name, c.company, (SELECT SUM(total_paid_real / conversion_rate) FROM ps_orders o WHERE (o.id_customer = c.id_customer) AND (o.id_shop IN (\'1\')) AND (o.valid = 1)) as total_spent, (SELECT c.date_add FROM ps_guest g LEFT JOIN ps_connections con ON con.id_guest = g.id_guest WHERE g.id_customer = c.id_customer ORDER BY c.date_add DESC LIMIT 1) as connect FROM ps_customer c LEFT JOIN ps_gender_lang gl ON c.id_gender = gl.id_gender AND gl.id_lang = 1 LEFT JOIN ps_shop s ON c.id_shop = s.id_shop WHERE (c.deleted = 0) AND (c.id_shop IN (\'1\')) ORDER BY c.email asc LIMIT 50 OFFSET 0');
/*!40000 ALTER TABLE `ps_request_sql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_required_field`
--

DROP TABLE IF EXISTS `ps_required_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_required_field` (
  `id_required_field` int(11) NOT NULL AUTO_INCREMENT,
  `object_name` varchar(32) NOT NULL,
  `field_name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_required_field`),
  KEY `object_name` (`object_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_required_field`
--

LOCK TABLES `ps_required_field` WRITE;
/*!40000 ALTER TABLE `ps_required_field` DISABLE KEYS */;
INSERT INTO `ps_required_field` VALUES (1,'CustomerAddress','phone_mobile');
/*!40000 ALTER TABLE `ps_required_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_risk`
--

DROP TABLE IF EXISTS `ps_risk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_risk` (
  `id_risk` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `percent` tinyint(3) NOT NULL,
  `color` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_risk`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_risk`
--

LOCK TABLES `ps_risk` WRITE;
/*!40000 ALTER TABLE `ps_risk` DISABLE KEYS */;
INSERT INTO `ps_risk` VALUES (1,0,'#32CD32'),(2,35,'#FF8C00'),(3,75,'#DC143C'),(4,100,'#ec2e15');
/*!40000 ALTER TABLE `ps_risk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_risk_lang`
--

DROP TABLE IF EXISTS `ps_risk_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_risk_lang` (
  `id_risk` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_risk`,`id_lang`),
  KEY `id_risk` (`id_risk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_risk_lang`
--

LOCK TABLES `ps_risk_lang` WRITE;
/*!40000 ALTER TABLE `ps_risk_lang` DISABLE KEYS */;
INSERT INTO `ps_risk_lang` VALUES (1,1,'無'),(1,2,'无'),(1,3,'无'),(1,4,'无'),(2,1,'低'),(2,2,'Low'),(2,3,'低'),(2,4,'低'),(3,1,'中'),(3,2,'Medium'),(3,3,'中'),(3,4,'中'),(4,1,'高'),(4,2,'High'),(4,3,'高'),(4,4,'高い');
/*!40000 ALTER TABLE `ps_risk_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_search_engine`
--

DROP TABLE IF EXISTS `ps_search_engine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_search_engine` (
  `id_search_engine` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server` varchar(64) NOT NULL,
  `getvar` varchar(16) NOT NULL,
  PRIMARY KEY (`id_search_engine`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_search_engine`
--

LOCK TABLES `ps_search_engine` WRITE;
/*!40000 ALTER TABLE `ps_search_engine` DISABLE KEYS */;
INSERT INTO `ps_search_engine` VALUES (1,'google','q'),(2,'aol','q'),(3,'yandex','text'),(4,'ask.com','q'),(5,'nhl.com','q'),(6,'yahoo','p'),(7,'baidu','wd'),(8,'lycos','query'),(9,'exalead','q'),(10,'search.live','q'),(11,'voila','rdata'),(12,'altavista','q'),(13,'bing','q'),(14,'daum','q'),(15,'eniro','search_word'),(16,'naver','query'),(17,'msn','q'),(18,'netscape','query'),(19,'cnn','query'),(20,'about','terms'),(21,'mamma','query'),(22,'alltheweb','q'),(23,'virgilio','qs'),(24,'alice','qs'),(25,'najdi','q'),(26,'mama','query'),(27,'seznam','q'),(28,'onet','qt'),(29,'szukacz','q'),(30,'yam','k'),(31,'pchome','q'),(32,'kvasir','q'),(33,'sesam','q'),(34,'ozu','q'),(35,'terra','query'),(36,'mynet','q'),(37,'ekolay','q'),(38,'rambler','words');
/*!40000 ALTER TABLE `ps_search_engine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_search_index`
--

DROP TABLE IF EXISTS `ps_search_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_search_index` (
  `id_product` int(11) unsigned NOT NULL,
  `id_word` int(11) unsigned NOT NULL,
  `weight` smallint(4) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_word`,`id_product`),
  KEY `id_product` (`id_product`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_search_index`
--

LOCK TABLES `ps_search_index` WRITE;
/*!40000 ALTER TABLE `ps_search_index` DISABLE KEYS */;
INSERT INTO `ps_search_index` VALUES (1,86283,1),(1,86284,1),(1,86285,1),(1,86286,1),(1,86287,1),(1,86288,1),(1,86289,1),(1,86290,1),(1,86291,1),(1,86292,1),(1,86293,1),(1,86294,1),(1,86295,1),(1,86296,1),(1,86297,1),(1,86298,1),(1,86299,1),(1,86300,1),(1,86301,1),(1,86302,1),(1,86303,1),(1,86304,1),(1,86305,1),(1,86306,1),(1,86307,1),(1,86308,1),(1,86309,1),(1,86310,1),(1,86311,1),(1,86312,1),(1,86313,1),(1,86314,1),(1,86315,1),(1,86316,1),(1,86317,1),(1,86318,1),(1,86319,1),(1,86320,1),(1,86321,1),(1,86322,1),(1,86323,1),(1,86324,1),(1,86325,1),(1,86326,1),(1,86327,1),(1,86328,1),(1,86329,1),(1,86330,1),(1,86331,1),(1,86332,1),(1,86333,1),(1,86334,1),(1,86335,1),(1,86336,1),(1,86337,1),(1,86338,1),(1,86339,1),(1,86340,1),(1,86341,1),(1,86342,1),(1,86343,1),(1,86344,1),(1,86345,1),(1,86346,1),(1,86347,1),(1,86348,1),(1,86349,1),(1,86350,1),(1,86351,1),(1,86352,1),(1,86353,1),(1,86354,1),(1,86355,1),(1,86356,1),(1,86357,1),(1,86358,1),(1,86359,1),(1,86360,1),(1,86361,1),(1,86362,1),(1,86363,1),(1,86364,1),(1,86365,1),(1,86366,1),(1,86367,1),(1,86368,1),(1,86369,1),(1,86370,1),(1,86371,1),(1,86372,1),(1,86373,1),(1,86374,1),(1,86375,1),(1,86376,1),(1,86377,1),(1,86378,1),(1,86379,1),(1,86380,1),(1,86381,1),(1,86382,1),(1,86383,1),(1,86384,1),(1,86385,1),(1,86386,1),(1,86387,1),(1,86388,1),(1,86389,1),(1,86390,1),(1,86391,1),(1,86392,1),(1,86393,1),(1,86394,1),(1,86395,1),(1,86396,1),(1,86397,1),(1,86398,1),(1,86399,1),(1,86400,1),(1,86401,1),(1,86402,1),(1,86403,1),(1,86404,1),(1,86405,1),(1,86406,1),(1,86408,1),(1,86409,1),(1,86410,1),(1,86411,1),(1,86412,1),(1,86413,1),(1,86414,1),(1,86415,1),(1,86416,1),(1,86417,1),(1,86418,1),(1,86419,1),(1,86420,1),(1,86421,1),(1,86422,1),(1,86423,1),(1,86424,1),(1,86425,1),(1,86426,1),(1,86427,1),(1,86428,1),(1,86429,1),(1,86430,1),(1,86431,1),(1,86432,1),(1,86433,1),(1,86434,1),(1,86435,1),(1,86436,1),(1,86437,1),(1,86438,1),(1,86439,1),(1,86440,1),(1,86442,1),(1,86443,1),(1,86444,1),(1,86445,1),(1,86446,1),(1,86448,1),(1,86449,1),(1,86450,1),(1,86451,1),(1,86452,1),(1,86453,1),(1,86454,1),(1,86455,1),(1,86456,1),(1,86457,1),(1,86458,1),(1,86459,1),(1,86460,1),(1,86461,1),(1,86463,1),(1,86464,1),(1,86465,1),(1,86466,1),(1,86467,1),(1,86469,1),(1,86470,1),(1,86471,1),(1,86472,1),(1,86473,1),(1,86474,1),(1,86475,1),(1,86476,1),(1,86477,1),(1,86478,1),(1,86479,1),(1,86480,1),(1,86481,1),(1,86482,1),(1,86483,1),(1,86484,1),(1,86485,1),(1,86486,1),(1,86487,1),(1,86488,1),(1,86489,1),(1,86490,1),(1,86491,1),(1,86492,1),(1,86493,1),(1,86494,1),(1,86495,1),(1,86496,1),(1,86497,1),(1,86498,1),(1,86503,1),(1,86504,1),(1,86505,1),(1,86506,1),(1,86507,1),(1,86508,1),(1,86509,1),(1,86510,1),(1,86511,1),(1,86512,1),(1,86513,1),(1,86514,1),(1,86515,1),(1,86516,1),(1,86517,1),(1,86518,1),(1,86519,1),(1,86520,1),(1,86521,1),(1,86522,1),(1,86523,1),(1,86524,1),(1,86525,1),(1,86526,1),(1,86527,1),(1,86528,1),(1,86529,1),(1,86530,1),(1,86531,1),(1,86532,1),(1,86533,1),(1,86534,1),(1,86535,1),(1,86536,1),(1,86537,1),(1,86538,1),(1,86539,1),(1,86540,1),(1,86541,1),(1,86542,1),(1,86543,1),(1,86544,1),(1,86545,1),(1,86546,1),(1,86547,1),(1,86548,1),(1,86549,1),(1,86550,1),(1,86551,1),(1,86552,1),(1,86553,1),(1,86554,1),(1,86555,1),(1,86556,1),(1,86557,1),(1,86558,1),(1,86559,1),(1,86560,1),(1,86561,1),(1,86562,1),(1,86563,1),(1,86564,1),(1,86565,1),(1,86566,1),(1,86567,1),(1,86568,1),(1,86569,1),(1,86570,1),(1,86571,1),(1,86572,1),(1,86573,1),(1,86574,1),(1,86575,1),(1,86576,1),(1,86577,1),(1,86578,1),(1,86579,1),(1,86580,1),(1,86581,1),(1,86582,1),(1,86583,1),(1,86584,1),(1,86585,1),(1,86586,1),(1,86587,1),(1,86588,1),(1,86589,1),(1,86590,1),(1,86591,1),(1,86592,1),(1,86593,1),(1,86594,1),(1,86595,1),(1,86596,1),(1,86597,1),(1,86598,1),(1,86599,1),(1,86600,1),(1,86601,1),(1,86602,1),(1,86603,1),(1,86604,1),(1,86605,1),(1,86606,1),(1,86607,1),(1,86608,1),(1,86609,1),(1,86610,1),(1,86611,1),(1,86612,1),(1,86613,1),(1,86614,1),(1,86615,1),(1,86616,1),(1,86617,1),(1,86618,1),(1,86619,1),(1,86620,1),(1,86621,1),(1,86622,1),(1,86623,1),(1,86624,1),(1,86625,1),(1,86626,1),(1,86627,1),(1,86628,1),(1,86629,1),(1,86630,1),(1,86631,1),(1,86632,1),(1,86633,1),(1,86634,1),(1,86635,1),(1,86636,1),(1,86637,1),(1,86638,1),(1,86639,1),(1,86640,1),(1,86641,1),(1,86642,1),(1,86643,1),(1,86644,1),(1,86645,1),(1,86646,1),(1,86647,1),(1,86648,1),(1,86649,1),(1,86650,1),(1,86651,1),(1,86652,1),(1,86653,1),(1,86654,1),(1,86655,1),(1,86656,1),(1,86657,1),(1,86658,1),(1,86659,1),(1,86660,1),(1,86661,1),(1,86662,1),(1,86663,1),(1,86664,1),(1,86665,1),(1,86666,1),(1,86667,1),(1,86668,1),(1,86669,1),(1,86670,1),(1,86671,1),(1,86672,1),(1,86673,1),(1,86674,1),(1,86675,1),(1,86676,1),(1,86677,1),(1,86678,1),(1,86679,1),(1,86680,1),(1,86681,1),(1,86682,1),(1,86683,1),(1,86684,1),(1,86685,1),(1,86686,1),(1,86687,1),(1,86688,1),(1,86689,1),(1,86690,1),(1,86691,1),(1,86692,1),(1,86693,1),(1,86694,1),(1,86695,1),(1,86696,1),(1,86697,1),(1,86698,1),(1,86699,1),(1,86700,1),(1,86701,1),(1,86702,1),(1,86703,1),(1,86704,1),(1,86705,1),(1,86706,1),(1,86707,1),(1,86708,1),(1,86709,1),(1,86710,1),(1,86711,1),(1,86712,1),(1,86713,1),(1,86714,1),(1,86715,1),(1,86716,1),(1,86717,1),(1,86718,1),(1,86719,1),(1,86720,1),(1,86721,1),(1,86722,1),(1,86723,1),(1,86724,1),(1,86725,1),(1,86726,1),(1,86727,1),(1,86728,1),(1,86729,1),(1,86730,1),(1,86731,1),(1,86732,1),(1,86733,1),(1,86734,1),(1,86735,1),(1,86736,1),(1,86737,1),(1,86738,1),(1,86739,1),(1,86740,1),(1,86741,1),(1,86742,1),(1,86743,1),(1,86744,1),(1,86745,1),(1,86746,1),(1,86747,1),(1,86748,1),(1,86749,1),(1,86750,1),(1,86751,1),(1,86752,1),(1,86753,1),(1,86754,1),(1,86755,1),(1,86756,1),(1,86757,1),(1,86758,1),(1,86759,1),(1,86760,1),(1,86761,1),(1,86762,1),(1,86763,1),(1,86764,1),(1,86765,1),(1,86766,1),(1,86767,1),(1,86768,1),(1,86769,1),(1,86770,1),(1,86771,1),(1,86772,1),(1,86773,1),(1,86774,1),(1,86775,1),(1,86776,1),(1,86777,1),(1,86778,1),(1,86779,1),(1,86780,1),(1,86781,1),(1,86782,1),(1,86783,1),(1,86784,1),(1,86785,1),(1,86786,1),(1,86787,1),(1,86788,1),(1,86789,1),(1,86790,1),(1,86791,1),(1,86792,1),(1,86793,1),(1,86794,1),(1,86795,1),(1,86796,1),(1,86797,1),(1,86798,1),(1,86799,1),(1,86800,1),(1,86801,1),(1,86802,1),(1,86803,1),(1,86804,1),(1,86805,1),(1,86806,1),(1,86807,1),(1,86808,1),(1,86809,1),(1,86810,1),(1,86811,1),(1,86812,1),(1,86813,1),(1,86814,1),(1,86815,1),(1,86816,1),(1,86817,1),(1,86818,1),(1,86819,1),(1,86820,1),(1,86821,1),(1,86822,1),(1,86823,1),(1,86824,1),(1,86825,1),(1,86826,1),(1,86827,1),(1,86828,1),(1,86829,1),(1,86830,1),(1,86831,1),(1,86832,1),(1,86833,1),(1,86834,1),(1,86835,1),(1,86836,1),(1,86837,1),(1,86838,1),(1,86839,1),(1,86840,1),(1,86841,1),(1,86842,1),(1,86843,1),(1,86844,1),(1,86845,1),(1,86846,1),(1,86847,1),(1,86848,1),(1,86857,1),(1,86858,1),(1,86859,1),(1,86860,1),(1,86861,1),(1,86862,1),(1,86863,1),(1,86864,1),(1,86865,1),(1,86866,1),(1,86867,1),(1,86868,1),(1,86869,1),(1,86870,1),(1,86871,1),(1,86872,1),(1,86873,1),(1,86874,1),(1,86875,1),(1,86876,1),(1,86877,1),(1,86878,1),(1,86879,1),(1,86880,1),(1,86881,1),(1,86882,1),(1,86883,1),(1,86884,1),(1,86885,1),(1,86886,1),(1,86887,1),(1,86888,1),(1,86889,1),(1,86890,1),(1,86891,1),(1,86892,1),(1,86893,1),(1,86894,1),(1,86895,1),(1,86896,1),(1,86897,1),(1,86898,1),(1,86899,1),(1,86900,1),(1,86901,1),(1,86902,1),(1,86903,1),(1,86904,1),(1,86905,1),(1,86906,1),(1,86907,1),(1,86908,1),(1,86909,1),(1,86910,1),(1,86911,1),(1,86912,1),(1,86913,1),(1,86914,1),(1,86915,1),(1,86916,1),(1,86917,1),(1,86918,1),(1,86919,1),(1,86920,1),(1,86921,1),(1,86922,1),(1,86923,1),(1,86924,1),(1,86925,1),(1,86926,1),(1,86927,1),(1,86928,1),(1,86929,1),(1,86930,1),(1,86931,1),(1,86932,1),(1,86933,1),(1,86934,1),(1,86935,1),(1,86936,1),(1,86937,1),(1,86938,1),(1,86939,1),(1,86940,1),(1,86941,1),(1,86942,1),(1,86943,1),(1,86944,1),(1,86945,1),(1,86946,1),(1,86947,1),(1,86948,1),(1,86949,1),(1,86950,1),(1,86951,1),(1,86952,1),(1,86953,1),(1,86954,1),(1,86955,1),(1,86956,1),(1,86957,1),(1,86958,1),(1,86959,1),(1,86960,1),(1,86961,1),(1,86962,1),(1,86963,1),(1,86964,1),(1,86965,1),(1,86966,1),(1,86967,1),(1,86968,1),(1,86969,1),(1,86970,1),(1,86971,1),(1,86972,1),(1,86973,1),(1,86974,1),(1,86975,1),(1,86976,1),(1,86977,1),(1,86978,1),(1,86979,1),(1,86980,1),(1,86982,1),(1,86983,1),(1,86984,1),(1,86985,1),(1,86986,1),(1,86987,1),(1,86988,1),(1,86989,1),(1,86990,1),(1,86991,1),(1,86992,1),(1,86993,1),(1,86994,1),(1,86995,1),(1,86996,1),(1,86997,1),(1,86998,1),(1,86999,1),(1,87000,1),(1,87001,1),(1,87002,1),(1,87003,1),(1,87004,1),(1,87005,1),(1,87006,1),(1,87007,1),(1,87008,1),(1,87009,1),(1,87010,1),(1,87011,1),(1,87012,1),(1,87013,1),(1,87014,1),(1,87016,1),(1,87017,1),(1,87018,1),(1,87019,1),(1,87020,1),(1,87022,1),(1,87023,1),(1,87024,1),(1,87025,1),(1,87026,1),(1,87027,1),(1,87028,1),(1,87029,1),(1,87030,1),(1,87031,1),(1,87032,1),(1,87033,1),(1,87034,1),(1,87035,1),(1,87037,1),(1,87038,1),(1,87039,1),(1,87040,1),(1,87041,1),(1,87043,1),(1,87044,1),(1,87045,1),(1,87046,1),(1,87047,1),(1,87048,1),(1,87049,1),(1,87050,1),(1,87051,1),(1,87052,1),(1,87053,1),(1,87054,1),(1,87055,1),(1,87056,1),(1,87057,1),(1,87058,1),(1,87059,1),(1,87060,1),(1,87061,1),(1,87062,1),(1,87063,1),(1,87064,1),(1,87065,1),(1,87066,1),(1,87067,1),(1,87068,1),(1,87069,1),(1,87070,1),(1,87071,1),(1,87072,1),(1,87077,1),(1,87078,1),(1,87079,1),(1,87080,1),(1,87081,1),(1,87082,1),(1,87083,1),(1,87084,1),(1,87085,1),(1,87086,1),(1,87087,1),(1,87088,1),(1,87089,1),(1,87090,1),(1,87091,1),(1,87092,1),(1,87093,1),(1,87094,1),(1,87095,1),(1,87096,1),(1,87097,1),(1,87098,1),(1,87099,1),(1,87100,1),(1,87101,1),(1,87102,1),(1,87103,1),(1,87104,1),(1,87105,1),(1,87106,1),(1,87107,1),(1,87108,1),(1,87109,1),(1,87110,1),(1,87111,1),(1,87112,1),(1,87113,1),(1,87114,1),(1,87115,1),(1,87116,1),(1,87117,1),(1,87118,1),(1,87119,1),(1,87120,1),(1,87121,1),(1,87122,1),(1,87123,1),(1,87124,1),(1,87125,1),(1,87126,1),(1,87127,1),(1,87128,1),(1,87129,1),(1,87130,1),(1,87131,1),(1,87132,1),(1,87133,1),(1,87134,1),(1,87135,1),(1,87136,1),(1,87137,1),(1,87138,1),(1,87139,1),(1,87140,1),(1,87141,1),(1,87142,1),(1,87143,1),(1,87144,1),(1,87145,1),(1,87146,1),(1,87147,1),(1,87148,1),(1,87149,1),(1,87150,1),(1,87151,1),(1,87152,1),(1,87153,1),(1,87154,1),(1,87155,1),(1,87156,1),(1,87157,1),(1,87158,1),(1,87159,1),(1,87160,1),(1,87161,1),(1,87162,1),(1,87163,1),(1,87164,1),(1,87165,1),(1,87166,1),(1,87167,1),(1,87168,1),(1,87169,1),(1,87170,1),(1,87171,1),(1,87172,1),(1,87173,1),(1,87174,1),(1,87175,1),(1,87176,1),(1,87177,1),(1,87178,1),(1,87179,1),(1,87180,1),(1,87181,1),(1,87182,1),(1,87183,1),(1,87184,1),(1,87185,1),(1,87186,1),(1,87187,1),(1,87188,1),(1,87189,1),(1,87190,1),(1,87191,1),(1,87192,1),(1,87193,1),(1,87194,1),(1,87195,1),(1,87196,1),(1,87197,1),(1,87198,1),(1,87199,1),(1,87200,1),(1,87201,1),(1,87202,1),(1,87203,1),(1,87204,1),(1,87205,1),(1,87206,1),(1,87207,1),(1,87208,1),(1,87209,1),(1,87210,1),(1,87211,1),(1,87212,1),(1,87213,1),(1,87214,1),(1,87215,1),(1,87216,1),(1,87217,1),(1,87218,1),(1,87219,1),(1,87220,1),(1,87221,1),(1,87222,1),(1,87223,1),(1,87224,1),(1,87225,1),(1,87226,1),(1,87227,1),(1,87228,1),(1,87229,1),(1,87230,1),(1,87231,1),(1,87232,1),(1,87233,1),(1,87234,1),(1,87235,1),(1,87236,1),(1,87237,1),(1,87238,1),(1,87239,1),(1,87240,1),(1,87241,1),(1,87242,1),(1,87243,1),(1,87244,1),(1,87245,1),(1,87246,1),(1,87247,1),(1,87248,1),(1,87249,1),(1,87250,1),(1,87251,1),(1,87252,1),(1,87253,1),(1,87254,1),(1,87255,1),(1,87256,1),(1,87257,1),(1,87258,1),(1,87259,1),(1,87260,1),(1,87261,1),(1,87262,1),(1,87263,1),(1,87264,1),(1,87265,1),(1,87266,1),(1,87267,1),(1,87268,1),(1,87269,1),(1,87270,1),(1,87271,1),(1,87272,1),(1,87273,1),(1,87274,1),(1,87275,1),(1,87276,1),(1,87277,1),(1,87278,1),(1,87279,1),(1,87280,1),(1,87281,1),(1,87282,1),(1,87283,1),(1,87284,1),(1,87285,1),(1,87286,1),(1,87287,1),(1,87288,1),(1,87289,1),(1,87290,1),(1,87291,1),(1,87292,1),(1,87293,1),(1,87294,1),(1,87295,1),(1,87296,1),(1,87297,1),(1,87298,1),(1,87299,1),(1,87300,1),(1,87301,1),(1,87302,1),(1,87303,1),(1,87304,1),(1,87305,1),(1,87306,1),(1,87307,1),(1,87308,1),(1,87309,1),(1,87310,1),(1,87311,1),(1,87312,1),(1,87313,1),(1,87314,1),(1,87315,1),(1,87316,1),(1,87317,1),(1,87318,1),(1,87319,1),(1,87320,1),(1,87321,1),(1,87322,1),(1,87323,1),(1,87324,1),(1,87325,1),(1,87326,1),(1,87327,1),(1,87328,1),(1,87329,1),(1,87330,1),(1,87331,1),(1,87332,1),(1,87333,1),(1,87334,1),(1,87335,1),(1,87336,1),(1,87337,1),(1,87338,1),(1,87339,1),(1,87340,1),(1,87341,1),(1,87342,1),(1,87343,1),(1,87344,1),(1,87345,1),(1,87346,1),(1,87347,1),(1,87348,1),(1,87349,1),(1,87350,1),(1,87351,1),(1,87352,1),(1,87353,1),(1,87354,1),(1,87355,1),(1,87356,1),(1,87357,1),(1,87358,1),(1,87359,1),(1,87360,1),(1,87361,1),(1,87362,1),(1,87363,1),(1,87364,1),(1,87365,1),(1,87366,1),(1,87367,1),(1,87368,1),(1,87369,1),(1,87370,1),(1,87371,1),(1,87372,1),(1,87373,1),(1,87374,1),(1,87375,1),(1,87376,1),(1,87377,1),(1,87378,1),(1,87379,1),(1,87380,1),(1,87381,1),(1,87382,1),(1,87383,1),(1,87384,1),(1,87385,1),(1,87386,1),(1,87387,1),(1,87388,1),(1,87389,1),(1,87390,1),(1,87391,1),(1,87392,1),(1,87393,1),(1,87394,1),(1,87395,1),(1,87396,1),(1,87397,1),(1,87398,1),(1,87399,1),(1,87400,1),(1,87401,1),(1,87402,1),(1,87403,1),(1,87404,1),(1,87405,1),(1,87406,1),(1,87407,1),(1,87408,1),(1,87409,1),(1,87410,1),(1,87411,1),(1,87412,1),(1,87413,1),(1,87414,1),(1,87415,1),(1,87416,1),(1,87417,1),(1,87418,1),(1,87419,1),(1,87420,1),(1,87421,1),(1,87422,1),(1,86849,3),(1,87423,3),(1,86407,4),(1,86441,4),(1,86447,4),(1,86462,4),(1,86468,4),(1,86981,4),(1,87015,4),(1,87021,4),(1,87036,4),(1,87042,4),(1,86276,6),(1,86277,6),(1,86850,6),(1,86851,6),(1,86278,7),(1,86279,7),(1,86280,7),(1,86281,7),(1,86282,7),(1,86499,7),(1,86501,7),(1,86502,7),(1,86852,7),(1,86853,7),(1,86854,7),(1,86855,7),(1,86856,7),(1,87073,7),(1,87075,7),(1,87076,7),(1,86500,10),(1,87074,10),(2,86408,2),(2,86419,2),(2,86993,2),(2,87426,2),(2,87427,2),(2,87428,2),(2,87429,2),(2,87430,2),(2,87431,2),(2,87432,2),(2,87433,2),(2,87434,2),(2,87435,2),(2,87436,2),(2,87437,2),(2,87438,2),(2,87452,2),(2,87453,2),(2,87454,2),(2,87462,2),(2,87463,2),(2,87464,2),(2,87465,2),(2,87466,2),(2,87467,2),(2,87468,2),(2,87469,2),(2,87470,2),(2,87471,2),(2,87472,2),(2,87473,2),(2,87474,2),(2,87475,2),(2,87486,2),(2,87487,2),(2,87488,2),(2,87489,2),(2,86407,3),(2,86441,3),(2,86447,3),(2,86462,3),(2,86468,3),(2,86500,3),(2,86849,3),(2,86981,3),(2,87015,3),(2,87021,3),(2,87036,3),(2,87042,3),(2,87074,3),(2,87423,3),(2,86278,6),(2,86279,6),(2,86280,6),(2,86476,6),(2,86499,6),(2,86852,6),(2,87050,6),(2,87073,6),(2,87424,6),(2,87425,6),(2,87450,6),(2,87451,6),(2,87458,6),(2,87459,6),(2,87460,6),(2,87461,6),(2,87484,6),(2,87485,6),(3,86407,3),(3,86441,3),(3,86447,3),(3,86462,3),(3,86468,3),(3,86500,3),(3,86849,3),(3,86981,3),(3,87015,3),(3,87021,3),(3,87036,3),(3,87042,3),(3,87074,3),(3,87423,3),(3,86278,6),(3,86279,6),(3,86280,6),(3,86852,6),(3,87460,6),(3,87461,6),(3,87493,6),(3,87494,6),(3,87495,6),(3,87496,6),(3,87505,6),(3,87508,6),(3,87509,6),(3,87510,6),(3,87511,6),(3,87520,6),(4,87536,1),(4,87537,1),(4,87538,1),(4,87539,1),(4,87540,1),(4,87541,1),(4,87542,1),(4,87543,1),(4,87544,1),(4,87545,1),(4,87546,1),(4,86407,3),(4,86441,3),(4,86447,3),(4,86462,3),(4,86468,3),(4,86500,3),(4,86849,3),(4,86981,3),(4,87015,3),(4,87021,3),(4,87036,3),(4,87042,3),(4,87074,3),(4,87423,3),(4,86278,6),(4,86279,6),(4,86280,6),(4,86852,6),(4,87460,6),(4,87461,6),(4,87493,6),(4,87508,6),(4,87523,6),(4,87524,6),(4,87525,6),(4,87535,6),(4,87549,6),(4,87550,6),(4,87551,6),(4,87561,6),(5,53437,3),(5,53471,3),(5,53477,3),(5,53492,3),(5,53498,3),(5,53530,3),(5,53879,3),(5,54011,3),(5,54045,3),(5,54051,3),(5,54066,3),(5,54072,3),(5,54104,3),(5,54453,3),(5,26388,6),(5,26389,6),(5,26390,6),(5,26391,6),(5,26402,6),(5,26403,6),(5,53415,6),(5,53440,6),(5,54553,6),(5,54593,6),(5,54628,6),(5,66510,6),(5,66511,6),(6,86276,1),(6,86281,1),(6,86282,1),(6,86289,1),(6,86290,1),(6,86292,1),(6,86293,1),(6,86310,1),(6,86331,1),(6,86354,1),(6,86372,1),(6,86383,1),(6,86387,1),(6,86388,1),(6,86399,1),(6,86437,1),(6,86458,1),(6,86487,1),(6,86499,1),(6,86500,1),(6,86552,1),(6,86553,1),(6,86554,1),(6,86737,1),(6,86747,1),(6,86748,1),(6,86751,1),(6,86775,1),(6,86778,1),(6,86782,1),(6,86838,1),(6,86839,1),(6,86840,1),(6,86845,1),(6,86848,1),(6,86850,1),(6,86855,1),(6,86856,1),(6,86863,1),(6,86864,1),(6,86866,1),(6,86867,1),(6,86884,1),(6,86905,1),(6,86928,1),(6,86946,1),(6,86957,1),(6,86961,1),(6,86962,1),(6,86973,1),(6,87011,1),(6,87032,1),(6,87061,1),(6,87073,1),(6,87074,1),(6,87126,1),(6,87127,1),(6,87128,1),(6,87311,1),(6,87321,1),(6,87322,1),(6,87325,1),(6,87349,1),(6,87352,1),(6,87356,1),(6,87412,1),(6,87413,1),(6,87414,1),(6,87419,1),(6,87422,1),(6,87425,1),(6,87459,1),(6,87495,1),(6,87496,1),(6,87510,1),(6,87511,1),(6,87568,1),(6,87569,1),(6,87570,1),(6,87571,1),(6,87572,1),(6,87573,1),(6,87574,1),(6,87575,1),(6,87576,1),(6,87577,1),(6,87578,1),(6,87579,1),(6,87580,1),(6,87581,1),(6,87582,1),(6,87583,1),(6,87584,1),(6,87585,1),(6,87586,1),(6,87587,1),(6,87588,1),(6,87589,1),(6,87590,1),(6,87591,1),(6,87592,1),(6,87593,1),(6,87594,1),(6,87595,1),(6,87596,1),(6,87597,1),(6,87598,1),(6,87599,1),(6,87600,1),(6,87601,1),(6,87602,1),(6,87603,1),(6,87604,1),(6,87605,1),(6,87606,1),(6,87607,1),(6,87608,1),(6,87610,1),(6,87637,1),(6,87638,1),(6,87639,1),(6,87640,1),(6,87641,1),(6,87642,1),(6,87643,1),(6,87644,1),(6,87645,1),(6,87646,1),(6,87647,1),(6,87648,1),(6,87649,1),(6,87650,1),(6,87651,1),(6,87652,1),(6,87653,1),(6,87654,1),(6,87655,1),(6,87656,1),(6,87680,1),(6,87681,1),(6,87682,1),(6,87683,1),(6,87684,1),(6,87685,1),(6,87686,1),(6,87687,1),(6,87688,1),(6,87689,1),(6,87690,1),(6,87691,1),(6,87692,1),(6,87693,1),(6,87694,1),(6,87695,1),(6,87696,1),(6,87697,1),(6,87698,1),(6,87699,1),(6,87700,1),(6,87701,1),(6,87702,1),(6,87703,1),(6,87704,1),(6,87705,1),(6,87706,1),(6,87707,1),(6,87708,1),(6,87709,1),(6,87710,1),(6,87711,1),(6,87712,1),(6,87713,1),(6,87714,1),(6,87715,1),(6,87716,1),(6,87717,1),(6,87718,1),(6,87719,1),(6,87720,1),(6,87721,1),(6,87722,1),(6,87724,1),(6,87751,1),(6,87752,1),(6,87753,1),(6,87754,1),(6,87755,1),(6,87756,1),(6,87757,1),(6,87758,1),(6,87759,1),(6,87760,1),(6,87761,1),(6,87762,1),(6,87763,1),(6,87764,1),(6,87765,1),(6,87766,1),(6,87767,1),(6,87768,1),(6,87769,1),(6,87770,1),(6,87609,2),(6,87723,2),(6,87611,3),(6,87612,3),(6,87613,3),(6,87657,3),(6,87725,3),(6,87726,3),(6,87727,3),(6,87771,3),(6,87677,6),(6,87679,6),(6,86413,7),(6,86486,7),(6,86557,7),(6,86987,7),(6,87060,7),(6,87131,7),(6,87564,7),(6,87565,7),(6,87566,7),(6,87567,7),(6,87676,7),(6,87678,7),(8,86289,1),(8,86290,1),(8,86292,1),(8,86293,1),(8,86310,1),(8,86312,1),(8,86331,1),(8,86372,1),(8,86486,1),(8,86499,1),(8,86500,1),(8,86552,1),(8,86553,1),(8,86554,1),(8,86557,1),(8,86737,1),(8,86747,1),(8,86748,1),(8,86751,1),(8,86775,1),(8,86778,1),(8,86782,1),(8,86838,1),(8,86839,1),(8,86840,1),(8,86845,1),(8,86848,1),(8,86863,1),(8,86864,1),(8,86866,1),(8,86867,1),(8,86884,1),(8,86886,1),(8,86905,1),(8,86946,1),(8,87060,1),(8,87073,1),(8,87074,1),(8,87126,1),(8,87127,1),(8,87128,1),(8,87131,1),(8,87311,1),(8,87321,1),(8,87322,1),(8,87325,1),(8,87349,1),(8,87352,1),(8,87356,1),(8,87412,1),(8,87413,1),(8,87414,1),(8,87419,1),(8,87422,1),(8,87425,1),(8,87459,1),(8,87495,1),(8,87496,1),(8,87510,1),(8,87511,1),(8,87564,1),(8,87565,1),(8,87566,1),(8,87569,1),(8,87570,1),(8,87571,1),(8,87573,1),(8,87574,1),(8,87575,1),(8,87577,1),(8,87578,1),(8,87579,1),(8,87580,1),(8,87581,1),(8,87582,1),(8,87583,1),(8,87584,1),(8,87585,1),(8,87586,1),(8,87587,1),(8,87604,1),(8,87605,1),(8,87606,1),(8,87607,1),(8,87608,1),(8,87610,1),(8,87639,1),(8,87640,1),(8,87641,1),(8,87642,1),(8,87644,1),(8,87645,1),(8,87646,1),(8,87647,1),(8,87648,1),(8,87649,1),(8,87650,1),(8,87651,1),(8,87652,1),(8,87653,1),(8,87654,1),(8,87655,1),(8,87656,1),(8,87676,1),(8,87677,1),(8,87678,1),(8,87681,1),(8,87682,1),(8,87683,1),(8,87685,1),(8,87686,1),(8,87687,1),(8,87689,1),(8,87690,1),(8,87691,1),(8,87692,1),(8,87693,1),(8,87694,1),(8,87695,1),(8,87696,1),(8,87697,1),(8,87698,1),(8,87699,1),(8,87718,1),(8,87719,1),(8,87720,1),(8,87721,1),(8,87722,1),(8,87724,1),(8,87753,1),(8,87754,1),(8,87755,1),(8,87756,1),(8,87758,1),(8,87759,1),(8,87760,1),(8,87761,1),(8,87762,1),(8,87763,1),(8,87764,1),(8,87765,1),(8,87766,1),(8,87767,1),(8,87768,1),(8,87769,1),(8,87770,1),(8,87793,1),(8,87794,1),(8,87795,1),(8,87796,1),(8,87797,1),(8,87798,1),(8,87880,1),(8,87881,1),(8,87882,1),(8,87883,1),(8,87884,1),(8,87885,1),(8,87611,3),(8,87612,3),(8,87613,3),(8,87657,3),(8,87725,3),(8,87726,3),(8,87727,3),(8,87771,3),(8,87643,7),(8,87757,7),(8,87790,7),(8,87791,7),(8,87792,7),(8,87877,7),(8,87878,7),(8,87879,7),(9,86286,1),(9,86287,1),(9,86329,1),(9,86343,1),(9,86364,1),(9,86370,1),(9,86371,1),(9,86372,1),(9,86376,1),(9,86381,1),(9,86499,1),(9,86500,1),(9,86502,1),(9,86514,1),(9,86552,1),(9,86619,1),(9,86655,1),(9,86713,1),(9,86736,1),(9,86761,1),(9,86785,1),(9,86813,1),(9,86826,1),(9,86832,1),(9,86835,1),(9,86838,1),(9,86839,1),(9,86840,1),(9,86845,1),(9,86848,1),(9,86860,1),(9,86861,1),(9,86903,1),(9,86917,1),(9,86938,1),(9,86944,1),(9,86945,1),(9,86946,1),(9,86950,1),(9,86955,1),(9,87073,1),(9,87074,1),(9,87076,1),(9,87088,1),(9,87126,1),(9,87193,1),(9,87229,1),(9,87287,1),(9,87310,1),(9,87335,1),(9,87359,1),(9,87387,1),(9,87400,1),(9,87406,1),(9,87409,1),(9,87412,1),(9,87413,1),(9,87414,1),(9,87419,1),(9,87422,1),(9,87425,1),(9,87459,1),(9,87568,1),(9,87573,1),(9,87574,1),(9,87575,1),(9,87581,1),(9,87586,1),(9,87587,1),(9,87593,1),(9,87605,1),(9,87606,1),(9,87608,1),(9,87610,1),(9,87645,1),(9,87680,1),(9,87685,1),(9,87686,1),(9,87687,1),(9,87693,1),(9,87698,1),(9,87699,1),(9,87706,1),(9,87719,1),(9,87720,1),(9,87722,1),(9,87724,1),(9,87759,1),(9,87790,1),(9,87791,1),(9,87792,1),(9,87795,1),(9,87796,1),(9,87798,1),(9,87877,1),(9,87878,1),(9,87879,1),(9,87882,1),(9,87883,1),(9,87885,1),(9,87964,1),(9,87965,1),(9,87966,1),(9,87967,1),(9,87968,1),(9,87969,1),(9,87970,1),(9,87971,1),(9,87972,1),(9,87973,1),(9,87974,1),(9,87975,1),(9,87976,1),(9,87977,1),(9,87978,1),(9,87979,1),(9,87980,1),(9,87981,1),(9,87982,1),(9,87983,1),(9,87984,1),(9,87985,1),(9,87986,1),(9,87987,1),(9,87988,1),(9,87989,1),(9,87990,1),(9,87991,1),(9,87992,1),(9,87993,1),(9,87994,1),(9,87995,1),(9,87996,1),(9,87997,1),(9,87998,1),(9,87999,1),(9,88000,1),(9,88001,1),(9,88036,1),(9,88037,1),(9,88038,1),(9,88039,1),(9,88040,1),(9,88041,1),(9,88042,1),(9,88043,1),(9,88044,1),(9,88045,1),(9,88046,1),(9,88047,1),(9,88048,1),(9,88049,1),(9,88050,1),(9,88051,1),(9,88052,1),(9,88053,1),(9,88054,1),(9,88055,1),(9,88056,1),(9,88057,1),(9,88058,1),(9,88059,1),(9,88060,1),(9,88061,1),(9,88062,1),(9,88063,1),(9,88089,1),(9,88090,1),(9,88091,1),(9,88092,1),(9,88093,1),(9,88094,1),(9,88095,1),(9,88096,1),(9,88097,1),(9,88098,1),(9,88099,1),(9,88100,1),(9,88101,1),(9,88102,1),(9,88103,1),(9,88104,1),(9,88105,1),(9,88106,1),(9,88107,1),(9,88108,1),(9,88109,1),(9,88110,1),(9,88111,1),(9,88112,1),(9,88113,1),(9,88114,1),(9,88115,1),(9,88116,1),(9,88117,1),(9,88118,1),(9,88119,1),(9,88120,1),(9,88121,1),(9,88122,1),(9,88123,1),(9,88124,1),(9,88125,1),(9,88126,1),(9,88161,1),(9,88162,1),(9,88163,1),(9,88164,1),(9,88165,1),(9,88166,1),(9,88167,1),(9,88168,1),(9,88169,1),(9,88170,1),(9,88171,1),(9,88172,1),(9,88173,1),(9,88174,1),(9,88175,1),(9,88176,1),(9,88177,1),(9,88178,1),(9,88179,1),(9,88180,1),(9,88181,1),(9,88182,1),(9,88183,1),(9,88184,1),(9,88185,1),(9,88186,1),(9,88187,1),(9,88188,1),(9,86408,3),(9,86982,3),(9,88002,3),(9,88003,3),(9,88064,3),(9,88127,3),(9,88128,3),(9,88189,3),(9,86737,7),(9,87311,7),(9,87495,7),(9,87496,7),(9,87510,7),(9,87511,7),(9,87640,7),(9,87655,7),(9,87754,7),(9,87769,7),(10,86286,1),(10,86287,1),(10,86329,1),(10,86343,1),(10,86370,1),(10,86371,1),(10,86372,1),(10,86376,1),(10,86381,1),(10,86387,1),(10,86388,1),(10,86499,1),(10,86500,1),(10,86502,1),(10,86514,1),(10,86552,1),(10,86619,1),(10,86655,1),(10,86713,1),(10,86736,1),(10,86761,1),(10,86785,1),(10,86826,1),(10,86832,1),(10,86835,1),(10,86838,1),(10,86839,1),(10,86840,1),(10,86845,1),(10,86848,1),(10,86860,1),(10,86861,1),(10,86903,1),(10,86917,1),(10,86944,1),(10,86945,1),(10,86946,1),(10,86950,1),(10,86955,1),(10,86961,1),(10,86962,1),(10,87073,1),(10,87074,1),(10,87076,1),(10,87088,1),(10,87126,1),(10,87193,1),(10,87229,1),(10,87287,1),(10,87310,1),(10,87335,1),(10,87359,1),(10,87400,1),(10,87406,1),(10,87409,1),(10,87412,1),(10,87413,1),(10,87414,1),(10,87419,1),(10,87422,1),(10,87425,1),(10,87459,1),(10,87568,1),(10,87573,1),(10,87574,1),(10,87575,1),(10,87581,1),(10,87586,1),(10,87587,1),(10,87593,1),(10,87605,1),(10,87606,1),(10,87608,1),(10,87610,1),(10,87645,1),(10,87680,1),(10,87685,1),(10,87686,1),(10,87687,1),(10,87693,1),(10,87698,1),(10,87699,1),(10,87706,1),(10,87719,1),(10,87720,1),(10,87722,1),(10,87724,1),(10,87759,1),(10,87790,1),(10,87791,1),(10,87792,1),(10,87795,1),(10,87796,1),(10,87798,1),(10,87877,1),(10,87878,1),(10,87879,1),(10,87882,1),(10,87883,1),(10,87885,1),(10,87964,1),(10,87965,1),(10,87966,1),(10,87967,1),(10,87968,1),(10,87969,1),(10,87970,1),(10,87971,1),(10,87972,1),(10,87973,1),(10,87974,1),(10,87975,1),(10,87976,1),(10,87977,1),(10,87978,1),(10,87979,1),(10,87980,1),(10,87982,1),(10,87984,1),(10,87985,1),(10,87986,1),(10,87987,1),(10,87988,1),(10,87989,1),(10,87993,1),(10,87995,1),(10,87996,1),(10,87997,1),(10,87998,1),(10,87999,1),(10,88000,1),(10,88001,1),(10,88036,1),(10,88037,1),(10,88038,1),(10,88039,1),(10,88040,1),(10,88041,1),(10,88042,1),(10,88043,1),(10,88044,1),(10,88045,1),(10,88046,1),(10,88047,1),(10,88048,1),(10,88049,1),(10,88050,1),(10,88052,1),(10,88054,1),(10,88055,1),(10,88056,1),(10,88059,1),(10,88061,1),(10,88062,1),(10,88063,1),(10,88089,1),(10,88090,1),(10,88091,1),(10,88092,1),(10,88093,1),(10,88094,1),(10,88095,1),(10,88096,1),(10,88097,1),(10,88098,1),(10,88099,1),(10,88100,1),(10,88101,1),(10,88102,1),(10,88103,1),(10,88104,1),(10,88105,1),(10,88107,1),(10,88109,1),(10,88110,1),(10,88111,1),(10,88112,1),(10,88113,1),(10,88114,1),(10,88118,1),(10,88120,1),(10,88121,1),(10,88122,1),(10,88123,1),(10,88125,1),(10,88161,1),(10,88162,1),(10,88163,1),(10,88164,1),(10,88165,1),(10,88166,1),(10,88167,1),(10,88168,1),(10,88169,1),(10,88170,1),(10,88171,1),(10,88172,1),(10,88173,1),(10,88174,1),(10,88175,1),(10,88177,1),(10,88179,1),(10,88180,1),(10,88181,1),(10,88184,1),(10,88186,1),(10,88187,1),(10,88188,1),(10,88215,1),(10,88216,1),(10,88217,1),(10,88285,1),(10,88286,1),(10,88287,1),(10,88336,1),(10,88337,1),(10,88338,1),(10,88339,1),(10,88340,1),(10,88406,1),(10,88407,1),(10,88408,1),(10,86408,3),(10,86982,3),(10,88002,3),(10,88003,3),(10,88064,3),(10,88127,3),(10,88128,3),(10,88189,3),(10,88214,6),(10,88335,6),(10,86737,7),(10,87311,7),(10,87495,7),(10,87496,7),(10,87510,7),(10,87511,7),(10,87640,7),(10,87655,7),(10,87754,7),(10,87769,7),(11,86276,1),(11,86278,1),(11,86279,1),(11,86280,1),(11,86281,1),(11,86282,1),(11,86329,1),(11,86331,1),(11,86343,1),(11,86355,1),(11,86383,1),(11,86384,1),(11,86387,1),(11,86388,1),(11,86391,1),(11,86392,1),(11,86399,1),(11,86409,1),(11,86433,1),(11,86436,1),(11,86437,1),(11,86438,1),(11,86441,1),(11,86450,1),(11,86452,1),(11,86458,1),(11,86476,1),(11,86489,1),(11,86490,1),(11,86495,1),(11,86500,1),(11,86502,1),(11,86504,1),(11,86514,1),(11,86619,1),(11,86785,1),(11,86787,1),(11,86806,1),(11,86832,1),(11,86835,1),(11,86838,1),(11,86839,1),(11,86840,1),(11,86845,1),(11,86848,1),(11,86860,1),(11,86861,1),(11,86879,1),(11,86903,1),(11,86917,1),(11,86929,1),(11,86945,1),(11,86946,1),(11,86955,1),(11,86962,1),(11,87011,1),(11,87063,1),(11,87064,1),(11,87074,1),(11,87076,1),(11,87078,1),(11,87088,1),(11,87193,1),(11,87359,1),(11,87361,1),(11,87380,1),(11,87406,1),(11,87409,1),(11,87412,1),(11,87413,1),(11,87414,1),(11,87419,1),(11,87422,1),(11,87494,1),(11,87524,1),(11,87550,1),(11,87564,1),(11,87581,1),(11,87586,1),(11,87587,1),(11,87591,1),(11,87593,1),(11,87596,1),(11,87597,1),(11,87598,1),(11,87599,1),(11,87600,1),(11,87601,1),(11,87602,1),(11,87603,1),(11,87606,1),(11,87610,1),(11,87611,1),(11,87676,1),(11,87693,1),(11,87698,1),(11,87699,1),(11,87705,1),(11,87706,1),(11,87713,1),(11,87716,1),(11,87720,1),(11,87724,1),(11,87725,1),(11,87885,1),(11,87987,1),(11,87995,1),(11,88000,1),(11,88001,1),(11,88036,1),(11,88037,1),(11,88038,1),(11,88039,1),(11,88051,1),(11,88052,1),(11,88053,1),(11,88054,1),(11,88055,1),(11,88056,1),(11,88059,1),(11,88060,1),(11,88061,1),(11,88089,1),(11,88090,1),(11,88091,1),(11,88092,1),(11,88094,1),(11,88106,1),(11,88107,1),(11,88108,1),(11,88109,1),(11,88111,1),(11,88112,1),(11,88113,1),(11,88114,1),(11,88118,1),(11,88119,1),(11,88120,1),(11,88125,1),(11,88161,1),(11,88162,1),(11,88163,1),(11,88164,1),(11,88176,1),(11,88177,1),(11,88178,1),(11,88179,1),(11,88180,1),(11,88181,1),(11,88184,1),(11,88185,1),(11,88186,1),(11,88340,1),(11,88457,1),(11,88458,1),(11,88459,1),(11,88460,1),(11,88461,1),(11,88462,1),(11,88463,1),(11,88464,1),(11,88465,1),(11,88466,1),(11,88467,1),(11,88468,1),(11,88469,1),(11,88470,1),(11,88471,1),(11,88472,1),(11,88473,1),(11,88474,1),(11,88475,1),(11,88476,1),(11,88477,1),(11,88478,1),(11,88479,1),(11,88480,1),(11,88481,1),(11,88482,1),(11,88483,1),(11,88484,1),(11,88485,1),(11,88486,1),(11,88487,1),(11,88488,1),(11,88489,1),(11,88490,1),(11,88491,1),(11,88492,1),(11,88493,1),(11,88494,1),(11,88495,1),(11,88496,1),(11,88497,1),(11,88498,1),(11,88499,1),(11,88500,1),(11,88501,1),(11,88502,1),(11,88503,1),(11,88504,1),(11,88505,1),(11,88506,1),(11,88507,1),(11,88508,1),(11,88509,1),(11,88510,1),(11,88511,1),(11,88512,1),(11,88513,1),(11,88514,1),(11,88515,1),(11,88516,1),(11,88517,1),(11,88577,1),(11,88578,1),(11,88579,1),(11,88580,1),(11,88581,1),(11,88582,1),(11,88583,1),(11,88584,1),(11,88585,1),(11,88586,1),(11,88587,1),(11,88588,1),(11,88589,1),(11,88622,1),(11,88623,1),(11,88624,1),(11,88625,1),(11,88626,1),(11,88627,1),(11,88628,1),(11,88629,1),(11,88630,1),(11,88631,1),(11,88632,1),(11,88633,1),(11,88634,1),(11,88635,1),(11,88636,1),(11,88637,1),(11,88638,1),(11,88639,1),(11,88640,1),(11,88641,1),(11,88642,1),(11,88643,1),(11,88644,1),(11,88645,1),(11,88646,1),(11,88647,1),(11,88648,1),(11,88649,1),(11,88650,1),(11,88651,1),(11,88652,1),(11,88653,1),(11,88654,1),(11,88655,1),(11,88656,1),(11,88657,1),(11,88658,1),(11,88659,1),(11,88660,1),(11,88661,1),(11,88662,1),(11,88663,1),(11,88664,1),(11,88665,1),(11,88666,1),(11,88667,1),(11,88668,1),(11,88719,1),(11,88720,1),(11,88721,1),(11,88722,1),(11,88723,1),(11,88724,1),(11,88725,1),(11,88726,1),(11,88727,1),(11,88728,1),(11,88729,1),(11,88730,1),(11,88731,1),(11,86982,3),(11,88127,3),(11,88128,3),(11,86408,4),(11,88002,4),(11,88003,4),(11,88064,4),(11,88189,4),(11,88456,6),(11,88576,6),(11,88621,6),(11,88718,6),(11,86499,7),(11,87073,7),(11,87424,7),(11,87425,7),(11,87451,7),(11,87458,7),(11,87459,7),(11,87485,7),(12,86282,1),(12,86286,1),(12,86287,1),(12,86288,1),(12,86305,1),(12,86326,1),(12,86328,1),(12,86329,1),(12,86343,1),(12,86354,1),(12,86355,1),(12,86371,1),(12,86372,1),(12,86381,1),(12,86409,1),(12,86437,1),(12,86441,1),(12,86489,1),(12,86490,1),(12,86500,1),(12,86502,1),(12,86514,1),(12,86619,1),(12,86758,1),(12,86785,1),(12,86786,1),(12,86787,1),(12,86805,1),(12,86806,1),(12,86832,1),(12,86835,1),(12,86838,1),(12,86839,1),(12,86840,1),(12,86845,1),(12,86848,1),(12,86860,1),(12,86861,1),(12,86862,1),(12,86879,1),(12,86900,1),(12,86902,1),(12,86903,1),(12,86917,1),(12,86928,1),(12,86929,1),(12,86945,1),(12,86946,1),(12,86955,1),(12,87011,1),(12,87063,1),(12,87064,1),(12,87074,1),(12,87076,1),(12,87088,1),(12,87193,1),(12,87332,1),(12,87359,1),(12,87360,1),(12,87361,1),(12,87379,1),(12,87380,1),(12,87406,1),(12,87409,1),(12,87412,1),(12,87413,1),(12,87414,1),(12,87419,1),(12,87422,1),(12,87524,1),(12,87550,1),(12,87564,1),(12,87581,1),(12,87586,1),(12,87587,1),(12,87592,1),(12,87593,1),(12,87599,1),(12,87602,1),(12,87606,1),(12,87610,1),(12,87611,1),(12,87676,1),(12,87693,1),(12,87698,1),(12,87699,1),(12,87705,1),(12,87706,1),(12,87713,1),(12,87716,1),(12,87720,1),(12,87724,1),(12,87725,1),(12,87798,1),(12,87885,1),(12,87964,1),(12,87965,1),(12,87966,1),(12,87967,1),(12,87969,1),(12,87981,1),(12,87982,1),(12,87983,1),(12,87984,1),(12,87986,1),(12,87987,1),(12,87988,1),(12,87989,1),(12,87990,1),(12,87993,1),(12,87994,1),(12,87996,1),(12,87997,1),(12,88000,1),(12,88001,1),(12,88036,1),(12,88037,1),(12,88038,1),(12,88039,1),(12,88051,1),(12,88052,1),(12,88053,1),(12,88054,1),(12,88055,1),(12,88056,1),(12,88057,1),(12,88059,1),(12,88060,1),(12,88062,1),(12,88089,1),(12,88090,1),(12,88091,1),(12,88092,1),(12,88094,1),(12,88106,1),(12,88107,1),(12,88108,1),(12,88109,1),(12,88111,1),(12,88112,1),(12,88113,1),(12,88114,1),(12,88115,1),(12,88118,1),(12,88119,1),(12,88121,1),(12,88122,1),(12,88125,1),(12,88161,1),(12,88162,1),(12,88163,1),(12,88164,1),(12,88176,1),(12,88177,1),(12,88178,1),(12,88179,1),(12,88180,1),(12,88181,1),(12,88182,1),(12,88184,1),(12,88185,1),(12,88187,1),(12,88340,1),(12,88457,1),(12,88459,1),(12,88468,1),(12,88469,1),(12,88482,1),(12,88483,1),(12,88484,1),(12,88485,1),(12,88486,1),(12,88487,1),(12,88488,1),(12,88489,1),(12,88490,1),(12,88491,1),(12,88492,1),(12,88493,1),(12,88494,1),(12,88495,1),(12,88496,1),(12,88497,1),(12,88498,1),(12,88499,1),(12,88500,1),(12,88501,1),(12,88502,1),(12,88503,1),(12,88504,1),(12,88505,1),(12,88506,1),(12,88507,1),(12,88515,1),(12,88577,1),(12,88578,1),(12,88579,1),(12,88580,1),(12,88581,1),(12,88582,1),(12,88583,1),(12,88584,1),(12,88585,1),(12,88586,1),(12,88587,1),(12,88588,1),(12,88622,1),(12,88623,1),(12,88624,1),(12,88625,1),(12,88626,1),(12,88627,1),(12,88628,1),(12,88629,1),(12,88630,1),(12,88631,1),(12,88636,1),(12,88637,1),(12,88638,1),(12,88639,1),(12,88640,1),(12,88641,1),(12,88642,1),(12,88643,1),(12,88644,1),(12,88645,1),(12,88646,1),(12,88647,1),(12,88648,1),(12,88649,1),(12,88650,1),(12,88651,1),(12,88652,1),(12,88653,1),(12,88654,1),(12,88655,1),(12,88656,1),(12,88657,1),(12,88658,1),(12,88659,1),(12,88660,1),(12,88661,1),(12,88662,1),(12,88663,1),(12,88664,1),(12,88665,1),(12,88666,1),(12,88667,1),(12,88668,1),(12,88719,1),(12,88720,1),(12,88721,1),(12,88722,1),(12,88723,1),(12,88724,1),(12,88725,1),(12,88726,1),(12,88727,1),(12,88728,1),(12,88729,1),(12,88730,1),(12,88766,1),(12,88767,1),(12,88768,1),(12,88769,1),(12,88770,1),(12,88771,1),(12,88772,1),(12,88773,1),(12,88774,1),(12,88775,1),(12,88776,1),(12,88777,1),(12,88778,1),(12,88779,1),(12,88780,1),(12,88781,1),(12,88877,1),(12,88878,1),(12,88879,1),(12,88880,1),(12,88881,1),(12,88882,1),(12,88933,1),(12,88934,1),(12,88935,1),(12,88936,1),(12,88937,1),(12,88938,1),(12,88939,1),(12,89044,1),(12,89045,1),(12,89046,1),(12,89047,1),(12,89048,1),(12,89049,1),(12,86396,2),(12,88782,2),(12,88783,2),(12,88784,2),(12,88883,2),(12,88940,2),(12,88941,2),(12,88942,2),(12,88943,2),(12,89050,2),(12,86388,3),(12,86408,3),(12,86962,3),(12,86982,3),(12,88002,3),(12,88003,3),(12,88127,3),(12,88128,3),(12,88064,4),(12,88189,4),(12,88763,6),(12,88875,6),(12,88930,6),(12,89042,6),(12,86499,7),(12,87073,7),(12,87424,7),(12,87425,7),(12,87451,7),(12,87458,7),(12,87459,7),(12,87485,7),(12,88764,10),(12,88765,10),(12,88876,10),(12,88931,10),(12,88932,10),(12,89043,10),(13,86278,1),(13,86279,1),(13,86280,1),(13,86281,1),(13,86282,1),(13,86330,1),(13,86354,1),(13,86355,1),(13,86383,1),(13,86384,1),(13,86385,1),(13,86390,1),(13,86396,1),(13,86397,1),(13,86409,1),(13,86423,1),(13,86428,1),(13,86434,1),(13,86437,1),(13,86441,1),(13,86446,1),(13,86447,1),(13,86456,1),(13,86457,1),(13,86458,1),(13,86463,1),(13,86476,1),(13,86485,1),(13,86499,1),(13,86500,1),(13,86502,1),(13,86552,1),(13,86553,1),(13,86554,1),(13,86564,1),(13,86654,1),(13,86655,1),(13,86713,1),(13,86729,1),(13,86736,1),(13,86737,1),(13,86749,1),(13,86761,1),(13,86805,1),(13,86806,1),(13,86832,1),(13,86835,1),(13,86838,1),(13,86839,1),(13,86840,1),(13,86845,1),(13,86848,1),(13,86852,1),(13,86853,1),(13,86854,1),(13,86855,1),(13,86856,1),(13,86904,1),(13,86928,1),(13,86929,1),(13,86957,1),(13,86958,1),(13,86959,1),(13,86964,1),(13,86970,1),(13,86971,1),(13,86983,1),(13,86997,1),(13,87002,1),(13,87008,1),(13,87011,1),(13,87015,1),(13,87020,1),(13,87021,1),(13,87030,1),(13,87031,1),(13,87032,1),(13,87037,1),(13,87050,1),(13,87059,1),(13,87073,1),(13,87074,1),(13,87076,1),(13,87126,1),(13,87127,1),(13,87128,1),(13,87131,1),(13,87138,1),(13,87228,1),(13,87229,1),(13,87287,1),(13,87303,1),(13,87310,1),(13,87311,1),(13,87323,1),(13,87335,1),(13,87379,1),(13,87380,1),(13,87406,1),(13,87409,1),(13,87412,1),(13,87413,1),(13,87414,1),(13,87419,1),(13,87422,1),(13,87425,1),(13,87459,1),(13,87493,1),(13,87494,1),(13,87495,1),(13,87496,1),(13,87508,1),(13,87509,1),(13,87510,1),(13,87511,1),(13,87523,1),(13,87549,1),(13,87595,1),(13,87598,1),(13,87599,1),(13,87600,1),(13,87601,1),(13,87602,1),(13,87603,1),(13,87613,1),(13,87640,1),(13,87641,1),(13,87642,1),(13,87645,1),(13,87655,1),(13,87656,1),(13,87700,1),(13,87709,1),(13,87712,1),(13,87713,1),(13,87714,1),(13,87715,1),(13,87716,1),(13,87717,1),(13,87727,1),(13,87754,1),(13,87755,1),(13,87756,1),(13,87759,1),(13,87769,1),(13,87770,1),(13,88000,1),(13,88038,1),(13,88039,1),(13,88040,1),(13,88041,1),(13,88042,1),(13,88043,1),(13,88046,1),(13,88047,1),(13,88048,1),(13,88049,1),(13,88050,1),(13,88059,1),(13,88061,1),(13,88125,1),(13,88163,1),(13,88164,1),(13,88165,1),(13,88166,1),(13,88167,1),(13,88168,1),(13,88171,1),(13,88172,1),(13,88173,1),(13,88174,1),(13,88175,1),(13,88184,1),(13,88186,1),(13,88466,1),(13,88468,1),(13,88469,1),(13,88470,1),(13,88472,1),(13,88473,1),(13,88474,1),(13,88476,1),(13,88485,1),(13,88492,1),(13,88581,1),(13,88649,1),(13,88723,1),(13,89097,1),(13,89098,1),(13,89099,1),(13,89100,1),(13,89101,1),(13,89102,1),(13,89103,1),(13,89104,1),(13,89105,1),(13,89106,1),(13,89107,1),(13,89108,1),(13,89109,1),(13,89110,1),(13,89111,1),(13,89112,1),(13,89113,1),(13,89115,1),(13,89116,1),(13,89117,1),(13,89118,1),(13,89119,1),(13,89120,1),(13,89121,1),(13,89122,1),(13,89123,1),(13,89124,1),(13,89125,1),(13,89126,1),(13,89127,1),(13,89128,1),(13,89129,1),(13,89130,1),(13,89131,1),(13,89132,1),(13,89133,1),(13,89134,1),(13,89135,1),(13,89136,1),(13,89137,1),(13,89138,1),(13,89139,1),(13,89140,1),(13,89141,1),(13,89142,1),(13,89143,1),(13,89144,1),(13,89145,1),(13,89146,1),(13,89147,1),(13,89148,1),(13,89149,1),(13,89150,1),(13,89151,1),(13,89152,1),(13,89153,1),(13,89154,1),(13,89155,1),(13,89156,1),(13,89157,1),(13,89158,1),(13,89159,1),(13,89160,1),(13,89161,1),(13,89162,1),(13,89163,1),(13,89164,1),(13,89165,1),(13,89166,1),(13,89167,1),(13,89170,1),(13,89171,1),(13,89172,1),(13,89173,1),(13,89174,1),(13,89175,1),(13,89176,1),(13,89177,1),(13,89178,1),(13,89179,1),(13,89180,1),(13,89181,1),(13,89182,1),(13,89183,1),(13,89184,1),(13,89185,1),(13,89186,1),(13,89187,1),(13,89188,1),(13,89189,1),(13,89190,1),(13,89191,1),(13,89254,1),(13,89255,1),(13,89256,1),(13,89257,1),(13,89258,1),(13,89259,1),(13,89260,1),(13,89261,1),(13,89262,1),(13,89263,1),(13,89264,1),(13,89265,1),(13,89266,1),(13,89267,1),(13,89268,1),(13,89269,1),(13,89270,1),(13,89271,1),(13,89272,1),(13,89273,1),(13,89274,1),(13,89275,1),(13,89276,1),(13,89277,1),(13,89278,1),(13,89279,1),(13,89280,1),(13,89281,1),(13,89282,1),(13,89283,1),(13,89284,1),(13,89285,1),(13,89286,1),(13,89287,1),(13,89288,1),(13,89289,1),(13,89290,1),(13,89291,1),(13,89292,1),(13,89293,1),(13,89294,1),(13,89295,1),(13,89296,1),(13,89297,1),(13,89344,1),(13,89345,1),(13,89346,1),(13,89347,1),(13,89348,1),(13,89349,1),(13,89350,1),(13,89351,1),(13,89352,1),(13,89353,1),(13,89354,1),(13,89355,1),(13,89356,1),(13,89357,1),(13,89358,1),(13,89359,1),(13,89360,1),(13,89362,1),(13,89363,1),(13,89364,1),(13,89365,1),(13,89366,1),(13,89367,1),(13,89368,1),(13,89369,1),(13,89370,1),(13,89371,1),(13,89372,1),(13,89373,1),(13,89374,1),(13,89375,1),(13,89376,1),(13,89377,1),(13,89378,1),(13,89379,1),(13,89380,1),(13,89381,1),(13,89382,1),(13,89383,1),(13,89384,1),(13,89385,1),(13,89386,1),(13,89387,1),(13,89388,1),(13,89389,1),(13,89390,1),(13,89391,1),(13,89392,1),(13,89393,1),(13,89394,1),(13,89395,1),(13,89396,1),(13,89397,1),(13,89398,1),(13,89399,1),(13,89400,1),(13,89401,1),(13,89402,1),(13,89403,1),(13,89404,1),(13,89405,1),(13,89406,1),(13,89407,1),(13,89408,1),(13,89409,1),(13,89410,1),(13,89411,1),(13,89412,1),(13,89413,1),(13,89414,1),(13,89415,1),(13,89416,1),(13,89417,1),(13,89418,1),(13,89419,1),(13,89420,1),(13,89421,1),(13,89422,1),(13,89423,1),(13,89426,1),(13,89427,1),(13,89428,1),(13,89429,1),(13,89430,1),(13,89431,1),(13,89432,1),(13,89433,1),(13,89434,1),(13,89435,1),(13,89436,1),(13,89437,1),(13,89438,1),(13,89439,1),(13,89440,1),(13,89441,1),(13,89442,1),(13,89443,1),(13,89444,1),(13,89445,1),(13,89446,1),(13,89447,1),(13,89504,1),(13,89505,1),(13,89506,1),(13,89507,1),(13,89508,1),(13,89509,1),(13,89510,1),(13,89511,1),(13,89512,1),(13,89513,1),(13,89514,1),(13,89515,1),(13,89516,1),(13,89517,1),(13,89518,1),(13,89519,1),(13,89520,1),(13,89521,1),(13,89522,1),(13,89523,1),(13,89524,1),(13,89525,1),(13,89526,1),(13,89527,1),(13,89528,1),(13,89529,1),(13,89530,1),(13,89531,1),(13,89532,1),(13,89533,1),(13,89534,1),(13,89535,1),(13,89536,1),(13,89537,1),(13,89538,1),(13,89539,1),(13,89540,1),(13,89541,1),(13,89542,1),(13,89543,1),(13,89544,1),(13,89545,1),(13,89546,1),(13,89547,1),(13,86371,2),(13,86945,2),(13,87593,2),(13,87596,2),(13,87706,2),(13,87710,2),(13,89192,2),(13,89193,2),(13,89448,2),(13,89449,2),(13,89298,3),(13,89548,3),(13,89114,4),(13,89168,4),(13,89169,4),(13,89361,4),(13,89424,4),(13,89425,4),(13,87677,6),(13,89502,6),(13,89503,6),(13,86486,7),(13,86557,7),(13,87060,7),(13,87564,7),(13,87565,7),(13,87566,7),(13,87676,7),(13,87678,7),(14,86343,1),(14,86370,1),(14,86371,1),(14,86372,1),(14,86376,1),(14,86387,1),(14,86438,1),(14,86499,1),(14,86500,1),(14,86502,1),(14,86552,1),(14,86564,1),(14,86655,1),(14,86713,1),(14,86736,1),(14,86761,1),(14,86826,1),(14,86835,1),(14,86838,1),(14,86839,1),(14,86840,1),(14,86845,1),(14,86848,1),(14,86917,1),(14,86944,1),(14,86945,1),(14,86946,1),(14,86950,1),(14,86961,1),(14,87012,1),(14,87073,1),(14,87074,1),(14,87076,1),(14,87126,1),(14,87138,1),(14,87229,1),(14,87287,1),(14,87310,1),(14,87335,1),(14,87400,1),(14,87409,1),(14,87412,1),(14,87413,1),(14,87414,1),(14,87419,1),(14,87422,1),(14,87425,1),(14,87459,1),(14,87568,1),(14,87573,1),(14,87574,1),(14,87575,1),(14,87585,1),(14,87586,1),(14,87587,1),(14,87594,1),(14,87605,1),(14,87606,1),(14,87608,1),(14,87610,1),(14,87645,1),(14,87654,1),(14,87680,1),(14,87685,1),(14,87686,1),(14,87687,1),(14,87697,1),(14,87698,1),(14,87699,1),(14,87719,1),(14,87720,1),(14,87722,1),(14,87724,1),(14,87759,1),(14,87768,1),(14,87790,1),(14,87791,1),(14,87792,1),(14,87795,1),(14,87796,1),(14,87798,1),(14,87877,1),(14,87878,1),(14,87879,1),(14,87882,1),(14,87883,1),(14,87885,1),(14,87966,1),(14,87969,1),(14,87970,1),(14,87971,1),(14,87972,1),(14,87973,1),(14,87974,1),(14,87975,1),(14,87976,1),(14,87977,1),(14,87978,1),(14,87979,1),(14,87980,1),(14,87993,1),(14,87999,1),(14,88000,1),(14,88001,1),(14,88038,1),(14,88041,1),(14,88042,1),(14,88043,1),(14,88044,1),(14,88045,1),(14,88046,1),(14,88047,1),(14,88048,1),(14,88049,1),(14,88050,1),(14,88059,1),(14,88091,1),(14,88094,1),(14,88095,1),(14,88096,1),(14,88097,1),(14,88098,1),(14,88099,1),(14,88100,1),(14,88101,1),(14,88102,1),(14,88103,1),(14,88104,1),(14,88105,1),(14,88118,1),(14,88125,1),(14,88163,1),(14,88166,1),(14,88167,1),(14,88168,1),(14,88169,1),(14,88170,1),(14,88171,1),(14,88172,1),(14,88173,1),(14,88174,1),(14,88175,1),(14,88184,1),(14,88339,1),(14,88340,1),(14,89262,1),(14,89282,1),(14,89512,1),(14,89532,1),(14,89594,1),(14,89595,1),(14,89596,1),(14,89597,1),(14,89598,1),(14,89599,1),(14,89600,1),(14,89601,1),(14,89602,1),(14,89603,1),(14,89604,1),(14,89605,1),(14,89606,1),(14,89607,1),(14,89608,1),(14,89609,1),(14,89610,1),(14,89611,1),(14,89612,1),(14,89613,1),(14,89614,1),(14,89662,1),(14,89663,1),(14,89664,1),(14,89665,1),(14,89666,1),(14,89667,1),(14,89668,1),(14,89669,1),(14,89670,1),(14,89671,1),(14,89672,1),(14,89674,1),(14,89675,1),(14,89676,1),(14,89677,1),(14,89713,1),(14,89714,1),(14,89715,1),(14,89716,1),(14,89717,1),(14,89718,1),(14,89719,1),(14,89720,1),(14,89721,1),(14,89722,1),(14,89723,1),(14,89724,1),(14,89725,1),(14,89726,1),(14,89727,1),(14,89728,1),(14,89729,1),(14,89730,1),(14,89731,1),(14,89732,1),(14,89733,1),(14,89734,1),(14,89781,1),(14,89782,1),(14,89783,1),(14,89784,1),(14,89785,1),(14,89786,1),(14,89787,1),(14,89788,1),(14,89789,1),(14,89790,1),(14,89791,1),(14,89793,1),(14,89794,1),(14,89795,1),(14,89796,1),(14,89616,3),(14,89736,3),(14,89615,4),(14,89673,4),(14,89735,4),(14,89792,4),(14,86737,7),(14,87311,7),(14,87495,7),(14,87496,7),(14,87510,7),(14,87511,7),(14,87640,7),(14,87655,7),(14,87754,7),(14,87769,7),(15,86413,2),(15,86987,2),(15,89136,2),(15,89386,2),(15,89834,2),(15,89835,2),(15,89836,2),(15,89837,2),(15,89838,2),(15,89848,2),(15,89849,2),(15,89850,2),(15,89851,2),(15,89852,2),(15,89859,2),(15,89860,2),(15,89861,2),(15,89862,2),(15,89615,3),(15,89616,3),(15,89673,3),(15,89735,3),(15,89736,3),(15,89792,3),(15,87496,6),(15,87511,6),(15,89832,6),(15,89833,6),(15,89846,6),(15,89847,6),(15,87495,8),(15,87510,8);
/*!40000 ALTER TABLE `ps_search_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_search_word`
--

DROP TABLE IF EXISTS `ps_search_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_search_word` (
  `id_word` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_lang` int(10) unsigned NOT NULL,
  `word` varchar(15) NOT NULL,
  PRIMARY KEY (`id_word`),
  UNIQUE KEY `id_lang` (`id_lang`,`id_shop`,`word`)
) ENGINE=InnoDB AUTO_INCREMENT=89863 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_search_word`
--

LOCK TABLES `ps_search_word` WRITE;
/*!40000 ALTER TABLE `ps_search_word` DISABLE KEYS */;
INSERT INTO `ps_search_word` VALUES (86498,1,1,'-'),(87609,1,1,'---------------'),(86388,1,1,'1'),(87987,1,1,'10'),(87580,1,1,'105'),(87573,1,1,'11'),(74505,1,1,'111'),(89102,1,1,'12'),(86299,1,1,'130'),(86334,1,1,'143'),(87577,1,1,'148'),(86328,1,1,'15'),(89594,1,1,'153'),(88763,1,1,'15mm'),(86307,1,1,'1875'),(86387,1,1,'2'),(86288,1,1,'20'),(88774,1,1,'200'),(86380,1,1,'20042014'),(86285,1,1,'2010'),(86375,1,1,'2012'),(86368,1,1,'20134th'),(86376,1,1,'2014'),(86354,1,1,'2015'),(86381,1,1,'2016'),(86364,1,1,'2017'),(86332,1,1,'21'),(87576,1,1,'240g'),(87985,1,1,'25'),(86438,1,1,'3'),(87996,1,1,'30'),(89599,1,1,'3d'),(86437,1,1,'4'),(88461,1,1,'45'),(88456,1,1,'45mm'),(89611,1,1,'4band'),(87592,1,1,'5'),(86297,1,1,'5000'),(88514,1,1,'6'),(87991,1,1,'66'),(88781,1,1,'7'),(88509,1,1,'8'),(89098,1,1,'88'),(88515,1,1,'9'),(88462,1,1,'90'),(89614,1,1,'925'),(86337,1,1,'9789574173310'),(89177,1,1,'a'),(86303,1,1,'art'),(86370,1,1,'artist'),(86345,1,1,'arts'),(88765,1,1,'b'),(86326,1,1,'back'),(86346,1,1,'bank'),(87795,1,1,'beach'),(86320,1,1,'binding'),(86314,1,1,'black'),(86372,1,1,'book'),(86356,1,1,'books'),(86362,1,1,'ca'),(87579,1,1,'card'),(87575,1,1,'cean'),(86340,1,1,'central'),(87587,1,1,'chieh'),(87794,1,1,'chihsingtan'),(87569,1,1,'ching'),(87607,1,1,'ching-shui'),(87604,1,1,'chingshui'),(87974,1,1,'chishingtan'),(86294,1,1,'chyaulun'),(87977,1,1,'clear'),(87571,1,1,'cliff'),(86329,1,1,'cm'),(89597,1,1,'coast'),(86357,1,1,'codex'),(86338,1,1,'collection'),(86351,1,1,'collectors'),(86290,1,1,'color'),(88459,1,1,'com'),(86319,1,1,'coptic'),(86313,1,1,'cover'),(86359,1,1,'craneway'),(89605,1,1,'daily'),(88778,1,1,'december'),(86378,1,1,'del'),(88779,1,1,'dergi'),(89598,1,1,'design'),(87968,1,1,'designed'),(89602,1,1,'differentintegr'),(86291,1,1,'digital'),(87970,1,1,'drawing'),(88481,1,1,'e'),(89596,1,1,'eastern'),(86287,1,1,'edition'),(86309,1,1,'egyptian'),(86298,1,1,'electrolnk'),(88772,1,1,'etsy'),(86367,1,1,'exhibition'),(86321,1,1,'exposed'),(89101,1,1,'fabric'),(87979,1,1,'face'),(86353,1,1,'fair'),(86302,1,1,'fine'),(86286,1,1,'first'),(86325,1,1,'flat'),(87583,1,1,'foil'),(89603,1,1,'formed'),(89105,1,1,'frankie'),(86289,1,1,'full'),(87595,1,1,'g'),(86310,1,1,'gold'),(86366,1,1,'group'),(86300,1,1,'gsm'),(86333,1,1,'h'),(89600,1,1,'handmade'),(86324,1,1,'hole'),(87582,1,1,'hot'),(86295,1,1,'hp'),(88771,1,1,'http'),(87796,1,1,'hualien'),(86276,1,1,'i'),(86296,1,1,'indigo'),(87973,1,1,'ink'),(86305,1,1,'inner'),(89595,1,1,'inspired'),(86369,1,1,'international'),(86336,1,1,'isbn'),(87578,1,1,'ivory'),(88215,1,1,'japanese'),(87997,1,1,'july'),(87992,1,1,'june'),(86308,1,1,'kg'),(87967,1,1,'kind'),(87596,1,1,'l'),(88766,1,1,'landscape'),(86323,1,1,'larger'),(86341,1,1,'library'),(89097,1,1,'light'),(88773,1,1,'listing'),(87798,1,1,'liu'),(86355,1,1,'liuyingchieh'),(87988,1,1,'long'),(87989,1,1,'loop'),(87593,1,1,'m'),(87995,1,1,'made'),(88767,1,1,'masking'),(86312,1,1,'metallic'),(87581,1,1,'mm'),(89613,1,1,'mmsterling'),(89099,1,1,'moisture'),(89178,1,1,'n'),(86339,1,1,'national'),(87964,1,1,'new'),(88775,1,1,'numbered'),(87574,1,1,'o'),(87608,1,1,'o-cean'),(87605,1,1,'ocean'),(86292,1,1,'offset'),(87966,1,1,'one'),(87969,1,1,'original'),(88480,1,1,'p'),(87980,1,1,'pacific'),(86306,1,1,'page'),(86335,1,1,'pages'),(86379,1,1,'paine'),(88769,1,1,'painting'),(86304,1,1,'paper'),(87983,1,1,'paper1'),(88216,1,1,'paperset'),(86360,1,1,'pavilion'),(87976,1,1,'pebble'),(87972,1,1,'pen'),(88458,1,1,'pinkoi'),(87993,1,1,'printed'),(86293,1,1,'printing'),(86350,1,1,'private'),(86373,1,1,'prize'),(88460,1,1,'product'),(86284,1,1,'published'),(89607,1,1,'purpose'),(86352,1,1,'related'),(86283,1,1,'reproduction'),(86361,1,1,'richmond'),(89608,1,1,'ring'),(87975,1,1,'rocky'),(87984,1,1,'roll'),(88217,1,1,'rolls'),(88776,1,1,'round'),(86371,1,1,'s'),(87965,1,1,'sealed'),(87990,1,1,'second'),(86317,1,1,'section'),(88770,1,1,'series'),(86318,1,1,'sewn'),(86348,1,1,'sheffield'),(87570,1,1,'shui'),(87424,1,1,'significant'),(87585,1,1,'silver'),(89609,1,1,'size'),(87568,1,1,'sketch'),(87793,1,1,'sketches'),(89601,1,1,'slightly'),(88780,1,1,'sold'),(86374,1,1,'solo'),(86322,1,1,'spine'),(87971,1,1,'spread'),(87584,1,1,'stamping'),(88777,1,1,'stickermade'),(86347,1,1,'street'),(89104,1,1,'stretch'),(89604,1,1,'sturdy'),(88764,1,1,'t123456789'),(87998,1,1,'tain'),(86342,1,1,'taipei'),(86343,1,1,'taiwan'),(87797,1,1,'taiwan240g'),(87981,1,1,'taiwanese'),(87572,1,1,'taiwanfrom'),(88768,1,1,'tape'),(86377,1,1,'torres'),(87425,1,1,'travel'),(87597,1,1,'u'),(86349,1,1,'uk'),(86315,1,1,'uncoated'),(86344,1,1,'university'),(89610,1,1,'us'),(86363,1,1,'usa'),(89606,1,1,'use'),(86358,1,1,'v'),(86277,1,1,'venezia'),(86365,1,1,'vi'),(86330,1,1,'w'),(87982,1,1,'washi'),(87978,1,1,'waves'),(89103,1,1,'way'),(86301,1,1,'white'),(89100,1,1,'wicking'),(87986,1,1,'wide'),(89612,1,1,'width'),(86316,1,1,'woodfree'),(88457,1,1,'www'),(86331,1,1,'x'),(89193,1,1,'xl'),(89192,1,1,'xs'),(88479,1,1,'y'),(87586,1,1,'ying'),(87610,1,1,'ying-chieh'),(87606,1,1,'yingchieh'),(86327,1,1,'yoshosu'),(87994,1,1,'yuanpao'),(86311,1,1,'zipang'),(87430,1,1,'あ'),(87432,1,1,'じ'),(87433,1,1,'ま'),(87431,1,1,'ら'),(87429,1,1,'イ'),(86417,1,1,'グ'),(86414,1,1,'ジ'),(87426,1,1,'ト'),(86415,1,1,'パ'),(87428,1,1,'メ'),(86416,1,1,'ン'),(87427,1,1,'ー'),(26389,1,1,'ㄌ'),(26390,1,1,'ㄏ'),(26391,1,1,'ㄑ'),(87494,1,1,'一'),(87790,1,1,'七'),(88498,1,1,'三'),(89146,1,1,'不'),(86443,1,1,'並'),(86497,1,1,'中'),(86452,1,1,'之'),(88493,1,1,'九'),(89151,1,1,'也'),(87523,1,1,'二'),(88464,1,1,'交'),(86431,1,1,'亭'),(89183,1,1,'以'),(88494,1,1,'份'),(89185,1,1,'伴'),(86397,1,1,'位'),(83840,1,1,'低'),(87603,1,1,'作'),(89145,1,1,'你'),(86450,1,1,'使'),(88472,1,1,'來'),(89174,1,1,'供'),(89143,1,1,'保'),(87612,1,1,'信'),(86484,1,1,'個'),(86403,1,1,'倫'),(88784,1,1,'值'),(89186,1,1,'做'),(86402,1,1,'僑'),(87435,1,1,'光'),(86409,1,1,'內'),(86394,1,1,'全'),(86434,1,1,'公'),(86459,1,1,'典'),(86385,1,1,'冊'),(89148,1,1,'冒'),(88496,1,1,'冷'),(86390,1,1,'出'),(86435,1,1,'分'),(88478,1,1,'列'),(86392,1,1,'初'),(86400,1,1,'刷'),(88507,1,1,'前'),(87437,1,1,'剛'),(88475,1,1,'創'),(89125,1,1,'力'),(86457,1,1,'加'),(86279,1,1,'動'),(86467,1,1,'北'),(89158,1,1,'匯'),(89162,1,1,'區'),(87493,1,1,'十'),(88503,1,1,'博'),(87590,1,1,'卡'),(86399,1,1,'印'),(88482,1,1,'卷'),(86404,1,1,'厚'),(88474,1,1,'原'),(86412,1,1,'及'),(86449,1,1,'口'),(87438,1,1,'古'),(89182,1,1,'可'),(86281,1,1,'台'),(89124,1,1,'向'),(89106,1,1,'吸'),(89153,1,1,'吹'),(86495,1,1,'和'),(88476,1,1,'品'),(81500,1,1,'商'),(86476,1,1,'四'),(86461,1,1,'國'),(86493,1,1,'園'),(86463,1,1,'圖'),(89164,1,1,'在'),(87599,1,1,'地'),(89140,1,1,'均'),(86488,1,1,'坊'),(88497,1,1,'坑'),(86411,1,1,'埃'),(89131,1,1,'墨'),(86456,1,1,'外'),(86446,1,1,'大'),(89179,1,1,'好'),(86469,1,1,'學'),(89142,1,1,'宜'),(89132,1,1,'室'),(88502,1,1,'宮'),(86462,1,1,'家'),(88471,1,1,'容'),(88468,1,1,'寫'),(86433,1,1,'寬'),(88516,1,1,'寶'),(86418,1,1,'封'),(88484,1,1,'尾'),(86477,1,1,'屆'),(86470,1,1,'展'),(87524,1,1,'山'),(87566,1,1,'崖'),(86487,1,1,'工'),(89155,1,1,'布'),(88003,1,1,'帶'),(89137,1,1,'常'),(86398,1,1,'平'),(86389,1,1,'年'),(89181,1,1,'幸'),(89188,1,1,'度'),(86496,1,1,'廊'),(87601,1,1,'式'),(89110,1,1,'彈'),(86395,1,1,'彩'),(88490,1,1,'循'),(89159,1,1,'德'),(88463,1,1,'心'),(89152,1,1,'怕'),(89111,1,1,'性'),(89147,1,1,'感'),(89161,1,1,'憩'),(89615,1,1,'戒'),(89133,1,1,'戶'),(81499,1,1,'所'),(87602,1,1,'手'),(88517,1,1,'承'),(89191,1,1,'拿'),(89616,1,1,'指'),(88510,1,1,'捲'),(89108,1,1,'排'),(88487,1,1,'接'),(89173,1,1,'提'),(88501,1,1,'故'),(89176,1,1,'教'),(86396,1,1,'數'),(89156,1,1,'料'),(86489,1,1,'新'),(87565,1,1,'斷'),(86458,1,1,'方'),(86386,1,1,'於'),(86485,1,1,'旅'),(89136,1,1,'日'),(89129,1,1,'昇'),(87611,1,1,'明'),(87791,1,1,'星'),(89163,1,1,'是'),(86426,1,1,'普'),(88467,1,1,'景'),(86441,1,1,'書'),(86471,1,1,'會'),(86444,1,1,'有'),(86393,1,1,'本'),(89115,1,1,'材'),(86424,1,1,'林'),(88783,1,1,'格'),(89157,1,1,'案'),(88506,1,1,'桌'),(89180,1,1,'榮'),(89112,1,1,'機'),(89167,1,1,'步'),(88511,1,1,'每'),(89127,1,1,'毒'),(87564,1,1,'水'),(89109,1,1,'汗'),(87436,1,1,'波'),(87496,1,1,'洋'),(86448,1,1,'洞'),(87495,1,1,'海'),(88500,1,1,'淺'),(88214,1,1,'淼'),(86486,1,1,'清'),(89837,1,1,'湖'),(83841,1,1,'溫'),(89149,1,1,'滿'),(87792,1,1,'潭'),(89107,1,1,'濕'),(87999,1,1,'灘'),(86282,1,1,'灣'),(87434,1,1,'炫'),(88485,1,1,'無'),(89172,1,1,'照'),(89128,1,1,'熱'),(87567,1,1,'燙'),(86480,1,1,'爾'),(87613,1,1,'片'),(86391,1,1,'版'),(87589,1,1,'牙'),(88504,1,1,'物'),(86427,1,1,'特'),(89154,1,1,'獨'),(89175,1,1,'玩'),(89169,1,1,'珈'),(26388,1,1,'球'),(89832,1,1,'琺'),(89168,1,1,'瑜'),(89833,1,1,'瑯'),(86432,1,1,'璇'),(88491,1,1,'環'),(88469,1,1,'生'),(87598,1,1,'產'),(88508,1,1,'用'),(86384,1,1,'畫'),(86451,1,1,'疊'),(86447,1,1,'的'),(86430,1,1,'盧'),(86405,1,1,'磅'),(89170,1,1,'示'),(86425,1,1,'科'),(86278,1,1,'移'),(86494,1,1,'空'),(89138,1,1,'穿'),(86455,1,1,'窄'),(86465,1,1,'立'),(86490,1,1,'竹'),(86475,1,1,'第'),(89171,1,1,'範'),(87591,1,1,'精'),(88477,1,1,'系'),(89836,1,1,'紅'),(89123,1,1,'紗'),(86408,1,1,'紙'),(89838,1,1,'綠'),(89120,1,1,'維'),(88512,1,1,'編'),(88486,1,1,'縫'),(88470,1,1,'繪'),(89119,1,1,'纖'),(86406,1,1,'美'),(86401,1,1,'者'),(89117,1,1,'聚'),(86474,1,1,'聯'),(86442,1,1,'背'),(89113,1,1,'能'),(87525,1,1,'脈'),(88002,1,1,'膠'),(88473,1,1,'自'),(86466,1,1,'臺'),(86422,1,1,'色'),(88499,1,1,'芝'),(88000,1,1,'花'),(86483,1,1,'英'),(89130,1,1,'華'),(86479,1,1,'菲'),(89139,1,1,'著'),(88001,1,1,'蓮'),(89834,1,1,'藍'),(86460,1,1,'藏'),(86468,1,1,'藝'),(89165,1,1,'蘇'),(88513,1,1,'號'),(89835,1,1,'血'),(89135,1,1,'行'),(86407,1,1,'術'),(86428,1,1,'裝'),(86439,1,1,'裸'),(86383,1,1,'製'),(86382,1,1,'複'),(89114,1,1,'褲'),(86420,1,1,'襯'),(88782,1,1,'規'),(86429,1,1,'訂'),(89190,1,1,'計'),(86280,1,1,'記'),(89189,1,1,'設'),(86481,1,1,'評'),(89144,1,1,'護'),(87588,1,1,'象'),(89116,1,1,'質'),(89166,1,1,'路'),(89150,1,1,'身'),(88488,1,1,'軌'),(86445,1,1,'較'),(89121,1,1,'輕'),(87600,1,1,'造'),(89160,1,1,'遊'),(89134,1,1,'運'),(86423,1,1,'道'),(89141,1,1,'適'),(86482,1,1,'選'),(89118,1,1,'酯'),(86492,1,1,'醒'),(89122,1,1,'量'),(86413,1,1,'金'),(87594,1,1,'銀'),(88465,1,1,'錯'),(86436,1,1,'長'),(86453,1,1,'間'),(88489,1,1,'限'),(88505,1,1,'院'),(89184,1,1,'陪'),(88495,1,1,'陽'),(86454,1,1,'隔'),(86472,1,1,'際'),(86473,1,1,'雙'),(89187,1,1,'難'),(86478,1,1,'雪'),(86440,1,1,'露'),(86419,1,1,'面'),(86410,1,1,'頁'),(88466,1,1,'風'),(86464,1,1,'館'),(88483,1,1,'首'),(86491,1,1,'香'),(89126,1,1,'高'),(86421,1,1,'黑'),(88492,1,1,'點'),(86846,1,2,'-feb'),(87649,1,2,'105'),(88589,1,2,'108'),(74519,1,2,'111'),(86767,1,2,'130'),(86783,1,2,'143'),(86782,1,2,'148'),(89662,1,2,'153'),(88875,1,2,'15mm'),(86773,1,2,'1875'),(88877,1,2,'200'),(86511,1,2,'2002'),(86704,1,2,'2003'),(86830,1,2,'20042014'),(86505,1,2,'2010'),(86823,1,2,'2012'),(86817,1,2,'20134th'),(86826,1,2,'2014'),(86805,1,2,'2015'),(86832,1,2,'2016'),(86813,1,2,'2017'),(86727,1,2,'411'),(88576,1,2,'45mm'),(89674,1,2,'4band'),(86753,1,2,'5000'),(88586,1,2,'57177974山水手卷卷首卷'),(89677,1,2,'925'),(86789,1,2,'9789574173310'),(86589,1,2,'accumulated'),(86555,1,2,'alishan'),(86607,1,2,'also'),(89272,1,2,'anti'),(86546,1,2,'around'),(86771,1,2,'art'),(86761,1,2,'artist'),(86849,1,2,'artists'),(86797,1,2,'arts'),(86654,1,2,'artwork'),(86758,1,2,'back'),(86799,1,2,'bank'),(86625,1,2,'base'),(86521,1,2,'bathroom'),(87645,1,2,'beach'),(86624,1,2,'become'),(86596,1,2,'becoming'),(86707,1,2,'bed'),(86529,1,2,'bedroom'),(86533,1,2,'beginning'),(86649,1,2,'binding'),(86779,1,2,'black'),(86536,1,2,'blonde'),(86528,1,2,'body'),(86500,1,2,'book'),(86565,1,2,'books'),(86760,1,2,'bound'),(86841,1,2,'buyer'),(89284,1,2,'canadadesigned'),(87648,1,2,'card'),(86566,1,2,'carrier'),(86592,1,2,'carry'),(87640,1,2,'cean'),(86792,1,2,'central'),(86568,1,2,'characteristic'),(86839,1,2,'chieh'),(87644,1,2,'chihsingtan'),(87641,1,2,'ching'),(87656,1,2,'ching-shui'),(86553,1,2,'chingshui'),(88044,1,2,'chishingtan'),(88048,1,2,'clear'),(86554,1,2,'cliff'),(89288,1,2,'cliffs'),(89665,1,2,'coast'),(89287,1,2,'coastal'),(86807,1,2,'codex'),(86790,1,2,'collection'),(86803,1,2,'collectorsrelat'),(86748,1,2,'color'),(88585,1,2,'com'),(86543,1,2,'comics'),(86645,1,2,'complex'),(86610,1,2,'contact'),(86575,1,2,'continuous'),(86754,1,2,'coptic'),(86759,1,2,'cover'),(86809,1,2,'craneway'),(86594,1,2,'creates'),(86581,1,2,'creation'),(86567,1,2,'creations'),(86599,1,2,'creative'),(86609,1,2,'creator'),(86524,1,2,'curtain'),(89262,1,2,'daily'),(89256,1,2,'dancing'),(88880,1,2,'december'),(86828,1,2,'del'),(86636,1,2,'depth'),(88881,1,2,'dergi'),(89666,1,2,'design'),(88040,1,2,'designed'),(86541,1,2,'diaries'),(89669,1,2,'differentintegr'),(86749,1,2,'digital'),(86640,1,2,'dimensional'),(86617,1,2,'disappear'),(86641,1,2,'distance'),(86523,1,2,'door'),(86526,1,2,'dorm'),(86531,1,2,'draw'),(88041,1,2,'drawing'),(86508,1,2,'drawn'),(86648,1,2,'dreams'),(86562,1,2,'duration'),(86576,1,2,'dynamic'),(86744,1,2,'east'),(89664,1,2,'eastern'),(89274,1,2,'eco'),(89296,1,2,'eco-friendly'),(89294,1,2,'ecofriendly'),(86785,1,2,'edition'),(86774,1,2,'egyptian'),(86652,1,2,'elements'),(86718,1,2,'eluanbi'),(86598,1,2,'entire'),(86842,1,2,'entitled'),(88584,1,2,'etsy'),(86816,1,2,'exhibition'),(86614,1,2,'experience'),(86647,1,2,'express'),(86632,1,2,'extension'),(86603,1,2,'external'),(89267,1,2,'fabric'),(88050,1,2,'face'),(86804,1,2,'fair'),(86548,1,2,'fangliao'),(86510,1,2,'feb'),(86525,1,2,'female'),(86740,1,2,'fenqihu'),(86770,1,2,'fine'),(86514,1,2,'first'),(86757,1,2,'flat'),(86570,1,2,'flipping'),(86595,1,2,'flux'),(87652,1,2,'foil'),(89670,1,2,'formed'),(86650,1,2,'forms'),(86593,1,2,'fragments'),(86642,1,2,'frames'),(89292,1,2,'frankie'),(89275,1,2,'friendly'),(86579,1,2,'fulfill'),(86747,1,2,'full'),(86663,1,2,'future'),(86535,1,2,'giudecca'),(86775,1,2,'gold'),(86711,1,2,'gondola移動記'),(86815,1,2,'group'),(86629,1,2,'growth'),(86768,1,2,'gsm'),(86537,1,2,'hair'),(86507,1,2,'hand'),(89667,1,2,'handmade'),(86733,1,2,'heren'),(89278,1,2,'high'),(89260,1,2,'hiking'),(86756,1,2,'hole'),(86518,1,2,'hostel'),(87651,1,2,'hot'),(86605,1,2,'however'),(88582,1,2,'http'),(86552,1,2,'hualien'),(86580,1,2,'image'),(86577,1,2,'imagination'),(86587,1,2,'imitate'),(86615,1,2,'incidents'),(86752,1,2,'indigo'),(88043,1,2,'ink'),(88578,1,2,'inner'),(89663,1,2,'inspired'),(86637,1,2,'instead'),(86634,1,2,'intend'),(86602,1,2,'intended'),(86560,1,2,'interested'),(86604,1,2,'internal'),(86818,1,2,'international'),(86788,1,2,'isbn'),(87647,1,2,'ivory'),(86509,1,2,'jan'),(88285,1,2,'japanese'),(86600,1,2,'journey'),(88062,1,2,'july'),(88058,1,2,'june'),(88039,1,2,'kind'),(86715,1,2,'kissing'),(88577,1,2,'landscape'),(86622,1,2,'last'),(86658,1,2,'left'),(89298,1,2,'leggings'),(86608,1,2,'lets'),(86793,1,2,'library'),(86586,1,2,'life'),(89261,1,2,'light'),(86784,1,2,'limited'),(86722,1,2,'line'),(86659,1,2,'link'),(86787,1,2,'listing'),(86750,1,2,'lithography'),(86840,1,2,'liu'),(86806,1,2,'liuyingchieh'),(86619,1,2,'long'),(88056,1,2,'loop'),(88061,1,2,'made'),(89283,1,2,'manufactured'),(88579,1,2,'masking'),(86534,1,2,'memories'),(86563,1,2,'memory'),(86778,1,2,'metallic'),(89273,1,2,'microbial'),(89676,1,2,'mmsterling'),(86582,1,2,'mode'),(89268,1,2,'moisture'),(86656,1,2,'moment'),(86644,1,2,'montage'),(86540,1,2,'monthes'),(86734,1,2,'moonrise'),(86578,1,2,'motivation'),(89286,1,2,'mountain'),(86572,1,2,'movement'),(86544,1,2,'movies'),(86583,1,2,'moving'),(86527,1,2,'naked'),(86791,1,2,'national'),(88036,1,2,'new'),(86626,1,2,'next'),(89276,1,2,'non'),(89297,1,2,'non-toxic'),(89295,1,2,'nontoxic'),(86657,1,2,'now'),(86786,1,2,'numbered'),(87655,1,2,'o-cean'),(86737,1,2,'ocean'),(87650,1,2,'offset'),(88038,1,2,'one'),(86766,1,2,'open'),(86588,1,2,'opened'),(89281,1,2,'order'),(86726,1,2,'ordinary'),(86835,1,2,'original'),(89259,1,2,'outdoor'),(86618,1,2,'overnight'),(86736,1,2,'pacific'),(86569,1,2,'page'),(86591,1,2,'pages'),(86829,1,2,'paine'),(88580,1,2,'painting'),(86772,1,2,'paper'),(88053,1,2,'paper1'),(88286,1,2,'paperset'),(86660,1,2,'past'),(89285,1,2,'pattern'),(86810,1,2,'pavilion'),(88047,1,2,'pebble'),(88042,1,2,'pen'),(89265,1,2,'performance'),(86620,1,2,'period'),(89290,1,2,'photo'),(86549,1,2,'pinghsi'),(89263,1,2,'polyester'),(87657,1,2,'postcard'),(87638,1,2,'postcards'),(86621,1,2,'precipitation'),(86561,1,2,'preserving'),(88059,1,2,'printed'),(86751,1,2,'printing'),(86802,1,2,'private'),(86819,1,2,'prize'),(81727,1,2,'products'),(86628,1,2,'promote'),(86837,1,2,'property'),(86503,1,2,'published'),(89672,1,2,'purpose'),(89279,1,2,'quality'),(86742,1,2,'railway'),(86584,1,2,'real'),(86627,1,2,'reality'),(86601,1,2,'really'),(86836,1,2,'remains'),(86631,1,2,'repetition'),(86506,1,2,'reproduction'),(86574,1,2,'resulting'),(86811,1,2,'richmond'),(86745,1,2,'rift'),(86661,1,2,'right'),(86843,1,2,'rights'),(89673,1,2,'ring'),(86542,1,2,'road'),(88046,1,2,'rocky'),(88054,1,2,'roll'),(88287,1,2,'rolls'),(86709,1,2,'roomate'),(86538,1,2,'roommate'),(88878,1,2,'round'),(86729,1,2,'running'),(86550,1,2,'sandiaoling'),(86520,1,2,'saw'),(88037,1,2,'sealed'),(88057,1,2,'second'),(86764,1,2,'section'),(86504,1,2,'september'),(86643,1,2,'sequences'),(88581,1,2,'series'),(87637,1,2,'set'),(86539,1,2,'several'),(86765,1,2,'sewn'),(86801,1,2,'sheffield'),(86519,1,2,'shocked'),(86597,1,2,'show'),(86571,1,2,'showing'),(87642,1,2,'shui'),(86763,1,2,'signatures'),(87451,1,2,'significant'),(87654,1,2,'silver'),(86532,1,2,'since'),(89282,1,2,'size'),(86713,1,2,'sketch'),(87639,1,2,'sketches'),(89668,1,2,'slightly'),(88882,1,2,'sold'),(86822,1,2,'solo'),(86573,1,2,'space'),(89264,1,2,'spandex'),(86755,1,2,'special'),(89258,1,2,'spinning'),(86635,1,2,'spiritual'),(89255,1,2,'sport'),(86655,1,2,'spread'),(86630,1,2,'stacking'),(86646,1,2,'staggered'),(87653,1,2,'stamping'),(86530,1,2,'started'),(86606,1,2,'state'),(86559,1,2,'statement'),(86724,1,2,'station'),(86516,1,2,'stayed'),(88879,1,2,'stickermade'),(86613,1,2,'stimulation'),(86716,1,2,'stone'),(86728,1,2,'stop'),(86800,1,2,'street'),(89271,1,2,'stretch'),(86590,1,2,'strokes'),(86612,1,2,'strong'),(86633,1,2,'structure'),(89671,1,2,'sturdy'),(89280,1,2,'sublimation'),(89254,1,2,'summer'),(86738,1,2,'sunrise'),(88876,1,2,'t123456789'),(88063,1,2,'tain'),(86795,1,2,'taipei'),(86502,1,2,'taiwan'),(87646,1,2,'taiwan240g'),(88051,1,2,'taiwanese'),(88064,1,2,'tape'),(86639,1,2,'three'),(86847,1,2,'three-dimension'),(86844,1,2,'threedimensiona'),(86653,1,2,'throughout'),(86515,1,2,'time'),(89289,1,2,'top'),(86827,1,2,'torres'),(89277,1,2,'toxic'),(86547,1,2,'train'),(86499,1,2,'travel'),(86545,1,2,'traveled'),(86708,1,2,'traveler'),(86623,1,2,'trip'),(86585,1,2,'trying'),(86780,1,2,'uncoated'),(86662,1,2,'undertake'),(86611,1,2,'unexpected'),(86796,1,2,'university'),(86812,1,2,'usa'),(86814,1,2,'usarelated'),(86564,1,2,'use'),(86746,1,2,'valley'),(86706,1,2,'venezia'),(86501,1,2,'venice'),(86638,1,2,'virtual'),(86651,1,2,'visual'),(89293,1,2,'wang'),(88052,1,2,'washi'),(86710,1,2,'wave'),(88049,1,2,'waves'),(89270,1,2,'way'),(89266,1,2,'wear'),(86513,1,2,'weeks'),(86512,1,2,'went'),(86769,1,2,'white'),(89269,1,2,'wicking'),(88055,1,2,'wide'),(89675,1,2,'width'),(86616,1,2,'will'),(86522,1,2,'without'),(86781,1,2,'woodfree'),(88583,1,2,'www'),(86551,1,2,'yilan'),(86838,1,2,'ying'),(86848,1,2,'ying-chieh'),(86845,1,2,'yingchieh'),(89257,1,2,'yoga'),(86762,1,2,'yoshosu'),(86517,1,2,'youth'),(88060,1,2,'yuanpao'),(86776,1,2,'zipang'),(86777,1,2,'ジパング'),(87452,1,2,'トーメイあらじま'),(26403,1,2,'ㄌㄏㄌㄑㄏㄌ'),(86730,1,2,'一步又一步'),(87643,1,2,'七星潭'),(88045,1,2,'七星潭海灘'),(86556,1,2,'三貂嶺'),(86723,1,2,'三貂嶺車站'),(86684,1,2,'上一段旅行的回憶'),(88588,1,2,'九份陽明山冷水坑花蓮三芝淺水灣'),(86687,1,2,'交互推進'),(86694,1,2,'交錯的時空'),(86693,1,2,'以蒙太奇手法並置複雜'),(87541,1,2,'其頁面接續頁面的結構易於表述時'),(87545,1,2,'則提供了較為私密'),(86678,1,2,'創作之旅'),(86697,1,2,'創作載體之裝訂形式'),(86703,1,2,'劉穎捷'),(86702,1,2,'右頁承接未來'),(86681,1,2,'同時也讓創作者不斷接觸意料之外'),(87542,1,2,'呈現宛如記憶綿延的連續動態想像'),(86692,1,2,'呈現對於純粹繪畫過於複雜的時空'),(86667,1,2,'呈現時空的轉移'),(86696,1,2,'回憶的特質'),(86794,1,2,'國家圖書館'),(86834,1,2,'國立台灣圖書館雙和藝廊'),(86798,1,2,'國立臺北藝術大學圖書館'),(86808,1,2,'國際雙年展'),(86672,1,2,'在旅途中'),(87537,1,2,'在路上邊走邊畫'),(26402,1,2,'地球山水冊頁'),(86735,1,2,'太平洋日出'),(86739,1,2,'奮起湖'),(88587,1,2,'寫生地點'),(86700,1,2,'對於左翻書而言'),(86701,1,2,'左頁聯繫著過去'),(86721,1,2,'平溪線'),(86732,1,2,'幸福水泥'),(87544,1,2,'徒手翻頁的特質'),(86719,1,2,'從枋寮上車之後'),(86690,1,2,'意圖以心靈空間深度取代三度空間'),(86685,1,2,'成為下一段旅行的基底'),(86698,1,2,'成為貫穿整本書冊的視覺元素'),(87536,1,2,'手工縫製一本隨身畫冊'),(86731,1,2,'接近清水斷崖之中'),(86665,1,2,'於是選擇以書冊為創作載體'),(86712,1,2,'旅行寫生'),(86680,1,2,'旅行狀態本身'),(86669,1,2,'旅行的動機是為了成全以書冊為載'),(86677,1,2,'書冊呈現生命整體的綿延狀態'),(86699,1,2,'書冊被攤開的雙頁即是當下'),(87543,1,2,'書冊需要近觀'),(87538,1,2,'書冊體積小'),(86691,1,2,'書頁中的分格'),(86675,1,2,'書頁承載了片段時刻'),(86831,1,2,'書香醒園藝術空間'),(86720,1,2,'松山車站'),(87454,1,2,'波面剛古紙'),(86825,1,2,'清大藝術工坊'),(86557,1,2,'清水斷崖'),(87453,1,2,'炫光紙'),(86664,1,2,'熱衷於保存記憶的綿延狀態'),(89291,1,2,'玩瑜珈教室'),(86686,1,2,'現實與想像互相模仿'),(86679,1,2,'確實意圖讓外部旅程模仿內部想像'),(86705,1,2,'移動記'),(86824,1,2,'移動記之旅'),(87505,1,2,'移動記十一'),(87535,1,2,'移動記十二'),(87450,1,2,'移動記四'),(86725,1,2,'第411號列車'),(86820,1,2,'第四屆雪菲爾國際藝術家的書評選'),(86683,1,2,'經過長時間沈澱'),(86673,1,2,'翻開書冊'),(86676,1,2,'翻頁造成變化之流'),(87540,1,2,'能收取到繪畫者面對大自然時最感'),(86743,1,2,'花東縱谷'),(86821,1,2,'英國related'),(86833,1,2,'藝術家的書'),(86695,1,2,'表現夢境'),(88883,1,2,'規格數值1'),(86714,1,2,'親吻岩'),(87546,1,2,'親近人身體的感官體驗'),(86671,1,2,'讓真實生活模仿記憶的綿延'),(87539,1,2,'輕便易攜帶'),(86666,1,2,'透過書頁的翻頁特質'),(86688,1,2,'透過生長與堆疊'),(86670,1,2,'透過身體的真正移動'),(86674,1,2,'逐頁累積筆觸'),(86682,1,2,'這些意外的經歷並不會隔夜就消失'),(86668,1,2,'造成連續性的動態想像'),(86689,1,2,'重複與延伸的模式來結構畫面'),(86558,1,2,'阿里山'),(86741,1,2,'阿里山小火車'),(86717,1,2,'鵝鑾鼻'),(87072,1,3,'-'),(87723,1,3,'---------------'),(86962,1,3,'1'),(88112,1,3,'10'),(87692,1,3,'105'),(88634,1,3,'108'),(87685,1,3,'11'),(74521,1,3,'111'),(89349,1,3,'12'),(86873,1,3,'130'),(86908,1,3,'143'),(87689,1,3,'148'),(86902,1,3,'15'),(89713,1,3,'153'),(88930,1,3,'15mm'),(86881,1,3,'1875'),(86961,1,3,'2'),(86862,1,3,'20'),(88933,1,3,'200'),(86954,1,3,'20042014'),(86859,1,3,'2010'),(86949,1,3,'2012'),(86942,1,3,'20134th'),(86950,1,3,'2014'),(86928,1,3,'2015'),(86955,1,3,'2016'),(86938,1,3,'2017'),(86906,1,3,'21'),(87688,1,3,'240g'),(88110,1,3,'25'),(87012,1,3,'3'),(88121,1,3,'30'),(89718,1,3,'3d'),(87011,1,3,'4'),(88632,1,3,'45'),(88621,1,3,'45mm'),(89730,1,3,'4band'),(87705,1,3,'5'),(86871,1,3,'5000'),(88116,1,3,'66'),(88636,1,3,'7'),(89345,1,3,'88'),(88637,1,3,'9'),(88633,1,3,'90'),(89733,1,3,'925'),(86911,1,3,'9789574173310'),(89433,1,3,'a'),(86877,1,3,'art'),(86944,1,3,'artist'),(86919,1,3,'arts'),(88932,1,3,'b'),(86900,1,3,'back'),(86920,1,3,'bank'),(87882,1,3,'beach'),(86894,1,3,'binding'),(86888,1,3,'black'),(86946,1,3,'book'),(86930,1,3,'books'),(86936,1,3,'ca'),(87691,1,3,'card'),(87687,1,3,'cean'),(86914,1,3,'central'),(87699,1,3,'chieh'),(87881,1,3,'chihsingtan'),(87681,1,3,'ching'),(87721,1,3,'ching-shui'),(87718,1,3,'chingshui'),(88099,1,3,'chishingtan'),(86868,1,3,'chyaulun'),(88102,1,3,'clear'),(87683,1,3,'cliff'),(86903,1,3,'cm'),(89716,1,3,'coast'),(86931,1,3,'codex'),(86912,1,3,'collection'),(86925,1,3,'collectors'),(86864,1,3,'color'),(88630,1,3,'com'),(86893,1,3,'coptic'),(86887,1,3,'cover'),(86933,1,3,'craneway'),(89724,1,3,'daily'),(88937,1,3,'december'),(86952,1,3,'del'),(88938,1,3,'dergi'),(89717,1,3,'design'),(88093,1,3,'designed'),(89721,1,3,'differentintegr'),(86865,1,3,'digital'),(88095,1,3,'drawing'),(89715,1,3,'eastern'),(86861,1,3,'edition'),(86883,1,3,'egyptian'),(86872,1,3,'electrolnk'),(88629,1,3,'etsy'),(86941,1,3,'exhibition'),(86895,1,3,'exposed'),(89348,1,3,'fabric'),(88104,1,3,'face'),(86927,1,3,'fair'),(86876,1,3,'fine'),(86860,1,3,'first'),(86899,1,3,'flat'),(87695,1,3,'foil'),(89722,1,3,'formed'),(89352,1,3,'frankie'),(86863,1,3,'full'),(87709,1,3,'g'),(86884,1,3,'gold'),(86940,1,3,'group'),(86874,1,3,'gsm'),(86907,1,3,'h'),(89719,1,3,'handmade'),(86898,1,3,'hole'),(87694,1,3,'hot'),(86869,1,3,'hp'),(88627,1,3,'http'),(87883,1,3,'hualien'),(86850,1,3,'i'),(86870,1,3,'indigo'),(88098,1,3,'ink'),(86879,1,3,'inner'),(89714,1,3,'inspired'),(86943,1,3,'international'),(86910,1,3,'isbn'),(87690,1,3,'ivory'),(88336,1,3,'japanese'),(88122,1,3,'july'),(88117,1,3,'june'),(86882,1,3,'kg'),(88092,1,3,'kind'),(87710,1,3,'l'),(88622,1,3,'landscape'),(86897,1,3,'larger'),(86915,1,3,'library'),(89344,1,3,'light'),(88631,1,3,'listing'),(87885,1,3,'liu'),(86929,1,3,'liuyingchieh'),(88113,1,3,'long'),(88114,1,3,'loop'),(87706,1,3,'m'),(88120,1,3,'made'),(88623,1,3,'masking'),(86886,1,3,'metallic'),(87693,1,3,'mm'),(89732,1,3,'mmsterling'),(89346,1,3,'moisture'),(89434,1,3,'n'),(86913,1,3,'national'),(88089,1,3,'new'),(88934,1,3,'numbered'),(87686,1,3,'o'),(87722,1,3,'o-cean'),(87719,1,3,'ocean'),(86866,1,3,'offset'),(88091,1,3,'one'),(88094,1,3,'original'),(88105,1,3,'pacific'),(86880,1,3,'page'),(86909,1,3,'pages'),(86953,1,3,'paine'),(88625,1,3,'painting'),(86878,1,3,'paper'),(88108,1,3,'paper1'),(88337,1,3,'paperset'),(86934,1,3,'pavilion'),(88101,1,3,'pebble'),(88097,1,3,'pen'),(88118,1,3,'printed'),(86867,1,3,'printing'),(86924,1,3,'private'),(86947,1,3,'prize'),(86858,1,3,'published'),(89726,1,3,'purpose'),(86926,1,3,'related'),(86857,1,3,'reproduction'),(86935,1,3,'richmond'),(89727,1,3,'ring'),(88100,1,3,'rocky'),(88109,1,3,'roll'),(88338,1,3,'rolls'),(88935,1,3,'round'),(86945,1,3,'s'),(88090,1,3,'sealed'),(88115,1,3,'second'),(86891,1,3,'section'),(88635,1,3,'september'),(88626,1,3,'series'),(86892,1,3,'sewn'),(86922,1,3,'sheffield'),(87682,1,3,'shui'),(87458,1,3,'significant'),(87697,1,3,'silver'),(89728,1,3,'size'),(87680,1,3,'sketch'),(87880,1,3,'sketches'),(89720,1,3,'slightly'),(88939,1,3,'sold'),(86948,1,3,'solo'),(86896,1,3,'spine'),(88096,1,3,'spread'),(87696,1,3,'stamping'),(88936,1,3,'stickermade'),(86921,1,3,'street'),(89351,1,3,'stretch'),(89723,1,3,'sturdy'),(88931,1,3,'t123456789'),(88123,1,3,'tain'),(86916,1,3,'taipei'),(86917,1,3,'taiwan'),(87884,1,3,'taiwan240g'),(88106,1,3,'taiwanese'),(87684,1,3,'taiwanfrom'),(88624,1,3,'tape'),(86951,1,3,'torres'),(87459,1,3,'travel'),(87711,1,3,'u'),(86923,1,3,'uk'),(86889,1,3,'uncoated'),(86918,1,3,'university'),(89729,1,3,'us'),(86937,1,3,'usa'),(89725,1,3,'use'),(86932,1,3,'v'),(86851,1,3,'venezia'),(86939,1,3,'vi'),(86904,1,3,'w'),(88107,1,3,'washi'),(88103,1,3,'waves'),(89350,1,3,'way'),(86875,1,3,'white'),(89347,1,3,'wicking'),(88111,1,3,'wide'),(89731,1,3,'width'),(86890,1,3,'woodfree'),(88628,1,3,'www'),(86905,1,3,'x'),(89449,1,3,'xl'),(89448,1,3,'xs'),(87698,1,3,'ying'),(87724,1,3,'ying-chieh'),(87720,1,3,'yingchieh'),(86901,1,3,'yoshosu'),(88119,1,3,'yuanpao'),(86885,1,3,'zipang'),(87466,1,3,'あ'),(87468,1,3,'じ'),(87469,1,3,'ま'),(87467,1,3,'ら'),(87465,1,3,'イ'),(86991,1,3,'グ'),(86988,1,3,'ジ'),(87462,1,3,'ト'),(86989,1,3,'パ'),(87464,1,3,'メ'),(86990,1,3,'ン'),(87463,1,3,'ー'),(87509,1,3,'一'),(87877,1,3,'七'),(88656,1,3,'三'),(89396,1,3,'不'),(87058,1,3,'个'),(87071,1,3,'中'),(87026,1,3,'之'),(88651,1,3,'九'),(89401,1,3,'也'),(87015,1,3,'书'),(87549,1,3,'二'),(86960,1,3,'于'),(87712,1,3,'产'),(87005,1,3,'亭'),(89439,1,3,'以'),(88652,1,3,'份'),(87045,1,3,'会'),(86977,1,3,'伦'),(89441,1,3,'伴'),(86971,1,3,'位'),(87717,1,3,'作'),(89395,1,3,'你'),(87024,1,3,'使'),(89430,1,3,'供'),(86976,1,3,'侨'),(89393,1,3,'保'),(87726,1,3,'信'),(88943,1,3,'值'),(89442,1,3,'做'),(87471,1,3,'光'),(88660,1,3,'內'),(86968,1,3,'全'),(87008,1,3,'公'),(87033,1,3,'典'),(86983,1,3,'内'),(86959,1,3,'册'),(89398,1,3,'冒'),(89417,1,3,'写'),(88654,1,3,'冷'),(86964,1,3,'出'),(87009,1,3,'分'),(86966,1,3,'初'),(86974,1,3,'刷'),(88668,1,3,'前'),(87474,1,3,'剛'),(89373,1,3,'力'),(87031,1,3,'加'),(86853,1,3,'动'),(87460,1,3,'動'),(87041,1,3,'北'),(89416,1,3,'区'),(87508,1,3,'十'),(89380,1,3,'华'),(88663,1,3,'博'),(87703,1,3,'卡'),(87004,1,3,'卢'),(86973,1,3,'印'),(88638,1,3,'卷'),(86978,1,3,'厚'),(89370,1,3,'原'),(86986,1,3,'及'),(87047,1,3,'双'),(87025,1,3,'叠'),(87023,1,3,'口'),(87475,1,3,'古'),(89438,1,3,'可'),(86855,1,3,'台'),(89372,1,3,'向'),(89353,1,3,'吸'),(89403,1,3,'吹'),(87069,1,3,'和'),(89375,1,3,'品'),(82079,1,3,'商'),(87050,1,3,'四'),(87067,1,3,'园'),(87035,1,3,'国'),(87037,1,3,'图'),(89420,1,3,'在'),(87713,1,3,'地'),(89390,1,3,'均'),(87062,1,3,'坊'),(88655,1,3,'坑'),(86985,1,3,'埃'),(89381,1,3,'墨'),(87030,1,3,'外'),(87020,1,3,'大'),(89435,1,3,'好'),(87043,1,3,'学'),(89392,1,3,'宜'),(89382,1,3,'室'),(88662,1,3,'宮'),(87036,1,3,'家'),(87007,1,3,'宽'),(88648,1,3,'寫'),(86992,1,3,'封'),(87054,1,3,'尔'),(88640,1,3,'尾'),(87051,1,3,'届'),(87044,1,3,'展'),(87550,1,3,'山'),(87678,1,3,'崖'),(87061,1,3,'工'),(89406,1,3,'布'),(88128,1,3,'带'),(89387,1,3,'常'),(86972,1,3,'平'),(86963,1,3,'年'),(87017,1,3,'并'),(89437,1,3,'幸'),(89444,1,3,'度'),(87070,1,3,'廊'),(87715,1,3,'式'),(89357,1,3,'弹'),(86969,1,3,'彩'),(88646,1,3,'循'),(89413,1,3,'德'),(89402,1,3,'怕'),(89358,1,3,'性'),(89397,1,3,'感'),(89415,1,3,'憩'),(89735,1,3,'戒'),(89383,1,3,'户'),(82078,1,3,'所'),(87716,1,3,'手'),(89394,1,3,'护'),(89447,1,3,'拿'),(89736,1,3,'指'),(89355,1,3,'排'),(88643,1,3,'接'),(89429,1,3,'提'),(88661,1,3,'故'),(89432,1,3,'教'),(86970,1,3,'数'),(88942,1,3,'數'),(89407,1,3,'料'),(87700,1,3,'断'),(87063,1,3,'新'),(87677,1,3,'斷'),(87032,1,3,'方'),(87059,1,3,'旅'),(89376,1,3,'无'),(89386,1,3,'日'),(89379,1,3,'昇'),(87725,1,3,'明'),(87878,1,3,'星'),(89419,1,3,'是'),(87000,1,3,'普'),(88666,1,3,'書'),(87018,1,3,'有'),(86967,1,3,'本'),(86981,1,3,'术'),(89359,1,3,'机'),(89362,1,3,'材'),(89409,1,3,'来'),(86998,1,3,'林'),(88941,1,3,'格'),(89408,1,3,'案'),(88667,1,3,'桌'),(89423,1,3,'步'),(89377,1,3,'毒'),(87676,1,3,'水'),(89412,1,3,'汇'),(89356,1,3,'汗'),(87473,1,3,'波'),(87511,1,3,'洋'),(87022,1,3,'洞'),(87510,1,3,'海'),(88658,1,3,'淺'),(88335,1,3,'淼'),(87060,1,3,'清'),(89414,1,3,'游'),(89851,1,3,'湖'),(86856,1,3,'湾'),(89354,1,3,'湿'),(89399,1,3,'满'),(88124,1,3,'滩'),(87879,1,3,'潭'),(88339,1,3,'灘'),(88659,1,3,'灣'),(87470,1,3,'炫'),(89418,1,3,'点'),(87707,1,3,'烫'),(89378,1,3,'热'),(88641,1,3,'無'),(89428,1,3,'照'),(87679,1,3,'燙'),(87727,1,3,'片'),(86965,1,3,'版'),(87702,1,3,'牙'),(88664,1,3,'物'),(87001,1,3,'特'),(89405,1,3,'独'),(89431,1,3,'玩'),(89425,1,3,'珈'),(89846,1,3,'琺'),(89424,1,3,'瑜'),(89847,1,3,'瑯'),(87006,1,3,'璇'),(88647,1,3,'環'),(88649,1,3,'生'),(86958,1,3,'画'),(87021,1,3,'的'),(89389,1,3,'着'),(86979,1,3,'磅'),(89426,1,3,'示'),(86999,1,3,'科'),(86852,1,3,'移'),(87068,1,3,'空'),(89388,1,3,'穿'),(87029,1,3,'窄'),(87039,1,3,'立'),(87064,1,3,'竹'),(87049,1,3,'第'),(87704,1,3,'精'),(89850,1,3,'紅'),(87472,1,3,'紙'),(89852,1,3,'綠'),(88642,1,3,'縫'),(89366,1,3,'纤'),(89371,1,3,'纱'),(86982,1,3,'纸'),(89411,1,3,'绘'),(89367,1,3,'维'),(86980,1,3,'美'),(86975,1,3,'者'),(87048,1,3,'联'),(89364,1,3,'聚'),(87016,1,3,'背'),(88127,1,3,'胶'),(89360,1,3,'能'),(87551,1,3,'脈'),(89410,1,3,'自'),(87040,1,3,'臺'),(86996,1,3,'色'),(87042,1,3,'艺'),(88657,1,3,'芝'),(88125,1,3,'花'),(89421,1,3,'苏'),(87057,1,3,'英'),(89427,1,3,'范'),(89436,1,3,'荣'),(88126,1,3,'莲'),(87053,1,3,'菲'),(88340,1,3,'蓮'),(89848,1,3,'藍'),(87034,1,3,'藏'),(89849,1,3,'血'),(89385,1,3,'行'),(86994,1,3,'衬'),(87002,1,3,'装'),(89361,1,3,'裤'),(87013,1,3,'裸'),(86957,1,3,'製'),(86956,1,3,'複'),(88940,1,3,'規'),(87461,1,3,'記'),(89446,1,3,'计'),(87003,1,3,'订'),(86854,1,3,'记'),(89445,1,3,'设'),(87055,1,3,'评'),(87701,1,3,'象'),(89363,1,3,'质'),(89422,1,3,'路'),(89400,1,3,'身'),(88644,1,3,'軌'),(89368,1,3,'轻'),(87019,1,3,'较'),(89384,1,3,'运'),(89391,1,3,'适'),(87056,1,3,'选'),(87714,1,3,'造'),(86997,1,3,'道'),(89365,1,3,'酯'),(87066,1,3,'醒'),(89369,1,3,'量'),(86987,1,3,'金'),(89734,1,3,'銀'),(87708,1,3,'银'),(87010,1,3,'长'),(87027,1,3,'间'),(87046,1,3,'际'),(88645,1,3,'限'),(88665,1,3,'院'),(89440,1,3,'陪'),(88653,1,3,'陽'),(87028,1,3,'隔'),(89443,1,3,'难'),(87052,1,3,'雪'),(87014,1,3,'露'),(86993,1,3,'面'),(86984,1,3,'页'),(89404,1,3,'风'),(87038,1,3,'馆'),(88639,1,3,'首'),(87065,1,3,'香'),(89374,1,3,'高'),(86995,1,3,'黑'),(88650,1,3,'點'),(87420,1,4,'-feb'),(87763,1,4,'105'),(88731,1,4,'108'),(74535,1,4,'111'),(87341,1,4,'130'),(87357,1,4,'143'),(87356,1,4,'148'),(89781,1,4,'153'),(89042,1,4,'15mm'),(87347,1,4,'1875'),(89044,1,4,'200'),(87085,1,4,'2002'),(87278,1,4,'2003'),(87404,1,4,'20042014'),(87079,1,4,'2010'),(87397,1,4,'2012'),(87391,1,4,'20134th'),(87400,1,4,'2014'),(87379,1,4,'2015'),(87406,1,4,'2016'),(87387,1,4,'2017'),(87301,1,4,'411'),(88718,1,4,'45mm'),(89793,1,4,'4band'),(87327,1,4,'5000'),(88728,1,4,'57177974山水手卷卷首卷'),(89796,1,4,'925'),(87363,1,4,'9789574173310'),(87163,1,4,'accumulated'),(87129,1,4,'alishan'),(87181,1,4,'also'),(89522,1,4,'anti'),(87120,1,4,'around'),(87345,1,4,'art'),(87335,1,4,'artist'),(87423,1,4,'artists'),(87371,1,4,'arts'),(87228,1,4,'artwork'),(87332,1,4,'back'),(87373,1,4,'bank'),(87199,1,4,'base'),(87095,1,4,'bathroom'),(87759,1,4,'beach'),(87198,1,4,'become'),(87170,1,4,'becoming'),(87281,1,4,'bed'),(87103,1,4,'bedroom'),(87107,1,4,'beginning'),(87223,1,4,'binding'),(87353,1,4,'black'),(87110,1,4,'blonde'),(87102,1,4,'body'),(87074,1,4,'book'),(87139,1,4,'books'),(87334,1,4,'bound'),(87415,1,4,'buyer'),(89534,1,4,'canadadesigned'),(87762,1,4,'card'),(87140,1,4,'carrier'),(87166,1,4,'carry'),(87754,1,4,'cean'),(87366,1,4,'central'),(87142,1,4,'characteristic'),(87413,1,4,'chieh'),(87758,1,4,'chihsingtan'),(87755,1,4,'ching'),(87770,1,4,'ching-shui'),(87127,1,4,'chingshui'),(88169,1,4,'chishingtan'),(88173,1,4,'clear'),(87128,1,4,'cliff'),(89538,1,4,'cliffs'),(89784,1,4,'coast'),(89537,1,4,'coastal'),(87381,1,4,'codex'),(87364,1,4,'collection'),(87377,1,4,'collectorsrelat'),(87322,1,4,'color'),(88727,1,4,'com'),(87117,1,4,'comics'),(87219,1,4,'complex'),(87184,1,4,'contact'),(87149,1,4,'continuous'),(87328,1,4,'coptic'),(87333,1,4,'cover'),(87383,1,4,'craneway'),(87168,1,4,'creates'),(87155,1,4,'creation'),(87141,1,4,'creations'),(87173,1,4,'creative'),(87183,1,4,'creator'),(87098,1,4,'curtain'),(89512,1,4,'daily'),(89506,1,4,'dancing'),(89047,1,4,'december'),(87402,1,4,'del'),(87210,1,4,'depth'),(89048,1,4,'dergi'),(89785,1,4,'design'),(88165,1,4,'designed'),(87115,1,4,'diaries'),(89788,1,4,'differentintegr'),(87323,1,4,'digital'),(87214,1,4,'dimensional'),(87191,1,4,'disappear'),(87215,1,4,'distance'),(87097,1,4,'door'),(87100,1,4,'dorm'),(87105,1,4,'draw'),(88166,1,4,'drawing'),(87082,1,4,'drawn'),(87222,1,4,'dreams'),(87136,1,4,'duration'),(87150,1,4,'dynamic'),(87318,1,4,'east'),(89783,1,4,'eastern'),(89524,1,4,'eco'),(89546,1,4,'eco-friendly'),(89544,1,4,'ecofriendly'),(87359,1,4,'edition'),(87348,1,4,'egyptian'),(87226,1,4,'elements'),(87292,1,4,'eluanbi'),(87172,1,4,'entire'),(87416,1,4,'entitled'),(88726,1,4,'etsy'),(87390,1,4,'exhibition'),(87188,1,4,'experience'),(87221,1,4,'express'),(87206,1,4,'extension'),(87177,1,4,'external'),(89517,1,4,'fabric'),(88175,1,4,'face'),(87378,1,4,'fair'),(87122,1,4,'fangliao'),(87084,1,4,'feb'),(87099,1,4,'female'),(87314,1,4,'fenqihu'),(87344,1,4,'fine'),(87088,1,4,'first'),(87331,1,4,'flat'),(87144,1,4,'flipping'),(87169,1,4,'flux'),(87766,1,4,'foil'),(89789,1,4,'formed'),(87224,1,4,'forms'),(87167,1,4,'fragments'),(87216,1,4,'frames'),(89542,1,4,'frankie'),(89525,1,4,'friendly'),(87153,1,4,'fulfill'),(87321,1,4,'full'),(87237,1,4,'future'),(87109,1,4,'giudecca'),(87349,1,4,'gold'),(87285,1,4,'gondola移動記'),(87389,1,4,'group'),(87203,1,4,'growth'),(87342,1,4,'gsm'),(87111,1,4,'hair'),(87081,1,4,'hand'),(89786,1,4,'handmade'),(87307,1,4,'heren'),(89528,1,4,'high'),(89510,1,4,'hiking'),(87330,1,4,'hole'),(87092,1,4,'hostel'),(87765,1,4,'hot'),(87179,1,4,'however'),(88724,1,4,'http'),(87126,1,4,'hualien'),(87154,1,4,'image'),(87151,1,4,'imagination'),(87161,1,4,'imitate'),(87189,1,4,'incidents'),(87326,1,4,'indigo'),(88168,1,4,'ink'),(88720,1,4,'inner'),(89782,1,4,'inspired'),(87211,1,4,'instead'),(87208,1,4,'intend'),(87176,1,4,'intended'),(87134,1,4,'interested'),(87178,1,4,'internal'),(87392,1,4,'international'),(87362,1,4,'isbn'),(87761,1,4,'ivory'),(87083,1,4,'jan'),(88406,1,4,'japanese'),(87174,1,4,'journey'),(88187,1,4,'july'),(88183,1,4,'june'),(88164,1,4,'kind'),(87289,1,4,'kissing'),(88719,1,4,'landscape'),(87196,1,4,'last'),(87232,1,4,'left'),(89548,1,4,'leggings'),(87182,1,4,'lets'),(87367,1,4,'library'),(87160,1,4,'life'),(89511,1,4,'light'),(87358,1,4,'limited'),(87296,1,4,'line'),(87233,1,4,'link'),(87361,1,4,'listing'),(87324,1,4,'lithography'),(87414,1,4,'liu'),(87380,1,4,'liuyingchieh'),(87193,1,4,'long'),(88181,1,4,'loop'),(88186,1,4,'made'),(89533,1,4,'manufactured'),(88721,1,4,'masking'),(87108,1,4,'memories'),(87137,1,4,'memory'),(87352,1,4,'metallic'),(89523,1,4,'microbial'),(89795,1,4,'mmsterling'),(87156,1,4,'mode'),(89518,1,4,'moisture'),(87230,1,4,'moment'),(87218,1,4,'montage'),(87114,1,4,'monthes'),(87308,1,4,'moonrise'),(87152,1,4,'motivation'),(89536,1,4,'mountain'),(87146,1,4,'movement'),(87118,1,4,'movies'),(87157,1,4,'moving'),(87101,1,4,'naked'),(87365,1,4,'national'),(88161,1,4,'new'),(87200,1,4,'next'),(89526,1,4,'non'),(89547,1,4,'non-toxic'),(89545,1,4,'nontoxic'),(87231,1,4,'now'),(87360,1,4,'numbered'),(87769,1,4,'o-cean'),(87311,1,4,'ocean'),(87764,1,4,'offset'),(88163,1,4,'one'),(87340,1,4,'open'),(87162,1,4,'opened'),(89531,1,4,'order'),(87300,1,4,'ordinary'),(87409,1,4,'original'),(89509,1,4,'outdoor'),(87192,1,4,'overnight'),(87310,1,4,'pacific'),(87143,1,4,'page'),(87165,1,4,'pages'),(87403,1,4,'paine'),(88722,1,4,'painting'),(87346,1,4,'paper'),(88178,1,4,'paper1'),(88407,1,4,'paperset'),(87234,1,4,'past'),(89535,1,4,'pattern'),(87384,1,4,'pavilion'),(88172,1,4,'pebble'),(88167,1,4,'pen'),(89515,1,4,'performance'),(87194,1,4,'period'),(89540,1,4,'photo'),(87123,1,4,'pinghsi'),(89513,1,4,'polyester'),(87771,1,4,'postcard'),(87752,1,4,'postcards'),(87195,1,4,'precipitation'),(87135,1,4,'preserving'),(88184,1,4,'printed'),(87325,1,4,'printing'),(87376,1,4,'private'),(87393,1,4,'prize'),(82304,1,4,'products'),(87202,1,4,'promote'),(87411,1,4,'property'),(87077,1,4,'published'),(89791,1,4,'purpose'),(89529,1,4,'quality'),(87316,1,4,'railway'),(87158,1,4,'real'),(87201,1,4,'reality'),(87175,1,4,'really'),(87410,1,4,'remains'),(87205,1,4,'repetition'),(87080,1,4,'reproduction'),(87148,1,4,'resulting'),(87385,1,4,'richmond'),(87319,1,4,'rift'),(87235,1,4,'right'),(87417,1,4,'rights'),(89792,1,4,'ring'),(87116,1,4,'road'),(88171,1,4,'rocky'),(88179,1,4,'roll'),(88408,1,4,'rolls'),(87283,1,4,'roomate'),(87112,1,4,'roommate'),(89045,1,4,'round'),(87303,1,4,'running'),(87124,1,4,'sandiaoling'),(87094,1,4,'saw'),(88162,1,4,'sealed'),(88182,1,4,'second'),(87338,1,4,'section'),(87078,1,4,'september'),(87217,1,4,'sequences'),(88723,1,4,'series'),(87751,1,4,'set'),(87113,1,4,'several'),(87339,1,4,'sewn'),(87375,1,4,'sheffield'),(87093,1,4,'shocked'),(87171,1,4,'show'),(87145,1,4,'showing'),(87756,1,4,'shui'),(87337,1,4,'signatures'),(87485,1,4,'significant'),(87768,1,4,'silver'),(87106,1,4,'since'),(89532,1,4,'size'),(87287,1,4,'sketch'),(87753,1,4,'sketches'),(89787,1,4,'slightly'),(89049,1,4,'sold'),(87396,1,4,'solo'),(87147,1,4,'space'),(89514,1,4,'spandex'),(87329,1,4,'special'),(89508,1,4,'spinning'),(87209,1,4,'spiritual'),(89505,1,4,'sport'),(87229,1,4,'spread'),(87204,1,4,'stacking'),(87220,1,4,'staggered'),(87767,1,4,'stamping'),(87104,1,4,'started'),(87180,1,4,'state'),(87133,1,4,'statement'),(87298,1,4,'station'),(87090,1,4,'stayed'),(89046,1,4,'stickermade'),(87187,1,4,'stimulation'),(87290,1,4,'stone'),(87302,1,4,'stop'),(87374,1,4,'street'),(89521,1,4,'stretch'),(87164,1,4,'strokes'),(87186,1,4,'strong'),(87207,1,4,'structure'),(89790,1,4,'sturdy'),(89530,1,4,'sublimation'),(89504,1,4,'summer'),(87312,1,4,'sunrise'),(89043,1,4,'t123456789'),(88188,1,4,'tain'),(87369,1,4,'taipei'),(87076,1,4,'taiwan'),(87760,1,4,'taiwan240g'),(88176,1,4,'taiwanese'),(88189,1,4,'tape'),(87213,1,4,'three'),(87421,1,4,'three-dimension'),(87418,1,4,'threedimensiona'),(87227,1,4,'throughout'),(87089,1,4,'time'),(89539,1,4,'top'),(87401,1,4,'torres'),(89527,1,4,'toxic'),(87121,1,4,'train'),(87073,1,4,'travel'),(87119,1,4,'traveled'),(87282,1,4,'traveler'),(87197,1,4,'trip'),(87159,1,4,'trying'),(87354,1,4,'uncoated'),(87236,1,4,'undertake'),(87185,1,4,'unexpected'),(87370,1,4,'university'),(87386,1,4,'usa'),(87388,1,4,'usarelated'),(87138,1,4,'use'),(87320,1,4,'valley'),(87280,1,4,'venezia'),(87075,1,4,'venice'),(87212,1,4,'virtual'),(87225,1,4,'visual'),(89543,1,4,'wang'),(88177,1,4,'washi'),(87284,1,4,'wave'),(88174,1,4,'waves'),(89520,1,4,'way'),(89516,1,4,'wear'),(87087,1,4,'weeks'),(87086,1,4,'went'),(87343,1,4,'white'),(89519,1,4,'wicking'),(88180,1,4,'wide'),(89794,1,4,'width'),(87190,1,4,'will'),(87096,1,4,'without'),(87355,1,4,'woodfree'),(88725,1,4,'www'),(87125,1,4,'yilan'),(87412,1,4,'ying'),(87422,1,4,'ying-chieh'),(87419,1,4,'yingchieh'),(89507,1,4,'yoga'),(87336,1,4,'yoshosu'),(87091,1,4,'youth'),(88185,1,4,'yuanpao'),(87350,1,4,'zipang'),(89861,1,4,'イエロー'),(87487,1,4,'キュリアス'),(87489,1,4,'コンケラーコンツァ'),(89859,1,4,'シーブルー'),(87351,1,4,'ジパング'),(87486,1,4,'トーメイあらじま'),(87488,1,4,'メタル'),(89862,1,4,'ライトグリーン'),(89860,1,4,'レッド'),(66511,1,4,'ㄌㄏㄌㄑㄏㄌ'),(87304,1,4,'一步又一步'),(87757,1,4,'七星潭'),(88170,1,4,'七星潭海灘'),(87130,1,4,'三貂嶺'),(87297,1,4,'三貂嶺車站'),(87258,1,4,'上一段旅行的回憶'),(88730,1,4,'九份陽明山冷水坑花蓮三芝淺水灣'),(87261,1,4,'交互推進'),(87268,1,4,'交錯的時空'),(87267,1,4,'以蒙太奇手法並置複雜'),(87252,1,4,'創作之旅'),(87271,1,4,'創作載體之裝訂形式'),(87277,1,4,'劉穎捷'),(87276,1,4,'右頁承接未來'),(87255,1,4,'同時也讓創作者不斷接觸意料之外'),(87266,1,4,'呈現對於純粹繪畫過於複雜的時空'),(87241,1,4,'呈現時空的轉移'),(87270,1,4,'回憶的特質'),(87368,1,4,'國家圖書館'),(87408,1,4,'國立台灣圖書館雙和藝廊'),(87372,1,4,'國立臺北藝術大學圖書館'),(87382,1,4,'國際雙年展'),(87246,1,4,'在旅途中'),(66510,1,4,'地球山水冊頁'),(87309,1,4,'太平洋日出'),(87313,1,4,'奮起湖'),(88729,1,4,'寫生地點'),(87274,1,4,'對於左翻書而言'),(87275,1,4,'左頁聯繫著過去'),(87295,1,4,'平溪線'),(87306,1,4,'幸福水泥'),(87293,1,4,'從枋寮上車之後'),(87264,1,4,'意圖以心靈空間深度取代三度空間'),(87259,1,4,'成為下一段旅行的基底'),(87272,1,4,'成為貫穿整本書冊的視覺元素'),(87305,1,4,'接近清水斷崖之中'),(87239,1,4,'於是選擇以書冊為創作載體'),(87286,1,4,'旅行寫生'),(87254,1,4,'旅行狀態本身'),(87243,1,4,'旅行的動機是為了成全以書冊為載'),(87251,1,4,'書冊呈現生命整體的綿延狀態'),(87273,1,4,'書冊被攤開的雙頁即是當下'),(87265,1,4,'書頁中的分格'),(87249,1,4,'書頁承載了片段時刻'),(87405,1,4,'書香醒園藝術空間'),(87294,1,4,'松山車站'),(54518,1,4,'波面剛古紙'),(87399,1,4,'清大藝術工坊'),(89502,1,4,'清水断崖'),(87131,1,4,'清水斷崖'),(54517,1,4,'炫光紙'),(87238,1,4,'熱衷於保存記憶的綿延狀態'),(89541,1,4,'玩瑜珈教室'),(87260,1,4,'現實與想像互相模仿'),(87253,1,4,'確實意圖讓外部旅程模仿內部想像'),(87279,1,4,'移動記'),(87398,1,4,'移動記之旅'),(87520,1,4,'移動記十一'),(87561,1,4,'移動記十二'),(87484,1,4,'移動記四'),(87299,1,4,'第411號列車'),(87394,1,4,'第四屆雪菲爾國際藝術家的書評選'),(89503,1,4,'箔押し'),(87257,1,4,'經過長時間沈澱'),(87247,1,4,'翻開書冊'),(87250,1,4,'翻頁造成變化之流'),(87317,1,4,'花東縱谷'),(87395,1,4,'英國related'),(87407,1,4,'藝術家的書'),(87269,1,4,'表現夢境'),(89050,1,4,'規格數值1'),(87288,1,4,'親吻岩'),(87245,1,4,'讓真實生活模仿記憶的綿延'),(87240,1,4,'透過書頁的翻頁特質'),(87262,1,4,'透過生長與堆疊'),(87244,1,4,'透過身體的真正移動'),(87248,1,4,'逐頁累積筆觸'),(87256,1,4,'這些意外的經歷並不會隔夜就消失'),(87242,1,4,'造成連續性的動態想像'),(87263,1,4,'重複與延伸的模式來結構畫面'),(87132,1,4,'阿里山'),(87315,1,4,'阿里山小火車'),(87291,1,4,'鵝鑾鼻');
/*!40000 ALTER TABLE `ps_search_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_shop`
--

DROP TABLE IF EXISTS `ps_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_shop` (
  `id_shop` int(11) NOT NULL AUTO_INCREMENT,
  `id_shop_group` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `id_category` int(11) NOT NULL,
  `theme_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_shop`),
  KEY `IDX_CBDFBB9EF5C9E40` (`id_shop_group`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_shop`
--

LOCK TABLES `ps_shop` WRITE;
/*!40000 ALTER TABLE `ps_shop` DISABLE KEYS */;
INSERT INTO `ps_shop` VALUES (1,1,'My TekapoCart',2,'simplicity',1,0),(2,1,'shop 2',2,'simplicity',1,0),(3,1,'shop 3',2,'simplicity',1,0),(4,1,'shop 4',2,'simplicity',1,0);
/*!40000 ALTER TABLE `ps_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_shop_group`
--

DROP TABLE IF EXISTS `ps_shop_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_shop_group` (
  `id_shop_group` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `share_customer` tinyint(1) NOT NULL,
  `share_order` tinyint(1) NOT NULL,
  `share_stock` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_shop_group`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_shop_group`
--

LOCK TABLES `ps_shop_group` WRITE;
/*!40000 ALTER TABLE `ps_shop_group` DISABLE KEYS */;
INSERT INTO `ps_shop_group` VALUES (1,'Default',0,0,0,1,0);
/*!40000 ALTER TABLE `ps_shop_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_shop_url`
--

DROP TABLE IF EXISTS `ps_shop_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_shop_url` (
  `id_shop_url` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_shop` int(11) unsigned NOT NULL,
  `domain` varchar(150) NOT NULL,
  `domain_ssl` varchar(150) NOT NULL,
  `physical_uri` varchar(64) NOT NULL,
  `virtual_uri` varchar(64) NOT NULL,
  `main` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_shop_url`),
  UNIQUE KEY `full_shop_url` (`domain`,`physical_uri`,`virtual_uri`),
  UNIQUE KEY `full_shop_url_ssl` (`domain_ssl`,`physical_uri`,`virtual_uri`),
  KEY `id_shop` (`id_shop`,`main`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_shop_url`
--

LOCK TABLES `ps_shop_url` WRITE;
/*!40000 ALTER TABLE `ps_shop_url` DISABLE KEYS */;
INSERT INTO `ps_shop_url` VALUES (1,1,'test.tekapo.cart','test.tekapo.cart','/','',1,1),(2,2,'shop2.presta.shop','shop2.presta.shop','/','',1,1),(3,3,'shop3.presta.shop','shop3.presta.shop','/','',1,1),(4,4,'shop4.presta.shop','shop4.presta.shop','/','',1,1);
/*!40000 ALTER TABLE `ps_shop_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_smarty_cache`
--

DROP TABLE IF EXISTS `ps_smarty_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smarty_cache` (
  `id_smarty_cache` char(40) NOT NULL,
  `name` char(40) NOT NULL,
  `cache_id` varchar(254) DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id_smarty_cache`),
  KEY `name` (`name`),
  KEY `cache_id` (`cache_id`),
  KEY `modified` (`modified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_smarty_cache`
--

LOCK TABLES `ps_smarty_cache` WRITE;
/*!40000 ALTER TABLE `ps_smarty_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_smarty_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_smarty_last_flush`
--

DROP TABLE IF EXISTS `ps_smarty_last_flush`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smarty_last_flush` (
  `type` enum('compile','template') NOT NULL,
  `last_flush` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_smarty_last_flush`
--

LOCK TABLES `ps_smarty_last_flush` WRITE;
/*!40000 ALTER TABLE `ps_smarty_last_flush` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_smarty_last_flush` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_smarty_lazy_cache`
--

DROP TABLE IF EXISTS `ps_smarty_lazy_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smarty_lazy_cache` (
  `template_hash` varchar(32) NOT NULL DEFAULT '',
  `cache_id` varchar(255) NOT NULL DEFAULT '',
  `compile_id` varchar(32) NOT NULL DEFAULT '',
  `filepath` varchar(255) NOT NULL DEFAULT '',
  `last_update` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`template_hash`,`cache_id`,`compile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_smarty_lazy_cache`
--

LOCK TABLES `ps_smarty_lazy_cache` WRITE;
/*!40000 ALTER TABLE `ps_smarty_lazy_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_smarty_lazy_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_smilepay_c2cup_table`
--

DROP TABLE IF EXISTS `ps_smilepay_c2cup_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smilepay_c2cup_table` (
  `id_smilepay_c2cup` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned NOT NULL,
  `smse_id` text NOT NULL,
  `store_id` varchar(50) NOT NULL,
  `store_name` varchar(50) NOT NULL,
  `store_address` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_phone` varchar(50) NOT NULL,
  `amount` decimal(20,6) NOT NULL,
  `c2cup_no` varchar(255) DEFAULT NULL,
  `btn_url` text NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_smilepay_c2cup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='速買配 超商取貨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_smilepay_c2cup_table`
--

LOCK TABLES `ps_smilepay_c2cup_table` WRITE;
/*!40000 ALTER TABLE `ps_smilepay_c2cup_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_smilepay_c2cup_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_smilepay_csv_table`
--

DROP TABLE IF EXISTS `ps_smilepay_csv_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smilepay_csv_table` (
  `id_smilepay_csv` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned NOT NULL,
  `smse_id` text NOT NULL,
  `barcode1` varchar(50) NOT NULL,
  `barcode2` varchar(50) NOT NULL,
  `barcode3` varchar(50) NOT NULL,
  `dateline` varchar(255) NOT NULL,
  `amount` decimal(20,6) NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_smilepay_csv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_smilepay_csv_table`
--

LOCK TABLES `ps_smilepay_csv_table` WRITE;
/*!40000 ALTER TABLE `ps_smilepay_csv_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_smilepay_csv_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_smilepay_ezcat_table`
--

DROP TABLE IF EXISTS `ps_smilepay_ezcat_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smilepay_ezcat_table` (
  `id_order` int(10) unsigned NOT NULL,
  `smse_id` varchar(255) NOT NULL,
  `track_num` varchar(255) NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_smilepay_ezcat_table`
--

LOCK TABLES `ps_smilepay_ezcat_table` WRITE;
/*!40000 ALTER TABLE `ps_smilepay_ezcat_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_smilepay_ezcat_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_smilepay_ezcatup_table`
--

DROP TABLE IF EXISTS `ps_smilepay_ezcatup_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smilepay_ezcatup_table` (
  `id_order` int(10) unsigned NOT NULL,
  `smse_id` varchar(255) NOT NULL,
  `track_num` varchar(255) NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_smilepay_ezcatup_table`
--

LOCK TABLES `ps_smilepay_ezcatup_table` WRITE;
/*!40000 ALTER TABLE `ps_smilepay_ezcatup_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_smilepay_ezcatup_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_smilepay_palmboxc2cup_table`
--

DROP TABLE IF EXISTS `ps_smilepay_palmboxc2cup_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_smilepay_palmboxc2cup_table` (
  `id_order` int(10) unsigned NOT NULL,
  `smse_id` varchar(255) DEFAULT NULL,
  `track_num` varchar(255) DEFAULT NULL,
  `checkcode` varchar(512) DEFAULT NULL,
  `storeid` varchar(255) NOT NULL,
  `storename` varchar(255) NOT NULL,
  `storeaddress` varchar(512) NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_smilepay_palmboxc2cup_table`
--

LOCK TABLES `ps_smilepay_palmboxc2cup_table` WRITE;
/*!40000 ALTER TABLE `ps_smilepay_palmboxc2cup_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_smilepay_palmboxc2cup_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_sociallogin`
--

DROP TABLE IF EXISTS `ps_sociallogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_sociallogin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_social` varchar(20) NOT NULL,
  `type` varchar(10) NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_social` (`id_social`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_sociallogin`
--

LOCK TABLES `ps_sociallogin` WRITE;
/*!40000 ALTER TABLE `ps_sociallogin` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_sociallogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_specific_price`
--

DROP TABLE IF EXISTS `ps_specific_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price` (
  `id_specific_price` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_specific_price_rule` int(11) unsigned NOT NULL,
  `id_cart` int(11) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_shop_group` int(11) unsigned NOT NULL,
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `id_customer` int(10) unsigned NOT NULL,
  `id_product_attribute` int(10) unsigned NOT NULL,
  `price` decimal(20,6) NOT NULL,
  `from_quantity` mediumint(8) unsigned NOT NULL,
  `reduction` decimal(20,6) NOT NULL,
  `reduction_tax` tinyint(1) NOT NULL DEFAULT '1',
  `reduction_type` enum('amount','percentage') NOT NULL,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  PRIMARY KEY (`id_specific_price`),
  UNIQUE KEY `id_product_2` (`id_product`,`id_product_attribute`,`id_customer`,`id_cart`,`from`,`to`,`id_shop`,`id_shop_group`,`id_currency`,`id_country`,`id_group`,`from_quantity`,`id_specific_price_rule`),
  KEY `id_product` (`id_product`,`id_shop`,`id_currency`,`id_country`,`id_group`,`id_customer`,`from_quantity`,`from`,`to`),
  KEY `from_quantity` (`from_quantity`),
  KEY `id_specific_price_rule` (`id_specific_price_rule`),
  KEY `id_cart` (`id_cart`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_shop` (`id_shop`),
  KEY `id_customer` (`id_customer`),
  KEY `from` (`from`),
  KEY `to` (`to`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_specific_price`
--

LOCK TABLES `ps_specific_price` WRITE;
/*!40000 ALTER TABLE `ps_specific_price` DISABLE KEYS */;
INSERT INTO `ps_specific_price` VALUES (18,0,0,1,1,0,0,0,0,0,0,-1.000000,1,0.100000,1,'percentage','0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,0,0,14,1,0,0,0,0,0,0,-1.000000,1,100.000000,0,'amount','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ps_specific_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_specific_price_priority`
--

DROP TABLE IF EXISTS `ps_specific_price_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price_priority` (
  `id_specific_price_priority` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(11) NOT NULL,
  `priority` varchar(80) NOT NULL,
  PRIMARY KEY (`id_specific_price_priority`,`id_product`),
  UNIQUE KEY `id_product` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_specific_price_priority`
--

LOCK TABLES `ps_specific_price_priority` WRITE;
/*!40000 ALTER TABLE `ps_specific_price_priority` DISABLE KEYS */;
INSERT INTO `ps_specific_price_priority` VALUES (1,6,'id_shop;id_currency;id_country;id_group'),(7,8,'id_shop;id_currency;id_country;id_group'),(29,11,'id_shop;id_currency;id_country;id_group'),(35,13,'id_shop;id_currency;id_country;id_group'),(37,14,'id_shop;id_currency;id_country;id_group'),(38,15,'id_shop;id_currency;id_country;id_group'),(52,1,'id_shop;id_currency;id_country;id_group'),(60,2,'id_shop;id_currency;id_country;id_group'),(76,3,'id_shop;id_currency;id_country;id_group'),(82,4,'id_shop;id_currency;id_country;id_group'),(91,5,'id_shop;id_currency;id_country;id_group'),(94,7,'id_shop;id_currency;id_country;id_group'),(96,9,'id_shop;id_currency;id_country;id_group'),(97,10,'id_shop;id_currency;id_country;id_group'),(99,12,'id_shop;id_currency;id_country;id_group');
/*!40000 ALTER TABLE `ps_specific_price_priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_specific_price_rule`
--

DROP TABLE IF EXISTS `ps_specific_price_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price_rule` (
  `id_specific_price_rule` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `id_shop` int(11) unsigned NOT NULL DEFAULT '1',
  `id_currency` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL,
  `from_quantity` mediumint(8) unsigned NOT NULL,
  `price` decimal(20,6) DEFAULT NULL,
  `reduction` decimal(20,6) NOT NULL,
  `reduction_tax` tinyint(1) NOT NULL DEFAULT '1',
  `reduction_type` enum('amount','percentage') NOT NULL,
  `from` datetime NOT NULL,
  `to` datetime NOT NULL,
  PRIMARY KEY (`id_specific_price_rule`),
  KEY `id_product` (`id_shop`,`id_currency`,`id_country`,`id_group`,`from_quantity`,`from`,`to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_specific_price_rule`
--

LOCK TABLES `ps_specific_price_rule` WRITE;
/*!40000 ALTER TABLE `ps_specific_price_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_specific_price_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_specific_price_rule_condition`
--

DROP TABLE IF EXISTS `ps_specific_price_rule_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price_rule_condition` (
  `id_specific_price_rule_condition` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_specific_price_rule_condition_group` int(11) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id_specific_price_rule_condition`),
  KEY `id_specific_price_rule_condition_group` (`id_specific_price_rule_condition_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_specific_price_rule_condition`
--

LOCK TABLES `ps_specific_price_rule_condition` WRITE;
/*!40000 ALTER TABLE `ps_specific_price_rule_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_specific_price_rule_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_specific_price_rule_condition_group`
--

DROP TABLE IF EXISTS `ps_specific_price_rule_condition_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_specific_price_rule_condition_group` (
  `id_specific_price_rule_condition_group` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_specific_price_rule` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_specific_price_rule_condition_group`,`id_specific_price_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_specific_price_rule_condition_group`
--

LOCK TABLES `ps_specific_price_rule_condition_group` WRITE;
/*!40000 ALTER TABLE `ps_specific_price_rule_condition_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_specific_price_rule_condition_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_state`
--

DROP TABLE IF EXISTS `ps_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_state` (
  `id_state` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(11) unsigned NOT NULL,
  `id_zone` int(11) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `iso_code` varchar(7) NOT NULL,
  `tax_behavior` smallint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_state`),
  KEY `id_country` (`id_country`),
  KEY `name` (`name`),
  KEY `id_zone` (`id_zone`)
) ENGINE=InnoDB AUTO_INCREMENT=372 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_state`
--

LOCK TABLES `ps_state` WRITE;
/*!40000 ALTER TABLE `ps_state` DISABLE KEYS */;
INSERT INTO `ps_state` VALUES (1,21,2,'AA','AA',0,1),(2,21,2,'AE','AE',0,1),(3,21,2,'AP','AP',0,1),(4,21,2,'Alabama','AL',0,1),(5,21,2,'Alaska','AK',0,1),(6,21,2,'Arizona','AZ',0,1),(7,21,2,'Arkansas','AR',0,1),(8,21,2,'California','CA',0,1),(9,21,2,'Colorado','CO',0,1),(10,21,2,'Connecticut','CT',0,1),(11,21,2,'Delaware','DE',0,1),(12,21,2,'Florida','FL',0,1),(13,21,2,'Georgia','GA',0,1),(14,21,2,'Hawaii','HI',0,1),(15,21,2,'Idaho','ID',0,1),(16,21,2,'Illinois','IL',0,1),(17,21,2,'Indiana','IN',0,1),(18,21,2,'Iowa','IA',0,1),(19,21,2,'Kansas','KS',0,1),(20,21,2,'Kentucky','KY',0,1),(21,21,2,'Louisiana','LA',0,1),(22,21,2,'Maine','ME',0,1),(23,21,2,'Maryland','MD',0,1),(24,21,2,'Massachusetts','MA',0,1),(25,21,2,'Michigan','MI',0,1),(26,21,2,'Minnesota','MN',0,1),(27,21,2,'Mississippi','MS',0,1),(28,21,2,'Missouri','MO',0,1),(29,21,2,'Montana','MT',0,1),(30,21,2,'Nebraska','NE',0,1),(31,21,2,'Nevada','NV',0,1),(32,21,2,'New Hampshire','NH',0,1),(33,21,2,'New Jersey','NJ',0,1),(34,21,2,'New Mexico','NM',0,1),(35,21,2,'New York','NY',0,1),(36,21,2,'North Carolina','NC',0,1),(37,21,2,'North Dakota','ND',0,1),(38,21,2,'Ohio','OH',0,1),(39,21,2,'Oklahoma','OK',0,1),(40,21,2,'Oregon','OR',0,1),(41,21,2,'Pennsylvania','PA',0,1),(42,21,2,'Rhode Island','RI',0,1),(43,21,2,'South Carolina','SC',0,1),(44,21,2,'South Dakota','SD',0,1),(45,21,2,'Tennessee','TN',0,1),(46,21,2,'Texas','TX',0,1),(47,21,2,'Utah','UT',0,1),(48,21,2,'Vermont','VT',0,1),(49,21,2,'Virginia','VA',0,1),(50,21,2,'Washington','WA',0,1),(51,21,2,'West Virginia','WV',0,1),(52,21,2,'Wisconsin','WI',0,1),(53,21,2,'Wyoming','WY',0,1),(54,21,2,'Puerto Rico','PR',0,1),(55,21,2,'US Virgin Islands','VI',0,1),(56,21,2,'District of Columbia','DC',0,1),(57,145,2,'Aguascalientes','AGS',0,1),(58,145,2,'Baja California','BCN',0,1),(59,145,2,'Baja California Sur','BCS',0,1),(60,145,2,'Campeche','CAM',0,1),(61,145,2,'Chiapas','CHP',0,1),(62,145,2,'Chihuahua','CHH',0,1),(63,145,2,'Coahuila','COA',0,1),(64,145,2,'Colima','COL',0,1),(65,145,2,'Distrito Federal','DIF',0,1),(66,145,2,'Durango','DUR',0,1),(67,145,2,'Guanajuato','GUA',0,1),(68,145,2,'Guerrero','GRO',0,1),(69,145,2,'Hidalgo','HID',0,1),(70,145,2,'Jalisco','JAL',0,1),(71,145,2,'Estado de México','MEX',0,1),(72,145,2,'Michoacán','MIC',0,1),(73,145,2,'Morelos','MOR',0,1),(74,145,2,'Nayarit','NAY',0,1),(75,145,2,'Nuevo León','NLE',0,1),(76,145,2,'Oaxaca','OAX',0,1),(77,145,2,'Puebla','PUE',0,1),(78,145,2,'Querétaro','QUE',0,1),(79,145,2,'Quintana Roo','ROO',0,1),(80,145,2,'San Luis Potosí','SLP',0,1),(81,145,2,'Sinaloa','SIN',0,1),(82,145,2,'Sonora','SON',0,1),(83,145,2,'Tabasco','TAB',0,1),(84,145,2,'Tamaulipas','TAM',0,1),(85,145,2,'Tlaxcala','TLA',0,1),(86,145,2,'Veracruz','VER',0,1),(87,145,2,'Yucatán','YUC',0,1),(88,145,2,'Zacatecas','ZAC',0,1),(89,4,2,'Ontario','ON',0,1),(90,4,2,'Quebec','QC',0,1),(91,4,2,'British Columbia','BC',0,1),(92,4,2,'Alberta','AB',0,1),(93,4,2,'Manitoba','MB',0,1),(94,4,2,'Saskatchewan','SK',0,1),(95,4,2,'Nova Scotia','NS',0,1),(96,4,2,'New Brunswick','NB',0,1),(97,4,2,'Newfoundland and Labrador','NL',0,1),(98,4,2,'Prince Edward Island','PE',0,1),(99,4,2,'Northwest Territories','NT',0,1),(100,4,2,'Yukon','YT',0,1),(101,4,2,'Nunavut','NU',0,1),(102,44,6,'Buenos Aires','B',0,1),(103,44,6,'Catamarca','K',0,1),(104,44,6,'Chaco','H',0,1),(105,44,6,'Chubut','U',0,1),(106,44,6,'Ciudad de Buenos Aires','C',0,1),(107,44,6,'Córdoba','X',0,1),(108,44,6,'Corrientes','W',0,1),(109,44,6,'Entre Ríos','E',0,1),(110,44,6,'Formosa','P',0,1),(111,44,6,'Jujuy','Y',0,1),(112,44,6,'La Pampa','L',0,1),(113,44,6,'La Rioja','F',0,1),(114,44,6,'Mendoza','M',0,1),(115,44,6,'Misiones','N',0,1),(116,44,6,'Neuquén','Q',0,1),(117,44,6,'Río Negro','R',0,1),(118,44,6,'Salta','A',0,1),(119,44,6,'San Juan','J',0,1),(120,44,6,'San Luis','D',0,1),(121,44,6,'Santa Cruz','Z',0,1),(122,44,6,'Santa Fe','S',0,1),(123,44,6,'Santiago del Estero','G',0,1),(124,44,6,'Tierra del Fuego','V',0,1),(125,44,6,'Tucumán','T',0,1),(126,10,1,'Agrigento','AG',0,1),(127,10,1,'Alessandria','AL',0,1),(128,10,1,'Ancona','AN',0,1),(129,10,1,'Aosta','AO',0,1),(130,10,1,'Arezzo','AR',0,1),(131,10,1,'Ascoli Piceno','AP',0,1),(132,10,1,'Asti','AT',0,1),(133,10,1,'Avellino','AV',0,1),(134,10,1,'Bari','BA',0,1),(135,10,1,'Barletta-Andria-Trani','BT',0,1),(136,10,1,'Belluno','BL',0,1),(137,10,1,'Benevento','BN',0,1),(138,10,1,'Bergamo','BG',0,1),(139,10,1,'Biella','BI',0,1),(140,10,1,'Bologna','BO',0,1),(141,10,1,'Bolzano','BZ',0,1),(142,10,1,'Brescia','BS',0,1),(143,10,1,'Brindisi','BR',0,1),(144,10,1,'Cagliari','CA',0,1),(145,10,1,'Caltanissetta','CL',0,1),(146,10,1,'Campobasso','CB',0,1),(147,10,1,'Carbonia-Iglesias','CI',0,1),(148,10,1,'Caserta','CE',0,1),(149,10,1,'Catania','CT',0,1),(150,10,1,'Catanzaro','CZ',0,1),(151,10,1,'Chieti','CH',0,1),(152,10,1,'Como','CO',0,1),(153,10,1,'Cosenza','CS',0,1),(154,10,1,'Cremona','CR',0,1),(155,10,1,'Crotone','KR',0,1),(156,10,1,'Cuneo','CN',0,1),(157,10,1,'Enna','EN',0,1),(158,10,1,'Fermo','FM',0,1),(159,10,1,'Ferrara','FE',0,1),(160,10,1,'Firenze','FI',0,1),(161,10,1,'Foggia','FG',0,1),(162,10,1,'Forlì-Cesena','FC',0,1),(163,10,1,'Frosinone','FR',0,1),(164,10,1,'Genova','GE',0,1),(165,10,1,'Gorizia','GO',0,1),(166,10,1,'Grosseto','GR',0,1),(167,10,1,'Imperia','IM',0,1),(168,10,1,'Isernia','IS',0,1),(169,10,1,'L\'Aquila','AQ',0,1),(170,10,1,'La Spezia','SP',0,1),(171,10,1,'Latina','LT',0,1),(172,10,1,'Lecce','LE',0,1),(173,10,1,'Lecco','LC',0,1),(174,10,1,'Livorno','LI',0,1),(175,10,1,'Lodi','LO',0,1),(176,10,1,'Lucca','LU',0,1),(177,10,1,'Macerata','MC',0,1),(178,10,1,'Mantova','MN',0,1),(179,10,1,'Massa','MS',0,1),(180,10,1,'Matera','MT',0,1),(181,10,1,'Medio Campidano','VS',0,1),(182,10,1,'Messina','ME',0,1),(183,10,1,'Milano','MI',0,1),(184,10,1,'Modena','MO',0,1),(185,10,1,'Monza e della Brianza','MB',0,1),(186,10,1,'Napoli','NA',0,1),(187,10,1,'Novara','NO',0,1),(188,10,1,'Nuoro','NU',0,1),(189,10,1,'Ogliastra','OG',0,1),(190,10,1,'Olbia-Tempio','OT',0,1),(191,10,1,'Oristano','OR',0,1),(192,10,1,'Padova','PD',0,1),(193,10,1,'Palermo','PA',0,1),(194,10,1,'Parma','PR',0,1),(195,10,1,'Pavia','PV',0,1),(196,10,1,'Perugia','PG',0,1),(197,10,1,'Pesaro-Urbino','PU',0,1),(198,10,1,'Pescara','PE',0,1),(199,10,1,'Piacenza','PC',0,1),(200,10,1,'Pisa','PI',0,1),(201,10,1,'Pistoia','PT',0,1),(202,10,1,'Pordenone','PN',0,1),(203,10,1,'Potenza','PZ',0,1),(204,10,1,'Prato','PO',0,1),(205,10,1,'Ragusa','RG',0,1),(206,10,1,'Ravenna','RA',0,1),(207,10,1,'Reggio Calabria','RC',0,1),(208,10,1,'Reggio Emilia','RE',0,1),(209,10,1,'Rieti','RI',0,1),(210,10,1,'Rimini','RN',0,1),(211,10,1,'Roma','RM',0,1),(212,10,1,'Rovigo','RO',0,1),(213,10,1,'Salerno','SA',0,1),(214,10,1,'Sassari','SS',0,1),(215,10,1,'Savona','SV',0,1),(216,10,1,'Siena','SI',0,1),(217,10,1,'Siracusa','SR',0,1),(218,10,1,'Sondrio','SO',0,1),(219,10,1,'Taranto','TA',0,1),(220,10,1,'Teramo','TE',0,1),(221,10,1,'Terni','TR',0,1),(222,10,1,'Torino','TO',0,1),(223,10,1,'Trapani','TP',0,1),(224,10,1,'Trento','TN',0,1),(225,10,1,'Treviso','TV',0,1),(226,10,1,'Trieste','TS',0,1),(227,10,1,'Udine','UD',0,1),(228,10,1,'Varese','VA',0,1),(229,10,1,'Venezia','VE',0,1),(230,10,1,'Verbano-Cusio-Ossola','VB',0,1),(231,10,1,'Vercelli','VC',0,1),(232,10,1,'Verona','VR',0,1),(233,10,1,'Vibo Valentia','VV',0,1),(234,10,1,'Vicenza','VI',0,1),(235,10,1,'Viterbo','VT',0,1),(236,111,3,'Aceh','ID-AC',0,1),(237,111,3,'Bali','ID-BA',0,1),(238,111,3,'Banten','ID-BT',0,1),(239,111,3,'Bengkulu','ID-BE',0,1),(240,111,3,'Gorontalo','ID-GO',0,1),(241,111,3,'Jakarta','ID-JK',0,1),(242,111,3,'Jambi','ID-JA',0,1),(243,111,3,'Jawa Barat','ID-JB',0,1),(244,111,3,'Jawa Tengah','ID-JT',0,1),(245,111,3,'Jawa Timur','ID-JI',0,1),(246,111,3,'Kalimantan Barat','ID-KB',0,1),(247,111,3,'Kalimantan Selatan','ID-KS',0,1),(248,111,3,'Kalimantan Tengah','ID-KT',0,1),(249,111,3,'Kalimantan Timur','ID-KI',0,1),(250,111,3,'Kalimantan Utara','ID-KU',0,1),(251,111,3,'Kepulauan Bangka Belitug','ID-BB',0,1),(252,111,3,'Kepulauan Riau','ID-KR',0,1),(253,111,3,'Lampung','ID-LA',0,1),(254,111,3,'Maluku','ID-MA',0,1),(255,111,3,'Maluku Utara','ID-MU',0,1),(256,111,3,'Nusa Tengara Barat','ID-NB',0,1),(257,111,3,'Nusa Tenggara Timur','ID-NT',0,1),(258,111,3,'Papua','ID-PA',0,1),(259,111,3,'Papua Barat','ID-PB',0,1),(260,111,3,'Riau','ID-RI',0,1),(261,111,3,'Sulawesi Barat','ID-SR',0,1),(262,111,3,'Sulawesi Selatan','ID-SN',0,1),(263,111,3,'Sulawesi Tengah','ID-ST',0,1),(264,111,3,'Sulawesi Tenggara','ID-SG',0,1),(265,111,3,'Sulawesi Utara','ID-SA',0,1),(266,111,3,'Sumatera Barat','ID-SB',0,1),(267,111,3,'Sumatera Selatan','ID-SS',0,1),(268,111,3,'Sumatera Utara','ID-SU',0,1),(269,111,3,'Yogyakarta','ID-YO',0,1),(270,11,10,'Aichi','23',0,1),(271,11,10,'Akita','05',0,1),(272,11,10,'Aomori','02',0,1),(273,11,10,'Chiba','12',0,1),(274,11,10,'Ehime','38',0,1),(275,11,10,'Fukui','18',0,1),(276,11,10,'Fukuoka','40',0,1),(277,11,10,'Fukushima','07',0,1),(278,11,10,'Gifu','21',0,1),(279,11,10,'Gunma','10',0,1),(280,11,10,'Hiroshima','34',0,1),(281,11,10,'Hokkaido','01',0,1),(282,11,10,'Hyogo','28',0,1),(283,11,10,'Ibaraki','08',0,1),(284,11,10,'Ishikawa','17',0,1),(285,11,10,'Iwate','03',0,1),(286,11,10,'Kagawa','37',0,1),(287,11,10,'Kagoshima','46',0,1),(288,11,10,'Kanagawa','14',0,1),(289,11,10,'Kochi','39',0,1),(290,11,10,'Kumamoto','43',0,1),(291,11,10,'Kyoto','26',0,1),(292,11,10,'Mie','24',0,1),(293,11,10,'Miyagi','04',0,1),(294,11,10,'Miyazaki','45',0,1),(295,11,10,'Nagano','20',0,1),(296,11,10,'Nagasaki','42',0,1),(297,11,10,'Nara','29',0,1),(298,11,10,'Niigata','15',0,1),(299,11,10,'Oita','44',0,1),(300,11,10,'Okayama','33',0,1),(301,11,10,'Okinawa','47',0,1),(302,11,10,'Osaka','27',0,1),(303,11,10,'Saga','41',0,1),(304,11,10,'Saitama','11',0,1),(305,11,10,'Shiga','25',0,1),(306,11,10,'Shimane','32',0,1),(307,11,10,'Shizuoka','22',0,1),(308,11,10,'Tochigi','09',0,1),(309,11,10,'Tokushima','36',0,1),(310,11,10,'Tokyo','13',0,1),(311,11,10,'Tottori','31',0,1),(312,11,10,'Toyama','16',0,1),(313,11,10,'Wakayama','30',0,1),(314,11,10,'Yamagata','06',0,1),(315,11,10,'Yamaguchi','35',0,1),(316,11,10,'Yamanashi','19',0,1),(317,24,5,'Australian Capital Territory','ACT',0,1),(318,24,5,'New South Wales','NSW',0,1),(319,24,5,'Northern Territory','NT',0,1),(320,24,5,'Queensland','QLD',0,1),(321,24,5,'South Australia','SA',0,1),(322,24,5,'Tasmania','TAS',0,1),(323,24,5,'Victoria','VIC',0,1),(324,24,5,'Western Australia','WA',0,1),(325,11,10,'Aichi','JP-23',0,1),(326,11,10,'Akita','JP-05',0,1),(327,11,10,'Aomori','JP-02',0,1),(328,11,10,'Chiba','JP-12',0,1),(329,11,10,'Ehime','JP-38',0,1),(330,11,10,'Fukui','JP-18',0,1),(331,11,10,'Fukuoka','JP-40',0,1),(332,11,10,'Fukushima','JP-07',0,1),(333,11,10,'Gifu','JP-21',0,1),(334,11,10,'Gunma','JP-10',0,1),(335,11,10,'Hiroshima','JP-34',0,1),(336,11,10,'Hokkaido','JP-01',0,1),(337,11,10,'Hyōgo','JP-28',0,1),(338,11,10,'Ibaraki','JP-08',0,1),(339,11,10,'Ishikawa','JP-17',0,1),(340,11,10,'Iwate','JP-03',0,1),(341,11,10,'Kagawa','JP-37',0,1),(342,11,10,'Kagoshima','JP-46',0,1),(343,11,10,'Kanagawa','JP-14',0,1),(344,11,10,'Kōchi','JP-39',0,1),(345,11,10,'Kumamoto','JP-43',0,1),(346,11,10,'Kyoto','JP-26',0,1),(347,11,10,'Mie','JP-24',0,1),(348,11,10,'Miyagi','JP-04',0,1),(349,11,10,'Miyazaki','JP-45',0,1),(350,11,10,'Nagano','JP-20',0,1),(351,11,10,'Nagasaki','JP-42',0,1),(352,11,10,'Nara','JP-29',0,1),(353,11,10,'Niigata','JP-15',0,1),(354,11,10,'Ōita','JP-44',0,1),(355,11,10,'Okayama','JP-33',0,1),(356,11,10,'Okinawa','JP-47',0,1),(357,11,10,'Osaka','JP-27',0,1),(358,11,10,'Saga','JP-41',0,1),(359,11,10,'Saitama','JP-11',0,1),(360,11,10,'Shiga','JP-25',0,1),(361,11,10,'Shimane','JP-32',0,1),(362,11,10,'Shizuoka','JP-22',0,1),(363,11,10,'Tochigi','JP-09',0,1),(364,11,10,'Tokushima','JP-36',0,1),(365,11,10,'Tokyo','JP-13',0,1),(366,11,10,'Tottori','JP-31',0,1),(367,11,10,'Toyama','JP-16',0,1),(368,11,10,'Wakayama','JP-30',0,1),(369,11,10,'Yamagata','JP-06',0,1),(370,11,10,'Yamaguchi','JP-35',0,1),(371,11,10,'Yamanashi','JP-19',0,1);
/*!40000 ALTER TABLE `ps_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_stock`
--

DROP TABLE IF EXISTS `ps_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock` (
  `id_stock` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_warehouse` int(11) unsigned NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `reference` varchar(64) DEFAULT NULL,
  `ean13` varchar(13) DEFAULT NULL,
  `isbn` varchar(32) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `physical_quantity` int(11) unsigned NOT NULL,
  `usable_quantity` int(11) unsigned NOT NULL,
  `price_te` decimal(20,6) DEFAULT '0.000000',
  PRIMARY KEY (`id_stock`),
  KEY `id_warehouse` (`id_warehouse`),
  KEY `id_product` (`id_product`),
  KEY `id_product_attribute` (`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_stock`
--

LOCK TABLES `ps_stock` WRITE;
/*!40000 ALTER TABLE `ps_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_stock_available`
--

DROP TABLE IF EXISTS `ps_stock_available`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock_available` (
  `id_stock_available` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  `id_shop_group` int(11) unsigned NOT NULL,
  `quantity` int(10) NOT NULL DEFAULT '0',
  `physical_quantity` int(11) NOT NULL DEFAULT '0',
  `reserved_quantity` int(11) NOT NULL DEFAULT '0',
  `depends_on_stock` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `out_of_stock` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_stock_available`),
  UNIQUE KEY `product_sqlstock` (`id_product`,`id_product_attribute`,`id_shop`,`id_shop_group`),
  KEY `id_shop` (`id_shop`),
  KEY `id_shop_group` (`id_shop_group`),
  KEY `id_product` (`id_product`),
  KEY `id_product_attribute` (`id_product_attribute`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_stock_available`
--

LOCK TABLES `ps_stock_available` WRITE;
/*!40000 ALTER TABLE `ps_stock_available` DISABLE KEYS */;
INSERT INTO `ps_stock_available` VALUES (1,1,0,1,0,995,996,1,0,2,''),(2,2,0,1,0,80,80,0,0,2,''),(3,3,0,1,0,1000,1000,0,0,2,NULL),(4,4,0,1,0,997,997,0,0,2,''),(5,5,0,1,0,1,1,0,0,2,''),(6,6,0,1,0,991,991,0,0,2,''),(8,8,0,1,0,989,989,0,0,2,''),(9,9,0,1,0,966,966,0,0,2,''),(10,10,0,1,0,799,801,2,0,2,''),(11,11,0,1,0,872,888,16,0,2,''),(12,12,0,1,0,996,997,1,0,1,''),(13,13,0,1,0,496,496,0,0,2,''),(14,14,0,1,0,99,99,0,0,2,''),(15,15,0,1,0,357,357,0,0,2,''),(17,13,1,1,0,100,100,0,0,2,''),(18,13,2,1,0,100,100,0,0,2,''),(19,13,3,1,0,96,98,2,0,2,''),(20,13,4,1,0,100,100,0,0,2,''),(21,13,5,1,0,100,100,0,0,2,''),(22,2,6,1,0,30,30,0,0,2,''),(23,2,7,1,0,20,20,0,0,2,''),(24,2,8,1,0,30,30,0,0,2,''),(25,15,9,1,0,0,0,0,0,2,''),(26,15,10,1,0,107,107,0,0,2,''),(27,15,11,1,0,120,120,0,0,2,''),(28,15,12,1,0,130,130,0,0,2,'');
/*!40000 ALTER TABLE `ps_stock_available` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_stock_mvt`
--

DROP TABLE IF EXISTS `ps_stock_mvt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock_mvt` (
  `id_stock_mvt` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_stock` int(11) NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `id_supply_order` int(11) DEFAULT NULL,
  `id_stock_mvt_reason` int(11) NOT NULL,
  `id_employee` int(11) NOT NULL,
  `employee_lastname` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_firstname` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `physical_quantity` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `sign` smallint(6) NOT NULL DEFAULT '1',
  `price_te` decimal(20,6) DEFAULT '0.000000',
  `last_wa` decimal(20,6) DEFAULT '0.000000',
  `current_wa` decimal(20,6) DEFAULT '0.000000',
  `referer` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_stock_mvt`),
  KEY `id_stock` (`id_stock`),
  KEY `id_stock_mvt_reason` (`id_stock_mvt_reason`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_stock_mvt`
--

LOCK TABLES `ps_stock_mvt` WRITE;
/*!40000 ALTER TABLE `ps_stock_mvt` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_stock_mvt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_stock_mvt_reason`
--

DROP TABLE IF EXISTS `ps_stock_mvt_reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock_mvt_reason` (
  `id_stock_mvt_reason` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sign` tinyint(1) NOT NULL DEFAULT '1',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_stock_mvt_reason`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_stock_mvt_reason`
--

LOCK TABLES `ps_stock_mvt_reason` WRITE;
/*!40000 ALTER TABLE `ps_stock_mvt_reason` DISABLE KEYS */;
INSERT INTO `ps_stock_mvt_reason` VALUES (1,1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(2,-1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(3,-1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(4,-1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(5,1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(6,-1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(7,1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(8,1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(9,1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(10,1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(11,1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0),(12,-1,'2018-07-11 11:57:36','2018-07-11 11:57:36',0);
/*!40000 ALTER TABLE `ps_stock_mvt_reason` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_stock_mvt_reason_lang`
--

DROP TABLE IF EXISTS `ps_stock_mvt_reason_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_stock_mvt_reason_lang` (
  `id_stock_mvt_reason` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_stock_mvt_reason`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_stock_mvt_reason_lang`
--

LOCK TABLES `ps_stock_mvt_reason_lang` WRITE;
/*!40000 ALTER TABLE `ps_stock_mvt_reason_lang` DISABLE KEYS */;
INSERT INTO `ps_stock_mvt_reason_lang` VALUES (1,1,'漲價'),(1,2,'涨价'),(1,3,'涨价'),(1,4,'涨价'),(2,1,'減少'),(2,2,'下降'),(2,3,'下降'),(2,4,'下降'),(3,1,'客戶訂單'),(3,2,'Customer Order'),(3,3,'Customer Order'),(3,4,'顧客注文'),(4,1,'Regulation following an inventory of stock'),(4,2,'Regulation following an inventory of stock'),(4,3,'Regulation following an inventory of stock'),(4,4,'Regulation following an inventory of stock'),(5,1,'Regulation following an inventory of stock'),(5,2,'Regulation following an inventory of stock'),(5,3,'Regulation following an inventory of stock'),(5,4,'Regulation following an inventory of stock'),(6,1,'轉移到另一個倉庫'),(6,2,'Transfer to another warehouse'),(6,3,'Transfer to another warehouse'),(6,4,'別の倉庫に移動'),(7,1,'由另一個倉庫轉移到此'),(7,2,'Transfer from another warehouse'),(7,3,'Transfer from another warehouse'),(7,4,'別の倉庫から移動'),(8,1,'採購單'),(8,2,'Supply Order'),(8,3,'Supply Order'),(8,4,'発注'),(9,1,'客戶訂單'),(9,2,'Customer Order'),(9,3,'Customer Order'),(9,4,'顧客注文'),(10,1,'退回商品'),(10,2,'Product return'),(10,3,'Product Return'),(10,4,'商品の返品'),(11,1,'管理者修改'),(11,2,'Employee Edition'),(11,3,'Employee Edition'),(11,4,'Employee Edition'),(12,1,'管理者修改'),(12,2,'Employee Edition'),(12,3,'Employee Edition'),(12,4,'Employee Edition');
/*!40000 ALTER TABLE `ps_stock_mvt_reason_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_store`
--

DROP TABLE IF EXISTS `ps_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_store` (
  `id_store` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(10) unsigned NOT NULL,
  `id_state` int(10) unsigned DEFAULT NULL,
  `city` varchar(64) NOT NULL,
  `postcode` varchar(12) NOT NULL,
  `latitude` decimal(13,8) DEFAULT NULL,
  `longitude` decimal(13,8) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `fax` varchar(16) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_store`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_store`
--

LOCK TABLES `ps_store` WRITE;
/*!40000 ALTER TABLE `ps_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_store_lang`
--

DROP TABLE IF EXISTS `ps_store_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_store_lang` (
  `id_store` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `hours` text,
  `note` text,
  PRIMARY KEY (`id_store`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_store_lang`
--

LOCK TABLES `ps_store_lang` WRITE;
/*!40000 ALTER TABLE `ps_store_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_store_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_store_shop`
--

DROP TABLE IF EXISTS `ps_store_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_store_shop` (
  `id_store` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_store`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_store_shop`
--

LOCK TABLES `ps_store_shop` WRITE;
/*!40000 ALTER TABLE `ps_store_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_store_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supplier`
--

DROP TABLE IF EXISTS `ps_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supplier` (
  `id_supplier` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supplier`
--

LOCK TABLES `ps_supplier` WRITE;
/*!40000 ALTER TABLE `ps_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supplier_lang`
--

DROP TABLE IF EXISTS `ps_supplier_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supplier_lang` (
  `id_supplier` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `description` text,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id_supplier`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supplier_lang`
--

LOCK TABLES `ps_supplier_lang` WRITE;
/*!40000 ALTER TABLE `ps_supplier_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_supplier_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supplier_shop`
--

DROP TABLE IF EXISTS `ps_supplier_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supplier_shop` (
  `id_supplier` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_supplier`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supplier_shop`
--

LOCK TABLES `ps_supplier_shop` WRITE;
/*!40000 ALTER TABLE `ps_supplier_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_supplier_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supply_order`
--

DROP TABLE IF EXISTS `ps_supply_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order` (
  `id_supply_order` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supplier` int(11) unsigned NOT NULL,
  `supplier_name` varchar(64) NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `id_warehouse` int(11) unsigned NOT NULL,
  `id_supply_order_state` int(11) unsigned NOT NULL,
  `id_currency` int(11) unsigned NOT NULL,
  `id_ref_currency` int(11) unsigned NOT NULL,
  `reference` varchar(64) NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `date_delivery_expected` datetime DEFAULT NULL,
  `total_te` decimal(20,6) DEFAULT '0.000000',
  `total_with_discount_te` decimal(20,6) DEFAULT '0.000000',
  `total_tax` decimal(20,6) DEFAULT '0.000000',
  `total_ti` decimal(20,6) DEFAULT '0.000000',
  `discount_rate` decimal(20,6) DEFAULT '0.000000',
  `discount_value_te` decimal(20,6) DEFAULT '0.000000',
  `is_template` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_supply_order`),
  KEY `id_supplier` (`id_supplier`),
  KEY `id_warehouse` (`id_warehouse`),
  KEY `reference` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supply_order`
--

LOCK TABLES `ps_supply_order` WRITE;
/*!40000 ALTER TABLE `ps_supply_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_supply_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supply_order_detail`
--

DROP TABLE IF EXISTS `ps_supply_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_detail` (
  `id_supply_order_detail` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supply_order` int(11) unsigned NOT NULL,
  `id_currency` int(11) unsigned NOT NULL,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `reference` varchar(64) NOT NULL,
  `supplier_reference` varchar(64) NOT NULL,
  `name` varchar(128) NOT NULL,
  `ean13` varchar(13) DEFAULT NULL,
  `isbn` varchar(32) DEFAULT NULL,
  `upc` varchar(12) DEFAULT NULL,
  `exchange_rate` decimal(20,6) DEFAULT '0.000000',
  `unit_price_te` decimal(20,6) DEFAULT '0.000000',
  `quantity_expected` int(11) unsigned NOT NULL,
  `quantity_received` int(11) unsigned NOT NULL,
  `price_te` decimal(20,6) DEFAULT '0.000000',
  `discount_rate` decimal(20,6) DEFAULT '0.000000',
  `discount_value_te` decimal(20,6) DEFAULT '0.000000',
  `price_with_discount_te` decimal(20,6) DEFAULT '0.000000',
  `tax_rate` decimal(20,6) DEFAULT '0.000000',
  `tax_value` decimal(20,6) DEFAULT '0.000000',
  `price_ti` decimal(20,6) DEFAULT '0.000000',
  `tax_value_with_order_discount` decimal(20,6) DEFAULT '0.000000',
  `price_with_order_discount_te` decimal(20,6) DEFAULT '0.000000',
  PRIMARY KEY (`id_supply_order_detail`),
  KEY `id_supply_order` (`id_supply_order`,`id_product`),
  KEY `id_product_attribute` (`id_product_attribute`),
  KEY `id_product_product_attribute` (`id_product`,`id_product_attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supply_order_detail`
--

LOCK TABLES `ps_supply_order_detail` WRITE;
/*!40000 ALTER TABLE `ps_supply_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_supply_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supply_order_history`
--

DROP TABLE IF EXISTS `ps_supply_order_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_history` (
  `id_supply_order_history` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supply_order` int(11) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `employee_lastname` varchar(255) DEFAULT '',
  `employee_firstname` varchar(255) DEFAULT '',
  `id_state` int(11) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_supply_order_history`),
  KEY `id_supply_order` (`id_supply_order`),
  KEY `id_employee` (`id_employee`),
  KEY `id_state` (`id_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supply_order_history`
--

LOCK TABLES `ps_supply_order_history` WRITE;
/*!40000 ALTER TABLE `ps_supply_order_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_supply_order_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supply_order_receipt_history`
--

DROP TABLE IF EXISTS `ps_supply_order_receipt_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_receipt_history` (
  `id_supply_order_receipt_history` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supply_order_detail` int(11) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `employee_lastname` varchar(255) DEFAULT '',
  `employee_firstname` varchar(255) DEFAULT '',
  `id_supply_order_state` int(11) unsigned NOT NULL,
  `quantity` int(11) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  PRIMARY KEY (`id_supply_order_receipt_history`),
  KEY `id_supply_order_detail` (`id_supply_order_detail`),
  KEY `id_supply_order_state` (`id_supply_order_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supply_order_receipt_history`
--

LOCK TABLES `ps_supply_order_receipt_history` WRITE;
/*!40000 ALTER TABLE `ps_supply_order_receipt_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_supply_order_receipt_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supply_order_state`
--

DROP TABLE IF EXISTS `ps_supply_order_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_state` (
  `id_supply_order_state` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `delivery_note` tinyint(1) NOT NULL DEFAULT '0',
  `editable` tinyint(1) NOT NULL DEFAULT '0',
  `receipt_state` tinyint(1) NOT NULL DEFAULT '0',
  `pending_receipt` tinyint(1) NOT NULL DEFAULT '0',
  `enclosed` tinyint(1) NOT NULL DEFAULT '0',
  `color` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_supply_order_state`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supply_order_state`
--

LOCK TABLES `ps_supply_order_state` WRITE;
/*!40000 ALTER TABLE `ps_supply_order_state` DISABLE KEYS */;
INSERT INTO `ps_supply_order_state` VALUES (1,0,1,0,0,0,'#faab00'),(2,1,0,0,0,0,'#273cff'),(3,0,0,0,1,0,'#ff37f5'),(4,0,0,1,1,0,'#ff3e33'),(5,0,0,1,0,1,'#00d60c'),(6,0,0,0,0,1,'#666666');
/*!40000 ALTER TABLE `ps_supply_order_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_supply_order_state_lang`
--

DROP TABLE IF EXISTS `ps_supply_order_state_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_supply_order_state_lang` (
  `id_supply_order_state` int(11) unsigned NOT NULL,
  `id_lang` int(11) unsigned NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_supply_order_state`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_supply_order_state_lang`
--

LOCK TABLES `ps_supply_order_state_lang` WRITE;
/*!40000 ALTER TABLE `ps_supply_order_state_lang` DISABLE KEYS */;
INSERT INTO `ps_supply_order_state_lang` VALUES (1,1,'1 - 正在創建'),(1,2,'1 - Creation in progress'),(1,3,'1 - Creation in progress'),(1,4,'1 - 処理手続き中'),(2,1,'2 - 訂單已驗證'),(2,2,'2 - Order validated'),(2,3,'2 - Order validated'),(2,4,'2 - 注文確定済み'),(3,1,'3 - 待收貨'),(3,2,'3 - Pending receipt'),(3,3,'3 - Pending receipt'),(3,4,'3 - 受取確認待ち'),(4,1,'4 - 收到部分訂單'),(4,2,'4 - Order received in part'),(4,3,'4 - Order received in part'),(4,4,'4 - 注文商品一部受取'),(5,1,'5 - 訂單已完全接收'),(5,2,'5 - Order received completely'),(5,3,'5 - Order received completely'),(5,4,'5 - 全ての注文商品を受取'),(6,1,'6 - 訂單取消'),(6,2,'6 - Order canceled'),(6,3,'6 - Order canceled'),(6,4,'6 - 注文キャンセル');
/*!40000 ALTER TABLE `ps_supply_order_state_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tab`
--

DROP TABLE IF EXISTS `ps_tab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tab` (
  `id_tab` int(11) NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `module` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `hide_host_mode` tinyint(1) NOT NULL,
  `icon` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_tab`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tab`
--

LOCK TABLES `ps_tab` WRITE;
/*!40000 ALTER TABLE `ps_tab` DISABLE KEYS */;
INSERT INTO `ps_tab` VALUES (1,0,1,NULL,'AdminDashboard',1,0,'trending_up'),(2,0,2,NULL,'SELL',1,0,''),(3,2,1,NULL,'AdminParentOrders',1,0,'shopping_basket'),(4,3,1,NULL,'AdminOrders',1,0,''),(5,3,2,NULL,'AdminInvoices',0,0,''),(6,3,3,NULL,'AdminSlip',0,0,''),(7,3,4,NULL,'AdminDeliverySlip',0,0,''),(8,3,5,NULL,'AdminCarts',1,0,''),(9,2,2,NULL,'AdminCatalog',1,0,'store'),(10,9,1,NULL,'AdminProducts',1,0,''),(11,9,2,NULL,'AdminCategories',1,0,''),(12,9,3,NULL,'AdminTracking',0,0,''),(13,9,4,NULL,'AdminParentAttributesGroups',1,0,''),(14,13,1,NULL,'AdminAttributesGroups',1,0,''),(15,13,2,NULL,'AdminFeatures',1,0,''),(16,9,5,NULL,'AdminParentManufacturers',0,0,''),(17,16,1,NULL,'AdminManufacturers',1,0,''),(18,16,2,NULL,'AdminSuppliers',1,0,''),(19,9,6,NULL,'AdminAttachments',1,0,''),(20,9,7,NULL,'AdminParentCartRules',0,0,''),(21,9,7,NULL,'AdminCartRules',1,0,''),(22,20,2,NULL,'AdminSpecificPriceRule',0,0,''),(23,9,8,NULL,'AdminStockManagement',1,0,''),(24,2,3,NULL,'AdminParentCustomer',1,0,'account_circle'),(25,24,1,NULL,'AdminCustomers',1,0,''),(26,24,2,NULL,'AdminAddresses',1,0,''),(27,24,3,NULL,'AdminOutstanding',0,0,''),(28,2,4,NULL,'AdminParentCustomerThreads',1,0,'chat'),(29,28,1,NULL,'AdminCustomerThreads',1,0,''),(30,28,2,NULL,'AdminOrderMessage',1,0,''),(31,28,3,NULL,'AdminReturn',0,0,''),(32,2,5,NULL,'AdminStats',1,0,'assessment'),(33,2,6,NULL,'AdminStock',1,0,'store'),(34,33,1,NULL,'AdminWarehouses',1,0,''),(35,33,2,NULL,'AdminParentStockManagement',1,0,''),(36,35,1,NULL,'AdminStockManagement',1,0,''),(37,36,1,NULL,'AdminStockMvt',1,0,''),(38,36,2,NULL,'AdminStockInstantState',1,0,''),(39,36,3,NULL,'AdminStockCover',1,0,''),(40,33,3,NULL,'AdminSupplyOrders',1,0,''),(41,33,4,NULL,'AdminStockConfiguration',1,0,''),(42,0,3,NULL,'IMPROVE',1,0,''),(43,42,1,NULL,'AdminParentModulesSf',0,0,'extension'),(44,43,0,NULL,'AdminModulesSf',0,0,''),(45,44,1,NULL,'AdminModulesManage',0,0,''),(46,44,2,NULL,'AdminModulesCatalog',0,0,''),(47,44,3,NULL,'AdminModulesNotifications',0,0,''),(48,43,2,NULL,'AdminModules',0,0,''),(49,43,3,NULL,'AdminAddonsCatalog',1,0,''),(50,42,2,NULL,'AdminParentThemes',1,0,'desktop_mac'),(51,121,1,'','AdminThemes',1,0,''),(52,50,2,NULL,'AdminThemesCatalog',0,0,''),(53,50,3,NULL,'AdminCmsContent',1,0,''),(54,50,5,NULL,'AdminModulesPositions',1,0,''),(55,77,6,NULL,'AdminImages',1,0,''),(56,42,3,NULL,'AdminParentShipping',0,0,'local_shipping'),(57,59,2,NULL,'AdminCarriers',1,0,''),(58,56,2,NULL,'AdminShipping',1,0,''),(59,42,4,NULL,'AdminParentPayment',1,0,'payment'),(60,59,1,NULL,'AdminPayment',1,0,''),(61,59,3,NULL,'AdminPaymentPreferences',1,0,''),(62,42,5,NULL,'AdminInternational',1,0,'language'),(63,62,1,NULL,'AdminParentLocalization',1,0,''),(64,63,1,NULL,'AdminLocalization',1,0,''),(65,62,1,NULL,'AdminLanguages',1,0,''),(66,62,2,NULL,'AdminCurrencies',1,0,''),(67,63,4,NULL,'AdminGeolocation',0,0,''),(68,62,2,NULL,'AdminParentCountries',1,0,''),(69,68,1,NULL,'AdminZones',1,0,''),(70,68,2,NULL,'AdminCountries',1,0,''),(71,68,3,NULL,'AdminStates',0,0,''),(72,62,3,NULL,'AdminParentTaxes',0,0,''),(73,72,1,NULL,'AdminTaxes',1,0,''),(74,72,2,NULL,'AdminTaxRulesGroup',1,0,''),(75,62,4,NULL,'AdminTranslations',0,0,''),(76,0,4,NULL,'CONFIGURE',1,0,''),(77,76,1,NULL,'ShopParameters',1,0,'settings'),(78,77,1,NULL,'AdminParentPreferences',0,0,''),(79,78,1,NULL,'AdminPreferences',1,0,''),(80,89,2,NULL,'AdminMaintenance',1,0,''),(81,77,2,NULL,'AdminParentOrderPreferences',0,0,''),(82,81,1,NULL,'AdminOrderPreferences',1,0,''),(83,81,2,NULL,'AdminStatuses',1,0,''),(84,77,4,NULL,'AdminPPreferences',1,0,''),(85,77,5,NULL,'AdminParentCustomerPreferences',1,0,''),(86,85,1,NULL,'AdminCustomerPreferences',0,0,''),(87,85,2,NULL,'AdminGroups',1,0,''),(88,85,3,NULL,'AdminGenders',1,0,''),(89,77,3,NULL,'AdminParentStores',1,0,''),(90,89,1,NULL,'AdminContacts',1,0,''),(91,89,2,NULL,'AdminStores',1,0,''),(92,77,8,NULL,'AdminParentMeta',1,0,''),(93,92,1,NULL,'AdminMeta',1,0,''),(94,92,2,NULL,'AdminSearchEngines',0,0,''),(95,92,3,NULL,'AdminReferrers',0,0,''),(96,77,7,NULL,'AdminParentSearchConf',1,0,''),(97,96,1,NULL,'AdminSearchConf',1,0,''),(98,96,2,NULL,'AdminTags',1,0,''),(99,76,2,NULL,'AdminAdvancedParameters',1,0,'settings_applications'),(100,99,1,NULL,'AdminInformation',0,0,''),(101,99,2,NULL,'AdminPerformance',1,0,''),(102,99,3,NULL,'AdminAdminPreferences',0,0,''),(103,77,9,NULL,'AdminEmails',1,0,''),(104,99,5,NULL,'AdminImport',1,0,''),(105,77,10,NULL,'AdminParentEmployees',1,0,''),(106,105,1,NULL,'AdminEmployees',1,0,''),(107,105,2,NULL,'AdminProfiles',1,0,''),(108,105,3,NULL,'AdminAccess',0,0,''),(109,99,7,NULL,'AdminParentRequestSql',1,0,''),(110,109,1,NULL,'AdminRequestSql',1,0,''),(111,109,2,NULL,'AdminBackup',0,0,''),(112,99,8,NULL,'AdminLogs',0,0,''),(113,99,9,NULL,'AdminWebservice',1,0,''),(114,99,10,NULL,'AdminShopGroup',0,0,''),(115,99,11,NULL,'AdminShopUrl',0,0,''),(116,-1,1,NULL,'AdminQuickAccesses',1,0,''),(117,0,5,NULL,'DEFAULT',0,0,''),(118,-1,2,NULL,'AdminPatterns',1,0,''),(119,-1,3,'dashgoals','AdminDashgoals',1,0,''),(120,50,6,'ps_linklist','AdminLinkWidget',0,0,''),(121,50,1,'','AdminThemesParent',1,0,''),(122,121,2,'ps_themecusto','AdminPsThemeCustoConfiguration',1,0,''),(123,121,3,'ps_themecusto','AdminPsThemeCustoAdvanced',1,0,''),(131,-1,4,'simplicity_fbmessaging','AdminSimplicityFbMessaging',1,0,''),(132,2,7,'paypal','AdminParentPaypalConfiguration',0,0,'payment'),(133,132,1,'paypal','AdminPaypalConfiguration',0,0,''),(134,133,1,'paypal','AdminPayPalSetup',1,0,''),(135,133,2,'paypal','AdminPayPalCustomizeCheckout',1,0,''),(136,133,3,'paypal','AdminPayPalHelp',1,0,''),(137,133,4,'paypal','AdminPayPalLogs',1,0,''),(138,132,2,'paypal','AdminPaypalProcessLogger',1,0,''),(139,77,9,NULL,'AdminParentMailTheme',0,0,''),(140,139,1,NULL,'AdminMailTheme',1,0,'');
/*!40000 ALTER TABLE `ps_tab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tab_bak`
--

DROP TABLE IF EXISTS `ps_tab_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tab_bak` (
  `id_tab` int(11) NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `module` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `hide_host_mode` tinyint(1) NOT NULL,
  `icon` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_tab`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tab_bak`
--

LOCK TABLES `ps_tab_bak` WRITE;
/*!40000 ALTER TABLE `ps_tab_bak` DISABLE KEYS */;
INSERT INTO `ps_tab_bak` VALUES (1,0,1,NULL,'AdminDashboard',1,0,'trending_up'),(2,0,2,NULL,'SELL',1,0,''),(3,2,1,NULL,'AdminParentOrders',1,0,'shopping_basket'),(4,3,1,NULL,'AdminOrders',1,0,''),(5,3,2,NULL,'AdminInvoices',1,0,''),(6,3,3,NULL,'AdminSlip',1,0,''),(7,3,4,NULL,'AdminDeliverySlip',1,0,''),(8,3,5,NULL,'AdminCarts',1,0,''),(9,2,2,NULL,'AdminCatalog',1,0,'store'),(10,9,1,NULL,'AdminProducts',1,0,''),(11,9,2,NULL,'AdminCategories',1,0,''),(12,9,3,NULL,'AdminTracking',1,0,''),(13,9,4,NULL,'AdminParentAttributesGroups',1,0,''),(14,13,1,NULL,'AdminAttributesGroups',1,0,''),(15,13,2,NULL,'AdminFeatures',1,0,''),(16,9,5,NULL,'AdminParentManufacturers',1,0,''),(17,16,1,NULL,'AdminManufacturers',1,0,''),(18,16,2,NULL,'AdminSuppliers',1,0,''),(19,9,6,NULL,'AdminAttachments',1,0,''),(20,9,7,NULL,'AdminParentCartRules',1,0,''),(21,20,1,NULL,'AdminCartRules',1,0,''),(22,20,2,NULL,'AdminSpecificPriceRule',1,0,''),(23,9,8,NULL,'AdminStockManagement',1,0,''),(24,2,3,NULL,'AdminParentCustomer',1,0,'account_circle'),(25,24,1,NULL,'AdminCustomers',1,0,''),(26,24,2,NULL,'AdminAddresses',1,0,''),(27,24,3,NULL,'AdminOutstanding',0,0,''),(28,2,4,NULL,'AdminParentCustomerThreads',1,0,'chat'),(29,28,1,NULL,'AdminCustomerThreads',1,0,''),(30,28,2,NULL,'AdminOrderMessage',1,0,''),(31,28,3,NULL,'AdminReturn',1,0,''),(32,2,5,NULL,'AdminStats',1,0,'assessment'),(33,2,6,NULL,'AdminStock',1,0,'store'),(34,33,1,NULL,'AdminWarehouses',1,0,''),(35,33,2,NULL,'AdminParentStockManagement',1,0,''),(36,35,1,NULL,'AdminStockManagement',1,0,''),(37,36,1,NULL,'AdminStockMvt',1,0,''),(38,36,2,NULL,'AdminStockInstantState',1,0,''),(39,36,3,NULL,'AdminStockCover',1,0,''),(40,33,3,NULL,'AdminSupplyOrders',1,0,''),(41,33,4,NULL,'AdminStockConfiguration',1,0,''),(42,0,3,NULL,'IMPROVE',1,0,''),(43,42,1,NULL,'AdminParentModulesSf',1,0,'extension'),(44,43,1,NULL,'AdminModulesSf',1,0,''),(45,44,1,NULL,'AdminModulesManage',1,0,''),(46,44,2,NULL,'AdminModulesCatalog',1,0,''),(47,44,3,NULL,'AdminModulesNotifications',1,0,''),(48,43,2,NULL,'AdminModules',0,0,''),(49,43,3,NULL,'AdminAddonsCatalog',1,0,''),(50,42,2,NULL,'AdminParentThemes',1,0,'desktop_mac'),(51,121,1,'','AdminThemes',1,0,''),(52,50,2,NULL,'AdminThemesCatalog',1,0,''),(53,50,3,NULL,'AdminCmsContent',1,0,''),(54,50,4,NULL,'AdminModulesPositions',1,0,''),(55,50,5,NULL,'AdminImages',1,0,''),(56,42,3,NULL,'AdminParentShipping',1,0,'local_shipping'),(57,56,1,NULL,'AdminCarriers',1,0,''),(58,56,2,NULL,'AdminShipping',1,0,''),(59,42,4,NULL,'AdminParentPayment',1,0,'payment'),(60,59,1,NULL,'AdminPayment',1,0,''),(61,59,2,NULL,'AdminPaymentPreferences',1,0,''),(62,42,5,NULL,'AdminInternational',1,0,'language'),(63,62,1,NULL,'AdminParentLocalization',1,0,''),(64,63,1,NULL,'AdminLocalization',1,0,''),(65,63,2,NULL,'AdminLanguages',1,0,''),(66,63,3,NULL,'AdminCurrencies',1,0,''),(67,63,4,NULL,'AdminGeolocation',1,0,''),(68,62,2,NULL,'AdminParentCountries',1,0,''),(69,68,1,NULL,'AdminZones',1,0,''),(70,68,2,NULL,'AdminCountries',1,0,''),(71,68,3,NULL,'AdminStates',1,0,''),(72,62,3,NULL,'AdminParentTaxes',1,0,''),(73,72,1,NULL,'AdminTaxes',1,0,''),(74,72,2,NULL,'AdminTaxRulesGroup',1,0,''),(75,62,4,NULL,'AdminTranslations',1,0,''),(76,0,4,NULL,'CONFIGURE',1,0,''),(77,76,1,NULL,'ShopParameters',1,0,'settings'),(78,77,1,NULL,'AdminParentPreferences',1,0,''),(79,78,1,NULL,'AdminPreferences',1,0,''),(80,78,2,NULL,'AdminMaintenance',1,0,''),(81,77,2,NULL,'AdminParentOrderPreferences',1,0,''),(82,81,1,NULL,'AdminOrderPreferences',1,0,''),(83,81,2,NULL,'AdminStatuses',1,0,''),(84,77,3,NULL,'AdminPPreferences',1,0,''),(85,77,4,NULL,'AdminParentCustomerPreferences',1,0,''),(86,85,1,NULL,'AdminCustomerPreferences',1,0,''),(87,85,2,NULL,'AdminGroups',1,0,''),(88,85,3,NULL,'AdminGenders',1,0,''),(89,77,5,NULL,'AdminParentStores',1,0,''),(90,89,1,NULL,'AdminContacts',1,0,''),(91,89,2,NULL,'AdminStores',1,0,''),(92,77,6,NULL,'AdminParentMeta',1,0,''),(93,92,1,NULL,'AdminMeta',1,0,''),(94,92,2,NULL,'AdminSearchEngines',1,0,''),(95,92,3,NULL,'AdminReferrers',1,0,''),(96,77,7,NULL,'AdminParentSearchConf',1,0,''),(97,96,1,NULL,'AdminSearchConf',1,0,''),(98,96,2,NULL,'AdminTags',1,0,''),(99,76,2,NULL,'AdminAdvancedParameters',1,0,'settings_applications'),(100,99,1,NULL,'AdminInformation',1,0,''),(101,99,2,NULL,'AdminPerformance',1,0,''),(102,99,3,NULL,'AdminAdminPreferences',1,0,''),(103,99,4,NULL,'AdminEmails',1,0,''),(104,99,5,NULL,'AdminImport',1,0,''),(105,99,6,NULL,'AdminParentEmployees',1,0,''),(106,105,1,NULL,'AdminEmployees',1,0,''),(107,105,2,NULL,'AdminProfiles',1,0,''),(108,105,3,NULL,'AdminAccess',1,0,''),(109,99,7,NULL,'AdminParentRequestSql',1,0,''),(110,109,1,NULL,'AdminRequestSql',1,0,''),(111,109,2,NULL,'AdminBackup',1,0,''),(112,99,8,NULL,'AdminLogs',1,0,''),(113,99,9,NULL,'AdminWebservice',1,0,''),(114,99,10,NULL,'AdminShopGroup',0,0,''),(115,99,11,NULL,'AdminShopUrl',0,0,''),(116,-1,1,NULL,'AdminQuickAccesses',1,0,''),(117,0,5,NULL,'DEFAULT',1,0,''),(118,-1,2,NULL,'AdminPatterns',1,0,''),(119,-1,3,'dashgoals','AdminDashgoals',1,0,''),(120,50,6,'ps_linklist','AdminLinkWidget',1,0,''),(121,50,1,'','AdminThemesParent',1,0,''),(122,121,2,'ps_themecusto','AdminPsThemeCustoConfiguration',1,0,''),(123,121,3,'ps_themecusto','AdminPsThemeCustoAdvanced',1,0,''),(128,-1,5,'smilepay_palmboxc2cup','AdminSmilepayPalmboxc2cup',1,0,''),(129,-1,6,'smilepay_ezcatup','AdminSmilepayEzcatup',1,0,''),(130,-1,7,'smilepay_ezcat','AdminSmilepayEzcat',1,0,'');
/*!40000 ALTER TABLE `ps_tab_bak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tab_lang`
--

DROP TABLE IF EXISTS `ps_tab_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tab_lang` (
  `id_tab` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_tab`,`id_lang`),
  KEY `IDX_CFD9262DED47AB56` (`id_tab`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tab_lang`
--

LOCK TABLES `ps_tab_lang` WRITE;
/*!40000 ALTER TABLE `ps_tab_lang` DISABLE KEYS */;
INSERT INTO `ps_tab_lang` VALUES (1,1,'主控台'),(1,2,'仪表盘'),(1,3,'仪表盘'),(1,4,'仪表盘'),(2,1,'銷售'),(2,2,'出售'),(2,3,'出售'),(2,4,'出售'),(3,1,'訂單'),(3,2,'订单'),(3,3,'订单'),(3,4,'订单'),(4,1,'訂單'),(4,2,'订单'),(4,3,'订单'),(4,4,'订单'),(5,1,'發票'),(5,2,'发票'),(5,3,'发票'),(5,4,'发票'),(6,1,'貸方票據'),(6,2,'Avoirs'),(6,3,'Avoirs'),(6,4,'Avoirs'),(7,1,'送貨單'),(7,2,'交货单'),(7,3,'交货单'),(7,4,'交货单'),(8,1,'購物車記錄'),(8,2,'购物车'),(8,3,'购物车'),(8,4,'购物车'),(9,1,'商品'),(9,2,'分类'),(9,3,'分类'),(9,4,'分类'),(10,1,'商品'),(10,2,'单件商品'),(10,3,'单件商品'),(10,4,'单件商品'),(11,1,'分類'),(11,2,'分类'),(11,3,'分类'),(11,4,'分类'),(12,1,'監控'),(12,2,'监测'),(12,3,'监测'),(12,4,'监测'),(13,1,'屬性＆規格'),(13,2,'属性和功能'),(13,3,'属性和功能'),(13,4,'属性和功能'),(14,1,'屬性'),(14,2,'特征'),(14,3,'特征'),(14,4,'特征'),(15,1,'規格'),(15,2,'特性'),(15,3,'特性'),(15,4,'特性'),(16,1,'品牌&供應商'),(16,2,'品牌 & 供应商'),(16,3,'品牌 & 供应商'),(16,4,'品牌 & 供应商'),(17,1,'品牌'),(17,2,'品牌'),(17,3,'品牌'),(17,4,'品牌'),(18,1,'供應商'),(18,2,'供应商'),(18,3,'供应商'),(18,4,'供应商'),(19,1,'檔案'),(19,2,'文件'),(19,3,'文件'),(19,4,'文件'),(20,1,'折扣'),(20,2,'Discounts'),(20,3,'折扣'),(20,4,'割引'),(21,1,'折扣'),(21,2,'购物车规则'),(21,3,'购物车规则'),(21,4,'购物车规则'),(22,1,'滿件折抵規則'),(22,2,'Règles de prix catalogue'),(22,3,'Règles de prix catalogue'),(22,4,'Règles de prix catalogue'),(23,1,'庫存'),(23,2,'Stocks'),(23,3,'Stocks'),(23,4,'Stocks'),(24,1,'客戶'),(24,2,'客户'),(24,3,'客户'),(24,4,'客户'),(25,1,'客戶'),(25,2,'客户'),(25,3,'客户'),(25,4,'客户'),(26,1,'地址'),(26,2,'Addresses'),(26,3,'地址'),(26,4,'住所'),(27,1,'未付'),(27,2,'未支付'),(27,3,'未支付'),(27,4,'未支付'),(28,1,'客服'),(28,2,'客户服务'),(28,3,'客户服务'),(28,4,'客户服务'),(29,1,'客服問答'),(29,2,'客户服务'),(29,3,'客户服务'),(29,4,'客户服务'),(30,1,'預設訊息'),(30,2,'Messages prédéfinis'),(30,3,'Messages prédéfinis'),(30,4,'Messages prédéfinis'),(31,1,'退貨'),(31,2,'Retours produit'),(31,3,'Retours produit'),(31,4,'Retours produit'),(32,1,'追蹤'),(32,2,'统计信息'),(32,3,'统计信息'),(32,4,'统计信息'),(34,1,'倉庫'),(34,2,'仓库'),(34,3,'仓库'),(34,4,'仓库'),(35,1,'存貨管理'),(35,2,'Gestion de stock'),(35,3,'Gestion de stock'),(35,4,'Gestion de stock'),(36,1,'存貨管理'),(36,2,'Gestion de stock'),(36,3,'Gestion de stock'),(36,4,'Gestion de stock'),(37,1,'庫存變動'),(37,2,'库存变动'),(37,3,'库存变动'),(37,4,'库存变动'),(38,1,'即時庫存狀況'),(38,2,'Etat instantané du stock'),(38,3,'Etat instantané du stock'),(38,4,'Etat instantané du stock'),(39,1,'現貨供應情況'),(39,2,'库存范围'),(39,3,'库存范围'),(39,4,'库存范围'),(40,1,'採購訂單'),(40,2,'供应订单'),(40,3,'供应订单'),(40,4,'供应订单'),(41,1,'設定'),(41,2,'Configure'),(41,3,'配置'),(41,4,'設定'),(42,1,'佈置'),(42,2,'改进'),(42,3,'改进'),(42,4,'改进'),(43,1,'模組'),(43,2,'模块'),(43,3,'模块'),(43,4,'模块'),(44,1,'模組及服務'),(44,2,'模块和服务'),(44,3,'模块和服务'),(44,4,'模块和服务'),(45,1,'已安裝模組'),(45,2,'已安装的模块'),(45,3,'已安装的模块'),(45,4,'已安装的模块'),(46,1,'選項'),(46,2,'选择'),(46,3,'选择'),(46,4,'选择'),(47,1,'提醒'),(47,2,'通知'),(47,3,'通知'),(47,4,'通知'),(49,1,'模組目錄'),(49,2,'模块目录'),(49,3,'模块目录'),(49,4,'模块目录'),(50,1,'設計'),(50,2,'设计'),(50,3,'设计'),(50,4,'设计'),(51,1,'佈景主題'),(51,2,'Theme & Logo'),(51,3,'Theme & Logo'),(51,4,'テーマとロゴ'),(52,1,'佈景目錄'),(52,2,'主题分类'),(52,3,'主题分类'),(52,4,'主题分类'),(53,1,'自訂頁面'),(53,2,'网页'),(53,3,'网页'),(53,4,'网页'),(54,1,'模組位置'),(54,2,'Positions'),(54,3,'位置'),(54,4,'位置'),(55,1,'圖片'),(55,2,'图像设置'),(55,3,'图像设置'),(55,4,'图像设置'),(56,1,'運費'),(56,2,'配送'),(56,3,'配送'),(56,4,'配送'),(57,1,'配送方式 (運費規則)'),(57,2,'货运商'),(57,3,'货运商'),(57,4,'货运商'),(58,1,'偏好設定'),(58,2,'选项'),(58,3,'选项'),(58,4,'选项'),(59,1,'金物流'),(59,2,'付款'),(59,3,'付款'),(59,4,'付款'),(60,1,'金物流模組'),(60,2,'Payment Methods'),(60,3,'Payment Methods'),(60,4,'支払い方法'),(61,1,'偏好設定'),(61,2,'选项'),(61,3,'选项'),(61,4,'选项'),(62,1,'多國'),(62,2,'国际'),(62,3,'国际'),(62,4,'国际'),(63,1,'本地化'),(63,2,'Localization'),(63,3,'本地化'),(63,4,'地域設定'),(64,1,'本地化'),(64,2,'Localization'),(64,3,'本地化'),(64,4,'地域設定'),(65,1,'語言'),(65,2,'语言'),(65,3,'语言'),(65,4,'语言'),(66,1,'貨幣'),(66,2,'货币'),(66,3,'货币'),(66,4,'货币'),(67,1,'地理位置'),(67,2,'Geolocation'),(67,3,'地理位置'),(67,4,'位置情報'),(68,1,'地點'),(68,2,'地点'),(68,3,'地点'),(68,4,'地点'),(69,1,'區域'),(69,2,'洲'),(69,3,'洲'),(69,4,'洲'),(70,1,'國家'),(70,2,'国家'),(70,3,'国家'),(70,4,'国家'),(71,1,'州'),(71,2,'省/市'),(71,3,'省/市'),(71,4,'省/市'),(72,1,'稅'),(72,2,'税'),(72,3,'税'),(72,4,'税'),(73,1,'稅'),(73,2,'税'),(73,3,'税'),(73,4,'税'),(74,1,'稅務規則'),(74,2,'税法'),(74,3,'税法'),(74,4,'税法'),(75,1,'翻譯'),(75,2,'翻译'),(75,3,'翻译'),(75,4,'翻译'),(76,1,'更多'),(76,2,'Configure'),(76,3,'配置'),(76,4,'設定'),(77,1,'設定'),(77,2,'Shop Parameters'),(77,3,'Shop Parameters'),(77,4,'ショップパラメータ'),(78,1,'一般'),(78,2,'General'),(78,3,'一般'),(78,4,'一般'),(79,1,'一般'),(79,2,'General'),(79,3,'一般'),(79,4,'一般'),(80,1,'網站維護'),(80,2,'维护'),(80,3,'维护'),(80,4,'维护'),(81,1,'訂購設定'),(81,2,'订单设置'),(81,3,'订单设置'),(81,4,'订单设置'),(82,1,'訂購設定'),(82,2,'订单设置'),(82,3,'订单设置'),(82,4,'订单设置'),(83,1,'États'),(83,2,'状态'),(83,3,'状态'),(83,4,'状态'),(84,1,'商品'),(84,2,'单件商品'),(84,3,'单件商品'),(84,4,'单件商品'),(85,1,'客戶'),(85,2,'客户设置'),(85,3,'客户设置'),(85,4,'客户设置'),(86,1,'客戶'),(86,2,'客户'),(86,3,'客户'),(86,4,'客户'),(87,1,'群組'),(87,2,'组'),(87,3,'组'),(87,4,'组'),(88,1,'稱號'),(88,2,'Titres de civilité'),(88,3,'Titres de civilité'),(88,4,'Titres de civilité'),(89,1,'商店'),(89,2,'联系我们'),(89,3,'联系我们'),(89,4,'联系我们'),(90,1,'客服信箱'),(90,2,'联系方式'),(90,3,'联系方式'),(90,4,'联系方式'),(91,1,'詳細資訊'),(91,2,'店铺'),(91,3,'店铺'),(91,4,'店铺'),(92,1,'SEO＆Meta'),(92,2,'Traffic & SEO'),(92,3,'Traffic & SEO'),(92,4,'トラフィックとSEOの設定'),(93,1,'SEO＆Meta'),(93,2,'SEO & 链接'),(93,3,'SEO & 链接'),(93,4,'SEO & 链接'),(94,1,'搜索引擎'),(94,2,'Search Engines'),(94,3,'搜索引擎'),(94,4,'検索エンジン'),(95,1,'來源'),(95,2,'推荐'),(95,3,'推荐'),(95,4,'推荐'),(96,1,'搜尋'),(96,2,'搜索'),(96,3,'搜索'),(96,4,'搜索'),(97,1,'搜尋'),(97,2,'搜索'),(97,3,'搜索'),(97,4,'搜索'),(98,1,'標籤'),(98,2,'标签'),(98,3,'标签'),(98,4,'标签'),(99,1,'進階設定'),(99,2,'高级参数'),(99,3,'高级参数'),(99,4,'高级参数'),(100,1,'資訊'),(100,2,'信息'),(100,3,'信息'),(100,4,'信息'),(101,1,'效能'),(101,2,'性能'),(101,3,'性能'),(101,4,'性能'),(102,1,'管理'),(102,2,'行政'),(102,3,'行政'),(102,4,'行政'),(103,1,'通知信'),(103,2,'邮箱'),(103,3,'邮箱'),(103,4,'邮箱'),(104,1,'匯入'),(104,2,'上传'),(104,3,'上传'),(104,4,'上传'),(105,1,'管理者'),(105,2,'雇员'),(105,3,'雇员'),(105,4,'雇员'),(106,1,'帳號'),(106,2,'雇员'),(106,3,'雇员'),(106,4,'雇员'),(107,1,'部門'),(107,2,'职位'),(107,3,'职位'),(107,4,'职位'),(108,1,'權限'),(108,2,'权限'),(108,3,'权限'),(108,4,'权限'),(109,1,'SQL 查詢'),(109,2,'数据库'),(109,3,'数据库'),(109,4,'数据库'),(110,1,'SQL 查詢'),(110,2,'SQL Manager'),(110,3,'SQL管理器'),(110,4,'SQL マネージャ'),(111,1,'數據庫備份'),(111,2,'数据库备份'),(111,3,'数据库备份'),(111,4,'数据库备份'),(112,1,'記錄'),(112,2,'日志'),(112,3,'日志'),(112,4,'日志'),(113,1,'Webservice'),(113,2,'Web服务'),(113,3,'Web服务'),(113,4,'Web服务'),(114,1,'Multiboutique'),(114,2,'Multistore'),(114,3,'Multiboutique'),(114,4,'マルチストア'),(115,1,'Multiboutique'),(115,2,'Multistore'),(115,3,'Multiboutique'),(115,4,'マルチストア'),(116,1,'快速連結'),(116,2,'快速通道'),(116,3,'快速通道'),(116,4,'快速通道'),(117,1,'更多'),(117,2,'More'),(117,3,'更多'),(117,4,'もっと'),(119,1,'Dashgoals'),(119,2,'Dashgoals'),(119,3,'Dashgoals'),(119,4,'Dashgoals'),(120,1,'Link Widget'),(120,2,'Link Widget'),(120,3,'Link Widget'),(120,4,'Link Widget'),(121,1,'佈景'),(121,2,'Theme & Logo'),(121,3,'Theme & Logo'),(121,4,'テーマとロゴ'),(122,1,'佈景模組'),(122,2,'Homepage Configuration'),(122,3,'Homepage Configuration'),(122,4,'Homepage Configuration'),(123,1,'客製化佈景'),(123,2,'Advanced Customization'),(123,3,'Advanced Customization'),(123,4,'Advanced Customization'),(131,1,'AdminSimplicityFbMessaging'),(131,2,'AdminSimplicityFbMessaging'),(131,3,'AdminSimplicityFbMessaging'),(131,4,'AdminSimplicityFbMessaging'),(132,1,'PayPal Official'),(132,2,'PayPal Official'),(132,3,'PayPal Official'),(132,4,'PayPal Official'),(133,1,'Configuration'),(133,2,'Configuration'),(133,3,'Configuration'),(133,4,'Configuration'),(134,1,'Setup'),(134,2,'Setup'),(134,3,'Setup'),(134,4,'Setup'),(135,1,'Experience'),(135,2,'Experience'),(135,3,'Experience'),(135,4,'Experience'),(136,1,'Help'),(136,2,'Help'),(136,3,'Help'),(136,4,'Help'),(137,1,'Logs'),(137,2,'Logs'),(137,3,'Logs'),(137,4,'Logs'),(138,1,'Logger'),(138,2,'Logger'),(138,3,'Logger'),(138,4,'Logger'),(139,1,'通知信樣板'),(139,2,'通知信樣板'),(139,3,'通知信樣板'),(139,4,'通知信樣板'),(140,1,'通知信樣板'),(140,2,'通知信樣板'),(140,3,'通知信樣板'),(140,4,'通知信樣板');
/*!40000 ALTER TABLE `ps_tab_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tab_lang_bak`
--

DROP TABLE IF EXISTS `ps_tab_lang_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tab_lang_bak` (
  `id_tab` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_tab`,`id_lang`),
  KEY `IDX_CFD9262DED47AB56` (`id_tab`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tab_lang_bak`
--

LOCK TABLES `ps_tab_lang_bak` WRITE;
/*!40000 ALTER TABLE `ps_tab_lang_bak` DISABLE KEYS */;
INSERT INTO `ps_tab_lang_bak` VALUES (1,1,'控制面板'),(1,2,'仪表盘'),(1,3,'仪表盘'),(1,4,'仪表盘'),(2,1,'銷售'),(2,2,'出售'),(2,3,'出售'),(2,4,'出售'),(3,1,'訂單'),(3,2,'订单'),(3,3,'订单'),(3,4,'订单'),(4,1,'訂單'),(4,2,'订单'),(4,3,'订单'),(4,4,'订单'),(5,1,'發票'),(5,2,'发票'),(5,3,'发票'),(5,4,'发票'),(6,1,'貸方票據'),(6,2,'Avoirs'),(6,3,'Avoirs'),(6,4,'Avoirs'),(7,1,'送貨單'),(7,2,'交货单'),(7,3,'交货单'),(7,4,'交货单'),(8,1,'購物車'),(8,2,'购物车'),(8,3,'购物车'),(8,4,'购物车'),(9,1,'商品目錄'),(9,2,'分类'),(9,3,'分类'),(9,4,'分类'),(10,1,'商品'),(10,2,'单件商品'),(10,3,'单件商品'),(10,4,'单件商品'),(11,1,'分類'),(11,2,'分类'),(11,3,'分类'),(11,4,'分类'),(12,1,'監控'),(12,2,'监测'),(12,3,'监测'),(12,4,'监测'),(13,1,'規格&特點'),(13,2,'属性和功能'),(13,3,'属性和功能'),(13,4,'属性和功能'),(14,1,'屬性'),(14,2,'特征'),(14,3,'特征'),(14,4,'特征'),(15,1,'特性'),(15,2,'特性'),(15,3,'特性'),(15,4,'特性'),(16,1,'品牌&供應商'),(16,2,'品牌 & 供应商'),(16,3,'品牌 & 供应商'),(16,4,'品牌 & 供应商'),(17,1,'品牌'),(17,2,'品牌'),(17,3,'品牌'),(17,4,'品牌'),(18,1,'供應商'),(18,2,'供应商'),(18,3,'供应商'),(18,4,'供应商'),(19,1,'檔案'),(19,2,'文件'),(19,3,'文件'),(19,4,'文件'),(20,1,'折扣'),(20,2,'Discounts'),(20,3,'折扣'),(20,4,'割引'),(21,1,'購物車規則'),(21,2,'购物车规则'),(21,3,'购物车规则'),(21,4,'购物车规则'),(22,1,'滿件折抵規則'),(22,2,'Règles de prix catalogue'),(22,3,'Règles de prix catalogue'),(22,4,'Règles de prix catalogue'),(23,1,'Stocks'),(23,2,'Stocks'),(23,3,'Stocks'),(23,4,'Stocks'),(24,1,'客戶'),(24,2,'客户'),(24,3,'客户'),(24,4,'客户'),(25,1,'客戶'),(25,2,'客户'),(25,3,'客户'),(25,4,'客户'),(26,1,'地址'),(26,2,'Addresses'),(26,3,'地址'),(26,4,'住所'),(27,1,'未付'),(27,2,'未支付'),(27,3,'未支付'),(27,4,'未支付'),(28,1,'客戶服務'),(28,2,'客户服务'),(28,3,'客户服务'),(28,4,'客户服务'),(29,1,'客戶服務'),(29,2,'客户服务'),(29,3,'客户服务'),(29,4,'客户服务'),(30,1,'訂購消息'),(30,2,'Messages prédéfinis'),(30,3,'Messages prédéfinis'),(30,4,'Messages prédéfinis'),(31,1,'退貨'),(31,2,'Retours produit'),(31,3,'Retours produit'),(31,4,'Retours produit'),(32,1,'統計'),(32,2,'统计信息'),(32,3,'统计信息'),(32,4,'统计信息'),(34,1,'倉庫'),(34,2,'仓库'),(34,3,'仓库'),(34,4,'仓库'),(35,1,'存貨管理'),(35,2,'Gestion de stock'),(35,3,'Gestion de stock'),(35,4,'Gestion de stock'),(36,1,'存貨管理'),(36,2,'Gestion de stock'),(36,3,'Gestion de stock'),(36,4,'Gestion de stock'),(37,1,'庫存變動'),(37,2,'库存变动'),(37,3,'库存变动'),(37,4,'库存变动'),(38,1,'即時庫存狀況'),(38,2,'Etat instantané du stock'),(38,3,'Etat instantané du stock'),(38,4,'Etat instantané du stock'),(39,1,'現貨供應情況'),(39,2,'库存范围'),(39,3,'库存范围'),(39,4,'库存范围'),(40,1,'採購訂單'),(40,2,'供应订单'),(40,3,'供应订单'),(40,4,'供应订单'),(41,1,'設定'),(41,2,'Configure'),(41,3,'配置'),(41,4,'設定'),(42,1,'改進'),(42,2,'改进'),(42,3,'改进'),(42,4,'改进'),(43,1,'模組'),(43,2,'模块'),(43,3,'模块'),(43,4,'模块'),(44,1,'模組及服務'),(44,2,'模块和服务'),(44,3,'模块和服务'),(44,4,'模块和服务'),(45,1,'已安装的模塊'),(45,2,'已安装的模块'),(45,3,'已安装的模块'),(45,4,'已安装的模块'),(46,1,'選項'),(46,2,'选择'),(46,3,'选择'),(46,4,'选择'),(47,1,'提醒'),(47,2,'通知'),(47,3,'通知'),(47,4,'通知'),(49,1,'模組目錄'),(49,2,'模块目录'),(49,3,'模块目录'),(49,4,'模块目录'),(50,1,'設計'),(50,2,'设计'),(50,3,'设计'),(50,4,'设计'),(51,1,'佈景 ＆ Logo'),(51,2,'Theme & Logo'),(51,3,'Theme & Logo'),(51,4,'テーマとロゴ'),(52,1,'佈景目錄'),(52,2,'主题分类'),(52,3,'主题分类'),(52,4,'主题分类'),(53,1,'網頁'),(53,2,'网页'),(53,3,'网页'),(53,4,'网页'),(54,1,'位置'),(54,2,'Positions'),(54,3,'位置'),(54,4,'位置'),(55,1,'圖片配置'),(55,2,'图像设置'),(55,3,'图像设置'),(55,4,'图像设置'),(56,1,'運費'),(56,2,'配送'),(56,3,'配送'),(56,4,'配送'),(57,1,'承運商'),(57,2,'货运商'),(57,3,'货运商'),(57,4,'货运商'),(58,1,'偏好設定'),(58,2,'选项'),(58,3,'选项'),(58,4,'选项'),(59,1,'付款方式'),(59,2,'付款'),(59,3,'付款'),(59,4,'付款'),(60,1,'付款方式'),(60,2,'Payment Methods'),(60,3,'Payment Methods'),(60,4,'支払い方法'),(61,1,'偏好設定'),(61,2,'选项'),(61,3,'选项'),(61,4,'选项'),(62,1,'多國語言'),(62,2,'国际'),(62,3,'国际'),(62,4,'国际'),(63,1,'本地化'),(63,2,'Localization'),(63,3,'本地化'),(63,4,'地域設定'),(64,1,'本地化'),(64,2,'Localization'),(64,3,'本地化'),(64,4,'地域設定'),(65,1,'語言'),(65,2,'语言'),(65,3,'语言'),(65,4,'语言'),(66,1,'貨幣'),(66,2,'货币'),(66,3,'货币'),(66,4,'货币'),(67,1,'地理位置'),(67,2,'Geolocation'),(67,3,'地理位置'),(67,4,'位置情報'),(68,1,'地點'),(68,2,'地点'),(68,3,'地点'),(68,4,'地点'),(69,1,'區塊'),(69,2,'洲'),(69,3,'洲'),(69,4,'洲'),(70,1,'國家'),(70,2,'国家'),(70,3,'国家'),(70,4,'国家'),(71,1,'州'),(71,2,'省/市'),(71,3,'省/市'),(71,4,'省/市'),(72,1,'稅'),(72,2,'税'),(72,3,'税'),(72,4,'税'),(73,1,'稅'),(73,2,'税'),(73,3,'税'),(73,4,'税'),(74,1,'稅務規則'),(74,2,'税法'),(74,3,'税法'),(74,4,'税法'),(75,1,'翻譯'),(75,2,'翻译'),(75,3,'翻译'),(75,4,'翻译'),(76,1,'配置'),(76,2,'Configure'),(76,3,'配置'),(76,4,'設定'),(77,1,'商店參數'),(77,2,'Shop Parameters'),(77,3,'Shop Parameters'),(77,4,'ショップパラメータ'),(78,1,'一般'),(78,2,'General'),(78,3,'一般'),(78,4,'一般'),(79,1,'一般'),(79,2,'General'),(79,3,'一般'),(79,4,'一般'),(80,1,'網站維護'),(80,2,'维护'),(80,3,'维护'),(80,4,'维护'),(81,1,'訂購設定'),(81,2,'订单设置'),(81,3,'订单设置'),(81,4,'订单设置'),(82,1,'訂購設定'),(82,2,'订单设置'),(82,3,'订单设置'),(82,4,'订单设置'),(83,1,'États'),(83,2,'状态'),(83,3,'状态'),(83,4,'状态'),(84,1,'商品設定'),(84,2,'单件商品'),(84,3,'单件商品'),(84,4,'单件商品'),(85,1,'客戶設定'),(85,2,'客户设置'),(85,3,'客户设置'),(85,4,'客户设置'),(86,1,'客戶'),(86,2,'客户'),(86,3,'客户'),(86,4,'客户'),(87,1,'群組'),(87,2,'组'),(87,3,'组'),(87,4,'组'),(88,1,'標題'),(88,2,'Titres de civilité'),(88,3,'Titres de civilité'),(88,4,'Titres de civilité'),(89,1,'聯絡我們'),(89,2,'联系我们'),(89,3,'联系我们'),(89,4,'联系我们'),(90,1,'聯絡人'),(90,2,'联系方式'),(90,3,'联系方式'),(90,4,'联系方式'),(91,1,'商店'),(91,2,'店铺'),(91,3,'店铺'),(91,4,'店铺'),(92,1,'流量來源 ＆ SEO網址'),(92,2,'Traffic & SEO'),(92,3,'Traffic & SEO'),(92,4,'トラフィックとSEOの設定'),(93,1,'SEO & 鏈接'),(93,2,'SEO & 链接'),(93,3,'SEO & 链接'),(93,4,'SEO & 链接'),(94,1,'搜索引擎'),(94,2,'Search Engines'),(94,3,'搜索引擎'),(94,4,'検索エンジン'),(95,1,'來源'),(95,2,'推荐'),(95,3,'推荐'),(95,4,'推荐'),(96,1,'搜尋'),(96,2,'搜索'),(96,3,'搜索'),(96,4,'搜索'),(97,1,'搜尋'),(97,2,'搜索'),(97,3,'搜索'),(97,4,'搜索'),(98,1,'標籤'),(98,2,'标签'),(98,3,'标签'),(98,4,'标签'),(99,1,'進階設定'),(99,2,'高级参数'),(99,3,'高级参数'),(99,4,'高级参数'),(100,1,'資訊'),(100,2,'信息'),(100,3,'信息'),(100,4,'信息'),(101,1,'效能'),(101,2,'性能'),(101,3,'性能'),(101,4,'性能'),(102,1,'管理'),(102,2,'行政'),(102,3,'行政'),(102,4,'行政'),(103,1,'電子信箱'),(103,2,'邮箱'),(103,3,'邮箱'),(103,4,'邮箱'),(104,1,'匯入'),(104,2,'上传'),(104,3,'上传'),(104,4,'上传'),(105,1,'團隊'),(105,2,'雇员'),(105,3,'雇员'),(105,4,'雇员'),(106,1,'員工'),(106,2,'雇员'),(106,3,'雇员'),(106,4,'雇员'),(107,1,'設定檔'),(107,2,'职位'),(107,3,'职位'),(107,4,'职位'),(108,1,'權限'),(108,2,'权限'),(108,3,'权限'),(108,4,'权限'),(109,1,'資料庫'),(109,2,'数据库'),(109,3,'数据库'),(109,4,'数据库'),(110,1,'SQL管理器'),(110,2,'SQL Manager'),(110,3,'SQL管理器'),(110,4,'SQL マネージャ'),(111,1,'數據庫備份'),(111,2,'数据库备份'),(111,3,'数据库备份'),(111,4,'数据库备份'),(112,1,'記錄'),(112,2,'日志'),(112,3,'日志'),(112,4,'日志'),(113,1,'網路服務'),(113,2,'Web服务'),(113,3,'Web服务'),(113,4,'Web服务'),(114,1,'Multiboutique'),(114,2,'Multistore'),(114,3,'Multiboutique'),(114,4,'マルチストア'),(115,1,'Multiboutique'),(115,2,'Multistore'),(115,3,'Multiboutique'),(115,4,'マルチストア'),(116,1,'快速連結'),(116,2,'快速通道'),(116,3,'快速通道'),(116,4,'快速通道'),(117,1,'更多'),(117,2,'More'),(117,3,'更多'),(117,4,'もっと'),(119,1,'Dashgoals'),(119,2,'Dashgoals'),(119,3,'Dashgoals'),(119,4,'Dashgoals'),(120,1,'Link Widget'),(120,2,'Link Widget'),(120,3,'Link Widget'),(120,4,'Link Widget'),(121,1,'佈景 ＆ Logo'),(121,2,'Theme & Logo'),(121,3,'Theme & Logo'),(121,4,'テーマとロゴ'),(122,1,'Homepage Configuration'),(122,2,'Homepage Configuration'),(122,3,'Homepage Configuration'),(122,4,'Homepage Configuration'),(123,1,'Advanced Customization'),(123,2,'Advanced Customization'),(123,3,'Advanced Customization'),(123,4,'Advanced Customization'),(128,1,'Smilepaypalmboxc2cup'),(128,2,'Smilepaypalmboxc2cup'),(128,3,'Smilepaypalmboxc2cup'),(128,4,'Smilepaypalmboxc2cup'),(129,1,'SmilepayEzcatup'),(129,2,'SmilepayEzcatup'),(129,3,'SmilepayEzcatup'),(129,4,'SmilepayEzcatup'),(130,1,'SmilepayEzcat'),(130,2,'SmilepayEzcat'),(130,3,'SmilepayEzcat'),(130,4,'SmilepayEzcat');
/*!40000 ALTER TABLE `ps_tab_lang_bak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tab_module_preference`
--

DROP TABLE IF EXISTS `ps_tab_module_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tab_module_preference` (
  `id_tab_module_preference` int(11) NOT NULL AUTO_INCREMENT,
  `id_employee` int(11) NOT NULL,
  `id_tab` int(11) NOT NULL,
  `module` varchar(255) NOT NULL,
  PRIMARY KEY (`id_tab_module_preference`),
  UNIQUE KEY `employee_module` (`id_employee`,`id_tab`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tab_module_preference`
--

LOCK TABLES `ps_tab_module_preference` WRITE;
/*!40000 ALTER TABLE `ps_tab_module_preference` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_tab_module_preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tag`
--

DROP TABLE IF EXISTS `ps_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tag` (
  `id_tag` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_tag`),
  KEY `tag_name` (`name`),
  KEY `id_lang` (`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tag`
--

LOCK TABLES `ps_tag` WRITE;
/*!40000 ALTER TABLE `ps_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tag_count`
--

DROP TABLE IF EXISTS `ps_tag_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tag_count` (
  `id_group` int(10) unsigned NOT NULL DEFAULT '0',
  `id_tag` int(10) unsigned NOT NULL DEFAULT '0',
  `id_lang` int(10) unsigned NOT NULL DEFAULT '0',
  `id_shop` int(11) unsigned NOT NULL DEFAULT '0',
  `counter` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_group`,`id_tag`),
  KEY `id_group` (`id_group`,`id_lang`,`id_shop`,`counter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tag_count`
--

LOCK TABLES `ps_tag_count` WRITE;
/*!40000 ALTER TABLE `ps_tag_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_tag_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax`
--

DROP TABLE IF EXISTS `ps_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax` (
  `id_tax` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rate` decimal(10,3) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_tax`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax`
--

LOCK TABLES `ps_tax` WRITE;
/*!40000 ALTER TABLE `ps_tax` DISABLE KEYS */;
INSERT INTO `ps_tax` VALUES (1,5.000,1,0),(2,5.000,1,0),(3,4.000,1,0),(4,0.000,1,0),(5,6.600,1,0),(6,6.000,1,0),(7,8.250,1,0),(8,2.900,1,0),(9,0.000,1,0),(10,0.000,1,0),(11,6.000,1,0),(12,4.000,1,0),(13,4.000,1,0),(14,6.000,1,0),(15,6.250,1,0),(16,7.000,1,0),(17,6.000,1,0),(18,5.300,1,0),(19,6.000,1,0),(20,4.000,1,0),(21,5.000,1,0),(22,6.000,1,0),(23,6.250,1,0),(24,6.000,1,0),(25,6.875,1,0),(26,7.000,1,0),(27,4.225,1,0),(28,0.000,1,0),(29,5.500,1,0),(30,6.850,1,0),(31,0.000,1,0),(32,7.000,1,0),(33,5.125,1,0),(34,4.000,1,0),(35,5.500,1,0),(36,5.000,1,0),(37,5.500,1,0),(38,4.500,1,0),(39,0.000,1,0),(40,6.000,1,0),(41,7.000,1,0),(42,6.000,1,0),(43,4.000,1,0),(44,7.000,1,0),(45,6.250,1,0),(46,4.750,1,0),(47,6.000,1,0),(48,4.000,1,0),(49,6.500,1,0),(50,6.000,1,0),(51,5.000,1,0),(52,4.000,1,0),(53,5.500,1,0),(54,6.000,1,0);
/*!40000 ALTER TABLE `ps_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax_lang`
--

DROP TABLE IF EXISTS `ps_tax_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_lang` (
  `id_tax` int(10) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_tax`,`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax_lang`
--

LOCK TABLES `ps_tax_lang` WRITE;
/*!40000 ALTER TABLE `ps_tax_lang` DISABLE KEYS */;
INSERT INTO `ps_tax_lang` VALUES (1,1,'VAT TW 5%'),(1,2,'VAT TW 5%'),(1,3,'VAT TW 5%'),(1,4,'VAT TW 5%'),(2,1,'消費税 JP 5%'),(2,2,'消費税 JP 5%'),(2,3,'消費税 JP 5%'),(2,4,'消費税 JP 5%'),(3,1,'Sales-taxes US-AL 4%'),(3,2,'Sales-taxes US-AL 4%'),(3,3,'Sales-taxes US-AL 4%'),(3,4,'Sales-taxes US-AL 4%'),(4,1,'Sales-taxes US-AK 0%'),(4,2,'Sales-taxes US-AK 0%'),(4,3,'Sales-taxes US-AK 0%'),(4,4,'Sales-taxes US-AK 0%'),(5,1,'Sales-taxes US-AZ 6.6%'),(5,2,'Sales-taxes US-AZ 6.6%'),(5,3,'Sales-taxes US-AZ 6.6%'),(5,4,'Sales-taxes US-AZ 6.6%'),(6,1,'Sales-taxes US-AR 6%'),(6,2,'Sales-taxes US-AR 6%'),(6,3,'Sales-taxes US-AR 6%'),(6,4,'Sales-taxes US-AR 6%'),(7,1,'Sales-taxes US-CA 8.25%'),(7,2,'Sales-taxes US-CA 8.25%'),(7,3,'Sales-taxes US-CA 8.25%'),(7,4,'Sales-taxes US-CA 8.25%'),(8,1,'Sales-taxes US-CO 2.9%'),(8,2,'Sales-taxes US-CO 2.9%'),(8,3,'Sales-taxes US-CO 2.9%'),(8,4,'Sales-taxes US-CO 2.9%'),(9,1,'Sales-taxes US-CT 0%'),(9,2,'Sales-taxes US-CT 0%'),(9,3,'Sales-taxes US-CT 0%'),(9,4,'Sales-taxes US-CT 0%'),(10,1,'Sales-taxes US-DE 0%'),(10,2,'Sales-taxes US-DE 0%'),(10,3,'Sales-taxes US-DE 0%'),(10,4,'Sales-taxes US-DE 0%'),(11,1,'Sales-taxes US-FL 6%'),(11,2,'Sales-taxes US-FL 6%'),(11,3,'Sales-taxes US-FL 6%'),(11,4,'Sales-taxes US-FL 6%'),(12,1,'Sales-taxes US-GA 4%'),(12,2,'Sales-taxes US-GA 4%'),(12,3,'Sales-taxes US-GA 4%'),(12,4,'Sales-taxes US-GA 4%'),(13,1,'Sales-taxes US-HI 4%'),(13,2,'Sales-taxes US-HI 4%'),(13,3,'Sales-taxes US-HI 4%'),(13,4,'Sales-taxes US-HI 4%'),(14,1,'Sales-taxes US-ID 6%'),(14,2,'Sales-taxes US-ID 6%'),(14,3,'Sales-taxes US-ID 6%'),(14,4,'Sales-taxes US-ID 6%'),(15,1,'Sales-taxes US-IL 6.25%'),(15,2,'Sales-taxes US-IL 6.25%'),(15,3,'Sales-taxes US-IL 6.25%'),(15,4,'Sales-taxes US-IL 6.25%'),(16,1,'Sales-taxes US-IN 7%'),(16,2,'Sales-taxes US-IN 7%'),(16,3,'Sales-taxes US-IN 7%'),(16,4,'Sales-taxes US-IN 7%'),(17,1,'Sales-taxes US-IA 6%'),(17,2,'Sales-taxes US-IA 6%'),(17,3,'Sales-taxes US-IA 6%'),(17,4,'Sales-taxes US-IA 6%'),(18,1,'Sales-taxes US-KS 5.3%'),(18,2,'Sales-taxes US-KS 5.3%'),(18,3,'Sales-taxes US-KS 5.3%'),(18,4,'Sales-taxes US-KS 5.3%'),(19,1,'Sales-taxes US-KY 6%'),(19,2,'Sales-taxes US-KY 6%'),(19,3,'Sales-taxes US-KY 6%'),(19,4,'Sales-taxes US-KY 6%'),(20,1,'Sales-taxes US-LA 4%'),(20,2,'Sales-taxes US-LA 4%'),(20,3,'Sales-taxes US-LA 4%'),(20,4,'Sales-taxes US-LA 4%'),(21,1,'Sales-taxes US-ME 5%'),(21,2,'Sales-taxes US-ME 5%'),(21,3,'Sales-taxes US-ME 5%'),(21,4,'Sales-taxes US-ME 5%'),(22,1,'Sales-taxes US-MD 6%'),(22,2,'Sales-taxes US-MD 6%'),(22,3,'Sales-taxes US-MD 6%'),(22,4,'Sales-taxes US-MD 6%'),(23,1,'Sales-taxes US-MA 6.25%'),(23,2,'Sales-taxes US-MA 6.25%'),(23,3,'Sales-taxes US-MA 6.25%'),(23,4,'Sales-taxes US-MA 6.25%'),(24,1,'Sales-taxes US-MI 6%'),(24,2,'Sales-taxes US-MI 6%'),(24,3,'Sales-taxes US-MI 6%'),(24,4,'Sales-taxes US-MI 6%'),(25,1,'Sales-taxes US-MN 6.875%'),(25,2,'Sales-taxes US-MN 6.875%'),(25,3,'Sales-taxes US-MN 6.875%'),(25,4,'Sales-taxes US-MN 6.875%'),(26,1,'Sales-taxes US-MS 7%'),(26,2,'Sales-taxes US-MS 7%'),(26,3,'Sales-taxes US-MS 7%'),(26,4,'Sales-taxes US-MS 7%'),(27,1,'Sales-taxes US-MO 4.225%'),(27,2,'Sales-taxes US-MO 4.225%'),(27,3,'Sales-taxes US-MO 4.225%'),(27,4,'Sales-taxes US-MO 4.225%'),(28,1,'Sales-taxes US-MT 0.0%'),(28,2,'Sales-taxes US-MT 0.0%'),(28,3,'Sales-taxes US-MT 0.0%'),(28,4,'Sales-taxes US-MT 0.0%'),(29,1,'Sales-taxes US-NE 5.5%'),(29,2,'Sales-taxes US-NE 5.5%'),(29,3,'Sales-taxes US-NE 5.5%'),(29,4,'Sales-taxes US-NE 5.5%'),(30,1,'Sales-taxes US-NV 6.85%'),(30,2,'Sales-taxes US-NV 6.85%'),(30,3,'Sales-taxes US-NV 6.85%'),(30,4,'Sales-taxes US-NV 6.85%'),(31,1,'Sales-taxes US-NH 0%'),(31,2,'Sales-taxes US-NH 0%'),(31,3,'Sales-taxes US-NH 0%'),(31,4,'Sales-taxes US-NH 0%'),(32,1,'Sales-taxes US-NJ 7%'),(32,2,'Sales-taxes US-NJ 7%'),(32,3,'Sales-taxes US-NJ 7%'),(32,4,'Sales-taxes US-NJ 7%'),(33,1,'Sales-taxes US-NM 5.125%'),(33,2,'Sales-taxes US-NM 5.125%'),(33,3,'Sales-taxes US-NM 5.125%'),(33,4,'Sales-taxes US-NM 5.125%'),(34,1,'Sales-taxes US-NY 4%'),(34,2,'Sales-taxes US-NY 4%'),(34,3,'Sales-taxes US-NY 4%'),(34,4,'Sales-taxes US-NY 4%'),(35,1,'Sales-taxes US-NC 5.5%'),(35,2,'Sales-taxes US-NC 5.5%'),(35,3,'Sales-taxes US-NC 5.5%'),(35,4,'Sales-taxes US-NC 5.5%'),(36,1,'Sales-taxes US-ND 5%'),(36,2,'Sales-taxes US-ND 5%'),(36,3,'Sales-taxes US-ND 5%'),(36,4,'Sales-taxes US-ND 5%'),(37,1,'Sales-taxes US-OH 5.5%'),(37,2,'Sales-taxes US-OH 5.5%'),(37,3,'Sales-taxes US-OH 5.5%'),(37,4,'Sales-taxes US-OH 5.5%'),(38,1,'Sales-taxes US-OK 4.5%'),(38,2,'Sales-taxes US-OK 4.5%'),(38,3,'Sales-taxes US-OK 4.5%'),(38,4,'Sales-taxes US-OK 4.5%'),(39,1,'Sales-taxes US-OR 0%'),(39,2,'Sales-taxes US-OR 0%'),(39,3,'Sales-taxes US-OR 0%'),(39,4,'Sales-taxes US-OR 0%'),(40,1,'Sales-taxes US-PA 6%'),(40,2,'Sales-taxes US-PA 6%'),(40,3,'Sales-taxes US-PA 6%'),(40,4,'Sales-taxes US-PA 6%'),(41,1,'Sales-taxes US-RI 7%'),(41,2,'Sales-taxes US-RI 7%'),(41,3,'Sales-taxes US-RI 7%'),(41,4,'Sales-taxes US-RI 7%'),(42,1,'Sales-taxes US-SC 6%'),(42,2,'Sales-taxes US-SC 6%'),(42,3,'Sales-taxes US-SC 6%'),(42,4,'Sales-taxes US-SC 6%'),(43,1,'Sales-taxes US-SD 4%'),(43,2,'Sales-taxes US-SD 4%'),(43,3,'Sales-taxes US-SD 4%'),(43,4,'Sales-taxes US-SD 4%'),(44,1,'Sales-taxes US-TN 7%'),(44,2,'Sales-taxes US-TN 7%'),(44,3,'Sales-taxes US-TN 7%'),(44,4,'Sales-taxes US-TN 7%'),(45,1,'Sales-taxes US-TX 6.25%'),(45,2,'Sales-taxes US-TX 6.25%'),(45,3,'Sales-taxes US-TX 6.25%'),(45,4,'Sales-taxes US-TX 6.25%'),(46,1,'Sales-taxes US-UT 4.75%'),(46,2,'Sales-taxes US-UT 4.75%'),(46,3,'Sales-taxes US-UT 4.75%'),(46,4,'Sales-taxes US-UT 4.75%'),(47,1,'Sales-taxes US-VT 6%'),(47,2,'Sales-taxes US-VT 6%'),(47,3,'Sales-taxes US-VT 6%'),(47,4,'Sales-taxes US-VT 6%'),(48,1,'Sales-taxes US-VA 4%'),(48,2,'Sales-taxes US-VA 4%'),(48,3,'Sales-taxes US-VA 4%'),(48,4,'Sales-taxes US-VA 4%'),(49,1,'Sales-taxes US-WA 6.5%'),(49,2,'Sales-taxes US-WA 6.5%'),(49,3,'Sales-taxes US-WA 6.5%'),(49,4,'Sales-taxes US-WA 6.5%'),(50,1,'Sales-taxes US-WV 6%'),(50,2,'Sales-taxes US-WV 6%'),(50,3,'Sales-taxes US-WV 6%'),(50,4,'Sales-taxes US-WV 6%'),(51,1,'Sales-taxes US-WI 5%'),(51,2,'Sales-taxes US-WI 5%'),(51,3,'Sales-taxes US-WI 5%'),(51,4,'Sales-taxes US-WI 5%'),(52,1,'Sales-taxes US-WY 4%'),(52,2,'Sales-taxes US-WY 4%'),(52,3,'Sales-taxes US-WY 4%'),(52,4,'Sales-taxes US-WY 4%'),(53,1,'Sales-taxes US-PR 5.5%'),(53,2,'Sales-taxes US-PR 5.5%'),(53,3,'Sales-taxes US-PR 5.5%'),(53,4,'Sales-taxes US-PR 5.5%'),(54,1,'Sales-taxes US-DC 6%'),(54,2,'Sales-taxes US-DC 6%'),(54,3,'Sales-taxes US-DC 6%'),(54,4,'Sales-taxes US-DC 6%');
/*!40000 ALTER TABLE `ps_tax_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax_rule`
--

DROP TABLE IF EXISTS `ps_tax_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rule` (
  `id_tax_rule` int(11) NOT NULL AUTO_INCREMENT,
  `id_tax_rules_group` int(11) NOT NULL,
  `id_country` int(11) NOT NULL,
  `id_state` int(11) NOT NULL,
  `zipcode_from` varchar(12) NOT NULL,
  `zipcode_to` varchar(12) NOT NULL,
  `id_tax` int(11) NOT NULL,
  `behavior` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tax_rule`),
  KEY `id_tax_rules_group` (`id_tax_rules_group`),
  KEY `id_tax` (`id_tax`),
  KEY `category_getproducts` (`id_tax_rules_group`,`id_country`,`id_state`,`zipcode_from`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax_rule`
--

LOCK TABLES `ps_tax_rule` WRITE;
/*!40000 ALTER TABLE `ps_tax_rule` DISABLE KEYS */;
INSERT INTO `ps_tax_rule` VALUES (1,1,203,0,'0','0',1,0,''),(2,2,11,0,'0','0',2,0,''),(3,3,21,4,'0','0',3,1,''),(4,4,21,5,'0','0',4,1,''),(5,5,21,6,'0','0',5,1,''),(6,6,21,7,'0','0',6,1,''),(7,7,21,8,'0','0',7,1,''),(8,8,21,9,'0','0',8,1,''),(9,9,21,10,'0','0',9,1,''),(10,10,21,11,'0','0',10,1,''),(11,11,21,12,'0','0',11,1,''),(12,12,21,13,'0','0',12,1,''),(13,13,21,14,'0','0',13,1,''),(14,14,21,15,'0','0',14,1,''),(15,15,21,16,'0','0',15,1,''),(16,16,21,17,'0','0',16,1,''),(17,17,21,18,'0','0',17,1,''),(18,18,21,19,'0','0',18,1,''),(19,19,21,20,'0','0',19,1,''),(20,20,21,21,'0','0',20,1,''),(21,21,21,22,'0','0',21,1,''),(22,22,21,23,'0','0',22,1,''),(23,23,21,24,'0','0',23,1,''),(24,24,21,25,'0','0',24,1,''),(25,25,21,26,'0','0',25,1,''),(26,26,21,27,'0','0',26,1,''),(27,27,21,28,'0','0',27,1,''),(28,28,21,29,'0','0',28,1,''),(29,29,21,30,'0','0',29,1,''),(30,30,21,31,'0','0',30,1,''),(31,31,21,32,'0','0',31,1,''),(32,32,21,33,'0','0',32,1,''),(33,33,21,34,'0','0',33,1,''),(34,34,21,35,'0','0',34,1,''),(35,35,21,36,'0','0',35,1,''),(36,36,21,37,'0','0',36,1,''),(37,37,21,38,'0','0',37,1,''),(38,38,21,39,'0','0',38,1,''),(39,39,21,40,'0','0',39,1,''),(40,40,21,41,'0','0',40,1,''),(41,41,21,42,'0','0',41,1,''),(42,42,21,43,'0','0',42,1,''),(43,43,21,44,'0','0',43,1,''),(44,44,21,45,'0','0',44,1,''),(45,45,21,46,'0','0',45,1,''),(46,46,21,47,'0','0',46,1,''),(47,47,21,48,'0','0',47,1,''),(48,48,21,49,'0','0',48,1,''),(49,49,21,50,'0','0',49,1,''),(50,50,21,51,'0','0',50,1,''),(51,51,21,52,'0','0',51,1,''),(52,52,21,53,'0','0',52,1,''),(53,53,21,54,'0','0',53,1,''),(54,54,21,56,'0','0',54,1,'');
/*!40000 ALTER TABLE `ps_tax_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax_rules_group`
--

DROP TABLE IF EXISTS `ps_tax_rules_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rules_group` (
  `id_tax_rules_group` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `active` int(11) NOT NULL,
  `deleted` tinyint(1) unsigned NOT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_tax_rules_group`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax_rules_group`
--

LOCK TABLES `ps_tax_rules_group` WRITE;
/*!40000 ALTER TABLE `ps_tax_rules_group` DISABLE KEYS */;
INSERT INTO `ps_tax_rules_group` VALUES (1,'TW Standard Rate (5%)',1,0,'2018-07-11 11:57:38','2018-07-11 11:57:38'),(2,'JP Standard Rate (5%)',1,0,'2018-07-11 22:15:57','2018-07-11 22:15:57'),(3,'US-AL Rate (4%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(4,'US-AK Rate (0%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(5,'US-AZ Rate (6.6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(6,'US-AR Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(7,'US-CA Rate (8.25%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(8,'US-CO Rate (2.9%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(9,'US-CT Rate (0%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(10,'US-DE Rate (0%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(11,'US-FL Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(12,'US-GA Rate (4%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(13,'US-HI Rate (4%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(14,'US-ID Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(15,'US-IL Rate (6.25%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(16,'US-IN Rate (7%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(17,'US-IA Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(18,'US-KS Rate (5.3%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(19,'US-KY Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(20,'US-LA Rate (4%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(21,'US-ME Rate (5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(22,'US-MD Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(23,'US-MA Rate (6.25%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(24,'US-MI Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(25,'US-MN Rate (6.875%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(26,'US-MS Rate (7%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(27,'US-MO Rate (4.225%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(28,'US-MT Rate (0%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(29,'US-NE Rate (5.5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(30,'US-NV Rate (6.85%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(31,'US-NH Rate (0%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(32,'US-NJ Rate (7%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(33,'US-NM Rate (5.125%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(34,'US-NY Rate (4%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(35,'US-NC Rate (5.5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(36,'US-ND Rate (5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(37,'US-OH Rate (5.5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(38,'US-OK Rate (4.5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(39,'US-OR Rate (0%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(40,'US-PA Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(41,'US-RI Rate (7%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(42,'US-SC Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(43,'US-SD Rate (4%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(44,'US-TN Rate (7%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(45,'US-TX Rate (6.25%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(46,'US-UT Rate (4.75%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(47,'US-VT Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(48,'US-VA Rate (4%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(49,'US-WA Rate (6.5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(50,'US-WV Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(51,'US-WI Rate (5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(52,'US-WY Rate (4%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(53,'US-PR Rate (5.5%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12'),(54,'US-DC Rate (6%)',1,0,'2018-07-13 14:32:12','2018-07-13 14:32:12');
/*!40000 ALTER TABLE `ps_tax_rules_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tax_rules_group_shop`
--

DROP TABLE IF EXISTS `ps_tax_rules_group_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tax_rules_group_shop` (
  `id_tax_rules_group` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_tax_rules_group`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tax_rules_group_shop`
--

LOCK TABLES `ps_tax_rules_group_shop` WRITE;
/*!40000 ALTER TABLE `ps_tax_rules_group_shop` DISABLE KEYS */;
INSERT INTO `ps_tax_rules_group_shop` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1),(52,1),(53,1),(54,1);
/*!40000 ALTER TABLE `ps_tax_rules_group_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tc_cart_shipping`
--

DROP TABLE IF EXISTS `ps_tc_cart_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tc_cart_shipping` (
  `id_tc_cart_shipping` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_cart` int(10) unsigned DEFAULT NULL,
  `id_carrier` int(10) unsigned DEFAULT NULL,
  `store_type` varchar(50) DEFAULT NULL,
  `store_code` varchar(10) DEFAULT NULL,
  `store_name` varchar(255) DEFAULT NULL,
  `store_addr` varchar(255) DEFAULT NULL,
  `delivery_date` varchar(10) DEFAULT NULL COMMENT 'ecpay: 包裹預定送達日',
  `delivery_time` varchar(2) DEFAULT NULL COMMENT 'ecpay: 包裹預定送達時段',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_tc_cart_shipping`),
  KEY `id_cart_carrier` (`id_cart`,`id_carrier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tc_cart_shipping`
--

LOCK TABLES `ps_tc_cart_shipping` WRITE;
/*!40000 ALTER TABLE `ps_tc_cart_shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_tc_cart_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tc_order_payment`
--

DROP TABLE IF EXISTS `ps_tc_order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tc_order_payment` (
  `id_tc_order_payment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned DEFAULT NULL,
  `order_reference` varchar(16) DEFAULT NULL,
  `module` varchar(64) DEFAULT NULL,
  `payment_type` varchar(20) DEFAULT NULL,
  `installment` varchar(2) DEFAULT NULL,
  `return_status` varchar(50) DEFAULT NULL,
  `return_message` text,
  `expire_date` varchar(20) DEFAULT NULL,
  `atm_bank_code` varchar(3) DEFAULT NULL,
  `atm_v_account` varchar(16) DEFAULT NULL,
  `cvs_payment_no` varchar(14) DEFAULT NULL,
  `barcode_1` varchar(20) DEFAULT NULL,
  `barcode_2` varchar(20) DEFAULT NULL,
  `barcode_3` varchar(20) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_tc_order_payment`),
  KEY `order_reference` (`order_reference`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tc_order_payment`
--

LOCK TABLES `ps_tc_order_payment` WRITE;
/*!40000 ALTER TABLE `ps_tc_order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_tc_order_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_tc_order_shipping`
--

DROP TABLE IF EXISTS `ps_tc_order_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_tc_order_shipping` (
  `id_tc_order_shipping` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_order` int(10) unsigned DEFAULT NULL,
  `order_reference` varchar(16) DEFAULT NULL,
  `module` varchar(64) DEFAULT NULL,
  `send_status` varchar(50) DEFAULT NULL COMMENT 'ezship: 訂單狀態, ecpay: 物流子類型',
  `pay_type` varchar(50) DEFAULT NULL COMMENT 'ezship: 訂單類別, ecpay: 是否代收貨款',
  `store_type` varchar(50) DEFAULT NULL,
  `store_code` varchar(50) DEFAULT NULL,
  `store_name` varchar(255) DEFAULT NULL,
  `store_addr` varchar(255) DEFAULT NULL,
  `rv_name` varchar(255) DEFAULT NULL,
  `rv_mobile` varchar(32) DEFAULT NULL,
  `rv_zip` varchar(12) DEFAULT NULL,
  `rv_address` varchar(255) DEFAULT NULL,
  `distance` varchar(2) NOT NULL COMMENT 'ecpay: 宅配距離',
  `specification` varchar(4) NOT NULL COMMENT 'ecpay: 包裹規格',
  `delivery_date` varchar(10) DEFAULT NULL COMMENT 'ecpay: 包裹預定送達日',
  `delivery_time` varchar(2) NOT NULL COMMENT 'ecpay: 包裹預定送達時段',
  `sn_id` varchar(64) DEFAULT NULL COMMENT 'ezship: 店到店編號, ecpay: 物流交易編號',
  `return_status` varchar(50) DEFAULT NULL,
  `return_message` text,
  `cvs_shipping_number` varchar(50) DEFAULT NULL COMMENT 'ecpay: 寄貨編號',
  `cvs_validation_number` varchar(50) DEFAULT NULL COMMENT 'ecpay: 驗證碼',
  `home_shipping_number` varchar(50) DEFAULT NULL COMMENT 'ecpay: 托運單號',
  `change_store_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'ecpay: 更新門市通知',
  `change_store_message` text COMMENT 'ecpay: 更新門市訊息',
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  PRIMARY KEY (`id_tc_order_shipping`),
  KEY `order_reference` (`order_reference`),
  KEY `id_order` (`id_order`),
  KEY `sn_id` (`sn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_tc_order_shipping`
--

LOCK TABLES `ps_tc_order_shipping` WRITE;
/*!40000 ALTER TABLE `ps_tc_order_shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_tc_order_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_timezone`
--

DROP TABLE IF EXISTS `ps_timezone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_timezone` (
  `id_timezone` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id_timezone`)
) ENGINE=InnoDB AUTO_INCREMENT=561 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_timezone`
--

LOCK TABLES `ps_timezone` WRITE;
/*!40000 ALTER TABLE `ps_timezone` DISABLE KEYS */;
INSERT INTO `ps_timezone` VALUES (1,'Africa/Abidjan'),(2,'Africa/Accra'),(3,'Africa/Addis_Ababa'),(4,'Africa/Algiers'),(5,'Africa/Asmara'),(6,'Africa/Asmera'),(7,'Africa/Bamako'),(8,'Africa/Bangui'),(9,'Africa/Banjul'),(10,'Africa/Bissau'),(11,'Africa/Blantyre'),(12,'Africa/Brazzaville'),(13,'Africa/Bujumbura'),(14,'Africa/Cairo'),(15,'Africa/Casablanca'),(16,'Africa/Ceuta'),(17,'Africa/Conakry'),(18,'Africa/Dakar'),(19,'Africa/Dar_es_Salaam'),(20,'Africa/Djibouti'),(21,'Africa/Douala'),(22,'Africa/El_Aaiun'),(23,'Africa/Freetown'),(24,'Africa/Gaborone'),(25,'Africa/Harare'),(26,'Africa/Johannesburg'),(27,'Africa/Kampala'),(28,'Africa/Khartoum'),(29,'Africa/Kigali'),(30,'Africa/Kinshasa'),(31,'Africa/Lagos'),(32,'Africa/Libreville'),(33,'Africa/Lome'),(34,'Africa/Luanda'),(35,'Africa/Lubumbashi'),(36,'Africa/Lusaka'),(37,'Africa/Malabo'),(38,'Africa/Maputo'),(39,'Africa/Maseru'),(40,'Africa/Mbabane'),(41,'Africa/Mogadishu'),(42,'Africa/Monrovia'),(43,'Africa/Nairobi'),(44,'Africa/Ndjamena'),(45,'Africa/Niamey'),(46,'Africa/Nouakchott'),(47,'Africa/Ouagadougou'),(48,'Africa/Porto-Novo'),(49,'Africa/Sao_Tome'),(50,'Africa/Timbuktu'),(51,'Africa/Tripoli'),(52,'Africa/Tunis'),(53,'Africa/Windhoek'),(54,'America/Adak'),(55,'America/Anchorage '),(56,'America/Anguilla'),(57,'America/Antigua'),(58,'America/Araguaina'),(59,'America/Argentina/Buenos_Aires'),(60,'America/Argentina/Catamarca'),(61,'America/Argentina/ComodRivadavia'),(62,'America/Argentina/Cordoba'),(63,'America/Argentina/Jujuy'),(64,'America/Argentina/La_Rioja'),(65,'America/Argentina/Mendoza'),(66,'America/Argentina/Rio_Gallegos'),(67,'America/Argentina/Salta'),(68,'America/Argentina/San_Juan'),(69,'America/Argentina/San_Luis'),(70,'America/Argentina/Tucuman'),(71,'America/Argentina/Ushuaia'),(72,'America/Aruba'),(73,'America/Asuncion'),(74,'America/Atikokan'),(75,'America/Atka'),(76,'America/Bahia'),(77,'America/Barbados'),(78,'America/Belem'),(79,'America/Belize'),(80,'America/Blanc-Sablon'),(81,'America/Boa_Vista'),(82,'America/Bogota'),(83,'America/Boise'),(84,'America/Buenos_Aires'),(85,'America/Cambridge_Bay'),(86,'America/Campo_Grande'),(87,'America/Cancun'),(88,'America/Caracas'),(89,'America/Catamarca'),(90,'America/Cayenne'),(91,'America/Cayman'),(92,'America/Chicago'),(93,'America/Chihuahua'),(94,'America/Coral_Harbour'),(95,'America/Cordoba'),(96,'America/Costa_Rica'),(97,'America/Cuiaba'),(98,'America/Curacao'),(99,'America/Danmarkshavn'),(100,'America/Dawson'),(101,'America/Dawson_Creek'),(102,'America/Denver'),(103,'America/Detroit'),(104,'America/Dominica'),(105,'America/Edmonton'),(106,'America/Eirunepe'),(107,'America/El_Salvador'),(108,'America/Ensenada'),(109,'America/Fort_Wayne'),(110,'America/Fortaleza'),(111,'America/Glace_Bay'),(112,'America/Godthab'),(113,'America/Goose_Bay'),(114,'America/Grand_Turk'),(115,'America/Grenada'),(116,'America/Guadeloupe'),(117,'America/Guatemala'),(118,'America/Guayaquil'),(119,'America/Guyana'),(120,'America/Halifax'),(121,'America/Havana'),(122,'America/Hermosillo'),(123,'America/Indiana/Indianapolis'),(124,'America/Indiana/Knox'),(125,'America/Indiana/Marengo'),(126,'America/Indiana/Petersburg'),(127,'America/Indiana/Tell_City'),(128,'America/Indiana/Vevay'),(129,'America/Indiana/Vincennes'),(130,'America/Indiana/Winamac'),(131,'America/Indianapolis'),(132,'America/Inuvik'),(133,'America/Iqaluit'),(134,'America/Jamaica'),(135,'America/Jujuy'),(136,'America/Juneau'),(137,'America/Kentucky/Louisville'),(138,'America/Kentucky/Monticello'),(139,'America/Knox_IN'),(140,'America/La_Paz'),(141,'America/Lima'),(142,'America/Los_Angeles'),(143,'America/Louisville'),(144,'America/Maceio'),(145,'America/Managua'),(146,'America/Manaus'),(147,'America/Marigot'),(148,'America/Martinique'),(149,'America/Mazatlan'),(150,'America/Mendoza'),(151,'America/Menominee'),(152,'America/Merida'),(153,'America/Mexico_City'),(154,'America/Miquelon'),(155,'America/Moncton'),(156,'America/Monterrey'),(157,'America/Montevideo'),(158,'America/Montreal'),(159,'America/Montserrat'),(160,'America/Nassau'),(161,'America/New_York'),(162,'America/Nipigon'),(163,'America/Nome'),(164,'America/Noronha'),(165,'America/North_Dakota/Center'),(166,'America/North_Dakota/New_Salem'),(167,'America/Panama'),(168,'America/Pangnirtung'),(169,'America/Paramaribo'),(170,'America/Phoenix'),(171,'America/Port-au-Prince'),(172,'America/Port_of_Spain'),(173,'America/Porto_Acre'),(174,'America/Porto_Velho'),(175,'America/Puerto_Rico'),(176,'America/Rainy_River'),(177,'America/Rankin_Inlet'),(178,'America/Recife'),(179,'America/Regina'),(180,'America/Resolute'),(181,'America/Rio_Branco'),(182,'America/Rosario'),(183,'America/Santarem'),(184,'America/Santiago'),(185,'America/Santo_Domingo'),(186,'America/Sao_Paulo'),(187,'America/Scoresbysund'),(188,'America/Shiprock'),(189,'America/St_Barthelemy'),(190,'America/St_Johns'),(191,'America/St_Kitts'),(192,'America/St_Lucia'),(193,'America/St_Thomas'),(194,'America/St_Vincent'),(195,'America/Swift_Current'),(196,'America/Tegucigalpa'),(197,'America/Thule'),(198,'America/Thunder_Bay'),(199,'America/Tijuana'),(200,'America/Toronto'),(201,'America/Tortola'),(202,'America/Vancouver'),(203,'America/Virgin'),(204,'America/Whitehorse'),(205,'America/Winnipeg'),(206,'America/Yakutat'),(207,'America/Yellowknife'),(208,'Antarctica/Casey'),(209,'Antarctica/Davis'),(210,'Antarctica/DumontDUrville'),(211,'Antarctica/Mawson'),(212,'Antarctica/McMurdo'),(213,'Antarctica/Palmer'),(214,'Antarctica/Rothera'),(215,'Antarctica/South_Pole'),(216,'Antarctica/Syowa'),(217,'Antarctica/Vostok'),(218,'Arctic/Longyearbyen'),(219,'Asia/Aden'),(220,'Asia/Almaty'),(221,'Asia/Amman'),(222,'Asia/Anadyr'),(223,'Asia/Aqtau'),(224,'Asia/Aqtobe'),(225,'Asia/Ashgabat'),(226,'Asia/Ashkhabad'),(227,'Asia/Baghdad'),(228,'Asia/Bahrain'),(229,'Asia/Baku'),(230,'Asia/Bangkok'),(231,'Asia/Beirut'),(232,'Asia/Bishkek'),(233,'Asia/Brunei'),(234,'Asia/Calcutta'),(235,'Asia/Choibalsan'),(236,'Asia/Chongqing'),(237,'Asia/Chungking'),(238,'Asia/Colombo'),(239,'Asia/Dacca'),(240,'Asia/Damascus'),(241,'Asia/Dhaka'),(242,'Asia/Dili'),(243,'Asia/Dubai'),(244,'Asia/Dushanbe'),(245,'Asia/Gaza'),(246,'Asia/Harbin'),(247,'Asia/Ho_Chi_Minh'),(248,'Asia/Hong_Kong'),(249,'Asia/Hovd'),(250,'Asia/Irkutsk'),(251,'Asia/Istanbul'),(252,'Asia/Jakarta'),(253,'Asia/Jayapura'),(254,'Asia/Jerusalem'),(255,'Asia/Kabul'),(256,'Asia/Kamchatka'),(257,'Asia/Karachi'),(258,'Asia/Kashgar'),(259,'Asia/Kathmandu'),(260,'Asia/Katmandu'),(261,'Asia/Kolkata'),(262,'Asia/Krasnoyarsk'),(263,'Asia/Kuala_Lumpur'),(264,'Asia/Kuching'),(265,'Asia/Kuwait'),(266,'Asia/Macao'),(267,'Asia/Macau'),(268,'Asia/Magadan'),(269,'Asia/Makassar'),(270,'Asia/Manila'),(271,'Asia/Muscat'),(272,'Asia/Nicosia'),(273,'Asia/Novosibirsk'),(274,'Asia/Omsk'),(275,'Asia/Oral'),(276,'Asia/Phnom_Penh'),(277,'Asia/Pontianak'),(278,'Asia/Pyongyang'),(279,'Asia/Qatar'),(280,'Asia/Qyzylorda'),(281,'Asia/Rangoon'),(282,'Asia/Riyadh'),(283,'Asia/Saigon'),(284,'Asia/Sakhalin'),(285,'Asia/Samarkand'),(286,'Asia/Seoul'),(287,'Asia/Shanghai'),(288,'Asia/Singapore'),(289,'Asia/Taipei'),(290,'Asia/Tashkent'),(291,'Asia/Tbilisi'),(292,'Asia/Tehran'),(293,'Asia/Tel_Aviv'),(294,'Asia/Thimbu'),(295,'Asia/Thimphu'),(296,'Asia/Tokyo'),(297,'Asia/Ujung_Pandang'),(298,'Asia/Ulaanbaatar'),(299,'Asia/Ulan_Bator'),(300,'Asia/Urumqi'),(301,'Asia/Vientiane'),(302,'Asia/Vladivostok'),(303,'Asia/Yakutsk'),(304,'Asia/Yekaterinburg'),(305,'Asia/Yerevan'),(306,'Atlantic/Azores'),(307,'Atlantic/Bermuda'),(308,'Atlantic/Canary'),(309,'Atlantic/Cape_Verde'),(310,'Atlantic/Faeroe'),(311,'Atlantic/Faroe'),(312,'Atlantic/Jan_Mayen'),(313,'Atlantic/Madeira'),(314,'Atlantic/Reykjavik'),(315,'Atlantic/South_Georgia'),(316,'Atlantic/St_Helena'),(317,'Atlantic/Stanley'),(318,'Australia/ACT'),(319,'Australia/Adelaide'),(320,'Australia/Brisbane'),(321,'Australia/Broken_Hill'),(322,'Australia/Canberra'),(323,'Australia/Currie'),(324,'Australia/Darwin'),(325,'Australia/Eucla'),(326,'Australia/Hobart'),(327,'Australia/LHI'),(328,'Australia/Lindeman'),(329,'Australia/Lord_Howe'),(330,'Australia/Melbourne'),(331,'Australia/North'),(332,'Australia/NSW'),(333,'Australia/Perth'),(334,'Australia/Queensland'),(335,'Australia/South'),(336,'Australia/Sydney'),(337,'Australia/Tasmania'),(338,'Australia/Victoria'),(339,'Australia/West'),(340,'Australia/Yancowinna'),(341,'Europe/Amsterdam'),(342,'Europe/Andorra'),(343,'Europe/Athens'),(344,'Europe/Belfast'),(345,'Europe/Belgrade'),(346,'Europe/Berlin'),(347,'Europe/Bratislava'),(348,'Europe/Brussels'),(349,'Europe/Bucharest'),(350,'Europe/Budapest'),(351,'Europe/Chisinau'),(352,'Europe/Copenhagen'),(353,'Europe/Dublin'),(354,'Europe/Gibraltar'),(355,'Europe/Guernsey'),(356,'Europe/Helsinki'),(357,'Europe/Isle_of_Man'),(358,'Europe/Istanbul'),(359,'Europe/Jersey'),(360,'Europe/Kaliningrad'),(361,'Europe/Kiev'),(362,'Europe/Lisbon'),(363,'Europe/Ljubljana'),(364,'Europe/London'),(365,'Europe/Luxembourg'),(366,'Europe/Madrid'),(367,'Europe/Malta'),(368,'Europe/Mariehamn'),(369,'Europe/Minsk'),(370,'Europe/Monaco'),(371,'Europe/Moscow'),(372,'Europe/Nicosia'),(373,'Europe/Oslo'),(374,'Europe/Paris'),(375,'Europe/Podgorica'),(376,'Europe/Prague'),(377,'Europe/Riga'),(378,'Europe/Rome'),(379,'Europe/Samara'),(380,'Europe/San_Marino'),(381,'Europe/Sarajevo'),(382,'Europe/Simferopol'),(383,'Europe/Skopje'),(384,'Europe/Sofia'),(385,'Europe/Stockholm'),(386,'Europe/Tallinn'),(387,'Europe/Tirane'),(388,'Europe/Tiraspol'),(389,'Europe/Uzhgorod'),(390,'Europe/Vaduz'),(391,'Europe/Vatican'),(392,'Europe/Vienna'),(393,'Europe/Vilnius'),(394,'Europe/Volgograd'),(395,'Europe/Warsaw'),(396,'Europe/Zagreb'),(397,'Europe/Zaporozhye'),(398,'Europe/Zurich'),(399,'Indian/Antananarivo'),(400,'Indian/Chagos'),(401,'Indian/Christmas'),(402,'Indian/Cocos'),(403,'Indian/Comoro'),(404,'Indian/Kerguelen'),(405,'Indian/Mahe'),(406,'Indian/Maldives'),(407,'Indian/Mauritius'),(408,'Indian/Mayotte'),(409,'Indian/Reunion'),(410,'Pacific/Apia'),(411,'Pacific/Auckland'),(412,'Pacific/Chatham'),(413,'Pacific/Easter'),(414,'Pacific/Efate'),(415,'Pacific/Enderbury'),(416,'Pacific/Fakaofo'),(417,'Pacific/Fiji'),(418,'Pacific/Funafuti'),(419,'Pacific/Galapagos'),(420,'Pacific/Gambier'),(421,'Pacific/Guadalcanal'),(422,'Pacific/Guam'),(423,'Pacific/Honolulu'),(424,'Pacific/Johnston'),(425,'Pacific/Kiritimati'),(426,'Pacific/Kosrae'),(427,'Pacific/Kwajalein'),(428,'Pacific/Majuro'),(429,'Pacific/Marquesas'),(430,'Pacific/Midway'),(431,'Pacific/Nauru'),(432,'Pacific/Niue'),(433,'Pacific/Norfolk'),(434,'Pacific/Noumea'),(435,'Pacific/Pago_Pago'),(436,'Pacific/Palau'),(437,'Pacific/Pitcairn'),(438,'Pacific/Ponape'),(439,'Pacific/Port_Moresby'),(440,'Pacific/Rarotonga'),(441,'Pacific/Saipan'),(442,'Pacific/Samoa'),(443,'Pacific/Tahiti'),(444,'Pacific/Tarawa'),(445,'Pacific/Tongatapu'),(446,'Pacific/Truk'),(447,'Pacific/Wake'),(448,'Pacific/Wallis'),(449,'Pacific/Yap'),(450,'Brazil/Acre'),(451,'Brazil/DeNoronha'),(452,'Brazil/East'),(453,'Brazil/West'),(454,'Canada/Atlantic'),(455,'Canada/Central'),(456,'Canada/East-Saskatchewan'),(457,'Canada/Eastern'),(458,'Canada/Mountain'),(459,'Canada/Newfoundland'),(460,'Canada/Pacific'),(461,'Canada/Saskatchewan'),(462,'Canada/Yukon'),(463,'CET'),(464,'Chile/Continental'),(465,'Chile/EasterIsland'),(466,'CST6CDT'),(467,'Cuba'),(468,'EET'),(469,'Egypt'),(470,'Eire'),(471,'EST'),(472,'EST5EDT'),(473,'Etc/GMT'),(474,'Etc/GMT+0'),(475,'Etc/GMT+1'),(476,'Etc/GMT+10'),(477,'Etc/GMT+11'),(478,'Etc/GMT+12'),(479,'Etc/GMT+2'),(480,'Etc/GMT+3'),(481,'Etc/GMT+4'),(482,'Etc/GMT+5'),(483,'Etc/GMT+6'),(484,'Etc/GMT+7'),(485,'Etc/GMT+8'),(486,'Etc/GMT+9'),(487,'Etc/GMT-0'),(488,'Etc/GMT-1'),(489,'Etc/GMT-10'),(490,'Etc/GMT-11'),(491,'Etc/GMT-12'),(492,'Etc/GMT-13'),(493,'Etc/GMT-14'),(494,'Etc/GMT-2'),(495,'Etc/GMT-3'),(496,'Etc/GMT-4'),(497,'Etc/GMT-5'),(498,'Etc/GMT-6'),(499,'Etc/GMT-7'),(500,'Etc/GMT-8'),(501,'Etc/GMT-9'),(502,'Etc/GMT0'),(503,'Etc/Greenwich'),(504,'Etc/UCT'),(505,'Etc/Universal'),(506,'Etc/UTC'),(507,'Etc/Zulu'),(508,'Factory'),(509,'GB'),(510,'GB-Eire'),(511,'GMT'),(512,'GMT+0'),(513,'GMT-0'),(514,'GMT0'),(515,'Greenwich'),(516,'Hongkong'),(517,'HST'),(518,'Iceland'),(519,'Iran'),(520,'Israel'),(521,'Jamaica'),(522,'Japan'),(523,'Kwajalein'),(524,'Libya'),(525,'MET'),(526,'Mexico/BajaNorte'),(527,'Mexico/BajaSur'),(528,'Mexico/General'),(529,'MST'),(530,'MST7MDT'),(531,'Navajo'),(532,'NZ'),(533,'NZ-CHAT'),(534,'Poland'),(535,'Portugal'),(536,'PRC'),(537,'PST8PDT'),(538,'ROC'),(539,'ROK'),(540,'Singapore'),(541,'Turkey'),(542,'UCT'),(543,'Universal'),(544,'US/Alaska'),(545,'US/Aleutian'),(546,'US/Arizona'),(547,'US/Central'),(548,'US/East-Indiana'),(549,'US/Eastern'),(550,'US/Hawaii'),(551,'US/Indiana-Starke'),(552,'US/Michigan'),(553,'US/Mountain'),(554,'US/Pacific'),(555,'US/Pacific-New'),(556,'US/Samoa'),(557,'UTC'),(558,'W-SU'),(559,'WET'),(560,'Zulu');
/*!40000 ALTER TABLE `ps_timezone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_translation`
--

DROP TABLE IF EXISTS `ps_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_translation` (
  `id_translation` int(11) NOT NULL AUTO_INCREMENT,
  `id_lang` int(11) NOT NULL,
  `key` text COLLATE utf8_unicode_ci NOT NULL,
  `translation` text COLLATE utf8_unicode_ci NOT NULL,
  `domain` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `theme` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_translation`),
  KEY `IDX_ADEBEB36BA299860` (`id_lang`),
  KEY `key` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_translation`
--

LOCK TABLES `ps_translation` WRITE;
/*!40000 ALTER TABLE `ps_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_warehouse`
--

DROP TABLE IF EXISTS `ps_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_warehouse` (
  `id_warehouse` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_currency` int(11) unsigned NOT NULL,
  `id_address` int(11) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `reference` varchar(64) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `management_type` enum('WA','FIFO','LIFO') NOT NULL DEFAULT 'WA',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_warehouse`
--

LOCK TABLES `ps_warehouse` WRITE;
/*!40000 ALTER TABLE `ps_warehouse` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_warehouse_carrier`
--

DROP TABLE IF EXISTS `ps_warehouse_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_warehouse_carrier` (
  `id_carrier` int(11) unsigned NOT NULL,
  `id_warehouse` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_warehouse`,`id_carrier`),
  KEY `id_warehouse` (`id_warehouse`),
  KEY `id_carrier` (`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_warehouse_carrier`
--

LOCK TABLES `ps_warehouse_carrier` WRITE;
/*!40000 ALTER TABLE `ps_warehouse_carrier` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_warehouse_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_warehouse_product_location`
--

DROP TABLE IF EXISTS `ps_warehouse_product_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_warehouse_product_location` (
  `id_warehouse_product_location` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_product` int(11) unsigned NOT NULL,
  `id_product_attribute` int(11) unsigned NOT NULL,
  `id_warehouse` int(11) unsigned NOT NULL,
  `location` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_warehouse_product_location`),
  UNIQUE KEY `id_product` (`id_product`,`id_product_attribute`,`id_warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_warehouse_product_location`
--

LOCK TABLES `ps_warehouse_product_location` WRITE;
/*!40000 ALTER TABLE `ps_warehouse_product_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_warehouse_product_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_warehouse_shop`
--

DROP TABLE IF EXISTS `ps_warehouse_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_warehouse_shop` (
  `id_shop` int(11) unsigned NOT NULL,
  `id_warehouse` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_warehouse`,`id_shop`),
  KEY `id_warehouse` (`id_warehouse`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_warehouse_shop`
--

LOCK TABLES `ps_warehouse_shop` WRITE;
/*!40000 ALTER TABLE `ps_warehouse_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_warehouse_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_web_browser`
--

DROP TABLE IF EXISTS `ps_web_browser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_web_browser` (
  `id_web_browser` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_web_browser`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_web_browser`
--

LOCK TABLES `ps_web_browser` WRITE;
/*!40000 ALTER TABLE `ps_web_browser` DISABLE KEYS */;
INSERT INTO `ps_web_browser` VALUES (1,'Safari'),(2,'Safari iPad'),(3,'Firefox'),(4,'Opera'),(5,'IE 6'),(6,'IE 7'),(7,'IE 8'),(8,'IE 9'),(9,'IE 10'),(10,'IE 11'),(11,'Chrome');
/*!40000 ALTER TABLE `ps_web_browser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_webservice_account`
--

DROP TABLE IF EXISTS `ps_webservice_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_webservice_account` (
  `id_webservice_account` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(32) NOT NULL,
  `description` text,
  `class_name` varchar(50) NOT NULL DEFAULT 'WebserviceRequest',
  `is_module` tinyint(2) NOT NULL DEFAULT '0',
  `module_name` varchar(50) DEFAULT NULL,
  `active` tinyint(2) NOT NULL,
  PRIMARY KEY (`id_webservice_account`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_webservice_account`
--

LOCK TABLES `ps_webservice_account` WRITE;
/*!40000 ALTER TABLE `ps_webservice_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_webservice_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_webservice_account_shop`
--

DROP TABLE IF EXISTS `ps_webservice_account_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_webservice_account_shop` (
  `id_webservice_account` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_webservice_account`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_webservice_account_shop`
--

LOCK TABLES `ps_webservice_account_shop` WRITE;
/*!40000 ALTER TABLE `ps_webservice_account_shop` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_webservice_account_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_webservice_permission`
--

DROP TABLE IF EXISTS `ps_webservice_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_webservice_permission` (
  `id_webservice_permission` int(11) NOT NULL AUTO_INCREMENT,
  `resource` varchar(50) NOT NULL,
  `method` enum('GET','POST','PUT','DELETE','HEAD') NOT NULL,
  `id_webservice_account` int(11) NOT NULL,
  PRIMARY KEY (`id_webservice_permission`),
  UNIQUE KEY `resource_2` (`resource`,`method`,`id_webservice_account`),
  KEY `resource` (`resource`),
  KEY `method` (`method`),
  KEY `id_webservice_account` (`id_webservice_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_webservice_permission`
--

LOCK TABLES `ps_webservice_permission` WRITE;
/*!40000 ALTER TABLE `ps_webservice_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `ps_webservice_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_zone`
--

DROP TABLE IF EXISTS `ps_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_zone` (
  `id_zone` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_zone`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_zone`
--

LOCK TABLES `ps_zone` WRITE;
/*!40000 ALTER TABLE `ps_zone` DISABLE KEYS */;
INSERT INTO `ps_zone` VALUES (1,'Europe',0),(2,'North America',1),(3,'Asia',1),(4,'Africa',0),(5,'Oceania',0),(6,'South America',0),(7,'Europe (non-EU)',0),(8,'Central America/Antilla',0),(9,'台灣',1),(10,'日本',1),(11,'中國',1),(12,'* 超商',1);
/*!40000 ALTER TABLE `ps_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_zone_shop`
--

DROP TABLE IF EXISTS `ps_zone_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_zone_shop` (
  `id_zone` int(11) unsigned NOT NULL,
  `id_shop` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id_zone`,`id_shop`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_zone_shop`
--

LOCK TABLES `ps_zone_shop` WRITE;
/*!40000 ALTER TABLE `ps_zone_shop` DISABLE KEYS */;
INSERT INTO `ps_zone_shop` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),(11,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),(11,3),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(8,4),(9,4),(10,4),(11,4);
/*!40000 ALTER TABLE `ps_zone_shop` ENABLE KEYS */;
UNLOCK TABLES;
/*!50112 SET @disable_bulk_load = IF (@is_rocksdb_supported, 'SET SESSION rocksdb_bulk_load = @old_rocksdb_bulk_load', 'SET @dummy_rocksdb_bulk_load = 0') */;
/*!50112 PREPARE s FROM @disable_bulk_load */;
/*!50112 EXECUTE s */;
/*!50112 DEALLOCATE PREPARE s */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-20  9:03:13
