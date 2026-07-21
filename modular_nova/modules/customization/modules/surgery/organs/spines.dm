/datum/bodypart_overlay/mutant/spines
	color_source = ORGAN_COLOR_OVERRIDE
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER,
		EXTERNAL_ADJACENT = BODY_ADJ_LAYER,
		EXTERNAL_BEHIND = BODY_BEHIND_LAYER,
	)

/datum/bodypart_overlay/mutant/spines/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/tail_spines
	color_source = ORGAN_COLOR_OVERRIDE
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER,
		EXTERNAL_ADJACENT = BODY_ADJ_LAYER,
		EXTERNAL_BEHIND = BODY_BEHIND_LAYER,
	)

/datum/bodypart_overlay/mutant/tail_spines/override_color(rgb_value)
	return draw_color
