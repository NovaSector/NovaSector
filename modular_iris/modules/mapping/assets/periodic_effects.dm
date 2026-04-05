/obj/effect/abstract/periodic_effect
	icon_state = "sec_holo_no_anim"
	var/effect_frequency = 3 SECONDS
	var/seconds_since_last_activation

/obj/effect/abstract/periodic_effect/Initialize(mapload)
	. = ..()
	icon_state = "nothing"
	if(effect_frequency < 1 SECONDS)
		effect_frequency = 1 SECONDS
	START_PROCESSING(SSprocessing, src)

/obj/effect/abstract/periodic_effect/process(seconds_per_tick)
	seconds_since_last_activation += 1 SECONDS * seconds_per_tick
	if(seconds_since_last_activation >= effect_frequency)
		seconds_since_last_activation = 0
		do_effect()

/obj/effect/abstract/periodic_effect/proc/do_effect()
	//override this proc with what you want to happen on children
	return

//fire attack that periodically lights up tiles in a given direction, not including its own tile
/obj/effect/abstract/periodic_effect/linear_fire
	var/effect_direction = 2 //SOUTH, use 1 for NORTH, 4 for EAST and 8 for WEST when mapping
	var/effect_range_in_tiles = 5
	var/stop_at_walls = FALSE
	var/fire_temperature = DRAKE_FIRE_TEMP
	var/fire_volume = DRAKE_FIRE_EXPOSURE

/obj/effect/abstract/periodic_effect/linear_fire/do_effect()
	var/turf/target_turf = get_ranged_target_turf(src, effect_direction, effect_range_in_tiles)
	var/list/turfs_to_burn = get_line(src, target_turf) - get_turf(src)

	for(var/turf/turf as anything in turfs_to_burn)
		if(turf.is_blocked_turf(exclude_mobs = TRUE))
			if(stop_at_walls)
				return
			continue
		new /obj/effect/hotspot(turf, fire_volume, fire_temperature)
		turf.hotspot_expose(fire_temperature, fire_volume, TRUE)
