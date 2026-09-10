/obj/item/organ/xenodorsal
	name = "dorsal spines"
	desc = "How did that even fit on them...?"
	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL

	mutantpart_key = FEATURE_XENODORSAL

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_XENODORSAL

	bodypart_overlay = /datum/bodypart_overlay/mutant/xenodorsal

/datum/bodypart_overlay/mutant/xenodorsal
	feature_key = FEATURE_XENODORSAL
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER,
		EXTERNAL_BEHIND = BODY_BEHIND_LAYER,
	)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = ENTIRE_BODY

/datum/bodypart_overlay/mutant/xenodorsal/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/xenodorsal/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_XENODORSAL]
