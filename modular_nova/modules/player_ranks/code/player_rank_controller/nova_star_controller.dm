/// The list of all star players.
GLOBAL_LIST_EMPTY(nova_star_list)
GLOBAL_PROTECT(nova_star_list)


/datum/player_rank_controller/nova_star
	rank_title = "nova_star"


/datum/player_rank_controller/nova_star/New()
	. = ..()
	legacy_file_path = "[global.config.directory]/nova/nova_star_players.txt"


/datum/player_rank_controller/nova_star/add_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	ckey = ckey(ckey)

	// Associative list for extra SPEED!
	GLOB.nova_star_list[ckey] = TRUE


/datum/player_rank_controller/nova_star/remove_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	GLOB.nova_star_list -= ckey


/datum/player_rank_controller/nova_star/get_ckeys_for_legacy_save()
	if(IsAdminAdvancedProcCall())
		return

	return GLOB.nova_star_list


/datum/player_rank_controller/nova_star/should_use_legacy_system()
	return CONFIG_GET(flag/nova_star_legacy_system)


/datum/player_rank_controller/nova_star/clear_existing_rank_data()
	if(IsAdminAdvancedProcCall())
		return

	GLOB.nova_star_list = list()
