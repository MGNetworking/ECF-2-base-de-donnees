-- Vérifier la cohérence du chiffre d’affaire du client, si supérieur à 1 million d’euros par personne la valeur du CA est erronée

drop trigger if exists chiffre_affaire;

delimiter $$

create trigger chiffre_affaire

before insert 
	on client for each row
    
    begin
    
		if  new.chiffreAffaire / new.effectifs > 1000000 then
			signal sqlstate '45000' set message_text = "le chiffre d\'affaire est supérieur a 1 000 000 euro" ;
		end if;
        
    end $$
    
delimiter ;

-- client teste 
insert into CLIENT ( raisonSociale ,adresse ,telephone ,chiffreAffaire ,effectifs ,commentGeneraux ,nature ,domain ,activite ) values 
					("client teste", "rue du machin", "0607982521", 300000 , 2, "commentaire de l'afpa", "principale", "public", "formation");

-- verifie le nouveau client
select raisonSociale , chiffreAffaire , effectifs, ID_CLIENT
from client ;

-- supprime le client ajouter
delete from CLIENT
	where raisonSociale like "%teste%" ;
