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
	/// The starter this home grew from. Lets a reset know what to put back, and gives an unreadable
	/// save something known-good to fall through to.
	var/starter_name
	/// Landing spot, as a 0-based offset from the reservation's bottom-left turf.
	var/landing_x = 1
	var/landing_y = 1
	/// TRUE once the owner has picked the landing spot by hand. Moving the door stops moving the
	/// landing spot after that: their choice outranks whatever tile the door happens to open onto.
	var/landing_pinned = FALSE
	/// When this home was last written to disk, for the exit prompt. Null if it never has been.
	var/last_saved

	// Room settings. All three live in the sidecar rather than the .dmm, so changing one never
	// touches the save.
	/// HOME_BRIGHTNESS_MIN (out) through HOME_BRIGHTNESS_MAX (bright).
	var/brightness = 2
	/// "#rrggbb" bulb colour, or "" to leave every fixture on its own default.
	var/lamp_color = ""
	/// FALSE floats the whole residence.
	var/gravity = TRUE

	/// FALSE takes the owner off the terminal's door list entirely, so nobody can knock.
	var/accepts_knocks = TRUE

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

/// Where a supply pod lands: on the console the order was placed at. Any unblocked open tile sounds
/// fairer and is much worse - that includes tiles the player has since walled off from themselves.
/datum/home_instance/proc/get_delivery_turf()
	if(isnull(reservation))
		return null
	var/obj/machinery/home_saver/console = find_console()
	if(!isnull(console))
		return get_turf(console)
	return get_landing_turf()

/// The home's exit door. Every interior needs one; loading self-heals if a save has lost it somehow.
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
/// anti-duplication scheme reduces to this one question.
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

/// The closed economy, enforced: everything belonging to the home is taken back off a departing
/// occupant, wherever in their kit they stashed it. force = TRUE matters - a furnishing that gains
/// TRAIT_NODROP when picked up would otherwise smuggle straight out of a save file. get_all_contents
/// rather than get_equipped_items() because we need to reach inside bags, not just the slots.
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

/// Turns everyone out, for a revert or a reset that rebuilds the rooms from scratch. Everything is
/// snapshotted up front: the last eviction releases the reservation and deletes this datum out from
/// under us, so nothing here may touch src's state after the loop begins.
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

/*
 * Room settings: lighting and gravity, set from the console and kept in the sidecar.
 */

/// A valid "#rrggbb" bulb colour, or "" for each fixture's own default. Never trusts a client string.
/proc/sanitize_home_lamp_color(color)
	var/static/regex/hex_color = regex(@"^#[0-9a-fA-F]{6}$")
	return (color && hex_color.Find(color)) ? color : ""

/// Pushes the stored brightness and bulb colour onto every light fixture in the home.
/datum/home_instance/proc/apply_lights()
	if(isnull(reservation))
		return
	var/color = sanitize_home_lamp_color(lamp_color)
	var/level = clamp(round(brightness), HOME_BRIGHTNESS_MIN, HOME_BRIGHTNESS_MAX)
	var/lights_out = (level <= HOME_BRIGHTNESS_MIN)
	/// bulb_power multiplier for brightness 1 through 3
	var/static/list/power_steps = list(0.5, 1, 1.7)

	// Set the area switch first, so the fixtures aren't fighting their own power state on the way.
	var/area/home_area = get_area(reservation.bottom_left_turfs[1])
	if(!isnull(home_area))
		home_area.lightswitch = !lights_out
		home_area.power_change()

	for(var/turf/reserved as anything in reservation.reserved_turfs)
		for(var/obj/machinery/light/fixture in reserved)
			if(lights_out)
				fixture.set_on(FALSE) // straight at the fixture; don't trust the power signal alone
				continue
			fixture.bulb_power = power_steps[level]
			fixture.bulb_colour = color || initial(fixture.bulb_colour)
			fixture.set_on(TRUE)
			// set_on() no-ops on an already-lit fixture whose colour and power we just changed. No
			// trigger or sound: this runs across a whole room.
			fixture.update(trigger = FALSE, play_sound = FALSE)
		CHECK_TICK

/// Turns the home's gravity on or off. The area flag is the only lever that works: has_gravity()
/// reads SSmapping.gravity_by_z_level[z] first and short-circuits past area.default_gravity, so on a
/// reservation z-level that has gravity, clearing default_gravity would do nothing at all.
/datum/home_instance/proc/apply_gravity()
	if(isnull(reservation))
		return
	var/area/home_area = get_area(reservation.bottom_left_turfs[1])
	if(isnull(home_area))
		return
	if(gravity)
		home_area.area_flags &= ~NO_GRAVITY
	else
		home_area.area_flags |= NO_GRAVITY
	// Mobs cache their gravity state, so they have to be told. Objects re-check on every move.
	for(var/mob/living/occupant as anything in home_area.get_all_contents_type(/mob/living))
		occupant.refresh_gravity()

/// Re-applies everything the sidecar remembers. Called once on load, and again on every change.
/datum/home_instance/proc/apply_settings()
	apply_lights()
	apply_gravity()

/area/misc/player_home
	name = "Home"
	icon = 'modular_nova/modules/condos/icons/area.dmi'
	icon_state = "condo"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = NOTELEPORT | HIDDEN_AREA | UNLIMITED_FISHING | NO_DEATH_MESSAGE
	// Deliberately not UNIQUE_AREA: only unique areas register in GLOB.areas_by_type, and the loader
	// reuses a registered area, so NONE here is what gives each loaded home its own area instance.
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
/// always explicit, which is what keeps a griefed home off the disk.
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
