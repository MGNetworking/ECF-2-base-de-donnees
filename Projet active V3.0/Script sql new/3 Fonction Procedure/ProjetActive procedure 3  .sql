-- procedure 3
--  On veut lister les interventions des collaborateurs sur un projet entre deux dates.
-- La procédure renvoie pour chaque intervention : 
-- Le nom du collaborateur associé - La fonction en clair du collaborateur - Les dates début et fin intervention - La tâche ou activité associée.

drop procedure liste_intervention;

delimiter $$
create procedure liste_intervention(in entreDate varcharacter(10), in sortiDate varcharacter(10)  )
begin 

select nom, f.intituler as 'fonction collaborateur' , `date` as 'date intervention' , i.intitule as 'tache executer'
	from projet p 
			inner join etape e on p.ID_CODEPROJET = e.ID_CODEPROJET
			inner join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
            inner join personnel pl on i.ID_PERSONNEL = pl.ID_PERSONNEL
			inner join technologie t on i.ID_TECHNOLOGIE = t.ID_TECHNOLOGIE
            inner join fonction f on i.ID_FONCTION = f.ID_FONCTION
where `date` between  str_to_date(entreDate, '%d/%m/%Y') and  str_to_date(sortiDate, '%d/%m/%Y');

end $$
delimiter ;

call liste_intervention('10/01/2008', '10/10/2020');