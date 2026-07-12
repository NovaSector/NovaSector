/// Allows people to decide if they want to be anonymous in dep-oocs or not.
/datum/preference/toggle/department_ooc_anon
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE
	savefile_key = "department_ooc_anon"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/department_ooc_anon/create_default_value()
	return TRUE
