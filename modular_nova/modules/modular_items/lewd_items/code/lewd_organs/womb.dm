/obj/item/organ/genital/womb
	name = "womb"
	desc = "A female reproductive organ."
	icon = 'modular_nova/master_files/icons/obj/genitals/vagina.dmi'
	icon_state = "womb"
	mutantpart_key = ORGAN_SLOT_WOMB
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_WOMB
	visibility_preference = GENITAL_SKIP_VISIBILITY
	aroused = AROUSAL_CANT
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/womb

/datum/bodypart_overlay/mutant/genital/womb
	feature_key = ORGAN_SLOT_WOMB
	layers = NONE

/datum/bodypart_overlay/mutant/genital/womb/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_WOMB]
