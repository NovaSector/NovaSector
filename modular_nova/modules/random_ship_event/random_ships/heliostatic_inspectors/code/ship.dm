/datum/map_template/shuttle/pirate/hc_police
	prefix = "_maps/shuttles/nova/"
	suffix = "random_ship_hc_police"
	name = "police ship (HC Enforcer-Class Starship)"
	port_x_offset = -5
	port_y_offset = 5

/area/shuttle/pirate/nri
	name = "HC Starship"
	forced_ambience = TRUE
	ambient_buzz = 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_radio.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_small_09.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_loop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_start.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_stop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/intercom_loop.ogg')

/obj/machinery/computer/shuttle/pirate/nri
	name = "police shuttle console"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/nri
	name = "police shuttle navigation computer"
	desc = "Used to designate a precise transit location for the police shuttle."

/obj/machinery/porta_turret/syndicate/hc_police
	name = "anti-projectile turret"
	desc = "An automatic defense turret designed for point-defense, it's probably not that wise to try approaching it."
	scan_range = 9
	shot_delay = 15
	faction = list(FACTION_NEUTRAL)
	icon = 'modular_nova/modules/random_ship_event/random_ships/nri/icons/turrets.dmi'
	icon_state = "gun_turret"
	base_icon_state = "gun_turret"
	max_integrity = 250
	stun_projectile = /obj/projectile/bullet/ciws
	lethal_projectile = /obj/projectile/bullet/ciws
	lethal_projectile_sound = 'modular_nova/modules/random_ship_event/random_ships/nri/sounds/shell_out_tiny.ogg'
	stun_projectile_sound = 'modular_nova/modules/random_ship_event/random_ships/nri/sounds/shell_out_tiny.ogg'

/obj/machinery/porta_turret/syndicate/hc_police/target(atom/movable/target)
	if(target)
		setDir(get_dir(base, target))//even if you can't shoot, follow the target
		shootAt(target)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay * 2)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay * 3)
		return TRUE

/obj/projectile/bullet/ciws
	name = "anti-projectile salvo"
	icon_state = "guardian"
	damage = 15
	armour_penetration = 10

/obj/docking_port/mobile/pirate/hc_police
	name = "NRI IAC-PV 'Evangelium'" //Nobody will care about the translation but basically NRI Internal Affairs Collegium-Patrol Vessel
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
	desc = "NRI Terentiev-Yermolayev Orbital Shipworks, Providence High Orbit, Ship OSTs-02 'Potato Beetle' Class Corvette Commissioned 10/11/2562 'Keeping Promises'"

/obj/machinery/computer/centcom_announcement/hc_police
	name = "inspection announcement console"
	desc = "A console used for making safety inspection announcements."
	req_access = null
	circuit = null
	command_name = "Heliostatic Coalition Safety Inspection Team Announcement"
	report_sound = ANNOUNCER_hc_police

/obj/machinery/suit_storage_unit/nri
	mod_type = /obj/item/mod/control/pre_equipped/policing
	storage_type = /obj/item/tank/internals/oxygen/yellow
