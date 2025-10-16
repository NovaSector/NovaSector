/// Allows proteans to lock their modsuit on you when you wear it (prevents removal until unlocked or forcefully removed)
/datum/preference/toggle/allow_protean_lock
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "allow_protean_lock"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = FALSE // Disabled by default - opt-in only

/datum/preference/toggle/allow_protean_lock/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return TRUE

/datum/preference/toggle/allow_protean_lock/create_default_value()
	return FALSE

