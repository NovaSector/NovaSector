/obj/item/organ/genital/anus
	name = "anus"
	desc = "What do you want me to tell you?"
	icon = 'modular_nova/master_files/icons/obj/genitals/anus.dmi'
	icon_state = "anus"
	mutantpart_key = ORGAN_SLOT_ANUS
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_ANUS
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/anus

/datum/bodypart_overlay/mutant/genital/anus
	feature_key = ORGAN_SLOT_ANUS
	layers = NONE

/obj/item/organ/genital/anus/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see an [LOWER_TEXT(genital_name)]."
	if(aroused == AROUSAL_PARTIAL)
		returned_string += " It looks tight."
	if(aroused == AROUSAL_FULL)
		returned_string += " It looks very tight."
	return returned_string

/datum/bodypart_overlay/mutant/genital/anus/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_ANUS]
