/datum/bodypart_overlay/mutant/spines
	color_source = ORGAN_COLOR_OVERRIDE
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER,
		EXTERNAL_ADJACENT = BODY_ADJ_LAYER,
		EXTERNAL_BEHIND = BODY_BEHIND_LAYER,
	)

/datum/bodypart_overlay/mutant/spines/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/spines/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner)
	if(!..())
		return FALSE
	var/mob/living/carbon/human/human = owner || bodypart_owner.owner
	if(!istype(human))
		return TRUE
	return !sprite_datum.is_hidden(human)

/datum/bodypart_overlay/mutant/spines/get_global_feature_list()
	return SSaccessories.sprite_accessories[FEATURE_SPINES]

/datum/bodypart_overlay/mutant/tail_spines
	color_source = ORGAN_COLOR_OVERRIDE
	layers = list(
		EXTERNAL_FRONT = BODY_FRONT_LAYER,
		EXTERNAL_ADJACENT = BODY_ADJ_LAYER,
		EXTERNAL_BEHIND = BODY_BEHIND_LAYER,
	)

/datum/bodypart_overlay/mutant/tail_spines/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/tail_spines/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner)
	if (!..())
		return FALSE
	var/mob/living/carbon/human/human = owner || bodypart_owner.owner
	if(!istype(human))
		return TRUE
	return !sprite_datum.is_hidden(human)
