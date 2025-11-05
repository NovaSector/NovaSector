/obj/item/stack/shibari_rope
	name = "shibari ropes"
	desc = "Coil of bondage ropes."
	full_w_class = WEIGHT_CLASS_SMALL
	amount = 1
	merge_type = /obj/item/stack/shibari_rope
	singular_name = "rope"
	max_amount = 5
	flags_1 = IS_PLAYER_COLORABLE_1
	obj_flags_nova = ERP_ITEM

	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/stack/shibari_rope"
	post_init_icon_state = "shibari_rope"
	greyscale_config = /datum/greyscale_config/shibari_rope
	greyscale_colors = "#bd8fcf"

	greyscale_config_inhand_left = /datum/greyscale_config/shibari_rope_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/shibari_rope_inhand_right

	/// We use this var to change tightness var on worn version of this item.
	var/tightness = SHIBARI_TIGHTNESS_LOW
	/// Whether clothing items created by this stack glow
	var/glow = FALSE

// Spawns with full stack.
/obj/item/stack/shibari_rope/full
	amount = 5

/obj/item/stack/shibari_rope/glow
	name = "glowy shibari ropes"
	singular_name = "glowy rope"
	full_w_class = WEIGHT_CLASS_SMALL
	merge_type = /obj/item/stack/shibari_rope/glow
	icon_state = "/obj/item/stack/shibari_rope/glow"
	post_init_icon_state = "shibari_rope_glow"
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_on = TRUE
	light_power = 3
	glow = TRUE

/obj/item/stack/shibari_rope/glow/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	set_light_color(greyscale_colors)

/obj/item/stack/shibari_rope/glow/full
	amount = 5

/obj/item/stack/shibari_rope/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, post_init_icon_state, src, alpha = alpha)

/obj/item/stack/shibari_rope/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = standing.alpha)

/obj/item/stack/shibari_rope/update_icon_state()
	if(amount <= (max_amount * (1/3)))
		set_greyscale(greyscale_colors, /datum/greyscale_config/shibari_rope)
		return ..()
	if(amount <= (max_amount * (2/3)))
		set_greyscale(greyscale_colors, /datum/greyscale_config/shibari_rope/med)
		return ..()
	set_greyscale(greyscale_colors, /datum/greyscale_config/shibari_rope/high)
	return ..()

/obj/item/stack/shibari_rope/split_stack(amount)
	. = ..()
	if(.)
		var/obj/item/stack/current_stack = .
		current_stack.set_greyscale(greyscale_colors)

/obj/item/stack/shibari_rope/can_merge(obj/item/stack/check, inhand = TRUE)
	if(check.greyscale_colors == greyscale_colors)
		return ..()
	return FALSE

/obj/item/stack/shibari_rope/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	RegisterSignal(src, COMSIG_ITEM_ATTACK, PROC_REF(handle_roping))
	if(!greyscale_colors)
		var/new_color = "#"
		for(var/i in 1 to 3)
			new_color += num2hex(rand(0, 255), 2)
		set_greyscale(colors = list(new_color))

/// Begins the correct tying sequence based on the body zone selected
/obj/item/stack/shibari_rope/proc/handle_roping(datum/source, mob/living/carbon/attacked, mob/living/user)
	SIGNAL_HANDLER

	if(get_dist(user, src) > 1)
		return
	if(!ishuman(attacked))
		return
	if(!attacked.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("Looks like [attacked] doesn't want you to do that."))
		return

	switch(user.zone_selected)
		if(BODY_ZONE_L_LEG)
			INVOKE_ASYNC(src, PROC_REF(handle_leg_tying), attacked, user)
			return COMPONENT_CANCEL_ATTACK_CHAIN
		if(BODY_ZONE_R_LEG)
			INVOKE_ASYNC(src, PROC_REF(handle_leg_tying), attacked, user)
			return COMPONENT_CANCEL_ATTACK_CHAIN
		if(BODY_ZONE_PRECISE_GROIN)
			INVOKE_ASYNC(src, PROC_REF(handle_groin_tying), attacked, user)
			return COMPONENT_CANCEL_ATTACK_CHAIN
		if(BODY_ZONE_CHEST)
			INVOKE_ASYNC(src, PROC_REF(handle_chest_tying), attacked, user)
			return COMPONENT_CANCEL_ATTACK_CHAIN
		if(BODY_ZONE_L_ARM)
			INVOKE_ASYNC(src, PROC_REF(handle_arm_tying), attacked, user)
			return COMPONENT_CANCEL_ATTACK_CHAIN
		if(BODY_ZONE_R_ARM)
			INVOKE_ASYNC(src, PROC_REF(handle_arm_tying), attacked, user)
			return COMPONENT_CANCEL_ATTACK_CHAIN

/// Try to tie the groin
/obj/item/stack/shibari_rope/proc/handle_groin_tying(mob/living/carbon/human/them, mob/living/user)
	if(istype(them.w_uniform, /obj/item/clothing/under/shibari/torso))
		handle_fullbody_tying(them, user)
		return
	if(them.w_uniform)
		to_chat(user, span_warning("They're already wearing something on this slot!"))
		return

	them.visible_message(
		span_warning("[user] starts tying [them]'s groin!"),
		span_userdanger("You start tying your groin!"),
		span_hear("You hear ropes being tightened.")
	)
	if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 2 SECONDS : 6 SECONDS, them))
		return

	var/obj/item/stack/shibari_rope/split_rope
	var/slow = 0
	if(them.bodyshape & BODYSHAPE_TAUR)
		split_rope = split_stack(2)
		slow = 4
	else
		split_rope = split_stack(1)

	if(!split_rope)
		to_chat(user, span_warning("You don't have enough ropes!"))
		return

	var/obj/item/clothing/under/shibari/groin/shibari_groin = new(get_turf(src))
	shibari_groin.slowdown = slow
	shibari_groin.set_greyscale(greyscale_colors)
	shibari_groin.glow = glow

	if(!them.equip_to_slot_if_possible(shibari_groin, ITEM_SLOT_ICLOTHING, TRUE, FALSE, TRUE))
		merge(split_rope)
		return

	shibari_groin.tightness = tightness
	them.visible_message(
		span_warning("[user] has tied [them]'s groin!"),
		span_userdanger("You've tied your groin!"),
		span_hear("You hear ropes being completely tightened.")
	)
	split_rope.forceMove(shibari_groin)


/obj/item/stack/shibari_rope/proc/handle_chest_tying(mob/living/carbon/human/them, mob/living/user)
	if(istype(them.w_uniform, /obj/item/clothing/under/shibari/groin))
		handle_fullbody_tying(them, user)
		return
	if(them.w_uniform)
		to_chat(user, span_warning("They're already wearing something on this slot!"))
		return

	them.visible_message(
		span_warning("[user] starts tying [them]'s chest!"),
		span_userdanger("You start tying your chest!"),
		span_hear("You hear ropes being tightened.")
	)
	if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 2 SECONDS : 6 SECONDS, them))
		return

	var/obj/item/stack/shibari_rope/split_rope = split_stack(1)
	if(!split_rope)
		to_chat(user, span_warning("You don't have enough ropes!"))
		return

	var/obj/item/clothing/under/shibari/torso/shibari_body = new(get_turf(src))
	shibari_body.set_greyscale(greyscale_colors)
	shibari_body.glow = glow

	if(!them.equip_to_slot_if_possible(shibari_body, ITEM_SLOT_ICLOTHING, TRUE, FALSE, TRUE))
		merge(split_rope)
		return

	shibari_body.tightness = tightness
	them.visible_message(
		span_warning("[user] has tied [them]'s chest!"),
		span_userdanger("You've tied your chest!"),
		span_hear("You hear ropes being completely tightened.")
	)
	split_rope.forceMove(shibari_body)

/// Try to tie the arms
/obj/item/stack/shibari_rope/proc/handle_arm_tying(mob/living/carbon/human/them, mob/living/user)
	if(them.gloves)
		to_chat(user, span_warning("They're already wearing something on this slot!"))
		return

	them.visible_message(
		span_warning("[user] starts tying [them]'s hands!"),
		span_userdanger("You start tying your hands!"),
		span_hear("You hear ropes being tightened.")
	)
	if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 2 SECONDS : 6 SECONDS, them))
		return

	var/obj/item/stack/shibari_rope/split_rope = split_stack(1)
	if(!split_rope)
		to_chat(user, span_warning("You don't have enough ropes!"))
		return

	var/obj/item/clothing/gloves/shibari_hands/shibari_hands = new(get_turf(src))
	shibari_hands.set_greyscale(greyscale_colors)
	shibari_hands.glow = glow

	if(!them.equip_to_slot_if_possible(shibari_hands, ITEM_SLOT_GLOVES, TRUE, FALSE, TRUE))
		merge(split_rope)
		return

	them.visible_message(
		span_warning("[user] hastied [them]'s hands!"),
		span_userdanger("You've tied your hands!"),
		span_hear("You hear ropes being completely tightened.")
	)
	split_rope.forceMove(shibari_hands)

/// Try to tie the legs
/obj/item/stack/shibari_rope/proc/handle_leg_tying(mob/living/carbon/human/them, mob/living/user)
	if(them.shoes)
		to_chat(user, span_warning("They're already wearing something on this slot!"))
		return
	if(them.bodyshape & BODYSHAPE_TAUR)
		to_chat(user, span_warning("You can't tie their feet, they're a taur!"))
		return

	them.visible_message(
		span_warning("[user] starts tying [them]'s feet!"),
		span_userdanger("You start tying your feet!"),
		span_hear("You hear ropes being tightened.")
	)
	if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 2 SECONDS : 6 SECONDS, them))
		return

	var/obj/item/stack/shibari_rope/split_rope = split_stack(1)
	if(!split_rope)
		to_chat(user, span_warning("You don't have enough ropes!"))
		return

	var/obj/item/clothing/shoes/shibari_legs/shibari_legs = new(get_turf(src))
	shibari_legs.set_greyscale(greyscale_colors)
	shibari_legs.glow = glow

	if(!them.equip_to_slot_if_possible(shibari_legs, ITEM_SLOT_FEET, TRUE, FALSE, TRUE))
		merge(split_rope)
		return

	them.visible_message(
		span_warning("[user] has tied [them]'s feet!"),
		span_userdanger("You've tied your feet!"),
		span_hear("You hear ropes being completely tightened.")
	)
	split_rope.forceMove(shibari_legs)

/// When half the torso is tied, targetting the other half leads to fullbody tying
/obj/item/stack/shibari_rope/proc/handle_fullbody_tying(mob/living/carbon/human/them, mob/living/user)
	switch(user.zone_selected)
		if(BODY_ZONE_CHEST)
			them.visible_message(
				span_warning("[user] starts tying [them]'s chest!"),
				span_userdanger("You start tying your chest!"),
				span_hear("You hear ropes being tightened.")
			)
			if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 2 SECONDS : 6 SECONDS, them))
				return

			var/slow = 0
			if(them.bodyshape & BODYSHAPE_TAUR)
				slow = 4

			var/obj/item/stack/shibari_rope/split_rope = split_stack(1)
			if(!split_rope)
				to_chat(user, span_warning("You don't have enough ropes!"))
				return

			var/obj/item/clothing/under/shibari/body_rope = them.w_uniform
			if(body_rope.glow != split_rope.glow)
				to_chat(user, span_warning("You can't mix these types of ropes!"))
				split_rope.forceMove(get_turf(them))
				return

			var/obj/item/clothing/under/shibari/full/shibari_fullbody = new(get_turf(src))
			shibari_fullbody.slowdown = slow
			shibari_fullbody.glow = glow
			shibari_fullbody.set_greyscale(list(greyscale_colors, body_rope.greyscale_colors))

			var/list/previous_rope_pieces = list()
			for(var/obj/item/stack/shibari_rope/rope_piece in body_rope.contents)
				previous_rope_pieces += rope_piece
				rope_piece.forceMove(drop_location())

			qdel(body_rope)

			if(!them.equip_to_slot_if_possible(shibari_fullbody, ITEM_SLOT_ICLOTHING, TRUE, FALSE, TRUE))
				merge(split_rope)
				return

			shibari_fullbody.tightness = tightness
			them.visible_message(
				span_warning("[user] has tied [them]'s chest!"),
				span_userdanger("You've tied your chest!"),
				span_hear("You hear ropes being completely tightened.")
			)
			for(var/obj/item/stack/shibari_rope/rope_piece as anything in previous_rope_pieces + split_rope)
				rope_piece.forceMove(shibari_fullbody)

		if(BODY_ZONE_PRECISE_GROIN)
			them.visible_message(
				span_warning("[user] starts tying [them]'s groin!"),
				span_userdanger("You start tying your groin!"),
				span_hear("You hear ropes being tightened.")
			)
			if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 2 SECONDS : 6 SECONDS, them))
				return

			var/obj/item/stack/shibari_rope/split_rope
			var/slow = 0
			if(them.bodyshape & BODYSHAPE_TAUR)
				split_rope = split_stack(2)
				slow = 4
			else
				split_rope = split_stack(1)

			if(!split_rope)
				to_chat(user, span_warning("You don't have enough ropes!"))
				return

			var/obj/item/clothing/under/shibari/body_rope = them.w_uniform
			if(body_rope.glow != split_rope.glow)
				to_chat(user, span_warning("You can't mix these type of ropes!"))
				split_rope.forceMove(get_turf(them))
				return

			var/obj/item/clothing/under/shibari/full/shibari_fullbody = new(get_turf(src))
			shibari_fullbody.slowdown = slow
			shibari_fullbody.glow = glow
			shibari_fullbody.set_greyscale(list(body_rope.greyscale_colors, greyscale_colors))

			var/list/previous_rope_pieces = list()
			for(var/obj/item/stack/shibari_rope/rope_piece in body_rope.contents)
				previous_rope_pieces += rope_piece
				rope_piece.forceMove(drop_location())

			qdel(body_rope)

			if(!them.equip_to_slot_if_possible(shibari_fullbody, ITEM_SLOT_ICLOTHING, TRUE, FALSE, TRUE))
				merge(split_rope)
				return

			shibari_fullbody.tightness = tightness
			them.visible_message(
				span_warning("[user] has tied [them]'s groin!"),
				span_userdanger("You've tied your groin!"),
				span_hear("You hear ropes being completely tightened.")
			)
			for(var/obj/item/stack/shibari_rope/rope_piece as anything in previous_rope_pieces + split_rope)
				rope_piece.forceMove(shibari_fullbody)

/// This part of code required for tightness adjustment. You can change tightness of future shibari bondage on character by clicking on ropes.
// Rope tightness works as multiplier for arousal and pleasure per tick when character tied up with those.
/obj/item/stack/shibari_rope/attack_self(mob/user)
	switch(tightness)
		if(SHIBARI_TIGHTNESS_HIGH)
			tightness = SHIBARI_TIGHTNESS_LOW
			playsound_if_pref(loc, 'modular_nova/modules/modular_items/lewd_items/sounds/latex.ogg', 25)
			balloon_alert(user, "slightly tightened the ropes")
		if(SHIBARI_TIGHTNESS_LOW)
			tightness = SHIBARI_TIGHTNESS_MED
			playsound_if_pref(loc, 'modular_nova/modules/modular_items/lewd_items/sounds/latex.ogg', 50)
			balloon_alert(user, "moderately tightened the ropes")
		if(SHIBARI_TIGHTNESS_MED)
			tightness = SHIBARI_TIGHTNESS_HIGH
			playsound_if_pref(loc, 'modular_nova/modules/modular_items/lewd_items/sounds/latex.ogg', 75)
			balloon_alert(user, "strongly tightened the ropes")
