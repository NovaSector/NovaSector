/datum/bodypart_overlay/mutant/spines
	color_source = ORGAN_COLOR_OVERRIDE
	layers = ALL_EXTERNAL_OVERLAYS

/datum/bodypart_overlay/mutant/spines/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/spines/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner)
	var/mob/living/carbon/human/human = bodypart_owner.owner
	if(!istype(human))
		return TRUE
	return !sprite_datum.is_hidden(human)

/datum/bodypart_overlay/mutant/spines/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_SPINES]

/datum/bodypart_overlay/mutant/tail_spines
	color_source = ORGAN_COLOR_OVERRIDE
	layers = ALL_EXTERNAL_OVERLAYS

/datum/bodypart_overlay/mutant/tail_spines/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/tail_spines/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner)
	var/mob/living/carbon/human/human = bodypart_owner.owner
	if(!istype(human))
		return TRUE
	return !sprite_datum.is_hidden(human)
