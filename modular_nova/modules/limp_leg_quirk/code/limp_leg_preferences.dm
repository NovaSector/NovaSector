/datum/preference/choiced/limp_leg
	savefile_key = "limp_leg"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/limp_leg/create_default_value()
	return "Left leg"

/datum/preference/choiced/limp_leg/init_possible_values()
	return list("Left leg")
	//return GLOB.limp_leg_choice

/datum/preference/choiced/limp_leg/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Limp leg" in preferences.all_quirks

/datum/preference/choiced/limp_leg/apply_to_human(mob/living/carbon/human/target, value)
	return

GLOBAL_LIST_INIT(limp_leg_choice, list(
	"Random",
	"Left Leg",
	"Right Leg",
))
