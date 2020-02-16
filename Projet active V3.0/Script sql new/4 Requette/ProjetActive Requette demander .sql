-- Requête 1 : On souhaite obtenir par secteur d’activité  la moyenne des charges estimées des projets..
	select AVG(ChargeGlobEstime) as 'Moyen des charges projet' 
	from projet p 
	join secteur_activite s on p.ID_SECTEUR = s.ID_SECTEUR
	group by s.label;
    
-- Requête 2 : On souhaite obtenir la liste des projets (libellé court) sur lesquels un collaborateur est intervenu.  
-- Préciser également sa fonction dans les projets
	select p.libelCourt as 'nom des projets' , nom , f.intituler as 'fonction'
	from projet p 
		join etape e on e.ID_CODEPROJET = p.ID_CODEPROJET
		join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
		join personnel pl on i.ID_PERSONNEL = pl.ID_PERSONNEL
		join fonction f on pl.ID_FONCTION = f.ID_FONCTION
	where pl.NOM like '%pont%';

-- Requête 2 perso : On souhaite obtenir la liste des projets (libellé court) sur lesquels tous les collaborateurs sont intervenu.  
-- Préciser également sa fonction dans les projets

select NOMPROJET as 'Nom des projets' , nom as 'nom du personnel' , f.intituler as 'Fonction du personnel'
from projet p 
	join etape e on e.ID_CODEPROJET = p.ID_CODEPROJET
	join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
    join personnel pl on i.ID_PERSONNEL = pl.ID_PERSONNEL
    join fonction f on pl.ID_FONCTION = f.ID_FONCTION
    order by nom asc;
    

 
 -- Requête 3 : On souhaite obtenir à la date du jour la liste des projets en cours, par secteur d’activité.  
 -- Préciser le nombre de collaborateurs associés aux projets et ceci par fonction.
	select current_date() as 'date du jours', count(ID_PERSONNEL) as 'nombre de personne' , f.intituler as 'Fonction' , p.nomProjet , sa.label as 'secteur d\'activité'
		from fonction f 
				join intervention i on i.ID_FONCTION = f.ID_FONCTION
				join etape e on e.ID_NUMLOT = i.ID_NUMLOT
				join projet p on p.ID_CODEPROJET = e.ID_CODEPROJET
				join secteur_activite sa on p.ID_SECTEUR = sa.ID_SECTEUR
		where p.datePrevutFin is null
	group by f.intituler;
    
    
  
  
