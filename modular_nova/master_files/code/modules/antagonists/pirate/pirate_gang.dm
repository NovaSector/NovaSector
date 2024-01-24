/// Override for Pirates for lore or policy reasons
/init_pirate_gangs(is_heavy)
	var/list/pirate_gangs = ..()
	pirate_gangs -= /datum/pirate_gang/interdyne // Interdyne isnt a hostile faction in current lore, balance reasons aside
	return pirate_gangs
