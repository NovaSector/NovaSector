/**
 * A modification to the standard bioscrambler anomaly event. The anomaly cannot pass through walls,
 * and the spawn is restricted to common areas that engineering has rapid access.
 */

/obj/effect/anomaly/bioscrambler
	pass_flags = PASSTABLE | PASSGLASS | PASSMACHINE | PASSDOORS
	range = 4
	pulse_delay = 20 SECONDS

/datum/round_event/anomaly/anomaly_bioscrambler/setup()
	if(spawn_location)
		impact_area = get_area(spawn_location)
	else
		impact_area = placer.find_bioscrambler_area()

/datum/round_event/anomaly/anomaly_bioscrambler/announce(fake)
	if(isnull(impact_area))
		impact_area = placer.find_bioscrambler_area()
	priority_announce("Biologic limb swapping agent detected on [ANOMALY_ANNOUNCE_MEDIUM_TEXT] [impact_area.name]. Engineers are advised to set up containment fields to prevent movement. Wear biosuits or other protective gear to counter the effects. Calculated half-life of %9£$T$%F3 years.", "Anomaly Alert", ANNOUNCER_ANOMALIES)

/**
 * Returns an area which is safe to place a bioscrambler anomaly.
 */
/datum/anomaly_placer/proc/find_bioscrambler_area()
	var/static/list/bioscrambler_inclusions = typecacheof(list(
		/area/station/commons,
		/area/station/hallway/primary,
		/area/station/hallway/secondary,
	))

	//Subtypes from the above that shouldn't be included.
	var/static/list/bioscrambler_exclusions = typecacheof(list(
		/area/station/commons/dorms,
		/area/station/hallway/secondary/command,
		/area/station/hallway/secondary/construction,
		/area/station/hallway/secondary/dock,
		/area/station/hallway/secondary/exit/escape_pod,
		/area/station/hallway/secondary/recreation,
		/area/station/hallway/secondary/service,
		/area/station/hallway/secondary/spacebridge,
		/area/station/commons/storage,
		/area/station/commons/toilet,
		/area/station/commons/vacant_room,
	))

	var/static/list/bioscrambler_areas = bioscrambler_inclusions - bioscrambler_exclusions

	log_game("ICES: Anomaly: Bioscrambler: [length(bioscrambler_inclusions)] areas cached for selection")
	var/list/possible_areas = typecache_filter_list(GLOB.areas, bioscrambler_areas)
	if(!length(possible_areas))
		CRASH("No valid areas for anomaly found.")

	var/area/landing_area = pick(possible_areas)
	log_game("ICES: Anomaly: Bioscrambler: [landing_area.name] selected for spawn")
	var/list/turf_test = get_area_turfs(landing_area)
	if(!turf_test.len)
		CRASH("Anomaly : No valid turfs found for [landing_area] - [landing_area.type]")

	return landing_area
