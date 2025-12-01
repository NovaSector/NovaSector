#define DEFAULT_SHELF_USE_DELAY 1 SECONDS // Default interaction delay of the shelf
#define DEFAULT_SHELF_VERTICAL_OFFSET 10 // Vertical pixel offset of shelving-related things. Set to 10 by default due to this leaving more of the crate on-screen to be clicked.

/obj/structure/cargo_shelf //Crate shelf port from Shiptest: https://github.com/shiptest-ss13/Shiptest/pull/2374
	name = "crate shelf"
	desc = "It's a shelf! For storing crates!"
	icon = 'modular_nova/modules/shelves/structures.dmi'
	icon_state = "shelf_base"
	density = TRUE
	anchored = TRUE
	max_integrity = 50 // Not hard to break
	/// how many items the shelf can hold. Only supports 3 because that's how many can fit in a 32x32 tile.
	VAR_FINAL/capacity = 3
	/// the delay before the shelf is truly used
	var/use_delay = DEFAULT_SHELF_USE_DELAY
	/// List of which crates are stored where, to keep track of occupied slots
	var/list/crates_stored

/obj/structure/cargo_shelf/Initialize(mapload)
	. = ..()
	crates_stored = new /list(capacity)
	var/stack_layer // This is used to generate the sprite layering of the shelf pieces.
	var/stack_offset // This is used to generate the vertical offset of the shelf pieces.
	for(var/i in 1 to (capacity - 1))
		if(i >= 3) // If we're at or above three, we'll be on the way to going off the tile we're on. This allows mobs to be below the shelf when this happens.
			stack_layer = ABOVE_MOB_LAYER + (0.02 * i) - 0.01
		else
			stack_layer  = BELOW_OBJ_LAYER + (0.02 * i) - 0.01 // Make each shelf piece render above the last, but below the crate that should be on it.
		stack_offset = DEFAULT_SHELF_VERTICAL_OFFSET * i // Make each shelf piece physically above the last.
		var/mutable_appearance/shelf_overlay = mutable_appearance('modular_nova/modules/shelves/structures.dmi', "shelf_stack", layer = stack_layer)
		shelf_overlay.pixel_y = stack_offset
		overlays += shelf_overlay
	return

/obj/structure/cargo_shelf/Destroy()
	spill_contents()
	return ..()

/obj/structure/cargo_shelf/examine(mob/user)
	. = ..()
	. += span_notice("There are some <b>bolts</b> holding [src] together.")
	if(crate_count() < capacity) // If there's an empty space in the shelf, let the examiner know.
		. += span_notice("You could <b>drag and drop</b> a crate into [src].")
	if(crate_count()) // If there are any crates in the shelf, let the examiner know.
		. += span_notice("You could <b>drag and drop</b> a crate out of [src].")
		. += span_notice("[src] contains:")
		for(var/obj/structure/closet/crate/crate in contents)
			. += span_notice("[icon2html(crate, user)] \A [crate]")

/obj/structure/cargo_shelf/wrench_act_secondary(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/structure/cargo_shelf/relay_container_resist_act(mob/living/user, obj/structure/closet/crate)
	to_chat(user, span_notice("You begin attempting to knock [crate] out of [src]"))
	if(do_after(user, 30 SECONDS, target = crate))
		if(!user || user.stat != CONSCIOUS || user.loc != crate || crate.loc != src)
			return // If the user is in a strange condition, return early.
		visible_message(span_warning("[crate] falls off of [src]!"),
			span_notice("You manage to knock [crate] free of [src]"),
			span_notice("You hear a thud."))
		crate.forceMove(get_spill_location()) // Try to push it somewhere

/// Spits out how many crates are currently stored, counting the non nulls
/obj/structure/cargo_shelf/proc/crate_count()
	var/count = 0
	for(var/crate in crates_stored)
		if(crate)
			count++
	return count

/// Returns if this crate can actually be loaded
/obj/structure/cargo_shelf/proc/can_load(obj/structure/closet/crate/crate, mob/user, y_offset)
	if(crate_count() >= capacity) // If we don't find an empty slot, return early.
		balloon_alert(user, "shelf full!")
		return FALSE
	if (y_offset <= 12)
		if(crates_stored[1])
			balloon_alert(user, "shelf occupied!")
			return FALSE
	else if (y_offset <= 21)
		if(crates_stored[2])
			balloon_alert(user, "shelf occupied!")
			return FALSE
	else
		if(crates_stored[3])
			balloon_alert(user, "shelf occupied!")
			return FALSE
	return TRUE

/// proc that will attempt to add something to the contents of the shelf
/obj/structure/cargo_shelf/proc/load(obj/structure/closet/crate/crate, mob/user, y_offset, instant)
	if(!can_load(crate, user, y_offset))
		return FALSE
	if(!instant && !do_after(user, use_delay, target = crate))
		return FALSE // If the do_after() is interrupted, return FALSE!
	crate.add_fingerprint(user)
	if(add_crate(crate, user, y_offset))
		return TRUE

/// proc that will attempt to remove something to the contents of the shelf
/obj/structure/cargo_shelf/proc/unload(obj/structure/closet/crate/crate, mob/user, turf/unload_turf)
	var/unloading_to_turf = istype(unload_turf)
	if(unloading_to_turf && unload_turf.is_blocked_turf(exclude_mobs = TRUE)) // Shelf to shelf
		unload_turf.balloon_alert(user, "no room!")
		return FALSE
	if(!do_after(user, use_delay, target = crate))
		return FALSE
	if(unloading_to_turf && unload_turf.is_blocked_turf(exclude_mobs = TRUE)) // make sure we still are able to put it here
		unload_turf.balloon_alert(user, "no room!")
		return FALSE
	if(!locate(crate) in src)
		return FALSE // If something has happened to the crate while we were waiting, abort!

	// Same shelf - we aren't actually leaving our loc here so Exited won't be called.
	if(unload_turf == src)
		remove_crate(crate)
	else
		crate.forceMove(unload_turf)
	crate.add_fingerprint(user)
	return TRUE

/obj/structure/cargo_shelf/atom_deconstruct(disassembled = TRUE)
	spill_contents()
	if(!disassembled)
		return ..()

	var/obj/item/rack_parts/cargo_shelf/newparts = new(loc)
	transfer_fingerprints_to(newparts)

/// Fling crates around and open/break some of them in the process
/obj/structure/cargo_shelf/proc/spill_contents()
	for(var/obj/structure/closet/crate/crate in contents)
		crate.forceMove(get_spill_location()) // Shuffle the crates around as though they've fallen down.
		crate.SpinAnimation(rand(4,7), 1) // Spin the crates around a little as they fall. Randomness is applied so it doesn't look weird.
		if(prob(75))
			continue
		else
			if(crate.welded || crate.locked)
				continue
			crate.open(force = TRUE) // Break some open, cause a little chaos.
			crate.visible_message(span_warning("[crate]'s lid falls open!"))

// Returns a valid open turf to scatter crates
/obj/structure/cargo_shelf/proc/get_spill_location(radius = 2)
	var/list/buckets = new /list(radius+1)
	for(var/turf/turf_in_view in range(radius, get_turf(src)))
		var/distance = max(get_dist(get_turf(src), turf_in_view), 1)
		if(isclosedturf(turf_in_view))
			continue
		if(isgroundlessturf(turf_in_view) && !GET_TURF_BELOW(turf_in_view))
			continue
		if(turf_in_view.is_blocked_turf(exclude_mobs = TRUE))
			continue

		LAZYADD(buckets[distance], turf_in_view)

	// now return the first non-empty ring
	for(var/i = 1 to radius)
		if(LAZYLEN(buckets[i]))
			if(length(buckets[i]) == 1) // if it's just the same turf as the shelf try other options first
				continue
			return pick(buckets[i])
	return get_turf(src) // fallback on source turf

/obj/structure/closet/crate/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	. = ..()
	if(!isliving(user))
		return

	// -----------------------------------------
	// 1) Unloading from shelf to turf
	// -----------------------------------------
	if (istype(over, /turf/open) && istype(loc, /obj/structure/cargo_shelf))
		if(get_dist(user, over_location) > 1)
			balloon_alert(user, "too far!")
			return
		var/obj/structure/cargo_shelf/shelf = loc
		shelf.unload(src, user, over)
		return

	var/list/modifiers = params2list(params)
	var/y_offset = text2num(modifiers[ICON_Y])

	// -----------------------------------------
	// 2) Shelf to Shelf (drag from one shelf to another)
	// -----------------------------------------
	if (istype(over, /obj/structure/cargo_shelf) && istype(loc, /obj/structure/cargo_shelf))
		var/obj/structure/cargo_shelf/source_shelf = loc
		var/obj/structure/cargo_shelf/destination_shelf = over

		if(destination_shelf.can_load(src, user, y_offset) && source_shelf.unload(src, user, destination_shelf))
			if(!destination_shelf.load(src, user, y_offset, instant = TRUE)) // Might have been filled up in that the time it took to load
				forceMove(source_shelf.get_spill_location()) // So let's get rid of it in that case
		return

	// -----------------------------------------
	// 3) turf to shelf (normal loading)
	// -----------------------------------------
	if (istype(over, /obj/structure/cargo_shelf) && isturf(loc))
		var/obj/structure/cargo_shelf/shelf = over
		shelf.load(src, user, y_offset)
		return

/// Adds a crate to the shelf
/obj/structure/cargo_shelf/proc/add_crate(obj/structure/closet/crate/crate, mob/user, y_offset)
	if(!can_load(crate, user, y_offset))
		return FALSE // Something has been added to the shelf while we were waiting, abort!
	if(crate.opened) // If the crate is open, try to close it.
		if(!crate.close())
			return FALSE // If we fail to close it, don't load it into the shelf.
	// Where the crate gets placed is based on where on the icon we mousedragged
	if (y_offset <= 12)
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * 0
		crate.layer = BELOW_OBJ_LAYER
		crates_stored[1] = REF(crate)
	else if (y_offset <= 21)
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * 1
		crate.layer = BELOW_OBJ_LAYER + 0.02
		crates_stored[2] = REF(crate)
	else
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * 2
		crate.layer = ABOVE_MOB_LAYER + 0.02
		crates_stored[3] = REF(crate)
	crate.interaction_flags_atom |= INTERACT_ATOM_MOUSEDROP_IGNORE_ADJACENT // We can't trust the mouse pull adjacency check
	crate.forceMove(src) // Insert the crate into the shelf.
	vis_contents += crate
	return TRUE

/// Removes a crate from the shelf
/obj/structure/cargo_shelf/proc/remove_crate(obj/structure/closet/crate/crate)
	PROTECTED_PROC(TRUE)
	for(var/slot in 1 to length(crates_stored)) // don't remove from the list, instead set the appropriate slot to null
		if(crates_stored[slot] == REF(crate))
			crates_stored[slot] = null
			crate.layer = initial(crate.layer) // Reset the crate back to having the default layer, otherwise we might get strange interactions.
			crate.pixel_y = initial(crate.pixel_y) // Reset the crate back to having no offset, otherwise it will be floating.
			crate.interaction_flags_atom &= ~INTERACT_ATOM_MOUSEDROP_IGNORE_ADJACENT
			vis_contents -= crate
			return TRUE
	return FALSE

/obj/structure/cargo_shelf/Exited(atom/movable/gone, direction)
	if(istype(gone, /obj/structure/closet/crate))
		remove_crate(gone)
	return ..()

/obj/item/rack_parts/cargo_shelf
	name = "crate shelf parts"
	icon = 'modular_nova/modules/shelves/structures.dmi'
	icon_state = "rack_parts"
	desc = "Parts of a crate shelf, for storing crates."

/obj/item/rack_parts/cargo_shelf/attack_self(mob/user)
	if(building)
		return
	building = TRUE
	to_chat(user, span_notice("You start constructing [src]..."))
	if(do_after(user, 5 SECONDS, target = user, progress=TRUE))
		if(!user.temporarilyRemoveItemFromInventory(src))
			building = FALSE
			return
		var/obj/structure/cargo_shelf/rack = new /obj/structure/cargo_shelf(get_turf(src))
		user.visible_message(
			span_notice("[user] assembles \a [rack]."),
			span_notice("You assemble \a [rack]."),
		)
		rack.add_fingerprint(user)
		qdel(src)
		return
	building = FALSE

#undef DEFAULT_SHELF_USE_DELAY
#undef DEFAULT_SHELF_VERTICAL_OFFSET
