/datum/controller/subsystem/machines
	/// If called /obj/machinery/tune_special_cases(), those who located in this areas will be tuned
	var/list/special_tune_whitelist_areas = list()

/// Checks if the machine is in a special area and applies special tuning if required
/obj/machinery/proc/tune_special_cases()
	var/area/target_area = get_area(src)
	if (!target_area)
		return

	// Interdyne/DS2
	if (!SSmachines.special_tune_whitelist_areas["interdyne_ds2"])
		SSmachines.special_tune_whitelist_areas["interdyne_ds2"] = typecacheof(list(
			/area/ruin/space/has_grav/interdyne,
			/area/shuttle/interdyne_cargo,
			/area/ruin/interdyne_planetary_base,
			/area/ruin/space/has_grav/nova/des_two))

	if(is_type_in_typecache(target_area.type, SSmachines.special_tune_whitelist_areas["interdyne_ds2"]))
		interdinify()
		return

	// Tarkon
	if (!SSmachines.special_tune_whitelist_areas["tarkon"])
		SSmachines.special_tune_whitelist_areas["tarkon"] = typecacheof(list(
			/area/ruin/space/has_grav/port_tarkon,
			/area/shuttle/tarkon_driver))

	if(is_type_in_typecache(target_area.type, SSmachines.special_tune_whitelist_areas["tarkon"]))
		tarkonize()
		return

// To avoid every machine checking their area, we call tuning only for those, who may benefit from it
// AAS
/obj/machinery/announcement_system/post_machine_initialize()
	. = ..()
	tune_special_cases()

// Cryosleep consoles
/obj/machinery/computer/cryopod/post_machine_initialize()
	. = ..()
	tune_special_cases()

// Stasis beds
/obj/machinery/stasis/post_machine_initialize()
	. = ..()
	tune_special_cases()

// Brig timers
/obj/machinery/status_display/door_timer/post_machine_initialize()
	. = ..()
	tune_special_cases()

// Posi alert
/obj/machinery/posialert/post_machine_initialize()
	. = ..()
	tune_special_cases()

// Cryo tubes
/obj/machinery/cryo_cell/post_machine_initialize()
	. = ..()
	tune_special_cases()
