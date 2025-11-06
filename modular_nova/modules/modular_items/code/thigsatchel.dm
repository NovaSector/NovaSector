/obj/item/storage/belt/thigh_satchel
	name = "thigh satchel"
	desc = "A little satchel that goes on your thigh!"
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	lefthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/storage/belt/thigh_satchel"
	post_init_icon_state = "thighsatchel"
	greyscale_config = /datum/greyscale_config/thighsatchel
	greyscale_config_worn = /datum/greyscale_config/thighsatchel/worn
	greyscale_colors = "#383840#383840#d1d3e0"
	inhand_icon_state = "erpbelt"
	worn_icon_state = "thighsatchel"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbelt_pickup.ogg'
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/thigh_satchel

/datum/storage/thigh_satchel
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_total_storage = WEIGHT_CLASS_SMALL * 7
	max_slots = 7
