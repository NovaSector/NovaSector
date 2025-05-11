/obj/item/storage/belt/thigh_satchel
	name = "thigh satchel"
	desc = "A little satchel that goes on your thigh!"
	icon = 'modular_nova/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	lefthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_nova/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	greyscale_colors = "#383840#383840#d1d3e0"
	greyscale_config = /datum/greyscale_config/thighsatchel
	greyscale_config_worn = /datum/greyscale_config/thighsatchel/worn
	icon_state = "thighsatchel"
	inhand_icon_state = "erpbelt"
	worn_icon_state = "thighsatchel"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbelt_pickup.ogg'
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/thigh_satchel/Initialize(mapload)
	. = ..()

	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = WEIGHT_CLASS_SMALL * 7
	atom_storage.max_slots = 7
