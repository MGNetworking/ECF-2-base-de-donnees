/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  16/02/2020 23:59:12                      */
/* Fait par : Ghalem Maxime                                     */
/*==============================================================*/

-- pour gagner du tps dans workbench
-- drop schema active ;
-- create schema active;

SET foreign_key_checks = 0;

drop table if exists `CLIENT`;
drop table if exists COLLABORATEUR_CLIENT;
drop table if exists COMMENTAIRE;
drop table if exists CONTRAT;
drop table if exists CYCLE_VIE;
drop table if exists DOCUMENTATION;
drop table if exists ETAPE;
drop table if exists FONCTION;
drop table if exists INTERVENTION;
drop table if exists PERMISSION;
drop table if exists PERMISSION_FONCTION;
drop table if exists PERSONNEL;
drop table if exists PROCESSUS;
drop table if exists PROJET;
drop table if exists PROJET_CYCLE;
drop table if exists SALAIRE;
drop table if exists CONTRAT_SALAIRE;
drop table if exists TECHNOLOGIE;
drop table if exists SECTEUR_ACTIVITE;
drop table if exists PROJET_SECTEUR;
drop table if exists TECHNOLOGIE;
drop table if exists CLIENT_PROJET;
drop table if exists COLLABORATEUR_INTER;

SET foreign_key_checks = 1;

/*==============================================================*/
/* Table : PERMISSION  
/*==============================================================*/
CREATE TABLE `PERMISSION` (
   `ID_PERMISSION`          int AUTO_INCREMENT,
   `permission`             VARCHAR(50) NOT NULL,
   `description`            TEXT NOT NULL,

    constraint PK_PERMISSION PRIMARY KEY (ID_PERMISSION)
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : CYCLE_VIE  
/*==============================================================*/
CREATE TABLE `CYCLE_VIE` (
    `ID_CYCLE` int AUTO_INCREMENT,
    `cycle` CHAR(20) NOT NULL,

    constraint PK_CYCLE_VIE PRIMARY KEY (`ID_CYCLE`)
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : FONCTION   
/*==============================================================*/
CREATE TABLE `FONCTION` (
    `ID_FONCTION`      int AUTO_INCREMENT,
    `intituler`         char(100) NOT NULL,

    constraint PK_FONCTION PRIMARY KEY (`ID_FONCTION`)
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
CREATE TABLE `CLIENT` (
    `ID_CLIENT`              int AUTO_INCREMENT,
    `raisonSociale`          CHAR(100) NOT NULL,
    `adresse`                CHAR(100) NOT NULL,
    `telephone`              CHAR(10) NOT NULL,
    `chiffreAffaire`         NUMERIC(10 , 2 ) NOT NULL,
    `effectifs`              int NOT NULL,
    `commentGeneraux`        CHAR(100) NOT NULL,
    `nature`                 ENUM('principale', 'secondaire', 'ancienne') NOT NULL,
    `domain`                 ENUM('public', 'privé') NOT NULL,
    `activite`               CHAR(100) NOT NULL,

    constraint PK_CLIENT PRIMARY KEY (`ID_CLIENT`)

)ENGINE=InnoDB;

/*==============================================================*/
/* Table : PERMISSION_FONCTION                                  */
/*==============================================================*/
create table `PERMISSION_FONCTION`
(
   `ID_FONCTION`                   int not null,
   `ID_PERMISSION`                 int not null,

   constraint PK_PERMISSION_FONCTION primary key (`ID_FONCTION`, `ID_PERMISSION`),

   
   constraint FK_PERMISSION_FONCTION_ID_FONCTION foreign key (`ID_FONCTION`)
         references FONCTION (`ID_FONCTION`) on delete restrict on update restrict,

   constraint FK_PERMISSION_FONCTION_ID_PERMISSION foreign key (`ID_PERMISSION`)
         references PERMISSION (`ID_PERMISSION`) on delete restrict on update restrict
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : PERSONNEL   Matricule   4 caractères numériques, Incrémentation séquentielle */
/*==============================================================*/
create table `PERSONNEL`
(
   `ID_PERSONNEL`         char(4) ,
   `ID_FONCTION`          int not null,
   `nom`                  char(20) not null,
   `prenom`               char(20) not null,
   `adresse1`             char(25) not null,
   `adresse2`             char(25),
   `ville`                char(10) not null,
   `codePostale`          char(5) not null,
   `telephone`            char(10) not null,
   `matricule`            char(4) not null,
   `status`               ENUM('interne', 'externe')  not null,
   `civile`               ENUM('MR', 'MME', 'MLE') not null,
   `sex`                  char(1) not null,

   constraint PERSONNEL_sex check((`CIVILE` ='MR' and  `SEX`='H') or (`CIVILE` ='MME' and  `SEX`='F') or (`CIVILE` ='MLE' and  `SEX`='F')),

   constraint PK_PERSONNEL primary key (`ID_PERSONNEL`),

   constraint FK_PERSONNEL_FONCTION foreign key (`ID_FONCTION`)
      references FONCTION (`ID_FONCTION`) on delete restrict on update restrict

)ENGINE=InnoDB;

/*==============================================================*/
/* Table : SALAIRE 
/*==============================================================*/

CREATE TABLE `SALAIRE` 
(
   `ID_SALAIRE`        int AUTO_INCREMENT,
   `label`             NUMERIC(7,2) NOT NULL,
   `datee`      	   date NOT NULL,

   constraint PK_SALAIRE PRIMARY KEY (`ID_SALAIRE`)
   
) ENGINE=InnoDB;

/*==============================================================*/
/* Table : CONTRAT                                              */
/*==============================================================*/
create table `CONTRAT`
(
   `ID_CONTRAT`           int AUTO_INCREMENT,
   `ID_PERSONNEL`         char(4) not null,
   `contrat`              ENUM('CDD', 'CDI', 'STA')  not null,
   `dateEmbauche`         date not null,
   `dateFin`              date,

   constraint PK_CONTRAT primary key (`ID_CONTRAT`),

   constraint FK_PER_CONTRAT foreign key (`ID_PERSONNEL`)
      references PERSONNEL (`ID_PERSONNEL`) on delete restrict on update restrict

)ENGINE=InnoDB;

/*==============================================================*/
/* Table : CONTRAT_SALAIRE 
/*==============================================================*/

CREATE TABLE `CONTRAT_SALAIRE` 
(
   `ID_SALAIRE`        int not null,
   `ID_CONTRAT`        int not null,

   constraint PK_SALAIRE PRIMARY KEY (`ID_SALAIRE`,`ID_CONTRAT`),

   constraint FK_CONTRAT_SALAIRE_ID_SALAIRE foreign key (`ID_SALAIRE`)
      references SALAIRE(`ID_SALAIRE`)on delete restrict on update restrict,

   constraint FK_CONTRAT_SALAIRE_ID_CONTRAT foreign key (`ID_CONTRAT`)
      references CONTRAT(`ID_CONTRAT`)on delete restrict on update restrict
   
) ENGINE=InnoDB;
/*==============================================================*/
/* Table : DOCUMENTATION                                        */
/*==============================================================*/
create table `DOCUMENTATION`
(
   `ID_DOCUMENTATION`     int AUTO_INCREMENT,
   `ID_PERSONNEL`         char(4) not null,
   `titre`                char(100) not null,
   `remsuDoc`            char(100) not null,
   `dateDiffusion`        date not null,

   constraint PK_DOCUMENTATION primary key (`ID_DOCUMENTATION`),

   constraint FK_DOCUMENTATION foreign key (`ID_PERSONNEL`)
      references PERSONNEL (`ID_PERSONNEL`) on delete restrict on update restrict
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : SECTEUR_ACTIVITÉ                                     */
/*==============================================================*/
create table `SECTEUR_ACTIVITE`
(
      `ID_SECTEUR`      int AUTO_INCREMENT,
      `label`           char(50),

      constraint PK_SECTEUR_ACTIVITE primary key(`ID_SECTEUR`)

);

/*==============================================================*/
/* Table : PROJET                                               */
/*==============================================================*/
create table `PROJET`
(
   `ID_CODEPROJET`         char(4) not null,
   `ID_DOCUMENTATION`      int not null,
   `ID_SECTEUR`            int not null,
   `nomProjet`             char(50) not null,
   `libelCourt`            char(10) not null,
   `libelLong`             char(50) not null,
   `datePrevutDebut`       date not null,
   `datePrevutFin`         date not null,
   `dateReelleDebut`       date,
   `dateReelleFin`         date,
   `ChargeGlobEstime`      numeric(8,0) not null,
   `nBCollaboMax`          numeric(8,0) not null,
   `RemarqueEstimation`    char(100) not null,

   constraint PK_PROJET primary key (`ID_CODEPROJET`),

   constraint FK_PROJET_DOCUMENTATION foreign key (`ID_DOCUMENTATION`)
      references DOCUMENTATION (`ID_DOCUMENTATION`) on delete restrict on update restrict,

   constraint FK_PROJET_SECTEUR_ACTIVITE foreign key (`ID_SECTEUR`)
      references SECTEUR_ACTIVITE (`ID_SECTEUR`) on delete restrict on update restrict

)ENGINE=InnoDB;


/*==============================================================*/
/* Table : PROJET_CYCLE                                         */
/*==============================================================*/
create table `PROJET_CYCLE`
(
   `ID_CYCLE`             int not null,
   `ID_CODEPROJET`        char(4) not null,
   `date`                 date not null,

   constraint PK_PROJET_CYCLE primary key (`ID_CYCLE`, `ID_CODEPROJET`),

   constraint FK_PROJET_CYCLE foreign key (`ID_CYCLE`)
         references CYCLE_VIE (`ID_CYCLE`) on delete restrict on update restrict,

   constraint FK_PROJET_CYCLE2 foreign key (`ID_CODEPROJET`)
         references PROJET (`ID_CODEPROJET`) on delete cascade on update restrict

)ENGINE=InnoDB;


/*==============================================================*/
/* Table : PROCESSUS
/*==============================================================*/
CREATE TABLE `PROCESSUS` (
    `ID_PROCESSUS` INT AUTO_INCREMENT,
    `processus` CHAR(50) NOT NULL,

   constraint PK_PROCESSUS PRIMARY KEY (ID_PROCESSUS)

)ENGINE=InnoDB;



/*==============================================================*/
/* Table : ETAPE                                                */
/*==============================================================*/
create table `ETAPE`
(
   `ID_NUMLOT`               numeric(6,0) not null,
   `ID_PROCESSUS`            int not null,
   `ID_CODEPROJET`           char(4) not null,
   `chargeReelleProd`        int,
   `chargeValidation`        int,
   `chargeInitEstime`        time not null,
   `experience`              char(100) not null,

   constraint PK_ETAPE primary key (ID_NUMLOT),

      constraint FK_ETAPE_PROCES foreign key (`ID_PROCESSUS`)
         references PROCESSUS (`ID_PROCESSUS`) on delete restrict on update restrict,

      constraint FK_ETAPE_PROJET foreign key (`ID_CODEPROJET`)
         references PROJET (`ID_CODEPROJET`) on delete cascade on update restrict

)ENGINE=InnoDB;

/*==============================================================*/
/* Table : INTERVENTION                                         */
/*==============================================================*/
create table `INTERVENTION`
(
      `ID_INTERVENTION`      int AUTO_INCREMENT,
      `ID_PERSONNEL`         char(4) not null,
      `ID_NUMLOT`            numeric(6,0) not null,
      `ID_TECHNOLOGIE`       int not null,
      `ID_FONCTION`          int,
      `intitule`             char(100) not null,
      `date`                 date not null,
      `duree`                numeric(8,0) not null,

   constraint PK_INTERVENTION primary key (`ID_INTERVENTION`),

   constraint FK_PERSONNEL_INTERVENTION foreign key (`ID_PERSONNEL`)
      references PERSONNEL (`ID_PERSONNEL` ) on delete restrict on update restrict,

   constraint FK_INTER_ETAPE foreign key (`ID_NUMLOT`)
      references ETAPE (`ID_NUMLOT`) on delete cascade on update restrict,

   constraint FK_FONCTION_INTER foreign key (`ID_FONCTION`)
      references FONCTION (`ID_FONCTION`) on delete restrict on update restrict

)ENGINE=InnoDB;

/*==============================================================*/
/* Table : COLLABORATEUR_CLIENT                                 */
/*==============================================================*/
create table `COLLABORATEUR_CLIENT`
(
      `ID_COLLABORATEUR`      int AUTO_INCREMENT,
      `ID_CLIENT`             int not null,
      `ID_FONCTION`           int not null,
      `nom`                   char(20) not null,
      `commentSpe` char(100),
      `commentPro`     char(100),
      `adressEmail`           char(40),

      constraint PK_COLLABORATEUR_CLIENT primary key (`ID_COLLABORATEUR`),
   
      constraint FK_CLIENT_COLLABORATEUR foreign key (`ID_CLIENT`) 
            references CLIENT (`ID_CLIENT`) on delete restrict on update restrict,

      constraint FK_COLLABO_FONCTION foreign key (`ID_FONCTION`) 
            references FONCTION (`ID_FONCTION`) on delete restrict on update restrict
            
)ENGINE=InnoDB;


/*==============================================================*/
/* Table : CLIENT_PROJET                                        */
/*==============================================================*/
create table `CLIENT_PROJET`
(
      `ID_CODEPROJET`         char(4) not null,
      `ID_COLLABORATEUR`      int not null,

      constraint PK_COLLABORATEUR_CLIENT primary key (`ID_CODEPROJET`,`ID_COLLABORATEUR`),
   
      constraint FK_CLIENT_PROJET_ID_CODEPROJET foreign key (`ID_CODEPROJET`) 
            references PROJET (`ID_CODEPROJET`) on delete cascade on update restrict,

      constraint FK_CLIENT_PROJET_ID_CLIENT foreign key (`ID_COLLABORATEUR`) 
            references COLLABORATEUR_CLIENT (`ID_COLLABORATEUR`) on delete restrict on update restrict
            
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : COLLABORATEUR_INTERVENTION                           */
/*==============================================================*/
create table `COLLABORATEUR_INTER`
(
      `ID_COLLABORATEUR`      int not null,
      `ID_INTERVENTION`       int not null,

      constraint PK_COLLABORATEUR_INTER primary key (`ID_COLLABORATEUR`,`ID_INTERVENTION`),
   
      constraint FK_COLLABORATEUR_INTER_ID_COLLABORATEUR foreign key (`ID_COLLABORATEUR`) 
            references COLLABORATEUR_CLIENT (`ID_COLLABORATEUR`) on delete restrict on update restrict,

      constraint FK_COLLABORATEUR_INTER_ID_INTERVENTION foreign key (`ID_INTERVENTION`) 
            references INTERVENTION (`ID_INTERVENTION`) on delete cascade on update restrict
            
)ENGINE=InnoDB;

/*======================================================================*/
/* Table : COMMENTAIRE                                                  */
/* le commantaire peut étre supprimer d'un projet, d'une étape ou       */
/* d'une intervention. C'est pourquoi une clause on delete cascade      */
/* et placer aprés chaque clef étranger susceptible d'étre sollicité.   */
/*======================================================================*/
create table `COMMENTAIRE`
(
      `ID_COMMENTAIRE`       int AUTO_INCREMENT,
      `ID_CODEPROJET`        char(4) ,
      `ID_INTERVENTION`      int ,
      `ID_PERSONNEL`         char(4) not null,
      `ID_NUMLOT`            numeric(6,0) ,
      `commentaire`          char(100) not null,

      primary key (`ID_COMMENTAIRE`),

      
      constraint FK_COMMENTAIRE_PROJET foreign key (`ID_CODEPROJET`)
            references PROJET (`ID_CODEPROJET`) on delete cascade on update restrict,

      constraint FK_COMMENTAIRE_INTER foreign key (`ID_INTERVENTION`)
            references INTERVENTION (`ID_INTERVENTION`) on delete cascade on update restrict,

      constraint FK_COMMENTAIRE_PERS foreign key (`ID_PERSONNEL`)
            references PERSONNEL (`ID_PERSONNEL`) on delete restrict on update restrict,

      constraint FK_COMMENTAIRE_ETAPE foreign key (`ID_NUMLOT`)
            references ETAPE (`ID_NUMLOT`) on delete cascade on update restrict
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : TECHNOLOGIE                                          */
/*==============================================================*/
create table `TECHNOLOGIE`
(
   `ID_TECHNOLOGIE`       int AUTO_INCREMENT,
   `technologie`          char(100) not null,

   primary key (`ID_TECHNOLOGIE`)

)ENGINE=InnoDB;


