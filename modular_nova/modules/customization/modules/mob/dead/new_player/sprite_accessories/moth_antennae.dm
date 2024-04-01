/datum/sprite_accessory/moth_antennae
	generic = "Moth Antennae"
	key = "moth_antennae"
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/external/antennae

/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/wearer)
	if(!wearer.head)
		return FALSE

	// Can hide if wearing hat
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	// Exception for MODs
	if(istype(wearer.head, /obj/item/clothing/head/mod))
		return FALSE

	// Hide accessory if flagged to do so
	if((wearer.head?.flags_inv & HIDEHAIR || wearer.wear_mask?.flags_inv & HIDEHAIR) \
		// This line basically checks if we FORCE accessory-ears to show, for items with earholes like Balaclavas and Luchador masks
		&& ((wearer.head && !(wearer.head.flags_inv & SHOWSPRITEEARS)) || (wearer.wear_mask && !(wearer.wear_mask?.flags_inv & SHOWSPRITEEARS))))
		return TRUE

/datum/sprite_accessory/moth_antennae/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/moth_antennae/moogle
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/moogle_pom.dmi'

/datum/sprite_accessory/moth_antennae/moogle/mpom1
	name = "Moogle Pom (Small, Front)"
	icon_state = "mpom1"

/datum/sprite_accessory/moth_antennae/moogle/mpom1alt
	name = "Moogle Pom (Small, Back)"
	icon_state = "mpom1alt"

/datum/sprite_accessory/moth_antennae/moogle/mpom2
	name = "Moogle Pom (Medium, Front)"
	icon_state = "mpom2"

/datum/sprite_accessory/moth_antennae/moogle/mpom2alt
	name = "Moogle Pom (Medium, Back)"
	icon_state = "mpom2alt"

/datum/sprite_accessory/moth_antennae/moogle/mpom3
	name = "Moogle Pom (Large, Front)"
	icon_state = "mpom3"

/datum/sprite_accessory/moth_antennae/moogle/mpom3alt
	name = "Moogle Pom (Large, Back)"
	icon_state = "mpom3alt"

