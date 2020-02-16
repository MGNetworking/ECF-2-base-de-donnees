-- procédure 1
--  On souhaite obtenir la moyenne des charges estimées sur les projets en cours.

drop procedure charge_estimer_projet;

delimiter $$
create procedure charge_estimer_projet()
begin 

	select avg(ChargeGlobEstime)
	from projet 
	where dateReelleFin is null;

end $$
delimiter ;


call charge_estimer_projet();