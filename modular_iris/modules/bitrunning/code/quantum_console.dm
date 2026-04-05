/obj/machinery/computer/quantum_console/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, rmb_text = "Initialize random bitrunning domain")

/obj/machinery/computer/quantum_console/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	var/obj/machinery/quantum_server/server = find_server()
	if(isnull(server))
		return

	server.cold_boot_map(server.get_random_domain_id())
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
