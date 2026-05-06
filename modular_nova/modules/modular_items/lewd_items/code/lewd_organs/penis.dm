/obj/item/organ/genital/penis
	name = "penis"
	desc = "A male reproductive organ."
	icon_state = "penis"
	icon = 'modular_nova/master_files/icons/obj/genitals/penis.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_PENIS
	mutantpart_key = ORGAN_SLOT_PENIS
	drop_when_organ_spilling = FALSE
	var/girth = 9
	var/sheath = SHEATH_NONE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/penis

/datum/bodypart_overlay/mutant/genital/penis
	feature_key = ORGAN_SLOT_PENIS
	layers = EXTERNAL_FRONT_UNDER_CLOTHES | EXTERNAL_BEHIND

	/// Layer as high as possible
	layer_above_all = -(BODY_FRONT_LAYER - 0.02)
	layer_above_undies = -(UNIFORM_LAYER - 0.02)
	layer_below_undies = -(UNIFORM_LAYER + 0.04)

/datum/bodypart_overlay/mutant/genital/penis/underwear_check()
	if(!istype(owner))
		return FALSE
	else
		if(owner.underwear_visibility & UNDERWEAR_HIDE_UNDIES)
			return FALSE
		else
			return TRUE


/obj/item/organ/genital/penis/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = ""
	var/pname = LOWER_TEXT(genital_name) == "nondescript" ? "" : LOWER_TEXT(genital_name) + " "
	if(sheath != SHEATH_NONE && aroused != AROUSAL_FULL) //Hidden in sheath
		switch(sheath)
			if(SHEATH_NORMAL)
				returned_string = "You see a sheath."
			if(SHEATH_SLIT)
				returned_string = "You see a slit." ///Typo fix.
		if(aroused == AROUSAL_PARTIAL)
			returned_string += " There's a [pname]penis poking out of it."
	else
		returned_string = "You see a [pname]penis. You estimate it's [genital_size] inches long, and [girth] inches in circumference."
		switch(aroused)
			if(AROUSAL_NONE)
				returned_string += " It seems flaccid."
			if(AROUSAL_PARTIAL)
				returned_string += " It's partially erect."
			if(AROUSAL_FULL)
				returned_string += " It's fully erect."
	return returned_string

/obj/item/organ/genital/penis/update_genital_icon_state()
	var/size_affix
	var/measured_size = floor(genital_size)
	if(measured_size < 1)
		measured_size = 1
	switch(measured_size)
		if(1 to 8)
			size_affix = "1"
		if(9 to 15)
			size_affix = "2"
		if(16 to 24)
			size_affix = "3"
		else
			size_affix = "4"
	var/passed_string = "penis_[genital_type]_[size_affix]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/genital/penis/get_sprite_size_string()
	if(aroused != AROUSAL_FULL && sheath != SHEATH_NONE) //Sheath time!
		var/poking_out = 0
		if(aroused == AROUSAL_PARTIAL)
			poking_out = 1
		return "[LOWER_TEXT(sheath)]_[poking_out]"

	var/size_affix
	var/measured_size = floor(genital_size)
	var/is_erect = 0
	if(aroused == AROUSAL_FULL)
		is_erect = 1
	if(measured_size < 1)
		measured_size = 1
	switch(measured_size)
		if(1 to 6)
			size_affix = "1"
		if(7 to 11)
			size_affix = "2"
		if(12 to 36)
			size_affix = "3"
		if(37 to 48)
			size_affix = "4"
		if(49 to 56)
			size_affix = "5"
		if(57 to 64)
			size_affix = "6"
		else
			size_affix = "7"
	size_affix = "[min((text2num(size_affix)), max(max_sprite_size_affix, 1))]"
	var/passed_string = "[genital_type]_[size_affix]_[is_erect]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/obj/item/organ/genital/penis/build_from_dna(datum/dna/DNA, associated_key)
	girth = DNA.features["penis_girth"]
	uses_skin_color = DNA.features["penis_uses_skincolor"]
	genital_size = DNA.features["penis_size"]

	return ..()

/obj/item/organ/genital/penis/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	var/datum/sprite_accessory/genital/penis/snake = accessory
	if(snake.can_have_sheath)
		sheath = DNA.features["penis_sheath"]
	if(DNA.features["penis_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading
	return ..()

/datum/bodypart_overlay/mutant/genital/penis/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_PENIS]
