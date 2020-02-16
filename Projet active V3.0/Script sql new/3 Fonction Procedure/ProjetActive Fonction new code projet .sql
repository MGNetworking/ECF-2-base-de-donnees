
drop function if exists new_project_code;

delimiter //

create function new_project_code ()
	returns char(4)
	not deterministic
		reads sql DATA
begin
	declare codemax char(4);
	select max(ID_CODEPROJET) from projet into codemax ;
	if substring( codemax , 1 , 2 ) like substring( year( current_date() ) , 3 ) then
		set codeMax = codeMax + 1;
	else
		set codeMax = ( substring( year( current_date() ) , 3 ) * 100 ) + 1 ; 
	end if;
	return codeMax; 
end 
//
delimiter ;

-- select new_project_code();