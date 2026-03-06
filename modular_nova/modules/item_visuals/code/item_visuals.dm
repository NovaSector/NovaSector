// ITEM VISUALS - Random rotation & pixel shift for items, robot interactions

/obj/item
	/// Current rotation angle of the item
	var/our_angle = 0

/// Randomly rotates and pixel shifts the item for a messy appearance. Has a 35% chance to actually trigger.
/obj/item/proc/do_messy(pixel_variation = 8, angle_variation = 360, duration = 0)
	if(item_flags & NO_PIXEL_RANDOM_DROP)
		return
	if(!prob(35)) // 35% chance to actually rotate - reduces visual spam
		return

	// Undo old angle if present
	var/matrix/our_matrix = transform
	if(our_angle)
		our_matrix = our_matrix.Turn(-our_angle)

	// Pick new position + angle variation
	var/new_x = base_pixel_x + rand(-pixel_variation, pixel_variation)
	var/new_y = base_pixel_y + rand(-pixel_variation, pixel_variation)

	our_angle = rand(0, angle_variation)
	our_matrix = our_matrix.Turn(our_angle)

	animate(src,
		pixel_x = new_x,
		pixel_y = new_y,
		transform = our_matrix,
		time = duration,
		flags = ANIMATION_PARALLEL
	)

/// Unrotates and resets pixel position of the item
/obj/item/proc/undo_messy(duration = 0)
	var/matrix/new_transform = transform
	if (our_angle)
		new_transform = new_transform.Turn(-our_angle)

	animate(src,
		pixel_x = base_pixel_x,
		pixel_y = base_pixel_y,
		transform = new_transform,
		time = duration,
		flags = ANIMATION_PARALLEL
	)

	our_angle = 0

/// Handles throwing behavior with messy rotation
/obj/item/on_thrown(mob/living/carbon/user, atom/target)
	. = ..()
	if(!.)
		return
	user.dropItemToGround(src, silent = TRUE)
	if(throwforce && (HAS_TRAIT(user, TRAIT_PACIFISM)) || HAS_TRAIT(user, TRAIT_NO_THROWING))
		to_chat(user, span_notice("You set [src] down gently on the ground."))
		return
	undo_messy()
	do_messy(duration = 0.4 SECONDS)
	return src

/// Additional rotation after item lands from throw
/obj/item/after_throw(datum/callback/callback)
	. = ..()
	undo_messy()
	do_messy(duration = 0.2 SECONDS)

/// Rotation when item falls between z-levels
/obj/item/onZImpact(turf/turf_fallen, levels)
	. = ..()
	undo_messy()
	do_messy(duration = 0.4 SECONDS)

/// Resets item rotation when picked up into hand
/mob/put_in_hand(obj/item/item_picked, hand_index, forced = FALSE, ignore_anim = TRUE, visuals_only = FALSE)
	. = ..()
	if(. && item_picked)
		item_picked.undo_messy(duration = 0 SECONDS)

/// Applies messy rotation when dropping items in combat mode
/mob/living/dropItemToGround(obj/item/to_drop, force, silent, invdrop, turf/newloc)
	. = ..()
	if(combat_mode == FALSE)
		return
	if(. && to_drop)
		if(!(to_drop.item_flags & NO_PIXEL_RANDOM_DROP))
			to_drop.do_messy(duration = 0.2 SECONDS)

