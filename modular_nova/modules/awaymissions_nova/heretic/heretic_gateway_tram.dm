/obj/effect/landmark/transport/transport_id/heretic
	specific_transport_id = HERETIC_LINE_1

/obj/effect/landmark/transport/nav_beacon/tram/nav/heretic
	name = HERETIC_LINE_1
	specific_transport_id = TRAM_NAV_BEACONS

/obj/effect/landmark/transport/nav_beacon/tram/platform/heretic/left
	name = "Port"
	specific_transport_id = HERETIC_LINE_1
	platform_code = HERETIC_PORT
	tgui_icons = list("Reception" = "briefcase", "Botany" = "leaf", "Chemistry" = "flask")

/obj/effect/landmark/transport/nav_beacon/tram/platform/heretic/middle
	name = "Central"
	specific_transport_id = HERETIC_LINE_1
	platform_code = HERETIC_CENTRAL
	tgui_icons = list("Processing" = "cogs", "Xenobiology" = "paw")

/obj/effect/landmark/transport/nav_beacon/tram/platform/heretic/right
	name = "Starboard"
	specific_transport_id = HERETIC_LINE_1
	platform_code = HERETIC_STARBOARD
	tgui_icons = list("Ordnance" = "bullseye", "Office" = "user", "Dormitories" = "bed")

/obj/item/keycard/hereticgateway
	name = "Secure storage keycard"
	desc = "A keycard that simply states, 'only under exteme circumstances'."
	color = "#000000"
	puzzle_id = "heretic_gateway"

/obj/machinery/door/puzzle/keycard/hereticgateway
	name = "secure airlock"
	puzzle_id = "heretic_gateway"
