/datum/sprite_accessory/moth_antennae
	key = FEATURE_MOTH_ANTENNAE
	organ_type = /obj/item/organ/antennae
	flags_custom_mod_icon = MOD_ACCESSORY_HELMET

/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/wearer, datum/bodypart_overlay/mutant/bodypart_overlay)
	. = ..()
	if(.)
		return

	if(wearer.obscured_slots & HIDEHAIR)
		if(istype(wearer.head, /obj/item/clothing/head/mod))
			return FALSE // i'm so sorry, this is still required
		if(wearer.obscured_slots & SHOWSPRITEEARS)
			return FALSE
		return TRUE

/datum/sprite_accessory/moth_antennae/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	natural_spawn = FALSE
