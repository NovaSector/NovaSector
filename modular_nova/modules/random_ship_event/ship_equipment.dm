//Shuttle equipment for random ship events

/obj/machinery/computer/shuttle/random_ship
	name = "ship shuttle console"
	shuttleId = "random_ship"
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	light_color = COLOR_FRENCH_BLUE
	possible_destinations = "random_ship_away;random_ship_home;random_ship_custom"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/random_ship
	name = "ship navigation computer"
	desc = "Used to designate a precise transit location for the ship."
	shuttleId = "random_ship"
	lock_override = CAMERA_LOCK_STATION
	shuttlePortId = "random_ship_custom"
	x_offset = 9
	y_offset = 0
	see_hidden = FALSE

/obj/docking_port/mobile/random_ship
	name = "random ship"
	shuttle_id = "random_ship"
	rechargeTime = 3 MINUTES
