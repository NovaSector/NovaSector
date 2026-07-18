/obj/item/organ/horns
	desc = "Why do some people even have horns? Well, this one obviously doesn't."
	mutantpart_key = FEATURE_HORNS

/datum/bodypart_overlay/mutant/horns
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER,
		EXTERNAL_ADJACENT = BODY_ADJ_LAYER,
		EXTERNAL_BEHIND = BODY_BEHIND_LAYER,
	)
	feature_key = FEATURE_HORNS
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/horns/override_color(rgb_value)
	return draw_color
