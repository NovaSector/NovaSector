/datum/sprite_accessory/head_accessory
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/head_accessory.dmi'
	key = FEATURE_HEAD_ACCESSORY
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)
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

/datum/sprite_accessory/head_accessory/none
	name = SPRITE_ACCESSORY_NONE
	color_src = null
	natural_spawn = FALSE
	factual = FALSE

/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/owner)
	var/obj/item/clothing/head/worn_head = owner.head
	var/obj/item/clothing/mask/worn_mask = owner.wear_mask
	if((worn_head?.flags_inv & HIDEHAIR || worn_mask?.flags_inv & HIDEHAIR) \
		&& !(worn_mask && worn_mask.flags_inv & SHOWSPRITEEARS))
		return TRUE
	return FALSE

/datum/sprite_accessory/head_accessory/sylveon_bow
	name = "Sylveon Bow"
	icon_state = "sylveon_bow"

/datum/sprite_accessory/head_accessory/moogle_pom
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/moogle_pom.dmi'
	recommended_species = list(
		SPECIES_MAMMAL = 1,
		SPECIES_HUMAN = 1,
	)

/datum/sprite_accessory/head_accessory/moogle_pom/small_front
	name = "Moogle Pom (Small, Front)"
	icon_state = "mpom1"

/datum/sprite_accessory/head_accessory/moogle_pom/small_back
	name = "Moogle Pom (Small, Back)"
	icon_state = "mpom1alt"

/datum/sprite_accessory/head_accessory/moogle_pom/medium_front
	name = "Moogle Pom (Medium, Front)"
	icon_state = "mpom2"

/datum/sprite_accessory/head_accessory/moogle_pom/medium_back
	name = "Moogle Pom (Medium, Back)"
	icon_state = "mpom2alt"

/datum/sprite_accessory/head_accessory/moogle_pom/large_front
	name = "Moogle Pom (Large, Front)"
	icon_state = "mpom3"

/datum/sprite_accessory/head_accessory/moogle_pom/large_back
	name = "Moogle Pom (Large, Back)"
	icon_state = "mpom3alt"

/datum/sprite_accessory/head_accessory/halo
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/halo.dmi'
	color_src = USE_ONE_COLOR
	recommended_species = list(
		SPECIES_MAMMAL = 1,
		SPECIES_HUMAN = 1,
	)

/datum/sprite_accessory/head_accessory/halo/simple
	name = "Halo"
	icon_state = "halo"

/datum/sprite_accessory/head_accessory/halo/simple/no_animation
	name = "Halo (Static)"
	icon_state = "halo_static"

/datum/sprite_accessory/head_accessory/halo/halo_double
	name = "Double Halo"
	icon_state = "halo_double"

/datum/sprite_accessory/head_accessory/halo/halo_double/no_animation
	name = "Double Halo (Static)"
	icon_state = "halo_double_static"
