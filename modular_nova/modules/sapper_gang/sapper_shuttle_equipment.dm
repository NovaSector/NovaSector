/datum/map_template/shuttle/pirate/sapper
	prefix = "_maps/shuttles/nova/"
	suffix = "sapper"
	name = "Sapper ship (Default)"

/area/shuttle/pirate/sapper
	name = "Sapper Shuttle"

/obj/docking_port/mobile/pirate/sapper
	name = "Sapper Shuttle"
	callTime = 1 MINUTES
	rechargeTime = 2 MINUTES
	shuttle_id = "pirate_sapper"
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	preferred_direction = NORTH
	port_direction = WEST

/obj/machinery/computer/shuttle/pirate/sapper
	name = "shuttle console"
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_SAPPER_SHIP)
	shuttleId = "pirate_sapper"
	possible_destinations = "sapper_custom;"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/sapper
	name = "shuttle navigation computer"
	icon_screen = "tram"
	icon_keyboard = "atmos_key"
	desc = "Used to designate a precise transit location for the shuttle."
	shuttleId = "pirate_sapper"
	shuttlePortId = "sapper_custom"

/obj/machinery/porta_turret/syndicate/energy/sapper
	max_integrity = 250
	faction = list(FACTION_SAPPER)
	req_access = list(ACCESS_SAPPER_SHIP)
	on = FALSE

/obj/item/storage/toolbox/emergency/turret/sapper
	name = "portable turret toolbox"

/obj/item/storage/toolbox/emergency/turret/sapper/PopulateContents()
	//we don't need the combat wrench, we already spawn with it in our belt

/obj/item/storage/toolbox/emergency/turret/sapper/set_faction(obj/machinery/porta_turret/turret, mob/user) //a nice proc to hook into
	turret.faction = list(FACTION_SAPPER)
	turret.lethal_projectile = /obj/projectile/beam/laser/sapper_turret
	turret.lethal_projectile_sound = 'sound/weapons/laser2.ogg'
	turret.max_integrity = 150
	turret.shot_delay = 2 SECONDS

/obj/projectile/beam/laser/sapper_turret
	damage = 10
	speed = 0.6
	light_color = COLOR_VIVID_YELLOW

/mob/living/basic/bot/medbot/sapper
	name = "\proper Manon"
	medkit_type = /obj/item/storage/medkit/fire
	skin = "ointment"
	health = 40
	maxHealth = 40
	req_one_access = list(ACCESS_SAPPER_SHIP)
	bot_mode_flags = parent_type::bot_mode_flags & ~BOT_MODE_REMOTE_ENABLED
	radio_key = /obj/item/encryptionkey/syndicate
	radio_channel = RADIO_CHANNEL_SYNDICATE
	damage_type_healer = HEAL_ALL_DAMAGE
	faction = list(FACTION_SAPPER)
	heal_threshold = 0
	heal_amount = 5
	additional_access = /datum/id_trim/sapper

/mob/living/basic/bot/medbot/sapper/Initialize(mapload, new_skin)
	. = ..()
	internal_radio.set_frequency(FREQ_SYNDICATE)
	internal_radio.freqlock = RADIO_FREQENCY_LOCKED
