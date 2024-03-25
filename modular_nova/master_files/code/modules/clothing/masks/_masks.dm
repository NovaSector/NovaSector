// Make sure that these get drawn over the snout layer if the mob has a snout
/obj/item/clothing/mask/visual_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot & ITEM_SLOT_MASK)
		if(!(user.bodyshape & BODYSHAPE_ALT_FACEWEAR_LAYER))
			return
		if(!isnull(alternate_worn_layer) && alternate_worn_layer < BODY_FRONT_LAYER) // if the alternate worn layer was already lower than snouts then leave it be
			return

		alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
		user.update_worn_mask()

		if(user.head) // so we don't draw over hats, which use the same layer
			user.update_worn_head()

/obj/item/clothing/mask/dropped(mob/living/carbon/human/user)
	. = ..()
	alternate_worn_layer = initial(alternate_worn_layer)

/obj/item/clothing/mask
	var/item_face_toggled

/obj/item/clothing/mask/Initialize(mapload)
	if (src.flags_inv && (src.flags_inv & HIDEFACE))
		if (!islist(actions_types))
			actions_types = list(/datum/action/item_action/toggle_hide_face)

	return ..()

/datum/action/item_action/toggle_hide_face/Trigger(trigger_flags)
    . = ..()
    if(!.)
        return
    var/obj/item/clothing/mask/target_mask = target
    target_mask.toggle_hide_face(usr)

/**
 * Toggles the HIDEFACE flag on the user's mask.
 *
 * @param user The user to toggle the mask for.
 * @param force Whether to force the mask to be toggled.
 * @return TRUE if the mask was toggled, FALSE otherwise.
 */
/obj/item/clothing/mask/proc/toggle_hide_face(mob/living/carbon/user, force = FALSE)
	if(!user.wear_mask && !force)
		return FALSE

	if(src.flags_inv & HIDEFACE)
		src.flags_inv &= ~HIDEFACE
		to_chat(user, "You've revealed your face!")
		item_face_toggled = TRUE
	else
		src.flags_inv |= HIDEFACE
		if (!force)
			to_chat(user, "You've hidden your face!")
		item_face_toggled = FALSE

	return TRUE

/obj/item/clothing/mask/dropped(mob/living/user)
	. = ..()
	if(item_face_toggled)
		toggle_hide_face(user, force = TRUE)
