/obj/item/organ/tail
	mutantpart_key = FEATURE_TAIL
	var/can_wag = TRUE
	var/wagging = FALSE

/datum/bodypart_overlay/mutant/tail
	layers = list(
		EXTERNAL_FRONT = ABOVE_BODY_FRONT_HEAD_LAYER, // Changed from EXTERNAL_FRONT = BODY_FRONT_LAYER ON TG
		EXTERNAL_BEHIND = BODY_BEHIND_LAYER,
	)
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/tail/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_TAIL]

/datum/bodypart_overlay/mutant/tail/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/tail/get_feature_key_for_overlay()
	return (wagging ? "wagging" : "") + ..()

/datum/bodypart_overlay/mutant/tail/get_base_icon_state()
	return sprite_datum.icon_state

/obj/item/organ/tail/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_WAG_ABLE)
		wag_flags |= WAG_ABLE
	return ..()

/obj/item/organ/tail/monkey
	wag_flags = WAG_ABLE // waggable monkey tails

/obj/item/organ/tail/fluffy
	name = "fluffy tail"

/obj/item/organ/tail/fluffy/no_wag

/obj/item/organ/tail/cat

/obj/item/organ/tail/lizard
