/datum/dynamic_ruleset/midround/from_ghosts/marauder
	name = "Ghost Roll Traitor"
	config_tag = "Marauders"
	preview_antag_datum = /datum/antagonist/traitor/marauder
	midround_type = HEAVY_MIDROUND
	candidate_role = "Marauder"
	pref_flag = ROLE_MARAUDER
	jobban_flag = ROLE_MARAUDER
	ruleset_flags = RULESET_INVADER
	weight = list(
		DYNAMIC_TIER_LOW = 4,
		DYNAMIC_TIER_LOWMEDIUM = 4,
		DYNAMIC_TIER_MEDIUMHIGH = 6,
		DYNAMIC_TIER_HIGH = 8,
	)
	min_pop = 20
	repeatable = TRUE
	signup_atom_appearance = /obj/item/clothing/mask/gas/syndicate
	/// The reservation datum, aka where is our map
	var/datum/turf_reservation/reservation
	/// The datum which actually holds the map
	var/datum/lazy_template/midround_traitor/map
	/// The turf inside the lazy_template marked as this antag's spawn
	var/turf/spawnpoint
	/// Amount of times we've occured in the round
	var/marauder_no = 1

/datum/dynamic_ruleset/midround/from_ghosts/marauder/prepare_for_role(datum/mind/player_mind)
	map = new
	reservation = map.lazy_load()
	. = ..()
	var/mob/living/carbon/human/new_character = player_mind.current
	new_character.Sleeping(7 SECONDS)
	//assign our number
	for(var/datum/dynamic_ruleset/midround/from_ghosts/marauder/ruleset in SSdynamic.executed_rulesets)
		marauder_no++
	move_to_spawn(new_character)
	load_personal_items(new_character)
	//report to mins
	message_admins("[ADMIN_LOOKUPFLW(new_character)] has been made into a traitor by midround ruleset.")
	log_game("[key_name(new_character)] was spawned as a traitor by midround ruleset.")

/datum/dynamic_ruleset/midround/from_ghosts/marauder/assign_role(datum/mind/player_mind)
	var/datum/antagonist/traitor/marauder/antag_datum = new /datum/antagonist/traitor/marauder
	player_mind.add_antag_datum(antag_datum)
	load_shuttle()

/// move our guy
/datum/dynamic_ruleset/midround/from_ghosts/marauder/proc/move_to_spawn(mob/living/carbon/human/marauder)
	spawnpoint = GLOB.traitor_start[marauder_no]
	marauder.forceMove(spawnpoint)
	var/obj/structure/bed/bed = locate() in spawnpoint
	var/obj/item/bedsheet/bedsheet = locate() in spawnpoint
	if(!bed || !bedsheet)
		return
	//put them in bed
	marauder.setDir(SOUTH)
	bed.buckle_mob(marauder)
	bedsheet.coverup(marauder)
	RegisterSignal(marauder, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_departure))

/// this is where we load the personalized note and loadout equipped mannequin
/datum/dynamic_ruleset/midround/from_ghosts/marauder/proc/load_personal_items(mob/living/carbon/human/marauder)
	if(!marauder || !marauder.client)
		return
	for(var/turf/open/floor/iron/relevant_turf in reservation.reserved_turfs)
		if(!istype(get_area(relevant_turf), /area/misc/operative_barracks/dorm))
			continue
		var/obj/structure/mannequin/operative_barracks/loadout/mannequin = locate() in relevant_turf
		var/obj/machinery/door/airlock/airlock = locate() in relevant_turf
		if(mannequin && !mannequin.loaded)
			mannequin.load_items(marauder.client)
			mannequin.loaded = TRUE
			mannequin.update_appearance()
		if(airlock && !airlock.note)
			var/obj/item/paper/fluff/midround_traitor/greeting/note = new(airlock)
			airlock.note = note
			note.write_note(marauder.real_name)
			note.update_appearance()
			note.forceMove(airlock)
			airlock.update_appearance()

/// when the marauder flies away from the base, actually procs when landed due to the base starting in transit Z
/datum/dynamic_ruleset/midround/from_ghosts/marauder/proc/on_departure(datum/source)
	SIGNAL_HANDLER
	//unload the map
	if(reservation && map)
		unload_map()
	var/mob/living/user = source
	//prompt namechange
	if(!user)
		return
	if(!user.client)
		return
	UnregisterSignal(user, COMSIG_MOVABLE_Z_CHANGED) //clean up, too
	INVOKE_ASYNC(src, PROC_REF(prompt_namechange), user, user.client)

/datum/dynamic_ruleset/midround/from_ghosts/marauder/proc/unload_map()
	for(var/turf/victimized_turf as anything in reservation.reserved_turfs)
		victimized_turf.empty()
	map.reservations -= reservation
	map = null
	spawnpoint = null
	QDEL_NULL(reservation)

/// load the shuttle, we don't trust lazy_load with this
/datum/dynamic_ruleset/midround/from_ghosts/marauder/proc/load_shuttle()
	var/datum/map_template/shuttle/marauder_shuttle = SSmapping.shuttle_templates["traitor_default"]
	var/x = (world.maxx - TRANSITIONEDGE - marauder_shuttle.width - (marauder_no * 10))
	var/y = (world.maxy - TRANSITIONEDGE - marauder_shuttle.height)
	var/z
	if(SSmapping.empty_space)
		z = SSmapping.empty_space.z_value
	else
		//no space level, lets go for the safest next option
		//lets find a transit z, we will claim the top right corner
		for(var/datum/space_level/z_level as anything in SSmapping.z_list)
			if(z_level.traits.Find(ZTRAIT_RESERVED))
				z = z_level.z_value
				break

	var/turf/turf = locate(x,y,z)
	if(!turf)
		CRASH("[src] found no turf to load its shuttle in")
	if(!marauder_shuttle.load(turf))
		CRASH("Loading [marauder_shuttle] failed!")
	//dock at our port
	var/obj/docking_port/mobile/mobile_port = marauder_no == 1 ? SSshuttle.getShuttle("traitor") : SSshuttle.getShuttle("traitor_[marauder_no]")
	mobile_port.destination = marauder_no == 1 ? SSshuttle.getDock("traitor") : SSshuttle.getDock("traitor_[marauder_no]")
	mobile_port.mode = SHUTTLE_IGNITING
	mobile_port.setTimer(mobile_port.ignitionTime)
