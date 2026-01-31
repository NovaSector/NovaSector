/datum/sprite_accessory/fourarms
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/four_arms.dmi'
	key = FEATURE_FOURARMS
	relevent_layers = ALL_EXTERNAL_OVERLAYS
	organ_type = /obj/item/organ/fourarms
	color_src = USE_ONE_COLOR
	icon_state = "quadarm"
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/fourarms/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE

// The base sprites for the other arms are all there, but they'll require manual adjustment into position.
// My initial idea was to just clone the arms overlays during runtime and snap them into the correct spot...
// ... but .dm felt too restrictive for me to manage to do that, so, instead, I edited a couple spritesheets by hand.

/datum/sprite_accessory/fourarms/insectoid
	name = "Insectoid"
	icon_state = "insectoid"

/*
/datum/sprite_accessory/fourarms/standard
	name = "Human"
	icon_state = "human"

/datum/sprite_accessory/fourarms/humanoid
	name = "Humanoid"
	icon_state = "humanoid"

/datum/sprite_accessory/fourarms/akula
	name = "Akula"
	icon_state = "akula"

/datum/sprite_accessory/fourarms/aquatic
	name = "Aquatic"
	icon_state = "aquatic"

/datum/sprite_accessory/fourarms/insect
	name = "Insect"
	icon_state = "insect"

/datum/sprite_accessory/fourarms/lizard
	name = "Lizard"
	icon_state = "lizard"

/datum/sprite_accessory/fourarms/mammal
	name = "Mammal"
	icon_state = "mammal"

/datum/sprite_accessory/fourarms/moth
	name = "Moth"
	icon_state = "moth"

/datum/sprite_accessory/fourarms/skrell
	name = "Skrell"
	icon_state = "skrell"

/datum/sprite_accessory/fourarms/slime
	name = "Slime"
	icon_state = "slime"

/datum/sprite_accessory/fourarms/xeno
	name = "Xeno"
	icon_state = "xeno"
*/

/datum/sprite_accessory/fourarms/is_hidden(mob/living/carbon/human/wearer)
	var/obj/item/clothing/suit/mod/worn_suit = wearer.wear_suit
	if(isnull(wearer.w_uniform) && isnull(worn_suit))
		return FALSE
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	if(worn_suit)
		// Exception for MODs
		if(istype(worn_suit))
			return FALSE
		// Hide accessory if flagged to do so
		else if(worn_suit.flags_inv & HIDEFOURARMS)
			return TRUE
