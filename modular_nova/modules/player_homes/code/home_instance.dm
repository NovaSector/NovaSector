/// The home the given atom is standing in, or null if it isn't in one.
/proc/get_home_of(atom/target)
	var/area/misc/player_home/home_area = get_area(target)
	return istype(home_area) ? home_area.home : null

/// One player's home, loaded into a turf reservation for as long as somebody is standing in it.
/datum/home_instance
	/// The account this home belongs to. Homes are per-ckey, so every character shares one.
	var/owner_ckey
	/// The cafe terminal occupants warp back out to.
	var/obj/machinery/home_terminal/parent_terminal
	var/datum/turf_reservation/player_home/reservation
	/// Name of the starter this home grew from. Carried in the sidecar so a reset knows what to put
	/// back, and so an unreadable save can fall all the way through to a known-good interior.
	var/starter_name
	/// Landing spot, as an offset from the reservation's bottom-left turf. Same 0-based convention
	/// the condo templates use for landing_zone_x_offset.
	var/landing_x = 1
	var/landing_y = 1
	/// When this home was last written to disk, for the exit prompt. Null if it never has been.
	var/last_saved

	// Room settings. All three live in the sidecar rather than in the .dmm - they describe the
	// residence rather than anything standing in it, and keeping them out of the map file means
	// changing one costs nothing and never risks the save.
	/// HOME_BRIGHTNESS_MIN (out) through HOME_BRIGHTNESS_MAX (bright).
	var/brightness = 2
	/// "#rrggbb" bulb colour, or "" to leave every fixture on its own default.
	var/lamp_color = ""
	/// FALSE floats the whole residence.
	var/gravity = TRUE

/datum/home_instance/Destroy(force)
	if(!isnull(reservation))
		reservation.home = null
		reservation = null
	parent_terminal = null
	return ..()

/// Where to drop somebody arriving in this home. Falls back through the doorstep to any open turf,
/// so a player who builds a wall over their own landing spot can never lock themselves out.
/datum/home_instance/proc/get_landing_turf()
	if(isnull(reservation))
		return null
	var/turf/bottom_left = reservation.bottom_left_turfs[1]
	if(isnull(bottom_left))
		return null

	var/turf/landing = locate(bottom_left.x + landing_x, bottom_left.y + landing_y, bottom_left.z)
	if(!isnull(landing) && !landing.density)
		return landing

	var/turf/door = find_door()
	if(!isnull(door))
		for(var/turf/open/doorstep in orange(1, door))
			if(!doorstep.density && (doorstep in reservation.reserved_turfs))
				return doorstep

	for(var/turf/open/anywhere in reservation.reserved_turfs)
		if(!anywhere.density)
			return anywhere
	return null

/// Somewhere to land a supply pod: an open tile with nothing solid on it and nobody standing there,
/// so a delivery never crushes the person who ordered it or drops into a wall. Falls back to the
/// landing spot, which is always somewhere a body can stand.
/datum/home_instance/proc/get_delivery_turf()
	if(isnull(reservation))
		return null
	var/list/candidates = list()
	for(var/turf/open/candidate in reservation.reserved_turfs)
		if(candidate.density)
			continue
		var/blocked = FALSE
		for(var/atom/movable/occupant in candidate)
			if(occupant.density)
				blocked = TRUE
				break
		if(!blocked)
			candidates += candidate
	if(length(candidates))
		return pick(candidates)
	return get_landing_turf()

/// The home's exit door. Every interior needs one; loading self-heals if a save has lost it.
/datum/home_instance/proc/find_door()
	if(isnull(reservation))
		return null
	for(var/turf/closed/indestructible/hoteldoor/door in reservation.reserved_turfs)
		return door
	return null

/// The save console. Loading guarantees exactly one of these exists.
/datum/home_instance/proc/find_console()
	if(isnull(reservation))
		return null
	for(var/turf/reserved as anything in reservation.reserved_turfs)
		var/obj/machinery/home_saver/console = locate() in reserved
		if(!isnull(console))
			return console
	return null

/// TRUE if this movable belongs to the home rather than to whoever is carrying it. The whole
/// anti-duplication scheme reduces to this one question - see TRAIT_HOME_FURNISHING.
/datum/home_instance/proc/owns(atom/movable/thing)
	return HAS_TRAIT(thing, TRAIT_HOME_FURNISHING)

/// TRUE if this mob is the account that owns this home.
/datum/home_instance/proc/is_owner(mob/user)
	return user?.ckey && (user.ckey == owner_ckey)

/// A line for the exit prompt, so leaving is never a surprise about what's about to be lost.
/datum/home_instance/proc/save_state_blurb()
	if(isnull(last_saved))
		return "This home has never been saved."
	return "You last saved on [last_saved] (UTC)."

/**
 * The closed economy, enforced. Everything that belongs to the home is taken back off a departing
 * occupant, wherever in their kit they stashed it; their own belongings are left alone.
 *
 * force = TRUE matters. A furnishing that gains TRAIT_NODROP when picked up would otherwise be a
 * smuggling channel straight out of a save file. get_equipped_items() is not used here for the same
 * reason it would be tempting to - we need to reach inside bags, not just the equipment slots.
 */
/datum/home_instance/proc/strip_belongings(mob/living/user)
	var/turf/drop_spot = get_turf(user)
	if(isnull(drop_spot))
		return 0
	user.stop_pulling()
	user.unbuckle_all_mobs(force = TRUE)

	var/left_behind = 0
	for(var/atom/movable/carried as anything in user.get_all_contents())
		if(!owns(carried))
			continue
		// Its container is a furnishing too and is already on its way out - let it ride, rather than
		// tipping the contents of somebody's saved backpack onto the floor.
		if(ismovable(carried.loc) && owns(carried.loc))
			continue
		if(isitem(carried))
			user.transferItemToLoc(carried, drop_spot, force = TRUE, silent = TRUE)
		else
			carried.forceMove(drop_spot)
		left_behind++
	return left_behind

/// Strips an occupant and sends them back to the terminal they came in through.
/datum/home_instance/proc/evict(mob/living/user)
	// Confirm they can actually leave before going through their pockets.
	var/turf/destination = get_turf(parent_terminal)
	if(isnull(destination))
		to_chat(user, span_warning("The door refuses to operate - its far side has gone missing!"))
		return FALSE
	var/left_behind = strip_belongings(user)
	user.forceMove(destination)
	do_sparks(3, FALSE, get_turf(user))
	if(left_behind)
		to_chat(user, span_notice("You leave [left_behind] item\s behind. Nothing that belongs to a home may be carried out of it."))
	return TRUE

/// Turns everyone out, for a revert or a reset that needs to rebuild the rooms from scratch.
/// Everything is snapshotted up front: the last eviction releases the reservation and deletes this
/// datum out from under us, so nothing here may touch src's state after the loop begins.
/datum/home_instance/proc/evict_all()
	var/turf/destination = get_turf(parent_terminal)
	var/area/misc/player_home/home_area = get_area(reservation?.bottom_left_turfs[1])
	if(!istype(home_area))
		return
	var/list/occupants = list()
	for(var/mob/living/occupant as anything in home_area.get_all_contents_type(/mob/living)) // catches anyone hiding in anything
		if(occupant.mind)
			occupants += occupant
	for(var/mob/living/occupant as anything in occupants)
		strip_belongings(occupant)
		if(isnull(destination))
			continue
		occupant.forceMove(destination)
		do_sparks(3, FALSE, get_turf(occupant))
