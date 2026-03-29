// This part essential to display colors on greyscale antennaes
/datum/bodypart_overlay/mutant/antennae
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/antennae/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_MOTH_ANTENNAE]

/datum/bodypart_overlay/mutant/antennae/override_color(rgb_value)
	return draw_color
