-- Ne pas supprimer un projet si la date réelle de fin du projet est inférieure à 2 mois par rapport  à la date du jour. 

drop trigger if exists suprimer_projet ;

delimiter $$
create trigger suprimer_projet
before delete 
	on projet for each row
    begin 
    
		-- si le projet et fini depuis moin de 2 mois, blockage de la suppriession
		if ((old.datePrevutFin - current_date()) < 60) then 
			signal sqlstate '45000' set message_text = "Le délai des 60 jours pour la suppression du projet n'est pas arriver a échéance";
		end if;
    
    end $$
delimiter ;

-- teste de suppression
delete from projet 
where ID_CODEPROJET = 2001;

-- verification des projets
select nomProjet , datePrevutFin
from projet;

