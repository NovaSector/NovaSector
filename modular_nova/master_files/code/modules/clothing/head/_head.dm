//Define worn_icon_muzzled below here for suits so we don't have to make whole new .dm files for each

/// For making sure that snouts with the (Top) suffix have their gear layered correctly
/// Also handles hiding the ear slot properly after equipping a hat
/obj/item/clothing/head/visual_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!istype(user))
		return
	if(slot & ITEM_SLOT_HEAD)
		if(user.ears && (flags_inv & HIDEEARS))
			user.update_worn_ears()
		if(!(user.bodyshape & BODYSHAPE_ALT_FACEWEAR_LAYER))
			return
		if(!isnull(alternate_worn_layer) && alternate_worn_layer < BODY_FRONT_LAYER) // if the alternate worn layer was already lower than snouts then leave it be
			return

		alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
		user.update_worn_head()

/obj/item/clothing/head/dropped(mob/living/carbon/human/user)
	alternate_worn_layer = initial(alternate_worn_layer)
	return ..()

/obj/item/clothing/head/bio_hood
	worn_icon_muzzled = 'modular_nova/master_files/icons/mob/clothing/head/bio_muzzled.dmi'

/obj/item/clothing/head/helmet
	worn_icon_muzzled = 'modular_nova/master_files/icons/mob/clothing/head/helmet_muzzled.dmi'

/obj/item/clothing/head/helmet/toggleable/riot
	flags_inv = HIDEEARS|HIDEFACE //Removes HIDESNOUT so that transparent helmets still show the snout

/obj/item/clothing/head/helmet/space
	worn_icon_muzzled = 'modular_nova/master_files/icons/mob/clothing/head/spacehelm_muzzled.dmi'
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR //Removes HIDESNOUT so that transparent helmets still show the snout

/obj/item/clothing/head/helmet/chaplain
	worn_icon_muzzled = 'modular_nova/master_files/icons/mob/clothing/head/chaplain_muzzled.dmi'

/obj/item/clothing/head/hooded/monkhabit
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hooded/monkhabit"
	post_init_icon_state = "monkhood"
	greyscale_config = /datum/greyscale_config/monk_habit_hood
	greyscale_config_worn = /datum/greyscale_config/monk_habit_hood/worn
	greyscale_colors = "#8C531A#9C7132"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/chaplain/nun_hood
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/chaplain/nun_hood"
	post_init_icon_state = "nun_hood"
	greyscale_config = /datum/greyscale_config/nun_hood
	greyscale_config_worn = /datum/greyscale_config/nun_hood/worn
	greyscale_colors = "#373548#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/chaplain/habit_veil
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/chaplain/habit_veil"
	post_init_icon_state = "nun_hood_alt"
	greyscale_config = /datum/greyscale_config/nun_veil
	greyscale_config_worn = /datum/greyscale_config/nun_veil/worn
	greyscale_colors = "#373548#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/collectable/welding
	worn_icon_muzzled = 'modular_nova/master_files/icons/mob/clothing/head_muzzled.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

//Re-adds HIDESNOUT to whatever needs it, and marks them CLOTHING_NO_VARIATION so they don't look for muzzled sprites
//TODO - this needs a better method, can we do this as a SQUISH thing like digitigrade?
/obj/item/clothing/head/helmet/space/changeling
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/head/helmet/space/freedom
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/head/helmet/space/santahat
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	supports_variations_flags = CLOTHING_NO_VARIATION
