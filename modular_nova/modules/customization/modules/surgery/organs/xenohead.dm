/obj/item/organ/xenohead
	name = "xeno head"
	desc = "How did you take that off?"
	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL

	mutantpart_key = FEATURE_XENOHEAD

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_XENOHEAD

	organ_flags = ORGAN_UNREMOVABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/xenohead

/datum/bodypart_overlay/mutant/xenohead
	feature_key = FEATURE_XENOHEAD
	layers = EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/xenohead/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/xenohead/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_XENOHEAD]
