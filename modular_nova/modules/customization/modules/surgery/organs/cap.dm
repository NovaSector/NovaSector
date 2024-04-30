/obj/item/organ/external/mushroom_cap
	icon_state = "random_fly_1"

	mutantpart_key = "caps"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Round", MUTANT_INDEX_COLOR_LIST = list("#FF4B19"))
	slot = ORGAN_SLOT_EXTERNAL_CAP
	preference = "feature_caps"

/datum/bodypart_overlay/mutant/mushroom_cap
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/mushroom_cap/randomize_appearance()
	. = ..()
	randomize_cap_color()

/datum/bodypart_overlay/mutant/mushroom_cap/proc/randomize_cap_color()
	draw_color = pick("#FF4B19", "#925858", "#E7AB33", "#704923") // mushroom colors I guess

/datum/bodypart_overlay/mutant/mushroom_cap/override_color(rgb_value)
	if(isnull(draw_color))
		randomize_cap_color()
	return draw_color

/datum/bodypart_overlay/mutant/mushroom_cap/can_draw_on_bodypart(mob/living/carbon/human/human)
	return !sprite_datum.is_hidden(human)
