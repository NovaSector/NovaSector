/// For use with the Admin Notify verb
/datum/preference/toggle/admin_notify_alert
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "admin_notify_alert"
	default_value = TRUE

/datum/preference/toggle/admin_notify_alert/create_default_value()
	return TRUE

// Only shows for admeme
/datum/preference/toggle/admin_notify_alert/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE
	return !!preferences.parent?.holder
