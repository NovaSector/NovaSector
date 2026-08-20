/obj/item/organ/neck_accessory
	name = "neck accessory"
	desc = "It goes on the neck."

	mutantpart_key = FEATURE_NECK_ACCESSORY

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_NECK_ACCESSORY
	organ_flags = ORGAN_UNREMOVABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/neck_accessory

/datum/bodypart_overlay/mutant/neck_accessory
	feature_key = FEATURE_NECK_ACCESSORY
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER,
		EXTERNAL_ADJACENT = BODY_ADJ_LAYER,
	)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = UPPER_BODY

/datum/bodypart_overlay/mutant/neck_accessory/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/neck_accessory/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_NECK_ACCESSORY]
