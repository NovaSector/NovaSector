/datum/sprite_accessory/neck_accessory
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/neck_accessory.dmi'
	key = FEATURE_NECK_ACCESSORY
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	organ_type = /obj/item/organ/neck_accessory
	recommended_species = list(
		SPECIES_MAMMAL = 1,
		SPECIES_HUMAN = 1,
		SPECIES_SYNTH = 1,
		SPECIES_FELINE = 1,
		SPECIES_HUMANOID = 1,
	)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/neck_accessory/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	factual = FALSE
	natural_spawn = FALSE

/datum/sprite_accessory/neck_accessory/sylveon_bow
	name = "Sylveon Bow"
	icon_state = "sylveon_bow"

/datum/sprite_accessory/neck_accessory/is_hidden(mob/living/carbon/human/wearer)
	var/obj/item/clothing/head/worn_neck = wearer.wear_neck
	var/obj/item/clothing/mask/worn_mask = wearer.wear_mask
	if((worn_neck?.flags_inv & HIDEHAIR || worn_mask?.flags_inv & HIDEHAIR))
		return TRUE
	return FALSE
