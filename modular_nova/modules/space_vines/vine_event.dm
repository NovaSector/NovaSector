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

/// Creates the spacevine controller at the chosen turf location
/datum/round_event/spacevine/difficult/proc/make_spacevine_controller(turf/chosen_spawn_turf)
	new /datum/spacevine_controller(
		location = chosen_spawn_turf,
		muts = list(
			/datum/spacevine_mutation/flowering,
			/datum/spacevine_mutation/light,
			SSmapping.is_planetary() ? /datum/spacevine_mutation/thorns : /datum/spacevine_mutation/cold_proof
		),
		potency = MAX_SEVERITY_LINEAR_COEFF,
		production = MAX_POSSIBLE_PRODUCTIVITY_VALUE,
		event = src
	)

/datum/round_event/spacevine/difficult/start()
	var/list/possible_spawn_turfs = list()

	if(override_turf)
		INVOKE_ASYNC(src, PROC_REF(make_spacevine_controller), override_turf)
		return

	var/obj/structure/spacevine/test_vine = new()
	for(var/area/possible_area in shuffle(GLOB.areas))
		var/list/candidate_turfs = list()

		// filter only the relevant areas
		if(SSmapping.is_planetary())
			if(!istype(possible_area, /area/station/hallway))
				continue
		else
			if(!(istype(possible_area, /area/space/nearstation) || istype(possible_area, /area/station/solars)))
				continue

		// perform cheap filtering on all possible turfs in each area
		for(var/turf/open/floor in possible_area.get_turfs_from_all_zlevels())
			if(!is_station_level(floor.z))
				continue
			if(isopenspaceturf(floor))
				continue
			if(floor.get_lumcount() <= LIGHTING_TILE_IS_DARK)
				continue

			candidate_turfs += floor

		// Enter() is expensive to call on potentially hundreds to thousands of turfs at once and can even lead to server crashes.
		// We can pick() a subset instead and get close enough results at a fraction of the cost.
		var/max_attempts = 25
		var/attempts = 0
		// Pick extra candidates to compensate for potential Enter() failures
		var/list/final_candidate_turfs = pick_n(candidate_turfs, min(max_attempts, length(candidate_turfs)))

		for(var/turf/open/floor as anything in final_candidate_turfs)
			if(attempts >= max_attempts)
				break
			if(floor.Enter(test_vine))
				possible_spawn_turfs += floor
				attempts++

	qdel(test_vine)

	// pick a spawn turf safely
	if(length(possible_spawn_turfs))
		var/turf/chosen_spawn_turf = pick(possible_spawn_turfs)
		if(chosen_spawn_turf)
			// schedule vine creation asynchronously
			INVOKE_ASYNC(src, PROC_REF(make_spacevine_controller), chosen_spawn_turf)
