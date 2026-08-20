/obj/item/organ/ears_external
	name = "fluffy ears"
	desc = "Wait, there's two pairs of these?"
	icon = 'icons/obj/clothing/head/costume.dmi'
	icon_state = "kitty"
	mutantpart_key = FEATURE_EARS
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_EARS
	organ_flags = ORGAN_EXTERNAL
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears

/datum/bodypart_overlay/mutant/ears
	feature_key = FEATURE_EARS
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER,
		EXTERNAL_ADJACENT = BODY_ADJ_LAYER,
		EXTERNAL_BEHIND = BODY_BEHIND_LAYER,
	)
	color_source = ORGAN_COLOR_OVERRIDE
	offset_location = UPPER_BODY

/datum/bodypart_overlay/mutant/ears/set_appearance_from_name(accessory_name)
	if(!accessory_name)
		accessory_name = SPRITE_ACCESSORY_NONE // Just to deal with the edge cases where there's some that wouldn't have an actual base appearance, since ears don't always need a visual component, but we have to proceed like this due to the unfortunate nature of this system.

	return ..()

/datum/bodypart_overlay/mutant/ears/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/ears/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_EARS]
