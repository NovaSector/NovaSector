#define SALVAGE_SHUTTLE_STRINGS "nova/salvage_shuttle.json"

#define SALVAGE_SHUTTLE_OLDEST_PRODUCED (1990 + STATION_YEAR_OFFSET)
#define SALVAGE_SHUTTLE_NEWEST_PRODUCED (2004 + STATION_YEAR_OFFSET)
#define SALVAGE_SHUTTLE_LATEST_USED (2025 + STATION_YEAR_OFFSET)

/datum/map_template/shuttle/salvage_scrap
	name = "DEBUG: Salvage Shuttle Basetype"
	description = "Surely there would be a ship here."
	shuttle_id = "shuttle_salvage_scrap"
	port_id = "salvage"
	prefix = "_maps/shuttles/nova/salvage/"
	who_can_purchase = null
	width = 35
	height = 24
	/// Is this ship going to show up in the random ships from the salvage controller?
	var/shows_up_as_salvage = TRUE
	/// The name of the ship before it got abandoned, randomized if null
	var/prior_name = null
	/// A general ship class, similarly shaped ships should have the same class to help players
	var/ship_class = "UNKNOWN"
	/// What the ship was doing before it got abandoned, tells players what to expect inside the ship
	var/prior_usage = "BEING BROKEN"
	/// Overridden by prior_owner_datum if set, subtypes of datums in this list will be picked randomly for a shuttle owner
	var/list/random_owner_types = list()
	/// Who owned the ship before it was salvage, randomized if null
	var/datum/shipbreaking_owner/prior_owner_datum = null
	/// Operation date, "(year) to (year)", randomized if empty
	var/prior_date = null
	/// What kind of hazards the crews could expect to be in the ship, unknown by default
	var/list/ship_hazards = list()

/datum/map_template/shuttle/salvage_scrap/New()
	. = ..()
	if(!prior_name)
		prior_name = pick_list_replacements(SALVAGE_SHUTTLE_STRINGS, "ship_name")
	if(!prior_owner_datum)
		var/list/random_owner_subtypes = list()
		for(var/datum/shipbreaking_owner/past_owner_type as anything in random_owner_types)
			random_owner_subtypes += subtypesof(past_owner_type)
		prior_owner_datum = pick(random_owner_subtypes)
	if(!prior_date)
		prior_date = "[rand(SALVAGE_SHUTTLE_OLDEST_PRODUCED, SALVAGE_SHUTTLE_NEWEST_PRODUCED)] to [rand(SALVAGE_SHUTTLE_NEWEST_PRODUCED, SALVAGE_SHUTTLE_LATEST_USED)]"

/datum/map_template/shuttle/salvage_scrap/post_load(obj/docking_port/mobile/shuttle_port)
	. = ..()
	var/area/shuttle_area = get_area(shuttle_port)
	for(var/atom/recolorable_thing as anything in shuttle_area.contents)
		if(HAS_TRAIT(recolorable_thing, TRAIT_SHIP_PRIMARY_COLOUR))
			recolorable_thing.color = prior_owner_datum.ship_primary_colour
		else if(HAS_TRAIT(recolorable_thing, TRAIT_SHIP_SECONDARY_COLOUR))
			recolorable_thing.color = prior_owner_datum.ship_secondary_colour

/obj/docking_port/mobile/salvage
	name = "salvaged shuttle"
	shuttle_id = "shuttle_salvage_scrap"
	callTime = 15 SECONDS
	rechargeTime = 30 SECONDS
	prearrivalTime = 10 SECONDS
	preferred_direction = EAST
	dir = NORTH
	port_direction = EAST
	movement_force = list(
		"KNOCKDOWN" = 2,
		"THROW" = 0,
	)

/obj/docking_port/mobile/salvage/canDock(obj/docking_port/stationary/stationary_dock)
	if(!stationary_dock)
		return SHUTTLE_CAN_DOCK
	if(!istype(stationary_dock))
		return SHUTTLE_NOT_A_DOCKING_PORT
	if(stationary_dock.override_can_dock_checks)
		return SHUTTLE_CAN_DOCK
	// check the dock isn't occupied
	var/currently_docked = stationary_dock.get_docked()
	if(currently_docked)
		// by someone other than us
		if(currently_docked != src)
			return SHUTTLE_SOMEONE_ELSE_DOCKED
		else
		// This isn't an error, per se, but we can't let the shuttle code
		// attempt to move us where we currently are, it will get weird.
			return SHUTTLE_ALREADY_DOCKED
	return SHUTTLE_CAN_DOCK

/// Checks if any items in the areas of the docking port would be blocked by the cargo shuttle, and so shouldn't be deleted here
/obj/docking_port/mobile/salvage/proc/check_blacklist()
	for(var/area/shuttle_area as anything in shuttle_areas)
		for (var/list/zlevel_turfs as anything in shuttle_area.get_zlevel_turf_lists())
			for(var/turf/shuttle_turf as anything in zlevel_turfs)
				for(var/atom/passenger in shuttle_turf.get_all_contents())
					if((is_type_in_typecache(passenger, GLOB.blacklisted_salvage_removal_types) || HAS_TRAIT(passenger, TRAIT_BANNED_FROM_CARGO_SHUTTLE)) && !istype(passenger, /obj/docking_port))
						return FALSE
	return TRUE

/area/shuttle/salvaged_shuttle
	name = "Shuttle Salvage"
	requires_power = TRUE
	always_unpowered = FALSE
	power_equip = FALSE
	power_light = FALSE
	power_environ = TRUE
	power_apc_charge = FALSE
	default_gravity = ZERO_GRAVITY
	area_flags = NO_GRAVITY
	area_limited_icon_smoothing = /area/shuttle/salvaged_shuttle

#undef SALVAGE_SHUTTLE_STRINGS
#undef SALVAGE_SHUTTLE_OLDEST_PRODUCED
#undef SALVAGE_SHUTTLE_NEWEST_PRODUCED
#undef SALVAGE_SHUTTLE_LATEST_USED
