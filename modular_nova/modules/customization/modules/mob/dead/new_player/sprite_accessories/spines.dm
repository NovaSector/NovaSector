/datum/sprite_accessory/spines
	key = "spines"
	generic = "Spines"
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/lizard_spines.dmi'
	special_render_case = TRUE
	default_color = DEFAULT_SECONDARY
	recommended_species = list(SPECIES_LIZARD, SPECIES_UNATHI, SPECIES_LIZARD_ASH, SPECIES_LIZARD_SILVER)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/external/spines

/datum/sprite_accessory/spines/is_hidden(mob/living/carbon/human/wearer)
	var/obj/item/organ/external/tail/tail = wearer.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	//	Can hide if wearing uniform
	if(key in wearer.try_hide_mutant_parts)
		return TRUE
	if(wearer.wear_suit)
	//	Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE
	else if(!tail \
			|| (wearer.wear_suit \
				&& (wearer.wear_suit.flags_inv & HIDETAIL \
				|| wearer.wear_suit.flags_inv & HIDESPINE) \
			)
		)
		return TRUE

/datum/sprite_accessory/spines/get_special_render_state(mob/living/carbon/human/H)
	return icon_state

/datum/sprite_accessory/spines/is_hidden(mob/living/carbon/human/wearer)
	var/list/used_in_turf = list("tail")
	// Emote exception
	if(wearer.owned_turf?.name in used_in_turf)
		return TRUE

	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	if(wearer.wear_suit)
		// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE

		// Hide accessory if flagged to do so
		else if(wearer.wear_suit.flags_inv & HIDETAIL)
			return TRUE

	return FALSE
