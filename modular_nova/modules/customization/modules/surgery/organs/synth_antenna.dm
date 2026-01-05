/obj/item/organ/synth_antenna
	name = "synth antenna"
	desc = "Wonder if we'll catch Syndicate frequencies with these..."

	mutantpart_key = FEATURE_SYNTH_ANTENNA

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_SYNTH_ANTENNA

	bodypart_overlay = /datum/bodypart_overlay/mutant/synth_antenna
	use_mob_sprite_as_obj_sprite = TRUE

/datum/bodypart_overlay/mutant/synth_antenna
	feature_key = FEATURE_SYNTH_ANTENNA
	layers = EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/synth_antenna/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/synth_antenna/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_SYNTH_ANTENNA]
