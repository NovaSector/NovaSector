// Interdyne/DS2
/// Any special changes/tuning on the Interdyne map for a particular machine can be applied by implementing this proc. If adding a new type of machine, you must also call tune_special_cases() in post_machine_initialize()
/obj/machinery/proc/interdinify()

// AAS
/obj/machinery/announcement_system/interdinify()
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)
	radio_type = /obj/item/radio/headset/interdyne/command
	QDEL_NULL(radio)
	radio = new radio_type(src)
	// Tweaking defaults a bit (requires TGcode tweaks to take effect, will be done for upstream)
	var/datum/aas_config_entry/config = locate(/datum/aas_config_entry/newhead) in config_entries
	if (config)
		config.announcement_lines_map = list("Message" = "%PERSON, %RANK is the representative of the command at the installation.")

// Cryosleep consoles
/obj/machinery/computer/cryopod/interdinify()
	announcement_channel = RADIO_CHANNEL_INTERDYNE
	req_one_access = list(ACCESS_SYNDICATE_LEADER)

// Stasis beds
/obj/machinery/stasis/interdinify()
	announcement_channel = RADIO_CHANNEL_INTERDYNE

// Brig timers
/obj/machinery/status_display/door_timer/interdinify()
	req_access = list(ACCESS_SYNDICATE)
	broadcast_channel = RADIO_CHANNEL_INTERDYNE

// Posi alert
/obj/machinery/posialert/interdinify()
	announcement_channel = RADIO_CHANNEL_INTERDYNE

// Cryo tubes
/obj/machinery/cryo_cell/interdinify()
	broadcast_channel = RADIO_CHANNEL_INTERDYNE
