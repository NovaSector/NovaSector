/*
 * Moving the two fixtures a home cannot do without.
 *
 * The console unbolts and gets dragged like any other machine. The door is a turf, so it cannot be
 * dragged at all - taking it down hands the player a flat pack, and using that on a wall hangs it
 * somewhere else. Both are marked TRAIT_HOME_FURNISHING, so neither can be walked out of the home,
 * and both persist through a save: the console through its anchored var, the door through the
 * replaced_type it remembers.
 */

/// A front door in a flat pack. Only exists between a player taking one down and hanging it again.
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
	// A door needs somewhere to open onto, or the player hangs it facing the cordon and the home
	// looks broken for no reason they can see.
	if(!home.has_open_neighbour(target_wall))
		balloon_alert(user, "nothing behind it!")
		return ITEM_INTERACT_BLOCKING

	home.hang_door(target_wall)
	balloon_alert(user, "door hung")
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/// Turns a wall into this home's front door, remembering the wall so it can be put back. Pure
/// mechanism - every "is this yours, is this a wall, does it lead anywhere" question belongs to the
/// caller, which is what lets the loader fit a door without a player being involved at all.
/datum/home_instance/proc/hang_door(turf/closed/target_wall)
	var/replacing = target_wall.type
	var/turf/closed/indestructible/hoteldoor/fakedoor/player_home/hung = target_wall.ChangeTurf(/turf/closed/indestructible/hoteldoor/fakedoor/player_home)
	if(isnull(hung))
		return null
	hung.replaced_type = replacing
	hung.parentSphere = parent_terminal
	ADD_TRAIT(hung, TRAIT_HOME_FURNISHING, HOME_FURNISHING_TRAIT)
	// You arrive through the front door, so where the door is *is* where you arrive. Without this the
	// landing spot stays wherever the starter interior put it, and a player who moves their door keeps
	// being dropped in the old room.
	move_landing_to_doorstep(hung)
	return hung

/// Points the landing spot at an open tile beside the given door, in the 0-based offset form the
/// sidecar stores. Leaves it alone if the door has nothing open beside it - get_landing_turf() can
/// cope with a stale offset, but there is no sense writing a worse one.
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
