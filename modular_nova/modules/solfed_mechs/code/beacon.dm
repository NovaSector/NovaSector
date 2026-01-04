GLOBAL_DATUM(mech_drop_alert_handler, /datum/mech_drop_alert_handler)

//Global Datum that tracks any active mech summoning beacon to avoid alert spamming.
/datum/mech_drop_alert_handler
	///list of active mech summon beacons.
	var/list/obj/item/mecha_summon_remote/beacon_queue

///adds a beacon to the inbound mech queue
/datum/mech_drop_alert_handler/proc/add_beacon(obj/item/mecha_summon_remote/beacon)
		LAZYADD(beacon_queue, beacon)

///removes a beacon from the inbound mech queue
/datum/mech_drop_alert_handler/proc/remove_beacon(obj/item/mecha_summon_remote/beacon)
		LAZYREMOVE(beacon_queue, beacon)

///returns the length of the inbound mech queue
/datum/mech_drop_alert_handler/proc/queue_length()
		return LAZYLEN(beacon_queue)

///returns all the inbound mechs types except hermes as it is stealthy
/datum/mech_drop_alert_handler/proc/get_visible_mech_types()
	var/list/mech_types = list()
	for (var/obj/item/mecha_summon_remote/beacon as anything in beacon_queue)
		if (beacon.spawn_type == /obj/vehicle/sealed/mecha/solfed/hermes)
			continue
		mech_types += beacon.spawn_type
	return mech_types

///returns the location of the drop that triggered the annoucement. Blacklist centcom levels to avoid spamm when testing.
/datum/mech_drop_alert_handler/proc/get_announcement_location()
	for (var/obj/item/mecha_summon_remote/beacon as anything in beacon_queue)
		var/area/area_loc = get_area(beacon)
		if (!istype(area_loc, /area/centcom))
			return area_loc.name
	return null


/obj/item/mecha_summon_remote
	name = "mech drop beacon"
	desc = "base for solfed mech beacons, (yell at whoever gave you this one.)"
	icon = 'modular_nova/modules/solfed_mechs/icons/grenades.dmi'
	icon_state = "mech_beacon"
	///What mech should this beacon spawn?
	var/spawn_type
	///Has it been activated yet?
	var/activated = FALSE
	///When was it triggered
	var/activation_time = null

/obj/item/mecha_summon_remote/Initialize(mapload)
	. = ..()
	transform = matrix(0.6, MATRIX_SCALE)

/obj/item/mecha_summon_remote/aegis
	name = "Aegis Orbital Deployment Beacon"
	desc = "A throwable beacon that designates a SolFed mech drop zone. Calls for the deployment of a riot-control mech. Rumored to have been field-tested in Sector 7G."
	spawn_type = /obj/vehicle/sealed/mecha/solfed/aegis

/obj/item/mecha_summon_remote/atlas
	name = "Atlas Orbital Deployment Beacon"
	desc = "A throwable beacon that designates a SolFed mech drop zone. Calls in a support mech based on terraforming schematics from a defunct, ethically dubious conglomerate."
	spawn_type = /obj/vehicle/sealed/mecha/solfed/atlas

/obj/item/mecha_summon_remote/hermes
	name = "Hermes Orbital Deployment Beacon"
	desc = "A throwable beacon that designates a SolFed mech drop zone. Summons a recon mech inspired by a prototype courier drone known for vanishing from radar—codenamed HMX-2001."
	spawn_type = /obj/vehicle/sealed/mecha/solfed/hermes

/obj/item/mecha_summon_remote/prometheus
	name = "Prometheus Orbital Deployment Beacon"
	desc = "A throwable beacon that designates a SolFed mech drop zone. Deploys a breach-assault mech equipped with incendiary ordnance. Engineers joke that Prometheus is 'hot-headed' in more ways than one."
	spawn_type = /obj/vehicle/sealed/mecha/solfed/prometheus

/obj/item/mecha_summon_remote/thanatos
	name = "Thanatos Orbital Deployment Beacon"
	desc = "A throwable beacon that designates a SolFed mech drop zone. Authorizes launch of a heavy assault mech optimized for suppression fire. Nicknamed 'Thanatos' after a design committee insisted it sounded cooler than 'Model-X.'"
	spawn_type = /obj/vehicle/sealed/mecha/solfed/thanatos

/obj/effect/temp_visual/solfed_drop_warning
	name = "Orbital Drop Beacon"
	desc = "A shimmering holographic marker designating a SolFed orbital deployment zone."
	icon = 'modular_nova/modules/solfed_mechs/icons/hologram.dmi'
	icon_state = "drop_warn"
	duration = 34

/obj/structure/closet/supplypod/mech_drop
	name = "SolFed Mech Drop Pod"
	desc = "A specialized orbital pod used to deliver SolFed mechs directly to the station surface."
	bluespace = TRUE
	create_sparks = FALSE
	effectStealth = TRUE
	effectQuiet = FALSE
	specialised = TRUE
	stay_after_drop = FALSE
	anchored = TRUE
	allow_objects = TRUE
	allow_dense = TRUE
	density = TRUE
	armor_type = /datum/armor/closet_supplypod
	pod_flags = NONE
	delays = list(POD_TRANSIT = 30, POD_FALLING = 4, POD_OPENING = 0, POD_LEAVING = 0)
	custom_rev_delay = FALSE
	door = null
	fin_mask = null
	soundVolume = 80
	openingSound = null
	leavingSound = null

/obj/structure/closet/supplypod/mech_drop/preOpen()
	. = ..()

	var/turf/pod_tile = get_turf(src)
	for (var/obj/effect/temp_visual/solfed_drop_warning/warning_effect in pod_tile)
		qdel(warning_effect)

/obj/item/mecha_summon_remote/attack_self(mob/user, modifiers)
	. = ..()

	if (!GLOB.mech_drop_alert_handler)
		GLOB.mech_drop_alert_handler = new /datum/mech_drop_alert_handler()

	if(activated)
		return

	user.visible_message(span_emote("[user] inputs ↑ ↑ ↓ → on the beacon interface."))
	if(do_after(user, 1 SECONDS, user))
		icon_state = "mech_beacon_on"
		activated = TRUE
		activation_time = world.time
		desc = "[desc]\nThis one is active, a blue light beams up from its top."
		say(pick(
			"Orbital drop beacon activated. Recommend throwing unless you enjoy being crushed.",
			"Deployment sequence initiated. Toss me unless you're feeling brave.",
			"Incoming mech strike. You might want to not be here.",
			"SolFed drop confirmed. Throw me or prepare to meet your new roommate.",
			"Beacon armed. If you're still holding me in 30 seconds, that's on you.",
		))

		// Delay actual drop logic
		addtimer(CALLBACK(src, PROC_REF(trigger_drop), user), 30 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME)
		GLOB.mech_drop_alert_handler.add_beacon(src)
		if (GLOB.mech_drop_alert_handler.queue_length() == 1)
			addtimer(CALLBACK(src, PROC_REF(solfed_mech_drop_announcement)), 10 SECONDS)
	else
		return FALSE

/obj/item/mecha_summon_remote/examine(mob/user)
	. = ..()
	if(activated)
		var/time_left = max(0, round(((activation_time + 30 SECONDS) - world.time) / 10, 1 SECONDS))
		var/message = "The countdown on its screen shows: [time_left] seconds."
		. += ""
		. += span_notice(message)

///Spawns a warning holosign on the floor then summons a drop pod containing a mech and using the sprite of the mech it contains.
/obj/item/mecha_summon_remote/proc/trigger_drop(mob/user)
	var/turf/deployment_tile = get_turf(src)
	GLOB.mech_drop_alert_handler.remove_beacon(src)
	if (!deployment_tile)
		return

	// Spawn visual warning effect
	var/obj/effect/temp_visual/solfed_drop_warning/warning_hologram = new /obj/effect/temp_visual/solfed_drop_warning(deployment_tile)
	warning_hologram.pixel_w = -32
	warning_hologram.pixel_z = -32

	// Create mech and supply pod
	var/obj/vehicle/sealed/mecha/deployed_mech = new spawn_type()
	var/obj/structure/closet/supplypod/mech_drop/supply_pod = new /obj/structure/closet/supplypod/mech_drop()
	supply_pod.pixel_x = 16
	deployed_mech.forceMove(supply_pod)

	// Sync pod visuals with mech
	supply_pod.icon = deployed_mech.icon
	supply_pod.icon_state = deployed_mech.icon_state

	// Insert mech into pod
	supply_pod.insert(deployed_mech, supply_pod)

	// Create landing zone and launch pod
	new /obj/effect/pod_landingzone(deployment_tile, supply_pod)

	// Remove beacon
	qdel(src)

///Create an annoucement depending on the incoming mech(s)
/obj/item/mecha_summon_remote/proc/solfed_mech_drop_announcement()
	var/list/mech_types = GLOB.mech_drop_alert_handler.get_visible_mech_types()
	if (!length(mech_types))
		return

	var/location_name = GLOB.mech_drop_alert_handler.get_announcement_location()
	if (!location_name)
		return

	var/text
	if (length(mech_types) == 1)
		// Cast the first element to a mech type so we can access its initial name
		var/typepath = mech_types[1]
		var/obj/vehicle/sealed/mecha/mech_type = typepath
		var/mech_name = initial(mech_type.name)

		text = "Inbound SolFed mech of type [mech_name] detected. Estimated landing site: [location_name]. All personnel are advised to clear the drop zone."
	else
		// Build a readable list of names for multiple mechs
		var/list/mech_names = list()
		for (var/typepath in mech_types)
			var/obj/vehicle/sealed/mecha/mech_type = typepath
			mech_names += initial(mech_type.name)

		var/list/parts = list()
		if (length(mech_names) == 1)
			parts += mech_names[1]
		else if (length(mech_names) == 2)
			parts += "[mech_names[1]] and [mech_names[2]]"
		else if (length(mech_names) > 2)
			// Add everything except the last with commas
			for (var/i = 1; i < length(mech_names); i++)
				parts += "[mech_names[i]],"
			// Add final item prefixed with "and"
			parts += "and [mech_names[length(mech_names)]]"
		// The final string
		var/names_str = jointext(parts, " ")

		text = "Multiple SolFed mech signatures ([names_str]) detected on orbital approach, inbound toward [location_name]. Estimated impact in 30 seconds. Evacuation of the landing zone recommended."

	var/sound_to_play = ANNOUNCER_HC_POLICE
	if (prob(1))
		sound_to_play = ANNOUNCER_ANIMES

	priority_announce(text, "Nanotrasen traffic control", sound_to_play, ANNOUNCEMENT_TYPE_PRIORITY)
