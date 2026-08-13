/datum/aas_config_entry/supply_shuttle_overcrowding
	name = "Cargo Alert: Supply Shuttle Overcrowding"
	announcement_lines_map = list(
		"First Notice" = "The supply shuttle has low free space. Some orders may not be confirmed. Consider removing objects from the shuttle.",
		"Second Notice" = "The supply shuttle still has low free space. Consider removing objects from the shuttle.",
		"Blocked" = "The supply shuttle has no free space for cargo to be loaded onto. Orders are not being confirmed. Clear the shuttle of blockages to start receiving orders again.",
	)

/obj/docking_port/mobile
	/// Does this shuttle play sounds upon landing and takeoff?
	var/shuttle_sounds = TRUE
	/// The take off sound to be played
	var/takeoff_sound = sound('modular_nova/modules/advanced_shuttles/sound/engine_startup.ogg')
	/// The landing sound to be played
	var/landing_sound = sound('modular_nova/modules/advanced_shuttles/sound/engine_landing.ogg')
	/// The sound range coeff for the landing and take off sound effect
	var/sound_range = 11

/obj/docking_port/mobile/proc/bolt_all_doors() // Expensive procs :(
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	// List off non-external airlocks with id_tag and id_tags of external airlock
	// If its string - its used by non-external airlock to check if it has same id_tag and it needs to be bolted
	// If its entity - its entity of non-external airlock, that MAY be bolted later if external one with same id_tag found
	var/list/airlock_cache = list()
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]

		// Do not touch station airlocks
		if (!shuttle_areas[get_area(checked_turf)])
			continue

		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			if(airlock_door.external)
				airlock_door.close(force_crush = TRUE)
				airlock_door.bolt()
				// If airlock is controlled - bolt all airlocks with same id, to avoid different bolt state on airlocks binded to same button
				if(airlock_door.id_tag)
					// Let non-external airlocks after us know, that they should bolt themself
					airlock_cache[airlock_door.id_tag] = TRUE
					// For every non-external airlock that we already iterated through
					for(var/obj/machinery/door/airlock/synced_door in airlock_cache)
						if (synced_door.id_tag == airlock_door.id_tag)
							synced_door.close(force_crush = TRUE)
							synced_door.bolt()
							airlock_cache -= synced_door

			// If we are non-external, but we having id - there is possibility of external airlock with same id, if so - we want be bolted too
			// That is needed to avoid different bolt state on airlocks binded to same button
			else if(airlock_door.id_tag)
				// It already was external airlock with same id
				if(airlock_cache[airlock_door.id_tag])
					airlock_door.close(force_crush = TRUE)
					airlock_door.bolt()
					continue
				// There was none, so let it handle our bolting, if there will be any external at all
				airlock_cache += airlock_door

/obj/docking_port/mobile/proc/unbolt_all_doors()
	var/list/turfs = return_ordered_turfs(x, y, z, dir)
	for(var/i in 1 to turfs.len)
		var/turf/checked_turf = turfs[i]

		// Do not touch station airlocks
		if (!shuttle_areas[get_area(checked_turf)])
			continue

		for(var/obj/machinery/door/airlock/airlock_door in checked_turf)
			if(airlock_door.external)
				airlock_door.unbolt()

/obj/docking_port/mobile/proc/play_engine_sound(atom/distant_source, takeoff)
	if(distant_source)
		for(var/mob/hearing_mob in range(sound_range, distant_source))
			if(!hearing_mob?.client)
				continue
			var/volume_pref_modifier = hearing_mob.client.prefs.read_preference(/datum/preference/numeric/volume/sound_ship_ambience_volume) / 100
			if(volume_pref_modifier == 0)
				continue
			var/dist = get_dist(hearing_mob.loc, distant_source.loc)
			var/vol = clamp(40 - ((dist - 3) * 5) * volume_pref_modifier, 0, 40) // Every tile decreases sound volume by 5
			hearing_mob.playsound_local(distant_source, takeoff ? takeoff_sound : landing_sound, vol)

/obj/docking_port/mobile/supply
	/// Number of times there's been an announcement for overcrowding on the shuttle
	var/static/overcrowding_announcements = 0
	/// These *objects* will not be considered as blocking a tile
	var/static/list/ignored_objects = typecacheof(list(
		/obj/effect,
		/obj/machinery/light,
		/obj/machinery/button,
	))

/// Returns FALSE if a turf is blocked by a dense object
/// or has objects in its contents that aren't ignored
/obj/docking_port/mobile/supply/proc/turf_is_occupied(turf/open/shuttle_turf)
	for(var/obj/object in shuttle_turf.contents)
		if(object.density)
			return TRUE
		if(!is_type_in_typecache(object, ignored_objects))
			return TRUE

/// Announces that all turfs are blocked and orders aren't being confirmed
/obj/docking_port/mobile/supply/proc/announce_rejection()
	// I thought of having a cooldown for this, but the station is
	// being deprived of orders at this stage so it's whatever
	aas_config_announce(
		/datum/aas_config_entry/supply_shuttle_overcrowding,
		variables_map = list(),
		source = null,
		channels = list(RADIO_CHANNEL_SUPPLY),
		announcement_line = "Blocked",
		command_span = TRUE,
	)

/// Announces that many turfs are blocked and some orders may not be confirmed
/obj/docking_port/mobile/supply/proc/announce_overcrowding()
	if(overcrowding_announcements >= 2)
		return // if you really want the shuttle to be full of shit and know the downsides...
	overcrowding_announcements++
	aas_config_announce(
		/datum/aas_config_entry/supply_shuttle_overcrowding,
		variables_map = list(),
		source = null,
		channels = list(RADIO_CHANNEL_SUPPLY),
		announcement_line = overcrowding_announcements < 2 ? "First Notice" : "Second Notice",
	)
