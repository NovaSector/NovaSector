/datum/sprite_accessory/neck_accessory
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/neck_accessory.dmi'
	key = FEATURE_NECK_ACCESSORY
	organ_type = /obj/item/organ/neck_accessory
	recommended_species = list(
		SPECIES_MAMMAL = 1,
		SPECIES_HUMAN = 1,
		SPECIES_SYNTH = 1,
		SPECIES_FELINE = 1,
		SPECIES_HUMANOID = 1,
	)
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

/datum/sprite_accessory/neck_accessory/is_hidden(mob/living/carbon/human/wearer, datum/bodypart_overlay/mutant/bodypart_overlay)
	. = ..()
	if(.)
		return

	return !!(wearer.obscured_slots & HIDEHAIR)
