-- historique du personnel dans l'entreprise les 5 derniers années soit 1825 jour
select nom, contrat , label as 'salaire' , dateEmbauche , dateFin
from personnel p
	join contrat c on p.ID_PERSONNEL = c.ID_PERSONNEL
    join contrat_salaire cs on cs.ID_CONTRAT = c.ID_CONTRAT
    join salaire s on cs.ID_SALAIRE = s.ID_SALAIRE
where datediff(current_date, dateEmbauche) > 1825
    order by dateEmbauche asc ;
    
-- Historique du personnel
select nom, contrat , label as 'salaire', dateEmbauche , dateFin
from personnel p
	join contrat c on p.ID_PERSONNEL = c.ID_PERSONNEL
    join contrat_salaire cs on cs.ID_CONTRAT = c.ID_CONTRAT
    join salaire s on cs.ID_SALAIRE = s.ID_SALAIRE
    order by contrat asc ;

-- A utiliser pour le delete
-- Projet terminer + plus charge relle de production égale à 0
select dateReelleFin, chargeReelleProd , nomProjet
from projet p
	inner join etape e on p.ID_CODEPROJET = e.ID_CODEPROJET
    inner join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
    where dateReelleFin is not null and chargeReelleProd <= 0;
    
-- la liste des projets
select  nomProjet
from projet
order by nomProjet ;

-- tous les projets avec leur nom et leurs techno
select nomProjet , processus as 'process etape', technologie as 'techno intervention'
from projet p
	inner join etape e on p.ID_CODEPROJET = e.ID_CODEPROJET
    inner join processus pc on pc.ID_PROCESSUS = e.ID_PROCESSUS
    inner join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
    inner join technologie t on t.ID_TECHNOLOGIE = i.ID_TECHNOLOGIE
    order by nomProjet asc ;
    
-- Tous les projets avec leur commentaire 
-- il y a 2 commentaires qui ce trouve dans les interventions pour chaque projet 
select nomProjet , commentaire
from projet p
	inner join etape e on p.ID_CODEPROJET = e.ID_CODEPROJET
    inner join processus pc on pc.ID_PROCESSUS = e.ID_PROCESSUS
    inner join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
    inner join technologie t on t.ID_TECHNOLOGIE = i.ID_TECHNOLOGIE
    inner join commentaire c on c.ID_INTERVENTION = i.ID_INTERVENTION
    order by nomProjet asc ;
    
-- intervention collaborateur a verifier 
select nomProjet , nom
	from projet p
    inner join client_projet cp on p.ID_CODEPROJET = cp.ID_CODEPROJET
    inner join collaborateur_client cl on cp.ID_COLLABORATEUR = cl.ID_COLLABORATEUR;
    