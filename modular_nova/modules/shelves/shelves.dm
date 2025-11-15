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
	/// how many items the shelf can hold
	VAR_FINAL/capacity = 3
	/// the delay before the shelf is truly used
	var/use_delay = DEFAULT_SHELF_USE_DELAY
	/// how many crates are currently stored in the shelf
	var/crates_stored = 0

/obj/structure/cargo_shelf/Initialize(mapload)
	. = ..()
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
	if(crates_stored < capacity) // If there's an empty space in the shelf, let the examiner know.
		. += span_notice("You could <b>drag and drop</b> a crate into [src].")
	if(crates_stored) // If there are any crates in the shelf, let the examiner know.
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
		remove_crate(crate, drop_location())
		step_rand(crate, 1) // Then try to push it somewhere.

/// proc that will attempt to add something to the contents of the shelf
/obj/structure/cargo_shelf/proc/load(obj/structure/closet/crate/crate, mob/user, y_offset, instant)
	if(crates_stored >= capacity) // If we don't find an empty slot, return early.
		balloon_alert(user, "shelf full!")
		return FALSE
	if(!instant && !do_after(user, use_delay, target = crate))
		return FALSE // If the do_after() is interrupted, return FALSE!
	crate.add_fingerprint(user)
	add_crate(crate, y_offset)
	return TRUE


/// proc that will attempt to remove something to the contents of the shelf
/obj/structure/cargo_shelf/proc/unload(obj/structure/closet/crate/crate, mob/user, turf/unload_turf)
	if(!unload_turf)
		unload_turf = get_turf(user) // If a turf somehow isn't passed into the proc, put it at the user's feet.
	if(!unload_turf.Enter(crate)) // If moving the crate from the shelf to the desired turf would bump, don't do it! Thanks Kapu1178 for the help here. - Generic DM
		unload_turf.balloon_alert(user, "no room!")
		return FALSE
	if(!do_after(user, use_delay, target = crate))
		return FALSE
	if(!locate(crate) in src)
		return FALSE // If something has happened to the crate while we were waiting, abort!

	remove_crate(crate, unload_turf)
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
	var/turf/dump_turf = drop_location()
	for(var/obj/structure/closet/crate/crate in contents)
		remove_crate(crate, dump_turf)
		step(crate, pick(GLOB.alldirs)) // Shuffle the crates around as though they've fallen down.
		crate.SpinAnimation(rand(4,7), 1) // Spin the crates around a little as they fall. Randomness is applied so it doesn't look weird.
		switch(pick(1, 1, 1, 1, 2, 2, 3)) // Randomly pick whether to do nothing, open the crate, or break it open.
			if(1) // Believe it or not, this does nothing.
				continue
			if(2) // Open the crate!
				if(crate.open()) // Break some open, cause a little chaos.
					crate.visible_message(span_warning("[crate]'s lid falls open!"))
				else // If we somehow fail to open the crate, just break it instead!
					crate.visible_message(span_warning("[crate] falls apart!"))
					crate.deconstruct(FALSE)
			if(3) // Break that crate!
				crate.visible_message(span_warning("[crate] falls apart!"))
				crate.deconstruct(FALSE)

/obj/structure/closet/crate/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	. = ..()
	if(!isliving(user))
		return

	// -----------------------------------------
	// 1) Unloading from shelf to turf
	// -----------------------------------------
	if (istype(over, /turf/open) && istype(loc, /obj/structure/cargo_shelf))
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

		if(source_shelf.unload(src, user, destination_shelf))
			destination_shelf.load(src, user, y_offset, instant = TRUE)
		return

	// -----------------------------------------
	// 3) turf to shelf (normal loading)
	// -----------------------------------------
	if (istype(over, /obj/structure/cargo_shelf) && isturf(loc))
		var/obj/structure/cargo_shelf/shelf = over
		shelf.load(src, user, y_offset)
		return

/// Adds a crate to the shelf
/obj/structure/cargo_shelf/proc/add_crate(obj/structure/closet/crate/crate, y_offset)
	if(crates_stored >= capacity)
		return FALSE // Something has been added to the shelf while we were waiting, abort!
	if(crate.opened) // If the crate is open, try to close it.
		if(!crate.close())
			return FALSE // If we fail to close it, don't load it into the shelf.
	crate.interaction_flags_atom |= INTERACT_ATOM_MOUSEDROP_IGNORE_ADJACENT // We can't trust the mouse pull adjacency check
	crate.forceMove(src) // Insert the crate into the shelf.
	crates_stored++
	// Where the crate gets placed is based on where on the icon we mousedragged
	if (y_offset <= 12)
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * 0
		crate.layer = BELOW_OBJ_LAYER
	else if (y_offset <= 21)
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * 1
		crate.layer = BELOW_OBJ_LAYER + 0.02
	else
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * 2
		crate.layer = ABOVE_MOB_LAYER + 0.02
	vis_contents += crate

/// Removes a crate from the shelf
/obj/structure/cargo_shelf/proc/remove_crate(obj/structure/closet/crate/crate, turf/unload_turf)
	crate.layer = initial(crate.layer) // Reset the crate back to having the default layer, otherwise we might get strange interactions.
	crate.pixel_y = initial(crate.pixel_y) // Reset the crate back to having no offset, otherwise it will be floating.
	crate.forceMove(unload_turf)
	crates_stored--
	crate.interaction_flags_atom &= ~INTERACT_ATOM_MOUSEDROP_IGNORE_ADJACENT
	vis_contents -= crate

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
