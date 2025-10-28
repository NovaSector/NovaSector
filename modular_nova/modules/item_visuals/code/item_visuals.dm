// ITEM VISUALS - Random rotation & pixel shift for items, robot interactions

// Item rotation and pixel shifting
/obj/item
	var/our_angle = 0

/obj/item/proc/do_messy(pixel_variation = 8, angle_variation = 360, duration = 0)
	if(item_flags & NO_PIXEL_RANDOM_DROP)
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

/obj/item/after_throw(datum/callback/callback)
	. = ..()
	undo_messy()
	do_messy(duration = 0.2 SECONDS)

/obj/item/onZImpact(turf/turf_fallen, levels)
	. = ..()
	undo_messy()
	do_messy(duration = 0.4 SECONDS)

/mob/put_in_hand(obj/item/item_picked, hand_index, forced = FALSE, ignore_anim = TRUE, visuals_only = FALSE)
	. = ..()
	if(. && item_picked)
		item_picked.undo_messy(duration = 0 SECONDS)

/mob/living/dropItemToGround(obj/item/to_drop, force, silent, invdrop, turf/newloc)
	. = ..()
	if(combat_mode == FALSE)
		return
	if(. && to_drop)
		if(!(to_drop.item_flags & NO_PIXEL_RANDOM_DROP))
			to_drop.do_messy(duration = 0.2 SECONDS)

// Robot/silicon interactions for precise item placement
/obj/structure/table/attack_robot(mob/living/user, list/modifiers)
	if(isnull(user.pulling))
		return ..()
	if(get_dist(user, src) > 1)
		return
	if(is_flipped)
		return
	if(isliving(user.pulling))
		attack_hand(user, modifiers)
		return
	user.Move_Pulled(src)
	if(user.pulling.loc != loc)
		return
	if(isitem(user.pulling))
		pixelplace_pulled_item(user.pulling, modifiers)
	user.visible_message(span_notice("[user] places [user.pulling] onto [src]."),
		span_notice("You place [user.pulling] onto [src]."))
	user.stop_pulling()

/obj/structure/table/proc/pixelplace_pulled_item(obj/item/placed_item, list/modifiers)
	placed_item.undo_messy()
	placed_item.pixel_x = base_pixel_x
	placed_item.pixel_y = base_pixel_y
	if(LAZYACCESS(modifiers, ICON_X) && LAZYACCESS(modifiers, ICON_Y))
		placed_item.pixel_x += clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(ICON_SIZE_X*0.5), ICON_SIZE_X*0.5)
		placed_item.pixel_y += clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(ICON_SIZE_Y*0.5), ICON_SIZE_Y*0.5)

/obj/structure/table/attack_robot_secondary(mob/living/user, list/modifiers)
	if(!Adjacent(user))
		return ..()
	return attack_hand_secondary(user, modifiers)

/obj/machinery/conveyor/attack_robot(mob/user, modifiers)
	if(isnull(user.pulling))
		return ..()
	if(get_dist(user, src) > 1)
		return
	attack_hand(user, modifiers)

/turf/open/attack_robot(mob/user, modifiers)
	if(isnull(user.pulling))
		return ..()
	if(get_dist(user, src) > 1)
		return
	user.Move_Pulled(src)

/obj/structure/rack/attack_robot(mob/user, modifiers)
	if(isnull(user.pulling))
		return ..()
	if(get_dist(user, src) > 1)
		return
	if(!isitem(user.pulling))
		return
	var/obj/item/pulled_item = user.pulling
	user.Move_Pulled(src)
	if(pulled_item.loc != loc)
		return
	pulled_item.undo_messy()
	pulled_item.pixel_x = base_pixel_x
	pulled_item.pixel_y = base_pixel_y
	user.visible_message(span_notice("[user] places [user.pulling] onto [src]."),
		span_notice("You place [user.pulling] onto [src]."))
	user.stop_pulling()

