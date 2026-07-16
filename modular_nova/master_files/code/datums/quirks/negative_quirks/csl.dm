/datum/quirk/csl/is_valid(datum/preferences/preferences)
	if(length(preferences.languages) < 2) // NOVA EDIT ADDITION
		return FALSE
	return ..()
