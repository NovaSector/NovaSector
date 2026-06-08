// Abstract types to cut down on copypasta; rendered through the Mammal Pregnancy quirk customization menu.

/// Abstract base for numeric pregnancy prefs
/datum/preference/numeric/pregnancy
	abstract_type = /datum/preference/numeric/pregnancy

/datum/preference/numeric/pregnancy/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	return /datum/quirk/mammal_pregnancy::name in preferences.all_quirks

/datum/preference/numeric/pregnancy/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Abstract base for toggle pregnancy prefs
/datum/preference/toggle/pregnancy
	abstract_type = /datum/preference/toggle/pregnancy

/datum/preference/toggle/pregnancy/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	return /datum/quirk/mammal_pregnancy::name in preferences.all_quirks

/datum/preference/toggle/pregnancy/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/pregnancy/chance
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_chance"
	minimum = PREGNANCY_CHANCE_MINIMUM
	maximum = PREGNANCY_CHANCE_MAXIMUM

/datum/preference/numeric/pregnancy/chance/create_default_value()
	return PREGNANCY_CHANCE_DEFAULT

/datum/preference/toggle/pregnancy/cryptic
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_cryptic"
	default_value = FALSE

/datum/preference/toggle/pregnancy/belly_inflation
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_belly_inflation"
	default_value = TRUE

/datum/preference/toggle/pregnancy/nausea
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_nausea"
	default_value = FALSE
