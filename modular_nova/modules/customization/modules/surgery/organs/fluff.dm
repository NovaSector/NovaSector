/obj/item/organ/fluff
	name = "fluff"
	desc = "Real fluffy."

	mutantpart_key = FEATURE_FLUFF

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_FLUFF
	organ_flags = ORGAN_UNREMOVABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/fluff

/datum/bodypart_overlay/mutant/fluff
	feature_key = FEATURE_FLUFF
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/fluff/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/fluff/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_FLUFF]
