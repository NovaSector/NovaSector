// Modular kinetic crusher zone restrictions
/obj/item/kinetic_crusher
	var/trophies_enabled = FALSE
	var/previous_trophies_enabled = FALSE

/obj/item/kinetic_crusher/Initialize(mapload)
	. = ..()
	update_trophies_enabled()
	// Listen for z-level changes only
	RegisterSignal(src, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_z_level_change))
	// Also register for when we're picked up/dropped to catch container movement
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equipment_change))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_equipment_change))

/obj/item/kinetic_crusher/proc/on_z_level_change(datum/source, turf/old_turf, turf/new_turf)
	SIGNAL_HANDLER
	update_trophies_enabled()

/obj/item/kinetic_crusher/proc/on_equipment_change(datum/source)
	SIGNAL_HANDLER
	// When we're equipped/dropped, we might need to listen to our new container's movement
	var/atom/holder = loc
	if(ismob(holder))
		// Register to the mob's z-level changes
		RegisterSignal(holder, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_container_z_change), TRUE)
	else
		// Clean up any old mob signals
		UnregisterSignal(src, COMSIG_MOVABLE_Z_CHANGED)

/obj/item/kinetic_crusher/proc/on_container_z_change(datum/source, turf/old_turf, turf/new_turf)
	SIGNAL_HANDLER
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
