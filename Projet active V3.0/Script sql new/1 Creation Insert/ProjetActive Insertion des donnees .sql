-- delete from client where ID_CLIENT = 1 and ID_CLIENT = 2;

-- voir le on delet cascade 

insert into PERMISSION (permission,`description`) values
                        ("CREATE", "création de fichier"),
                        ("READ", "lecture de fichier"),
                        ("UPDATE", "mise à jours de fichier"),
                        ("DELETE", "suppréssion de fichier");

insert into CYCLE_VIE (cycle) values
                        ("complet"),
                        ("étude"),
                        ("développement");

insert into FONCTION (ID_FONCTION, intituler ) values
                     (1, "Responsable de projet"),
                     (2, "Analyste responsable d’application"),
                     (3, "Développeur"),
                     (4, "Technicien support"),
                     (5, "Commercial"),
                     (6, "Technico-commercial"),
                     (7, "Secrétaire"),
                     (8, "responsable des études"),
                     (9, "secrétariat technique"),
                     (10, "chef de projet"),
                     (11, "responsable commercial"),
                     (12, "responsable d'étude");

insert into CLIENT ( raisonSociale ,adresse ,telephone ,chiffreAffaire ,effectifs ,commentGeneraux ,nature ,domain ,activite ) values 
					("clemessy colmar", "rue du machin", "0607982521", 5000000 , 2, "commentaire de l'afpa", "principale", "public", "formation"),
                    ("clemessy Mulhouse", "rue du bidule", "0607080910", 3000 , 100, "commentaire de clemessy", "secondaire", "privé", "formation");
                    

insert into PERMISSION_FONCTION (ID_FONCTION, ID_PERMISSION) values
                                (1 , 1),
                                (1 , 2),
                                (1 , 3),
                                (1 , 4),
                                (6 , 1),
                                (6 , 2),
                                (6 , 3),
                                (6 , 4);

insert into PERSONNEL ( ID_PERSONNEL , ID_FONCTION , nom, prenom,adresse1,adresse2,ville,codePostale,telephone,matricule,`status`,civile,sex)values
						("cccc", 1 , "dupont","moréti","6 rue de labas","","amiens","80800","0698442069","2002","interne","MR","H"),
                        ("ffff", 2 ,"celine","truc","9 rue truc ","","mulhouse","68000","0698442069","2060","interne","MME","F"),
                        ("gggg", 3 ,"emmanuelle","dubois","6 rue machine truc","","altkirch","68130","0698442069","2050","externe","MLE","F"),
						("dddd", 4 ,"philipe","maurice","29 rue d'en haut","","molien","80300","0698442069","3030","externe","MR","H"),
                        ("eeee", 5 ,"papin","jean pierre","89 rue de chez lui","","paris","95000","098472079","3030","externe","MR","H");

insert into DOCUMENTATION (ID_PERSONNEL,titre,remsuDoc,dateDiffusion) values
                            ("cccc","développement application","resumé développement ", "2010/06/25"),
                            ("ffff","projet 2 ","resumé du projet 2 ", "2012/09/06");

insert into SECTEUR_ACTIVITE ( label ) values
                            ("gestion commerciale"),
                            ("gestion des ressource humaine"),
                            ("production"),
                            ("Achat");

-- new_project_code() est une fonction qui doit etre ajoute au schemas avant de faire l'insertion
insert into PROJET (ID_CODEPROJET, ID_DOCUMENTATION , ID_SECTEUR , nomProjet , libelCourt , libelLong , datePrevutDebut , datePrevutFin , dateReelleDebut , dateReelleFin , ChargeGlobEstime , nBCollaboMax , RemarqueEstimation ) values
                    ( new_project_code() , 1 , 3 ,"Mni PCCN", "deve","Développement Application Web","2019/09/25","2020/01/15",null,null,15000,5,"aucun remarque"),
                    ( new_project_code() , 2 , 3 ,"IHM autoroute", "deve","Développement IHM","2019/02/20","2020/01/20" ,null,"2020/01/20",2000,2,"aucun remarque");

insert into PROJET_CYCLE(ID_CYCLE, ID_CODEPROJET , `date`) values 
                        (2,2001,"2005/01/10"),
                        (3,2001,"2005/01/10"),
                        (1,2001,"2005/01/10");

insert into PROCESSUS ( processus) values
                        ("analyse des besoins"),
                        ("analyse des besoins Conception"),
                        ("Tests unitaires"),
                        ("Tests d’intégration"),
                        ("Tests de recette et installation"),
                        ("Management du projet"),
                        ("Gestion de configuration"),
                        ("Formation spécifique au projet");

insert into SALAIRE ( label , `datee`) values
                    ( 1500, str_to_date('10/10/2006', '%d/%m/%Y')),
                    ( 1600, str_to_date('01/10/2005', '%d/%m/%Y')),
                    ( 1800, str_to_date('10/02/2005', '%d/%m/%Y')),
                    ( 1500, str_to_date('15/08/2017', '%d/%m/%Y')),
                    ( 1800, str_to_date('10/12/2019', '%d/%m/%Y')),
					( 1900, str_to_date('16/08/2019', '%d/%m/%Y'));				

insert into CONTRAT ( ID_PERSONNEL, contrat, dateEmbauche, dateFin) values
                    ("cccc" , "CDI","2006/10/10",null),
                    ("ffff" , "CDI","2005/01/10",null),
                    ("gggg" , "CDD","2017/08/15","2019/08/15"),
                    ("dddd" , "CDD","2005/02/10","2006/02/10"),
                    ("eeee" , "CDI","2019/12/10",null),
					("gggg" , "CDI","2019/08/16",null);

insert into CONTRAT_salaire(ID_CONTRAT, ID_SALAIRE) values 
                            (1 , 1),
                            (2 , 2),
                            (3 , 4),
                            (4 , 3),
                            (5 , 5),
                            (6 , 6);              
    
insert into ETAPE (ID_NUMLOT, ID_PROCESSUS, ID_CODEPROJET, ChargeReelleProd, ChargeValidation,ChargeInitestime,experience) values
                    ( 1 , 1 , 2001 , 1800 , 1800 , 1500 ,"Aucun retour expérience"),
                    ( 2 , 8 , 2002 , 0 , 0 , 0 ,"Aucun retour expérience");

insert into INTERVENTION (ID_INTERVENTION , ID_PERSONNEL , ID_NUMLOT , ID_TECHNOLOGIE , ID_FONCTION ,intitule , `date` , duree ) values
                            ( 1, "cccc" , 1 , 1, 4 ,"développement de l'interface user java" ,"2020/02/20","70"),
                            ( 2, "gggg" , 1 , 3, 3 ,"développement de connection a tomcat" ,"2020/03/08","20"),
                            ( 3, "ffff" , 1 , 7, 2 ,"développement de la base de données" ,"2020/03/12","25"),
                            ( 4, "eeee" , 2 , 1, 8 ,"recherche est d'information" ,"2020/03/12","25");

insert into COLLABORATEUR_CLIENT ( ID_CLIENT, ID_FONCTION, nom, commentSpe, commentPro,adressEmail) values
                                ( 1 , 6 , "jean jack" , "intervant commerciale pour clemssey", "no comment" , "jeanJack@gmail.com"),
                                ( 1 , 3 , "Fabien" , "intervant developpement pour clemssey", "preparation du matériel" , "fabien.zindinzidan@gmail.com"),
                                ( 2 , 4 , "maxime" , "intervant developpement pour AFPA", "dévelpeur" , "ghalem.max@gmail.com");

insert into CLIENT_PROJET(ID_CODEPROJET,ID_COLLABORATEUR) values
                            (2001,1),
                            (2001,2),
                            (2002,3);

insert into COLLABORATEUR_INTER(ID_COLLABORATEUR ,ID_INTERVENTION ) values
                                ( 1, 1 ),
                                ( 1, 2 ),
                                ( 2, 3 );

insert into COMMENTAIRE ( ID_INTERVENTION, ID_PERSONNEL, commentaire) values
                        ( 1 , "cccc" , "commentaire sur l'interface de développement"),
                        ( 1 , "ffff" , "commentaire sur le cahier des charges"),
                        ( 4 , "gggg" , "commentaire sur la base de données");

insert into TECHNOLOGIE (ID_TECHNOLOGIE, technologie) values
                                (1 , "java"),
                                (2 , "C++"),
                                (3 , "Tomcat"),
                                (4 , "glassFich"),
                                (5 , "VueJS"),
                                (6 , "AngularJs"),
                                (7 , "Mysql");


