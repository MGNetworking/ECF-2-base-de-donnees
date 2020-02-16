-- procedure 2 
-- On souhaite obtenir sur un thème technique donné la liste des projets associés et terminés depuis moins de 2 ans 

drop procedure donner_technique;

delimiter $$
create procedure donner_technique()
begin 

	select nomProjet , technologie
		from projet p 
			inner join etape e on p.ID_CODEPROJET = e.ID_CODEPROJET
			inner join intervention i on e.ID_NUMLOT = i.ID_NUMLOT
			inner join technologie t on i.ID_TECHNOLOGIE = t.ID_TECHNOLOGIE
	where datediff(current_date, dateReelleFin) > (365*2);

end $$

delimiter ;


call donner_technique();



