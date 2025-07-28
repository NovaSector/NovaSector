/datum/round_event_control/spacevine/difficult
	name = "Space Vines (Hard)"
	typepath = /datum/round_event/spacevine/difficult
	min_players = 30
	description = "Kudzu begins to overtake the station. Will spawn man-traps."
	admin_setup = list(
		/datum/event_admin_setup/set_location/spacevine,
	)

/datum/round_event/spacevine/difficult

/datum/round_event/spacevine/difficult/start()
	var/list/turfs = list()
	if(override_turf)
		turfs += override_turf
	else
		var/obj/structure/spacevine/vine = new()
		for(var/area/area in GLOB.areas)
			if(istype(area, /area/station/hallway) || istype(area, /area/station/maintenance) || (istype(area, /area/station/solars) && !SSmapping.is_planetary()))
				for(var/turf/open/floor in area.get_turfs_from_all_zlevels())
					if(!isopenspaceturf(floor) && floor.Enter(vine) && (floor.get_lumcount() > LIGHTING_TILE_IS_DARK))
						//yea ok we can spawn in maintenance now but there has to be light on the tile
						turfs += floor
		qdel(vine)

	if(length(turfs))
		var/turf/floor = pick(turfs)
		new /datum/spacevine_controller(
			floor,
			list(
				/datum/spacevine_mutation/flowering,
				/datum/spacevine_mutation/light,
				/datum/spacevine_mutation/cold_proof,
				),
			MAX_SEVERITY_LINEAR_COEFF,
			MAX_POSSIBLE_PRODUCTIVITY_VALUE,
			src,
			)
