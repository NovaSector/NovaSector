/area/misc/player_home
	name = "Home"
	icon = 'modular_nova/modules/condos/icons/area.dmi'
	icon_state = "condo"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = NOTELEPORT | HIDDEN_AREA | UNLIMITED_FISHING | NO_DEATH_MESSAGE
	// Deliberately not UNIQUE_AREA. Only unique areas register in GLOB.areas_by_type, and the map
	// loader reuses a registered area rather than making a new one - so leaving this NONE is what
	// gives every loaded home its own area instance. /area/misc/condo does the same for the same
	// reason.
	area_flags_mapping = NONE
	static_lighting = TRUE
	mood_bonus = /area/centcom/holding::mood_bonus
	mood_message = /area/centcom/holding::mood_message
	/// The home loaded into these turfs.
	var/datum/home_instance/home
	/// Set while the home is being torn down, so the egress guard doesn't fight the cleanup.
	var/releasing = FALSE

/area/misc/player_home/Destroy()
	home = null
	return ..()

/area/misc/player_home/Exited(atom/movable/gone, direction)
	. = ..()
	if(releasing || isnull(home))
		return
	if(ismob(gone))
		check_for_departure(gone)
		return
	block_egress(gone)

/// Nobody minded left inside? Let the reservation go. Nothing is saved on the way out - saving is
/// always an explicit act at the console, which is what keeps a griefed home off the disk.
/area/misc/player_home/proc/check_for_departure(mob/gone)
	log_game("[key_name(gone)] has left [home.owner_ckey]'s home")
	for(var/mob/living/occupant as anything in get_all_contents_type(/mob/living)) // catches anyone hiding in anything
		if(occupant.mind)
			return
	releasing = TRUE
	SShomes.release_home(home)
	home = null

/// Closed-economy backstop. The door's strip is the real enforcement; this only catches anything
/// that finds some other way across the boundary. Deferred by a tick because moving an atom from
/// inside its own Exited() is a re-entrancy hazard.
/area/misc/player_home/proc/block_egress(atom/movable/escapee)
	if(QDELETED(escapee) || ismob(escapee))
		return
	var/turf/back_inside = home.get_landing_turf()
	if(isnull(back_inside))
		return
	addtimer(CALLBACK(src, PROC_REF(drag_back), escapee, back_inside), 0)

/area/misc/player_home/proc/drag_back(atom/movable/escapee, turf/back_inside)
	if(QDELETED(escapee) || QDELETED(back_inside) || (get_area(escapee) == src))
		return
	escapee.forceMove(back_inside)
