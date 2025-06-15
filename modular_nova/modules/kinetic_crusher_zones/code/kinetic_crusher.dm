// Modular kinetic crusher zone restrictions

/obj/item/kinetic_crusher
	var/trophies_enabled = FALSE

/obj/item/kinetic_crusher/Initialize(mapload)
	. = ..()
	update_trophies_enabled()
	// Listen to our own movement AND our container's movement
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(on_any_movement))

/obj/item/kinetic_crusher/proc/on_any_movement(datum/source, atom/old_loc, atom/new_loc)
	SIGNAL_HANDLER
	// Check if we actually changed z-levels
	var/turf/old_turf = get_turf(old_loc)
	var/turf/new_turf = get_turf(new_loc)

	if(!old_turf || !new_turf)
		update_trophies_enabled()
		return

	if(old_turf.z != new_turf.z)
		update_trophies_enabled()

		// Provide chat feedback to holder if it's a mob
		var/atom/holder = loc
		if(ishuman(holder))
			to_chat(holder, "[src.name]: Trophies [trophies_enabled ? "enabled" : "disabled"] based on current z-level.")
		else if(ismob(holder))
			to_chat(holder, "[src.name]: Trophies [trophies_enabled ? "enabled" : "disabled"].")

/obj/item/kinetic_crusher/proc/update_trophies_enabled()
	// Get the actual turf we're on
	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		trophies_enabled = FALSE
		return

	var/datum/space_level/level = SSmapping.z_list[current_turf.z]

	// Check if the current z-level has the ZTRAIT_LAVA_RUINS trait (lavaland)
	if(level && (ZTRAIT_LAVA_RUINS in level.traits))
		trophies_enabled = TRUE
	else
		trophies_enabled = FALSE

	// Debug output
	world.log << "[src.name] trophies_enabled = [trophies_enabled] at z-level [current_turf.z] (trait check: [ZTRAIT_LAVA_RUINS in level?.traits])"
