/datum/sprite_accessory/head_accessory
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/head_accessory.dmi'
	key = FEATURE_HEAD_ACCESSORY
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	organ_type = /obj/item/organ/head_accessory

/datum/sprite_accessory/head_accessory/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	factual = FALSE
	natural_spawn = FALSE

/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/H)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)))
		return TRUE
	return FALSE

/datum/sprite_accessory/head_accessory/sylveon_bow
	name = "Sylveon Head Bow"
	icon_state = "sylveon_bow"
	recommended_species = list(
		SPECIES_MAMMAL = 1,
		SPECIES_HUMAN = 1,
		SPECIES_SYNTH = 1,
		SPECIES_FELINE = 1,
		SPECIES_HUMANOID = 1,
	)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	color_src = USE_MATRIXED_COLORS
	ckey_whitelist = list("whirlsam" = TRUE)
