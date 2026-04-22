// Abstract types to cut down on copypasta; all gated on master ERP pref and config.

/// Abstract base for numeric pregnancy prefs
/datum/preference/numeric/pregnancy
	abstract_type = /datum/preference/numeric/pregnancy

/datum/preference/numeric/pregnancy/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_pregnancy))
		return FALSE
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/toggle/master_pregnancy_preferences)

/datum/preference/numeric/pregnancy/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Abstract base for toggle pregnancy prefs
/datum/preference/toggle/pregnancy
	abstract_type = /datum/preference/toggle/pregnancy

/datum/preference/toggle/pregnancy/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_pregnancy))
		return FALSE
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/toggle/master_pregnancy_preferences)

/datum/preference/toggle/pregnancy/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Abstract base for choiced pregnancy prefs
/datum/preference/choiced/pregnancy
	abstract_type = /datum/preference/choiced/pregnancy

/datum/preference/choiced/pregnancy/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_pregnancy))
		return FALSE
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/toggle/master_pregnancy_preferences)

/datum/preference/choiced/pregnancy/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/pregnancy/chance
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_chance"
	minimum = PREGNANCY_CHANCE_MINIMUM
	maximum = PREGNANCY_CHANCE_MAXIMUM

/datum/preference/numeric/pregnancy/chance/create_default_value()
	return PREGNANCY_CHANCE_DEFAULT

/datum/preference/numeric/pregnancy/duration
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_duration"
	minimum = PREGNANCY_DURATION_MINIMUM
	maximum = PREGNANCY_DURATION_MAXIMUM

/datum/preference/numeric/pregnancy/duration/create_default_value()
	return PREGNANCY_DURATION_DEFAULT

/datum/preference/toggle/pregnancy/cryptic
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_cryptic"
	default_value = FALSE

/datum/preference/toggle/pregnancy/belly_inflation
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_belly_inflation"
	default_value = TRUE

/datum/preference/toggle/pregnancy/nausea
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_nausea"
	default_value = FALSE

/datum/preference/toggle/pregnancy/vaginal_insemination
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_insemination_vagina"
	default_value = TRUE

/datum/preference/toggle/pregnancy/anal_insemination
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_insemination_anus"
	default_value = FALSE

/datum/preference/toggle/pregnancy/oral_insemination
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_insemination_mouth"
	default_value = FALSE

/datum/preference/choiced/pregnancy/egg_skin
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "pregnancy_egg_skin"

/datum/preference/choiced/pregnancy/egg_skin/create_default_value()
	return GLOB.pregnancy_egg_skins[GLOB.pregnancy_egg_skins.Find("Chicken") || 1]

/datum/preference/choiced/pregnancy/egg_skin/init_possible_values()
	return assoc_to_keys(GLOB.pregnancy_egg_skins)
