/**
 * CYBERSUN SIM
 */
/datum/lazy_template/deathmatch/cybersun_sim
	map_dir = "_maps/nova/lazy_templates/deathmatch"
	name = "Cybersun Training Simulator"
	max_players = 4
	allowed_loadouts = list(/datum/outfit/deathmatch_loadout/cybersun_sim)
	map_name = "cybersun_sim"
	key = "cybersun_sim"

/**
 * DEEPSPACE
 */
/datum/lazy_template/deathmatch/azulean
	map_dir = "_maps/nova/lazy_templates/deathmatch"
	name = "Deep Space"
	desc = "A deep space loading station has fallen under attack by an Azulean pirate raid."
	max_players = 12
	automatic_gameend_time = 15 MINUTES
	allowed_loadouts = list(/datum/outfit/deathmatch_loadout/azulean, /datum/outfit/deathmatch_loadout/syndicate_space, /datum/outfit/deathmatch_loadout/assistant_space)
	map_name = "deep_space"
	key = "deep_space"
