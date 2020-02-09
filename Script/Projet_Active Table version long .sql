
/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  06/02/2020 13:47:13 
/* By : Ghalem Maxime                     */
/*==============================================================*/

-- creation de la base de donnée si elle n'existe pas.
-- CREATE SCHEMA if not exists `active` ;
-- drop SCHEMA active;

-- pour contourner le blocage de la clef étrangère 0 ouvrir 1 fermé
SET foreign_key_checks = 0;

drop table if exists TYPE_CONTRAT;
drop table if exists ETAT_CIVILE;
drop table if exists STATUT;
drop table if exists DOMAIN;
drop table if exists NATURE;
drop table if exists ACTIVITE;
drop table if exists PROCESSUS;
drop table if exists CYCLE_VIE;
drop table if exists SECTEUR;
drop table if exists FONCTION;
drop table if exists CLIENT;
drop table if exists CL_ACTIVITE;
drop table if exists PERSONNEL;
drop table if exists PER_CONTRAT;
drop table if exists PERMISSION;
drop table if exists FONCTION_PERMISSION;
drop Table if exists PER_FONCTION;
drop Table if exists DOCUMENTATION;
drop Table if exists PROJET;
drop Table if exists ETAPE;
drop Table if exists INTERVENTION;
drop Table if exists COLLABORATEUR_CL;
drop Table if exists PER_INTERVENTION;
drop Table if exists COMMENTAIRE;
drop Table if exists TECHNOLOGIE;
drop Table if exists PER_TECHNO;
drop Table if exists PRO_CYCLE;
drop Table if exists PRO_DOCUMENTATION;
drop Table if exists SALAIRE;

SET foreign_key_checks = 1;

/*==============================================================*/
/* Table : TYPE_CONTRAT                                         */

create table TYPE_CONTRAT
(
   ID_TYPE              int not null,
   TYPE                 char(3) not null,

   primary key (ID_TYPE)

);

/*==============================================================*/
/* Table : ETAT_CIVILE                                          */

create table ETAT_CIVILE
(
   ID_CIVIL             int not null,
   TYPE_CIVILE          char(3) not null,
   SEX                  char(1) not null,

   primary key (ID_CIVIL)

);

/*==============================================================*/
/* Table : STATUT                                               */

create table STATUT
(
   ID_STCOLLABRATEUR    int not null,
   TYPE_COLLABORATION   varchar(7) not null,

   primary key (ID_STCOLLABRATEUR)

);

/*==============================================================*/
/* Table : PERMISSION                                           */

create table PERMISSION
(
   ID_permission        int not null,
   KEYPERMISSION        varchar(50) not null,
   PERMDESCRIPTION      text not null,

   primary key (ID_PERMISSION)

);

/*==============================================================*/
/* Table : DOMAIN                                               */
create table DOMAIN
(
   ID_DOMAIN            char(1) not null,
   DOMAIN          char(6) not null,

   primary key (ID_DOMAIN)
);


/*==============================================================*/
/* Table : NATURE                                               */

create table NATURE
(
   ID_NATURE            int not null,
   NATURE               char(100) not null,

   primary key (ID_NATURE)
);

/*==============================================================*/
/* Table : ACTIVITE                                             */

create table ACTIVITE
(
   ID_ACTIVITE          int not null,
   ACTIVITE             char(100) not null,

   primary key (ID_ACTIVITE)

);

/*==============================================================*/
/* Table : PROCESSUS                                            */

create table PROCESSUS
(
   ID_PROCESSUS         int not null,
   PROCESSUS        char(50) not null,

   primary key (ID_PROCESSUS)
);

/*==============================================================*/
/* Table : CYCLE_VIE                                            */

create table CYCLE_VIE
(
   ID_CYCLE             int not null,
   CYCLE                char(10) not null,

   primary key (ID_CYCLE)

);

/*==============================================================*/
/* Table : SECTEUR                                              */

create table SECTEUR
(
   ID_SECTEUR           int not null,
   SECTEUR              char(25) not null,

   primary key (ID_SECTEUR)

);

/*==============================================================*/
/* Table : FONCTION                                             */

create table FONCTION
(
   ID_FONCTION          int not null,
   FONCTION        char(15) not null,

   primary key (ID_FONCTION)

);

/*==============================================================*/
/* Table : CLIENT                                               */

create table CLIENT
(
   ID_CLIENT            numeric(4,0) not null,
   ID_DOMAIN            char(1) not null,
   ID_NATURE            int not null,
   RAISONSOCIALE        char(100) not null,
   ADRESSE              char(100) not null,
   TELEPHONECLIENT      char(10) not null,
   CHIFFREAFFAIRE       numeric(10,2) not null,
   EFFECTIFS            int not null,
   COMMENTAIREGENERAUX  char(100) not null,

   primary key (ID_CLIENT),

   CONSTRAINT FK_DOMAIN_CLIENT FOREIGN KEY(ID_DOMAIN) REFERENCES DOMAIN(ID_DOMAIN),
   CONSTRAINT FK_NATURE_CLIENT FOREIGN KEY(ID_NATURE) REFERENCES NATURE(ID_NATURE)

);

/*==============================================================*/
/* Table : CL_ACTIVITE                                          */

create table CL_ACTIVITE
(
   ID_ACTIVITE          int not null,
   ID_CLIENT            numeric(4,0) not null,

   primary key (ID_ACTIVITE, ID_CLIENT),

   CONSTRAINT FK_ACTIVITE_CL_ACTIVITE FOREIGN KEY(ID_ACTIVITE) REFERENCES ACTIVITE(ID_ACTIVITE),
   CONSTRAINT FK_CLIENT_CL_ACTIVITE FOREIGN KEY(ID_CLIENT) REFERENCES CLIENT(ID_CLIENT)

); 

/*==============================================================*/
/* Table : PERSONNEL                                            */

create table PERSONNEL
(
   ID_PERSONNEL       char(4) not null,
   ID_STCOLLABRATEUR    int not null,
   ID_CIVIL             int not null,
   NOMCONTACT           char(20) not null,
   PRENOM               char(20) not null,
   ADRESSE1             char(25) not null,
   ADRESSE2             char(25),
   VILLE                char(10) not null,
   CODEPOSTALE          char(5) not null,
   TELEPHONEPERSONNE    char(10) not null,
   MATRICULE            char(4) not null,

   primary key (ID_PERSONNEL),

   CONSTRAINT FK_STCOLLABRATEUR_PERSONNEL FOREIGN KEY(ID_STCOLLABRATEUR) REFERENCES STATUT(ID_STCOLLABRATEUR) ,
   CONSTRAINT FK_CIVIL_PERSONNEL FOREIGN KEY(ID_CIVIL) REFERENCES ETAT_CIVILE(ID_CIVIL) 

);

/*==============================================================*/
/* Table : PER_CONTRAT                                          */

create table PER_CONTRAT
(
   ID_PERSONNEL         char(4) not null,
   ID_CONTRAT           int not null,
   DEBUT                date not null,
   FIN                  date,

   primary key (ID_PERSONNEL, ID_CONTRAT),

   CONSTRAINT FK_PERSONNEL_PER_CONTRAT FOREIGN KEY(ID_PERSONNEL) REFERENCES PERSONNEL(ID_PERSONNEL),
   CONSTRAINT FK_CONTRAT_PER_CONTRAT FOREIGN KEY(ID_CONTRAT) REFERENCES TYPE_CONTRAT(ID_TYPE)

);

/*==============================================================*/
/* Table : FONCTION_PERMISSION                                  */

create table FONCTION_PERMISSION
(
   ID_PERMISSION        int not null,
   ID_FONCTION          int not null,

   primary key (ID_PERMISSION, ID_FONCTION),

   CONSTRAINT FK_PERMISSION8_FONCTION_PERMISSION FOREIGN KEY(ID_PERMISSION) REFERENCES PERMISSION(ID_PERMISSION),
   CONSTRAINT FK_FONCTION_FONCTION_PERMISSION FOREIGN KEY(ID_FONCTION) REFERENCES FONCTION(ID_FONCTION)

);

/*==============================================================*/
/* Table : PER_FONCTION                                         */

create table PER_FONCTION
(
   ID_PERSONNEL          char(4) not null,
   ID_FONCTION          int not null,
   DATEFONCTION         date not null,

   primary key (ID_PERSONNEL, ID_FONCTION),

   CONSTRAINT KF_PERSONNEL_PER_FONCTION FOREIGN KEY(ID_PERSONNEL) REFERENCES PERSONNEL(ID_PERSONNEL),
   CONSTRAINT KF_FONCTION_PER_FONCTION FOREIGN KEY(ID_FONCTION) REFERENCES FONCTION(ID_FONCTION)

);

/*==============================================================*/
/* Table : DOCUMENTATION                                        */

create table DOCUMENTATION
(
   ID_DOCUMENTATION     int not null,
   ID_PERSONNEL         char(4) not null,
   TITRE                char(100) not null,
   RESUMEDOC            char(100) not null,
   DATEDIFFUSION        date not null,

   primary key (ID_DOCUMENTATION),
   CONSTRAINT ID_PERSONNEL_DOCUMENTATION FOREIGN KEY(ID_PERSONNEL) REFERENCES PERSONNEL(ID_PERSONNEL)
);

/*==============================================================*/
/* Table : PROJET                                               */

create table PROJET
(
   ID_CODEPROJET              numeric(4,0) not null,
   ID_SECTEUR                 int not null,
   ID_PERSONNEL               char(4) not null,
   NOMPROJET                  char(50) not null,
   LIBELLECOURT               char(10) not null,
   LIBELLELONG                char(50) not null,
   DATEPREVUESDEBUT           date not null,
   DATEPREVUESFIN             date not null,
   DATEREELLESDEBUT           date,
   DATEREELLESFIN             date,
   CHARGEGLOBALEESTIMEE       numeric(8,0) not null,
   INFOTECHPROJET             char(100) not null,
   NBCOLLABORATEURMAX         numeric(8,0) not null,
   REMARQUEESTIMATION         char(100) not null,
   COMMENTAIRE               text not null,

   primary key (ID_CODEPROJET),

   CONSTRAINT ID_SECTEUR_PROJET FOREIGN KEY(ID_SECTEUR) REFERENCES SECTEUR(ID_SECTEUR),
   CONSTRAINT ID_PERSONNEL_PROJET FOREIGN KEY(ID_PERSONNEL) REFERENCES PERSONNEL(ID_PERSONNEL)

);

/*==============================================================*/
/* Table : ETAPE                                                */

create table ETAPE
(
   ID_NUMLOT            numeric(6,0) not null,
   ID_PROCESSUS         int not null,
   ID_CODEPROJET        numeric(4,0) not null,
   CHARGEPRODUCTION     int,
   CHARGEVALIDATION     int,
   CHARGEINITESTIMEE    time not null,
   EXPERIENCE           char(100) not null,

   primary key (ID_NUMLOT),

   CONSTRAINT ID_PROCESSUS_ETAPE FOREIGN key(ID_PROCESSUS) REFERENCES PROCESSUS(ID_PROCESSUS),
   CONSTRAINT ID_CODEPROJET FOREIGN key(ID_CODEPROJET) REFERENCES PROJET(ID_CODEPROJET)

);

/*==============================================================*/
/* Table : INTERVENTION                                         */

create table INTERVENTION
(
   ID_INTERVENTION      int not null,
   ID_NUMLOT            numeric(6,0) not null,
   TYPEINTERVENTION     char(100) not null,
   DATEINTERVENTION     date not null,
   DUREE                numeric(8,0) not null,

   primary key (ID_INTERVENTION),

    CONSTRAINT  ID_NUMLOT_INTERVENTION FOREIGN key(ID_NUMLOT) REFERENCES ETAPE(ID_NUMLOT)

);

/*==============================================================*/
/* Table : COLLABORATEUR_CL                                     */

create table COLLABORATEUR_CL
(
   NOM                        char(20) not null,
   ID_FONCTION                int not null,
   ID_CLIENT                  numeric(4,0) not null,
   ID_INTERVENTION            int not null,
   COMMENTAIRESPECIFIQUE      char(100) not null,
   ID_COLLABORATEUR           int not null,

   primary key (NOM),

   CONSTRAINT ID_FONCTION_COLLABORATEUR_CL FOREIGN key(ID_FONCTION) REFERENCES FONCTION(ID_FONCTION),
   CONSTRAINT ID_CLIENT_COLLABORATEUR_CL FOREIGN key(ID_CLIENT) REFERENCES CLIENT(ID_CLIENT),
   CONSTRAINT ID_INTERVENTION_COLLABORATEUR_CL FOREIGN key(ID_INTERVENTION) REFERENCES INTERVENTION(ID_INTERVENTION)

);

/*==============================================================*/
/* Table : PER_INTERVENTION                                     */

create table PER_INTERVENTION
(
   ID_INTERVENTION      int not null,
   ID_PERSONNEL       char(4) not null,

   primary key (ID_INTERVENTION, ID_PERSONNEL),
   CONSTRAINT ID_PERSONNEL_PER_INTERVENTION FOREIGN KEY(ID_PERSONNEL) REFERENCES PERSONNEL(ID_PERSONNEL)

);

/*==============================================================*/
/* Table : COMMENTAIRE                                          */

create table COMMENTAIRE
(
   ID_COMMENTAIRE       int not null,
   ID_NUMLOT            numeric(6,0) not null,
   ID_CODEPROJET        numeric(4,0) not null,
   ID_INTERVENTION      int not null,
   ID_PERSONNEL         char(4) not null,
   COMMENTAIRE          char(100) not null,

   primary key (ID_COMMENTAIRE),

   CONSTRAINT ID_NUMLOT_COMMENTAIRE FOREIGN KEY(ID_NUMLOT) REFERENCES ETAPE(ID_NUMLOT),
   CONSTRAINT ID_CODEPROJET_COMMENTAIRE FOREIGN KEY(ID_CODEPROJET) REFERENCES PROJET(ID_CODEPROJET),
   CONSTRAINT ID_INTERVENTION_COMMENTAIRE FOREIGN KEY(ID_INTERVENTION) REFERENCES INTERVENTION(ID_INTERVENTION),
   CONSTRAINT ID_PERSONNEL_COMMENTAIRE FOREIGN KEY(ID_PERSONNEL) REFERENCES PERSONNEL(ID_PERSONNEL)
);

/*==============================================================*/
/* Table : TECHNOLOGIE                                          */

create table TECHNOLOGIE
(
   ID_TECHNOLOGIE       int not null,
   ID_NUMLOT            numeric(6,0) not null,
   TYPETECHNOLOGIE      char(100) not null,

   primary key (ID_TECHNOLOGIE),

   CONSTRAINT ID_NUMLOT_TECHNOLOGIE FOREIGN KEY(ID_NUMLOT) REFERENCES INTERVENTION(ID_NUMLOT)

);

/*==============================================================*/
/* Table : PER_TECHNO                                           */

create table PER_TECHNO
(
   ID_TECHNOLOGIE       int not null,
   ID_PERSONNEL       char(4) not null,

   primary key (ID_TECHNOLOGIE, ID_PERSONNEL),

   CONSTRAINT ID_TECHNOLOGIE_PER_TECHNO FOREIGN KEY(ID_TECHNOLOGIE) REFERENCES TECHNOLOGIE(ID_TECHNOLOGIE),
   CONSTRAINT ID_PERSONNEL_PER_TECHNO FOREIGN KEY(ID_PERSONNEL) REFERENCES PERSONNEL(ID_PERSONNEL)

);

/*==============================================================*/
/* Table : PRO_CYCLE                                            */

create table PRO_CYCLE
(
   ID_CYCLE             int not null,
   ID_CODEPROJET        numeric(4,0) not null,

   primary key (ID_CYCLE, ID_CODEPROJET),

   CONSTRAINT ID_CYCLE_PRO_CYCLE FOREIGN key(ID_CYCLE) REFERENCES CYCLE_VIE(ID_CYCLE),
   CONSTRAINT ID_CODEPROJET_PRO_CYCLE FOREIGN key(ID_CODEPROJET) REFERENCES PROJET(ID_CODEPROJET)

);

/*==============================================================*/
/* Table : PRO_DOCUMENTATION                                    */

create table PRO_DOCUMENTATION
(
   ID_CODEPROJET        numeric(4,0) not null,
   ID_DOCUMENTATION     int not null,

   primary key (ID_CODEPROJET, ID_DOCUMENTATION),

   CONSTRAINT ID_CODEPROJET_PRO_DOCUMENTATION FOREIGN key(ID_CODEPROJET) REFERENCES PROJET(ID_CODEPROJET),
   CONSTRAINT ID_DOCUMENTATION_PRO_DOCUMENTATION FOREIGN key(ID_DOCUMENTATION) REFERENCES DOCUMENTATION(ID_DOCUMENTATION)

);


/*==============================================================*/
/* Table : SALAIRE                                              */
/*==============================================================*/
create table SALAIRE
(
   ID_SALAIRE           int not null,
   ID_PERSONNEL         char(4),
   SALAIRE              numeric(2,2) not null,
   DATESALAIRE          date not null,

   primary key (ID_SALAIRE),

   CONSTRAINT ID_PERSONNEL_SALAIRE FOREIGN key(ID_PERSONNEL) REFERENCES PERSONNEL(ID_PERSONNEL)
   

);