/obj/item/organ/genital/butt
	name = "butt"
	desc = "You see a pair of asscheeks."
	icon = 'modular_nova/master_files/icons/obj/genitals/butt.dmi'
	icon_state = "butt"
	slot = ORGAN_SLOT_BUTT
	zone = BODY_ZONE_PRECISE_GROIN
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/butt
	aroused = AROUSAL_CANT
	drop_when_organ_spilling = FALSE
	genital_type = "pair"
	mutantpart_key = ORGAN_SLOT_BUTT

/obj/item/organ/genital/butt/get_description_string(datum/sprite_accessory/genital/gas)
	var/size_name
	var/butt_style = gas ? LOWER_TEXT(gas.icon_state) : LOWER_TEXT(genital_name)
	switch(round(genital_size))
		if(1)
			size_name = "average"
		if(2)
			size_name = "sizable"
		if(3)
			size_name = "squeezable"
		if(4)
			size_name = "hefty"
		if(5)
			size_name = pick("massive", "very generous")
		if(6)
			size_name = pick("gigantic", "big bubbly", "enormous")
		if(7)
			size_name = pick("unfathomably large", "extreme")
		if(8)
			size_name = pick("absolute dumptruck", "humongous", "dummy thick")
		else
			size_name = "nonexistent"

	return "You see a [butt_style] of [size_name] asscheeks."


/obj/item/organ/genital/butt/get_sprite_size_string()
	. = "[genital_type]_[floor(genital_size)]"
	if(uses_skintones)
		. += "_s"

/obj/item/organ/genital/butt/build_from_dna(datum/dna/DNA, associated_key) // Corrected DNA feature keys
	uses_skin_color = DNA.features["butt_uses_skincolor"]
	set_size(DNA.features["butt_size"])

	return ..()

/obj/item/organ/genital/butt/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["butt_uses_skintones"]) // Corrected DNA feature key
		uses_skintones = accessory.has_skintone_shading
	return ..()

/datum/bodypart_overlay/mutant/genital/butt
	feature_key = ORGAN_SLOT_BUTT
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT

/datum/bodypart_overlay/mutant/genital/butt/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_BUTT]

/datum/bodypart_overlay/mutant/genital/butt/underwear_check()
    if(!istype(owner))
        return FALSE
    else
        if(owner.underwear_visibility & UNDERWEAR_HIDE_UNDIES)
            return FALSE
        else
            return TRUE
