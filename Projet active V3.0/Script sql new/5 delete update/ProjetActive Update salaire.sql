UPDATE salaire s
		join contrat_salaire cs on cs.ID_SALAIRE = s.ID_SALAIRE
		join contrat c on c.ID_CONTRAT = cs.ID_CONTRAT
		join PERSONNEL p on p.ID_PERSONNEL = c.ID_PERSONNEL
        
    set label = label + (s.label * 0.05)
    
where contrat like 'CDI' and dateFin is null;


