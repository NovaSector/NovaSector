/datum/round_event_control/spacevine/difficult
	name = "Space Vines (Hard)"
	typepath = /datum/round_event/spacevine/difficult
	min_players = 40
	max_occurrences = 1
	weight = 8 //LOW_EVENT_FREQ
	description = "Kudzu begins to overtake the station. Will spawn man-traps."
	admin_setup = list(
		/datum/event_admin_setup/set_location/spacevine,
	)

/// puts the space in spacevine. this one can spawn in space
/datum/round_event/spacevine/difficult

/// for each turf that can be a possible spawn point, run a series of checks to see if its appropriate to pick
/datum/round_event/spacevine/difficult/proc/validate_turfs(area/possible_area, list/possible_spawn_turfs, obj/structure/spacevine/test_vine)
	for(var/turf/open/floor in possible_area.get_turfs_from_all_zlevels())
		if(!is_station_level(floor.z)) //is the tile station z
			continue
		if(isopenspaceturf(floor)) // don't spawn in openspace turfs
			continue
		if(floor.get_lumcount() <= LIGHTING_TILE_IS_DARK) //we don't like to spawn in the dark
			continue
		if(!floor.Enter(test_vine)) //can we enter the tile
			continue
		possible_spawn_turfs += floor
	return possible_spawn_turfs

/datum/round_event/spacevine/difficult/start()
	var/list/possible_spawn_turfs = list()
	if(override_turf)
		possible_spawn_turfs += override_turf
	else
		var/obj/structure/spacevine/test_vine = new()
		for(var/area/possible_area in GLOB.areas)
			if(SSmapping.is_planetary())
				if(istype(possible_area, /area/station/hallway))
					possible_spawn_turfs += validate_turfs(possible_area, possible_spawn_turfs, test_vine)
			else
				if(istype(possible_area, /area/space/nearstation) || istype(possible_area, /area/station/solars))
					possible_spawn_turfs += validate_turfs(possible_area, possible_spawn_turfs, test_vine)
		qdel(test_vine)

	if(length(possible_spawn_turfs))
		var/turf/chosen_spawn_turf = pick(possible_spawn_turfs)
		new /datum/spacevine_controller(
			chosen_spawn_turf,
			list(
				/datum/spacevine_mutation/flowering,
				/datum/spacevine_mutation/light,
				SSmapping.is_planetary() ? /datum/spacevine_mutation/thorns : /datum/spacevine_mutation/cold_proof
			),
			MAX_SEVERITY_LINEAR_COEFF,
			MAX_POSSIBLE_PRODUCTIVITY_VALUE,
			src,
		)
