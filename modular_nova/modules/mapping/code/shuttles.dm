/datum/map_template/shuttle/arrival/outpost
	suffix = "outpost"
	name = "arrival shuttle (Outpost)"

/datum/map_template/shuttle/emergency/outpost
	suffix = "outpost"
	prefix = "_maps/shuttles/nova/"
	name = "Outpoststation Emergency Shuttle"
	description = "The perfect shuttle for rectangle enthuasiasts, this long and slender shuttle has been known for it's incredible(Citation Needed) safety rating."
	admin_notes = "Has airlocks on both sides of the shuttle and will probably ram deltastation's maint wing below medical. Oh well?"
	credit_cost = CARGO_CRATE_VALUE * 4
	occupancy_limit = 45

/*----- Black Market Shuttle Datum + related code -----*/
/datum/map_template/shuttle/ruin/blackmarket_burst
	prefix = "_maps/shuttles/nova/"
	suffix = "blackmarket_burst"
	description = "A small cargo jump freighter, popular among smugglers who enjoy both the cargo space and speed"
	name = "Black Market Burst"

/obj/machinery/computer/shuttle/caravan/blackmarket_burst
	name = "Burst Shuttle Console"
	desc = "Used to control the affectionately named 'Burst'."
	circuit = /obj/item/circuitboard/computer/blackmarket_burst
	shuttleId = "blackmarket_burst"
	possible_destinations = "blackmarket_burst_custom;blackmarket_burst_home;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/blackmarket_burst
	name = "Burst Navigation Computer"
	desc = "Used to designate a precise transit location for the affectionately named 'Burst'."
	shuttleId = "blackmarket_burst"
	lock_override = NONE
	shuttlePortId = "blackmarket_burst_custom"
	jump_to_ports = list("blackmarket_burst_home" = 1, "whiteship_home" = 1)
	view_range = 0
	x_offset = 2
	y_offset = 0

/obj/item/circuitboard/computer/blackmarket_burst
	name = "Burst Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/caravan/blackmarket_burst

/obj/item/shuttle_remote/bmd
	name = "Burst Remote"
	shuttle_away_id = "whiteship_home"
	shuttle_home_id = "blackmarket_burst_home"

/*----- End of Black Market Shuttle Code -----*/

/*Interdyne Cargo Shuttle*/
/datum/map_template/shuttle/ruin/interdyne_cargo
	prefix = "_maps/shuttles/nova/"
	suffix = "interdyne_cargo"
	name = "Interdyne Cargo Shuttle"

/obj/machinery/computer/shuttle/interdyne_cargo
	name = "Interdyne Cargo Shuttle Console"
	desc = "Used to control the Interdyne cargo shuttle."
	circuit = /obj/item/circuitboard/computer/interdyne_cargo
	shuttleId = "interdyne_cargo"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	possible_destinations = "interdyne_cargo_home;interdyne_cargo_away;interdyne_cargo_custom;whiteship_home"

/obj/item/circuitboard/computer/interdyne_cargo
	name = "Interdyne Shuttle Control (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/interdyne_cargo

/obj/item/shuttle_remote/interdyne
	name = "Interdyne Cargo Shuttle Remote"
	shuttle_away_id = "interdyne_cargo_away"
	shuttle_home_id = "interdyne_cargo_home"

/*Interdyne Cargo Shuttle End*/

/datum/map_template/shuttle/prison_transport
	prefix = "_maps/shuttles/nova/"
	port_id = "prison_transport"
	suffix = "nova"
	name = "Prison Transporter NSS-74"


/obj/machinery/computer/camera_advanced/shuttle_docker/slaver
	name = "Ship Navigation Computer"
	desc = "Used to designate a precise custom destination to land."
	shuttleId = "slaver_syndie"
	lock_override = NONE
	shuttlePortId = "slaver"
	jump_to_ports = list("whiteship_away" = 1, "whiteship_home" = 1, "whiteship_z4" = 1, "syndicate_ne" = 1, "syndicate_nw" = 1, "syndicate_n" = 1, "syndicate_se" = 1, "syndicate_sw" = 1, "syndicate_s" = 1)
	view_range = 10
	x_offset = 0
	y_offset = 0
	designate_time = 30

/obj/machinery/computer/shuttle/slaver
	name = "Ship Travel Terminal"
	desc = "Controls for moving the ship to a pre-programmed destination or a custom one marked out by the navigation computer."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	shuttleId = "slaver_syndie"
	possible_destinations = "syndicate_ne;syndicate_nw;syndicate_n;syndicate_se;syndicate_sw;syndicate_s"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

// formerly NO_DECONSTRUCTION
/obj/machinery/computer/shuttle/slaver/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/computer/shuttle/slaver/default_deconstruction_crowbar(obj/item/crowbar, ignore_panel, custom_deconstruct)
	return NONE

/obj/machinery/computer/shuttle/slaver/default_pry_open(obj/item/crowbar, close_after_pry = FALSE, open_density = FALSE, closed_density = TRUE)
	return NONE

/datum/map_template/shuttle/slaver_ship
	port_id = "slaver ship"
	prefix = "_maps/shuttles/nova/"
	port_id = "slaver"
	suffix = "syndie"
	name = "Slaver Ship"
	who_can_purchase = null

/obj/effect/mob_spawn/ghost_role/human/guild
	name = "Privateer Slaver"
	prompt_name = "a privateer slaver"
	you_are_text = "You're here to capture valuable hostages to sell into slavery."
	flavour_text = "You're part of a privateer crew that sometimes takes contracts from the illusive Guild, which offers bounties and contracts to independent crews. Raiding colonies of the many less technologically advanced species in the area is much easier than this. You've been told that your mission is to capture as many valuable hostages from the station as possible. Your anonymous employer insists on the importance of humiliating SolFed by snatching those under their protection from right under their noses."
	important_text = ""

/obj/effect/mob_spawn/ghost_role/human/guild/slaver
	name = "Privateer Slaver"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/guild/slaver

/obj/effect/mob_spawn/ghost_role/human/guild/slaver/captain
	name = "Privateer Slaver Captain"
	you_are_text = "You lead a small team focused on capturing hostages."
	flavour_text = "You're the captain of a privateer crew that sometimes takes contracts from the illusive Guild, which offers bounties and contracts to independent crews, like yours! Lead your crew to infiltrate the station and capture hostages and hold them till the station's emergency shuttle leaves. The higher ranking the hostages, the more you'll get paid out. You're free to (and encouraged to) beat and humiliate, but not kill. Your anonymous employer wants your victims as their personel slaves. They mentioned something about propaganda? Ah, who knows with the Guild... All sorts of types posts these bounties."
	important_text = "You are expected to roleplay heavily and lead effectively in this role."
	outfit = /datum/outfit/guild/slaver/captain

/obj/item/radio/headset/guild
	keyslot = new /obj/item/encryptionkey/headset_syndicate/guild

/obj/item/radio/headset/guild/command
	command = TRUE

/datum/outfit/guild
	name = "Guild Default Outfit"

/datum/outfit/guild/slaver
	name = "Privateer Slaver"
	head = /obj/item/clothing/head/helmet/alt
	suit = /obj/item/clothing/suit/armor/bulletproof
	uniform = /obj/item/clothing/under/syndicate/combat
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/guild
	glasses = /obj/item/clothing/glasses/hud/security/chameleon
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	belt = /obj/item/storage/belt/military
	r_pocket = /obj/item/storage/pouch/ammo
	l_pocket = /obj/item/gun/energy/e_gun/mini
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	skillchips = list(/obj/item/skillchip/job/engineer)
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/radio,
		/obj/item/melee/baton/telescopic,
		/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/wespe,
		/obj/item/grenade/c4,
		/obj/item/grenade/smokebomb
	)

/datum/outfit/guild/slaver/captain
	name = "Privateer Slaver Captain"
	head = /obj/item/clothing/head/helmet/alt
	suit = /obj/item/clothing/suit/armor/bulletproof
	uniform = /obj/item/clothing/under/syndicate/combat
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/guild/command
	glasses = /obj/item/clothing/glasses/thermal/syndi
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	belt = /obj/item/storage/belt/military
	r_pocket = /obj/item/storage/pouch/ammo
	l_pocket = /obj/item/gun/energy/e_gun/mini
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	skillchips = list(/obj/item/skillchip/job/engineer)
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/radio,
		/obj/item/melee/baton/telescopic,
		/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/skild,
		/obj/item/megaphone/command,
	)

/*----- Tarkon Shuttle Datum + related code -----*/
/datum/map_template/shuttle/ruin/tarkon_driver
	prefix = "_maps/shuttles/nova/"
	suffix = "tarkon_driver"
	name = "Tarkon Drill Driver"

/obj/machinery/computer/shuttle/tarkon_driver
	name = "Tarkon Driver Control"
	desc = "Used to control the Tarkon Driver."
	circuit = /obj/item/circuitboard/computer/tarkon_driver
	shuttleId = "tarkon_driver"
	possible_destinations = "tarkon_driver_custom;port_tarkon;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/tarkon_driver
	name = "Tarkon Driver Navigation Computer"
	desc = "The Navigation console for the Tarkon Driver. A broken \"Engage Drill\" button seems to dimly blink in a yellow colour"
	shuttleId = "tarkon_driver"
	lock_override = NONE
	shuttlePortId = "tarkon_driver_custom"
	jump_to_ports = list("port_tarkon" = 1, "whiteship_home" = 1)
	view_range = 0

/obj/item/circuitboard/computer/tarkon_driver
	name = "Tarkon Driver Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/tarkon_driver

/obj/item/shuttle_remote/tarkon
	name = "Tarkon Driver Remote"
	shuttle_away_id = "whiteship_home"
	shuttle_home_id = "port_tarkon"

/*----- End of Tarkon Shuttle Code -----*/

/*----- SerenityStation Shuttle Code -----*/
/datum/map_template/shuttle/planetary
	port_id = "planetary"
	who_can_purchase = null

/datum/map_template/shuttle/planetary/planetary_ferry
	prefix = "_maps/shuttles/nova/"
	suffix = "planetary_ferry"
	name = "Planetary Ferry"

/obj/machinery/computer/shuttle/planetary_ferry
	name = "Planetary Ferry Console"
	desc = "Used to control the ferry off-planet."
	circuit = /obj/item/circuitboard/computer/planetary_ferry
	shuttleId = "planetary_ferry"
	possible_destinations = "planetary_dock;orbital_dock"

/obj/item/circuitboard/computer/planetary_ferry
	name = "Planetary Ferry Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/planetary_ferry

/*----- End of SerenityStation Shuttle Code -----*/

/*----- SOLFED VESSEL Shuttle Code -----*/
/datum/map_template/shuttle/ert/solfed
	prefix = "_maps/shuttles/nova/"
	suffix = "solfed_general_shuttle"
	name = "EAS(I)-6224 Transport Shuttle"

/obj/machinery/computer/shuttle/solfed
	name = "\improper EAS(I)-6224 control console"
	desc = "Used to control the EAS(I)-6224."
	circuit = /obj/item/circuitboard/computer/solfed
	shuttleId = "solfed_general_shuttle"
	possible_destinations = "solfed_general_custom;solfed_general_home;whiteship_home;syndicate_nw"
	req_access = list(ACCESS_CENT_GENERAL)

/obj/machinery/computer/camera_advanced/shuttle_docker/solfed
	name = "\improper EAS(I)-6224 navigation computer"
	desc = "The navigation console for the EAS(I)-6224."
	shuttleId = "solfed_general_shuttle"
	lock_override = CAMERA_LOCK_STATION
	shuttlePortId = "solfed_general_custom"
	jump_to_ports = list( "whiteship_home" = 1, "syndicate_nw" = 1, )
	view_range = 12
	zlink_range = 1
	move_up_action = /datum/action/innate/camera_multiz_up
	move_down_action = /datum/action/innate/camera_multiz_down

/obj/item/circuitboard/computer/solfed
	name = "EAS(I)-6224 Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/solfed

/obj/item/gps/computer/space/solfed
	name = "\improper SolFed GPS transponder"
	icon = 'modular_nova/modules/mapping/icons/machinery/gps_computer_x32.dmi'	//needs its own file for pixel size ;-;
	gpstag = "*SF - EAS(I)-6224"
	pixel_y = 0

/*----- End of SOLFED VESSEL Shuttle Code -----*/

/*----- SOLFED INFANTRY VESSEL Shuttle Code -----*/
/datum/map_template/shuttle/ert/solfed/armory
	prefix = "_maps/shuttles/nova/"
	suffix = "solfed_armory_shuttle"
	name = "EAS(I)-2271 Transport Shuttle"

/obj/machinery/computer/shuttle/solfed/armory
	name = "\improper EAS(I)-2271 control console"
	desc = "Used to control the EAS(I)-2271."
	circuit = /obj/item/circuitboard/computer/solfed/armory
	shuttleId = "solfed_armory_shuttle"
	possible_destinations = "solfed_armory_custom;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/solfed/armory
	name = "\improper EAS(I)-2271 navigation computer"
	desc = "The navigation console for the EAS(I)-2271."
	shuttleId = "solfed_armory_shuttle"
	shuttlePortId = "solfed_armory_custom"

/obj/item/circuitboard/computer/solfed/armory
	name = "EAS(I)-2271 Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/solfed/armory

/obj/item/gps/computer/space/solfed/armory
	gpstag = "*SF - EAS(I)-2271"
/*----- End of SOLFED INFANTRY VESSEL Shuttle Code -----*/

/*----- SOLFED HOSPITAL VESSEL Shuttle Code -----*/
/datum/map_template/shuttle/ert/solfed/medical
	prefix = "_maps/shuttles/nova/"
	suffix = "solfed_medical_shuttle"
	name = "EAS(H)-1457 Medical Transport Shuttle"

/obj/machinery/computer/shuttle/solfed/medical
	name = "\improper EAS(H)-1457 control console"
	desc = "Used to control the EAS(H)-1457."
	circuit = /obj/item/circuitboard/computer/solfed/medical
	shuttleId = "solfed_medical_shuttle"
	possible_destinations = "solfed_medical_shuttle_custom;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/solfed/medical
	name = "\improper EAS(H)-1457 navigation computer"
	desc = "The navigation console for the EAS(H)-1457."
	shuttleId = "solfed_medical_shuttle"
	shuttlePortId = "solfed_medical_shuttle_custom"

/obj/item/circuitboard/computer/solfed/medical
	name = "EAS(H)-1457 Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/solfed/medical

/obj/item/gps/computer/space/solfed/medical
	gpstag = "*SF - EAS(H)-1457"
/*----- End of SOLFED HOSPITAL VESSEL Shuttle Code -----*/

/*----- SOLFED HOSPITAL ASSAULT Shuttle Code -----*/
/datum/map_template/shuttle/ert/solfed/assault
	prefix = "_maps/shuttles/nova/"
	suffix = "solfed_assault_shuttle"
	name = "EAS(L)-9921 Assault Transport Shuttle"

/obj/machinery/computer/shuttle/solfed/assault
	name = "\improper EAS(L)-9921 control console"
	desc = "Used to control the EAS(L)-9921."
	circuit = /obj/item/circuitboard/computer/solfed/assault
	shuttleId = "solfed_assault_shuttle"
	possible_destinations = "solfed_assault_shuttle_custom;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/solfed/assault
	name = "\improper EAS(L)-9921 navigation computer"
	desc = "The navigation console for the EAS(L)-9921."
	shuttleId = "solfed_assault_shuttle"
	shuttlePortId = "solfed_assault_shuttle_custom"

/obj/item/circuitboard/computer/solfed/assault
	name = "EAS(L)-9921 Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/solfed/assault

/obj/item/gps/computer/space/solfed/assault
	gpstag = "*SF - EAS(L)-9921"
/*----- End of SOLFED ASSAULT VESSEL Shuttle Code -----*/

/*----- SOLFED OFFICIALS VESSEL Shuttle Code -----*/
/datum/map_template/shuttle/ert/solfed/official
	prefix = "_maps/shuttles/nova/"
	suffix = "solfed_official_shuttle"
	name = "SFTS-3329 Transport Shuttle"

/obj/machinery/computer/shuttle/solfed/official
	name = "\improper SFTS-3329 control console"
	desc = "Used to control the SFTS-3329."
	circuit = /obj/item/circuitboard/computer/solfed/official
	shuttleId = "solfed_official_shuttle"
	possible_destinations = "solfed_official_custom;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/solfed/official
	name = "\improper SFTS-3329 navigation computer"
	desc = "The navigation console for the SFTS-3329."
	shuttleId = "solfed_official_shuttle"
	shuttlePortId = "solfed_official_custom"

/obj/item/circuitboard/computer/solfed/official
	name = "SFTS-3329 Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/solfed/official

/obj/item/gps/computer/space/solfed/official
	gpstag = "*SF - SFTS-3329"
/*----- End of OFFICIALS HOSPITAL VESSEL Shuttle Code -----*/

/*----- SOLFED FANCY VESSEL Shuttle Code -----*/
/datum/map_template/shuttle/ert/solfed/fancy
	prefix = "_maps/shuttles/nova/"
	suffix = "solfed_fancy_shuttle"
	name = "SFTS-1221 Transport Shuttle."

/obj/machinery/computer/shuttle/solfed/fancy
	name = "\improper SFTS-1221 control console"
	desc = "Used to control the SFTS-1221."
	circuit = /obj/item/circuitboard/computer/solfed/fancy
	shuttleId = "solfed_fancy_shuttle"
	possible_destinations = "solfed_fancy_shuttle_custom;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/solfed/fancy
	name = "\improper SFTS-1221 navigation computer"
	desc = "The navigation console for the SFTS-1221."
	shuttleId = "solfed_fancy_shuttle"
	shuttlePortId = "solfed_fancy_shuttle_custom"

/obj/item/circuitboard/computer/solfed/fancy
	name = "SFTS-1221 Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/solfed/fancy

/obj/item/gps/computer/space/solfed/fancy
	gpstag = "*SF - SFTS-1221"
/*----- End of FANCY VESSEL Shuttle Code -----*/

/*----- SOLFED ENGINEERING VESSEL Shuttle Code -----*/
/datum/map_template/shuttle/ert/solfed/engineer
	prefix = "_maps/shuttles/nova/"
	suffix = "solfed_engineer_shuttle"
	name = "EAS(E)-3921 Transport Shuttle."

/obj/machinery/computer/shuttle/solfed/engineer
	name = "\improper EAS(E)-3921 control console"
	desc = "Used to control the EAS(E)-3921"
	circuit = /obj/item/circuitboard/computer/solfed/engineer
	shuttleId = "solfed_engineer_shuttle"
	possible_destinations = "solfed_engineer_shuttle_custom;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/solfed/engineer
	name = "\improper EAS(E)-3921 navigation computer"
	desc = "The navigation console for the EAS(E)-3921."
	shuttleId = "solfed_engineer_shuttle"
	shuttlePortId = "solfed_engineer_shuttle_custom"

/obj/item/circuitboard/computer/solfed/engineer
	name = "EAS(E)-3921 Driver Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/solfed/engineer

/obj/item/gps/computer/space/solfed/engineer
	gpstag = "*SF - EAS(E)-3921"
/*----- End of ENGINEERING VESSEL Shuttle Code -----*/
