/obj/machinery/stasis
	name = "lifeform stasis unit MK-II"
	/// Controls wherever the stasis bed gives an announcement when someone is buckled to it or not.
	var/announce = FALSE

/obj/machinery/stasis/Initialize(mapload)
	. = ..()
	var/obj/item/circuitboard/machine/stasis/board = circuit
	if (board.fresh)
		var/area/my_area = get_area(src)
		if(my_area.type in GLOB.the_station_areas)
			announce = TRUE
			board.announce = TRUE
		board.fresh = FALSE
	else
		announce = board.announce

/obj/machinery/stasis/post_buckle_mob(mob/living/L)
	. = ..()
	if (announce)
		var/obj/machinery/announcement_system/system = pick(GLOB.announcement_systems)
		if (system)
			system.broadcast("Critical Patient [L.name] set in stasis at [get_area(src)]!", list(RADIO_CHANNEL_MEDICAL))

/obj/item/circuitboard/machine/stasis
	/// Controls wherever the stasis bed gives an announcement when someone is buckled to it or not.
	var/announce = FALSE
	/// Flag that tells wherever this is a freshly created board, in which case it will go with the z level logic, or if it was modified and thus needs to read the new logic.
	var/fresh = TRUE

/obj/item/circuitboard/machine/stasis/multitool_act(mob/living/user)
	. = ..()
	announce = !announce
	fresh = FALSE
	to_chat(user, span_notice("Medbay announcement set to [announce ? "Enabled" : "Disabled"]."))
