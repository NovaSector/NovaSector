/// The alternative `dimension_x` to use if it's a taur.
#define TAUR_DIMENSION_X 64

/datum/sprite_accessory/genital
	/// The name that shows in examine descriptions and such, if you want it to be different from the name of the sprite accessory
	var/display_name
	var/associated_organ_slot
	/// If true, then there should be a variant in the icon file that's slightly pinkier to match human base colors.
	var/has_skintone_shading = FALSE
	///Where the genital is on the body. If clothing doesn't cover it, it shows up!
	var/genital_location = GROIN
	/// The biggest size that this sprite accessory goes up to (used for icon_state)
	var/max_sprite_size_affix
	/// The biggest size that this sprite accessory goes up to for the skintone version (used for icon_state)
	var/skintone_max_sprite_size_affix

/datum/sprite_accessory/genital/is_hidden(mob/living/carbon/human/target_mob)
	var/obj/item/organ/genital/badonkers = target_mob?.get_organ_slot(associated_organ_slot)
	if(!badonkers)
		return TRUE

	switch(badonkers.visibility_preference)
		if(GENITAL_HIDDEN_BY_CLOTHES, GENITAL_CUSTOM)
			if(badonkers.get_effective_layer_mode() != GENITAL_LAYER_NORMAL)
				return FALSE
			// Single source of coverage truth, shared with is_exposed() - render
			return badonkers.covered_by_clothing(target_mob)
		//If not hidden-by-clothes or custom, it defaults to always hidden
		else
			return TRUE

/datum/sprite_accessory/genital/get_sprite_suffix()
	return "[icon_state]_[max_sprite_size_affix]"

/datum/sprite_accessory/genital/penis
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/genitals/penis_onmob.dmi'
	organ_type = /obj/item/organ/genital/penis
	associated_organ_slot = ORGAN_SLOT_PENIS
	key = FEATURE_PENIS
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	center = TRUE
	special_x_dimension = TRUE
	max_sprite_size_affix = 7
	var/can_have_sheath = TRUE

/datum/sprite_accessory/genital/penis/get_special_icon(mob/living/carbon/human/target_mob)
	var/taur_mode = target_mob?.get_taur_mode()

	if(!taur_mode || !target_mob.dna.features["penis_taur_mode"] || taur_mode & BODYSHAPE_TAUR_SNAKE)
		return icon

	return 'modular_nova/master_files/icons/mob/sprite_accessory/genitals/taur_penis_onmob.dmi'

/datum/sprite_accessory/genital/penis/get_special_x_dimension(mob/living/carbon/human/target_mob)
	var/taur_mode = target_mob?.get_taur_mode()

	if(!taur_mode || !target_mob.dna.features["penis_taur_mode"] || taur_mode & BODYSHAPE_TAUR_SNAKE)
		return dimension_x

	return TAUR_DIMENSION_X

/datum/sprite_accessory/genital/penis/get_sprite_suffix()
	return "[icon_state]_[max_sprite_size_affix]_0" // flaccid variant of the largest size

/datum/sprite_accessory/genital/penis/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	natural_spawn = FALSE
	color_src = null

/datum/sprite_accessory/genital/penis/human
	icon_state = "human"
	name = "Human"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SKIN_OR_PRIMARY
	has_skintone_shading = TRUE
	can_have_sheath = FALSE

/datum/sprite_accessory/genital/penis/human/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	max_sprite_size_affix = 5
	skintone_max_sprite_size_affix = 4

/datum/sprite_accessory/genital/penis/nondescript
	display_name = ""
	icon_state = "nondescript"
	name = "Nondescript"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/penis/nondescript/alt
	name = parent_type::name + " (Alt)"
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE
	max_sprite_size_affix = 4

/datum/sprite_accessory/genital/penis/knotted
	icon_state = "knotted"
	name = "Knotted"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/penis/knotted/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE
	max_sprite_size_affix = 5

/datum/sprite_accessory/genital/penis/flared
	icon_state = "flared"
	name = "Flared"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/penis/flared/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE
	max_sprite_size_affix = 5

/datum/sprite_accessory/genital/penis/barbknot
	icon_state = "barbknot"
	name = "Barbed, Knotted"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/penis/barbknot/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE
	max_sprite_size_affix = 5

/datum/sprite_accessory/genital/penis/tapered
	icon_state = "tapered"
	name = "Tapered"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/penis/tapered/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE
	max_sprite_size_affix = 5

/datum/sprite_accessory/genital/penis/tentacle
	icon_state = "tentacle"
	name = "Tentacled"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/penis/tentacle/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE
	max_sprite_size_affix = 4

/datum/sprite_accessory/genital/penis/hemi
	icon_state = "hemi"
	name = "Hemi"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/penis/hemi/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE
	max_sprite_size_affix = 5

/datum/sprite_accessory/genital/penis/hemiknot
	icon_state = "hemiknot"
	name = "Knotted Hemi"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/penis/hemiknot/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = PENIS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE
	max_sprite_size_affix = 5

/datum/sprite_accessory/genital/sheath
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/genitals/sheath_onmob.dmi'
	key = FEATURE_SHEATH
	feature_key_override = FEATURE_SHEATH
	associated_organ_slot = ORGAN_SLOT_PENIS
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	center = TRUE

/datum/sprite_accessory/genital/sheath/get_sprite_suffix()
	return "[icon_state]_0"

/datum/sprite_accessory/genital/sheath/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	natural_spawn = FALSE
	color_src = null

/datum/sprite_accessory/genital/sheath/normal
	name = "Sheath"
	icon_state = "normal"

/datum/sprite_accessory/genital/sheath/slit
	name = "Slit"
	icon_state = "slit"

/datum/sprite_accessory/genital/testicles
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/genitals/testicles_onmob.dmi'
	organ_type = /obj/item/organ/genital/testicles
	associated_organ_slot = ORGAN_SLOT_TESTICLES
	key = FEATURE_TESTICLES
	always_color_customizable = TRUE
	special_x_dimension = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	max_sprite_size_affix = 8
	var/has_size = TRUE

/datum/sprite_accessory/genital/testicles/get_special_icon(mob/living/carbon/human/target_mob)
	var/taur_mode = target_mob?.get_taur_mode()

	if(!taur_mode || !target_mob.dna.features["penis_taur_mode"] || taur_mode & BODYSHAPE_TAUR_SNAKE)
		return icon

	return 'modular_nova/master_files/icons/mob/sprite_accessory/genitals/taur_penis_onmob.dmi'

/datum/sprite_accessory/genital/testicles/get_special_x_dimension(mob/living/carbon/human/target_mob)
	var/taur_mode = target_mob?.get_taur_mode()

	if(!taur_mode || !target_mob.dna.features["penis_taur_mode"] || taur_mode & BODYSHAPE_TAUR_SNAKE)
		return dimension_x

	return TAUR_DIMENSION_X

/datum/sprite_accessory/genital/testicles/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	natural_spawn = FALSE
	color_src = null

/datum/sprite_accessory/genital/testicles/pair
	name = "Pair"
	icon_state = "pair"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/testicles/pair/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = TESTICLES_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	max_sprite_size_affix = 6

/datum/sprite_accessory/genital/testicles/sheath
	name = "Sheathed Pair"
	icon_state = "sheath"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/testicles/sheath/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = TESTICLES_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	has_skintone_shading = FALSE

/datum/sprite_accessory/genital/testicles/internal
	name = "Internal"
	icon_state = "none"
	color_src = null
	has_size = FALSE

/datum/sprite_accessory/genital/vagina
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/genitals/vagina_onmob.dmi'
	organ_type = /obj/item/organ/genital/vagina
	associated_organ_slot = ORGAN_SLOT_VAGINA
	key = FEATURE_VAGINA
	always_color_customizable = TRUE
	default_color = "#FFCCCC"
	var/alt_aroused = TRUE

/datum/sprite_accessory/genital/vagina/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	natural_spawn = FALSE
	color_src = null

/datum/sprite_accessory/genital/vagina/human
	icon_state = "human"
	name = "Human"

/datum/sprite_accessory/genital/vagina/tentacles
	icon_state = "tentacle"
	name = "Tentacle"

/datum/sprite_accessory/genital/vagina/dentata
	icon_state = "dentata"
	name = "Dentata"

/datum/sprite_accessory/genital/vagina/hairy
	icon_state = "hairy"
	name = "Hairy"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/spade
	icon_state = "spade"
	name = "Spade"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/furred
	icon_state = "furred"
	name = "Furred"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/gaping
	icon_state = "gaping"
	name = "Gaping"

/datum/sprite_accessory/genital/vagina/cloaca
	icon_state = "cloaca"
	name = "Cloaca"

/datum/sprite_accessory/genital/womb
	organ_type = /obj/item/organ/genital/womb
	associated_organ_slot = ORGAN_SLOT_WOMB
	key = FEATURE_WOMB

/datum/sprite_accessory/genital/womb/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	natural_spawn = FALSE
	color_src = null

/datum/sprite_accessory/genital/womb/normal
	icon_state = "none"
	name = "Normal"
	color_src = null

/datum/sprite_accessory/genital/anus
	organ_type = /obj/item/organ/genital/anus
	associated_organ_slot = ORGAN_SLOT_ANUS
	key = FEATURE_ANUS

/datum/sprite_accessory/genital/anus/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	natural_spawn = FALSE
	color_src = null

/datum/sprite_accessory/genital/anus/normal
	icon_state = "anus"
	name = "Anus"
	color_src = null

/datum/sprite_accessory/genital/breasts
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/genitals/breasts_onmob.dmi'
	organ_type = /obj/item/organ/genital/breasts
	associated_organ_slot = ORGAN_SLOT_BREASTS
	key = FEATURE_BREASTS
	always_color_customizable = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	has_skintone_shading = TRUE
	genital_location = CHEST
	max_sprite_size_affix = 5

/datum/sprite_accessory/genital/breasts/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	natural_spawn = FALSE
	color_src = null

/datum/sprite_accessory/genital/breasts/pair
	icon_state = "pair"
	name = "Pair"
	max_sprite_size_affix = 19

/datum/sprite_accessory/genital/breasts/pair/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = BREASTS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/genital/breasts/quad
	icon_state = "quad"
	name = "Quad"

/datum/sprite_accessory/genital/breasts/quad/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = BREASTS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	color_src = USE_MATRIXED_COLORS
	max_sprite_size_affix = 19

/datum/sprite_accessory/genital/breasts/sextuple
	icon_state = "sextuple"
	name = "Sextuple"
	max_sprite_size_affix = 15
	skintone_max_sprite_size_affix = 5

/datum/sprite_accessory/genital/breasts/sextuple/alt
	name = parent_type::name + " (Alt)"
	display_name = parent_type::name
	icon = BREASTS_ICON_ALT
	icon_state = parent_type::icon_state + "_alt"
	color_src = USE_MATRIXED_COLORS
	max_sprite_size_affix = 19
	skintone_max_sprite_size_affix = null

// BUTT

/datum/sprite_accessory/genital/butt
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/genitals/butt_onmob.dmi'
	organ_type = /obj/item/organ/genital/butt
	associated_organ_slot = ORGAN_SLOT_BUTT
	key = ORGAN_SLOT_BUTT
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	has_skintone_shading = TRUE
	max_sprite_size_affix = 8

/datum/sprite_accessory/genital/butt/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/butt/pair
	icon_state = "pair"
	name = "Pair"

#undef TAUR_DIMENSION_X
