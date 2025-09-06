/obj/machinery/stasis
	name = "lifeform stasis unit MK-II"
	/// The radio channel used to send messages. May be overridden by away missions
	var/announcement_channel = RADIO_CHANNEL_MEDICAL

/obj/machinery/stasis/Initialize(mapload)
	. = ..()
	if (!mapload)
		return
	var/obj/item/circuitboard/machine/stasis/board = circuit
	if (board)
		var/area/my_area = get_area(src)
		if(my_area.type in GLOB.the_station_areas)
			board.announce_when_buckled = TRUE

/obj/machinery/stasis/post_buckle_mob(mob/living/buckled_mob)
	. = ..()
	var/obj/item/circuitboard/machine/stasis/board = circuit
	var/patient_status = (buckled_mob.maxHealth - buckled_mob.health) > 10 ? "Injured" : "Healthy"
	patient_status = buckled_mob.stat != CONSCIOUS ? "Critical" : patient_status
	if(board && board.announce_when_buckled)
		aas_config_announce(/datum/aas_config_entry/stasis_announcement, list(
			"PERSON" = buckled_mob.name,
			"AREA" = get_area_name(src),
		), src, list(announcement_channel), patient_status)

/obj/item/circuitboard/machine/stasis
	/// Controls wherever the stasis bed gives an announcement when someone is buckled to it or not.
	var/announce_when_buckled = FALSE

/obj/item/circuitboard/machine/stasis/multitool_act(mob/living/user)
	. = ..()
	announce_when_buckled = !announce_when_buckled
	to_chat(user, span_notice("Medbay announcement set to [announce_when_buckled ? "Enabled" : "Disabled"]."))

/obj/item/circuitboard/machine/stasis/examine(mob/user)
	. = ..()
	. += span_info("Patient announcement pin is now [announce_when_buckled ? "enabled" : "disabled"]. You can use a [EXAMINE_HINT("multitool")] to reconfigure it.")

/datum/aas_config_entry/stasis_announcement
	name = "Medical Alert: Stasis Announcement"
	// Empty line will be dropped, so by default we will not report nurse taking a nap on stasis bed.
	announcement_lines_map = list(
		"Healthy" = "",
		"Injured" = "%PERSON awaiting treatment in stasis at %AREA.",
		"Critical" = "Critical Patient %PERSON set in stasis at %AREA!",
	)
	vars_and_tooltips_map = list(
		"PERSON" = "will be replaced with their name.",
		"AREA" = "with their location."
	)
