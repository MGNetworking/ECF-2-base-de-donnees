-- Vérifier la cohérence du code statut,  Passages possibles de : - S (stagiaire) à D (CDD)  ou I (CDI),  - D (CDD) à I (CDI)

drop trigger if exists status_contrat;

delimiter $$

create trigger status_contrat
before update
	on contrat for each row
		begin 
            DECLARE old_Status , new_Status INT ;
			-- affectation de valeur pour l'ancien contrat
            case 
				when old.contrat = 'STA' then set old_Status = 1;       
                when old.contrat = 'CDD' then set old_Status = 2;
                when old.contrat = 'CDI' then set old_Status = 3;
			end case;
            -- affection de valeur pour le nouveau contrat 
			case 
                when new.contrat = 'STA' then set new_Status = 1;
                when new.contrat = 'CDD' then set new_Status = 2;
                when new.contrat = 'CDI' then set new_Status = 3;
			end case;
            
            -- teste si le nouveau contrat a un status plus élevé
            if  old_Status > new_Status  then
				signal sqlstate '45000' set message_text = "vous ne pouvez pas faire évoluer ce contrat vers ce nouveau status";
            end if;

		end $$
    
delimiter ;

-- verification de l'update avant il etait CDI passage vers STA
update CONTRAT set contrat = "CDI" where ID_CONTRAT = 1;


select contrat , nom , dateEmbauche, dateFin
from personnel p
	left join contrat c on c.id_personnel = p.id_personnel
where ID_CONTRAT = 1;
                    
    