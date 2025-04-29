/obj/item/clothing/under/tarkon
	name = "tarkon general uniform"
	desc = "A uniform worn by civilian-ranked crew, provided by Tarkon Industries."
	worn_icon = 'modular_nova/modules/tarkon/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_nova/modules/tarkon/icons/mob/clothing/uniform_digi.dmi'
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	armor_type = /datum/armor/clothing_under/tarkon
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/tarkon"
	post_init_icon_state = "tarkon"
	greyscale_config = /datum/greyscale_config/tarkonuniform
	greyscale_config_worn = /datum/greyscale_config/tarkonuniform/worn
	greyscale_config_worn_digi = /datum/greyscale_config/tarkonuniform/worn/digi

/obj/item/clothing/under/tarkon/cargo
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/tarkon"
	post_init_icon_state = "tarkon"
	name = "tarkon cargo uniform"
	desc = "A uniform worn by cargo-ranked crew, provided by Tarkon Industries."
	greyscale_colors = "#B7793D"

/obj/item/clothing/under/tarkon/sci
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/tarkon"
	post_init_icon_state = "tarkon"
	name = "tarkon research uniform"
	desc = "A uniform worn by research-ranked crew, provided by Tarkon Industries."
	greyscale_colors = "#9E00EA"

/obj/item/clothing/under/tarkon/sec
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/tarkon"
	post_init_icon_state = "tarkon"
	name = "tarkon guard uniform"
	desc = "A uniform worn by security-ranked crew, provided by Tarkon Industries."
	armor_type = /datum/armor/clothing_under/tarkon
	greyscale_colors = "#B72B2F"

/obj/item/clothing/under/tarkon/med
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/tarkon"
	post_init_icon_state = "tarkon"
	name = "tarkon medical uniform"
	desc = "A uniform worn by medical-ranked crew, provided by Tarkon Industries."
	greyscale_colors = "#85C1E6"

/obj/item/clothing/under/tarkon/eng
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/tarkon"
	post_init_icon_state = "tarkon"
	name = "tarkon maintenance uniform"
	desc = "A uniform worn by maintenance-ranked crew, provided by Tarkon Industries."
	greyscale_colors = "#ff9900"

/obj/item/clothing/under/tarkon/com
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/tarkon"
	post_init_icon_state = "tarkon"
	name = "tarkon command uniform"
	desc = "A uniform worn by command-ranked crew, provided by Tarkon Industries."
	armor_type = /datum/armor/clothing_under/tarkon
	greyscale_colors = "#3F6E9E"

/datum/armor/clothing_under/tarkon
	melee = 10
	fire = 50
	acid = 50
	wound = 10
