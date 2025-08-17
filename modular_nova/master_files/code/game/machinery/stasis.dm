/obj/machinery/stasis
	name = "lifeform stasis unit MK-II"

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
	if(board && board.announce_when_buckled)
		var/obj/machinery/announcement_system/system = pick(GLOB.announcement_systems)
		if (system)
			system.broadcast("Critical Patient [buckled_mob.name] set in stasis at [get_area(src)]!", list(RADIO_CHANNEL_MEDICAL))

/obj/item/circuitboard/machine/stasis
	/// Controls wherever the stasis bed gives an announcement when someone is buckled to it or not.
	var/announce_when_buckled = FALSE

/obj/item/circuitboard/machine/stasis/multitool_act(mob/living/user)
	. = ..()
	announce_when_buckled = !announce_when_buckled
	to_chat(user, span_notice("Medbay announcement set to [announce_when_buckled ? "Enabled" : "Disabled"]."))
