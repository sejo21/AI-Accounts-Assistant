-- MySQL dump 10.13  Distrib 5.7.35, for Win64 (x86_64)
--
-- Host: localhost    Database: televet
-- ------------------------------------------------------
-- Server version	5.7.35-log

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
-- Current Database: `televet`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `televet` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `televet`;

--
-- Table structure for table `abbreviations`
--

DROP TABLE IF EXISTS `abbreviations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abbreviations` (
  `Abbreviation` varchar(5) NOT NULL,
  `Full_text` varchar(3000) DEFAULT NULL,
  `Practitioner_ID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Abbreviation`),
  UNIQUE KEY `Abbreviation` (`Abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_restriction`
--

DROP TABLE IF EXISTS `access_restriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_restriction` (
  `Access_restriction_ID` int(10) NOT NULL AUTO_INCREMENT,
  `User_class_ID` int(10) DEFAULT NULL,
  `Program_to_restrict` varchar(6) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Access_restriction_ID`),
  KEY `Access_restriction_ID` (`Access_restriction_ID`) USING BTREE,
  KEY `Program_to_restrict` (`Program_to_restrict`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2137888894 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts_category`
--

DROP TABLE IF EXISTS `accounts_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_category` (
  `Accounts_category_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Accounts_category_number` varchar(3) DEFAULT NULL,
  `Accounts_category_text` varchar(30) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Accounts_category_ID`),
  UNIQUE KEY `Accounts_category_number` (`Accounts_category_number`)
) ENGINE=InnoDB AUTO_INCREMENT=659 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agriabreedlist`
--

DROP TABLE IF EXISTS `agriabreedlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agriabreedlist` (
  `AgriaBreedListID` int(11) NOT NULL AUTO_INCREMENT,
  `BreedName` varchar(255) DEFAULT NULL,
  `Species` varchar(255) DEFAULT NULL,
  `AgriaBreedID` int(11) DEFAULT NULL,
  PRIMARY KEY (`AgriaBreedListID`)
) ENGINE=InnoDB AUTO_INCREMENT=1422 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agriafreecover`
--

DROP TABLE IF EXISTS `agriafreecover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agriafreecover` (
  `AgriaFreeCoverID` int(11) NOT NULL AUTO_INCREMENT,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `CanOfferInsurance` tinyint(1) DEFAULT NULL,
  `CanOfferInsuranceReportedErrors` varchar(5000) DEFAULT NULL,
  `DateChecked` datetime DEFAULT NULL,
  `RemindNextTime` tinyint(1) DEFAULT NULL,
  `CreatePolicyIsSuccess` tinyint(1) DEFAULT NULL,
  `CreatePolicyReportedErrors` varchar(5000) DEFAULT NULL,
  `DatePolicyCreated` datetime DEFAULT NULL,
  `CoverNote` varchar(255) DEFAULT NULL,
  `PromptCounter` int(11) DEFAULT '0',
  PRIMARY KEY (`AgriaFreeCoverID`),
  UNIQUE KEY `AnimalID` (`AnimalID`)
) ENGINE=InnoDB AUTO_INCREMENT=129252 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal` (
  `Animal_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Species` varchar(20) DEFAULT NULL,
  `Breed` varchar(255) DEFAULT NULL,
  `Colour` varchar(30) DEFAULT NULL,
  `Markings` varchar(20) DEFAULT NULL,
  `Sex` varchar(1) DEFAULT NULL,
  `Neutered` tinyint(1) NOT NULL DEFAULT '0',
  `Date_of_birth` datetime DEFAULT NULL,
  `Height` decimal(10,3) DEFAULT NULL,
  `Weight` decimal(10,3) DEFAULT NULL,
  `Insurance_Co` varchar(20) DEFAULT NULL,
  `Insurance_policy_number` varchar(20) DEFAULT NULL,
  `Identity_number` varchar(20) DEFAULT NULL,
  `Operation_ID` int(10) DEFAULT NULL,
  `Overnight_charge` decimal(19,4) DEFAULT NULL,
  `Notes` varchar(5000) DEFAULT NULL,
  `Sensitive_notes` varchar(5000) DEFAULT NULL,
  `Warning_or_status_1` varchar(20) DEFAULT NULL,
  `Warning_or_status_2` varchar(20) DEFAULT NULL,
  `Warning_or_status_3` varchar(20) DEFAULT NULL,
  `Other_1` varchar(20) DEFAULT NULL,
  `Other_2` varchar(20) DEFAULT NULL,
  `Other_3` varchar(20) DEFAULT NULL,
  `Other_4` varchar(20) DEFAULT NULL,
  `Other_5` varchar(20) DEFAULT NULL,
  `Insurance_expiry_date` datetime DEFAULT NULL,
  `Inpatient` tinyint(1) NOT NULL DEFAULT '0',
  `Deceased` tinyint(1) NOT NULL DEFAULT '0',
  `MovedAway` tinyint(1) DEFAULT '0',
  `Animal_name` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ProfilePicture` varchar(255) DEFAULT '',
  PRIMARY KEY (`Animal_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Animal_name` (`Animal_name`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Identity_number` (`Identity_number`) USING BTREE,
  KEY `Insurance_Co` (`Insurance_Co`) USING BTREE,
  KEY `Insurance_policy_number` (`Insurance_policy_number`) USING BTREE,
  KEY `Other_1` (`Other_1`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2000031131 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Animal__beforeupdate` BEFORE UPDATE ON `animal` FOR EACH ROW INSERT INTO `Animal:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', Animal.*
                            FROM Animal WHERE Animal.Animal_ID = OLD.Animal_ID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Animal__beforedelete` BEFORE DELETE ON `animal` FOR EACH ROW INSERT INTO `Animal:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', Animal.* 
                            FROM Animal WHERE Animal.Animal_ID = OLD.Animal_ID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `animal:deletes`
--

DROP TABLE IF EXISTS `animal:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `Animal_ID` int(11) NOT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Species` varchar(20) DEFAULT NULL,
  `Breed` varchar(255) DEFAULT NULL,
  `Colour` varchar(30) DEFAULT NULL,
  `Markings` varchar(20) DEFAULT NULL,
  `Sex` varchar(1) DEFAULT NULL,
  `Neutered` tinyint(1) NOT NULL DEFAULT '0',
  `Date_of_birth` datetime DEFAULT NULL,
  `Height` decimal(10,3) DEFAULT NULL,
  `Weight` decimal(10,3) DEFAULT NULL,
  `Insurance_Co` varchar(20) DEFAULT NULL,
  `Insurance_policy_number` varchar(20) DEFAULT NULL,
  `Identity_number` varchar(20) DEFAULT NULL,
  `Operation_ID` int(10) DEFAULT NULL,
  `Overnight_charge` decimal(19,4) DEFAULT NULL,
  `Notes` varchar(5000) DEFAULT NULL,
  `Sensitive_notes` varchar(5000) DEFAULT NULL,
  `Warning_or_status_1` varchar(20) DEFAULT NULL,
  `Warning_or_status_2` varchar(20) DEFAULT NULL,
  `Warning_or_status_3` varchar(20) DEFAULT NULL,
  `Other_1` varchar(20) DEFAULT NULL,
  `Other_2` varchar(20) DEFAULT NULL,
  `Other_3` varchar(20) DEFAULT NULL,
  `Other_4` varchar(20) DEFAULT NULL,
  `Other_5` varchar(20) DEFAULT NULL,
  `Insurance_expiry_date` datetime DEFAULT NULL,
  `Inpatient` tinyint(1) NOT NULL DEFAULT '0',
  `Deceased` tinyint(1) NOT NULL DEFAULT '0',
  `MovedAway` tinyint(1) DEFAULT '0',
  `Animal_name` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ProfilePicture` varchar(255) DEFAULT '',
  PRIMARY KEY (`Delete_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Animal_name` (`Animal_name`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Identity_number` (`Identity_number`) USING BTREE,
  KEY `Insurance_Co` (`Insurance_Co`) USING BTREE,
  KEY `Insurance_policy_number` (`Insurance_policy_number`) USING BTREE,
  KEY `Other_1` (`Other_1`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106939 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animal:edits`
--

DROP TABLE IF EXISTS `animal:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `Animal_ID` int(11) NOT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Species` varchar(20) DEFAULT NULL,
  `Breed` varchar(255) DEFAULT NULL,
  `Colour` varchar(30) DEFAULT NULL,
  `Markings` varchar(20) DEFAULT NULL,
  `Sex` varchar(1) DEFAULT NULL,
  `Neutered` tinyint(1) NOT NULL DEFAULT '0',
  `Date_of_birth` datetime DEFAULT NULL,
  `Height` decimal(10,3) DEFAULT NULL,
  `Weight` decimal(10,3) DEFAULT NULL,
  `Insurance_Co` varchar(20) DEFAULT NULL,
  `Insurance_policy_number` varchar(20) DEFAULT NULL,
  `Identity_number` varchar(20) DEFAULT NULL,
  `Operation_ID` int(10) DEFAULT NULL,
  `Overnight_charge` decimal(19,4) DEFAULT NULL,
  `Notes` varchar(5000) DEFAULT NULL,
  `Sensitive_notes` varchar(5000) DEFAULT NULL,
  `Warning_or_status_1` varchar(20) DEFAULT NULL,
  `Warning_or_status_2` varchar(20) DEFAULT NULL,
  `Warning_or_status_3` varchar(20) DEFAULT NULL,
  `Other_1` varchar(20) DEFAULT NULL,
  `Other_2` varchar(20) DEFAULT NULL,
  `Other_3` varchar(20) DEFAULT NULL,
  `Other_4` varchar(20) DEFAULT NULL,
  `Other_5` varchar(20) DEFAULT NULL,
  `Insurance_expiry_date` datetime DEFAULT NULL,
  `Inpatient` tinyint(1) NOT NULL DEFAULT '0',
  `Deceased` tinyint(1) NOT NULL DEFAULT '0',
  `MovedAway` tinyint(1) DEFAULT '0',
  `Animal_name` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ProfilePicture` varchar(255) DEFAULT '',
  PRIMARY KEY (`Edit_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Animal_name` (`Animal_name`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Identity_number` (`Identity_number`) USING BTREE,
  KEY `Insurance_Co` (`Insurance_Co`) USING BTREE,
  KEY `Insurance_policy_number` (`Insurance_policy_number`) USING BTREE,
  KEY `Other_1` (`Other_1`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=170277 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animal_insurance_details`
--

DROP TABLE IF EXISTS `animal_insurance_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal_insurance_details` (
  `Animal_insurance_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Animal_ID` int(10) DEFAULT NULL,
  `Policy_type_text` varchar(80) DEFAULT NULL,
  `Policy_limit` decimal(19,4) DEFAULT NULL,
  `Policy_excess` varchar(50) DEFAULT NULL,
  `Inception_date` datetime DEFAULT NULL,
  `Exclusions` varchar(80) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PolicyExcess1` varchar(255) DEFAULT NULL,
  `PolicyExcess2` varchar(255) DEFAULT NULL,
  `PolicyExcess3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Animal_insurance_ID`),
  UNIQUE KEY `Animal_ID` (`Animal_ID`),
  KEY `Animal_insurance_ID` (`Animal_insurance_ID`) USING BTREE,
  KEY `Policy_type_text` (`Policy_type_text`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27233 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Animal_insurance_details__beforeupdate` BEFORE UPDATE ON `animal_insurance_details` FOR EACH ROW INSERT INTO `Animal_insurance_details:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', Animal_insurance_details.*
                            FROM Animal_insurance_details WHERE Animal_insurance_details.Animal_insurance_ID = OLD.Animal_insurance_ID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Animal_insurance_details__beforedelete` BEFORE DELETE ON `animal_insurance_details` FOR EACH ROW INSERT INTO `Animal_insurance_details:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', Animal_insurance_details.* 
                            FROM Animal_insurance_details WHERE Animal_insurance_details.Animal_insurance_ID = OLD.Animal_insurance_ID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `animal_insurance_details:deletes`
--

DROP TABLE IF EXISTS `animal_insurance_details:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal_insurance_details:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `Animal_insurance_ID` int(11) NOT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Policy_type_text` varchar(80) DEFAULT NULL,
  `Policy_limit` decimal(19,4) DEFAULT NULL,
  `Policy_excess` varchar(50) DEFAULT NULL,
  `Inception_date` datetime DEFAULT NULL,
  `Exclusions` varchar(80) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PolicyExcess1` varchar(255) DEFAULT NULL,
  `PolicyExcess2` varchar(255) DEFAULT NULL,
  `PolicyExcess3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`),
  KEY `Animal_insurance_ID` (`Animal_insurance_ID`) USING BTREE,
  KEY `Policy_type_text` (`Policy_type_text`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animal_insurance_details:edits`
--

DROP TABLE IF EXISTS `animal_insurance_details:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal_insurance_details:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `Animal_insurance_ID` int(11) NOT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Policy_type_text` varchar(80) DEFAULT NULL,
  `Policy_limit` decimal(19,4) DEFAULT NULL,
  `Policy_excess` varchar(50) DEFAULT NULL,
  `Inception_date` datetime DEFAULT NULL,
  `Exclusions` varchar(80) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PolicyExcess1` varchar(255) DEFAULT NULL,
  `PolicyExcess2` varchar(255) DEFAULT NULL,
  `PolicyExcess3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`),
  KEY `Animal_insurance_ID` (`Animal_insurance_ID`) USING BTREE,
  KEY `Policy_type_text` (`Policy_type_text`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animalinsuranceexclusions`
--

DROP TABLE IF EXISTS `animalinsuranceexclusions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalinsuranceexclusions` (
  `AnimalInsuranceExclusionID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimalID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `ExclusionText` varchar(1000) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AnimalInsuranceExclusionID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AnimalInsuranceExclusions__beforeupdate BEFORE UPDATE ON  AnimalInsuranceExclusions FOR EACH ROW
                            INSERT INTO `AnimalInsuranceExclusions:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', AnimalInsuranceExclusions.*
                            FROM AnimalInsuranceExclusions WHERE AnimalInsuranceExclusions.AnimalInsuranceExclusionID = OLD.AnimalInsuranceExclusionID; */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER AnimalInsuranceExclusions__beforedelete BEFORE DELETE ON  AnimalInsuranceExclusions FOR EACH ROW
                            INSERT INTO `AnimalInsuranceExclusions:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', AnimalInsuranceExclusions.* 
                            FROM AnimalInsuranceExclusions WHERE AnimalInsuranceExclusions.AnimalInsuranceExclusionID = OLD.AnimalInsuranceExclusionID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `animalinsuranceexclusions:deletes`
--

DROP TABLE IF EXISTS `animalinsuranceexclusions:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalinsuranceexclusions:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `AnimalInsuranceExclusionID` int(11) NOT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `ExclusionText` varchar(1000) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Delete_ID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animalinsuranceexclusions:edits`
--

DROP TABLE IF EXISTS `animalinsuranceexclusions:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalinsuranceexclusions:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `AnimalInsuranceExclusionID` int(11) NOT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `ExclusionText` varchar(1000) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Edit_ID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animallocation`
--

DROP TABLE IF EXISTS `animallocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animallocation` (
  `AnimalLocationID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimalID` int(11) DEFAULT NULL,
  `Description` mediumtext,
  `Postcode` varchar(255) DEFAULT NULL,
  `Latitude` varchar(255) DEFAULT NULL,
  `Longitude` varchar(255) DEFAULT NULL,
  `Reference` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AnimalLocationID`),
  UNIQUE KEY `AnimalID` (`AnimalID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AnimalLocation__beforeupdate` BEFORE UPDATE ON `animallocation` FOR EACH ROW INSERT INTO `AnimalLocation:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', AnimalLocation.*
                            FROM AnimalLocation WHERE AnimalLocation.AnimalLocationID = OLD.AnimalLocationID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AnimalLocation__beforedelete` BEFORE DELETE ON `animallocation` FOR EACH ROW INSERT INTO `AnimalLocation:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', AnimalLocation.* 
                            FROM AnimalLocation WHERE AnimalLocation.AnimalLocationID = OLD.AnimalLocationID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `animallocation:deletes`
--

DROP TABLE IF EXISTS `animallocation:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animallocation:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `AnimalLocationID` int(11) NOT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `Description` mediumtext,
  `Postcode` varchar(255) DEFAULT NULL,
  `Latitude` varchar(255) DEFAULT NULL,
  `Longitude` varchar(255) DEFAULT NULL,
  `Reference` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animallocation:edits`
--

DROP TABLE IF EXISTS `animallocation:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animallocation:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `AnimalLocationID` int(11) NOT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `Description` mediumtext,
  `Postcode` varchar(255) DEFAULT NULL,
  `Latitude` varchar(255) DEFAULT NULL,
  `Longitude` varchar(255) DEFAULT NULL,
  `Reference` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animalmeasurements`
--

DROP TABLE IF EXISTS `animalmeasurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalmeasurements` (
  `MeasurementID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeID` int(11) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Value` decimal(19,3) DEFAULT NULL,
  `TakenBy` int(255) DEFAULT NULL,
  `EnteredBy` int(255) DEFAULT NULL,
  `TransactionID` int(11) DEFAULT NULL,
  `TransactionLocation` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MeasurementID`),
  KEY `Date` (`Date`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `TypeID` (`TypeID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=100439 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animalmeasurementtypes`
--

DROP TABLE IF EXISTS `animalmeasurementtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalmeasurementtypes` (
  `TypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(255) DEFAULT NULL,
  `Default` decimal(19,2) DEFAULT NULL,
  `Units` varchar(255) DEFAULT NULL,
  `NumberOfFields` int(11) DEFAULT '1',
  `CreatedBy` int(255) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`TypeID`),
  UNIQUE KEY `TypeName` (`TypeName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animalnotes`
--

DROP TABLE IF EXISTS `animalnotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalnotes` (
  `AnimalNoteID` int(10) NOT NULL AUTO_INCREMENT,
  `AnimalID` int(10) DEFAULT NULL,
  `TypeID` int(10) DEFAULT NULL,
  `Text` varchar(3000) DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `PractitionerID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AnimalNoteID`),
  UNIQUE KEY `AID_TID` (`AnimalID`,`TypeID`),
  KEY `AnimalID` (`AnimalID`) USING BTREE,
  KEY `AnimalNoteID` (`AnimalNoteID`) USING BTREE,
  KEY `LastEdited` (`LastEdited`) USING BTREE,
  KEY `PractitionerID` (`PractitionerID`) USING BTREE,
  KEY `Text` (`Text`(255)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1399 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animalnotetype`
--

DROP TABLE IF EXISTS `animalnotetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalnotetype` (
  `AnimalNoteTypeID` int(10) NOT NULL AUTO_INCREMENT,
  `TypeID` int(10) DEFAULT NULL,
  `Caption` varchar(255) NOT NULL,
  `ImageFilename` varchar(255) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AnimalNoteTypeID`),
  UNIQUE KEY `unique_index` (`TypeID`,`Caption`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animalstableyard`
--

DROP TABLE IF EXISTS `animalstableyard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalstableyard` (
  `AnimalStableyardID` int(10) NOT NULL AUTO_INCREMENT,
  `StableyardID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`AnimalStableyardID`),
  UNIQUE KEY `_IdentifierFields` (`AnimalID`),
  KEY `StableyardID` (`StableyardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AnimalStableyard__beforeupdate` BEFORE UPDATE ON `animalstableyard` FOR EACH ROW INSERT INTO `AnimalStableyard:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', AnimalStableyard.*
                            FROM AnimalStableyard WHERE AnimalStableyard.AnimalStableyardID = OLD.AnimalStableyardID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AnimalStableyard__beforedelete` BEFORE DELETE ON `animalstableyard` FOR EACH ROW INSERT INTO `AnimalStableyard:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', AnimalStableyard.* 
                            FROM AnimalStableyard WHERE AnimalStableyard.AnimalStableyardID = OLD.AnimalStableyardID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `animalstableyard:deletes`
--

DROP TABLE IF EXISTS `animalstableyard:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalstableyard:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `AnimalStableyardID` int(11) NOT NULL,
  `StableyardID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`),
  KEY `StableyardID` (`StableyardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `animalstableyard:edits`
--

DROP TABLE IF EXISTS `animalstableyard:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animalstableyard:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `AnimalStableyardID` int(11) NOT NULL,
  `StableyardID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`),
  KEY `StableyardID` (`StableyardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentnotifications`
--

DROP TABLE IF EXISTS `appointmentnotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointmentnotifications` (
  `AppointmentNotificationID` int(10) NOT NULL AUTO_INCREMENT,
  `SlotID` int(10) DEFAULT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `NoticePeriod` int(10) DEFAULT NULL,
  `NotificationText` varchar(1000) DEFAULT NULL,
  `MobileNumber` varchar(15) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`AppointmentNotificationID`),
  UNIQUE KEY `SlotID` (`SlotID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`)
) ENGINE=InnoDB AUTO_INCREMENT=1168 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentnotificationtext`
--

DROP TABLE IF EXISTS `appointmentnotificationtext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointmentnotificationtext` (
  `AppointmentNotificationTextID` int(10) NOT NULL AUTO_INCREMENT,
  `Title` varchar(50) DEFAULT NULL,
  `Text` varchar(1000) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`AppointmentNotificationTextID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appt_trigger`
--

DROP TABLE IF EXISTS `appt_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appt_trigger` (
  `Appointment_trigger_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Diary_ID` int(10) DEFAULT NULL,
  `How_soon` smallint(5) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Appointment_trigger_ID`),
  KEY `Appointment_trigger_ID` (`Appointment_trigger_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `archived`
--

DROP TABLE IF EXISTS `archived`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archived` (
  `Transaction_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  PRIMARY KEY (`Transaction_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Date_entered` (`Date_entered`) USING BTREE,
  KEY `Department` (`Client_department_ID`) USING BTREE,
  KEY `Department1` (`Accounts_category_ID`) USING BTREE,
  KEY `Details` (`Details`) USING BTREE,
  KEY `Invoice_date` (`Invoice_date`) USING BTREE,
  KEY `Transaction_ID` (`Transaction_ID`) USING BTREE,
  KEY `Work_done_by` (`Work_done_by`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_trail`
--

DROP TABLE IF EXISTS `audit_trail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_trail` (
  `Audit_trail_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Transaction_ID` int(10) DEFAULT NULL,
  `Number` int(10) DEFAULT NULL,
  `Type` int(10) DEFAULT NULL,
  `Tax_point` datetime DEFAULT NULL,
  `Spare_1` varchar(10) DEFAULT NULL,
  `Spare_2` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Audit_trail_ID`),
  KEY `Audit_trail_ID` (`Audit_trail_ID`) USING BTREE,
  KEY `Transaction_ID` (`Transaction_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `breed`
--

DROP TABLE IF EXISTS `breed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `breed` (
  `Breed_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Breed_text` varchar(255) DEFAULT NULL,
  `Species` varchar(20) DEFAULT NULL,
  `Subtype` varchar(20) DEFAULT NULL,
  `Average_height_M` varchar(10) DEFAULT NULL,
  `Average_height_F` varchar(10) DEFAULT NULL,
  `Average_weight_M` varchar(10) DEFAULT NULL,
  `Average_weight_F` varchar(10) DEFAULT NULL,
  `Colours` varchar(5000) DEFAULT NULL,
  `Markings` varchar(5000) DEFAULT NULL,
  `Information1` varchar(5000) DEFAULT NULL,
  `Information2` varchar(5000) DEFAULT NULL,
  `Information3` varchar(5000) DEFAULT NULL,
  `Information4` varchar(5000) DEFAULT NULL,
  `Information5` varchar(5000) DEFAULT NULL,
  `Picture` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IdexxBreedID` int(10) DEFAULT NULL,
  `AgriaBreedListID` int(10) DEFAULT NULL,
  PRIMARY KEY (`Breed_ID`),
  UNIQUE KEY `Breed_text` (`Breed_text`)
) ENGINE=InnoDB AUTO_INCREMENT=2362 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business` (
  `Business_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Business_Name` varchar(50) DEFAULT NULL,
  `Telephone_Number` varchar(50) DEFAULT NULL,
  `Fax_Number` varchar(50) DEFAULT NULL,
  `Modem_Number` varchar(50) DEFAULT NULL,
  `Email_Address` varchar(50) DEFAULT NULL,
  `Contact_Name` varchar(50) DEFAULT NULL,
  `House_Number` varchar(50) DEFAULT NULL,
  `Address_1` varchar(50) DEFAULT NULL,
  `Address_2` varchar(50) DEFAULT NULL,
  `Address_3` varchar(50) DEFAULT NULL,
  `Address_4` varchar(50) DEFAULT NULL,
  `Postcode` varchar(10) DEFAULT NULL,
  `Website_URL` varchar(50) DEFAULT NULL,
  `Delivery_Charge` decimal(19,4) DEFAULT NULL,
  `Billing_Terms` varchar(50) DEFAULT NULL,
  `Notes` varchar(5000) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsReferringPractice` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Business_ID`),
  KEY `Business_ID` (`Business_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2101121160 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cardterminalconfig`
--

DROP TABLE IF EXISTS `cardterminalconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cardterminalconfig` (
  `CardTerminalID` int(10) NOT NULL AUTO_INCREMENT,
  `TerminalIdentifier` varchar(30) DEFAULT NULL,
  `SiteLocation` varchar(3) DEFAULT NULL,
  `IPAddress` varchar(15) DEFAULT NULL,
  `CloverDevice` tinyint(1) DEFAULT '0',
  `PortNumber` varchar(255) DEFAULT NULL,
  `PairingAuthToken` varchar(255) DEFAULT NULL,
  `CopyReceipt` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`CardTerminalID`),
  UNIQUE KEY `TerminalIdentifier` (`TerminalIdentifier`),
  UNIQUE KEY `IPAddress` (`IPAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashbooklog`
--

DROP TABLE IF EXISTS `cashbooklog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashbooklog` (
  `CashbookLogID` int(11) NOT NULL AUTO_INCREMENT,
  `DeptID` int(11) DEFAULT NULL,
  `PeriodStart` datetime DEFAULT NULL,
  `PeriodEnd` datetime DEFAULT NULL,
  `ReportOptions` text,
  `PractitionerID` int(11) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`CashbookLogID`)
) ENGINE=InnoDB AUTO_INCREMENT=2269 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `Client_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Surname` varchar(30) DEFAULT NULL,
  `First_name_or_initials` varchar(12) DEFAULT NULL,
  `Title` varchar(25) DEFAULT NULL,
  `Surname_2` varchar(30) DEFAULT NULL,
  `First_name_or_initials_2` varchar(12) DEFAULT NULL,
  `Title_2` varchar(10) DEFAULT NULL,
  `House_number` varchar(30) DEFAULT NULL,
  `Address_1` varchar(30) DEFAULT NULL,
  `Address_2` varchar(30) DEFAULT NULL,
  `Address_3` varchar(30) DEFAULT NULL,
  `Address_4` varchar(30) DEFAULT NULL,
  `Postcode` varchar(10) DEFAULT NULL,
  `Other_Housenumber` varchar(30) DEFAULT NULL,
  `Other_Address_1` varchar(30) DEFAULT NULL,
  `Other_Address_2` varchar(30) DEFAULT NULL,
  `Other_Address_3` varchar(30) DEFAULT NULL,
  `Other_Address_4` varchar(30) DEFAULT NULL,
  `Other_Postcode` varchar(10) DEFAULT NULL,
  `Map_reference` varchar(10) DEFAULT NULL,
  `Phone_home` varchar(15) DEFAULT NULL,
  `Phone_work` varchar(15) DEFAULT NULL,
  `Phone_mobile` varchar(15) DEFAULT NULL,
  `Email_address` varchar(50) DEFAULT NULL,
  `Billing_terms` varchar(10) DEFAULT NULL,
  `Next_appointment_date` datetime DEFAULT NULL,
  `Next_appointment_time` datetime DEFAULT NULL,
  `Next_appointment_diary_no` int(10) DEFAULT NULL,
  `Usual_branch` int(10) DEFAULT NULL,
  `Usual_vet_1` varchar(3) DEFAULT NULL,
  `Usual_vet_2` varchar(3) DEFAULT NULL,
  `First_registered` datetime DEFAULT NULL,
  `Last_visit` datetime DEFAULT NULL,
  `Notes` varchar(5000) DEFAULT NULL,
  `Sensitive_notes` varchar(5000) DEFAULT NULL,
  `Global_discount` double DEFAULT NULL,
  `Bill_type` varchar(1) DEFAULT NULL,
  `Send_this_run` tinyint(1) NOT NULL DEFAULT '1',
  `Mileage` smallint(5) DEFAULT NULL,
  `Credit_limit` decimal(19,4) DEFAULT NULL,
  `Other_1` varchar(20) DEFAULT NULL,
  `Other_2` varchar(20) DEFAULT NULL,
  `Other_3` varchar(20) DEFAULT NULL,
  `Other_4` varchar(20) DEFAULT NULL,
  `Other_5` varchar(20) DEFAULT NULL,
  `Which_billing_address` varchar(1) DEFAULT NULL,
  `Which_recall_address` varchar(1) DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Home_text` varchar(20) DEFAULT NULL,
  `Work_text` varchar(20) DEFAULT NULL,
  `Mobile_text` varchar(20) DEFAULT NULL,
  `Warning_or_status_1` varchar(50) DEFAULT NULL,
  `Warning_or_status_2` varchar(50) DEFAULT NULL,
  `Warning_or_status_3` varchar(50) DEFAULT NULL,
  `Phone_home_2` varchar(15) DEFAULT NULL,
  `Home_text_2` varchar(20) DEFAULT NULL,
  `ThirdPartyOptOut` tinyint(1) DEFAULT '0',
  `MovedAway` tinyint(1) DEFAULT '0',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ReferringPracticeID` int(10) DEFAULT NULL,
  `ReferringVetID` int(10) DEFAULT NULL,
  `AdminFeeExempt` tinyint(1) DEFAULT '0',
  `Sundry` tinyint(1) DEFAULT '0',
  `Phone_home_description` varchar(255) DEFAULT '',
  `Phone_work_description` varchar(255) DEFAULT '',
  `Phone_mobile_description` varchar(255) DEFAULT '',
  `Email_description` varchar(255) DEFAULT '',
  PRIMARY KEY (`Client_ID`),
  UNIQUE KEY `Client_ID` (`Client_ID`),
  KEY `Address_1` (`Address_1`) USING BTREE,
  KEY `Address_11` (`Address_2`) USING BTREE,
  KEY `Address_12` (`Address_3`) USING BTREE,
  KEY `Address_13` (`Address_4`) USING BTREE,
  KEY `Address_14` (`Other_Address_1`) USING BTREE,
  KEY `Address_2` (`Address_2`) USING BTREE,
  KEY `Address_3` (`Address_3`) USING BTREE,
  KEY `Address_4` (`Address_4`) USING BTREE,
  KEY `House_number` (`House_number`) USING BTREE,
  KEY `Other_1` (`Other_1`) USING BTREE,
  KEY `Other_2` (`Other_2`) USING BTREE,
  KEY `Phone_home` (`Phone_home`) USING BTREE,
  KEY `Phone_home1` (`Phone_work`) USING BTREE,
  KEY `Phone_home2` (`Phone_mobile`) USING BTREE,
  KEY `Postcode` (`Postcode`) USING BTREE,
  KEY `Postcode1` (`Other_Postcode`) USING BTREE,
  KEY `Surname` (`Surname`) USING BTREE,
  KEY `Surname_2` (`Surname_2`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2000006431 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Client__beforeupdate` BEFORE UPDATE ON `client` FOR EACH ROW INSERT INTO `Client:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', Client.*
                            FROM Client WHERE Client.Client_ID = OLD.Client_ID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Client__beforedelete` BEFORE DELETE ON `client` FOR EACH ROW INSERT INTO `Client:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', Client.* 
                            FROM Client WHERE Client.Client_ID = OLD.Client_ID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `client:deletes`
--

DROP TABLE IF EXISTS `client:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `Client_ID` int(11) NOT NULL,
  `Surname` varchar(30) DEFAULT NULL,
  `First_name_or_initials` varchar(12) DEFAULT NULL,
  `Title` varchar(25) DEFAULT NULL,
  `Surname_2` varchar(30) DEFAULT NULL,
  `First_name_or_initials_2` varchar(12) DEFAULT NULL,
  `Title_2` varchar(10) DEFAULT NULL,
  `House_number` varchar(30) DEFAULT NULL,
  `Address_1` varchar(30) DEFAULT NULL,
  `Address_2` varchar(30) DEFAULT NULL,
  `Address_3` varchar(30) DEFAULT NULL,
  `Address_4` varchar(30) DEFAULT NULL,
  `Postcode` varchar(10) DEFAULT NULL,
  `Other_Housenumber` varchar(30) DEFAULT NULL,
  `Other_Address_1` varchar(30) DEFAULT NULL,
  `Other_Address_2` varchar(30) DEFAULT NULL,
  `Other_Address_3` varchar(30) DEFAULT NULL,
  `Other_Address_4` varchar(30) DEFAULT NULL,
  `Other_Postcode` varchar(10) DEFAULT NULL,
  `Map_reference` varchar(10) DEFAULT NULL,
  `Phone_home` varchar(15) DEFAULT NULL,
  `Phone_work` varchar(15) DEFAULT NULL,
  `Phone_mobile` varchar(15) DEFAULT NULL,
  `Email_address` varchar(50) DEFAULT NULL,
  `Billing_terms` varchar(10) DEFAULT NULL,
  `Next_appointment_date` datetime DEFAULT NULL,
  `Next_appointment_time` datetime DEFAULT NULL,
  `Next_appointment_diary_no` int(10) DEFAULT NULL,
  `Usual_branch` int(10) DEFAULT NULL,
  `Usual_vet_1` varchar(3) DEFAULT NULL,
  `Usual_vet_2` varchar(3) DEFAULT NULL,
  `First_registered` datetime DEFAULT NULL,
  `Last_visit` datetime DEFAULT NULL,
  `Notes` varchar(5000) DEFAULT NULL,
  `Sensitive_notes` varchar(5000) DEFAULT NULL,
  `Global_discount` double DEFAULT NULL,
  `Bill_type` varchar(1) DEFAULT NULL,
  `Send_this_run` tinyint(1) NOT NULL DEFAULT '1',
  `Mileage` smallint(5) DEFAULT NULL,
  `Credit_limit` decimal(19,4) DEFAULT NULL,
  `Other_1` varchar(20) DEFAULT NULL,
  `Other_2` varchar(20) DEFAULT NULL,
  `Other_3` varchar(20) DEFAULT NULL,
  `Other_4` varchar(20) DEFAULT NULL,
  `Other_5` varchar(20) DEFAULT NULL,
  `Which_billing_address` varchar(1) DEFAULT NULL,
  `Which_recall_address` varchar(1) DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Home_text` varchar(20) DEFAULT NULL,
  `Work_text` varchar(20) DEFAULT NULL,
  `Mobile_text` varchar(20) DEFAULT NULL,
  `Warning_or_status_1` varchar(50) DEFAULT NULL,
  `Warning_or_status_2` varchar(50) DEFAULT NULL,
  `Warning_or_status_3` varchar(50) DEFAULT NULL,
  `Phone_home_2` varchar(15) DEFAULT NULL,
  `Home_text_2` varchar(20) DEFAULT NULL,
  `ThirdPartyOptOut` tinyint(1) DEFAULT '0',
  `MovedAway` tinyint(1) DEFAULT '0',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ReferringPracticeID` int(10) DEFAULT NULL,
  `ReferringVetID` int(10) DEFAULT NULL,
  `AdminFeeExempt` tinyint(1) DEFAULT '0',
  `Sundry` tinyint(1) DEFAULT '0',
  `Phone_home_description` varchar(255) DEFAULT '',
  `Phone_work_description` varchar(255) DEFAULT '',
  `Phone_mobile_description` varchar(255) DEFAULT '',
  `Email_description` varchar(255) DEFAULT '',
  PRIMARY KEY (`Delete_ID`),
  KEY `Address_1` (`Address_1`) USING BTREE,
  KEY `Address_11` (`Address_2`) USING BTREE,
  KEY `Address_12` (`Address_3`) USING BTREE,
  KEY `Address_13` (`Address_4`) USING BTREE,
  KEY `Address_14` (`Other_Address_1`) USING BTREE,
  KEY `Address_2` (`Address_2`) USING BTREE,
  KEY `Address_3` (`Address_3`) USING BTREE,
  KEY `Address_4` (`Address_4`) USING BTREE,
  KEY `House_number` (`House_number`) USING BTREE,
  KEY `Other_1` (`Other_1`) USING BTREE,
  KEY `Other_2` (`Other_2`) USING BTREE,
  KEY `Phone_home` (`Phone_home`) USING BTREE,
  KEY `Phone_home1` (`Phone_work`) USING BTREE,
  KEY `Phone_home2` (`Phone_mobile`) USING BTREE,
  KEY `Postcode` (`Postcode`) USING BTREE,
  KEY `Postcode1` (`Other_Postcode`) USING BTREE,
  KEY `Surname` (`Surname`) USING BTREE,
  KEY `Surname_2` (`Surname_2`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1505 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client:edits`
--

DROP TABLE IF EXISTS `client:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `Client_ID` int(11) NOT NULL,
  `Surname` varchar(30) DEFAULT NULL,
  `First_name_or_initials` varchar(12) DEFAULT NULL,
  `Title` varchar(25) DEFAULT NULL,
  `Surname_2` varchar(30) DEFAULT NULL,
  `First_name_or_initials_2` varchar(12) DEFAULT NULL,
  `Title_2` varchar(10) DEFAULT NULL,
  `House_number` varchar(30) DEFAULT NULL,
  `Address_1` varchar(30) DEFAULT NULL,
  `Address_2` varchar(30) DEFAULT NULL,
  `Address_3` varchar(30) DEFAULT NULL,
  `Address_4` varchar(30) DEFAULT NULL,
  `Postcode` varchar(10) DEFAULT NULL,
  `Other_Housenumber` varchar(30) DEFAULT NULL,
  `Other_Address_1` varchar(30) DEFAULT NULL,
  `Other_Address_2` varchar(30) DEFAULT NULL,
  `Other_Address_3` varchar(30) DEFAULT NULL,
  `Other_Address_4` varchar(30) DEFAULT NULL,
  `Other_Postcode` varchar(10) DEFAULT NULL,
  `Map_reference` varchar(10) DEFAULT NULL,
  `Phone_home` varchar(15) DEFAULT NULL,
  `Phone_work` varchar(15) DEFAULT NULL,
  `Phone_mobile` varchar(15) DEFAULT NULL,
  `Email_address` varchar(50) DEFAULT NULL,
  `Billing_terms` varchar(10) DEFAULT NULL,
  `Next_appointment_date` datetime DEFAULT NULL,
  `Next_appointment_time` datetime DEFAULT NULL,
  `Next_appointment_diary_no` int(10) DEFAULT NULL,
  `Usual_branch` int(10) DEFAULT NULL,
  `Usual_vet_1` varchar(3) DEFAULT NULL,
  `Usual_vet_2` varchar(3) DEFAULT NULL,
  `First_registered` datetime DEFAULT NULL,
  `Last_visit` datetime DEFAULT NULL,
  `Notes` varchar(5000) DEFAULT NULL,
  `Sensitive_notes` varchar(5000) DEFAULT NULL,
  `Global_discount` double DEFAULT NULL,
  `Bill_type` varchar(1) DEFAULT NULL,
  `Send_this_run` tinyint(1) NOT NULL DEFAULT '1',
  `Mileage` smallint(5) DEFAULT NULL,
  `Credit_limit` decimal(19,4) DEFAULT NULL,
  `Other_1` varchar(20) DEFAULT NULL,
  `Other_2` varchar(20) DEFAULT NULL,
  `Other_3` varchar(20) DEFAULT NULL,
  `Other_4` varchar(20) DEFAULT NULL,
  `Other_5` varchar(20) DEFAULT NULL,
  `Which_billing_address` varchar(1) DEFAULT NULL,
  `Which_recall_address` varchar(1) DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Home_text` varchar(20) DEFAULT NULL,
  `Work_text` varchar(20) DEFAULT NULL,
  `Mobile_text` varchar(20) DEFAULT NULL,
  `Warning_or_status_1` varchar(50) DEFAULT NULL,
  `Warning_or_status_2` varchar(50) DEFAULT NULL,
  `Warning_or_status_3` varchar(50) DEFAULT NULL,
  `Phone_home_2` varchar(15) DEFAULT NULL,
  `Home_text_2` varchar(20) DEFAULT NULL,
  `ThirdPartyOptOut` tinyint(1) DEFAULT '0',
  `MovedAway` tinyint(1) DEFAULT '0',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ReferringPracticeID` int(10) DEFAULT NULL,
  `ReferringVetID` int(10) DEFAULT NULL,
  `AdminFeeExempt` tinyint(1) DEFAULT '0',
  `Sundry` tinyint(1) DEFAULT '0',
  `Phone_home_description` varchar(255) DEFAULT '',
  `Phone_work_description` varchar(255) DEFAULT '',
  `Phone_mobile_description` varchar(255) DEFAULT '',
  `Email_description` varchar(255) DEFAULT '',
  PRIMARY KEY (`Edit_ID`),
  KEY `Address_1` (`Address_1`) USING BTREE,
  KEY `Address_11` (`Address_2`) USING BTREE,
  KEY `Address_12` (`Address_3`) USING BTREE,
  KEY `Address_13` (`Address_4`) USING BTREE,
  KEY `Address_14` (`Other_Address_1`) USING BTREE,
  KEY `Address_2` (`Address_2`) USING BTREE,
  KEY `Address_3` (`Address_3`) USING BTREE,
  KEY `Address_4` (`Address_4`) USING BTREE,
  KEY `House_number` (`House_number`) USING BTREE,
  KEY `Other_1` (`Other_1`) USING BTREE,
  KEY `Other_2` (`Other_2`) USING BTREE,
  KEY `Phone_home` (`Phone_home`) USING BTREE,
  KEY `Phone_home1` (`Phone_work`) USING BTREE,
  KEY `Phone_home2` (`Phone_mobile`) USING BTREE,
  KEY `Postcode` (`Postcode`) USING BTREE,
  KEY `Postcode1` (`Other_Postcode`) USING BTREE,
  KEY `Surname` (`Surname`) USING BTREE,
  KEY `Surname_2` (`Surname_2`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50171 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_department`
--

DROP TABLE IF EXISTS `client_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_department` (
  `Client_department_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_department_number` varchar(3) DEFAULT NULL,
  `Client_department_text` varchar(20) DEFAULT NULL,
  `Next_Purchase_Order_Number` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Default_telephone_number` varchar(15) DEFAULT NULL,
  `Email` char(255) DEFAULT NULL,
  `Alias` char(255) DEFAULT NULL,
  PRIMARY KEY (`Client_department_ID`),
  UNIQUE KEY `Client_department_number` (`Client_department_number`),
  KEY `Client_department_ID` (`Client_department_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1679224647 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientadditionalcontactnum`
--

DROP TABLE IF EXISTS `clientadditionalcontactnum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientadditionalcontactnum` (
  `ContactID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `Caption` varchar(20) DEFAULT NULL,
  `Number` varchar(15) DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  PRIMARY KEY (`ContactID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=907 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientadditionalcontacts`
--

DROP TABLE IF EXISTS `clientadditionalcontacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientadditionalcontacts` (
  `ContactID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `Caption` varchar(20) DEFAULT NULL,
  `Description` char(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Number` varchar(15) DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  PRIMARY KEY (`ContactID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=2481 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ClientAdditionalContacts__beforeupdate BEFORE UPDATE ON  ClientAdditionalContacts FOR EACH ROW
                            INSERT INTO `ClientAdditionalContacts:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', ClientAdditionalContacts.*
                            FROM ClientAdditionalContacts WHERE ClientAdditionalContacts.ContactID = OLD.ContactID; */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER ClientAdditionalContacts__beforedelete BEFORE DELETE ON  ClientAdditionalContacts FOR EACH ROW
                            INSERT INTO `ClientAdditionalContacts:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', ClientAdditionalContacts.* 
                            FROM ClientAdditionalContacts WHERE ClientAdditionalContacts.ContactID = OLD.ContactID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clientadditionalcontacts:deletes`
--

DROP TABLE IF EXISTS `clientadditionalcontacts:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientadditionalcontacts:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `ContactID` int(11) NOT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `Caption` varchar(20) DEFAULT NULL,
  `Description` char(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Number` varchar(15) DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientadditionalcontacts:edits`
--

DROP TABLE IF EXISTS `clientadditionalcontacts:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientadditionalcontacts:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `ContactID` int(11) NOT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `Caption` varchar(20) DEFAULT NULL,
  `Description` char(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Number` varchar(15) DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientbalance`
--

DROP TABLE IF EXISTS `clientbalance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientbalance` (
  `ClientBalanceID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `Balance` decimal(19,2) DEFAULT '0.00',
  `PHPBalance` decimal(19,2) DEFAULT '0.00',
  `InsuranceBalance` decimal(19,2) DEFAULT '0.00',
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ClientBalanceID`),
  UNIQUE KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=3891625 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientstableyard`
--

DROP TABLE IF EXISTS `clientstableyard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientstableyard` (
  `ClientStableyardID` int(10) NOT NULL AUTO_INCREMENT,
  `StableyardID` int(10) DEFAULT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`ClientStableyardID`),
  UNIQUE KEY `_IdentifierFields` (`ClientID`,`StableyardID`),
  KEY `StableyardID` (`StableyardID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ClientStableyard__beforeupdate` BEFORE UPDATE ON `clientstableyard` FOR EACH ROW INSERT INTO `ClientStableyard:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', ClientStableyard.*
                            FROM ClientStableyard WHERE ClientStableyard.ClientStableyardID = OLD.ClientStableyardID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ClientStableyard__beforedelete` BEFORE DELETE ON `clientstableyard` FOR EACH ROW INSERT INTO `ClientStableyard:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', ClientStableyard.* 
                            FROM ClientStableyard WHERE ClientStableyard.ClientStableyardID = OLD.ClientStableyardID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clientstableyard:deletes`
--

DROP TABLE IF EXISTS `clientstableyard:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientstableyard:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `ClientStableyardID` int(11) NOT NULL,
  `StableyardID` int(10) DEFAULT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`),
  KEY `StableyardID` (`StableyardID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientstableyard:edits`
--

DROP TABLE IF EXISTS `clientstableyard:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientstableyard:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `ClientStableyardID` int(11) NOT NULL,
  `StableyardID` int(10) DEFAULT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`),
  KEY `StableyardID` (`StableyardID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloverpayments`
--

DROP TABLE IF EXISTS `cloverpayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloverpayments` (
  `CloverPaymentID` int(11) NOT NULL AUTO_INCREMENT,
  `RequestID` varchar(255) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Amount` decimal(10,0) DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Processed` tinyint(1) DEFAULT '0',
  `TransactionID` int(11) DEFAULT NULL,
  PRIMARY KEY (`CloverPaymentID`),
  KEY `RequestID` (`RequestID`),
  KEY `ClientID` (`ClientID`),
  KEY `Date` (`Date`),
  KEY `Processed` (`Processed`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=108333 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `colour`
--

DROP TABLE IF EXISTS `colour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colour` (
  `Colour_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Colour_text` varchar(30) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Colour_ID`),
  KEY `Colour_text` (`Colour_text`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contactlog`
--

DROP TABLE IF EXISTS `contactlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactlog` (
  `ContactLogID` int(10) NOT NULL AUTO_INCREMENT,
  `DateSent` datetime DEFAULT NULL,
  `Module` varchar(255) DEFAULT '',
  `ClientID` int(10) DEFAULT NULL,
  `MessageContent` mediumtext,
  `Method` varchar(255) DEFAULT '',
  `Status` varchar(255) DEFAULT '',
  `Destination` varchar(1000) DEFAULT '',
  `ClientDepartment` int(10) DEFAULT NULL,
  PRIMARY KEY (`ContactLogID`)
) ENGINE=InnoDB AUTO_INCREMENT=183437 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `Currency_abbreviation` varchar(3) NOT NULL,
  `Currency_text` varchar(20) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Currency_abbreviation`),
  UNIQUE KEY `Currency` (`Currency_abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customfields`
--

DROP TABLE IF EXISTS `customfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customfields` (
  `CustomFieldID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomFieldTypeID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `Value` varchar(255) DEFAULT NULL,
  `DisplayIndex` int(11) DEFAULT NULL,
  PRIMARY KEY (`CustomFieldID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `CustomFields__beforeupdate` BEFORE UPDATE ON `customfields` FOR EACH ROW INSERT INTO `CustomFields:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', CustomFields.*
                            FROM CustomFields WHERE CustomFields.CustomFieldID = OLD.CustomFieldID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `CustomFields__beforedelete` BEFORE DELETE ON `customfields` FOR EACH ROW INSERT INTO `CustomFields:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', CustomFields.* 
                            FROM CustomFields WHERE CustomFields.CustomFieldID = OLD.CustomFieldID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customfields:deletes`
--

DROP TABLE IF EXISTS `customfields:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customfields:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `CustomFieldID` int(11) NOT NULL,
  `CustomFieldTypeID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `Value` varchar(255) DEFAULT NULL,
  `DisplayIndex` int(11) DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customfields:edits`
--

DROP TABLE IF EXISTS `customfields:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customfields:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `CustomFieldID` int(11) NOT NULL,
  `CustomFieldTypeID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `Value` varchar(255) DEFAULT NULL,
  `DisplayIndex` int(11) DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customfieldtypes`
--

DROP TABLE IF EXISTS `customfieldtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customfieldtypes` (
  `CustomFieldTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `FieldFormat` varchar(255) DEFAULT NULL,
  `FieldName` varchar(255) DEFAULT NULL,
  `FieldLength` int(11) DEFAULT NULL,
  `Decimals` int(11) DEFAULT NULL,
  `ListItems` mediumtext,
  `DefaultValue` varchar(255) DEFAULT NULL,
  `FieldRemoved` tinyint(4) DEFAULT '0',
  `AllowNull` tinyint(4) DEFAULT '1',
  `DisplayLocation` varchar(255) DEFAULT NULL,
  `AllowFreehand` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`CustomFieldTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customprompts`
--

DROP TABLE IF EXISTS `customprompts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customprompts` (
  `CustomPromptID` int(11) NOT NULL AUTO_INCREMENT,
  `PromptName` varchar(255) DEFAULT NULL,
  `PromptHeader` varchar(255) DEFAULT NULL,
  `PromptMessage` varchar(5000) DEFAULT NULL,
  `FieldToUpdate` varchar(255) DEFAULT NULL,
  `PromptApptStatusChanged` tinyint(1) DEFAULT '0',
  `PromptNewRecord` tinyint(1) DEFAULT '0',
  `PromptViewRecord` tinyint(1) DEFAULT '0',
  `PromptItemAdded` tinyint(1) DEFAULT '0',
  `ItemType` varchar(1) DEFAULT NULL,
  `ItemID` mediumtext,
  `PromptOnlyIfEmpty` tinyint(1) DEFAULT '0',
  `LastRecordedWeightDays` int(11) DEFAULT '0',
  `GroupID` int(11) DEFAULT NULL,
  `Species` mediumtext,
  `Diaries` mediumtext,
  `ApptStatus` varchar(255) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT '0',
  `EditedOn` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EditedBy` int(11) DEFAULT '0',
  PRIMARY KEY (`CustomPromptID`),
  UNIQUE KEY `CustomPromptID` (`CustomPromptID`),
  KEY `PromptApptStatusChanged` (`PromptApptStatusChanged`),
  KEY `PromptNewRecord` (`PromptNewRecord`),
  KEY `PromptViewRecord` (`PromptViewRecord`),
  KEY `PromptItemAdded` (`PromptItemAdded`),
  KEY `ApptStatus` (`ApptStatus`),
  KEY `ItemType` (`ItemType`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `databaseversion`
--

DROP TABLE IF EXISTS `databaseversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `databaseversion` (
  `DatabaseVersionID` int(10) NOT NULL AUTO_INCREMENT,
  `Version` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`DatabaseVersionID`),
  UNIQUE KEY `DatabaseVersionID` (`DatabaseVersionID`),
  KEY `Version` (`Version`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deletions`
--

DROP TABLE IF EXISTS `deletions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deletions` (
  `DeleteID` int(10) NOT NULL,
  `TableID` int(10) NOT NULL,
  `TableName` varchar(30) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`DeleteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diary`
--

DROP TABLE IF EXISTS `diary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diary` (
  `Diary_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Diary_name` varchar(50) DEFAULT NULL,
  `Diary_type` varchar(1) DEFAULT NULL,
  `Slots_profile_Mon` varchar(5000) DEFAULT NULL,
  `Slots_profile_Tue` varchar(5000) DEFAULT NULL,
  `Slots_profile_Wed` varchar(5000) DEFAULT NULL,
  `Slots_profile_Thu` varchar(5000) DEFAULT NULL,
  `Slots_profile_Fri` varchar(5000) DEFAULT NULL,
  `Slots_profile_Sat` varchar(5000) DEFAULT NULL,
  `Slots_profile_Sun` varchar(5000) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DefaultNotificationText` int(10) DEFAULT NULL,
  `OnlineConsultations` tinyint(1) DEFAULT '0',
  `ClientDepartmentID` int(10) DEFAULT NULL,
  PRIMARY KEY (`Diary_ID`),
  UNIQUE KEY `Diary_name` (`Diary_name`),
  KEY `Diary_ID` (`Diary_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2049885317 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documentation_trigger`
--

DROP TABLE IF EXISTS `documentation_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentation_trigger` (
  `Documentation_trigger_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Procedure_ID` int(10) DEFAULT NULL,
  `File_to_print` varchar(50) DEFAULT NULL,
  `StockorProcedure` varchar(1) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Documentation_trigger_ID`),
  KEY `Documentation_trigger_ID` (`Documentation_trigger_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dosage`
--

DROP TABLE IF EXISTS `dosage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosage` (
  `Dosage_or_warning_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Dosage_or_warning_abbrev` varchar(10) DEFAULT NULL,
  `Dosage_or_warning_text` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Dosage_or_warning_ID`),
  UNIQUE KEY `Dosage_or_warning_abbrev` (`Dosage_or_warning_abbrev`),
  KEY `Dosage_or_warning_ID` (`Dosage_or_warning_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2102498004 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `Transaction_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Transaction_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Date_entered` (`Date_entered`) USING BTREE,
  KEY `Department` (`Client_department_ID`) USING BTREE,
  KEY `Department1` (`Accounts_category_ID`) USING BTREE,
  KEY `Details` (`Details`) USING BTREE,
  KEY `Invoice_date` (`Invoice_date`) USING BTREE,
  KEY `Stock_ID` (`Stock_ID`) USING BTREE,
  KEY `Transaction_ID` (`Transaction_ID`) USING BTREE,
  KEY `Work_done_by` (`Work_done_by`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_category`
--

DROP TABLE IF EXISTS `drug_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_category` (
  `Drug_category` int(11) NOT NULL,
  `Drug_category_abbreviation` varchar(3) DEFAULT NULL,
  `Drug_category_full_text` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Drug_category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_location`
--

DROP TABLE IF EXISTS `drug_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_location` (
  `Drug_location_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Drug_location_text` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Drug_location_ID`),
  KEY `Drug_location_ID` (`Drug_location_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_location_abbreviation`
--

DROP TABLE IF EXISTS `drug_location_abbreviation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_location_abbreviation` (
  `Drug_Location_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Drug_Location_Abbreviation` varchar(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Drug_Location_ID`),
  KEY `Drug_Location_Abbreviation` (`Drug_Location_Abbreviation`) USING BTREE,
  KEY `Drug_Location_ID` (`Drug_Location_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edits`
--

DROP TABLE IF EXISTS `edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edits` (
  `EditID` int(10) NOT NULL,
  `TableID` int(10) NOT NULL,
  `TableName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`EditID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `errors`
--

DROP TABLE IF EXISTS `errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errors` (
  `ErrorID` int(11) NOT NULL AUTO_INCREMENT,
  `ErrorDate` datetime DEFAULT NULL,
  `Source` varchar(255) DEFAULT NULL,
  `SourceVersion` varchar(255) DEFAULT NULL,
  `ErrorDescription` varchar(10000) DEFAULT NULL,
  `SectionRef` varchar(255) DEFAULT NULL,
  `RunningQuery` varchar(10000) DEFAULT NULL,
  `StackTrace` varchar(20000) DEFAULT NULL,
  `Workstation` varchar(255) DEFAULT NULL,
  `WorkstationFolder` varchar(255) DEFAULT NULL,
  `PractitionerInitials` varchar(255) DEFAULT NULL,
  `AdditionalDetails` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ErrorID`),
  KEY `ErrorID` (`ErrorID`)
) ENGINE=InnoDB AUTO_INCREMENT=185053 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estimate`
--

DROP TABLE IF EXISTS `estimate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estimate` (
  `Estimate_ID` int(10) NOT NULL AUTO_INCREMENT,
  `File_contained_in` varchar(50) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `Amount` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`Estimate_ID`),
  KEY `Date` (`Date`) USING BTREE,
  KEY `Estimate_ID` (`Estimate_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estimatesturnedintowork`
--

DROP TABLE IF EXISTS `estimatesturnedintowork`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estimatesturnedintowork` (
  `EstimateTurnedIntoWorkID` int(11) NOT NULL AUTO_INCREMENT,
  `EstimateID` int(11) NOT NULL,
  `TransactionID` int(11) NOT NULL,
  PRIMARY KEY (`EstimateTurnedIntoWorkID`),
  KEY `EstimateID` (`EstimateID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=1249 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explicit_dosage`
--

DROP TABLE IF EXISTS `explicit_dosage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `explicit_dosage` (
  `ExplicitDosageID` int(10) NOT NULL AUTO_INCREMENT,
  `StockID` int(10) DEFAULT NULL,
  `SpeciesID` int(10) DEFAULT NULL,
  `Species` tinyint(1) DEFAULT NULL,
  `DosageMessage` text,
  `WarningMessage` text,
  `WithdrawalPeriodDairy` int(10) DEFAULT NULL,
  `WithdrawalPeriodDairyUnit` varchar(10) DEFAULT NULL,
  `WithdrawalPeriodMeat` int(10) DEFAULT NULL,
  `WithdrawalPeriodMeatUnit` varchar(10) DEFAULT NULL,
  `WithdrawalPeriodEggs` int(10) DEFAULT NULL,
  `WithdrawalPeriodEggsUnit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ExplicitDosageID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_change_trigger`
--

DROP TABLE IF EXISTS `field_change_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_change_trigger` (
  `Field_change_trigger` int(10) NOT NULL AUTO_INCREMENT,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Client_or_animal` varchar(1) DEFAULT NULL,
  `Field_to_change` varchar(50) DEFAULT NULL,
  `New_value` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Field_change_trigger`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gdprconfig`
--

DROP TABLE IF EXISTS `gdprconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gdprconfig` (
  `GDPRconfigID` int(11) NOT NULL AUTO_INCREMENT,
  `ConfigSetting` varchar(255) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `ModifiedOn` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`GDPRconfigID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gdprstatus`
--

DROP TABLE IF EXISTS `gdprstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gdprstatus` (
  `GDPRstatusID` int(11) NOT NULL AUTO_INCREMENT,
  `ClientID` int(11) DEFAULT NULL,
  `MarketingSMS` tinyint(1) DEFAULT NULL,
  `MarketingEmail` tinyint(1) DEFAULT NULL,
  `MarketingModified` datetime DEFAULT NULL,
  `MarketingModifiedBy` int(11) DEFAULT NULL,
  `InfoSMS` tinyint(1) DEFAULT NULL,
  `InfoEmail` tinyint(1) DEFAULT NULL,
  `InfoModified` datetime DEFAULT NULL,
  `InfoModifiedBy` int(11) DEFAULT NULL,
  `FormPath` varchar(255) DEFAULT NULL,
  `FormUpdated` datetime DEFAULT NULL,
  `FormUpdatedBy` int(11) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`GDPRstatusID`),
  UNIQUE KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=25803 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `GDPRstatus__beforeupdate` BEFORE UPDATE ON `gdprstatus` FOR EACH ROW INSERT INTO `GDPRstatus:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', GDPRstatus.*
                            FROM GDPRstatus WHERE GDPRstatus.GDPRstatusID = OLD.GDPRstatusID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `GDPRstatus__beforedelete` BEFORE DELETE ON `gdprstatus` FOR EACH ROW INSERT INTO `GDPRstatus:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', GDPRstatus.* 
                            FROM GDPRstatus WHERE GDPRstatus.GDPRstatusID = OLD.GDPRstatusID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `gdprstatus:deletes`
--

DROP TABLE IF EXISTS `gdprstatus:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gdprstatus:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `GDPRstatusID` int(11) NOT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `MarketingSMS` tinyint(1) DEFAULT NULL,
  `MarketingEmail` tinyint(1) DEFAULT NULL,
  `MarketingModified` datetime DEFAULT NULL,
  `MarketingModifiedBy` int(11) DEFAULT NULL,
  `InfoSMS` tinyint(1) DEFAULT NULL,
  `InfoEmail` tinyint(1) DEFAULT NULL,
  `InfoModified` datetime DEFAULT NULL,
  `InfoModifiedBy` int(11) DEFAULT NULL,
  `FormPath` varchar(255) DEFAULT NULL,
  `FormUpdated` datetime DEFAULT NULL,
  `FormUpdatedBy` int(11) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Delete_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gdprstatus:edits`
--

DROP TABLE IF EXISTS `gdprstatus:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gdprstatus:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `GDPRstatusID` int(11) NOT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `MarketingSMS` tinyint(1) DEFAULT NULL,
  `MarketingEmail` tinyint(1) DEFAULT NULL,
  `MarketingModified` datetime DEFAULT NULL,
  `MarketingModifiedBy` int(11) DEFAULT NULL,
  `InfoSMS` tinyint(1) DEFAULT NULL,
  `InfoEmail` tinyint(1) DEFAULT NULL,
  `InfoModified` datetime DEFAULT NULL,
  `InfoModifiedBy` int(11) DEFAULT NULL,
  `FormPath` varchar(255) DEFAULT NULL,
  `FormUpdated` datetime DEFAULT NULL,
  `FormUpdatedBy` int(11) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Edit_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7549 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `googlesheetslog`
--

DROP TABLE IF EXISTS `googlesheetslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `googlesheetslog` (
  `GoogleSheetsLogID` int(11) NOT NULL AUTO_INCREMENT,
  `SheetID` varchar(255) DEFAULT NULL,
  `SheetPageName` varchar(255) DEFAULT NULL,
  `DataLogged` mediumtext,
  `Result` text,
  `CreatedOn` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`GoogleSheetsLogID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_entries`
--

DROP TABLE IF EXISTS `hospital_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital_entries` (
  `Operation_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `List_ID` int(10) DEFAULT NULL,
  `Date_Admitted` datetime DEFAULT NULL,
  `Reason_for_admittal` varchar(100) DEFAULT NULL,
  `Admitted_by_ID` int(10) DEFAULT NULL,
  `Under_care_of_ID` int(10) DEFAULT NULL,
  `Nurse_ID` int(10) DEFAULT NULL,
  `Phone_Special` varchar(30) DEFAULT NULL,
  `Date_discharged` datetime DEFAULT NULL,
  `Status` varchar(2) DEFAULT NULL,
  `Inpatient` tinyint(1) NOT NULL,
  `Notes` longtext,
  `Communication` longtext,
  `Cancelled` tinyint(1) NOT NULL,
  `Cancellation_Reason` varchar(75) DEFAULT NULL,
  `Discharge_Details` longtext,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Operation_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Diary_ID` (`List_ID`) USING BTREE,
  KEY `Inpatient` (`Inpatient`) USING BTREE,
  KEY `Operation_ID` (`Operation_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57957 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_sheet`
--

DROP TABLE IF EXISTS `hospital_sheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital_sheet` (
  `Entry_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Operation_ID` int(10) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Temp` double DEFAULT NULL,
  `Pulse` varchar(50) DEFAULT NULL,
  `Respiration` varchar(50) DEFAULT NULL,
  `Vomiting` varchar(50) DEFAULT NULL,
  `Motions` varchar(50) DEFAULT NULL,
  `Urine` varchar(50) DEFAULT NULL,
  `Appetite` varchar(50) DEFAULT NULL,
  `Drink` varchar(50) DEFAULT NULL,
  `Medication_type` varchar(1) DEFAULT NULL,
  `Medication_ID` int(10) DEFAULT NULL,
  `Medication_quantity` double DEFAULT NULL,
  `Medication_freehand` varchar(50) DEFAULT NULL,
  `Medication_date` datetime DEFAULT NULL,
  `Medication_administered` tinyint(1) NOT NULL,
  `Comments` varchar(50) DEFAULT NULL,
  `User_ID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Entry_ID`),
  KEY `Entry_ID` (`Entry_ID`) USING BTREE,
  KEY `Medication_ID` (`Medication_ID`) USING BTREE,
  KEY `Operation_ID` (`Operation_ID`) USING BTREE,
  KEY `User_ID` (`User_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2137680268 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idexxbreedlist`
--

DROP TABLE IF EXISTS `idexxbreedlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idexxbreedlist` (
  `IdexxBreedListID` int(10) NOT NULL AUTO_INCREMENT,
  `Code` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `SpeciesCode` varchar(255) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`IdexxBreedListID`),
  KEY `IdexxBreedListID` (`IdexxBreedListID`),
  KEY `Code` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idexxpendingtests`
--

DROP TABLE IF EXISTS `idexxpendingtests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idexxpendingtests` (
  `IdexxPendingTestID` int(10) NOT NULL AUTO_INCREMENT,
  `OrderNumber` varchar(255) DEFAULT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`IdexxPendingTestID`),
  KEY `IdexxPendingTestID` (`IdexxPendingTestID`),
  KEY `TransactionID` (`TransactionID`),
  KEY `OrderNumber` (`OrderNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idexxreferenceversion`
--

DROP TABLE IF EXISTS `idexxreferenceversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idexxreferenceversion` (
  `IdexxReferenceVersionID` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Version` varchar(255) DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`IdexxReferenceVersionID`),
  KEY `IdexxReferenceVersionID` (`IdexxReferenceVersionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idexxspecieslist`
--

DROP TABLE IF EXISTS `idexxspecieslist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idexxspecieslist` (
  `IdexxSpeciesListID` int(10) NOT NULL AUTO_INCREMENT,
  `Code` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`IdexxSpeciesListID`),
  KEY `IdexxSpeciesListID` (`IdexxSpeciesListID`),
  KEY `Code` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idexxtestlist`
--

DROP TABLE IF EXISTS `idexxtestlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idexxtestlist` (
  `IdexxTestListID` int(10) NOT NULL AUTO_INCREMENT,
  `Code` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `ListPrice` decimal(19,4) DEFAULT NULL,
  `CurrencyCode` varchar(255) DEFAULT NULL,
  `Turnaround` varchar(255) DEFAULT NULL,
  `Specimen` varchar(5000) DEFAULT NULL,
  `AddOn` tinyint(1) DEFAULT NULL,
  `AllowsBatch` tinyint(1) DEFAULT NULL,
  `AllowsAddOns` tinyint(1) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  `DisplayCode` varchar(255) DEFAULT NULL,
  `InHouse` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`IdexxTestListID`),
  KEY `IdexxTestListID` (`IdexxTestListID`),
  KEY `Code` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idexxtestlistlinks`
--

DROP TABLE IF EXISTS `idexxtestlistlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idexxtestlistlinks` (
  `IdexxTestListLinkID` int(10) NOT NULL AUTO_INCREMENT,
  `IdexxTestListID` int(10) DEFAULT NULL,
  `ProcedureID` int(10) DEFAULT NULL,
  `PercentageMarkup` double DEFAULT NULL,
  `FeeMarkup` decimal(19,4) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`IdexxTestListLinkID`),
  KEY `IdexxTestListLinkID` (`IdexxTestListLinkID`),
  KEY `IdexxTestListID` (`IdexxTestListID`),
  KEY `ProcedureID` (`ProcedureID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `included_stock`
--

DROP TABLE IF EXISTS `included_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `included_stock` (
  `Included_stock_instance_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_item` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Multiplier` int(10) DEFAULT NULL,
  `Destock` tinyint(1) NOT NULL,
  `Add_price` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Included_stock_instance_ID`),
  KEY `Included_stock_instance_ID` (`Included_stock_instance_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2082323493 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance`
--

DROP TABLE IF EXISTS `insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance` (
  `Insurance_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Insurance_co_name` varchar(30) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Insurance_ID`),
  UNIQUE KEY `Insurance_co_name` (`Insurance_co_name`),
  KEY `Insurance_ID` (`Insurance_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2108553218 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_claims`
--

DROP TABLE IF EXISTS `insurance_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance_claims` (
  `Insurance_GUID` varchar(42) NOT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Query_GUID` varchar(42) DEFAULT NULL,
  `Practitioner_ID` int(10) DEFAULT NULL,
  `Recipient_GUID` varchar(42) DEFAULT NULL,
  `Notes` varchar(50) DEFAULT NULL,
  `Completed` datetime DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Insurance_GUID`),
  UNIQUE KEY `Insurance_GUID` (`Insurance_GUID`),
  UNIQUE KEY `Query_GUID` (`Query_GUID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Practitioner_ID` (`Practitioner_ID`) USING BTREE,
  KEY `Recipient_GUID` (`Recipient_GUID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_conditions`
--

DROP TABLE IF EXISTS `insurance_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance_conditions` (
  `Insurance_condition_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Claim_date` datetime DEFAULT NULL,
  `Description` varchar(80) DEFAULT NULL,
  `Treatment_date_from` datetime DEFAULT NULL,
  `Treatment_date_to` datetime DEFAULT NULL,
  `Total_ex_VAT` decimal(19,4) DEFAULT NULL,
  `VAT` decimal(19,4) DEFAULT NULL,
  `Total_incl_VAT` decimal(19,4) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Status` varchar(255) DEFAULT '',
  `AmountPaid` decimal(19,2) DEFAULT '0.00',
  PRIMARY KEY (`Insurance_condition_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Claim_date` (`Claim_date`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Insurance_condition_ID` (`Insurance_condition_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13593 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_policy_type`
--

DROP TABLE IF EXISTS `insurance_policy_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance_policy_type` (
  `Policy_type_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Insurance_ID` int(10) DEFAULT NULL,
  `Policy_type_text` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Policy_type_ID`),
  KEY `Insurance_ID` (`Insurance_ID`) USING BTREE,
  KEY `Policy_type_ID` (`Policy_type_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insuranceclaimtransactionlinks`
--

DROP TABLE IF EXISTS `insuranceclaimtransactionlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insuranceclaimtransactionlinks` (
  `LinkID` int(11) NOT NULL AUTO_INCREMENT,
  `InsuranceConditionID` int(11) DEFAULT NULL,
  `TransactionID` int(11) DEFAULT NULL,
  `TransactionLocation` int(11) DEFAULT NULL,
  PRIMARY KEY (`LinkID`),
  KEY `LinkID` (`LinkID`),
  KEY `InsuranceConditionID` (`InsuranceConditionID`),
  KEY `TransactionID` (`TransactionID`),
  KEY `TransactionLocation` (`TransactionLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=29797 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurancestatuslist`
--

DROP TABLE IF EXISTS `insurancestatuslist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurancestatuslist` (
  `InsuranceStatusListID` int(11) NOT NULL AUTO_INCREMENT,
  `StatusText` varchar(255) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`InsuranceStatusListID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoicecheck`
--

DROP TABLE IF EXISTS `invoicecheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoicecheck` (
  `InvoiceCheckID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT '0',
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`InvoiceCheckID`),
  UNIQUE KEY `InvoiceCheckID` (`InvoiceCheckID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `StartDate` (`StartDate`),
  KEY `EndDate` (`EndDate`),
  KEY `CreatedBy` (`CreatedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoicelinks`
--

DROP TABLE IF EXISTS `invoicelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoicelinks` (
  `InvoiceLinkID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `InvoiceLineID` int(10) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `TransactionType` int(10) DEFAULT NULL,
  `Amount` decimal(19,2) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`InvoiceLinkID`),
  UNIQUE KEY `InvoiceLinkID` (`InvoiceLinkID`),
  KEY `InvoiceLineID` (`InvoiceLineID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=820179 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `Invoice_ID` int(10) NOT NULL,
  `Invoice_Number` int(10) NOT NULL,
  `Invoice_Date` datetime DEFAULT NULL,
  `Practitioner_ID` int(10) NOT NULL,
  `Client_ID` int(10) NOT NULL,
  `Parent_Invoice_Line_ID` int(10) NOT NULL,
  PRIMARY KEY (`Invoice_ID`),
  UNIQUE KEY `Invoice_Number` (`Invoice_Number`),
  KEY `Invoice_Date` (`Invoice_Date`) USING BTREE,
  KEY `Invoice_ID` (`Invoice_ID`) USING BTREE,
  KEY `Practitioner_ID` (`Practitioner_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Parent_Invoice_Line_ID` (`Parent_Invoice_Line_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kennel`
--

DROP TABLE IF EXISTS `kennel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kennel` (
  `Kennel_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Arrival_date` datetime DEFAULT NULL,
  `Departure_date` datetime DEFAULT NULL,
  `Last_booster` datetime DEFAULT NULL,
  `Last_Intrac` datetime DEFAULT NULL,
  `Boarding_tariff` varchar(50) DEFAULT NULL,
  `Amount_per_day` decimal(19,4) DEFAULT NULL,
  `Extra_work_1_status` varchar(10) DEFAULT NULL,
  `Extra_work_2_status` varchar(10) DEFAULT NULL,
  `Extra_work_3_status` varchar(10) DEFAULT NULL,
  `Extra_work_4_status` varchar(10) DEFAULT NULL,
  `Extra_notes_1` varchar(5000) DEFAULT NULL,
  `Extra_notes_2` varchar(5000) DEFAULT NULL,
  `Extra_notes_3` varchar(5000) DEFAULT NULL,
  `Permanent_notes` varchar(5000) DEFAULT NULL,
  `Current_status` varchar(20) DEFAULT NULL,
  `Moves_required` varchar(5000) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Kennel_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Arrival_date` (`Arrival_date`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Current_status` (`Current_status`) USING BTREE,
  KEY `Departure_date` (`Departure_date`) USING BTREE,
  KEY `Kennel_ID` (`Kennel_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kennel_history`
--

DROP TABLE IF EXISTS `kennel_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kennel_history` (
  `Kennel_history_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Kennel_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Notes` varchar(80) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Kennel_history_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Kennel_history_ID` (`Kennel_history_ID`) USING BTREE,
  KEY `Kennel_ID` (`Kennel_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_abaxispricelist`
--

DROP TABLE IF EXISTS `lab_abaxispricelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_abaxispricelist` (
  `AbaxisPriceListID` int(10) NOT NULL AUTO_INCREMENT,
  `Section` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Replicate` tinyint(1) DEFAULT '0',
  `ValidFrom` datetime DEFAULT NULL,
  `Includes` varchar(5000) DEFAULT NULL,
  `Currency` varchar(255) DEFAULT NULL,
  `NonDiscountable` tinyint(1) DEFAULT '0',
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AbaxisPriceListID`)
) ENGINE=InnoDB AUTO_INCREMENT=428109 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_abaxissettings`
--

DROP TABLE IF EXISTS `lab_abaxissettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_abaxissettings` (
  `AbaxisSettingID` int(10) NOT NULL AUTO_INCREMENT,
  `SiteLocation` varchar(3) DEFAULT '',
  `BaseURL` varchar(255) DEFAULT '',
  `Username` varchar(255) DEFAULT '',
  `Password` varchar(255) DEFAULT '',
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AbaxisSettingID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_abaxisspecieslist`
--

DROP TABLE IF EXISTS `lab_abaxisspecieslist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_abaxisspecieslist` (
  `AbaxisSpecieID` int(10) NOT NULL AUTO_INCREMENT,
  `Specie` varchar(255) DEFAULT '',
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AbaxisSpecieID`)
) ENGINE=InnoDB AUTO_INCREMENT=125615 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_idexxprofiles`
--

DROP TABLE IF EXISTS `lab_idexxprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_idexxprofiles` (
  `ProfileID` int(11) NOT NULL AUTO_INCREMENT,
  `Analyser` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Includes` varchar(1000) DEFAULT NULL,
  `DisplayOrder` int(11) DEFAULT '1',
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ProfileID`),
  KEY `Code` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_milabprofiles`
--

DROP TABLE IF EXISTS `lab_milabprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_milabprofiles` (
  `ProfileID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `Includes` varchar(1000) DEFAULT NULL,
  `DisplayOrder` int(11) DEFAULT '1',
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ProfileID`),
  KEY `Code` (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_settings`
--

DROP TABLE IF EXISTS `lab_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_settings` (
  `LabID` int(11) NOT NULL AUTO_INCREMENT,
  `LabName` varchar(255) DEFAULT NULL,
  `SiteLocation` varchar(3) DEFAULT NULL,
  `RequestsDirectory` varchar(255) DEFAULT NULL,
  `ResultsDirectory` varchar(255) DEFAULT NULL,
  `ResultsPDFDirectory` varchar(255) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`LabID`),
  KEY `LabName` (`LabName`),
  KEY `SiteLocation` (`SiteLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labels`
--

DROP TABLE IF EXISTS `labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labels` (
  `LabelID` int(11) NOT NULL AUTO_INCREMENT,
  `TransactionID` int(10) DEFAULT NULL,
  `Date` varchar(255) DEFAULT NULL,
  `Client` varchar(255) DEFAULT NULL,
  `Animal` varchar(255) DEFAULT NULL,
  `Quantity` varchar(255) DEFAULT NULL,
  `Drug` varchar(255) DEFAULT NULL,
  `DoseWarn1` varchar(255) DEFAULT NULL,
  `DoseWarn2` varchar(255) DEFAULT NULL,
  `DoseWarn3` varchar(255) DEFAULT NULL,
  `DoseWarn4` varchar(255) DEFAULT NULL,
  `Action1` varchar(255) DEFAULT NULL,
  `Action1Practitioner` varchar(255) DEFAULT NULL,
  `Action2` varchar(255) DEFAULT NULL,
  `Action2Practitioner` varchar(255) DEFAULT NULL,
  `Action3` varchar(255) DEFAULT NULL,
  `Action3Practitioner` varchar(255) DEFAULT NULL,
  `RCVSnumber` varchar(255) DEFAULT NULL,
  `NumberOfLabels` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`LabelID`)
) ENGINE=InnoDB AUTO_INCREMENT=304213 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labrequests`
--

DROP TABLE IF EXISTS `labrequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labrequests` (
  `LabRequestID` int(10) NOT NULL AUTO_INCREMENT,
  `LabOrderID` varchar(255) DEFAULT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `RequestTransactionID` int(10) DEFAULT NULL,
  `Lab` varchar(255) DEFAULT NULL,
  `CreatedBy` int(255) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `Notes` varchar(500) DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `DateCompleted` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`LabRequestID`),
  UNIQUE KEY `LabRequestID` (`LabRequestID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `RequestTransactionID` (`RequestTransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=11261 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labresults`
--

DROP TABLE IF EXISTS `labresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labresults` (
  `LabResultID` int(11) NOT NULL AUTO_INCREMENT,
  `LabRequestID` int(11) DEFAULT NULL,
  `LabRef` varchar(500) DEFAULT NULL,
  `TransactionID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `TestCode` varchar(255) DEFAULT NULL,
  `TestName` varchar(255) DEFAULT NULL,
  `TestType` varchar(255) DEFAULT NULL,
  `AnalyteCode` varchar(255) DEFAULT NULL,
  `AnalyteName` varchar(255) DEFAULT NULL,
  `ResultDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Result` decimal(19,2) DEFAULT NULL,
  `ResultText` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ResultStatus` varchar(255) DEFAULT NULL,
  `Units` varchar(255) DEFAULT NULL,
  `LowRange` decimal(19,2) DEFAULT NULL,
  `HighRange` decimal(19,2) DEFAULT NULL,
  `Notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Alert` varchar(255) DEFAULT NULL,
  `Colour` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LabResultID`),
  KEY `TransactionID` (`TransactionID`),
  KEY `ResultDate` (`ResultDate`)
) ENGINE=InnoDB AUTO_INCREMENT=1619365 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `LabResults__beforeupdate` BEFORE UPDATE ON `labresults` FOR EACH ROW INSERT INTO `LabResults:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', LabResults.*
                            FROM LabResults WHERE LabResults.LabResultID = OLD.LabResultID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `LabResults__beforedelete` BEFORE DELETE ON `labresults` FOR EACH ROW INSERT INTO `LabResults:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', LabResults.* 
                            FROM LabResults WHERE LabResults.LabResultID = OLD.LabResultID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `labresults:deletes`
--

DROP TABLE IF EXISTS `labresults:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labresults:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `LabResultID` int(11) NOT NULL,
  `LabRequestID` int(11) DEFAULT NULL,
  `LabRef` varchar(500) DEFAULT NULL,
  `TransactionID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `TestCode` varchar(255) DEFAULT NULL,
  `TestName` varchar(255) DEFAULT NULL,
  `TestType` varchar(255) DEFAULT NULL,
  `AnalyteCode` varchar(255) DEFAULT NULL,
  `AnalyteName` varchar(255) DEFAULT NULL,
  `ResultDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Result` decimal(19,5) DEFAULT NULL,
  `ResultText` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ResultStatus` varchar(255) DEFAULT NULL,
  `Units` varchar(255) DEFAULT NULL,
  `LowRange` decimal(19,2) DEFAULT NULL,
  `HighRange` decimal(19,2) DEFAULT NULL,
  `Notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Alert` varchar(255) DEFAULT NULL,
  `Colour` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`),
  KEY `TransactionID` (`TransactionID`),
  KEY `ResultDate` (`ResultDate`)
) ENGINE=InnoDB AUTO_INCREMENT=2879 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labresults:edits`
--

DROP TABLE IF EXISTS `labresults:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labresults:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `LabResultID` int(11) NOT NULL,
  `LabRequestID` int(11) DEFAULT NULL,
  `LabRef` varchar(500) DEFAULT NULL,
  `TransactionID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `TestCode` varchar(255) DEFAULT NULL,
  `TestName` varchar(255) DEFAULT NULL,
  `TestType` varchar(255) DEFAULT NULL,
  `AnalyteCode` varchar(255) DEFAULT NULL,
  `AnalyteName` varchar(255) DEFAULT NULL,
  `ResultDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Result` decimal(19,5) DEFAULT NULL,
  `ResultText` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ResultStatus` varchar(255) DEFAULT NULL,
  `Units` varchar(255) DEFAULT NULL,
  `LowRange` decimal(19,2) DEFAULT NULL,
  `HighRange` decimal(19,2) DEFAULT NULL,
  `Notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Alert` varchar(255) DEFAULT NULL,
  `Colour` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`),
  KEY `TransactionID` (`TransactionID`),
  KEY `ResultDate` (`ResultDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labresultsunassigned`
--

DROP TABLE IF EXISTS `labresultsunassigned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labresultsunassigned` (
  `LabResultID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` varchar(255) DEFAULT NULL,
  `IdentifierInfo` varchar(500) DEFAULT NULL,
  `Lab` varchar(255) DEFAULT NULL,
  `LabRef` varchar(500) DEFAULT NULL,
  `TestCode` varchar(255) DEFAULT NULL,
  `TestName` varchar(255) DEFAULT NULL,
  `TestType` varchar(255) DEFAULT NULL,
  `AnalyteCode` varchar(255) DEFAULT NULL,
  `AnalyteName` varchar(255) DEFAULT NULL,
  `ResultDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Result` decimal(19,5) DEFAULT NULL,
  `ResultText` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ResultStatus` varchar(255) DEFAULT NULL,
  `Units` varchar(255) DEFAULT NULL,
  `LowRange` decimal(19,2) DEFAULT NULL,
  `HighRange` decimal(19,2) DEFAULT NULL,
  `Notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Alert` varchar(255) DEFAULT NULL,
  `Colour` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LabResultID`),
  KEY `ResultDate` (`ResultDate`),
  KEY `IdentifierInfo` (`IdentifierInfo`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=763 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_invoicerun`
--

DROP TABLE IF EXISTS `log_invoicerun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_invoicerun` (
  `InvoiceRunID` int(10) NOT NULL AUTO_INCREMENT,
  `RunStartTime` datetime DEFAULT NULL,
  `RunEndTime` datetime DEFAULT NULL,
  `BillingParameters` longtext,
  `PractitionerInitials` varchar(3) DEFAULT NULL,
  `WorkstationFolder` varchar(255) DEFAULT NULL,
  `ClientDepartment` int(10) DEFAULT NULL,
  `StartingInvoiceNumber` int(10) DEFAULT NULL,
  `EndingInvoiceNumber` int(10) DEFAULT NULL,
  `StartingStatementNumber` int(10) DEFAULT NULL,
  `EndingStatementNumber` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`InvoiceRunID`),
  UNIQUE KEY `InvoiceRunID` (`InvoiceRunID`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_movework`
--

DROP TABLE IF EXISTS `log_movework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_movework` (
  `MoveWorkID` int(10) NOT NULL AUTO_INCREMENT,
  `SessionID` varchar(36) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `OldClientID` int(10) DEFAULT NULL,
  `OldAnimalID` int(10) DEFAULT NULL,
  `NewClientID` int(10) DEFAULT NULL,
  `NewAnimalID` int(10) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `PractitionerInitials` varchar(3) DEFAULT NULL,
  `Table` varchar(255) DEFAULT 'Transactions',
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MoveWorkID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loginconfig`
--

DROP TABLE IF EXISTS `loginconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loginconfig` (
  `LoginConfigID` int(11) NOT NULL AUTO_INCREMENT,
  `ConfigSetting` varchar(255) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `ModifiedOn` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `ModifiedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`LoginConfigID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `macrov1`
--

DROP TABLE IF EXISTS `macrov1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `macrov1` (
  `Macro_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Description` varchar(30) DEFAULT NULL,
  `Command` varchar(200) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Macro_ID`),
  KEY `Macro_ID` (`Macro_ID`) USING BTREE,
  KEY `Procedure_ID` (`Procedure_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2141411025 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `macrov2`
--

DROP TABLE IF EXISTS `macrov2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `macrov2` (
  `MacroLineID` int(10) NOT NULL AUTO_INCREMENT,
  `ProcedureID` int(10) DEFAULT NULL,
  `SingleSelection` tinyint(1) DEFAULT NULL,
  `XferCostToProcedure` tinyint(1) DEFAULT NULL,
  `ItemType` varchar(1) DEFAULT NULL,
  `ItemReference` varchar(10) DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Ask` tinyint(1) DEFAULT NULL,
  `Mult` tinyint(1) DEFAULT NULL,
  `Free` tinyint(1) DEFAULT NULL,
  `GroupID` int(10) DEFAULT NULL,
  `LineIndex` double DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MacroLineID`),
  KEY `MacroLineID` (`MacroLineID`),
  KEY `ProcedureID` (`ProcedureID`),
  KEY `GroupID` (`GroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=9611 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manufacturer`
--

DROP TABLE IF EXISTS `manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufacturer` (
  `Manufacturer_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Manufacturer_Name` varchar(50) DEFAULT NULL,
  `Telephone_Number` varchar(50) DEFAULT NULL,
  `Fax_Number` varchar(50) DEFAULT NULL,
  `Modem_Number` varchar(50) DEFAULT NULL,
  `Email_Address` varchar(50) DEFAULT NULL,
  `Contact_Name` varchar(50) DEFAULT NULL,
  `House_Number` varchar(50) DEFAULT NULL,
  `Address_1` varchar(50) DEFAULT NULL,
  `Address_2` varchar(50) DEFAULT NULL,
  `Address_3` varchar(50) DEFAULT NULL,
  `Address_4` varchar(50) DEFAULT NULL,
  `Postcode` varchar(10) DEFAULT NULL,
  `Website_URL` varchar(50) DEFAULT NULL,
  `Delivery_Charge` decimal(19,4) DEFAULT NULL,
  `Billing_Terms` varchar(50) DEFAULT NULL,
  `Notes` longtext,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Manufacturer_ID`),
  KEY `Manufacturer_ID` (`Manufacturer_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `memos`
--

DROP TABLE IF EXISTS `memos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `memos` (
  `Memo_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_or_Animal` varchar(1) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Memo_text` varchar(5000) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DisplayIndex` int(10) DEFAULT '0',
  PRIMARY KEY (`Memo_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Memo_ID` (`Memo_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=152797 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modeussettings`
--

DROP TABLE IF EXISTS `modeussettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modeussettings` (
  `SettID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteLocation` varchar(3) DEFAULT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `DateCreated` datetime DEFAULT NULL,
  PRIMARY KEY (`SettID`),
  KEY `SiteLocation` (`SiteLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moduleusage`
--

DROP TABLE IF EXISTS `moduleusage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moduleusage` (
  `ModuleUsageID` int(11) NOT NULL AUTO_INCREMENT,
  `Workstation` varchar(255) DEFAULT NULL,
  `WorkstationFolder` varchar(255) DEFAULT NULL,
  `PractitionerID` int(11) DEFAULT NULL,
  `LastActiveDate` datetime DEFAULT NULL,
  `LastActiveModule` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ModuleUsageID`),
  UNIQUE KEY `_IdentifierFields` (`Workstation`,`WorkstationFolder`,`PractitionerID`),
  KEY `PractitionerID` (`PractitionerID`)
) ENGINE=InnoDB AUTO_INCREMENT=7489385 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `new_batch_numbers`
--

DROP TABLE IF EXISTS `new_batch_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `new_batch_numbers` (
  `Batch_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_ID` int(10) DEFAULT NULL,
  `Last_used` datetime DEFAULT NULL,
  `Batch_number` varchar(30) DEFAULT NULL,
  `Expiry_date` datetime DEFAULT NULL,
  `Amount_remaining` double DEFAULT NULL,
  `Supplier_ID` int(10) DEFAULT NULL,
  `Drug_location_ID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Batch_ID`),
  KEY `Batch_ID` (`Batch_ID`) USING BTREE,
  KEY `Batch_number` (`Batch_number`) USING BTREE,
  KEY `Expiry_date` (`Expiry_date`) USING BTREE,
  KEY `Last_used` (`Last_used`) USING BTREE,
  KEY `Stock_ID` (`Stock_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3961 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notes_trigger`
--

DROP TABLE IF EXISTS `notes_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes_trigger` (
  `Notes_trigger_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Text` varchar(50) DEFAULT NULL,
  `Multiplication_factor` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Notes_trigger_ID`),
  KEY `Notes_trigger_ID` (`Notes_trigger_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oldstuff`
--

DROP TABLE IF EXISTS `oldstuff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oldstuff` (
  `Transaction_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  PRIMARY KEY (`Transaction_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Date_entered` (`Date_entered`) USING BTREE,
  KEY `Department` (`Client_department_ID`) USING BTREE,
  KEY `Department1` (`Accounts_category_ID`) USING BTREE,
  KEY `Details` (`Details`) USING BTREE,
  KEY `Invoice_date` (`Invoice_date`) USING BTREE,
  KEY `Transaction_ID` (`Transaction_ID`) USING BTREE,
  KEY `Work_done_by` (`Work_done_by`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onpaymentdiscounts`
--

DROP TABLE IF EXISTS `onpaymentdiscounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `onpaymentdiscounts` (
  `OnPaymentDiscountID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `DiscountID` int(10) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `NetAmount` decimal(19,2) DEFAULT '0.00',
  `VATAmount` decimal(19,2) DEFAULT '0.00',
  `TotalAmount` decimal(19,2) DEFAULT '0.00',
  `DiscountPercentage` double DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`OnPaymentDiscountID`),
  UNIQUE KEY `OnPaymentDiscountID` (`OnPaymentDiscountID`),
  KEY `DiscountID` (`DiscountID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `Operation_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Op_date` datetime DEFAULT NULL,
  `Op_time` datetime DEFAULT NULL,
  `Details` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Operation_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_number`
--

DROP TABLE IF EXISTS `order_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_number` (
  `Order_number_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Supplier_ID` int(10) DEFAULT NULL,
  `Date_purchased` datetime DEFAULT NULL,
  `Purchase_Order_Number` varchar(15) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Order_number_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2145844985 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_type`
--

DROP TABLE IF EXISTS `payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_type` (
  `Payment_type_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Payment_text` varchar(15) DEFAULT NULL,
  `SurchargePercentage` int(10) DEFAULT '0',
  `SurchargeDepts` varchar(255) DEFAULT '',
  `SurchargeIfLessThan` decimal(19,2) DEFAULT '0.00',
  `SurchargeIfMoreThan` decimal(19,2) DEFAULT '0.00',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Payment_type_ID`),
  KEY `Payment_type_ID` (`Payment_type_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1644940101 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentallocations`
--

DROP TABLE IF EXISTS `paymentallocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentallocations` (
  `PaymentAllocationID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `PaymentID` int(10) DEFAULT NULL,
  `ReceiptID` int(10) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `Amount` decimal(19,2) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PaymentAllocationID`),
  UNIQUE KEY `PaymentAllocationID` (`PaymentAllocationID`),
  KEY `PaymentID` (`PaymentID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=668753 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentallocations:reversed`
--

DROP TABLE IF EXISTS `paymentallocations:reversed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentallocations:reversed` (
  `ReversedID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `PaymentID` int(10) DEFAULT NULL,
  `ReceiptID` int(10) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `Amount` decimal(19,2) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReversedID`),
  UNIQUE KEY `ReversedID` (`ReversedID`),
  KEY `PaymentID` (`PaymentID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=2707 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentallocations_pending`
--

DROP TABLE IF EXISTS `paymentallocations_pending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentallocations_pending` (
  `PaymentAllocationPendingID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `Amount` decimal(19,4) DEFAULT NULL,
  `WebPaymentUrlID` int(11) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PaymentAllocationPendingID`),
  UNIQUE KEY `PaymentAllocationPendingID` (`PaymentAllocationPendingID`),
  KEY `TransactionID` (`TransactionID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `WebPaymentUrlID` (`WebPaymentUrlID`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdfs`
--

DROP TABLE IF EXISTS `pdfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdfs` (
  `PDF_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Type` varchar(255) DEFAULT '',
  `Client_ID` int(10) DEFAULT NULL,
  `Invoice_number` varchar(15) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `Filename` varchar(255) DEFAULT NULL,
  `Printed` tinyint(1) NOT NULL,
  `DatePrinted` datetime DEFAULT NULL,
  `Email_address` varchar(255) DEFAULT NULL,
  `Status` varchar(40) DEFAULT NULL,
  `Date_created` datetime DEFAULT NULL,
  `Date_sent` datetime DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PDF_ID`),
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `PDF_ID` (`PDF_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=427945 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `php_instance`
--

DROP TABLE IF EXISTS `php_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `php_instance` (
  `PHP_instance_ID` int(10) NOT NULL AUTO_INCREMENT,
  `PHP_Procedure_ID` int(10) DEFAULT NULL,
  `Plan_start_date` datetime DEFAULT NULL,
  `Plan_end_date` datetime DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Active` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `LastEdited` datetime DEFAULT NULL,
  `LastEditedBy` varchar(3) DEFAULT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  `OnHold` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`PHP_instance_ID`),
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `PHP_instance_ID` (`PHP_instance_ID`) USING BTREE,
  KEY `PHP_Procedure_ID` (`PHP_Procedure_ID`) USING BTREE,
  KEY `Plan_end_date` (`Plan_end_date`) USING BTREE,
  KEY `Plan_start_date` (`Plan_start_date`) USING BTREE,
  KEY `Animal_ID` (`Animal_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phpallocations`
--

DROP TABLE IF EXISTS `phpallocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpallocations` (
  `PHPAllocationID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `PHPInstanceID` int(10) DEFAULT NULL,
  `ItemRef` varchar(255) DEFAULT NULL,
  `ItemType` varchar(1) DEFAULT NULL,
  `Allowed` double DEFAULT NULL,
  `Had` double DEFAULT NULL,
  `GroupID` int(10) DEFAULT NULL,
  `LastEdited` datetime DEFAULT NULL,
  `LastEditedBy` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PHPAllocationID`),
  UNIQUE KEY `PHPAllocationID` (`PHPAllocationID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `GroupID` (`GroupID`),
  KEY `ItemRef` (`ItemRef`) USING BTREE,
  KEY `ItemType` (`ItemType`) USING BTREE,
  KEY `PHPInstanceID` (`PHPInstanceID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phpsavings`
--

DROP TABLE IF EXISTS `phpsavings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phpsavings` (
  `PHPSavingsID` int(11) NOT NULL AUTO_INCREMENT,
  `TransactionID` int(11) NOT NULL,
  `OriginalPrice` decimal(19,2) NOT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PHPSavingsID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postcode`
--

DROP TABLE IF EXISTS `postcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postcode` (
  `Postcode` varchar(15) NOT NULL,
  `Street` varchar(50) DEFAULT NULL,
  `Locality` varchar(50) DEFAULT NULL,
  `Posttown` varchar(50) DEFAULT NULL,
  `County` varchar(50) DEFAULT NULL,
  `Street_numbers` longtext,
  PRIMARY KEY (`Postcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `practitioner`
--

DROP TABLE IF EXISTS `practitioner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `practitioner` (
  `Practitioner_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Practitioner_initials` varchar(3) DEFAULT NULL,
  `Practitioner_full_name` varchar(50) DEFAULT NULL,
  `Password` varchar(256) DEFAULT NULL,
  `PasswordDate` datetime DEFAULT NULL,
  `User_class_ID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `VetFormularyKey` varchar(255) DEFAULT NULL,
  `RCVSnumber` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Practitioner_ID`),
  UNIQUE KEY `Practitioner_initials` (`Practitioner_initials`),
  KEY `Password` (`Password`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2009754615 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescription` (
  `Prescription_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Expiry_date` datetime DEFAULT NULL,
  `Repeats_allowed` int(10) DEFAULT NULL,
  `Repeats_had` int(10) DEFAULT NULL,
  `Last_edited_initials` varchar(3) DEFAULT NULL,
  `Last_edited_date` datetime DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Frequency` int(10) DEFAULT '0',
  `FrequencyUnit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Prescription_ID`),
  KEY `Prescription_ID` (`Prescription_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13577 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescription_history`
--

DROP TABLE IF EXISTS `prescription_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescription_history` (
  `Prescription_history_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Prescription_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Text` varchar(500) DEFAULT NULL,
  `Initials` varchar(3) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Prescription_history_ID`),
  KEY `Prescription_history_ID` (`Prescription_history_ID`) USING BTREE,
  KEY `Prescription_ID` (`Prescription_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35217 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescription_line`
--

DROP TABLE IF EXISTS `prescription_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescription_line` (
  `Prescription_line_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Prescription_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Substock_ID` int(10) DEFAULT NULL,
  `Quantity` double DEFAULT NULL,
  `Text` varchar(255) DEFAULT NULL,
  `Dosage` varchar(255) DEFAULT NULL,
  `Warning1` varchar(255) DEFAULT NULL,
  `Warning2` varchar(255) DEFAULT NULL,
  `Warning3` varchar(255) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Prescription_line_ID`),
  KEY `Prescription_ID` (`Prescription_ID`) USING BTREE,
  KEY `Prescription_line_ID` (`Prescription_line_ID`) USING BTREE,
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Substock_ID` (`Substock_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14243 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `price_band`
--

DROP TABLE IF EXISTS `price_band`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_band` (
  `Price_band_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Band_start` smallint(5) DEFAULT NULL,
  `Band_finish` smallint(5) DEFAULT NULL,
  `Each_or_flat` varchar(1) DEFAULT NULL,
  `Price` decimal(19,4) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Price_band_ID`),
  KEY `Price_band_ID` (`Price_band_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedure`
--

DROP TABLE IF EXISTS `procedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedure` (
  `Procedure_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Procedure_text` varchar(50) DEFAULT NULL,
  `Procedure_ref` varchar(10) DEFAULT NULL,
  `Price_each` decimal(19,4) DEFAULT NULL,
  `VAT_Rate` varchar(1) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Force_weight_entry` tinyint(1) NOT NULL,
  `Transaction_text` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `QuantityInTransactionText` tinyint(1) DEFAULT '1',
  `PhpAddPriceOnSignup` tinyint(1) DEFAULT NULL,
  `PhpPricePerMonth` tinyint(1) DEFAULT NULL,
  `PHPCategory` int(11) DEFAULT NULL,
  `Procedure_notes` mediumtext,
  `BlockFractionCharging` tinyint(1) DEFAULT '0',
  `FontBold` tinyint(1) DEFAULT '0',
  `FontItalic` tinyint(1) DEFAULT '0',
  `FontUnderline` tinyint(1) DEFAULT '0',
  `FontColour` varchar(255) DEFAULT NULL,
  `FontSize` int(11) DEFAULT NULL,
  PRIMARY KEY (`Procedure_ID`),
  UNIQUE KEY `Procedure_ref` (`Procedure_ref`),
  KEY `Procedure_ID` (`Procedure_ID`) USING BTREE,
  KEY `Procedure_text` (`Procedure_text`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2136283463 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protocol`
--

DROP TABLE IF EXISTS `protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protocol` (
  `Protocol_ID` int(11) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Protocol_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protocol_question`
--

DROP TABLE IF EXISTS `protocol_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protocol_question` (
  `Protocol_question_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Protocol_ID` int(10) DEFAULT NULL,
  `Question_text` varchar(50) DEFAULT NULL,
  `Freehand_or_what` varchar(1) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Macro_ID` int(10) DEFAULT NULL,
  `Preceding_or_surrounding_text` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Protocol_question_ID`),
  KEY `Protocol_ID` (`Protocol_ID`) USING BTREE,
  KEY `Protocol_question_ID` (`Protocol_question_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purepetfoodconfig`
--

DROP TABLE IF EXISTS `purepetfoodconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purepetfoodconfig` (
  `PurePetFoodConfigID` int(11) NOT NULL AUTO_INCREMENT,
  `ConfigName` varchar(255) DEFAULT NULL,
  `Value` varchar(255) NOT NULL DEFAULT '',
  `TS` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PurePetFoodConfigID`),
  KEY `ConfigName` (`ConfigName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purepetfoodlog`
--

DROP TABLE IF EXISTS `purepetfoodlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purepetfoodlog` (
  `PurePetFoodLogID` int(11) NOT NULL AUTO_INCREMENT,
  `PractitionerID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT NULL,
  `ReferringPractice` varchar(255) DEFAULT NULL,
  `ReferringPractitioner` varchar(255) DEFAULT NULL,
  `ClientName` varchar(255) DEFAULT NULL,
  `EmailAddress` varchar(255) DEFAULT NULL,
  `DogName` varchar(255) DEFAULT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `FoodAllergies` varchar(500) DEFAULT NULL,
  `Ailments` varchar(500) DEFAULT NULL,
  `EmailBody` varchar(5000) DEFAULT NULL,
  `Link` varchar(1000) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PurePetFoodLogID`),
  KEY `PurePetFoodLogID` (`PurePetFoodLogID`),
  KEY `PractitionerID` (`PractitionerID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rankedclientspendingbands`
--

DROP TABLE IF EXISTS `rankedclientspendingbands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rankedclientspendingbands` (
  `RankID` int(11) NOT NULL AUTO_INCREMENT,
  `Caption` varchar(255) DEFAULT NULL,
  `MinimumSpend` decimal(19,2) DEFAULT '0.00',
  `MaximumSpend` decimal(19,2) DEFAULT '0.00',
  `IconToDisplay` varchar(255) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(255) DEFAULT '0',
  `TS` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`RankID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recall_instance`
--

DROP TABLE IF EXISTS `recall_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recall_instance` (
  `Recall_instance_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Recall_type_ID` int(10) DEFAULT NULL,
  `Recall_entered_on` datetime DEFAULT NULL,
  `Recall_due_on` datetime DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ReminderCounter` decimal(10,3) DEFAULT NULL,
  `Method` varchar(20) DEFAULT NULL,
  `ReminderCreated` datetime DEFAULT NULL,
  PRIMARY KEY (`Recall_instance_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Recall_due_on` (`Recall_due_on`) USING BTREE,
  KEY `Recall_entered_on` (`Recall_entered_on`) USING BTREE,
  KEY `Recall_instance_ID` (`Recall_instance_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=94233 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recall_trigger`
--

DROP TABLE IF EXISTS `recall_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recall_trigger` (
  `Recall_trigger` int(10) NOT NULL AUTO_INCREMENT,
  `Recall_type_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Recall_trigger`)
) ENGINE=InnoDB AUTO_INCREMENT=1651972485 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recall_type`
--

DROP TABLE IF EXISTS `recall_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recall_type` (
  `Recall_type_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Recall_text` varchar(30) DEFAULT NULL,
  `Recall_interval` smallint(5) DEFAULT NULL,
  `Next_recall_type` int(10) DEFAULT NULL,
  `File_to_use_1st_reminder` varchar(50) DEFAULT NULL,
  `File_to_use_2nd_reminder` varchar(50) DEFAULT NULL,
  `File_to_use_3rd_reminder` varchar(50) DEFAULT NULL,
  `File_to_use_4th_reminder` varchar(255) DEFAULT 'Recall4.rtf',
  `File_to_use_5th_reminder` varchar(255) DEFAULT 'Recall5.rtf',
  `AlternativeLetter` tinyint(1) DEFAULT '0',
  `MinimumAge` varchar(255) DEFAULT '',
  `MaximumAge` varchar(255) DEFAULT '',
  `Filename` varchar(255) DEFAULT '',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Recall_type_ID`),
  KEY `Recall_text` (`Recall_text`) USING BTREE,
  KEY `Recall_type_ID` (`Recall_type_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recallprofiles`
--

DROP TABLE IF EXISTS `recallprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recallprofiles` (
  `RecallProfileID` int(10) NOT NULL AUTO_INCREMENT,
  `ProfileName` varchar(255) DEFAULT NULL,
  `Canine` tinyint(1) DEFAULT '1',
  `Feline` tinyint(1) DEFAULT '1',
  `Rabbit` tinyint(1) DEFAULT '1',
  `Equine` tinyint(1) DEFAULT '1',
  `Other` tinyint(1) DEFAULT '1',
  `RecallTypes` varchar(5000) DEFAULT NULL,
  `ClientDepartments` varchar(5000) DEFAULT NULL,
  `StartSurname` varchar(255) DEFAULT NULL,
  `EndSurname` varchar(255) DEFAULT NULL,
  `Email` int(10) DEFAULT '0',
  `SMS` int(10) DEFAULT '0',
  `Letter` int(10) DEFAULT '0',
  `Label` int(10) DEFAULT '0',
  `AutomatedRun` tinyint(1) DEFAULT '0',
  `NoticePeriod` int(10) DEFAULT '28',
  `NotificationTime` time DEFAULT NULL,
  `ManualPrintouts` tinyint(1) DEFAULT '1',
  `TmailError` tinyint(1) DEFAULT '1',
  `TmailPrintoutRequired` tinyint(1) DEFAULT '1',
  `TmailUsers` varchar(5000) DEFAULT NULL,
  `RecallRun` int(11) DEFAULT '1',
  `OneRecallPerClient` tinyint(1) DEFAULT '1',
  `LabelForAnimal` tinyint(1) DEFAULT '0',
  `PrintLabelOnSLP` tinyint(1) DEFAULT '0',
  `AppStartupPath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RecallProfileID`),
  UNIQUE KEY `ProfileName` (`ProfileName`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referringvet`
--

DROP TABLE IF EXISTS `referringvet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referringvet` (
  `ReferringVetID` int(10) NOT NULL AUTO_INCREMENT,
  `VetName` varchar(150) DEFAULT NULL,
  `ReferringPracticeID` int(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`ReferringVetID`),
  KEY `ReferringPracticeID` (`ReferringPracticeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `refundallocations`
--

DROP TABLE IF EXISTS `refundallocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refundallocations` (
  `RefundAllocationID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `RefundID` int(10) DEFAULT NULL,
  `TransactionID` int(10) DEFAULT NULL,
  `Amount` decimal(19,2) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`RefundAllocationID`),
  UNIQUE KEY `RefundAllocationID` (`RefundAllocationID`),
  KEY `RefundID` (`RefundID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=15229 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reminderinstance`
--

DROP TABLE IF EXISTS `reminderinstance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminderinstance` (
  `ReminderInstanceID` int(10) NOT NULL AUTO_INCREMENT,
  `ReminderTypeID` int(10) DEFAULT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `Interval` int(10) DEFAULT NULL,
  `IntervalType` varchar(255) DEFAULT 'm',
  `ReminderDueOn` datetime DEFAULT NULL,
  `LastReminderDate` datetime DEFAULT NULL,
  `ReminderFormat` int(10) DEFAULT NULL,
  `MobileNumber` varchar(15) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`ReminderInstanceID`),
  KEY `ReminderTypeID` (`ReminderTypeID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `Interval` (`Interval`),
  KEY `ReminderDueOn` (`ReminderDueOn`)
) ENGINE=InnoDB AUTO_INCREMENT=6333 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remindertrigger`
--

DROP TABLE IF EXISTS `remindertrigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remindertrigger` (
  `ReminderTriggerID` int(10) NOT NULL AUTO_INCREMENT,
  `ReminderTypeID` int(10) DEFAULT NULL,
  `StockorProcedure` varchar(1) DEFAULT NULL,
  `ItemID` int(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`ReminderTriggerID`)
) ENGINE=InnoDB AUTO_INCREMENT=17079 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remindertype`
--

DROP TABLE IF EXISTS `remindertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remindertype` (
  `ReminderTypeID` int(10) NOT NULL AUTO_INCREMENT,
  `TypeText` varchar(30) DEFAULT NULL,
  `RecallsToReplace` varchar(255) DEFAULT NULL,
  `Export` tinyint(1) DEFAULT NULL,
  `Details` varchar(50) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  `DefaultInterval` int(10) DEFAULT '0',
  `DefaultIntervalType` varchar(255) DEFAULT 'm',
  `NoticePeriod` int(10) DEFAULT '0',
  `ReminderFormat` int(10) DEFAULT '0',
  PRIMARY KEY (`ReminderTypeID`),
  UNIQUE KEY `TypeText` (`TypeText`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `requiredfields`
--

DROP TABLE IF EXISTS `requiredfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requiredfields` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Table` varchar(255) DEFAULT NULL,
  `FieldName` varchar(255) DEFAULT NULL,
  `DisplayName` varchar(255) DEFAULT NULL,
  `Workstation` varchar(255) DEFAULT NULL,
  `Required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `routeofadmin`
--

DROP TABLE IF EXISTS `routeofadmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routeofadmin` (
  `RouteOfAdminID` int(10) NOT NULL AUTO_INCREMENT,
  `Text` varchar(255) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`RouteOfAdminID`),
  KEY `Text` (`Text`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sagedepartments`
--

DROP TABLE IF EXISTS `sagedepartments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sagedepartments` (
  `SageDepartmentID` int(11) NOT NULL AUTO_INCREMENT,
  `DepartmentNumber` int(11) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `MappingType` varchar(255) DEFAULT NULL,
  `Mapping` mediumtext,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`SageDepartmentID`),
  KEY `MappingType` (`MappingType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sageexportsettings`
--

DROP TABLE IF EXISTS `sageexportsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sageexportsettings` (
  `SageExportSettingID` int(11) NOT NULL AUTO_INCREMENT,
  `Command` varchar(255) DEFAULT NULL,
  `CustomerRef` varchar(255) DEFAULT NULL,
  `LastExport` varchar(255) DEFAULT NULL,
  `SpecialClientIDs` varchar(255) DEFAULT NULL,
  `SageDepartmentMappingType` varchar(255) DEFAULT NULL,
  `DefaultSalesNominalCode` varchar(8) DEFAULT NULL,
  `DefaultBankNominalCode` varchar(8) DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SageExportSettingID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sagenominalcodes`
--

DROP TABLE IF EXISTS `sagenominalcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sagenominalcodes` (
  `SageNominalCodeID` int(11) NOT NULL AUTO_INCREMENT,
  `NominalCode` varchar(8) DEFAULT NULL,
  `NominalCodeType` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `TransactionType` varchar(255) DEFAULT NULL,
  `SageDepartmentNumbers` mediumtext,
  `SageExportSettingID` int(255) DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  `TransactionChargeType` varchar(255) DEFAULT '',
  PRIMARY KEY (`SageNominalCodeID`),
  KEY `SageExportSettingID` (`SageExportSettingID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `savsnetpending`
--

DROP TABLE IF EXISTS `savsnetpending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savsnetpending` (
  `SAVSNETPendingID` int(10) NOT NULL AUTO_INCREMENT,
  `AnimalID` int(10) DEFAULT NULL,
  `UserID` int(10) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Details` longtext,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SAVSNETPendingID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `UserID` (`UserID`),
  KEY `Type` (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `savsnetsettings`
--

DROP TABLE IF EXISTS `savsnetsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savsnetsettings` (
  `SAVSNETSettingsID` int(10) NOT NULL AUTO_INCREMENT,
  `SiteLocation` varchar(3) DEFAULT NULL,
  `PracticeID` varchar(80) DEFAULT NULL,
  `PostCode` varchar(10) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SAVSNETSettingsID`),
  UNIQUE KEY `SiteLocation` (`SiteLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `savsnetsurveylog`
--

DROP TABLE IF EXISTS `savsnetsurveylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savsnetsurveylog` (
  `SAVSNETSurveyLogID` int(10) NOT NULL AUTO_INCREMENT,
  `AnimalID` int(10) DEFAULT NULL,
  `UserID` int(10) DEFAULT NULL,
  `ConsultGUID` varchar(255) DEFAULT NULL,
  `ConsultDate` datetime DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SAVSNETSurveyLogID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `UserID` (`UserID`),
  KEY `ConsultGUID` (`ConsultGUID`),
  KEY `ConsultDate` (`ConsultDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seasonal_variations`
--

DROP TABLE IF EXISTS `seasonal_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seasonal_variations` (
  `Seasonal_variations_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_ID` int(10) DEFAULT NULL,
  `Drug_location_ID` int(10) DEFAULT NULL,
  `Season_begin` datetime DEFAULT NULL,
  `Season_end` datetime DEFAULT NULL,
  `Seasonal_minimum` double DEFAULT NULL,
  PRIMARY KEY (`Seasonal_variations_ID`),
  KEY `Stock_ID` (`Stock_ID`) USING BTREE,
  KEY `Drug_location_ID` (`Drug_location_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sett_labels`
--

DROP TABLE IF EXISTS `sett_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sett_labels` (
  `SettID` int(11) NOT NULL AUTO_INCREMENT,
  `SettName` varchar(255) DEFAULT '',
  `SettValue` varchar(255) DEFAULT '',
  `SettScopeLevel` int(11) DEFAULT '0' COMMENT '0 = All,\n1 = Branch,\n2 = Workstation',
  `SettScope` varchar(255) DEFAULT '' COMMENT 'Branch abbrev or workstation name',
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SettID`),
  UNIQUE KEY `UniqueFields` (`SettName`,`SettScopeLevel`,`SettScope`) USING BTREE,
  KEY `SettID` (`SettID`),
  KEY `SettName` (`SettName`),
  KEY `SettScopeLevel` (`SettScopeLevel`),
  KEY `SettScope` (`SettScope`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sett_performance`
--

DROP TABLE IF EXISTS `sett_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sett_performance` (
  `SettID` int(11) NOT NULL AUTO_INCREMENT,
  `SettName` varchar(255) DEFAULT '',
  `SettValue` varchar(255) DEFAULT '',
  `SettScopeLevel` int(11) DEFAULT '0' COMMENT '0 = All,\n1 = Branch,\n2 = Workstation',
  `SettScope` varchar(255) DEFAULT '' COMMENT 'Branch abbrev or workstation name',
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SettID`),
  UNIQUE KEY `UniqueFields` (`SettName`,`SettScopeLevel`,`SettScope`) USING BTREE,
  KEY `SettID` (`SettID`),
  KEY `SettName` (`SettName`),
  KEY `SettScopeLevel` (`SettScopeLevel`),
  KEY `SettScope` (`SettScope`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slot`
--

DROP TABLE IF EXISTS `slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slot` (
  `Slot_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Page_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Time_label` datetime DEFAULT NULL,
  `Instance_number` smallint(5) DEFAULT NULL,
  `Reason` char(255) DEFAULT NULL,
  `Arrived_at` datetime DEFAULT NULL,
  `Current_status` varchar(50) DEFAULT NULL,
  `Other_notes` char(255) DEFAULT NULL,
  `Vet_to_see` varchar(3) DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  PRIMARY KEY (`Slot_ID`),
  KEY `Current_status` (`Current_status`) USING BTREE,
  KEY `Slot_ID` (`Slot_ID`) USING BTREE,
  KEY `Time_label` (`Time_label`) USING BTREE,
  KEY `Vet_to_see` (`Vet_to_see`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=701133 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slotlinks`
--

DROP TABLE IF EXISTS `slotlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slotlinks` (
  `SlotLinkID` int(10) NOT NULL AUTO_INCREMENT,
  `ParentSlot` int(10) DEFAULT NULL,
  `ChildSlot` int(10) DEFAULT NULL,
  PRIMARY KEY (`SlotLinkID`),
  KEY `ParentSlot` (`ParentSlot`),
  KEY `ChildSlot` (`ChildSlot`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms_log`
--

DROP TABLE IF EXISTS `sms_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_log` (
  `Message_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Destination` varchar(1000) DEFAULT NULL,
  `Message` varchar(1000) DEFAULT NULL,
  `Status` varchar(40) DEFAULT NULL,
  `From` varchar(40) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Message_ID`),
  KEY `Message_ID` (`Message_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=127473 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smssettings`
--

DROP TABLE IF EXISTS `smssettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smssettings` (
  `SMSSettingsID` int(10) NOT NULL AUTO_INCREMENT,
  `TeleosUserID` varchar(50) DEFAULT NULL,
  `SMSUserID` varchar(50) DEFAULT NULL,
  `SMSPassword` varchar(50) DEFAULT NULL,
  `AllowUnicodeChars` tinyint(1) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SMSSettingsID`),
  KEY `TeleosUserID` (`TeleosUserID`),
  KEY `SMSUserID` (`SMSUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `special_price_group_clients`
--

DROP TABLE IF EXISTS `special_price_group_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `special_price_group_clients` (
  `Special_price_group_clients_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Special_price_groups_ID` int(10) DEFAULT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`Special_price_group_clients_ID`),
  KEY `Special_price_group_clients_ID` (`Special_price_group_clients_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `special_price_groups`
--

DROP TABLE IF EXISTS `special_price_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `special_price_groups` (
  `Special_price_groups_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Special_price_groups_ID`),
  KEY `Special_price_groups_ID` (`Special_price_groups_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `special_prices`
--

DROP TABLE IF EXISTS `special_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `special_prices` (
  `Special_prices_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Stock_or_procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Amount_1` decimal(19,4) DEFAULT NULL,
  `Amount_2` double DEFAULT NULL,
  `Behaviour` varchar(1) DEFAULT NULL,
  `Expiry_date` datetime DEFAULT NULL,
  `Allow_fees` tinyint(1) DEFAULT '0',
  `Special_price_group` tinyint(1) DEFAULT '0',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Special_prices_ID`),
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Special_prices_ID` (`Special_prices_ID`) USING BTREE,
  KEY `Stock_ID` (`Stock_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `species`
--

DROP TABLE IF EXISTS `species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `species` (
  `Species_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Species_text` varchar(20) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IdexxSpeciesID` int(10) DEFAULT NULL,
  PRIMARY KEY (`Species_ID`),
  UNIQUE KEY `Species` (`Species_text`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stableyard`
--

DROP TABLE IF EXISTS `stableyard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stableyard` (
  `StableyardID` int(10) NOT NULL AUTO_INCREMENT,
  `StableyardSurname` varchar(30) DEFAULT NULL,
  `StableyardHousename` varchar(30) DEFAULT NULL,
  `StableyardAddress1` varchar(30) DEFAULT NULL,
  `StableyardAddress2` varchar(30) DEFAULT NULL,
  `StableyardAddress3` varchar(30) DEFAULT NULL,
  `StableyardAddress4` varchar(30) DEFAULT NULL,
  `StableyardTitle` varchar(10) DEFAULT NULL,
  `StableyardInitials` varchar(12) DEFAULT NULL,
  `StableyardPostcode` varchar(10) DEFAULT NULL,
  `StableyardHowToGetThere` varchar(250) DEFAULT NULL,
  `StableyardPriceBand` varchar(2) DEFAULT NULL,
  `StableyardSpare1` varchar(50) DEFAULT NULL,
  `StableyardSpare2` varchar(20) DEFAULT NULL,
  `StableyardSpare3` varchar(20) DEFAULT NULL,
  `StableyardSpare4` varchar(20) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`StableyardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statementaddress`
--

DROP TABLE IF EXISTS `statementaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statementaddress` (
  `StatementAddressID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `StatementSurname` varchar(30) DEFAULT NULL,
  `StatementHousename` varchar(30) DEFAULT NULL,
  `StatementAddress1` varchar(30) DEFAULT NULL,
  `StatementAddress2` varchar(30) DEFAULT NULL,
  `StatementAddress3` varchar(30) DEFAULT NULL,
  `StatementAddress4` varchar(30) DEFAULT NULL,
  `StatementTitle` varchar(10) DEFAULT NULL,
  `StatementInitials` varchar(12) DEFAULT NULL,
  `StatementPostcode` varchar(10) DEFAULT NULL,
  `StatementSpare1` varchar(50) DEFAULT NULL,
  `StatementSpare2` varchar(20) DEFAULT NULL,
  `StatementSpare3` varchar(20) DEFAULT NULL,
  `StatementSpare4` varchar(20) DEFAULT NULL,
  `StatementPercentage` double DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`StatementAddressID`),
  UNIQUE KEY `_IdentifierFields` (`ClientID`,`AnimalID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `StatementAddress__beforeupdate` BEFORE UPDATE ON `statementaddress` FOR EACH ROW INSERT INTO `StatementAddress:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', StatementAddress.*
                            FROM StatementAddress WHERE StatementAddress.StatementAddressID = OLD.StatementAddressID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `StatementAddress__beforedelete` BEFORE DELETE ON `statementaddress` FOR EACH ROW INSERT INTO `StatementAddress:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', StatementAddress.* 
                            FROM StatementAddress WHERE StatementAddress.StatementAddressID = OLD.StatementAddressID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `statementaddress:deletes`
--

DROP TABLE IF EXISTS `statementaddress:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statementaddress:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `StatementAddressID` int(11) NOT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `StatementSurname` varchar(30) DEFAULT NULL,
  `StatementHousename` varchar(30) DEFAULT NULL,
  `StatementAddress1` varchar(30) DEFAULT NULL,
  `StatementAddress2` varchar(30) DEFAULT NULL,
  `StatementAddress3` varchar(30) DEFAULT NULL,
  `StatementAddress4` varchar(30) DEFAULT NULL,
  `StatementTitle` varchar(10) DEFAULT NULL,
  `StatementInitials` varchar(12) DEFAULT NULL,
  `StatementPostcode` varchar(10) DEFAULT NULL,
  `StatementSpare1` varchar(50) DEFAULT NULL,
  `StatementSpare2` varchar(20) DEFAULT NULL,
  `StatementSpare3` varchar(20) DEFAULT NULL,
  `StatementSpare4` varchar(20) DEFAULT NULL,
  `StatementPercentage` double DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statementaddress:edits`
--

DROP TABLE IF EXISTS `statementaddress:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statementaddress:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `StatementAddressID` int(11) NOT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `StatementSurname` varchar(30) DEFAULT NULL,
  `StatementHousename` varchar(30) DEFAULT NULL,
  `StatementAddress1` varchar(30) DEFAULT NULL,
  `StatementAddress2` varchar(30) DEFAULT NULL,
  `StatementAddress3` varchar(30) DEFAULT NULL,
  `StatementAddress4` varchar(30) DEFAULT NULL,
  `StatementTitle` varchar(10) DEFAULT NULL,
  `StatementInitials` varchar(12) DEFAULT NULL,
  `StatementPostcode` varchar(10) DEFAULT NULL,
  `StatementSpare1` varchar(50) DEFAULT NULL,
  `StatementSpare2` varchar(20) DEFAULT NULL,
  `StatementSpare3` varchar(20) DEFAULT NULL,
  `StatementSpare4` varchar(20) DEFAULT NULL,
  `StatementPercentage` double DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `Stock_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_description` varchar(50) DEFAULT NULL,
  `Stock_reference` varchar(10) DEFAULT NULL,
  `Supplier_reference` varchar(50) DEFAULT NULL,
  `Bar_code` varchar(25) DEFAULT NULL,
  `Transaction_text` varchar(50) DEFAULT NULL,
  `Label_text` varchar(50) DEFAULT NULL,
  `Units_per_pack` varchar(15) DEFAULT NULL,
  `Pack_cost` decimal(19,4) DEFAULT NULL,
  `Markup_to_RRP` double DEFAULT NULL,
  `Discount_to_selling` double DEFAULT NULL,
  `Actual_rounded_price` decimal(19,4) DEFAULT NULL,
  `Supplier_ID` int(10) DEFAULT NULL,
  `Drug_data` varchar(5000) DEFAULT NULL,
  `Dosage_message` varchar(50) DEFAULT NULL,
  `Warning_message` varchar(50) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Drug_category` int(10) DEFAULT NULL,
  `VAT_Rate` varchar(1) DEFAULT NULL,
  `Season_begin_month` smallint(5) DEFAULT NULL,
  `Season_end_month` smallint(5) DEFAULT NULL,
  `Supplier_ID_2` int(10) DEFAULT NULL,
  `Supplier_reference_2` varchar(50) DEFAULT NULL,
  `Supplier_ID_3` int(10) DEFAULT NULL,
  `Supplier_reference_3` varchar(50) DEFAULT NULL,
  `Last_updated_initials` varchar(3) DEFAULT NULL,
  `Last_updated` datetime DEFAULT NULL,
  `Pack_cost_2` decimal(19,4) DEFAULT NULL,
  `Markup_to_RRP_2` double DEFAULT NULL,
  `Pack_cost_3` decimal(19,4) DEFAULT NULL,
  `Markup_to_RRP_3` double DEFAULT NULL,
  `Primary_Supplier` int(10) DEFAULT NULL,
  `SPX` tinyint(1) NOT NULL DEFAULT '0',
  `Net_net_Suppliers_Discount` double DEFAULT NULL,
  `Net_net_Specials_Discount` double DEFAULT NULL,
  `Use_net_net_pricing` tinyint(1) NOT NULL DEFAULT '0',
  `Manufacturer_ID` int(10) DEFAULT NULL,
  `Block_Ordering` tinyint(1) NOT NULL DEFAULT '0',
  `Block_Reason` varchar(80) DEFAULT NULL,
  `Alt_Ordering_Stock_ID` int(10) DEFAULT NULL,
  `Update_Prices` smallint(5) DEFAULT NULL,
  `Net_net_price` double DEFAULT NULL,
  `Discount_from_net` double DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `StockActive` tinyint(1) DEFAULT '-1',
  `VPA_number` varchar(255) DEFAULT NULL,
  `RouteOfAdminID` int(10) DEFAULT NULL,
  `HPCIA` int(10) DEFAULT '0',
  `DataSheetURL` varchar(2048) DEFAULT NULL,
  `Fast_moving` tinyint(1) DEFAULT '0',
  `ControlledDrug` tinyint(1) DEFAULT '0',
  `BlockFractionCharging` tinyint(1) DEFAULT '0',
  `FontBold` tinyint(1) DEFAULT '0',
  `FontItalic` tinyint(1) DEFAULT '0',
  `FontUnderline` tinyint(1) DEFAULT '0',
  `FontColour` varchar(255) DEFAULT NULL,
  `FontSize` int(11) DEFAULT NULL,
  PRIMARY KEY (`Stock_ID`),
  UNIQUE KEY `Stock_reference` (`Stock_reference`),
  KEY `Bar_code` (`Bar_code`) USING BTREE,
  KEY `Stock_description` (`Stock_description`) USING BTREE,
  KEY `Supplier_reference` (`Supplier_reference`) USING BTREE,
  KEY `Supplier_reference_2` (`Supplier_reference_2`) USING BTREE,
  KEY `Supplier_reference_3` (`Supplier_reference_3`) USING BTREE,
  KEY `Transaction_text` (`Transaction_text`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2146877805 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_action_reasons`
--

DROP TABLE IF EXISTS `stock_action_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_action_reasons` (
  `Stock_action_reason_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_action_ID` int(10) DEFAULT '0',
  `Stock_action_reason_text` varchar(30) DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Stock_action_reason_ID`),
  KEY `Stock_action_reason_ID` (`Stock_action_reason_ID`),
  KEY `Stock_action_ID` (`Stock_action_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_actions`
--

DROP TABLE IF EXISTS `stock_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_actions` (
  `Stock_action_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_action_text` varchar(30) DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Stock_action_ID`),
  KEY `Stock_action_ID` (`Stock_action_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_category`
--

DROP TABLE IF EXISTS `stock_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_category` (
  `Stock_category` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_category_abbreviation` varchar(7) DEFAULT NULL,
  `Stock_category_full_text` varchar(50) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Stock_category`),
  KEY `Stock_category` (`Stock_category`) USING BTREE,
  KEY `Stock_category_abbreviation` (`Stock_category_abbreviation`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_holding`
--

DROP TABLE IF EXISTS `stock_holding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_holding` (
  `Stock_holding_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_ID` int(10) DEFAULT NULL,
  `Drug_location_ID` int(10) DEFAULT NULL,
  `Stock_level` double(15,4) DEFAULT NULL,
  `Stock_minimum` int(10) DEFAULT NULL,
  `Reorder_multiple` int(10) DEFAULT NULL,
  `Seasonal_minimum` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Stock_holding_ID`),
  KEY `Drug_location_ID` (`Drug_location_ID`) USING BTREE,
  KEY `Stock_holding_ID` (`Stock_holding_ID`) USING BTREE,
  KEY `Stock_ID` (`Stock_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4815 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_orders`
--

DROP TABLE IF EXISTS `stock_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_orders` (
  `Stock_order_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_ID` int(10) DEFAULT NULL,
  `Order_number_ID` int(10) DEFAULT NULL,
  `On_order` int(10) DEFAULT NULL,
  `Arrived` int(10) DEFAULT NULL,
  `Order_date` datetime DEFAULT NULL,
  `Branch` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Stock_order_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2085193513 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_purchases`
--

DROP TABLE IF EXISTS `stock_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_purchases` (
  `Stock_purchase_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_ID` int(10) DEFAULT NULL,
  `Order_number_ID` int(10) DEFAULT NULL,
  `Stock_action_ID` int(10) DEFAULT '0',
  `Stock_action_reason_ID` int(10) DEFAULT '0',
  `Invoice_number` varchar(15) DEFAULT NULL,
  `Quantity` double(15,4) DEFAULT NULL,
  `Amount_Paid` decimal(19,4) DEFAULT NULL,
  `Branch` int(10) DEFAULT NULL,
  `Invoice_number_ID` varchar(15) DEFAULT NULL,
  `Batch_number` varchar(15) DEFAULT NULL,
  `Stock_or_substock` varchar(1) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Stock_purchase_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=352387 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_recall`
--

DROP TABLE IF EXISTS `stock_recall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_recall` (
  `Stock_recall_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Recall_type_ID` int(10) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Stock_recall_ID`),
  KEY `Stock_ID` (`Stock_ID`) USING BTREE,
  KEY `Stock_recall_ID` (`Stock_recall_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_subitem`
--

DROP TABLE IF EXISTS `stock_subitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_subitem` (
  `Stock_subitem_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_ID` int(10) DEFAULT NULL,
  `Multiply_divide_factor` double DEFAULT NULL,
  `Code` varchar(10) DEFAULT NULL,
  `Text` varchar(50) DEFAULT NULL,
  `Unit_price` decimal(19,4) DEFAULT NULL,
  `Dispensing_fee` decimal(19,4) DEFAULT NULL,
  `Add_flat_fee` tinyint(1) NOT NULL DEFAULT '0',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Stock_subitem_ID`),
  UNIQUE KEY `Code` (`Code`),
  KEY `Stock_subitem_ID` (`Stock_subitem_ID`) USING BTREE,
  KEY `Text` (`Text`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2142607681 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_subitem_markup`
--

DROP TABLE IF EXISTS `stock_subitem_markup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_subitem_markup` (
  `Stock_Subitem_Markup_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Stock_Subitem_ID` int(10) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Markup_to_RRP` double DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Stock_Subitem_Markup_ID`),
  UNIQUE KEY `Stock_Subitem_Markup_ID` (`Stock_Subitem_Markup_ID`),
  KEY `Markup_to_RRP` (`Stock_Subitem_Markup_ID`) USING BTREE,
  KEY `Stock_ID` (`Stock_ID`) USING BTREE,
  KEY `Stock_Subitem_ID` (`Stock_Subitem_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockactivesubstancelinks`
--

DROP TABLE IF EXISTS `stockactivesubstancelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockactivesubstancelinks` (
  `ActiveSubstanceLinkID` int(10) NOT NULL AUTO_INCREMENT,
  `ActiveSubstanceID` int(10) DEFAULT NULL,
  `StockID` int(10) DEFAULT NULL,
  PRIMARY KEY (`ActiveSubstanceLinkID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockactivesubstances`
--

DROP TABLE IF EXISTS `stockactivesubstances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockactivesubstances` (
  `ActiveSubstanceID` int(10) NOT NULL AUTO_INCREMENT,
  `ActiveSubstanceName` varchar(150) DEFAULT NULL,
  `ActiveSubstanceNumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ActiveSubstanceID`)
) ENGINE=InnoDB AUTO_INCREMENT=1162 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `Supplier_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Supplier_name` varchar(50) DEFAULT NULL,
  `Telephone_number` varchar(50) DEFAULT NULL,
  `Fax_number` varchar(50) DEFAULT NULL,
  `Modem_number` varchar(50) DEFAULT NULL,
  `Email_address` varchar(50) DEFAULT NULL,
  `Contact_Name` varchar(50) DEFAULT NULL,
  `House_Number` varchar(50) DEFAULT NULL,
  `Address_1` varchar(50) DEFAULT NULL,
  `Address_2` varchar(50) DEFAULT NULL,
  `Address_3` varchar(50) DEFAULT NULL,
  `Address_4` varchar(50) DEFAULT NULL,
  `Postcode` varchar(10) DEFAULT NULL,
  `Website_URL` varchar(50) DEFAULT NULL,
  `Delivery_Charge` decimal(19,4) DEFAULT NULL,
  `Billing_terms` varchar(50) DEFAULT NULL,
  `Notes` varchar(5000) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Supplier_ID`),
  KEY `Supplier_ID` (`Supplier_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1591721108 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `title`
--

DROP TABLE IF EXISTS `title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `title` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Title` varchar(25) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `Transaction_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Transaction_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Date_entered` (`Date_entered`) USING BTREE,
  KEY `Department` (`Client_department_ID`) USING BTREE,
  KEY `Department1` (`Accounts_category_ID`) USING BTREE,
  KEY `Details` (`Details`) USING BTREE,
  KEY `Invoice_date` (`Invoice_date`) USING BTREE,
  KEY `Stock_ID` (`Stock_ID`) USING BTREE,
  KEY `Transaction_ID` (`Transaction_ID`) USING BTREE,
  KEY `Work_done_by` (`Work_done_by`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13759633 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ins_clientbal` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN 
DECLARE vClientBalance DECIMAL (19,2); 
DECLARE vBilltype VARCHAR(1); 
DECLARE vCurrencyAbbreviation VARCHAR(3); 
IF (NEW.Procedure_ID = 2 OR NEW.Procedure_ID = 8 OR NEW.Procedure_ID = 9) AND NEW.Amount_in_currency <> 0 THEN 
SET vBilltype = ''; 
SET vBilltype = GetClientBillType(NEW.Client_ID); 
IF vBilltype = 'Z' THEN 
SET vCurrencyAbbreviation = 'IGN'; 
ELSE 
SET vCurrencyAbbreviation = NEW.Currency_abbreviation; 
END IF; 
SET vClientBalance = 0; 
SET vClientBalance = GetClientBalance(NEW.Client_ID,vCurrencyAbbreviation); 
IF NEW.Currency_abbreviation = 'PHP' THEN 
INSERT INTO ClientBalance SET ClientID = NEW.Client_ID, PHPBalance = vClientBalance ON DUPLICATE KEY UPDATE PHPBalance = vClientBalance; 
ELSEIF NEW.Currency_abbreviation = 'INS' THEN 
INSERT INTO ClientBalance SET ClientID = NEW.Client_ID, InsuranceBalance = vClientBalance ON DUPLICATE KEY UPDATE InsuranceBalance = vClientBalance; 
ELSE 
INSERT INTO ClientBalance SET ClientID  = NEW.Client_ID, Balance = vClientBalance ON DUPLICATE KEY UPDATE Balance = vClientBalance; 
END IF; END IF; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Transactions__beforeupdate` BEFORE UPDATE ON `transactions` FOR EACH ROW BEGIN
                                    IF @TRIGGER_DISABLED = 0 OR @TRIGGER_DISABLED IS NULL THEN
                                        IF NEW.Client_ID <> OLD.Client_ID OR
                                            NEW.Animal_ID <> OLD.Animal_ID OR
                                            NEW.Invoice_date <> OLD.Invoice_date OR
                                            NEW.Client_department_ID <> OLD.Client_department_ID OR
                                            NEW.Accounts_category_ID <> OLD.Accounts_category_ID OR
                                            NEW.Entered_by <> OLD.Entered_by OR
                                            NEW.Work_done_by <> OLD.Work_done_by OR
                                            NEW.Details <> OLD.Details OR
                                            NEW.Multiplication <> OLD.Multiplication OR
                                            NEW.Stock_or_Procedure <> OLD.Stock_or_Procedure OR
                                            NEW.Stock_ID <> OLD.Stock_ID OR
                                            NEW.Procedure_ID <> OLD.Procedure_ID OR
                                            NEW.Net_value <> OLD.Net_value OR
                                            NEW.VAT_percentage <> OLD.VAT_percentage OR
                                            NEW.VAT_amount <> OLD.VAT_amount OR
                                            NEW.Currency_abbreviation <> OLD.Currency_abbreviation OR
                                            NEW.Amount_in_currency <> OLD.Amount_in_currency THEN
                                            INSERT INTO `Transactions:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', Transactions.*
                                            FROM Transactions WHERE Transactions.Transaction_ID = OLD.Transaction_ID;
                                        END IF;
                                    END IF;
                                END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `upd_clientbal` AFTER UPDATE ON `transactions` FOR EACH ROW BEGIN 
DECLARE vClientBalance DECIMAL (19,2); 
DECLARE vBilltype VARCHAR(1); 
DECLARE vCurrencyAbbreviation VARCHAR(3); 
IF (NEW.Procedure_ID = 2 OR NEW.Procedure_ID = 8 OR NEW.Procedure_ID = 9) OR (OLD.Procedure_ID = 2 OR OLD.Procedure_ID = 8 OR OLD.Procedure_ID = 9)THEN 
IF (NEW.Amount_in_currency <> OLD.Amount_in_currency OR NEW.Currency_abbreviation <> OLD.Currency_abbreviation OR NEW.Procedure_ID <> OLD.Procedure_ID OR NEW.Client_ID <> OLD.Client_ID) THEN 
SET vBilltype = ''; 
SET vBilltype = GetClientBillType(NEW.Client_ID); 
SET vCurrencyAbbreviation =''; 
IF vBilltype = 'Z' THEN 
SET vCurrencyAbbreviation = 'IGN'; 
ELSE 
SET vCurrencyAbbreviation = NEW.Currency_abbreviation; 
END IF; 
SET vClientBalance = 0; 
SET vClientBalance = GetClientBalance(NEW.Client_ID,vCurrencyAbbreviation); 
IF NEW.Currency_abbreviation = 'PHP' THEN 
INSERT INTO ClientBalance SET ClientID  = NEW.Client_ID, PHPBalance = vClientBalance ON DUPLICATE KEY UPDATE PHPBalance = vClientBalance; 
ELSEIF NEW.Currency_abbreviation = 'INS' THEN 
INSERT INTO ClientBalance SET ClientID = NEW.Client_ID, InsuranceBalance = vClientBalance ON DUPLICATE KEY UPDATE InsuranceBalance = vClientBalance; 
ELSE 
INSERT INTO ClientBalance SET ClientID  = NEW.Client_ID, Balance = vClientBalance ON DUPLICATE KEY UPDATE Balance = vClientBalance; 
END IF; IF ((vBilltype <> 'Z' OR vBilltype IS NULL) AND NEW.Currency_abbreviation <> OLD.Currency_abbreviation) THEN 
SET vClientBalance = 0; 
SET vClientBalance = GetClientBalance(NEW.Client_ID,OLD.Currency_abbreviation); 
IF OLD.Currency_abbreviation = 'PHP' THEN 
INSERT INTO ClientBalance SET ClientID = NEW.Client_ID, PHPBalance = vClientBalance ON DUPLICATE KEY UPDATE PHPBalance = vClientBalance; 
ELSEIF OLD.Currency_abbreviation = 'INS' THEN 
INSERT INTO ClientBalance SET ClientID = NEW.Client_ID, InsuranceBalance = vClientBalance ON DUPLICATE KEY UPDATE InsuranceBalance = vClientBalance; 
ELSE 
INSERT INTO ClientBalance SET ClientID  = NEW.Client_ID, Balance = vClientBalance ON DUPLICATE KEY UPDATE Balance = vClientBalance; 
END IF; 
END IF; IF NEW.Client_ID <> OLD.Client_ID THEN 
SET vBilltype = ''; 
SET vBilltype = GetClientBillType(OLD.Client_ID); 
SET vCurrencyAbbreviation =''; 
IF vBilltype = 'Z' THEN 
SET vCurrencyAbbreviation = 'IGN'; 
ELSE 
SET vCurrencyAbbreviation = OLD.Currency_abbreviation; 
END IF; 
SET vClientBalance = 0; 
SET vClientBalance = GetClientBalance(OLD.Client_ID,vCurrencyAbbreviation); 
IF OLD.Currency_abbreviation = 'PHP' THEN 
INSERT INTO ClientBalance SET ClientID  = OLD.Client_ID, PHPBalance = vClientBalance ON DUPLICATE KEY UPDATE PHPBalance = vClientBalance; 
ELSEIF OLD.Currency_abbreviation = 'INS' THEN  
INSERT INTO ClientBalance SET ClientID = OLD.Client_ID, InsuranceBalance = vClientBalance ON DUPLICATE KEY UPDATE InsuranceBalance = vClientBalance; 
ELSE 
INSERT INTO ClientBalance SET ClientID  = OLD.Client_ID, Balance = vClientBalance ON DUPLICATE KEY UPDATE Balance = vClientBalance; 
END IF; 
END IF; END IF; END IF; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Transactions__beforedelete` BEFORE DELETE ON `transactions` FOR EACH ROW INSERT INTO `Transactions:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', Transactions.* 
                            FROM Transactions WHERE Transactions.Transaction_ID = OLD.Transaction_ID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `del_clientbal` AFTER DELETE ON `transactions` FOR EACH ROW BEGIN 
DECLARE vClientBalance DECIMAL (19,2); 
DECLARE vBilltype VARCHAR(1); 
DECLARE vCurrencyAbbreviation VARCHAR(3); IF (OLD.Procedure_ID = 2 Or OLD.Procedure_ID = 8 Or OLD.Procedure_ID = 9) Then 
SET vBilltype = ''; 
SET vBilltype = GetClientBillType(OLD.Client_ID); 
IF vBilltype = 'Z' THEN 
SET vCurrencyAbbreviation = 'IGN'; 
ELSE 
SET vCurrencyAbbreviation = OLD.Currency_abbreviation; 
END IF; 
SET vClientBalance = 0; 
SET vClientBalance = GetClientBalance(OLD.Client_ID,vCurrencyAbbreviation); 
IF OLD.Currency_abbreviation = 'PHP' THEN 
INSERT INTO ClientBalance SET ClientID  = OLD.Client_ID, PHPBalance = vClientBalance ON DUPLICATE KEY UPDATE PHPBalance = vClientBalance; 
ELSEIF OLD.Currency_abbreviation = 'INS' THEN 
INSERT INTO ClientBalance SET ClientID = OLD.Client_ID, InsuranceBalance = vClientBalance ON DUPLICATE KEY UPDATE InsuranceBalance = vClientBalance; 
ELSE 
INSERT INTO ClientBalance SET ClientID  = OLD.Client_ID, Balance = vClientBalance ON DUPLICATE KEY UPDATE Balance = vClientBalance; 
END IF; END IF; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transactions:deletes`
--

DROP TABLE IF EXISTS `transactions:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `Transaction_ID` int(11) NOT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Delete_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Date_entered` (`Date_entered`) USING BTREE,
  KEY `Department` (`Client_department_ID`) USING BTREE,
  KEY `Department1` (`Accounts_category_ID`) USING BTREE,
  KEY `Details` (`Details`) USING BTREE,
  KEY `Invoice_date` (`Invoice_date`) USING BTREE,
  KEY `Stock_ID` (`Stock_ID`) USING BTREE,
  KEY `Transaction_ID` (`Transaction_ID`) USING BTREE,
  KEY `Work_done_by` (`Work_done_by`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50327 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions:edits`
--

DROP TABLE IF EXISTS `transactions:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `Transaction_ID` int(11) NOT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Edit_ID`),
  KEY `Animal_ID` (`Animal_ID`) USING BTREE,
  KEY `Client_ID` (`Client_ID`) USING BTREE,
  KEY `Date_entered` (`Date_entered`) USING BTREE,
  KEY `Department` (`Client_department_ID`) USING BTREE,
  KEY `Department1` (`Accounts_category_ID`) USING BTREE,
  KEY `Details` (`Details`) USING BTREE,
  KEY `Invoice_date` (`Invoice_date`) USING BTREE,
  KEY `Stock_ID` (`Stock_ID`) USING BTREE,
  KEY `Transaction_ID` (`Transaction_ID`) USING BTREE,
  KEY `Work_done_by` (`Work_done_by`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5468677 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionsclinicalnotes`
--

DROP TABLE IF EXISTS `transactionsclinicalnotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionsclinicalnotes` (
  `ClinicalNoteID` int(10) NOT NULL AUTO_INCREMENT,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `InvoiceDate` datetime DEFAULT NULL,
  `DateEntered` datetime DEFAULT NULL,
  `TimeEntered` datetime DEFAULT NULL,
  `ClientDepartmentID` int(10) DEFAULT NULL,
  `EnteredBy` int(10) DEFAULT NULL,
  `WorkDoneBy` int(10) DEFAULT NULL,
  `DetailsRaw` mediumtext,
  `DetailsRTF` mediumtext,
  `Invoiced` tinyint(1) NOT NULL,
  `CurrencyAbbreviation` varchar(3) DEFAULT 'GBP',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `VenomCodeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ClinicalNoteID`),
  KEY `ClinicalNoteID` (`ClinicalNoteID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `InvoiceDate` (`InvoiceDate`),
  KEY `DateEntered` (`DateEntered`),
  KEY `TimeEntered` (`TimeEntered`),
  KEY `ClientDepartmentID` (`ClientDepartmentID`),
  KEY `EnteredBy` (`EnteredBy`),
  KEY `WorkDoneBy` (`WorkDoneBy`)
) ENGINE=InnoDB AUTO_INCREMENT=2302229 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TransactionsClinicalNotes__beforeupdate` BEFORE UPDATE ON `transactionsclinicalnotes` FOR EACH ROW INSERT INTO `TransactionsClinicalNotes:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', TransactionsClinicalNotes.*
                            FROM TransactionsClinicalNotes WHERE TransactionsClinicalNotes.ClinicalNoteID = OLD.ClinicalNoteID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TransactionsClinicalNotes__beforedelete` BEFORE DELETE ON `transactionsclinicalnotes` FOR EACH ROW INSERT INTO `TransactionsClinicalNotes:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', TransactionsClinicalNotes.* 
                            FROM TransactionsClinicalNotes WHERE TransactionsClinicalNotes.ClinicalNoteID = OLD.ClinicalNoteID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transactionsclinicalnotes:deletes`
--

DROP TABLE IF EXISTS `transactionsclinicalnotes:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionsclinicalnotes:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `ClinicalNoteID` int(11) NOT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `InvoiceDate` datetime DEFAULT NULL,
  `DateEntered` datetime DEFAULT NULL,
  `TimeEntered` datetime DEFAULT NULL,
  `ClientDepartmentID` int(10) DEFAULT NULL,
  `EnteredBy` int(10) DEFAULT NULL,
  `WorkDoneBy` int(10) DEFAULT NULL,
  `DetailsRaw` mediumtext,
  `DetailsRTF` mediumtext,
  `Invoiced` tinyint(1) NOT NULL,
  `CurrencyAbbreviation` varchar(3) DEFAULT 'GBP',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `VenomCodeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Delete_ID`),
  KEY `ClinicalNoteID` (`ClinicalNoteID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `InvoiceDate` (`InvoiceDate`),
  KEY `DateEntered` (`DateEntered`),
  KEY `TimeEntered` (`TimeEntered`),
  KEY `ClientDepartmentID` (`ClientDepartmentID`),
  KEY `EnteredBy` (`EnteredBy`),
  KEY `WorkDoneBy` (`WorkDoneBy`)
) ENGINE=InnoDB AUTO_INCREMENT=16079 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionsclinicalnotes:edits`
--

DROP TABLE IF EXISTS `transactionsclinicalnotes:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionsclinicalnotes:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `ClinicalNoteID` int(11) NOT NULL,
  `ClientID` int(10) DEFAULT NULL,
  `AnimalID` int(10) DEFAULT NULL,
  `InvoiceDate` datetime DEFAULT NULL,
  `DateEntered` datetime DEFAULT NULL,
  `TimeEntered` datetime DEFAULT NULL,
  `ClientDepartmentID` int(10) DEFAULT NULL,
  `EnteredBy` int(10) DEFAULT NULL,
  `WorkDoneBy` int(10) DEFAULT NULL,
  `DetailsRaw` mediumtext,
  `DetailsRTF` mediumtext,
  `Invoiced` tinyint(1) NOT NULL,
  `CurrencyAbbreviation` varchar(3) DEFAULT 'GBP',
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `VenomCodeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Edit_ID`),
  KEY `ClinicalNoteID` (`ClinicalNoteID`),
  KEY `ClientID` (`ClientID`),
  KEY `AnimalID` (`AnimalID`),
  KEY `InvoiceDate` (`InvoiceDate`),
  KEY `DateEntered` (`DateEntered`),
  KEY `TimeEntered` (`TimeEntered`),
  KEY `ClientDepartmentID` (`ClientDepartmentID`),
  KEY `EnteredBy` (`EnteredBy`),
  KEY `WorkDoneBy` (`WorkDoneBy`)
) ENGINE=InnoDB AUTO_INCREMENT=28305 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionsestimates`
--

DROP TABLE IF EXISTS `transactionsestimates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionsestimates` (
  `EstimateID` int(11) NOT NULL AUTO_INCREMENT,
  `Transaction_ID` int(10) NOT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EstimateID`),
  KEY `Animal_ID` (`Animal_ID`),
  KEY `Client_ID` (`Client_ID`),
  KEY `Date_entered` (`Date_entered`),
  KEY `Department` (`Client_department_ID`),
  KEY `Department1` (`Accounts_category_ID`),
  KEY `Details` (`Details`),
  KEY `Invoice_date` (`Invoice_date`),
  KEY `Stock_ID` (`Stock_ID`),
  KEY `Transaction_ID` (`Transaction_ID`),
  KEY `Work_done_by` (`Work_done_by`)
) ENGINE=InnoDB AUTO_INCREMENT=30029 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER TransactionsEstimates__beforeupdate BEFORE UPDATE ON  TransactionsEstimates FOR EACH ROW
                            INSERT INTO `TransactionsEstimates:edits` SELECT NULL, NOW(), @'User_initials', @'Workstation', TransactionsEstimates.*
                            FROM TransactionsEstimates WHERE TransactionsEstimates.EstimateID = OLD.EstimateID; */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER TransactionsEstimates__beforedelete BEFORE DELETE ON  TransactionsEstimates FOR EACH ROW
                            INSERT INTO `TransactionsEstimates:deletes` SELECT NULL, NOW(), @'User_initials', @'Workstation', TransactionsEstimates.* 
                            FROM TransactionsEstimates WHERE TransactionsEstimates.EstimateID = OLD.EstimateID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transactionsestimates:deletes`
--

DROP TABLE IF EXISTS `transactionsestimates:deletes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionsestimates:deletes` (
  `Delete_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Delete_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `EstimateID` int(11) NOT NULL,
  `Transaction_ID` int(10) NOT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Delete_ID`),
  KEY `Animal_ID` (`Animal_ID`),
  KEY `Client_ID` (`Client_ID`),
  KEY `Date_entered` (`Date_entered`),
  KEY `Department` (`Client_department_ID`),
  KEY `Department1` (`Accounts_category_ID`),
  KEY `Details` (`Details`),
  KEY `Invoice_date` (`Invoice_date`),
  KEY `Stock_ID` (`Stock_ID`),
  KEY `Transaction_ID` (`Transaction_ID`),
  KEY `Work_done_by` (`Work_done_by`)
) ENGINE=InnoDB AUTO_INCREMENT=1895 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionsestimates:edits`
--

DROP TABLE IF EXISTS `transactionsestimates:edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionsestimates:edits` (
  `Edit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Edit_datetime` datetime DEFAULT NULL,
  `User_initials` varchar(255) DEFAULT '',
  `Workstation` varchar(255) DEFAULT '',
  `EstimateID` int(11) NOT NULL,
  `Transaction_ID` int(10) NOT NULL,
  `Client_ID` int(10) DEFAULT NULL,
  `Animal_ID` int(10) DEFAULT NULL,
  `Invoice_date` datetime DEFAULT NULL,
  `Date_entered` datetime DEFAULT NULL,
  `Time_entered` datetime DEFAULT NULL,
  `Client_department_ID` int(10) DEFAULT NULL,
  `Accounts_category_ID` int(10) DEFAULT NULL,
  `Entered_by` int(10) DEFAULT NULL,
  `Work_done_by` int(10) DEFAULT NULL,
  `Details` varchar(80) DEFAULT NULL,
  `Multiplication` double DEFAULT NULL,
  `Stock_or_Procedure` varchar(1) DEFAULT NULL,
  `Stock_ID` int(10) DEFAULT NULL,
  `Procedure_ID` int(10) DEFAULT NULL,
  `Net_value` decimal(19,4) DEFAULT NULL,
  `VAT_percentage` double DEFAULT NULL,
  `VAT_amount` decimal(19,4) DEFAULT NULL,
  `Currency_abbreviation` varchar(3) DEFAULT NULL,
  `Amount_in_currency` decimal(19,4) DEFAULT NULL,
  `Invoiced` tinyint(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Edit_ID`),
  KEY `Animal_ID` (`Animal_ID`),
  KEY `Client_ID` (`Client_ID`),
  KEY `Date_entered` (`Date_entered`),
  KEY `Department` (`Client_department_ID`),
  KEY `Department1` (`Accounts_category_ID`),
  KEY `Details` (`Details`),
  KEY `Invoice_date` (`Invoice_date`),
  KEY `Stock_ID` (`Stock_ID`),
  KEY `Transaction_ID` (`Transaction_ID`),
  KEY `Work_done_by` (`Work_done_by`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionshyperlinks`
--

DROP TABLE IF EXISTS `transactionshyperlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionshyperlinks` (
  `HyperlinkID` int(11) NOT NULL AUTO_INCREMENT,
  `TransactionID` int(11) DEFAULT NULL,
  `Link` varchar(500) DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`HyperlinkID`),
  KEY `TransactionID` (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twins`
--

DROP TABLE IF EXISTS `twins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twins` (
  `Twin_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Primary_client_ID` int(10) DEFAULT NULL,
  `Secondary_client_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`Twin_ID`),
  KEY `Twin_ID` (`Twin_ID`) USING BTREE,
  KEY `Primary_client_ID` (`Primary_client_ID`) USING BTREE,
  KEY `Secondary_client_ID` (`Secondary_client_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uitelclientcard`
--

DROP TABLE IF EXISTS `uitelclientcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uitelclientcard` (
  `UIid` int(11) NOT NULL AUTO_INCREMENT,
  `Workstation` varchar(255) DEFAULT NULL,
  `PractitionerID` int(11) DEFAULT NULL,
  `Maximised` tinyint(1) DEFAULT NULL,
  `FormSize` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UIid`),
  UNIQUE KEY `_IdentifierFields` (`Workstation`,`PractitionerID`)
) ENGINE=InnoDB AUTO_INCREMENT=1717279 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uitelfindrecord`
--

DROP TABLE IF EXISTS `uitelfindrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uitelfindrecord` (
  `UIid` int(11) NOT NULL AUTO_INCREMENT,
  `PractitionerID` int(11) NOT NULL,
  `Field1` varchar(255) DEFAULT NULL,
  `Field1Exact` tinyint(1) DEFAULT '0',
  `Field2` varchar(255) DEFAULT NULL,
  `Field2Exact` tinyint(1) DEFAULT '0',
  `Field3` varchar(255) DEFAULT NULL,
  `Field3Exact` tinyint(1) DEFAULT '0',
  `DeptFilter` varchar(255) DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`UIid`),
  UNIQUE KEY `Practitioner` (`PractitionerID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uitelforms`
--

DROP TABLE IF EXISTS `uitelforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uitelforms` (
  `UIid` int(11) NOT NULL AUTO_INCREMENT,
  `PractitionerID` int(11) NOT NULL,
  `HideInfoPrompt` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`UIid`),
  UNIQUE KEY `Practitioner` (`PractitionerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uitelhistory`
--

DROP TABLE IF EXISTS `uitelhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uitelhistory` (
  `UIid` int(11) NOT NULL AUTO_INCREMENT,
  `Workstation` varchar(255) DEFAULT NULL,
  `PractitionerID` int(11) DEFAULT NULL,
  `FilterFindExpanded` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`UIid`),
  UNIQUE KEY `_IdentifierFields` (`Workstation`,`PractitionerID`)
) ENGINE=InnoDB AUTO_INCREMENT=1427833 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uitelworkentry`
--

DROP TABLE IF EXISTS `uitelworkentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uitelworkentry` (
  `UIid` int(11) NOT NULL AUTO_INCREMENT,
  `Workstation` varchar(255) DEFAULT NULL,
  `PractitionerID` int(11) DEFAULT NULL,
  `Button` varchar(255) DEFAULT NULL,
  `Maximised` tinyint(1) DEFAULT NULL,
  `FormSize` varchar(255) DEFAULT NULL,
  `ColumnSizes` varchar(255) DEFAULT NULL,
  `PHPinfoPanelSize` int(11) DEFAULT '0',
  `SortOnFilterText` tinyint(1) DEFAULT NULL,
  `ButtonHash` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`UIid`),
  UNIQUE KEY `_IdentifierFields` (`Workstation`,`PractitionerID`,`Button`)
) ENGINE=InnoDB AUTO_INCREMENT=627931 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_class`
--

DROP TABLE IF EXISTS `user_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_class` (
  `User_class_ID` int(10) NOT NULL AUTO_INCREMENT,
  `User_class_name` varchar(10) DEFAULT NULL,
  `Default_channel` smallint(5) DEFAULT NULL,
  `Default_window_size` smallint(5) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_class_ID`),
  KEY `User_class_ID` (`User_class_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1641811276 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_group_members`
--

DROP TABLE IF EXISTS `user_group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_members` (
  `User_group_members` int(10) NOT NULL AUTO_INCREMENT,
  `User_group_ID` int(10) DEFAULT NULL,
  `Practitioner_ID` int(10) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_group_members`),
  KEY `Practitioner_ID` (`Practitioner_ID`) USING BTREE,
  KEY `User_group_ID` (`User_group_ID`) USING BTREE,
  KEY `User_group_members` (`User_group_members`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `User_group_ID` int(10) NOT NULL AUTO_INCREMENT,
  `User_group_name` varchar(20) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_group_ID`),
  UNIQUE KEY `User_group_name` (`User_group_name`),
  KEY `User_group_ID` (`User_group_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vat_rate`
--

DROP TABLE IF EXISTS `vat_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vat_rate` (
  `VAT_Rate` varchar(1) NOT NULL,
  `Rate_description` varchar(50) DEFAULT NULL,
  `Percentage` double DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `CreatedBy` int(10) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`VAT_Rate`),
  KEY `VAT_Rate` (`VAT_Rate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `VersionID` int(10) NOT NULL,
  `LastChecked` datetime DEFAULT NULL,
  `ForBuild` varchar(10) DEFAULT NULL,
  `OtherStuff` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`VersionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vetchecksettings`
--

DROP TABLE IF EXISTS `vetchecksettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vetchecksettings` (
  `SettID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteLocation` varchar(3) DEFAULT NULL,
  `BaseURL` varchar(255) DEFAULT '',
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SettID`),
  KEY `SiteLocation` (`SiteLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vetconnectsettings`
--

DROP TABLE IF EXISTS `vetconnectsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vetconnectsettings` (
  `VetConnectSettingsID` int(10) NOT NULL AUTO_INCREMENT,
  `SiteLocation` varchar(3) DEFAULT NULL,
  `AccountType` varchar(50) DEFAULT NULL,
  `PracticeCountryCode` varchar(3) DEFAULT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `LabAccountID` varchar(255) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`VetConnectSettingsID`),
  KEY `SiteLocation` (`SiteLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visiocareconsultsettings`
--

DROP TABLE IF EXISTS `visiocareconsultsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visiocareconsultsettings` (
  `VisioCareConsultSettingsID` int(10) NOT NULL AUTO_INCREMENT,
  `Workstation` varchar(255) NOT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `RedirectPath` varchar(255) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `TS` datetime DEFAULT NULL,
  PRIMARY KEY (`VisioCareConsultSettingsID`),
  UNIQUE KEY `Workstation` (`Workstation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visit_sheet`
--

DROP TABLE IF EXISTS `visit_sheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_sheet` (
  `Visit_sheet_ID` int(11) NOT NULL,
  `Visit_sheet_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Visit_sheet_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visit_sheet_entry`
--

DROP TABLE IF EXISTS `visit_sheet_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_sheet_entry` (
  `Visit_sheet_entry_ID` int(11) NOT NULL,
  `Visit_sheet_ID` int(11) DEFAULT NULL,
  `Procedure_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Visit_sheet_entry_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voidinvoices`
--

DROP TABLE IF EXISTS `voidinvoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voidinvoices` (
  `VoidInvoiceID` int(11) NOT NULL AUTO_INCREMENT,
  `InvoiceLineID` int(11) DEFAULT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `PractitionerInitials` varchar(3) DEFAULT NULL,
  `VoidDate` datetime DEFAULT NULL,
  `Reason` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`VoidInvoiceID`),
  KEY `InvoiceLineID` (`InvoiceLineID`),
  KEY `ClientID` (`ClientID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webpaymentsettings`
--

DROP TABLE IF EXISTS `webpaymentsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webpaymentsettings` (
  `WebPaymentSettingID` int(11) NOT NULL AUTO_INCREMENT,
  `SiteLocation` varchar(3) DEFAULT NULL,
  `StoreID` varchar(255) DEFAULT NULL,
  `MerchantName` varchar(255) DEFAULT NULL,
  `UrlExpiryDays` int(11) DEFAULT '0',
  `PaymentURLCaption` varchar(255) DEFAULT NULL,
  `ListeningNotificationUrl` varchar(255) DEFAULT NULL,
  `ApiKey` varchar(255) DEFAULT NULL,
  `SharedSecret1` varchar(255) DEFAULT NULL,
  `SharedSecret2` varchar(255) DEFAULT NULL,
  `SMSTextTemplate` varchar(1000) DEFAULT '',
  `ConsultFeeAccountsCategoryNumbers` varchar(255) DEFAULT '',
  `DateCreated` datetime DEFAULT NULL,
  `TS` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `SMSTextTemplate_PaymentRequest` varchar(1000) DEFAULT '',
  PRIMARY KEY (`WebPaymentSettingID`),
  UNIQUE KEY `PaymentUrlSettingID` (`WebPaymentSettingID`),
  UNIQUE KEY `SiteLocation` (`SiteLocation`),
  KEY `StoreID` (`StoreID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webpaymenturls`
--

DROP TABLE IF EXISTS `webpaymenturls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webpaymenturls` (
  `WebPaymentUrlID` int(11) NOT NULL AUTO_INCREMENT,
  `ClientID` int(11) DEFAULT NULL,
  `DocumentType` varchar(255) DEFAULT NULL,
  `DocumentNumber` varchar(15) DEFAULT NULL,
  `ClientRequestID` varchar(255) DEFAULT NULL,
  `ApiTraceID` varchar(255) DEFAULT NULL,
  `OrderID` varchar(255) DEFAULT NULL,
  `PaymentURL` varchar(5000) DEFAULT NULL,
  `ExternalTransactionID` varchar(255) DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `CreatedOnEpochTs` varchar(255) DEFAULT NULL,
  `CreatedOn` datetime DEFAULT NULL,
  `EditedOn` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `AppointmentID` int(11) DEFAULT '0',
  `Amount` decimal(19,2) DEFAULT '0.00',
  `TransactionID` int(11) DEFAULT '0',
  `PaymentRecorded` tinyint(1) DEFAULT '0',
  `ClientDepartmentID` int(11) DEFAULT '0',
  `PaymentID` int(11) DEFAULT '0',
  `CurrencyAbbreviation` varchar(3) DEFAULT NULL,
  `AnimalID` int(11) DEFAULT '0',
  PRIMARY KEY (`WebPaymentUrlID`),
  UNIQUE KEY `PaymentUrlID` (`WebPaymentUrlID`),
  KEY `ClientID` (`ClientID`),
  KEY `DocumentType` (`DocumentType`),
  KEY `DocumentNumber` (`DocumentNumber`),
  KEY `ClientRequestID` (`ClientRequestID`),
  KEY `ApiTraceID` (`ApiTraceID`),
  KEY `OrderID` (`OrderID`),
  KEY `ExternalTransactionID` (`ExternalTransactionID`),
  KEY `AppointmentID` (`AppointmentID`),
  KEY `PaymentRecorded` (`PaymentRecorded`),
  KEY `ClientDepartmentID` (`ClientDepartmentID`),
  KEY `PaymentID` (`PaymentID`),
  KEY `CurrencyAbbreviation` (`CurrencyAbbreviation`),
  KEY `AnimalID` (`AnimalID`)
) ENGINE=InnoDB AUTO_INCREMENT=34821 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-19 17:18:45
