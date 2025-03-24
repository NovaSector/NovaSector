/obj/item/clothing/suit/armor/vest/alt/sec/white
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "vest_white"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "vest_black",
			RESKIN_WORN_ICON_STATE = "vest_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "vest_blue",
			RESKIN_WORN_ICON_STATE = "vest_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "vest_white",
			RESKIN_WORN_ICON_STATE = "vest_white"
		),
	)

/obj/item/clothing/suit/armor/vest/warden/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "vest_warden"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Standard" = list(
			RESKIN_ICON = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "vest_warden",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "vest_warden",
		),
		"Basic Warden Armor" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "warden_alt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "warden_alt"
		),
	)

/obj/item/clothing/head/hooded/winterhood/security/blue
	desc = "A blue, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes."
	icon = 'modular_nova/master_files/icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head/winterhood.dmi'
	icon_state = "winterhood_security"

/obj/item/clothing/suit/hooded/wintercoat/security/blue
	name = "security winter coat"
	desc = "A blue, armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coatsecurity_winter"

/obj/item/clothing/suit/armor/hos/hos_formal/black
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hosformal_black"
	current_skin = "hosformal_black"	//prevents reskinning (but not toggling!)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
