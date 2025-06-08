/obj/item/clothing/accessory/can_attach_accessory(obj/item/clothing/clothing_item, mob/user)
	if(!attachment_slot || (clothing_item?.attachment_slot_override & attachment_slot))
		return TRUE
	return ..()


/obj/item/clothing/accessory/chaps
	name = "chaps"
	desc = "Padding typically worn over one's trousers to better protect the outside of their legs from hazards."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/chaps"
	post_init_icon_state = "chaps"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'
	attachment_slot = LEGS //Worn over pants
	gender = PLURAL //"That's some chaps."
	greyscale_config = /datum/greyscale_config/chaps
	greyscale_config_worn = /datum/greyscale_config/chaps/worn
	greyscale_config_worn_digi = /datum/greyscale_config/chaps/worn/digi
	greyscale_colors = "#787878#252525#2B2B2B"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/accessory/chaps/click_ctrl_shift(mob/user)
	//Converts the Chaps into a Uniform.
	//See shorts_pants.dm for the Uniform version
	var/obj/item/clothing/under/pants/nova/chaps/chaps_uniform = new /obj/item/clothing/under/pants/nova/chaps(user.drop_location())
	chaps_uniform.greyscale_colors = greyscale_colors
	chaps_uniform.update_greyscale()
	user.balloon_alert(user, "changed to uniform!")
	qdel(src)
	user.put_in_hands(chaps_uniform)

/obj/item/clothing/accessory/chaps/examine(mob/user)
	. = ..()
	. += span_notice("It can be [EXAMINE_HINT("ctrl+shift clicked")] to be worn as a uniform.")

/obj/item/clothing/accessory/chaps/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item != source)
		return .

	context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Wear as uniform"
	return CONTEXTUAL_SCREENTIP_SET
