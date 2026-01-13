/datum/map_template/shuttle/random_ship/hc_police
	suffix = "hc_police"
	name = "random ship (HC Carrier)"

/datum/map_template/shuttle/random_ship/hc_ferry
	suffix = "hc_police_subshuttle"
	name = "random subship (HC Ferry)"

/area/shuttle/hc_cops
	name = "HC Carrier"
	forced_ambience = TRUE
	requires_power = TRUE
	ambient_buzz = 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_radio.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_small_09.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_loop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_start.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_stop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/intercom_loop.ogg')

/area/shuttle/hc_cops/engineering
	name = "HC Carrier Reactor Room"
	icon_state = "engie"

/area/shuttle/hc_cops/ready_room
	name = "HC Carrier Ready Room"
	icon_state = "security_sub"

/area/shuttle/hc_cops/cargo_hold
	name = "HC Carrier Cargo Hold"
	icon_state = "cargo_bay"

/area/shuttle/hc_cops/infirmary
	name = "HC Carrier Infirmary"
	icon_state = "med_central"

/area/shuttle/hc_cops/recreation
	name = "HC Carrier Recreation"
	icon_state = "rec"

/area/shuttle/hc_cops/armory
	name = "HC Carrier Armory"
	icon_state = "security"

/area/shuttle/hc_cops/command
	name = "HC Carrier Bridge"
	icon_state = "command"

/area/shuttle/hc_cops/dock
	name = "HC Carrier Docking Area"
	icon_state = "podbay"

/area/shuttle/hc_cops/ferry
	name = "HC Ferry"
	requires_power = FALSE

/obj/docking_port/stationary/movable/hc_carrier
	name = "HC ACV 'Harrier Du Bois' dock" //harrier the carrier haaaaa
	shuttle_id = "hc_carrier_dock"
	roundstart_template = /datum/map_template/shuttle/random_ship/hc_ferry
	width = 14
	height = 7
	dwidth = 0
	dheight = 7

/obj/docking_port/mobile/hc_carrier
	name = "HC ACV 'Harrier Du Bois'"
	shuttle_id = "hc_carrier"
	initial_engine_power = 6
	port_direction = EAST
	preferred_direction = EAST
	callTime = 2 MINUTES
	rechargeTime = 12 MINUTES
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	can_move_docking_ports = TRUE
	takeoff_sound = sound('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/engine_ignit_int.ogg')
	landing_sound = sound('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/env_ship_down.ogg')

/obj/docking_port/mobile/hc_ferry
	name = "HC IPV 'Tequilla Sunset'"
	shuttle_id = "hc_ferry"
	movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)
	dir = EAST
	port_direction = WEST
	takeoff_sound = sound('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/engine_ignit_int.ogg')
	landing_sound = sound('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/env_ship_down.ogg')

/obj/machinery/computer/shuttle/hc
	name = "police shuttle console"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED

/obj/machinery/computer/shuttle/hc/carrier
	shuttleId = "hc_carrier"
	possible_destinations = "hc_carrier_custom"

/obj/machinery/computer/shuttle/hc/ferry
	shuttleId = "hc_ferry"
	possible_destinations = "hc_carrier_dock;hc_ferry_custom"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/hc
	name = "police shuttle navigation computer"
	desc = "Used to designate a precise transit location for the police shuttle."
	lock_override = CAMERA_LOCK_STATION
	view_range = 5.5
	x_offset = -3
	y_offset = -7
	whitelist_turfs = list(/turf/open/space, /turf/open/floor/plating, /turf/open/lava, /turf/closed/mineral, /turf/open/openspace, /turf/open/misc)

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/hc/carrier
	shuttleId = "hc_carrier"
	shuttlePortId = "hc_carrier_custom"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/hc/ferry
	shuttleId = "hc_ferry"
	shuttlePortId = "hc_ferry_custom"

/obj/machinery/porta_turret/syndicate/hc_police
	name = "anti-projectile turret"
	desc = "An automatic defense turret designed for point-defense, it's probably not that wise to try approaching it."
	scan_range = 9
	shot_delay = 15
	faction = list(FACTION_NEUTRAL)
	icon = 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/icons/turrets.dmi'
	icon_state = "gun_turret"
	base_icon_state = "gun_turret"
	max_integrity = 250
	stun_projectile = /obj/projectile/bullet/ciws
	lethal_projectile = /obj/projectile/bullet/ciws
	lethal_projectile_sound = 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/shell_out_tiny.ogg'
	stun_projectile_sound = 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/shell_out_tiny.ogg'

/obj/machinery/porta_turret/syndicate/hc_police/target(atom/movable/target)
	if(target)
		setDir(get_dir(base, target))//even if you can't shoot, follow the target
		shootAt(target)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay, TIMER_STOPPABLE | TIMER_DELETE_ME)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay * 2, TIMER_STOPPABLE | TIMER_DELETE_ME)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay * 3, TIMER_STOPPABLE | TIMER_DELETE_ME)
		return TRUE

/obj/projectile/bullet/ciws
	name = "anti-projectile salvo"
	icon_state = "guardian"
	damage = 15
	armour_penetration = 10

/obj/structure/plaque/static_plaque/golden/commission/ks13/hc_police
	desc = "HC Sector 09-G-17 Asteroidal Anomaly Orbital Shipworks, Ship OSTs-03p 'Strider' Class Corvette Commissioned 03/09/2565 'Keeping Promises'"

/obj/machinery/computer/centcom_announcement/hc_police
	name = "inspection announcement console"
	desc = "A console used for making safety inspection announcements."
	req_access = null
	circuit = null
	command_name = "Heliostatic Coalition Safety Inspection Team Announcement"
	report_sound = ANNOUNCER_HC_POLICE

/obj/machinery/suit_storage_unit/hc_police
	mod_type = /obj/item/mod/control/pre_equipped/rim_inspector
	storage_type = /obj/item/tank/internals/oxygen/yellow
