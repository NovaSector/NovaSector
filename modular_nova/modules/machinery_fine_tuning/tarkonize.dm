// Tarkon
/// Any special changes/tuning on the Tarkon map for a particular machine can be applied by implementing this proc. If adding a new type of machine, you must also call tune_special_cases() in post_machine_initialize()
/obj/machinery/proc/tarkonize()

// AAS
/obj/machinery/announcement_system/tarkonize()
	AddElement(/datum/element/manufacturer_examine, "It has <b>[span_brown("Tarkon Industries")]</b> logo on it.")
	radio_type = /obj/item/radio/headset/tarkon/command
	QDEL_NULL(radio)
	radio = new radio_type(src)
	// Tweaking defaults a bit (requires TGcode tweaks to take effect, will be done for upstream)
	var/datum/aas_config_entry/config = locate(/datum/aas_config_entry/newhead) in config_entries
	if (config)
		config.announcement_lines_map = list("Message" = "%PERSON, %RANK now represents Tarkon interests on this facility.")

// Cryosleep consoles
/obj/machinery/computer/cryopod/tarkonize()
	announcement_channel = RADIO_CHANNEL_TARKON
	req_one_access = list(ACCESS_TARKON)

// Stasis beds
/obj/machinery/stasis/tarkonize()
	announcement_channel = RADIO_CHANNEL_TARKON

// Brig timers
/obj/machinery/status_display/door_timer/tarkonize()
	req_access = list(ACCESS_TARKON)
	broadcast_channel = RADIO_CHANNEL_TARKON

// Posi alert
/obj/machinery/posialert/tarkonize()
	announcement_channel = RADIO_CHANNEL_TARKON

// Cryo tubes
/obj/machinery/cryo_cell/tarkonize()
	broadcast_channel = RADIO_CHANNEL_TARKON
