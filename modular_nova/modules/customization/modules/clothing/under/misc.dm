/obj/item/clothing/under/misc/bluetracksuit
	name = "blue tracksuit"
	desc = "Found on a dead homeless man squatting in an alleyway, the classic design has been mass produced to bring terror to the galaxy."
	icon = 'modular_nova/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tracksuit_blue"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/tachawaiian
	name = "orange tactical hawaiian outfit"
	desc = "Clearly the wearer didn't know if they wanted to invade a country or lay on a nice Hawaiian beach."
	icon = 'modular_nova/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tacticool_hawaiian_orange"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/tachawaiian/blue
	name = "blue tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_blue"

/obj/item/clothing/under/tachawaiian/purple
	name = "purple tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_purple"

/obj/item/clothing/under/tachawaiian/green
	name = "green tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_green"

/obj/item/clothing/under/texas
	name = "texan formal outfit"
	desc = "A premium quality shirt and pants combo straight from Texas."
	icon = 'modular_nova/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "texas"
	supports_variations_flags = NONE

/obj/item/clothing/under/doug_dimmadome
	name = "dimmadome formal outfit"
	desc = "A tight fitting suit with a belt that is surely made out of gold."
	icon = 'modular_nova/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "doug_dimmadome"
	supports_variations_flags = NONE

/obj/item/clothing/under/pants/tactical
	icon = 'modular_nova/master_files/icons/obj/clothing/under/shorts_pants_shirts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'
	name = "tactical pants"
	desc = "A pair of tactical pants, designed for military use."
	icon_state = "tactical_pants"

/obj/item/clothing/under/pants/nova/big_pants
	name = "\improper JUNCO megacargo pants"
	desc = "De riguer for techno classicists, these extreme wide leg pants come back into style every \
		now and then. This pair has generous onboard storage."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/big_pants"
	post_init_icon_state = "big_pants"
	greyscale_config = /datum/greyscale_config/big_pants
	greyscale_config_worn = /datum/greyscale_config/big_pants/worn
	greyscale_config_worn_digi = /datum/greyscale_config/big_pants/worn/digi
	greyscale_colors = "#874f16"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER

/obj/item/clothing/under/pants/nova/loose_pants
	name = "Loose pants"
	desc = "Some loose pants with a belt that looks comfy."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/loose_pants"
	post_init_icon_state = "loose_pants"
	greyscale_config = /datum/greyscale_config/loose_pants
	greyscale_config_worn = /datum/greyscale_config/loose_pants/worn
	greyscale_colors = "#4d4d4d#666633#c0c0c0"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER

/obj/item/clothing/under/pants/nova/hakama
	name = "hakama"
	desc = "Traditional Japanese wide-legged trousers, often worn with formal attire."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/hakama"
	post_init_icon_state = "hakama"
	greyscale_config = /datum/greyscale_config/hakama
	greyscale_config_worn = /datum/greyscale_config/hakama/worn
	greyscale_colors = "#292929#ffffff#ff0000"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = LOW_FACEMASK_LAYER
