CREATE DATABASE  IF NOT EXISTS `active` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `active`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: active
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `ID_CLIENT` int(11) NOT NULL AUTO_INCREMENT,
  `raisonSociale` char(100) NOT NULL,
  `adresse` char(100) NOT NULL,
  `telephone` char(10) NOT NULL,
  `chiffreAffaire` decimal(10,2) NOT NULL,
  `effectifs` int(11) NOT NULL,
  `commentGeneraux` char(100) NOT NULL,
  `nature` enum('principale','secondaire','ancienne') NOT NULL,
  `domain` enum('public','privé') NOT NULL,
  `activite` char(100) NOT NULL,
  PRIMARY KEY (`ID_CLIENT`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_projet`
--

DROP TABLE IF EXISTS `client_projet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_projet` (
  `ID_CODEPROJET` char(4) NOT NULL,
  `ID_COLLABORATEUR` int(11) NOT NULL,
  PRIMARY KEY (`ID_CODEPROJET`,`ID_COLLABORATEUR`),
  KEY `FK_CLIENT_PROJET_ID_CLIENT` (`ID_COLLABORATEUR`),
  CONSTRAINT `FK_CLIENT_PROJET_ID_CLIENT` FOREIGN KEY (`ID_COLLABORATEUR`) REFERENCES `collaborateur_client` (`ID_COLLABORATEUR`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_CLIENT_PROJET_ID_CODEPROJET` FOREIGN KEY (`ID_CODEPROJET`) REFERENCES `projet` (`ID_CODEPROJET`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collaborateur_client`
--

DROP TABLE IF EXISTS `collaborateur_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collaborateur_client` (
  `ID_COLLABORATEUR` int(11) NOT NULL AUTO_INCREMENT,
  `ID_CLIENT` int(11) NOT NULL,
  `ID_FONCTION` int(11) NOT NULL,
  `nom` char(20) NOT NULL,
  `commentSpe` char(100) DEFAULT NULL,
  `commentPro` char(100) DEFAULT NULL,
  `adressEmail` char(40) DEFAULT NULL,
  PRIMARY KEY (`ID_COLLABORATEUR`),
  KEY `FK_CLIENT_COLLABORATEUR` (`ID_CLIENT`),
  KEY `FK_COLLABO_FONCTION` (`ID_FONCTION`),
  CONSTRAINT `FK_CLIENT_COLLABORATEUR` FOREIGN KEY (`ID_CLIENT`) REFERENCES `client` (`ID_CLIENT`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_COLLABO_FONCTION` FOREIGN KEY (`ID_FONCTION`) REFERENCES `fonction` (`ID_FONCTION`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collaborateur_inter`
--

DROP TABLE IF EXISTS `collaborateur_inter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collaborateur_inter` (
  `ID_COLLABORATEUR` int(11) NOT NULL,
  `ID_INTERVENTION` int(11) NOT NULL,
  PRIMARY KEY (`ID_COLLABORATEUR`,`ID_INTERVENTION`),
  KEY `FK_COLLABORATEUR_INTER_ID_INTERVENTION` (`ID_INTERVENTION`),
  CONSTRAINT `FK_COLLABORATEUR_INTER_ID_COLLABORATEUR` FOREIGN KEY (`ID_COLLABORATEUR`) REFERENCES `collaborateur_client` (`ID_COLLABORATEUR`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_COLLABORATEUR_INTER_ID_INTERVENTION` FOREIGN KEY (`ID_INTERVENTION`) REFERENCES `intervention` (`ID_INTERVENTION`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commentaire`
--

DROP TABLE IF EXISTS `commentaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentaire` (
  `ID_COMMENTAIRE` int(11) NOT NULL AUTO_INCREMENT,
  `ID_CODEPROJET` char(4) DEFAULT NULL,
  `ID_INTERVENTION` int(11) DEFAULT NULL,
  `ID_PERSONNEL` char(4) NOT NULL,
  `ID_NUMLOT` decimal(6,0) DEFAULT NULL,
  `commentaire` char(100) NOT NULL,
  PRIMARY KEY (`ID_COMMENTAIRE`),
  KEY `FK_COMMENTAIRE_PROJET` (`ID_CODEPROJET`),
  KEY `FK_COMMENTAIRE_INTER` (`ID_INTERVENTION`),
  KEY `FK_COMMENTAIRE_PERS` (`ID_PERSONNEL`),
  KEY `FK_COMMENTAIRE_ETAPE` (`ID_NUMLOT`),
  CONSTRAINT `FK_COMMENTAIRE_ETAPE` FOREIGN KEY (`ID_NUMLOT`) REFERENCES `etape` (`ID_NUMLOT`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_COMMENTAIRE_INTER` FOREIGN KEY (`ID_INTERVENTION`) REFERENCES `intervention` (`ID_INTERVENTION`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_COMMENTAIRE_PERS` FOREIGN KEY (`ID_PERSONNEL`) REFERENCES `personnel` (`ID_PERSONNEL`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_COMMENTAIRE_PROJET` FOREIGN KEY (`ID_CODEPROJET`) REFERENCES `projet` (`ID_CODEPROJET`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contrat`
--

DROP TABLE IF EXISTS `contrat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrat` (
  `ID_CONTRAT` int(11) NOT NULL AUTO_INCREMENT,
  `ID_PERSONNEL` char(4) NOT NULL,
  `contrat` enum('CDD','CDI','STA') NOT NULL,
  `dateEmbauche` date NOT NULL,
  `dateFin` date DEFAULT NULL,
  PRIMARY KEY (`ID_CONTRAT`),
  KEY `FK_PER_CONTRAT` (`ID_PERSONNEL`),
  CONSTRAINT `FK_PER_CONTRAT` FOREIGN KEY (`ID_PERSONNEL`) REFERENCES `personnel` (`ID_PERSONNEL`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Maxime`@`localhost`*/ /*!50003 TRIGGER `status_contrat` BEFORE UPDATE ON `contrat` FOR EACH ROW begin 
            DECLARE old_Status , new_Status INT ;
			-- affectation de valeur pour l'ancien contrat
            case 
				when old.contrat = 'STA' then set old_Status = 1;       
                when old.contrat = 'CDD' then set old_Status = 2;
                when old.contrat = 'CDI' then set old_Status = 3;
			end case;
            -- affection de valeur pour le nouveau contrat 
			case 
                when new.contrat = 'STA' then set new_Status = 1;
                when new.contrat = 'CDD' then set new_Status = 2;
                when new.contrat = 'CDI' then set new_Status = 3;
			end case;
            
            -- teste si le nouveau contrat a un status plus élevé
            if  old_Status > new_Status  then
				signal sqlstate '45000' set message_text = "vous ne pouvez pas faire évoluer ce contrat vers ce nouveau status";
            end if;

		end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `contrat_salaire`
--

DROP TABLE IF EXISTS `contrat_salaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrat_salaire` (
  `ID_SALAIRE` int(11) NOT NULL,
  `ID_CONTRAT` int(11) NOT NULL,
  PRIMARY KEY (`ID_SALAIRE`,`ID_CONTRAT`),
  KEY `FK_CONTRAT_SALAIRE_ID_CONTRAT` (`ID_CONTRAT`),
  CONSTRAINT `FK_CONTRAT_SALAIRE_ID_CONTRAT` FOREIGN KEY (`ID_CONTRAT`) REFERENCES `contrat` (`ID_CONTRAT`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_CONTRAT_SALAIRE_ID_SALAIRE` FOREIGN KEY (`ID_SALAIRE`) REFERENCES `salaire` (`ID_SALAIRE`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cycle_vie`
--

DROP TABLE IF EXISTS `cycle_vie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cycle_vie` (
  `ID_CYCLE` int(11) NOT NULL AUTO_INCREMENT,
  `cycle` char(20) NOT NULL,
  PRIMARY KEY (`ID_CYCLE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documentation`
--

DROP TABLE IF EXISTS `documentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentation` (
  `ID_DOCUMENTATION` int(11) NOT NULL AUTO_INCREMENT,
  `ID_PERSONNEL` char(4) NOT NULL,
  `titre` char(100) NOT NULL,
  `remsuDoc` char(100) NOT NULL,
  `dateDiffusion` date NOT NULL,
  PRIMARY KEY (`ID_DOCUMENTATION`),
  KEY `FK_DOCUMENTATION` (`ID_PERSONNEL`),
  CONSTRAINT `FK_DOCUMENTATION` FOREIGN KEY (`ID_PERSONNEL`) REFERENCES `personnel` (`ID_PERSONNEL`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etape`
--

DROP TABLE IF EXISTS `etape`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etape` (
  `ID_NUMLOT` decimal(6,0) NOT NULL,
  `ID_PROCESSUS` int(11) NOT NULL,
  `ID_CODEPROJET` char(4) NOT NULL,
  `chargeReelleProd` int(11) DEFAULT NULL,
  `chargeValidation` int(11) DEFAULT NULL,
  `chargeInitEstime` time NOT NULL,
  `experience` char(100) NOT NULL,
  PRIMARY KEY (`ID_NUMLOT`),
  KEY `FK_ETAPE_PROCES` (`ID_PROCESSUS`),
  KEY `FK_ETAPE_PROJET` (`ID_CODEPROJET`),
  CONSTRAINT `FK_ETAPE_PROCES` FOREIGN KEY (`ID_PROCESSUS`) REFERENCES `processus` (`ID_PROCESSUS`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_ETAPE_PROJET` FOREIGN KEY (`ID_CODEPROJET`) REFERENCES `projet` (`ID_CODEPROJET`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fonction`
--

DROP TABLE IF EXISTS `fonction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fonction` (
  `ID_FONCTION` int(11) NOT NULL AUTO_INCREMENT,
  `intituler` char(100) NOT NULL,
  PRIMARY KEY (`ID_FONCTION`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intervention`
--

DROP TABLE IF EXISTS `intervention`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intervention` (
  `ID_INTERVENTION` int(11) NOT NULL AUTO_INCREMENT,
  `ID_PERSONNEL` char(4) NOT NULL,
  `ID_NUMLOT` decimal(6,0) NOT NULL,
  `ID_TECHNOLOGIE` int(11) NOT NULL,
  `ID_FONCTION` int(11) DEFAULT NULL,
  `intitule` char(100) NOT NULL,
  `date` date NOT NULL,
  `duree` decimal(8,0) NOT NULL,
  PRIMARY KEY (`ID_INTERVENTION`),
  KEY `FK_PERSONNEL_INTERVENTION` (`ID_PERSONNEL`),
  KEY `FK_INTER_ETAPE` (`ID_NUMLOT`),
  KEY `FK_FONCTION_INTER` (`ID_FONCTION`),
  CONSTRAINT `FK_FONCTION_INTER` FOREIGN KEY (`ID_FONCTION`) REFERENCES `fonction` (`ID_FONCTION`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_INTER_ETAPE` FOREIGN KEY (`ID_NUMLOT`) REFERENCES `etape` (`ID_NUMLOT`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_PERSONNEL_INTERVENTION` FOREIGN KEY (`ID_PERSONNEL`) REFERENCES `personnel` (`ID_PERSONNEL`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `ID_PERMISSION` int(11) NOT NULL AUTO_INCREMENT,
  `permission` varchar(50) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`ID_PERMISSION`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission_fonction`
--

DROP TABLE IF EXISTS `permission_fonction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_fonction` (
  `ID_FONCTION` int(11) NOT NULL,
  `ID_PERMISSION` int(11) NOT NULL,
  PRIMARY KEY (`ID_FONCTION`,`ID_PERMISSION`),
  KEY `FK_PERMISSION_FONCTION_ID_PERMISSION` (`ID_PERMISSION`),
  CONSTRAINT `FK_PERMISSION_FONCTION_ID_FONCTION` FOREIGN KEY (`ID_FONCTION`) REFERENCES `fonction` (`ID_FONCTION`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_PERMISSION_FONCTION_ID_PERMISSION` FOREIGN KEY (`ID_PERMISSION`) REFERENCES `permission` (`ID_PERMISSION`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personnel`
--

DROP TABLE IF EXISTS `personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personnel` (
  `ID_PERSONNEL` char(4) NOT NULL,
  `ID_FONCTION` int(11) NOT NULL,
  `nom` char(20) NOT NULL,
  `prenom` char(20) NOT NULL,
  `adresse1` char(25) NOT NULL,
  `adresse2` char(25) DEFAULT NULL,
  `ville` char(10) NOT NULL,
  `codePostale` char(5) NOT NULL,
  `telephone` char(10) NOT NULL,
  `matricule` char(4) NOT NULL,
  `status` enum('interne','externe') NOT NULL,
  `civile` enum('MR','MME','MLE') NOT NULL,
  `sex` char(1) NOT NULL,
  PRIMARY KEY (`ID_PERSONNEL`),
  KEY `FK_PERSONNEL_FONCTION` (`ID_FONCTION`),
  CONSTRAINT `FK_PERSONNEL_FONCTION` FOREIGN KEY (`ID_FONCTION`) REFERENCES `fonction` (`ID_FONCTION`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `PERSONNEL_sex` CHECK ((((`CIVILE` = _utf8mb4'MR') and (`SEX` = _utf8mb4'H')) or ((`CIVILE` = _utf8mb4'MME') and (`SEX` = _utf8mb4'F')) or ((`CIVILE` = _utf8mb4'MLE') and (`SEX` = _utf8mb4'F'))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `processus`
--

DROP TABLE IF EXISTS `processus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `processus` (
  `ID_PROCESSUS` int(11) NOT NULL AUTO_INCREMENT,
  `processus` char(50) NOT NULL,
  PRIMARY KEY (`ID_PROCESSUS`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projet`
--

DROP TABLE IF EXISTS `projet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projet` (
  `ID_CODEPROJET` char(4) NOT NULL,
  `ID_DOCUMENTATION` int(11) NOT NULL,
  `ID_SECTEUR` int(11) NOT NULL,
  `nomProjet` char(50) NOT NULL,
  `libelCourt` char(10) NOT NULL,
  `libelLong` char(50) NOT NULL,
  `datePrevutDebut` date NOT NULL,
  `datePrevutFin` date NOT NULL,
  `dateReelleDebut` date DEFAULT NULL,
  `dateReelleFin` date DEFAULT NULL,
  `ChargeGlobEstime` decimal(8,0) NOT NULL,
  `nBCollaboMax` decimal(8,0) NOT NULL,
  `RemarqueEstimation` char(100) NOT NULL,
  PRIMARY KEY (`ID_CODEPROJET`),
  KEY `FK_PROJET_DOCUMENTATION` (`ID_DOCUMENTATION`),
  KEY `FK_PROJET_SECTEUR_ACTIVITE` (`ID_SECTEUR`),
  CONSTRAINT `FK_PROJET_DOCUMENTATION` FOREIGN KEY (`ID_DOCUMENTATION`) REFERENCES `documentation` (`ID_DOCUMENTATION`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_PROJET_SECTEUR_ACTIVITE` FOREIGN KEY (`ID_SECTEUR`) REFERENCES `secteur_activite` (`ID_SECTEUR`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Maxime`@`localhost`*/ /*!50003 TRIGGER `date_previsionnelle` BEFORE INSERT ON `projet` FOR EACH ROW begin
			-- génére une exception si la date de début et plus petit que celle de fin 
			if (new.datePrevutDebut >= new.datePrevutFin) then
			signal sqlstate '45000' set message_text = 'la date prévisionelle de début de projet doit étre plus ancienne que celle de fin projet';
		end if;

    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Maxime`@`localhost`*/ /*!50003 TRIGGER `suprimer_projet` BEFORE DELETE ON `projet` FOR EACH ROW begin 
    
		-- si le projet et fini depuis moin de 2 mois, blockage de la suppriession
		if ((old.datePrevutFin - current_date()) < 60) then 
			signal sqlstate '45000' set message_text = "Le délai des 60 jours pour la suppression du projet n'est pas arriver a échéance";
		end if;
    
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `projet_cycle`
--

DROP TABLE IF EXISTS `projet_cycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projet_cycle` (
  `ID_CYCLE` int(11) NOT NULL,
  `ID_CODEPROJET` char(4) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`ID_CYCLE`,`ID_CODEPROJET`),
  KEY `FK_PROJET_CYCLE2` (`ID_CODEPROJET`),
  CONSTRAINT `FK_PROJET_CYCLE` FOREIGN KEY (`ID_CYCLE`) REFERENCES `cycle_vie` (`ID_CYCLE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_PROJET_CYCLE2` FOREIGN KEY (`ID_CODEPROJET`) REFERENCES `projet` (`ID_CODEPROJET`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salaire`
--

DROP TABLE IF EXISTS `salaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salaire` (
  `ID_SALAIRE` int(11) NOT NULL AUTO_INCREMENT,
  `label` decimal(7,2) NOT NULL,
  `datee` date NOT NULL,
  PRIMARY KEY (`ID_SALAIRE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secteur_activite`
--

DROP TABLE IF EXISTS `secteur_activite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `secteur_activite` (
  `ID_SECTEUR` int(11) NOT NULL AUTO_INCREMENT,
  `label` char(50) DEFAULT NULL,
  PRIMARY KEY (`ID_SECTEUR`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `technologie`
--

DROP TABLE IF EXISTS `technologie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technologie` (
  `ID_TECHNOLOGIE` int(11) NOT NULL AUTO_INCREMENT,
  `technologie` char(100) NOT NULL,
  PRIMARY KEY (`ID_TECHNOLOGIE`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'active'
--

--
-- Dumping routines for database 'active'
--
/*!50003 DROP FUNCTION IF EXISTS `new_project_code` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Maxime`@`localhost` FUNCTION `new_project_code`() RETURNS char(4) CHARSET utf8mb4
    READS SQL DATA
begin
	declare codemax char(4);
	select max(ID_CODEPROJET) from projet into codemax ;
	if substring( codemax , 1 , 2 ) like substring( year( current_date() ) , 3 ) then
		set codeMax = codeMax + 1;
	else
		set codeMax = ( substring( year( current_date() ) , 3 ) * 100 ) + 1 ; 
	end if;
	return codeMax; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `charge_estimer_projet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Maxime`@`localhost` PROCEDURE `charge_estimer_projet`()
begin 

	select avg(ChargeGlobEstime)
	from projet 
	where dateReelleFin is null;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `donner_technique` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Maxime`@`localhost` PROCEDURE `donner_technique`()
begin 

	select nomProjet , technologie
		from projet p 
			inner join etape e on p.ID_CODEPROJET = e.ID_CODEPROJET
			inner join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
			inner join technologie t on i.ID_TECHNOLOGIE = t.ID_TECHNOLOGIE
	where datediff(current_date, dateReelleFin) > (365*2);

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `liste_intervention` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Maxime`@`localhost` PROCEDURE `liste_intervention`(in entreDate varcharacter(10), in sortiDate varcharacter(10)  )
begin 

select nom, f.intituler as 'fonction collaborateur' , `date` as 'date intervention' , i.intitule as 'tache executer'
	from projet p 
			inner join etape e on p.ID_CODEPROJET = e.ID_CODEPROJET
			inner join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
            inner join personnel pl on i.ID_PERSONNEL = pl.ID_PERSONNEL
			inner join technologie t on i.ID_TECHNOLOGIE = t.ID_TECHNOLOGIE
            inner join fonction f on i.ID_FONCTION = f.ID_FONCTION
where `date` between  str_to_date(entreDate, '%d/%m/%Y') and  str_to_date(sortiDate, '%d/%m/%Y');

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-16 23:51:57
