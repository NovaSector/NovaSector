/datum/round_event_control/cortical_borer
	name = "Cortical Borer Infestation"
	typepath = /datum/round_event/ghost_role/cortical_borer
	weight = 3
	min_players = 10
	max_occurrences = 1 //should only ever happen once
	category = EVENT_CATEGORY_ENTITIES
	description = "A cortical borer has appeared on station. It will also attempt to produce eggs, and will attempt to gather willing hosts and learn chemicals through the blood."

/datum/round_event/ghost_role/cortical_borer
	role_name = "Cortical Borer"
	minimum_required = 1
	announce_when = 10

/datum/round_event/ghost_role/cortical_borer/announce(fake)
	priority_announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", ANNOUNCER_ALIENS)

/*
/datum/round_event/ghost_role/cortical_borer/start()
	var/list/mob/dead/observer/candidates = SSpolling.poll_ghost_candidates(role = ROLE_BORER,check_jobban = FALSE,alert_pic = /obj/item/borer_egg,role_name_text = "cortical borer",amount_to_pick = 1)
	if(isnull(candidates))
		return NOT_ENOUGH_PLAYERS
/* disabling vent spawns in favor of maintenance spawns, can be changed later
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/atmospherics/components/unary/vent_pump))
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue // No parent vent
			// Stops Cortical Borers getting stuck in small networks.
			// See: Security, Virology
			if(length(temp_vent_parent.other_atmos_machines) > 20)
				vents += temp_vent
	if(!length(vents))
		return MAP_ERROR
*/
	world << "Subsystem 'polling' should be initialized for Cortical Borer Ghost Role"
	var/borer_spawn = find_maintenance_spawn()
	if(isnull(borer_spawn))
		return MAP_ERROR
	//var/living_number = max(length(GLOB.player_list) / POP_PER_BORER, 1)
	var/choosing_number = min(length(candidates))
	for(var/repeating_code in 1 to choosing_number)
		var/mob/dead/observer/new_borer = pick(candidates)
		candidates -= new_borer
		//var/turf/vent_turf = get_turf(pick(vents))
		var/mob/living/basic/cortical_borer/spawned_cb = new(borer_spawn)
		spawned_cb.ckey = new_borer.ckey
		spawned_cb.mind.add_antag_datum(/datum/antagonist/cortical_borer)
		to_chat(spawned_cb, span_warning("You are a cortical borer! You can fear someone to make them stop moving, but make sure to inhabit them! You only grow/heal/talk when inside a host!"))
	for(var/mob/dead_mob in GLOB.dead_mob_list)
		to_chat(dead_mob, span_notice("The cortical borer has been selected, you are able to orbit them! Remember, they can reproduce!"))
	return SUCCESSFUL_SPAWN
*/

//trying this to see if it works

/datum/round_event/ghost_role/cortical_borer/spawn_role()
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(role = ROLE_BORER,question = "Do you want to play as a Cortical Borer?", alert_pic = /obj/item/borer_egg, role_name_text = "cortical borer", amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	var/spawn_location = find_maintenance_spawn()
	if(isnull(spawn_location))
		return MAP_ERROR
	var/mob/living/basic/cortical_borer/spawned_cb = new(spawn_location)
	spawned_cb.key = chosen_one.key
	spawned_cb.mind.add_antag_datum(/datum/antagonist/cortical_borer)
	spawned_cb.log_message("was spawned as a Cortical Borer by an event.", LOG_GAME)
	to_chat(spawned_cb, span_warning("You are a cortical borer! You can fear someone to make them stop moving, but make sure to inhabit them! You only grow/heal/talk when inside a host!"))
	spawned_mobs += spawned_cb
	return SUCCESSFUL_SPAWN
