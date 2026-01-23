/datum/atom_skin/security_armor_vest_white
	abstract_type = /datum/atom_skin/security_armor_vest_white

/datum/atom_skin/security_armor_vest_white/black
	preview_name = "Black Variant"
	new_icon_state = "vest_black"

/datum/atom_skin/security_armor_vest_white/blue
	preview_name = "Blue Variant"
	new_icon_state = "vest_blue"

/datum/atom_skin/security_armor_vest_white/white
	preview_name = "White Variant"
	new_icon_state = "vest_white"

/obj/item/clothing/suit/armor/vest/alt/sec/white
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "vest_white"

/obj/item/clothing/suit/armor/vest/alt/sec/white/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_armor_vest_white)

/obj/item/clothing/suit/armor/vest/brit
	name = "high vis armored vest"
	desc = "Oi bruv, you got a loicence for that?"
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hazardbg"
	worn_icon_state = "hazardbg"

/obj/item/clothing/suit/armor/vest/brit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

/obj/item/clothing/suit/armor/vest/jacket
	name = "high vis security jacket"
	desc = "A slightly vintage canvas and aramid jacket; hi-vis checkers included. Armored and stylish? Implausible."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "highvis_jacket"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

/obj/item/clothing/suit/armor/vest/peacekeeper/jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

/obj/item/clothing/suit/armor/vest/jacket/badge
	name = "badged high vis security jacket"
	desc = "A slightly vintage canvas and aramid jacket; hi-vis checkers and chevron badge included. Armored and stylish? Implausible."
	icon_state = "highvis_jacket_badge"


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
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/blue

/*
*	WARDEN
*/

/obj/item/clothing/suit/armor/vest/warden/blue
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "vest_warden"

/*
*	Head of Security
*/

/obj/item/clothing/suit/armor/hos/hos_formal/black
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hosformal_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
