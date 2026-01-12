/datum/sprite_accessory/moth_antennae
	key = FEATURE_MOTH_ANTENNAE
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	organ_type = /obj/item/organ/antennae

/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/wearer)
	var/obj/item/clothing/head/mod/worn_head = wearer.head
	if(isnull(worn_head))
		return FALSE

	// Can hide if wearing hat
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	// Exception for MODs
	if(istype(worn_head))
		return FALSE

	// Hide accessory if flagged to do so
	var/obj/item/clothing/mask/worn_mask = wearer.wear_mask
	if((worn_head?.flags_inv & HIDEHAIR || worn_mask?.flags_inv & HIDEHAIR) \
		// This line basically checks if we FORCE accessory-ears to show, for items with earholes like Balaclavas and Luchador masks
		&& ((worn_head && !(worn_head.flags_inv & SHOWSPRITEEARS)) || (worn_mask && !(wearer.wear_mask?.flags_inv & SHOWSPRITEEARS))))
		return TRUE

/datum/sprite_accessory/moth_antennae/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
