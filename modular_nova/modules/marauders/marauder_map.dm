//shuttle
/datum/map_template/shuttle/traitor
	port_id = "traitor"
	prefix = "_maps/shuttles/nova/"
	who_can_purchase = null

/datum/map_template/shuttle/traitor/default
	suffix = "default"
	name = "marauder's shuttle (Default)"
	has_ceiling = TRUE
	ceiling_turf = /turf/open/floor/plating/reinforced

/obj/machinery/computer/shuttle/traitor/send_shuttle(dest_id, mob/user)
	. = ..()
	if(. != "success")
		return
	//make the shuttle travel in a random dir each time, because its cool 😎
	var/obj/docking_port/mobile/mobile_dock = SSshuttle.getShuttle(shuttleId)
	var/obj/docking_port/stationary/transit_dock
	for(var/obj/docking_port/stationary/transit/stationary_dock in SSshuttle.stationary_docking_ports)
		if(stationary_dock.owner == mobile_dock)
			transit_dock = stationary_dock
			break
	var/random_dir = pick(GLOB.cardinals)
	mobile_dock.preferred_direction = random_dir
	mobile_dock.port_direction = turn(random_dir, ROTATION_CLOCKWISE)
	transit_dock.setDir(random_dir)

/obj/machinery/computer/security/telescreen/traitor_shuttle
	name = "shuttle-camera telescreen"
	network = list("lone_infil_shuttle")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/security/telescreen/traitor_shuttle, 32)

/obj/machinery/computer/camera_advanced/shuttle_docker/traitor
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "traitor"
	shuttlePortId = "traitor_custom"
	jump_to_ports = list("ferry_home" = 1, "whiteship_home" = 1, "whiteship_lavaland" = 1, "traitor_home" = 1, "traitor_custom" = 1)
	see_hidden = FALSE
	lock_override = CAMERA_LOCK_STATION
	view_range = 4

//nav computers
/obj/machinery/computer/shuttle/traitor
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	shuttleId = "traitor"
	possible_destinations = "whiteship_home;whiteship_lavaland;traitor_home;traitor_custom"
	may_be_remote_controlled = TRUE

/obj/machinery/computer/shuttle/traitor/Initialize(mapload)
	. = ..()
	//planetary maps use "ferry_home" instead of "whiteship_home" for their arrivals dock
	if(SSmapping.is_planetary())
		possible_destinations = "ferry_home;whiteship_home;whiteship_lavaland;traitor_home;traitor_custom"

//shuttle remote
/obj/item/shuttle_remote/traitor
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "nukietalkie"
	shuttle_away_id = "traitor_home"

/obj/item/shuttle_remote/traitor/Initialize(mapload)
	. = ..()
	//ditto
	if(SSmapping.is_planetary())
		shuttle_home_id = "ferry_home"

//mobile docking port
/obj/docking_port/mobile/traitor
	name = "marauder shuttle"
	callTime = 10 SECONDS
	ignitionTime = 5 SECONDS
	rechargeTime = 30 SECONDS
	shuttle_id = "traitor"
	movement_force = list("KNOCKDOWN"=3,"THROW"=0)
	preferred_direction = EAST
	port_direction = SOUTH

//area
/area/shuttle/traitor
	requires_power = TRUE
	name = "Marauder Ship"
	flags_1 = NONE


//map
/datum/lazy_template/midround_traitor
	key = LAZY_TEMPLATE_KEY_MIDROUND_TRAITOR
	map_dir = "_maps/nova/lazy_templates"
	map_name = "midround_traitor"

//pet
/mob/living/basic/carp/pet/clover //carpo you're really adding another carp pet isn't that overdone? I JUST THINK THEY'RE NEAT
	name = "Clover"
	real_name = "Clover"
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "clover"
	icon_dead = "clover_dead"
	icon_gib = "clover_gib"
	icon_living = "clover"
	gender = MALE
	maxHealth = 300 //you said carps were stronger on nova-sector
	health = 300
	speak_emote = list("gruffs") //he's old
	desc = "A bright green carp tamed by one of the operatives on rotation at bay no. 09. \n\
		Has been here a long, long time. Petting him brings good luck, you'll need it."
	faction = list(ROLE_SYNDICATE)
	regenerate_colour = COLOR_HEALING_CYAN
	greyscale_config = NONE

/mob/living/basic/carp/pet/clover/Initialize(mapload)
	. = ..()
	combat_mode = FALSE //starts on for some reason, making him dense which is annoying
	//for sentience potion
	var/datum/language_holder/holder = get_language_holder()
	holder.grant_language(/datum/language/codespeak, source = LANGUAGE_MIND)
	holder.selected_language = /datum/language/codespeak

//mech or cyborg mmi
/obj/item/mmi/posibrain/circuit/disk/syndie
	overrides_aicore_laws = TRUE
	req_access = list(ACCESS_SYNDICATE)
	faction = list(ROLE_SYNDICATE)

/obj/item/mmi/posibrain/circuit/disk/syndie/Initialize(mapload)
	. = ..()
	laws = new /datum/ai_laws/syndicate_override()
	radio.set_on(FALSE)

//stationary docking port
/obj/docking_port/stationary/traitor
	name = "Launchpad no. 09"
	shuttle_id = "traitor"
	delete_after = TRUE //no return
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
/area/misc/operative_barracks
	name = "Aft Operative Barracks"
	requires_power = FALSE
	area_flags = NOTELEPORT | HIDDEN_AREA
	default_gravity = STANDARD_GRAVITY
	ambient_buzz = null

/area/misc/operative_barracks/armoury
	name = "Armoury no. 09"
	sound_environment = SOUND_ENVIRONMENT_LIVINGROOM

/area/misc/operative_barracks/secure
	name = "Armoury Secure Storage"
	sound_environment = SOUND_ENVIRONMENT_PADDED_CELL

/area/misc/operative_barracks/robotics
	name = "Robotics Laboratorium no. 09"
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/misc/operative_barracks/medbay
	name = "Implant Laboratorium no. 09"
	sound_environment = SOUND_ENVIRONMENT_BATHROOM

/area/misc/operative_barracks/surgery
	name = "Surgery Room"
	sound_environment = SOUND_ENVIRONMENT_PADDED_CELL

/area/misc/operative_barracks/mission_briefing
	name = "Mission Briefing no. 09"
	sound_environment = SOUND_ENVIRONMENT_STONEROOM

/area/misc/operative_barracks/dorm
	name = "Dormroom no. 09"
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/misc/operative_barracks/bathroom
	name = "Bathroom"
	sound_environment = SOUND_ENVIRONMENT_BATHROOM

/area/misc/operative_barracks/hangar
	name = "Launchpad no. 09"
	sound_environment = SOUND_ENVIRONMENT_HANGAR
