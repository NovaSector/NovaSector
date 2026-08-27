/*
 * The front door: the way out of a home, and the choke point the closed economy is enforced at. It
 * is a turf, so it cannot be dragged - taking it down hands the player a flat pack, and using that
 * on a wall hangs it elsewhere. Both are marked TRAIT_HOME_FURNISHING, so neither can be walked out.
 *
 * We subtype it off the condo fake door for ease of use.
 */

/turf/closed/indestructible/hoteldoor/fakedoor/player_home
	name = "home door"
	desc = "The front door of a private residence. Anything the residence owns stays on this side of it."
	floor_to_copy = /turf/open/floor/wood
	baseturfs = /turf/open/floor/plating
	/// What to put back underneath if this door is ever taken down. Set when a player hangs one;
	/// the default here covers doors that came with a starter interior and were never moved.
	var/turf/replaced_type = /turf/closed/wall

/// Without this the door forgets where it came from the moment it is saved, and taking down a door
/// a player had relocated would wall them in with the mapper's default instead of their own wall.
/turf/closed/indestructible/hoteldoor/fakedoor/player_home/get_save_vars()
	. = ..()
	. += NAMEOF(src, replaced_type)
	return .

/*
 * Turfs keep their signal registrations when their type changes. ChangeTurf() copies them onto the
 * replacement deliberately.
 *
 * Both /turf/closed/wall and the hotel door call register_context(), so any turf that has been
 * either leaves a live COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM behind when it becomes something
 * else. The next thing to register on that turf collides with the corpse of the last one and eats a
 * runtime. Call this anywhere we change a turf's type or hand a reservation back.
 */
/proc/clear_home_screentip_context(turf/target)
	if(isnull(target))
		return
	target.UnregisterSignal(target, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM)
	target.flags_1 &= ~HAS_CONTEXTUAL_SCREENTIPS_1

/turf/closed/indestructible/hoteldoor/fakedoor/player_home/ChangeTurf(path, list/new_baseturfs, flags)
	clear_home_screentip_context(src)
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

/// When you tell the console you want to move your door, you get a flatpacked door. Makes perfect sense.
/obj/item/home_door_kit
	name = "flat-packed front door"
	desc = "A front door, disassembled and bundled for carrying. Use it on any wall inside your \
		residence to hang it there. Your residence cannot be filed without one hung."
	icon = /obj/item/stack/sheet/mineral/wood::icon
	icon_state = /obj/item/stack/sheet/mineral/wood::icon_state
	inhand_icon_state = /obj/item/stack/sheet/mineral/wood::inhand_icon_state
	lefthand_file = /obj/item/stack/sheet/mineral/wood::lefthand_file
	righthand_file = /obj/item/stack/sheet/mineral/wood::righthand_file
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// The turf type to put back underneath if this door is ever taken down again.
	var/turf/replaced_type = /turf/closed/wall

/obj/item/home_door_kit/examine(mob/user)
	. = ..()
	. += span_notice("Use it on a wall inside your residence to hang it.")

/obj/item/home_door_kit/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isclosedturf(interacting_with))
		return NONE
	var/turf/closed/target_wall = interacting_with

	var/datum/home_instance/home = get_home_of(target_wall)
	if(isnull(home) || !(target_wall in home.reservation.reserved_turfs))
		balloon_alert(user, "not inside your residence!")
		return ITEM_INTERACT_BLOCKING
	if(!home.is_owner(user))
		balloon_alert(user, "not your residence!")
		return ITEM_INTERACT_BLOCKING
	if(istype(target_wall, /turf/closed/indestructible/hoteldoor))
		balloon_alert(user, "already a door!")
		return ITEM_INTERACT_BLOCKING
	// A door needs somewhere to open onto, or it ends up facing the cordon and looks broken.
	if(!home.has_open_neighbour(target_wall))
		balloon_alert(user, "nothing behind it!")
		return ITEM_INTERACT_BLOCKING

	home.hang_door(target_wall)
	balloon_alert(user, "door hung")
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/// Turns a wall into this home's front door, remembering the wall so it can be put back if needed.
/datum/home_instance/proc/hang_door(turf/closed/target_wall)
	var/replacing = target_wall.type
	// The wall registered a screentip context and the door is about to register its own onto the same turf datum.
	clear_home_screentip_context(target_wall)
	var/turf/closed/indestructible/hoteldoor/fakedoor/player_home/hung = target_wall.ChangeTurf(/turf/closed/indestructible/hoteldoor/fakedoor/player_home)
	if(isnull(hung))
		return null
	hung.replaced_type = replacing
	hung.parentSphere = parent_terminal
	ADD_TRAIT(hung, TRAIT_HOME_FURNISHING, HOME_FURNISHING_TRAIT)
	// You arrive through the front door, so where the door is *is* where you arrive.
	move_landing_to_doorstep(hung)
	return hung

/// Points the landing spot at an open tile beside the given door, in the 0-based offset form the
/// sidecar stores. Left alone if the door has nothing open beside it: get_landing_turf() copes with
/// a stale offset, and there is no sense writing a worse one.
/datum/home_instance/proc/move_landing_to_doorstep(turf/door)
	if(isnull(reservation) || isnull(door))
		return
	var/turf/bottom_left = reservation.bottom_left_turfs[1]
	if(isnull(bottom_left))
		return
	for(var/turf/open/doorstep in orange(1, door))
		if(doorstep.density || !(doorstep in reservation.reserved_turfs))
			continue
		landing_x = doorstep.x - bottom_left.x
		landing_y = doorstep.y - bottom_left.y
		return

/// Takes the home's door back down and hands the player the flat pack. Returns TRUE if it worked.
/datum/home_instance/proc/uninstall_door(mob/living/user)
	var/turf/closed/indestructible/hoteldoor/fakedoor/player_home/standing = find_door()
	if(isnull(standing))
		to_chat(user, span_warning("There is no door hung to take down."))
		return FALSE

	var/obj/item/home_door_kit/flat_pack = new(get_turf(user))
	if(istype(standing))
		flat_pack.replaced_type = standing.replaced_type
	// Marked like anything else the home owns, so a player cannot walk off with the front door.
	ADD_TRAIT(flat_pack, TRAIT_HOME_FURNISHING, HOME_FURNISHING_TRAIT)
	standing.ChangeTurf(flat_pack.replaced_type)
	user.put_in_hands(flat_pack)
	return TRUE

/// TRUE if the given turf has an open turf beside it that is part of this home - i.e. a door hung
/// there would actually lead somewhere.
/datum/home_instance/proc/has_open_neighbour(turf/target)
	if(isnull(reservation))
		return FALSE
	for(var/turf/open/neighbour in orange(1, target))
		if(!neighbour.density && (neighbour in reservation.reserved_turfs))
			return TRUE
	return FALSE
