/area/awaymission/caves/maintsroom
	name = "maintsroom"
	icon_state = "away2"
	requires_power = FALSE
	static_lighting = TRUE
	area_flags = NOTELEPORT
	area_flags_mapping = NONE

/area/awaymission/caves/maintsroom/deeper
	name = "deeper"
	icon_state = "away3"

/obj/machinery/door/puzzle/keycard/crowlie_keycard
	name = "ID locked Airlock"
	desc = "It looks like it requires a keycard."
	puzzle_id = "crowlie"

/obj/item/keycard/crowlie
	name = "keycard"
	desc = "A keycard. How terrific. Looks like it belongs to a ID locked Airlock."
	color = "#455357"
	puzzle_id = "crowlie"

/obj/machinery/door/puzzle/keycard/chamenos_keycard
	name = "keycard locked Airlock"
	desc = "It looks like it requires a keycard."
	puzzle_id = "chamenos"

/obj/item/keycard/chamenos
	name = "keycard"
	desc = "A keycard. How terrific. Looks like it belongs to a ID locked Airlock."
	color = "#09bbec"
	puzzle_id = "chamenos"
