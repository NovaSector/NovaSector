/mob/living/carbon/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if (!isnull(held_item))
		context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Offer item"
		return CONTEXTUAL_SCREENTIP_SET

	if (!ishuman(user))
		return .

	var/mob/living/carbon/human/human_user = user

	if (human_user.combat_mode)
		context[SCREENTIP_CONTEXT_LMB] = "Attack"
	else if (human_user == src)
		context[SCREENTIP_CONTEXT_LMB] = "Check injuries"

		if (get_bodypart(human_user.zone_selected)?.cached_bleed_rate)
			context[SCREENTIP_CONTEXT_CTRL_LMB] = "Grab limb"

		// NOVA EDIT ADDITION START
		var/obj/item/storage/backpack/backpack = human_user.get_item_by_slot(ITEM_SLOT_BACK)
		if (backpack && backpack.GetComponent(/datum/component/accessable_storage))
			context[SCREENTIP_CONTEXT_ALT_LMB] = "Open storage"
		// NOVA EDIT ADDITION END
	if (human_user != src)
		context[SCREENTIP_CONTEXT_RMB] = "Shove"

		if (!human_user.combat_mode)
			// NOVA EDIT ADDITION START
			var/obj/item/storage/backpack/backpack = get_item_by_slot(ITEM_SLOT_BACK)
			if (backpack && backpack.GetComponent(/datum/component/accessable_storage))
				context[SCREENTIP_CONTEXT_ALT_LMB] = "Open storage"
			// NOVA EDIT ADDITION END
			if (body_position == STANDING_UP)
				if(check_zone(user.zone_selected) == BODY_ZONE_HEAD && get_bodypart(BODY_ZONE_HEAD))
					context[SCREENTIP_CONTEXT_LMB] = "Headpat"
				else if(user.zone_selected == BODY_ZONE_PRECISE_GROIN && !isnull(get_organ_by_type(/obj/item/organ/tail)))
					context[SCREENTIP_CONTEXT_LMB] = "Pull tail"
				else
					context[SCREENTIP_CONTEXT_LMB] = "Hug"
			else if (health >= 0 && !HAS_TRAIT(src, TRAIT_FAKEDEATH))
				context[SCREENTIP_CONTEXT_LMB] = "Shake"
			else
				context[SCREENTIP_CONTEXT_LMB] = "CPR"

	return CONTEXTUAL_SCREENTIP_SET
