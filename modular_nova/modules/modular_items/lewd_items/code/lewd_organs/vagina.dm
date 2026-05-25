/obj/item/organ/genital/vagina
	name = "vagina"
	icon = 'modular_nova/master_files/icons/obj/genitals/vagina.dmi'
	icon_state = "vagina"
	mutantpart_key = ORGAN_SLOT_VAGINA
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/vagina
	internal_fluid_datum = /datum/reagent/consumable/femcum

/datum/bodypart_overlay/mutant/genital/vagina
	feature_key = ORGAN_SLOT_VAGINA
	layers = EXTERNAL_FRONT_UNDER_CLOTHES

	/// Lowest-layering thing that affects the crotch
	layer_above_all = -(BODY_FRONT_LAYER - 0.03)
	layer_above_undies = -(UNIFORM_LAYER - 0.03)
	layer_below_undies = -(UNIFORM_LAYER + 0.05)

/datum/bodypart_overlay/mutant/genital/vagina/underwear_check()
	if(!istype(owner))
		return FALSE
	else
		if(owner.underwear_visibility & UNDERWEAR_HIDE_UNDIES)
			return FALSE
		else
			return TRUE

/obj/item/organ/genital/vagina/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a [LOWER_TEXT(genital_name)] vagina."
	if(LOWER_TEXT(genital_name) == "cloaca")
		returned_string = "You see a cloaca." //i deserve a pipebomb for this
	switch(aroused)
		if(AROUSAL_NONE)
			returned_string += " It seems dry."
		if(AROUSAL_PARTIAL)
			returned_string += " It's glistening with arousal."
		if(AROUSAL_FULL)
			returned_string += " It's bright and dripping with arousal."
	return returned_string

/obj/item/organ/genital/vagina/get_sprite_size_string()
	var/is_dripping = 0
	if(aroused == AROUSAL_FULL)
		is_dripping = 1
	return "[genital_type]_[is_dripping]"

/obj/item/organ/genital/vagina/build_from_dna(datum/dna/DNA, associated_key)
	uses_skin_color = DNA.features["vagina_uses_skincolor"]
	internal_fluid_maximum = 10

	return ..() // will update the sprite suffix

/obj/item/organ/genital/vagina/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["vagina_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading

/datum/bodypart_overlay/mutant/genital/vagina/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_VAGINA]
