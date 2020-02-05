/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  05/02/2020 16:14:26                      */
/*==============================================================*/


drop table if exists ACTIVITE;

drop table if exists ASSOCIATION_25;

drop table if exists CLIENT;

drop table if exists CL_ACTIVITE;

drop table if exists COLLABORATEUR_CL;

drop table if exists COMMENTAIRE;

drop table if exists CYCLE_VIE;

drop table if exists DOCUMENTATION;

drop table if exists DOMAIN;

drop table if exists ETAPE;

drop table if exists ETAT_CIVILE;

drop table if exists FONCTION;

drop table if exists INTERVENTION;

drop table if exists NATURE;

drop table if exists PERSONNEL;

drop table if exists PER_CONTRAT;

drop table if exists PER_FONCTION;

drop table if exists PER_TECHNO;

drop table if exists PROCESSUS;

drop table if exists PROJET;

drop table if exists PRO_CYCLE;

drop table if exists PRO_DOCUMENTATION;

drop table if exists SALAIRE;

drop table if exists SECTEUR;

drop table if exists STATUT;

drop table if exists TECHNOLOGIE;

drop table if exists TYPE_CONTRAT;

/*==============================================================*/
/* Table : ACTIVITE                                             */
/*==============================================================*/
create table ACTIVITE
(
   ID_ACTIVITE          int not null,
   ACTIVITE             char(100) not null,
   primary key (ID_ACTIVITE)
);

/*==============================================================*/
/* Table : ASSOCIATION_25                                       */
/*==============================================================*/
create table ASSOCIATION_25
(
   ID_INTERVENTION      int not null,
   TOUT_LE_MONDE_       char(4) not null,
   primary key (ID_INTERVENTION, TOUT_LE_MONDE_)
);

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
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
   primary key (ID_CLIENT)
);

/*==============================================================*/
/* Table : CL_ACTIVITE                                          */
/*==============================================================*/
create table CL_ACTIVITE
(
   ID_ACTIVITE          int not null,
   ID_CLIENT            numeric(4,0) not null,
   primary key (ID_ACTIVITE, ID_CLIENT)
);

/*==============================================================*/
/* Table : COLLABORATEUR_CL                                     */
/*==============================================================*/
create table COLLABORATEUR_CL
(
   NOM                  char(20) not null,
   ID_                  int not null,
   ID_CLIENT            numeric(4,0) not null,
   ID_INTERVENTION      int not null,
   COMMENTAIRESPECIFIQUE char(100) not null,
   ID_COLLABORATEUR     int not null,
   primary key (NOM)
);

/*==============================================================*/
/* Table : COMMENTAIRE                                          */
/*==============================================================*/
create table COMMENTAIRE
(
   ID_COMMENTAIRE       int not null,
   ID_NUMLOT            numeric(6,0) not null,
   ID_CODEPROJET        numeric(4,0) not null,
   ID_INTERVENTION      int not null,
   TOUT_LE_MONDE_       char(4) not null,
   COMMENTAIRE          char(100) not null,
   primary key (ID_COMMENTAIRE)
);

/*==============================================================*/
/* Table : CYCLE_VIE                                            */
/*==============================================================*/
create table CYCLE_VIE
(
   ID_CYCLE             int not null,
   CYCLE                char(10) not null,
   primary key (ID_CYCLE)
);

/*==============================================================*/
/* Table : DOCUMENTATION                                        */
/*==============================================================*/
create table DOCUMENTATION
(
   ID_DOCUMENTATION     int not null,
   TOUT_LE_MONDE_       char(4) not null,
   TITRE                char(100) not null,
   RESUME               char(100) not null,
   DATEDIFFUSION        date not null,
   primary key (ID_DOCUMENTATION)
);

/*==============================================================*/
/* Table : DOMAIN                                               */
/*==============================================================*/
create table DOMAIN
(
   ID_DOMAIN            char(1) not null,
   TYPE_DOMAIN          char(6) not null,
   primary key (ID_DOMAIN)
);

/*==============================================================*/
/* Table : ETAPE                                                */
/*==============================================================*/
create table ETAPE
(
   ID_NUMLOT            numeric(6,0) not null,
   ID_PROCESSUS         int not null,
   ID_CODEPROJET        numeric(4,0) not null,
   CHARGEPRODUCTION     int,
   CHARGEVALIDATION     int,
   CHARGEINITESTIMEE    time not null,
   EXPERIENCE           char(100) not null,
   primary key (ID_NUMLOT)
);

/*==============================================================*/
/* Table : ETAT_CIVILE                                          */
/*==============================================================*/
create table ETAT_CIVILE
(
   ID_CIVIL             int not null,
   TYPE_CIVILE          char(3) not null,
   SEX                  char(1) not null,
   primary key (ID_CIVIL)
);

/*==============================================================*/
/* Table : FONCTION                                             */
/*==============================================================*/
create table FONCTION
(
   ID_                  int not null,
   TYPE_FONCTION        char(15) not null,
   primary key (ID_)
);

/*==============================================================*/
/* Table : INTERVENTION                                         */
/*==============================================================*/
create table INTERVENTION
(
   ID_INTERVENTION      int not null,
   ID_NUMLOT            numeric(6,0) not null,
   TYPEINTERVENTION     char(100) not null,
   DATEINTERVENTION     date not null,
   DUREE                numeric(8,0) not null,
   primary key (ID_INTERVENTION)
);

/*==============================================================*/
/* Table : NATURE                                               */
/*==============================================================*/
create table NATURE
(
   ID_NATURE            int not null,
   NATURE               char(100) not null,
   primary key (ID_NATURE)
);

/*==============================================================*/
/* Table : PERSONNEL                                            */
/*==============================================================*/
create table PERSONNEL
(
   TOUT_LE_MONDE_       char(4) not null,
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
   primary key (TOUT_LE_MONDE_)
);

/*==============================================================*/
/* Table : PER_CONTRAT                                          */
/*==============================================================*/
create table PER_CONTRAT
(
   TOUT_LE_MONDE_       char(4) not null,
   ID_TYPE              int not null,
   DEBUT                date not null,
   FIN                  date,
   primary key (TOUT_LE_MONDE_, ID_TYPE)
);

/*==============================================================*/
/* Table : PER_FONCTION                                         */
/*==============================================================*/
create table PER_FONCTION
(
   TOUT_LE_MONDE_       char(4) not null,
   ID_                  int not null,
   DATEFONCTION         date not null,
   primary key (TOUT_LE_MONDE_, ID_)
);

/*==============================================================*/
/* Table : PER_TECHNO                                           */
/*==============================================================*/
create table PER_TECHNO
(
   ID_TECHNOLOGIE       int not null,
   TOUT_LE_MONDE_       char(4) not null,
   primary key (ID_TECHNOLOGIE, TOUT_LE_MONDE_)
);

/*==============================================================*/
/* Table : PROCESSUS                                            */
/*==============================================================*/
create table PROCESSUS
(
   ID_PROCESSUS         int not null,
   TYPEPROCESSUS        char(50) not null,
   primary key (ID_PROCESSUS)
);

/*==============================================================*/
/* Table : PROJET                                               */
/*==============================================================*/
create table PROJET
(
   ID_CODEPROJET        numeric(4,0) not null,
   ID_SECTEUR           int not null,
   TOUT_LE_MONDE_       char(4) not null,
   NOMPROJET            char(50) not null,
   LIBELLECOURT         char(10) not null,
   LIBELLELONG          char(50) not null,
   DATEPREVUESDEBUT     date not null,
   DATEPREVUESFIN       date not null,
   DATEREELLESDEBUT     date,
   DATEREELLESFIN       date,
   CHARGEGLOBALEESTIMEE numeric(8,0) not null,
   INFOTECHPROJET       char(100) not null,
   NBCOLLABORATEURMAX   numeric(8,0) not null,
   REMARQUEESTIMATION   char(100) not null,
   COMMENTAIRE_         text not null,
   primary key (ID_CODEPROJET)
);

/*==============================================================*/
/* Table : PRO_CYCLE                                            */
/*==============================================================*/
create table PRO_CYCLE
(
   ID_CYCLE             int not null,
   ID_CODEPROJET        numeric(4,0) not null,
   primary key (ID_CYCLE, ID_CODEPROJET)
);

/*==============================================================*/
/* Table : PRO_DOCUMENTATION                                    */
/*==============================================================*/
create table PRO_DOCUMENTATION
(
   ID_CODEPROJET        numeric(4,0) not null,
   ID_DOCUMENTATION     int not null,
   primary key (ID_CODEPROJET, ID_DOCUMENTATION)
);

/*==============================================================*/
/* Table : SALAIRE                                              */
/*==============================================================*/
create table SALAIRE
(
   ID_SALAIRE           int not null,
   TOUT_LE_MONDE_       char(4),
   SALAIRE              numeric(2,2) not null,
   DATESALAIRE          date not null,
   primary key (ID_SALAIRE)
);

/*==============================================================*/
/* Table : SECTEUR                                              */
/*==============================================================*/
create table SECTEUR
(
   ID_SECTEUR           int not null,
   SECTEUR              char(25) not null,
   primary key (ID_SECTEUR)
);

/*==============================================================*/
/* Table : STATUT                                               */
/*==============================================================*/
create table STATUT
(
   ID_STCOLLABRATEUR    int not null,
   TYPE_COLLABORATION   varchar(7) not null,
   primary key (ID_STCOLLABRATEUR)
);

/*==============================================================*/
/* Table : TECHNOLOGIE                                          */
/*==============================================================*/
create table TECHNOLOGIE
(
   ID_TECHNOLOGIE       int not null,
   ID_NUMLOT            numeric(6,0) not null,
   TYPETECHNOLOGIE      char(100) not null,
   primary key (ID_TECHNOLOGIE)
);

/*==============================================================*/
/* Table : TYPE_CONTRAT                                         */
/*==============================================================*/
create table TYPE_CONTRAT
(
   ID_TYPE              int not null,
   TYPE                 char(3) not null,
   primary key (ID_TYPE)
);

alter table ASSOCIATION_25 add constraint FK_ASSOCIATION_25 foreign key (ID_INTERVENTION)
      references INTERVENTION (ID_INTERVENTION) on delete restrict on update restrict;

alter table ASSOCIATION_25 add constraint FK_ASSOCIATION_29 foreign key (TOUT_LE_MONDE_)
      references PERSONNEL (TOUT_LE_MONDE_) on delete restrict on update restrict;

alter table CLIENT add constraint FK_CL_DOMAIN foreign key (ID_DOMAIN)
      references DOMAIN (ID_DOMAIN) on delete restrict on update restrict;

alter table CLIENT add constraint FK_CL_NATURE foreign key (ID_NATURE)
      references NATURE (ID_NATURE) on delete restrict on update restrict;

alter table CL_ACTIVITE add constraint FK_CL_ACTIVITE foreign key (ID_ACTIVITE)
      references ACTIVITE (ID_ACTIVITE) on delete restrict on update restrict;

alter table CL_ACTIVITE add constraint FK_CL_ACTIVITE2 foreign key (ID_CLIENT)
      references CLIENT (ID_CLIENT) on delete restrict on update restrict;

alter table COLLABORATEUR_CL add constraint FK_ASSOCIATION_21 foreign key (ID_CLIENT)
      references CLIENT (ID_CLIENT) on delete restrict on update restrict;

alter table COLLABORATEUR_CL add constraint FK_ASSOCIATION_22 foreign key (ID_)
      references FONCTION (ID_) on delete restrict on update restrict;

alter table COLLABORATEUR_CL add constraint FK_ASSOCIATION_23 foreign key (ID_INTERVENTION)
      references INTERVENTION (ID_INTERVENTION) on delete restrict on update restrict;

alter table COMMENTAIRE add constraint FK_ASSOCIATION_24 foreign key (ID_CODEPROJET)
      references PROJET (ID_CODEPROJET) on delete restrict on update restrict;

alter table COMMENTAIRE add constraint FK_ASSOCIATION_26 foreign key (TOUT_LE_MONDE_)
      references PERSONNEL (TOUT_LE_MONDE_) on delete restrict on update restrict;

alter table COMMENTAIRE add constraint FK_ASSOCIATION_27 foreign key (ID_INTERVENTION)
      references INTERVENTION (ID_INTERVENTION) on delete restrict on update restrict;

alter table COMMENTAIRE add constraint FK_ASSOCIATION_28 foreign key (ID_NUMLOT)
      references ETAPE (ID_NUMLOT) on delete restrict on update restrict;

alter table DOCUMENTATION add constraint FK_PER_DOCMENTATION foreign key (TOUT_LE_MONDE_)
      references PERSONNEL (TOUT_LE_MONDE_) on delete restrict on update restrict;

alter table ETAPE add constraint FK_ETAPE_PROCESSUS foreign key (ID_PROCESSUS)
      references PROCESSUS (ID_PROCESSUS) on delete restrict on update restrict;

alter table ETAPE add constraint FK_PRO_ETAPE foreign key (ID_CODEPROJET)
      references PROJET (ID_CODEPROJET) on delete restrict on update restrict;

alter table INTERVENTION add constraint FK_INTER_ETAPE foreign key (ID_NUMLOT)
      references ETAPE (ID_NUMLOT) on delete restrict on update restrict;

alter table PERSONNEL add constraint FK_PER_CIVIL foreign key (ID_CIVIL)
      references ETAT_CIVILE (ID_CIVIL) on delete restrict on update restrict;

alter table PERSONNEL add constraint FK_PER_STATUT foreign key (ID_STCOLLABRATEUR)
      references STATUT (ID_STCOLLABRATEUR) on delete restrict on update restrict;

alter table PER_CONTRAT add constraint FK_PER_CONTRAT foreign key (TOUT_LE_MONDE_)
      references PERSONNEL (TOUT_LE_MONDE_) on delete restrict on update restrict;

alter table PER_CONTRAT add constraint FK_PER_CONTRAT2 foreign key (ID_TYPE)
      references TYPE_CONTRAT (ID_TYPE) on delete restrict on update restrict;

alter table PER_FONCTION add constraint FK_PER_FONCTION foreign key (TOUT_LE_MONDE_)
      references PERSONNEL (TOUT_LE_MONDE_) on delete restrict on update restrict;

alter table PER_FONCTION add constraint FK_PER_FONCTION2 foreign key (ID_)
      references FONCTION (ID_) on delete restrict on update restrict;

alter table PER_TECHNO add constraint FK_PER_TECHNO foreign key (ID_TECHNOLOGIE)
      references TECHNOLOGIE (ID_TECHNOLOGIE) on delete restrict on update restrict;

alter table PER_TECHNO add constraint FK_PER_TECHNO2 foreign key (TOUT_LE_MONDE_)
      references PERSONNEL (TOUT_LE_MONDE_) on delete restrict on update restrict;

alter table PROJET add constraint FK_CHEF_PROJET foreign key (TOUT_LE_MONDE_)
      references PERSONNEL (TOUT_LE_MONDE_) on delete restrict on update restrict;

alter table PROJET add constraint FK_PRO_SECTEUR foreign key (ID_SECTEUR)
      references SECTEUR (ID_SECTEUR) on delete restrict on update restrict;

alter table PRO_CYCLE add constraint FK_PRO_CYCLE foreign key (ID_CYCLE)
      references CYCLE_VIE (ID_CYCLE) on delete restrict on update restrict;

alter table PRO_CYCLE add constraint FK_PRO_CYCLE2 foreign key (ID_CODEPROJET)
      references PROJET (ID_CODEPROJET) on delete restrict on update restrict;

alter table PRO_DOCUMENTATION add constraint FK_PRO_DOCUMENTATION foreign key (ID_CODEPROJET)
      references PROJET (ID_CODEPROJET) on delete restrict on update restrict;

alter table PRO_DOCUMENTATION add constraint FK_PRO_DOCUMENTATION2 foreign key (ID_DOCUMENTATION)
      references DOCUMENTATION (ID_DOCUMENTATION) on delete restrict on update restrict;

alter table SALAIRE add constraint FK_PER_SALAIRE_HISTORIQUE foreign key (TOUT_LE_MONDE_)
      references PERSONNEL (TOUT_LE_MONDE_) on delete restrict on update restrict;

alter table TECHNOLOGIE add constraint FK_ETAPE_TECNO foreign key (ID_NUMLOT)
      references ETAPE (ID_NUMLOT) on delete restrict on update restrict;

