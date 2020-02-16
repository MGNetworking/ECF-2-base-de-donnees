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
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'clemessy colmar','rue du machin','0607982521',5000000.00,2,'commentaire de l\'afpa','principale','public','formation'),(2,'clemessy Mulhouse','rue du bidule','0607080910',3000.00,100,'commentaire de clemessy','secondaire','privé','formation'),(3,'client teste','rue du machin','0607982521',300000.00,2,'commentaire de l\'afpa','principale','public','formation');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `client_projet`
--

LOCK TABLES `client_projet` WRITE;
/*!40000 ALTER TABLE `client_projet` DISABLE KEYS */;
INSERT INTO `client_projet` VALUES ('2001',1),('2001',2),('2002',3);
/*!40000 ALTER TABLE `client_projet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `collaborateur_client`
--

LOCK TABLES `collaborateur_client` WRITE;
/*!40000 ALTER TABLE `collaborateur_client` DISABLE KEYS */;
INSERT INTO `collaborateur_client` VALUES (1,1,6,'jean jack','intervant commerciale pour clemssey','no comment','jeanJack@gmail.com'),(2,1,3,'Fabien','intervant developpement pour clemssey','preparation du matériel','fabien.zindinzidan@gmail.com'),(3,2,4,'maxime','intervant developpement pour AFPA','dévelpeur','ghalem.max@gmail.com');
/*!40000 ALTER TABLE `collaborateur_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `collaborateur_inter`
--

LOCK TABLES `collaborateur_inter` WRITE;
/*!40000 ALTER TABLE `collaborateur_inter` DISABLE KEYS */;
INSERT INTO `collaborateur_inter` VALUES (1,1),(1,2),(2,3);
/*!40000 ALTER TABLE `collaborateur_inter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `commentaire`
--

LOCK TABLES `commentaire` WRITE;
/*!40000 ALTER TABLE `commentaire` DISABLE KEYS */;
INSERT INTO `commentaire` VALUES (1,NULL,1,'cccc',NULL,'commentaire sur l\'interface de développement'),(2,NULL,1,'ffff',NULL,'commentaire sur le cahier des charges'),(3,NULL,4,'gggg',NULL,'commentaire sur la base de données');
/*!40000 ALTER TABLE `commentaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `contrat`
--

LOCK TABLES `contrat` WRITE;
/*!40000 ALTER TABLE `contrat` DISABLE KEYS */;
INSERT INTO `contrat` VALUES (1,'cccc','CDI','2006-10-10',NULL),(2,'ffff','CDI','2005-01-10',NULL),(3,'gggg','CDD','2017-08-15','2019-08-15'),(4,'dddd','CDD','2005-02-10','2006-02-10'),(5,'eeee','CDI','2019-12-10',NULL),(6,'gggg','CDI','2019-08-16',NULL);
/*!40000 ALTER TABLE `contrat` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `contrat_salaire`
--

LOCK TABLES `contrat_salaire` WRITE;
/*!40000 ALTER TABLE `contrat_salaire` DISABLE KEYS */;
INSERT INTO `contrat_salaire` VALUES (1,1),(2,2),(4,3),(3,4),(5,5),(6,6);
/*!40000 ALTER TABLE `contrat_salaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cycle_vie`
--

LOCK TABLES `cycle_vie` WRITE;
/*!40000 ALTER TABLE `cycle_vie` DISABLE KEYS */;
INSERT INTO `cycle_vie` VALUES (1,'complet'),(2,'étude'),(3,'développement');
/*!40000 ALTER TABLE `cycle_vie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `documentation`
--

LOCK TABLES `documentation` WRITE;
/*!40000 ALTER TABLE `documentation` DISABLE KEYS */;
INSERT INTO `documentation` VALUES (1,'cccc','développement application','resumé développement','2010-06-25'),(2,'ffff','projet 2','resumé du projet 2','2012-09-06');
/*!40000 ALTER TABLE `documentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `etape`
--

LOCK TABLES `etape` WRITE;
/*!40000 ALTER TABLE `etape` DISABLE KEYS */;
INSERT INTO `etape` VALUES (1,1,'2001',1800,1800,'00:15:00','Aucun retour expérience'),(2,8,'2002',0,0,'00:00:00','Aucun retour expérience');
/*!40000 ALTER TABLE `etape` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `fonction`
--

LOCK TABLES `fonction` WRITE;
/*!40000 ALTER TABLE `fonction` DISABLE KEYS */;
INSERT INTO `fonction` VALUES (1,'Responsable de projet'),(2,'Analyste responsable d’application'),(3,'Développeur'),(4,'Technicien support'),(5,'Commercial'),(6,'Technico-commercial'),(7,'Secrétaire'),(8,'responsable des études'),(9,'secrétariat technique'),(10,'chef de projet'),(11,'responsable commercial'),(12,'responsable d\'étude');
/*!40000 ALTER TABLE `fonction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `intervention`
--

LOCK TABLES `intervention` WRITE;
/*!40000 ALTER TABLE `intervention` DISABLE KEYS */;
INSERT INTO `intervention` VALUES (1,'cccc',1,1,4,'développement de l\'interface user java','2020-02-20',70),(2,'gggg',1,3,3,'développement de connection a tomcat','2020-03-08',20),(3,'ffff',1,7,2,'développement de la base de données','2020-03-12',25),(4,'eeee',2,1,8,'recherche est d\'information','2020-03-12',25);
/*!40000 ALTER TABLE `intervention` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'CREATE','création de fichier'),(2,'READ','lecture de fichier'),(3,'UPDATE','mise à jours de fichier'),(4,'DELETE','suppréssion de fichier');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `permission_fonction`
--

LOCK TABLES `permission_fonction` WRITE;
/*!40000 ALTER TABLE `permission_fonction` DISABLE KEYS */;
INSERT INTO `permission_fonction` VALUES (1,1),(6,1),(1,2),(6,2),(1,3),(6,3),(1,4),(6,4);
/*!40000 ALTER TABLE `permission_fonction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `personnel`
--

LOCK TABLES `personnel` WRITE;
/*!40000 ALTER TABLE `personnel` DISABLE KEYS */;
INSERT INTO `personnel` VALUES ('cccc',1,'dupont','moréti','6 rue de labas','','amiens','80800','0698442069','2002','interne','MR','H'),('dddd',4,'philipe','maurice','29 rue d\'en haut','','molien','80300','0698442069','3030','externe','MR','H'),('eeee',5,'papin','jean pierre','89 rue de chez lui','','paris','95000','098472079','3030','externe','MR','H'),('ffff',2,'celine','truc','9 rue truc','','mulhouse','68000','0698442069','2060','interne','MME','F'),('gggg',3,'emmanuelle','dubois','6 rue machine truc','','altkirch','68130','0698442069','2050','externe','MLE','F');
/*!40000 ALTER TABLE `personnel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `processus`
--

LOCK TABLES `processus` WRITE;
/*!40000 ALTER TABLE `processus` DISABLE KEYS */;
INSERT INTO `processus` VALUES (1,'analyse des besoins'),(2,'analyse des besoins Conception'),(3,'Tests unitaires'),(4,'Tests d’intégration'),(5,'Tests de recette et installation'),(6,'Management du projet'),(7,'Gestion de configuration'),(8,'Formation spécifique au projet');
/*!40000 ALTER TABLE `processus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `projet`
--

LOCK TABLES `projet` WRITE;
/*!40000 ALTER TABLE `projet` DISABLE KEYS */;
INSERT INTO `projet` VALUES ('2001',1,3,'Mni PCCN','deve','Développement Application Web','2019-09-25','2020-01-15',NULL,NULL,15000,5,'aucun remarque'),('2002',2,3,'IHM autoroute','deve','Développement IHM','2019-02-20','2020-01-20',NULL,'2020-01-20',2000,2,'aucun remarque');
/*!40000 ALTER TABLE `projet` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `projet_cycle`
--

LOCK TABLES `projet_cycle` WRITE;
/*!40000 ALTER TABLE `projet_cycle` DISABLE KEYS */;
INSERT INTO `projet_cycle` VALUES (1,'2001','2005-01-10'),(2,'2001','2005-01-10'),(3,'2001','2005-01-10');
/*!40000 ALTER TABLE `projet_cycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `salaire`
--

LOCK TABLES `salaire` WRITE;
/*!40000 ALTER TABLE `salaire` DISABLE KEYS */;
INSERT INTO `salaire` VALUES (1,1500.00,'2006-10-10'),(2,1600.00,'2005-10-01'),(3,1800.00,'2005-02-10'),(4,1500.00,'2017-08-15'),(5,1800.00,'2019-12-10'),(6,1900.00,'2019-08-16');
/*!40000 ALTER TABLE `salaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `secteur_activite`
--

LOCK TABLES `secteur_activite` WRITE;
/*!40000 ALTER TABLE `secteur_activite` DISABLE KEYS */;
INSERT INTO `secteur_activite` VALUES (1,'gestion commerciale'),(2,'gestion des ressource humaine'),(3,'production'),(4,'Achat');
/*!40000 ALTER TABLE `secteur_activite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `technologie`
--

LOCK TABLES `technologie` WRITE;
/*!40000 ALTER TABLE `technologie` DISABLE KEYS */;
INSERT INTO `technologie` VALUES (1,'java'),(2,'C++'),(3,'Tomcat'),(4,'glassFich'),(5,'VueJS'),(6,'AngularJs'),(7,'Mysql');
/*!40000 ALTER TABLE `technologie` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2020-02-16 23:53:43
