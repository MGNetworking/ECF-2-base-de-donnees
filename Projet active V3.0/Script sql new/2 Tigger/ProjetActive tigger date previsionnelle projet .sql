-- Vérifier que la date prévisionnelle de début du projet est inférieure ou égale la date  prévisionnelle de fin du projet. 

drop trigger if exists date_previsionnelle;

delimiter $$
create trigger date_previsionnelle

before insert 
	on projet for each row
    begin
			-- génére une exception si la date de début et plus petit que celle de fin 
			if (new.datePrevutDebut >= new.datePrevutFin) then
			signal sqlstate '45000' set message_text = 'la date prévisionelle de début de projet doit étre plus ancienne que celle de fin projet';
		end if;

    end $$
    
delimiter ;

insert into PROJET (ID_CODEPROJET, ID_DOCUMENTATION , ID_SECTEUR , nomProjet , libelCourt , libelLong , datePrevutDebut , datePrevutFin , dateReelleDebut , dateReelleFin , ChargeGlobEstime , nBCollaboMax , RemarqueEstimation ) values
                    ( new_project_code() , 2 , 3 ,"projet teste", "deve","Développement Application Web","2019/09/25","2021/10/24",null,null,15000,5,"aucun remarque");
    
select *
from projet ;

SET SQL_SAFE_UPDATES = 0;

delete from projet
	where ID_CODEPROJET = 2003;