/// The way out of a home, and the choke point the closed economy is enforced at. Subtyped off the
/// condo fake door so it inherits the floor underlay that makes it read as a real doorway.
/turf/closed/indestructible/hoteldoor/fakedoor/player_home
	name = "home door"
	desc = "The front door of a private residence. Anything the residence owns stays on this side of it."
	floor_to_copy = /turf/open/floor/wood
	/// What to put back underneath if this door is ever taken down. Set when a player hangs one;
	/// the default here covers doors that came with a starter interior and were never moved.
	var/turf/replaced_type = /turf/closed/wall

/// Without this the door forgets where it came from the moment it is saved, and taking down a door
/// a player had relocated would wall them in with the mapper's default instead of their own wall.
/turf/closed/indestructible/hoteldoor/fakedoor/player_home/get_save_vars()
	. = ..()
	. += NAMEOF(src, replaced_type)
	return .

/**
 * BYOND reuses a turf's datum in place when its type changes, so anything this door registered in
 * Initialize() outlives the door itself. The screentip context registration is the one that bites:
 * take a door down, hang another on the same tile later - or let the reservation be recycled into
 * somebody else's home - and the new door's register_context() collides with the leftover one.
 *
 * Only this subtype needs it. Condo and hotel doors are never changed into anything else.
 */
/turf/closed/indestructible/hoteldoor/fakedoor/player_home/ChangeTurf(path, list/new_baseturfs, flags)
	UnregisterSignal(src, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM)
	flags_1 &= ~HAS_CONTEXTUAL_SCREENTIPS_1
	return ..()

/turf/closed/indestructible/hoteldoor/fakedoor/player_home/examine(mob/user)
	. = ..()
	. += span_info("Alt-Click to look through the peephole.")
	. += span_notice("The registry console can take it down and hand it to you, if you would rather it were somewhere else.")

/turf/closed/indestructible/hoteldoor/fakedoor/player_home/promptExit(mob/living/user)
	if(!isliving(user) || !user.mind)
		return
	var/datum/home_instance/home = get_home_of(src)
	if(isnull(home))
		return ..() // orphaned door in some other context - let the hotel handle it
	if(isnull(home.parent_terminal))
		to_chat(user, span_warning("The door seems to be malfunctioning and refuses to operate!"))
		return

	var/prompt = "Anything belonging to the residence will be left on the floor behind you; your own \
		belongings come with you. [home.save_state_blurb()] Anything you have changed since then is \
		lost once the last person walks out. Ready to leave?"
	if(tgui_alert(user, prompt, "Exit", list("Leave", "Stay")) != "Leave")
		return
	//no teleporting around if they died or wandered off during the prompt
	if(HAS_TRAIT(user, TRAIT_IMMOBILIZED) || (get_dist(get_turf(src), get_turf(user)) > 1))
		return
	home.evict(user)
