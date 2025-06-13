//voucher redeemers
/obj/machinery/computer/voucher_redeemer

/obj/machinery/computer/voucher_redeemer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/voucher_redeemer, /obj/item/paper/paperslip/corporate/syndicate, /datum/voucher_set/lone_infil)

//shuttle
/datum/map_template/shuttle/lone_infil
	port_id = "lone_infil"
	prefix = "_maps/shuttles/nova/"
	who_can_purchase = null

/datum/map_template/shuttle/lone_infil/default
	suffix = "default"
	name = "infiltrator shuttle (Default)"

/obj/machinery/computer/shuttle/lone_infil
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	shuttleId = "lone_infil"
	possible_destinations = "whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/lone_infil
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "lone_infil"
	shuttlePortId = "lone_infil_start"
	jump_to_ports = list("whiteship_home" = 1)
	see_hidden = FALSE
	lock_override = CAMERA_LOCK_STATION
	view_range = 4
	x_offset = -2

/obj/docking_port/mobile/lone_infil
	name = "infiltrator shuttle"
	callTime = 10 SECONDS
	ignitionTime = 5 SECONDS
	rechargeTime = 30 SECONDS
	shuttle_id = "lone_infil"
	movement_force = list("KNOCKDOWN"=3,"THROW"=0)
	preferred_direction = EAST
	port_direction = SOUTH

/area/shuttle/lone_infil
	requires_power = TRUE
	name = "Infiltrator Ship"
	flags_1 = NONE

//map
/datum/lazy_template/infiltrator_memory
	key = LAZY_TEMPLATE_KEY_INFIL_MEMORY
	map_dir = "_maps/nova/lazy_templates"
	map_name = "infiltrator_memory"

//map spawn landmark
/obj/effect/landmark/start/lone_infil/Initialize(mapload)
	..()
	GLOB.lone_infil_start += loc
	return INITIALIZE_HINT_QDEL

//areas
/area/infiltrator_memory
	name = "Virtual Memory"
	default_gravity = STANDARD_GRAVITY
	area_flags = NOTELEPORT
	sound_environment = SOUND_ENVIRONMENT_AUDITORIUM
	requires_power = FALSE

/area/infiltrator_memory/landing_pad
	name = "Virtual Memory"
	requires_power = TRUE
