/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de cr�ation :  08/02/2020 15:32:56                      */
/*==============================================================*/

-- drop schema active ;
-- create schema active;

SET foreign_key_checks = 0;

drop table if exists CLIENT;

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

drop table if exists TECHNOLOGIE;

SET foreign_key_checks = 1;

/*==============================================================*/
/* Table : PERMISSION  
/*==============================================================*/
CREATE TABLE PERMISSION (
    ID_PERMISSION          int NOT NULL,
    PERMISSION             VARCHAR(50) NOT NULL,
    DESCRIPTION            TEXT NOT NULL,

    constraint PK_PERMISSION PRIMARY KEY (ID_PERMISSION)
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : SALAIRE 
/*==============================================================*/
CREATE TABLE SALAIRE (
   ID_SALAIRE        int not null,
   SALAIRE           NUMERIC(7,2) NOT NULL,
   DATEEMBAUCHE      date NOT NULL,
   DATEFIN           date ,

   constraint PK_SALAIRE PRIMARY KEY (ID_SALAIRE)
) ENGINE=InnoDB;

/*==============================================================*/
/* Table : CYCLE_VIE  
/*==============================================================*/
CREATE TABLE CYCLE_VIE (
    ID_CYCLE INT NOT NULL,
    CYCLE CHAR(10) NOT NULL,

    constraint PK_CYCLE_VIE PRIMARY KEY (ID_CYCLE)
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : FONCTION   
/*==============================================================*/
CREATE TABLE FONCTION (
    ID_FONCTION      int NOT NULL,
    INTITULE         char(100) NOT NULL,

    constraint PK_FONCTION PRIMARY KEY (ID_FONCTION)
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
CREATE TABLE CLIENT (
    ID_CLIENT              numeric(4),
    RAISONSOCIALE          CHAR(100) NOT NULL,
    ADRESSE                CHAR(100) NOT NULL,
    TELEPHONE              CHAR(10) NOT NULL,
    CHIFFREAFFAIRE         NUMERIC(10 , 2 ) NOT NULL,
    EFFECTIFS              int NOT NULL,
    COMMENTAIREGENERAUX    CHAR(100) NOT NULL,
    NATURE                 ENUM('principale', 'secondaire', 'ancienne') NOT NULL,
    DOMAIN                 ENUM('public', 'privé') NOT NULL,
    ACTIVITE               CHAR(100) NOT NULL,

    constraint PK_CLIENT PRIMARY KEY (ID_CLIENT)
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : PERMISSION_FONCTION                                  */
/*==============================================================*/
create table PERMISSION_FONCTION
(
   ID_FONCTION                   int not null,
   ID_PERMISSION                 int not null,

   constraint PK_PERMISSION_FONCTION primary key (ID_FONCTION, ID_PERMISSION),

   
   constraint FK_PERMISSION_FONCTION_ID_FONCTION foreign key (ID_FONCTION)
         references FONCTION (ID_FONCTION) on delete restrict on update restrict,

   constraint FK_PERMISSION_FONCTION_ID_PERMISSION foreign key (ID_PERMISSION)
         references PERMISSION (ID_PERMISSION) on delete restrict on update restrict
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : PERSONNEL                                            */
/*==============================================================*/
create table PERSONNEL
(
   ID_PERSONNEL         char(4) not null,
   ID_FONCTION          int not null,
   ID_SALAIRE           int not null,
   NOM                  char(20) not null,
   PRENOM               char(20) not null,
   ADRESSE1             char(25) not null,
   ADRESSE2             char(25),
   VILLE                char(10) not null,
   CODEPOSTALE          char(5) not null,
   TELEPHONEPERSONNE    char(10) not null,
   MATRICULE            char(4) not null,
   STATUS                ENUM('interne', 'externe')  not null,
   CIVILE                ENUM('MR', 'MME', 'MLE') not null,
   SEX                  char(1) not null,

   constraint PERSONNEL_sex_MR check((CIVILE ='MR' and  SEX='H') or (CIVILE ='MME' and  SEX='F') or (CIVILE ='MLE' and  SEX='F')),

   constraint PK_PERSONNEL primary key (ID_PERSONNEL),

   constraint FK_PERSONNEL_FONCTION foreign key (ID_FONCTION)
      references FONCTION (ID_FONCTION) on delete restrict on update restrict,

   constraint FK_PERSONNEL_SALAIRE foreign key (ID_SALAIRE)
      references SALAIRE (ID_SALAIRE) on delete restrict on update restrict


)ENGINE=InnoDB;

/*==============================================================*/
/* Table : DOCUMENTATION                                        */
/*==============================================================*/
create table DOCUMENTATION
(
   ID_DOCUMENTATION     int not null,
   ID_PERSONNEL         char(4) not null,
   TITRE                char(100) not null,
   RESUMEDOC            char(100) not null,
   DATEDIFFUSION        date not null,

   constraint PK_DOCUMENTATION primary key (ID_DOCUMENTATION),

   constraint FK_DOCUMENTATION foreign key (ID_PERSONNEL)
      references PERSONNEL (ID_PERSONNEL) on delete restrict on update restrict
)ENGINE=InnoDB;



/*==============================================================*/
/* Table : PROJET                                               */
/*==============================================================*/
create table PROJET
(
   ID_CODEPROJET        numeric(4,0) not null,
   ID_DOCUMENTATION     int not null,
   NOMPROJET            char(50) not null,
   LIBELLECOURT         char(10) not null,
   LIBELLELONG          char(50) not null,
   DATEPREVUESDEBUT     date not null,
   DATEPREVUESFIN       date not null,
   DATEREELLESDEBUT     date,
   DATEREELLESFIN       date,
   CHARGEGLOBALEESTIMEE numeric(8,0) not null,
   NBCOLLABORATEURMAX   numeric(8,0) not null,
   REMARQUEESTIMATION   char(100) not null,

   constraint PK_PROJET primary key (ID_CODEPROJET),

   constraint FK_PROJET_DOCUMENTATION foreign key (ID_DOCUMENTATION)
      references DOCUMENTATION (ID_DOCUMENTATION) on delete restrict on update restrict
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : PROJET_CYCLE                                         */
/*==============================================================*/
create table PROJET_CYCLE
(
   ID_CYCLE             int not null,
   ID_CODEPROJET        numeric(4,0) not null,

   constraint PK_PROJET_CYCLE primary key (ID_CYCLE, ID_CODEPROJET),

   constraint FK_PROJET_CYCLE foreign key (ID_CYCLE)
         references CYCLE_VIE (ID_CYCLE) on delete restrict on update restrict,

   constraint FK_PROJET_CYCLE2 foreign key (ID_CODEPROJET)
         references PROJET (ID_CODEPROJET) on delete restrict on update restrict
)ENGINE=InnoDB;


/*==============================================================*/
/* Table : PROCESSUS
/*==============================================================*/
CREATE TABLE PROCESSUS (
    ID_PROCESSUS INT NOT NULL,
    PROCESSUS CHAR(50) NOT NULL,

   constraint PK_PROCESSUS PRIMARY KEY (ID_PROCESSUS)
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : CONTRAT                                              */
/*==============================================================*/
create table CONTRAT
(
   ID_CONTRAT           int not null,
   ID_PERSONNEL         char(4) not null,
   CONTRAT               ENUM('CDD', 'CDI', 'STA')  not null,
   DATEEMBAUCHE         date not null,
   DATEFIN              date,

   constraint PK_CONTRAT primary key (ID_CONTRAT),

   constraint FK_PER_CONTRAT foreign key (ID_PERSONNEL)
      references PERSONNEL (ID_PERSONNEL) on delete restrict on update restrict
)ENGINE=InnoDB;





/*==============================================================*/
/* Table : ETAPE                                                */
/*==============================================================*/
create table ETAPE
(
   ID_NUMLOT               numeric(6,0) not null,
   ID_PROCESSUS            int not null,
   ID_CODEPROJET           numeric(4,0) not null,
   CHARGERREELLEPRODUCTION int,
   CHARGEVALIDATION        int,
   CHARGEINITESTIMEE       time not null,
   EXPERIENCE              char(100) not null,

   primary key (ID_NUMLOT),

      constraint FK_ETAPE_PROCES foreign key (ID_PROCESSUS)
         references PROCESSUS (ID_PROCESSUS) on delete restrict on update restrict,

      constraint FK_ETAPE_PROJET foreign key (ID_CODEPROJET)
         references PROJET (ID_CODEPROJET) on delete restrict on update restrict

)ENGINE=InnoDB;

/*==============================================================*/
/* Table : INTERVENTION                                         */
/*==============================================================*/
create table INTERVENTION
(
   ID_INTERVENTION      int not null,
   ID_PERSONNEL         char(4) not null,
   ID_NUMLOT            numeric(6,0) not null,
   ID_FONCTION          int,
   INTITULE             char(100) not null,
   DATE                 date not null,
   DUREE                numeric(8,0) not null,

   primary key (ID_INTERVENTION),

   constraint FK_PERSONNEL_INTERVENTION foreign key (ID_PERSONNEL)
      references PERSONNEL (ID_PERSONNEL ) on delete restrict on update restrict,

   constraint FK_INTER_ETAPE foreign key (ID_NUMLOT)
      references ETAPE (ID_NUMLOT) on delete restrict on update restrict,

   constraint FK_FONCTION_INTER foreign key (ID_FONCTION)
      references FONCTION (ID_FONCTION) on delete restrict on update restrict

)ENGINE=InnoDB;

/*==============================================================*/
/* Table : COLLABORATEUR_CLIENT                                 */
/*==============================================================*/
create table COLLABORATEUR_CLIENT
(
   ID_COLLABORATEUR     int not null,
   ID_CLIENT            numeric(4) not null,
   ID_INTERVENTION      int not null,
   ID_FONCTION          int not null,
   NOM                  char(20) not null,
   COMMENTAIRESPECIFIQUE char(100),
   COMMENTAIREPROJET    char(100),
   ADRESSEEMAIL         char(40),

      primary key (ID_COLLABORATEUR),
   
      constraint FK_CLIENT_COLLABORATEUR foreign key (ID_CLIENT) 
            references CLIENT (ID_CLIENT) on delete restrict on update restrict,

      constraint FK_COLLABORATEUR_INTER foreign key (ID_INTERVENTION) 
            references INTERVENTION (ID_INTERVENTION) on delete restrict on update restrict,

      constraint FK_COLLABO_FONCTION foreign key (ID_FONCTION) 
            references FONCTION (ID_FONCTION) on delete restrict on update restrict
)ENGINE=InnoDB;

/*==============================================================*/
/* Table : COMMENTAIRE                                          */
/*==============================================================*/
create table COMMENTAIRE
(
   ID_COMMENTAIRE       int not null,
   ID_CODEPROJET        numeric(4,0),
   ID_INTERVENTION      int,
   ID_PERSONNEL         char(4) not null,
   ID_NUMLOT            numeric(6,0),
   COMMENTAIRE          char(100) not null,

      primary key (ID_COMMENTAIRE),

      
      constraint FK_COMMENTAIRE_PROJET foreign key (ID_CODEPROJET)
            references PROJET (ID_CODEPROJET) on delete restrict on update restrict,

      constraint FK_COMMENTAIRE_INTER foreign key (ID_INTERVENTION)
            references INTERVENTION (ID_INTERVENTION) on delete restrict on update restrict,

      constraint FK_COMMENTAIRE_PERS foreign key (ID_PERSONNEL)
            references PERSONNEL (ID_PERSONNEL) on delete restrict on update restrict,

      constraint FK_COMMENTAIRE_ETAPE foreign key (ID_NUMLOT)
            references ETAPE (ID_NUMLOT) on delete restrict on update restrict
)ENGINE=InnoDB;
/*==============================================================*/
/* Table : TECHNOLOGIE                                          */
/*==============================================================*/
create table TECHNOLOGIE
(
   ID_TECHNOLOGIE       int not null,
   ID_INTERVENTION      int not null,
   LABELTECHNOLOGIE     char(100) not null,

   primary key (ID_TECHNOLOGIE),

   constraint FK_PROJET_TECHNOLOGIE foreign key (ID_INTERVENTION)
      references INTERVENTION (ID_INTERVENTION) on delete restrict on update restrict
)ENGINE=InnoDB;


