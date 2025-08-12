/datum/map_template/shuttle/pirate/nri_police
	prefix = "_maps/shuttles/nova/"
	suffix = "random_ship_nri_police"
	name = "police ship (NRI Enforcer-Class Starship)"
	port_x_offset = -5
	port_y_offset = 5

/area/shuttle/pirate/nri
	name = "NRI Starship"
	forced_ambience = TRUE
	ambient_buzz = 'modular_nova/modules/random_ship_event/random_ships/nri/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list('modular_nova/modules/random_ship_event/random_ships/nri/sounds/alarm_radio.ogg',
				'modular_nova/modules/random_ship_event/random_ships/nri/sounds/alarm_small_09.ogg',
				'modular_nova/modules/random_ship_event/random_ships/nri/sounds/gear_loop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/nri/sounds/gear_start.ogg',
				'modular_nova/modules/random_ship_event/random_ships/nri/sounds/gear_stop.ogg',
				'modular_nova/modules/random_ship_event/random_ships/nri/sounds/intercom_loop.ogg')

/obj/machinery/computer/shuttle/pirate/nri
	name = "police shuttle console"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/nri
	name = "police shuttle navigation computer"
	desc = "Used to designate a precise transit location for the police shuttle."

/obj/machinery/porta_turret/syndicate/nri_police
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

/obj/machinery/porta_turret/syndicate/nri_police/target(atom/movable/target)
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

/obj/docking_port/mobile/pirate/nri_police
	name = "NRI IAC-PV 'Evangelium'" //Nobody will care about the translation but basically NRI Internal Affairs Collegium-Patrol Vessel
	initial_engine_power = 6
	port_direction = EAST
	preferred_direction = EAST
	callTime = 2 MINUTES
	rechargeTime = 3 MINUTES
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	can_move_docking_ports = TRUE
	takeoff_sound = sound('modular_nova/modules/random_ship_event/random_ships/nri/sounds/engine_ignit_int.ogg')
	landing_sound = sound('modular_nova/modules/random_ship_event/random_ships/nri/sounds/env_ship_down.ogg')

/obj/structure/plaque/static_plaque/golden/commission/ks13/nri_police
	desc = "NRI Terentiev-Yermolayev Orbital Shipworks, Providence High Orbit, Ship OSTs-02 'Potato Beetle' Class Corvette Commissioned 10/11/2562 'Keeping Promises'"

/obj/machinery/computer/centcom_announcement/nri_police
	name = "inspection announcement console"
	desc = "A console used for making safety inspection announcements."
	req_access = null
	circuit = null
	command_name = "NRI Safety Inspection Team Announcement"
	report_sound = ANNOUNCER_NRI_POLICE

/obj/machinery/suit_storage_unit/nri
	mod_type = /obj/item/mod/control/pre_equipped/policing
	storage_type = /obj/item/tank/internals/oxygen/yellow

/obj/machinery/shuttle_scrambler/nri
	name = "supply monitor"
	desc = "This system monitors supply lines to ensure proper safety compliance. Can be turned off if needed."
	siphon_per_tick = 0

/obj/machinery/shuttle_scrambler/nri/toggle_on(mob/user)
	SSshuttle.registerTradeBlockade(src)
	AddComponent(/datum/component/gps, "NRI Starship")
	active = TRUE
	to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
	to_chat(user,span_warning("The scrambling signal can be now tracked by GPS."))
	START_PROCESSING(SSobj,src)

/obj/machinery/shuttle_scrambler/nri/process()
	if(active)
		if(is_station_level(z))
			var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
			if(D)
				var/siphoned = min(D.account_balance,siphon_per_tick)
				D.adjust_money(-siphoned)
				credits_stored += siphoned
	else
		return

/obj/machinery/shuttle_scrambler/nri/interact(mob/user)
	if(active)
		var/deactivation_response = tgui_alert(user,"Turn the crasher off?", "Crasher", list("Yes", "Cancel"))
		if(deactivation_response != "Yes")
			return
		if(!active|| !user.can_perform_action(src))
			return
		toggle_off(user)
		update_appearance()
		send_notification()
		to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
		return
	var/scramble_response = tgui_alert(user, "Turning the crasher on might alienate the population and will make the shuttle trackable by GPS. Are you sure you want to do it?", "Crasher", list("Yes", "Cancel"))
	if(scramble_response != "Yes")
		return
	if(active || !user.can_perform_action(src))
		return
	toggle_on(user)
	update_appearance()
	send_notification()
	to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
	return

/obj/machinery/shuttle_scrambler/nri/send_notification()
	if(active)
		priority_announce("We're monitoring all supply deliveries to ensure proper safety compliance during our inspection. This is a standard procedure for voluntary inspections.","NRI Safety Inspection Team",ANNOUNCER_NRI_POLICE,"Priority", color_override = "purple")
	else
		priority_announce("Supply monitoring has been discontinued. We appreciate your cooperation with our safety inspection.","NRI Safety Inspection Team",ANNOUNCER_NRI_POLICE,"Priority", color_override = "purple")
