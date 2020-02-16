-- safe mode mise a 0
SET SQL_SAFE_UPDATES = 0;

-- Supprimer de la base de données les projets qui sont terminés et qui n’ont pas eut de charges (étapes) associées.
delete projet 
from projet
inner join etape on projet.ID_CODEPROJET = etape.ID_CODEPROJET
where dateReelleFin is not null and chargeReelleProd = 0;

-- pour verifier la suppréssion d'un projet coté entreprise 
select p.ID_CODEPROJET, nomProjet  , commentaire as 'commentaire personnel' , pl.nom as 'nom collaborateur client'
from projet p
	inner join etape e on p.ID_CODEPROJET = e.ID_CODEPROJET
	inner join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
    inner join commentaire co on co.ID_INTERVENTION = i.ID_INTERVENTION
    inner join personnel pl on pl.ID_PERSONNEL = co.ID_PERSONNEL
group by pl.nom 
order by nomProjet;

-- coté client 
SELECT * FROM active.client_projet;

select * 
from intervention;

select * 
from etape;

select * 
from commentaire;