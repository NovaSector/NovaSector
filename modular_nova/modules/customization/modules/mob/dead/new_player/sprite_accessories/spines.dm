/datum/sprite_accessory/spines
	key = FEATURE_SPINES
	default_color = DEFAULT_SECONDARY
	recommended_species = list(SPECIES_LIZARD, SPECIES_UNATHI, SPECIES_LIZARD_ASH, SPECIES_LIZARD_SILVER)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)
	organ_type = /obj/item/organ/spines

/datum/sprite_accessory/spines/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/spines/is_hidden(mob/living/carbon/human/wearer)
	var/obj/item/clothing/worn_uniform = wearer.w_uniform
	var/obj/item/clothing/suit/mod/worn_suit = wearer.wear_suit
	if(worn_uniform?.flags_inv & HIDESPINE)
		return TRUE
	if(worn_suit?.flags_inv & HIDESPINE)
		return TRUE
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	return FALSE

/datum/sprite_accessory/tail_spines
	key = FEATURE_TAILSPINES
	default_color = DEFAULT_SECONDARY
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)

/datum/sprite_accessory/tail_spines/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/tail_spines/is_hidden(mob/living/carbon/human/wearer)
	if(wearer.owned_turf?.name == "tail")
	// Emote exception
		return TRUE

	var/obj/item/clothing/suit/mod/worn_suit = wearer.wear_suit
	if(isnull(wearer.w_uniform) && isnull(worn_suit))
		return FALSE
	if("spines" in wearer.try_hide_mutant_parts)
		return TRUE
	if("tail" in wearer.try_hide_mutant_parts)
		return TRUE

	if(worn_suit)
		// Exception for MODs
		if(istype(worn_suit))
			return FALSE
		// Hide accessory if flagged to do so
		if(worn_suit.flags_inv & HIDETAIL)
			return TRUE

	return FALSE
