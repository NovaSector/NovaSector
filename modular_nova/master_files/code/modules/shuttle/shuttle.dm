/obj/docking_port/mobile
	/// Does this shuttle play sounds upon landing and takeoff?
	var/shuttle_sounds = TRUE
	/// The take off sound to be played
	var/takeoff_sound = sound('modular_nova/modules/advanced_shuttles/sound/engine_startup.ogg')
	/// The landing sound to be played
	var/landing_sound = sound('modular_nova/modules/advanced_shuttles/sound/engine_landing.ogg')
	/// The sound range coeff for the landing and take off sound effect
	var/sound_range = 11

/obj/docking_port/mobile/proc/mark_external_doors()
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	var/list/bounds = return_coords()
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]

		// Do not touch station airlocks
		if (!shuttle_areas[get_area(checked_turf)])
			continue

		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			// Door on the border is external always
			if (airlock_door.x == bounds[1] || airlock_door.y == bounds[2] || airlock_door.x == bounds[3] || airlock_door.y == bounds[4])
				airlock_door.external = TRUE
				continue

			// If door facing space or mapped without atmos - it is external too
			var/turf/T = get_step(airlock_door, WEST)
			if(is_space_or_openspace(T) || T.initial_gas_mix == AIRLESS_ATMOS)
				airlock_door.external = TRUE
				continue
			T = get_step(airlock_door, EAST)
			if(is_space_or_openspace(T) || T.initial_gas_mix == AIRLESS_ATMOS)
				airlock_door.external = TRUE
				continue
			T = get_step(airlock_door, NORTH)
			if(is_space_or_openspace(T) || T.initial_gas_mix == AIRLESS_ATMOS)
				airlock_door.external = TRUE
				continue
			T = get_step(airlock_door, SOUTH)
			if(is_space_or_openspace(T) || T.initial_gas_mix == AIRLESS_ATMOS)
				airlock_door.external = TRUE
				continue

			// All checks passed - you are internal
			airlock_door.external = FALSE

/obj/docking_port/mobile/proc/bolt_all_doors() // Expensive procs :(
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	var/list/airlock_cache = list()
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]

		// Do not touch station airlocks
		if (!shuttle_areas[get_area(checked_turf)])
			continue

		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			if(airlock_door.external)
				airlock_door.close(force_crush = TRUE)
				airlock_door.bolt()
				// If airlock is controlled - bolt them all to avoid airlocks state mismatch
				if(airlock_door.id_tag)
					airlock_cache[airlock_door.id_tag] = TRUE
					for(var/obj/machinery/door/airlock/synced_door in airlock_cache)
						if (synced_door.id_tag == airlock_door.id_tag)
							synced_door.close(force_crush = TRUE)
							synced_door.bolt()
							airlock_cache -= synced_door

			else if(airlock_door.id_tag)
				if(airlock_cache[airlock_door.id_tag])
					airlock_door.close(force_crush = TRUE)
					airlock_door.bolt()
					continue
				airlock_cache += airlock_door

/obj/docking_port/mobile/proc/unbolt_all_doors()
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]

		// Do not touch station airlocks
		if (!shuttle_areas[get_area(checked_turf)])
			continue

		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			// Do not unbolt button controlled exits
			if(airlock_door.external && !airlock_door.id_tag)
				airlock_door.unbolt()

/obj/docking_port/mobile/proc/play_engine_sound(atom/distant_source, takeoff)
	if(distant_source)
		for(var/mob/hearing_mob in range(sound_range, distant_source))
			if(hearing_mob?.client)
				var/dist = get_dist(hearing_mob.loc, distant_source.loc)
				var/vol = clamp(40 - ((dist - 3) * 5), 0, 40) // Every tile decreases sound volume by 5
				if(takeoff)
					if(hearing_mob.client?.prefs?.read_preference(/datum/preference/toggle/sound_ship_ambience))
						hearing_mob.playsound_local(distant_source, takeoff_sound, vol)
				else
					if(hearing_mob.client?.prefs?.read_preference(/datum/preference/toggle/sound_ship_ambience))
						hearing_mob.playsound_local(distant_source, landing_sound, vol)
