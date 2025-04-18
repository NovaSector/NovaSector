/obj/item/clothing/accessory/can_attach_accessory(obj/item/clothing/clothing_item, mob/user)
	if(!attachment_slot || (clothing_item?.attachment_slot_override & attachment_slot))
		return TRUE
	return ..()

//See shorts_pants.dm for the Uniform version
/obj/item/clothing/accessory/chaps
	name = "black chaps"
	desc = "Yeehaw"
	icon_state = "chaps"
	icon = 'modular_nova/master_files/icons/obj/clothing/under/shorts_pants_shirts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'
	attachment_slot = LEGS //Worn over pants

/obj/item/clothing/accessory/chaps/click_ctrl_shift(mob/user)
	//Converts the Chaps into a Uniform.
	var/chaps_uniform = new /obj/item/clothing/under/pants/nova/chaps(user.drop_location())
	balloon_alert(user, "changed to uniform!")
	qdel(src)
	user.put_in_hands(chaps_uniform)

/obj/item/clothing/accessory/chaps/examine(mob/user)
	. = ..()
	span_notice("It can be [EXAMINE_HINT("ctrl+shift clicked")] to be worn as a uniform.")

/obj/item/clothing/accessory/chaps/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item != source)
		return .

	context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Wear as uniform"
	return CONTEXTUAL_SCREENTIP_SET
