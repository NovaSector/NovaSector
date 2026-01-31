/datum/map_template/shuttle/random_ship/hc_police
	suffix = "hc_police"
	name = "random ship (HC Ship)"

/area/shuttle/hc_cops
	name = "HC Ship"
	forced_ambience = TRUE
	requires_power = TRUE
	area_limited_icon_smoothing = /area/shuttle/hc_cops
	ambient_buzz = 'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_radio.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/alarm_small_09.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_loop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_start.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/gear_stop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/intercom_loop.ogg')

/area/shuttle/hc_cops/engineering
	name = "HC Ship Reactor Room"
	icon_state = "engie"

/area/shuttle/hc_cops/ready_room
	name = "HC Ship Ready Room"
	icon_state = "security_sub"

/area/shuttle/hc_cops/cargo_hold
	name = "HC Ship Cargo Hold"
	icon_state = "cargo_bay"

/area/shuttle/hc_cops/infirmary
	name = "HC Ship Infirmary"
	icon_state = "med_central"

/area/shuttle/hc_cops/recreation
	name = "HC Ship Recreation"
	icon_state = "rec"

/area/shuttle/hc_cops/armory
	name = "HC Ship Armory"
	icon_state = "security"

/area/shuttle/hc_cops/command
	name = "HC Ship Bridge"
	icon_state = "command"

/area/shuttle/hc_cops/canteen
	name = "HC Ship Canteen"
	icon_state = "cafeteria"

/area/shuttle/hc_cops/hydroponics
	name = "HC Ship Hydroponics"
	icon_state = "hydro"

/area/shuttle/hc_cops/isolation
	name = "HC Ship Isolation Room"
	icon_state = "virology_isolation"

/area/shuttle/hc_cops/conference
	name = "HC Ship Conference Hall"
	icon_state = "courtroom"

/area/shuttle/hc_cops/lounge
	name = "HC Ship Lounge"
	icon_state = "lounge"

/area/shuttle/hc_cops/checkpoint
	name = "HC Ship Teleporter Checkpoint"
	icon_state = "checkpoint_arr"

/area/shuttle/hc_cops/teleporter
	name = "HC Ship Teleporter"
	icon_state = "teleporter"

/obj/docking_port/mobile/hc_ship
	name = "HC LTPV 'Icebreaker'"
	shuttle_id = "hc_ship"
	port_direction = NORTH
	preferred_direction = NORTH
	callTime = 1 MINUTES
	rechargeTime = 3 MINUTES
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	takeoff_sound = sound('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/engine_ignit_int.ogg')
	landing_sound = sound('modular_nova/modules/random_ship_event/random_ships/heliostatic_inspectors/sounds/env_ship_down.ogg')

/obj/machinery/computer/shuttle/hc
	name = "police shuttle console"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	shuttleId = "hc_ship"
	possible_destinations = "hc_ship_custom"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/hc
	name = "police shuttle navigation computer"
	desc = "Used to designate a precise transit location for the police shuttle."
	lock_override = CAMERA_LOCK_STATION
	view_range = 8.5
	x_offset = 6
	y_offset = 15
	shuttleId = "hc_ship"
	shuttlePortId = "hc_ship_custom"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/hc/rotateLandingSpot()
	to_chat(current_user, span_warning("Rotation disabled to preserve structural integrity of the outpost."))
	return FALSE

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
	desc = "HC Sector 09-G-17 Asteroidal Anomaly Orbital Shipworks, Ship OSTs-05 'Hunter Strider' Class Frigate Commissioned 16/01/2566 'Keeping Promises'"

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
