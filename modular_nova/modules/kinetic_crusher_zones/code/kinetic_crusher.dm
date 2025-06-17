// Modular kinetic crusher zone restrictions

/obj/item/kinetic_crusher
	var/trophies_enabled = FALSE
	var/previous_trophies_enabled = FALSE

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

/obj/item/kinetic_crusher/proc/update_trophies_enabled()
	// Store the previous state
	previous_trophies_enabled = trophies_enabled

	// Get the actual turf we're on
	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		trophies_enabled = FALSE
		return

	var/datum/space_level/level = SSmapping.z_list[current_turf.z]

	// Check if the current z-level has the ZTRAIT_LAVA_RUINS trait
	if(level && (ZTRAIT_LAVA_RUINS in level.traits))
		trophies_enabled = TRUE
	else
		trophies_enabled = FALSE

	// Only show messages if the state actually changed
	if(trophies_enabled != previous_trophies_enabled)
		var/atom/holder = loc
		if(ismob(holder))
			balloon_alert(holder, "trophies [trophies_enabled ? "active" : "inactive"]")

			// Check if any fauna trophies are attached
			var/has_fauna_trophy = FALSE
			for(var/obj/item/crusher_trophy/trophy in trophies)
				if(trophy.fauna_trophy)
					has_fauna_trophy = TRUE
					break

			if(has_fauna_trophy)
				if(trophies_enabled)
					to_chat(holder, span_notice("The hostile resonance of Indecipheres feeds power through your crusher and its trophies."))
				else
					to_chat(holder, span_warning("The resonance fades from your crusher's trophies as you leave the atmosphere of Indecipheres behind."))

	// Debug output, if one wants to investigate
	world.log << "[src.name] trophies_enabled = [trophies_enabled] at z-level [current_turf.z] (trait check: [ZTRAIT_LAVA_RUINS in level?.traits])"
