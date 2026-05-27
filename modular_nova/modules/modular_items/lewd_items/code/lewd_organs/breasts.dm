
/obj/item/organ/genital/breasts
	name = "breasts"
	desc = "Female milk producing organs."
	icon_state = "breasts"
	icon = 'modular_nova/master_files/icons/obj/genitals/breasts.dmi'
	genital_type = "pair"
	mutantpart_key = ORGAN_SLOT_BREASTS
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS
	genital_location = CHEST
	drop_when_organ_spilling = FALSE
	var/lactates = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/breasts
	internal_fluid_datum = /datum/reagent/consumable/breast_milk

/datum/bodypart_overlay/mutant/genital/breasts
	feature_key = ORGAN_SLOT_BREASTS
	layers = EXTERNAL_FRONT_UNDER_CLOTHES | EXTERNAL_BEHIND

/datum/bodypart_overlay/mutant/genital/breasts/underwear_check()
	if(!istype(owner))
		return FALSE
	else
		if((owner.underwear_visibility & UNDERWEAR_HIDE_SHIRT) && (owner.underwear_visibility & UNDERWEAR_HIDE_BRA))
			return FALSE
		else
			return TRUE

/obj/item/organ/genital/breasts/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a [LOWER_TEXT(genital_name)] of breasts."
	var/size_description
	var/translation = breasts_size_to_cup(genital_size)
	switch(translation)
		if(BREAST_SIZE_FLATCHESTED)
			size_description = " They are small and flat, however."
		if(BREAST_SIZE_HUGE, BREAST_SIZE_GIGANTIC, BREAST_SIZE_ENORMOUS, BREAST_SIZE_MASSIVE, BREAST_SIZE_IMPOSSIBLE, BREAST_SIZE_BEYOND_MEASUREMENT)
			size_description = "They are beyond the concept of cup-sizes, you estimate they're around [genital_size] inches in diameter."
		else
			size_description = " You estimate they are [translation]-cups."
	returned_string += size_description
	if(aroused == AROUSAL_FULL)
		if(lactates)
			returned_string += " The nipples seem hard, perky and are leaking milk."
		else
			returned_string += " Their nipples look hard and perky."
	return returned_string

/obj/item/organ/genital/breasts/update_genital_icon_state()
	var/max_size = 5
	var/current_size = floor(genital_size)
	if(current_size < 0)
		current_size = 0
	else if (current_size > max_size)
		current_size = max_size
	var/passed_string = "breasts_pair_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/genital/breasts/get_sprite_size_string()
	var/current_size = floor(genital_size)
	current_size = clamp(current_size, 0, max_sprite_size_affix)
	var/passed_string = "[genital_type]_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/obj/item/organ/genital/breasts/build_from_dna(datum/dna/DNA, associated_key)
	lactates = DNA.features["breasts_lactation"]
	uses_skin_color = DNA.features["breasts_uses_skincolor"]
	genital_size = DNA.features["breasts_size"]
	var/breasts_capacity = 0
	var/size = 0.5
	if(DNA.features["breasts_size"] > 0)
		size = DNA.features["breasts_size"]

	switch(genital_type)
		if("pair")
			breasts_capacity = 2
		if("quad")
			breasts_capacity = 2.5
		if("sextuple")
			breasts_capacity = 3
	internal_fluid_maximum = size * breasts_capacity * 60 // This seems like it could balloon drastically out of proportion with larger breast sizes.

	return ..()

/obj/item/organ/genital/breasts/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["breasts_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading
	return ..()

/datum/bodypart_overlay/mutant/genital/breasts/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_BREASTS]

/obj/item/organ/genital/breasts/proc/breasts_size_to_cup(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.breast_size_translation["[number]"]
	if(!returned)
		returned = BREAST_SIZE_BEYOND_MEASUREMENT
	return returned

/obj/item/organ/genital/breasts/proc/breasts_cup_to_size(cup)
	for(var/key in GLOB.breast_size_translation)
		if(GLOB.breast_size_translation[key] == cup)
			return text2num(key)
	return 0
