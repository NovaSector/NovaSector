// Is this even still necessary? TODO: Find out and remove this if not

/mob/living/silicon/robot/deactivate_module(obj/item/item_module, hand_index, forced = FALSE, ignore_anim = TRUE, visuals_only = FALSE)
	. = ..()
	if(is_type_in_list(item_module, list(
		/obj/item/gun/energy/laser/cyborg,
		/obj/item/gun/energy/disabler/cyborg,
		/obj/item/gun/energy/e_gun/advtaser/cyborg,
	)))
		update_icons() //PUT THE GUN AWAY

/mob/living/silicon/robot/put_in_hand(obj/item/item_module, hand_index, forced = FALSE, ignore_anim = TRUE, visuals_only = FALSE)
	. = ..()
	if(is_type_in_list(item_module, list(
		/obj/item/gun/energy/laser/cyborg,
		/obj/item/gun/energy/disabler/cyborg,
		/obj/item/gun/energy/e_gun/advtaser/cyborg,
	)))
		update_icons() //REEEEEEACH FOR THE SKY
