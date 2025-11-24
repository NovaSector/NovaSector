/*

SOLFED ARMOR VALUES!

*/

// Regular armor resistances (NT Security ERT Protection Grade But Sidegrade [Boosted armor, no eva])
/datum/armor/clothing_under/solfed_response_standard
	melee = 50
	bullet = 50
	laser = 50
	energy = 50
	bomb = 50
	bio = 25
	fire = 25
	acid = 25
	wound = 30

// Grand Response armor resistances (NT Asset Protection Grade But Sidegrade [Boosted armor, no eva])
/datum/armor/clothing_under/solfed_response_grand
	melee = 80
	bullet = 80
	laser = 70
	energy = 60
	bomb = 80
	bio = 20
	fire = 50
	acid = 50
	wound = 45

/obj/item/clothing/suit/armor/vest/sol
	name = "'Gordyn' flak vest"
	desc = "A light armored jacket common on SolFed personnel who need armor, but find a full vest \
		too impractical or unneeded."
	icon = 'modular_nova/modules/goofsec/icons/obj/suits.dmi'
	icon_state = "flak"
	worn_icon = 'modular_nova/modules/goofsec/icons/mob/suits.dmi'
	worn_icon_digi = 'modular_nova/modules/goofsec/icons/mob/suits_digi.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	dog_fashion = null

// SolFed civilian armored vest
/obj/item/clothing/suit/armor/vest/sol/civil
	name = "'Safeguard' Combat Vest"
	desc = "A lightly armored sol federation combat vest, built for civilians to remain safe in dangerous areas."
	icon_state = "civil-response-vest"

// SolFed armored vest
/obj/item/clothing/suit/armor/vest/sol/police
	name = "'Orion' Police Vest"
	icon_state = "civil-response-police"

/obj/item/clothing/suit/armor/vest/sol/ems
	name = "'Hera' Emergency Medical Response vest"
	icon_state = "civil-response-medic"

/obj/item/clothing/suit/armor/vest/sol/atmos
	name = "'Aphrodite' Emergeency Response vest"
	icon_state = "civil-response-engi"

/obj/item/clothing/suit/armor/vest/sol/escallated
	name = "'Artemis' Escallated Combat vest"
	icon_state = "civil-response-vest-escallated"

/obj/item/clothing/suit/armor/vest/sol/droprig
	name = "'Hestia' Combat Drop Rig"
	icon_state = "drop-rig"

/obj/item/clothing/suit/armor/vest/sol/smartgunner
	name = "'Athena' Smartgunner rig"
	icon_state = "smartgunner-harness"

/obj/item/clothing/suit/armor/vest/sol/smartgunner/heavy
	name = "'Ares' Smartgunner Heavy rig"
	icon_state = "smartgunner-armored"

// SolFed Heavy Armor for Marines
/obj/item/clothing/suit/armor/vest/sol/marine
	name = "\improper 'Hephaestus' light armor"
	desc = "Through space, snow, oceans, painful hills and terrain, the 'Hephaestus' light armor is one of the Sol Federation's most unique combat vests, \
	used in the older days during the war of the rimworlds, its proven useful but outdated."
	icon_state = "icons/map_icons/clothing/suit/_suit"
	post_init_icon_state = "hephaestus"
	worn_icon_state = "hephaestus"
	armor_type = /datum/armor/clothing_under/solfed_response_standard
	greyscale_config = /datum/greyscale_config/vestcam
	greyscale_config_worn = /datum/greyscale_config/vestcam/worn
	greyscale_colors = "#4d4d4d"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/sol/marine/mk2
	name = "\improper 'Hercules' heavy armor"
	desc = "Through space, snow, oceans, painful hills and terrain, the 'Hercules' heavy armor is the Sol Federation's most versatile and robust heavily armored vest and padding, \
		to protect its marines from the most dangerous of threats in the most alien of environments."
	icon_state = "icons/map_icons/clothing/suit/_suit"
	post_init_icon_state = "hercules"
	worn_icon_state = "hercules"
	worn_icon_digi = "hercules"
	armor_type = /datum/armor/clothing_under/solfed_response_grand
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
