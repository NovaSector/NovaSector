//Tailcoat BY DimWhat OF MONKEESTATION

/obj/item/clothing/suit/jacket/tailcoat //parent type
	name = "tailcoat"
	desc = "A knee-length coat characterised by a rear section of the skirt, with the front of the skirt cut away."
	worn_icon = 'modular_iris/monke_ports/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_iris/monke_ports/icons/mob/clothing/suits/jacket_digi.dmi'
	icon = 'modular_iris/monke_ports/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "Tailcoat"
	post_init_icon_state = "Tailcoat"
	greyscale_colors = "#39393f"
	greyscale_config = /datum/greyscale_config/tailcoat
	greyscale_config_worn = /datum/greyscale_config/tailcoat/worn
	greyscale_config_worn_digi = /datum/greyscale_config/tailcoat/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/jacket/tailcoat/bartender
	name = "bartender's tailcoat"
	desc = "A knee-length coat characterised by a rear section of the skirt, with the front of the skirt cut away. It has an interior holster for firearms and some extra padding for minor protection."
	icon_state = "TailcoatBar"
	post_init_icon_state = "TailcoatBar"
	greyscale_colors = "#39393f#ffffff"
	greyscale_config = /datum/greyscale_config/tailcoat_bar
	greyscale_config_worn = /datum/greyscale_config/tailcoat_bar/worn
	greyscale_config_worn_digi = /datum/greyscale_config/tailcoat_bar/worn/digi
	armor_type = /datum/armor/suit_armor


/obj/item/clothing/suit/jacket/tailcoat/bartender/Initialize(mapload) //so bartenders can use cram their shotgun inside
	. = ..()
	allowed += list(
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
	)

/obj/item/clothing/suit/wizrobe/magician //Not really a robe but it's MAGIC
	name = "magician's tailcoat"
	desc = "A magnificent, gold-lined tailcoat that seems to radiate power."
	worn_icon = 'modular_iris/monke_ports/icons/mob/clothing/suits/jacket.dmi'
	worn_icon_digi = 'modular_iris/monke_ports/icons/mob/clothing/suits/jacket_digi.dmi'
	icon = 'modular_iris/monke_ports/icons/obj/clothing/suits/jacket.dmi'
	icon_state = "TailcoatWiz"
	post_init_icon_state = "TailcoatWiz"
	inhand_icon_state = null
	flags_inv = null

/obj/item/clothing/suit/jacket/tailcoat/centcom
	name = "Centcom tailcoat"
	desc = "An official coat usually worn by executives."
	icon_state = "TailcoatCentcom"
	post_init_icon_state = "TailcoatCentcom"
	armor_type = /datum/armor/armor_centcom_formal_nt_consultant
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/british
	name = "british flag tailcoat"
	desc = "A tailcoat emblazoned with the Union Jack. Perfect attire for teatime."
	icon_state = "TailcoatBrit"
	post_init_icon_state = "TailcoatBrit"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	greyscale_colors = null


/obj/item/clothing/suit/jacket/tailcoat/communist
	name = "really red tailcoat"
	desc = "A red tailcoat emblazoned with a golden star."
	icon_state = "TailcoatCommunist"
	post_init_icon_state = "TailcoatCommunist"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	greyscale_colors = null

/obj/item/clothing/suit/jacket/tailcoat/usa
	name = "stars tailcoat"
	desc = "A vintage coat worn by the 5th battalion during the Revolutionary War. Smooth-bore musket not included."
	icon_state = "TailcoatStars"
	post_init_icon_state = "TailcoatStars"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	greyscale_colors = null

//Tailcoat END
