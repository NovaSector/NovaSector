/datum/map_template/shuttle/random_ship/hc_police
	suffix = "hc_police"
	name = "random ship (HC Enforcer-Class Starship)"
	port_x_offset = -5
	port_y_offset = 5

/area/shuttle/hc_cops
	name = "HC Starship"
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

/obj/machinery/computer/shuttle/pirate/hc
	name = "police shuttle console"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/hc
	name = "police shuttle navigation computer"
	desc = "Used to designate a precise transit location for the police shuttle."
	x_offset = -3
	y_offset = -7

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

/obj/docking_port/mobile/pirate/hc_police
	name = "HC IPV 'Tequilla Sunset'"
	initial_engine_power = 6
	port_direction = EAST
	preferred_direction = EAST
	callTime = 2 MINUTES
	rechargeTime = 3 MINUTES
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	can_move_docking_ports = TRUE
	takeoff_sound = sound('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/engine_ignit_int.ogg')
	landing_sound = sound('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/env_ship_down.ogg')

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
	mod_type = /obj/item/mod/control/pre_equipped/policing
	storage_type = /obj/item/tank/internals/oxygen/yellow
