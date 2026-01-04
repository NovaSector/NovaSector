/datum/sprite_accessory/neck_accessory
	name = "Sylveon Neck Bow"
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/neck_accessory.dmi'
	key = FEATURE_NECK_ACCESSORY
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	organ_type = /obj/item/organ/neck_accessory
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

/datum/sprite_accessory/neck_accessory/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	factual = FALSE
	natural_spawn = FALSE
	ckey_whitelist = null

/datum/sprite_accessory/neck_accessory/is_hidden(mob/living/carbon/human/wearer)
	if(wearer.w_uniform)
		if(key in wearer.try_hide_mutant_parts)
			return TRUE
	return FALSE
