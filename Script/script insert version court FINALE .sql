-- delete from client where ID_CLIENT = 1 and ID_CLIENT = 2;

insert into CLIENT ( ID_CLIENT, RAISONSOCIALE,ADRESSE,TELEPHONE,CHIFFREAFFAIRE,EFFECTIFS,COMMENTAIREGENERAUX,NATURE,DOMAIN,ACTIVITE) values 
					( 1,"afpa", "rue du machin", "0607982521", 5000 , 500, "commentaire de l'afpa", "principale", "public", "formation"),
                    ( 2,"clemessy", "rue du bidule", "0607080910", 3000 , 100, "commentaire de clemessy", "secondaire", "privé", "formation");
                    
insert into FONCTION (ID_FONCTION, INTITULE ) values
                     (1, "Responsable de projet"),
                     (2, "analyse des besoins  Conception"),
                     (3, "Tests unitaires"),
                     (4, "Tests d’intégration"),
                     (5, "Tests de recette et installation"),
                     (6, "Management du projet"),
                     (7, "Gestion de configuration"),
                     (8, "Formation spécifique au projet"),
                     (9, "Divers");

insert into SALAIRE (ID_SALAIRE,SALAIRE,DATEEMBAUCHE,DATEFIN) values
                    (1,1500, str_to_date('15/08/2019', '%d/%m/%Y') , null),
                    (2,1600, str_to_date('07/06/2019', '%d/%m/%Y') , null),
                    (3,1300, str_to_date('07/06/2018', '%d/%m/%Y') , null),
                    (4,2100, str_to_date('07/06/2017', '%d/%m/%Y') , null);

insert into PERSONNEL ( ID_PERSONNEL,ID_FONCTION,ID_SALAIRE, NOM, PRENOM,ADRESSE1,ADRESSE2,VILLE,CODEPOSTALE,TELEPHONEPERSONNE,MATRICULE,STATUS,CIVILE,SEX)values
						("cccc",1,1,"dupont","moréti","6 rue de labas","","amiens","80800","0698442069","2002","interne","MR","H"),
                        ("ffff",2,3,"celine","truc","9 rue truc ","","mulhouse","68000","0698442069","2060","interne","MME","F"),
                        ("gggg",3,4,"emmanuelle","machin","6 rue machine truc","","altkirch","68130","0698442069","2050","externe","MLE","F"),
						("dddd",4,2,"dupont","moréti","29 rue d'en haut","","molien","80300","0698442069","3030","externe","MR","H");


                    
