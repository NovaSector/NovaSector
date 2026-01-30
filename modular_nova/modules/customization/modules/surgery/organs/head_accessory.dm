/obj/item/organ/head_accessory
	name = "head accessory"
	desc = "It goes on the head."

	mutantpart_key = FEATURE_HEAD_ACCESSORY

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_HEAD_ACCESSORY
	organ_flags = ORGAN_UNREMOVABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/head_accessory

/datum/bodypart_overlay/mutant/head_accessory
	feature_key = FEATURE_HEAD_ACCESSORY
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/head_accessory/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/head_accessory/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_HEAD_ACCESSORY]
