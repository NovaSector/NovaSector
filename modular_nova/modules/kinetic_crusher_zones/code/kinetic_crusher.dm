// Modular kinetic crusher zone restrictions
/obj/item/kinetic_crusher
	var/trophies_enabled = FALSE
	var/previous_trophies_enabled = FALSE
	var/previous_environment_type = null

/obj/item/kinetic_crusher/Initialize(mapload)
	. = ..()
	update_trophies_enabled()
	RegisterSignal(src, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_z_level_change))

/obj/item/kinetic_crusher/proc/on_z_level_change(datum/source, turf/old_turf, turf/new_turf)
	SIGNAL_HANDLER
	update_trophies_enabled(new_turf)

/obj/item/kinetic_crusher/proc/update_trophies_enabled(turf/new_turf)
	previous_trophies_enabled = trophies_enabled
	var/previous_env = previous_environment_type

	var/turf/current_turf = new_turf
	if(!current_turf)
		trophies_enabled = FALSE
		previous_environment_type = null
		return

	// Check if the current z-level has lava or ice underground traits
	trophies_enabled = FALSE
	var/active_environment_type = null

	if (SSmapping.level_trait(current_turf.z, ZTRAIT_ICE_RUINS_UNDERGROUND))
		trophies_enabled = TRUE
		active_environment_type = "ice_underground"
	else if (SSmapping.level_trait(current_turf.z, ZTRAIT_LAVA_RUINS))
		trophies_enabled = TRUE
		active_environment_type = "lava"

	// Update the stored environment type
	previous_environment_type = active_environment_type

	// Only show messages if the state actually changed
	if(trophies_enabled == previous_trophies_enabled)
		return

	var/atom/holder = loc
	if(!ismob(holder))
		return

	var/state = trophies_enabled ? "active" : "inactive"
	balloon_alert(holder, "trophies [state]")

	// Check if any fauna trophies are attached
	var/has_fauna_trophy = FALSE
	for(var/obj/item/crusher_trophy/trophy in trophies)
		if(trophy.fauna_trophy)
			has_fauna_trophy = TRUE
			break

	if(!has_fauna_trophy)
		return

	if(trophies_enabled)
		switch(active_environment_type)
			if("lava")
				to_chat(holder, span_notice("The hostile resonance of Indecipheres feeds power through your crusher and its trophies."))
			if("ice_underground")
				to_chat(holder, span_notice("The corruption of Freyja runs deeper in the caves, its resonance flowing through your crusher and its trophies."))
	else
		switch(previous_env)
			if("lava")
				to_chat(holder, span_warning("The resonance fades from your crusher's trophies as you leave the atmosphere of Indecipheres behind."))
			if("ice_underground")
				to_chat(holder, span_warning("The deep corruption fades from your crusher's trophies as you ascend from the frozen depths of Freyja."))

	// Debug output
	world.log << "[src.name] trophies_enabled = [trophies_enabled] at z-level [current_turf.z] (env: [active_environment_type || "none"])"
