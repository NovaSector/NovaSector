// Make spacer's gravity wellness effect visible so players know something is happening.
/datum/status_effect/spacer/gravity_wellness
	alert_type = /atom/movable/screen/alert/status_effect/gravity_wellness

/atom/movable/screen/alert/status_effect/gravity_wellness
	name = "Gravity Wellness"
	desc = "Your physiology thrives in low-gravity conditions: you catch your breath quicker and are more mobile."
	icon_state = "negative"

GLOBAL_LIST_INIT(spacer_height_choices, list(
	"Normal Height" = HUMAN_HEIGHT_MEDIUM,
	"Tall" = HUMAN_HEIGHT_TALL,
	"Taller" = HUMAN_HEIGHT_TALLER,
	"Tallest" = HUMAN_HEIGHT_TALLEST,
))

/datum/preference/choiced/spacer_height
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "spacer_height"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/spacer_height/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.spacer_height_choices)

/datum/preference/choiced/spacer_height/is_accessible(datum/preferences/preferences)
	return ..() && (/datum/quirk/spacer_born::name in preferences.all_quirks)

/datum/preference/choiced/csl_strength/create_default_value()
	return init_possible_values()[1]

/datum/quirk_constant_data/spacer_height
	associated_typepath = /datum/quirk/spacer_born
	customization_options = list(/datum/preference/choiced/spacer_height)

/datum/preference/choiced/spacer_height/create_default_value()
	return HUMAN_HEIGHT_MEDIUM

/datum/preference/choiced/spacer_height/apply_to_human(mob/living/carbon/human/target, value)
	return
