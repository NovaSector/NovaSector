/datum/sprite_accessory/head_accessory
	name = "Sylveon Head Bow"
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/head_accessory.dmi'
	icon_state = "sylveon_bow"
	key = FEATURE_HEAD_ACCESSORY
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	organ_type = /obj/item/organ/head_accessory
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

/datum/sprite_accessory/head_accessory/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	natural_spawn = FALSE
	factual = FALSE
	ckey_whitelist = null

/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/owner)
	if(owner.head && (owner.head.flags_inv & HIDEHAIR) || (owner.wear_mask && (owner.wear_mask.flags_inv & HIDEHAIR)))
		return TRUE
	return FALSE
