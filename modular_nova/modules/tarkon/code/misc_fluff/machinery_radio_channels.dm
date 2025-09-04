#define AFFECTED_MACHINES list(\
	/obj/machinery/announcement_system, \
	/obj/machinery/stasis, \
	/obj/machinery/status_display/door_timer, \
	/obj/machinery/posialert, \
	/obj/machinery/cryo_cell)

// Need to hook up listener to literaly something
/area/ruin/space/has_grav/port_tarkon/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_NEW_MACHINE, GLOBAL_PROC_REF(tarkonize_machine))

/area/ruin/space/has_grav/port_tarkon/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_NEW_MACHINE)
	. = ..()

/proc/tarkonize_machine(source, obj/machinery/target)
	SIGNAL_HANDLER

	// I thought type lookup should be faster, especially because ALL machines bump here.
	if (!(target.type in AFFECTED_MACHINES))
		return

	// Make sure we are on tarkon base or shuttle.
	var/area/target_area = get_area(target)
	if (!target_area || !(target_area.type in typesof(
			/area/ruin/space/has_grav/port_tarkon,
			/area/shuttle/tarkon_driver)))
		return

	// AAS
	if (istype(target, /obj/machinery/announcement_system))
		var/obj/machinery/announcement_system/announcement_system = target
		announcement_system.AddElement(/datum/element/manufacturer_examine, "It has <b>[span_brown("Tarkon Industries")]</b> logo on it.")
		announcement_system.radio_type = /obj/item/radio/headset/tarkon/command
		// Tweaking defaults a bit
		var/datum/aas_config_entry/config = locate(/datum/aas_config_entry/newhead) in announcement_system.config_entries
		if (config)
			config.announcement_lines_map = list("Message" = "%PERSON, %RANK now represents Tarkon interests on this facility.")

	// Stasis beds
	else if (istype(target, /obj/machinery/stasis))
		var/obj/machinery/stasis/stasis = target
		stasis.announcement_channel = RADIO_CHANNEL_TARKON
	// Brig timers
	else if (istype(target, /obj/machinery/status_display/door_timer))
		var/obj/machinery/status_display/door_timer/door_timer = target
		door_timer.req_access = list(ACCESS_TARKON)
		door_timer.broadcast_channel = RADIO_CHANNEL_TARKON
	// Posi alert
	else if (istype(target, /obj/machinery/posialert))
		var/obj/machinery/posialert/posialert = target
		posialert.announcement_channel = RADIO_CHANNEL_TARKON
	// Cryo tubes
	else if (istype(target, /obj/machinery/cryo_cell))
		var/obj/machinery/cryo_cell/cryo = target
		cryo.broadcast_channel = RADIO_CHANNEL_TARKON

#undef AFFECTED_MACHINES
