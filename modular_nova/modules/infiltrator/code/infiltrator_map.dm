//voucher redeemers
/obj/machinery/computer/voucher_redeemer

/obj/machinery/computer/voucher_redeemer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/voucher_redeemer, /obj/item/paper/paperslip/corporate/syndicate, /datum/voucher_set/traitor)

//shuttle
/datum/map_template/shuttle/traitor
	port_id = "traitor"
	prefix = "_maps/shuttles/nova/"
	who_can_purchase = null

/datum/map_template/shuttle/traitor/default
	suffix = "default"
	name = "traitor shuttle (Default)"
	has_ceiling = TRUE
	ceiling_turf = /turf/open/floor/plating/reinforced

//nav computers
/obj/machinery/computer/shuttle/traitor
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	shuttleId = "traitor"
	possible_destinations = "whiteship_home;traitor_home;traitor_custom"
	may_be_remote_controlled = TRUE

/obj/machinery/computer/camera_advanced/shuttle_docker/traitor
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "traitor"
	shuttlePortId = "traitor_custom"
	jump_to_ports = list("whiteship_home" = 1, "traitor_home" = 1, "traitor_custom" = 1)
	see_hidden = FALSE
	lock_override = CAMERA_LOCK_STATION
	view_range = 4

//shuttle remote
/obj/item/shuttle_remote/traitor
	icon_state = "nukietalkie"
	shuttle_away_id = "traitor_home"

//mobile docking port
/obj/docking_port/mobile/traitor
	name = "infiltrator shuttle"
	callTime = 10 SECONDS
	ignitionTime = 5 SECONDS
	rechargeTime = 30 SECONDS
	shuttle_id = "traitor"
	movement_force = list("KNOCKDOWN"=3,"THROW"=0)

//area
/area/shuttle/traitor
	requires_power = TRUE
	name = "Infiltrator Ship"
	flags_1 = NONE


//map
/datum/lazy_template/midround_traitor
	key = LAZY_TEMPLATE_KEY_MIDROUND_TRAITOR
	map_dir = "_maps/nova/lazy_templates"
	map_name = "midround_traitor"

//stationary docking port
/obj/docking_port/stationary/traitor
	name = "Launchpad no. 09"
	shuttle_id = "traitor"
	delete_after = TRUE
	hidden = TRUE
	width = 9
	height = 5
	dwidth = 4
	dheight = 0

//map spawn landmark
/obj/effect/landmark/start/midround_traitor/Initialize(mapload)
	..()
	GLOB.traitor_start += loc
	return INITIALIZE_HINT_QDEL

//areas
/area/misc/syndicate_armoury
	name = "Syndicate Armoury"
	area_flags = NOTELEPORT | HIDDEN_AREA
	default_gravity = STANDARD_GRAVITY
	requires_power = FALSE
	ambient_buzz = null
	sound_environment = SOUND_ENVIRONMENT_AUDITORIUM
