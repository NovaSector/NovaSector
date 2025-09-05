/datum/controller/subsystem/machines
	var/list/special_tune_whitelist_areas = list()

/obj/machinery/proc/tune_special_cases()
	var/area/target_area = get_area(src)
	if (!target_area)
		return

	// Interdyne/DS2
	if (!SSmachines.special_tune_whitelist_areas["interdyne_ds2"])
		SSmachines.special_tune_whitelist_areas["interdyne_ds2"] = typecacheof(list(
			/area/ruin/space/has_grav/interdyne,
			/area/shuttle/interdyne_cargo,
			/area/ruin/syndicate_lava_base,
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
