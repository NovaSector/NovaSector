/obj/item/organ/genital/testicles
	name = "testicles"
	desc = "A male reproductive organ."
	icon_state = "testicles"
	icon = 'modular_nova/master_files/icons/obj/genitals/testicles.dmi'
	mutantpart_key = ORGAN_SLOT_TESTICLES
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES
	aroused = AROUSAL_CANT
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/testicles
	internal_fluid_datum = /datum/reagent/consumable/cum

/datum/bodypart_overlay/mutant/genital/testicles
	feature_key = ORGAN_SLOT_TESTICLES
	layers = EXTERNAL_ADJACENT | EXTERNAL_BEHIND

	/// Layer a bit lower, but still close to as high as possible
	layer_above_all = -(BODY_FRONT_LAYER - 0.01)
	layer_above_undies = -(UNIFORM_LAYER - 0.01)
	layer_below_undies = -(UNIFORM_LAYER + 0.03)

/datum/bodypart_overlay/mutant/genital/testicles/underwear_check()
	if(!istype(owner))
		return FALSE
	else
		if(owner.underwear_visibility & UNDERWEAR_HIDE_UNDIES)
			return FALSE
		else
			return TRUE

/obj/item/organ/genital/testicles/update_genital_icon_state()
	var/measured_size = clamp(genital_size, 1, TESTICLES_MAX_SIZE)
	var/passed_string = "testicles_[genital_type]_[measured_size]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/genital/testicles/get_description_string(datum/sprite_accessory/genital/gas)
	if(genital_name == "Internal") //Checks if Testicles are of Internal Variety
		visibility_preference = GENITAL_SKIP_VISIBILITY //Removes visibility if yes.
	else
		return "You see a pair of testicles, they look [LOWER_TEXT(balls_size_to_description(genital_size))]."

/obj/item/organ/genital/testicles/build_from_dna(datum/dna/DNA, associated_key)
	uses_skin_color = DNA.features["testicles_uses_skincolor"]
	genital_size = DNA.features["balls_size"]
	var/size = 0.5
	if(DNA.features["balls_size"] > 0)
		size = DNA.features["balls_size"]

	internal_fluid_maximum = size * 20

	return ..()

/obj/item/organ/genital/testicles/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["testicles_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading
	return ..()

/obj/item/organ/genital/testicles/get_sprite_size_string()
	var/measured_size = floor(genital_size)
	measured_size = clamp(measured_size, 0, max_sprite_size_affix)
	var/passed_string = "[genital_type]_[measured_size]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/datum/bodypart_overlay/mutant/genital/testicles/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_TESTICLES]

/obj/item/organ/genital/testicles/proc/balls_size_to_description(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.balls_size_translation["[number]"]
	if(!returned)
		returned = BREAST_SIZE_BEYOND_MEASUREMENT
	return returned

/obj/item/organ/genital/testicles/proc/balls_description_to_size(cup)
	for(var/key in GLOB.balls_size_translation)
		if(GLOB.balls_size_translation[key] == cup)
			return text2num(key)
	return 0
