//DEFAULT NECK ITEMS OVERRIDE//
/obj/item/clothing/neck
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/greyscaled
	name = "Antique Short Cloak"
	desc = "An antique, fluffy shortcloak... not sure why it's so puffy and short."

	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/greyscaled"

	post_init_icon_state = "shortcloak"
	greyscale_config = /datum/greyscale_config/antique_short_cloak
	greyscale_config_worn = /datum/greyscale_config/antique_short_cloak/worn
	greyscale_colors = "#777777#ffffcc#66ffff"
	body_parts_covered = NECK
	flags_1 = IS_PLAYER_COLORABLE_1


/datum/atom_skin/seecloak
	abstract_type = /datum/atom_skin/seecloak
	greyscale_item_path = /obj/item/clothing/neck/greyscaled/seecloak

/datum/atom_skin/seecloak/seecloak
	preview_name = "default"
	new_icon_state = "seecloak"

/datum/atom_skin/seecloak/seecloak_trimonly
	preview_name = "trimmed"
	new_icon_state = "seecloak_trimonly"

/obj/item/clothing/neck/greyscaled/seecloak
	name = "Antique Seecloak"
	desc = "An antique cloak, with a symbol whose meaning has been lost to time..."

	icon_state = "/obj/item/clothing/neck/greyscaled/seecloak"
	post_init_icon_state = "seecloak"

	greyscale_config = /datum/greyscale_config/antique_seecloak
	greyscale_config_worn = /datum/greyscale_config/antique_seecloak/worn
	greyscale_colors = "#ffff99#4d4d4d"
	body_parts_covered = NECK|HAND_LEFT|ARM_LEFT|CHEST

/obj/item/clothing/neck/greyscaled/seecloak/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/seecloak, initial_skin = "default")

/obj/item/clothing/neck/greyscaled/matroncloak
	name = "Antique Matron Cloak"
	desc = "A large antique cloak with large puffy fluff."

	icon_state = "/obj/item/clothing/neck/greyscaled/matroncloak"
	post_init_icon_state = "matroncloak"

	greyscale_config = /datum/greyscale_config/antique_matroncloak
	greyscale_config_worn = /datum/greyscale_config/antique_matroncloak/worn
	greyscale_colors = "#777777#ffffcc#66ffff"

/obj/item/clothing/neck/greyscaled/xylixcloak
	name = "Antique Xylix Cloak"
	desc = "An antique poncho like cloak."

	icon_state = "/obj/item/clothing/neck/greyscaled/xylixcloak"
	post_init_icon_state = "xylixcloak"

	greyscale_config = /datum/greyscale_config/antique_xylixcloak
	greyscale_config_worn = /datum/greyscale_config/antique_xylixcloak/worn
	greyscale_colors = "#787878#abe2dc#f5d54a"
	body_parts_covered = NECK|CHEST
