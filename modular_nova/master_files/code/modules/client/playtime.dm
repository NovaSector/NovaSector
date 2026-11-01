// A toggle per character to spawn with a pin indicating you are new to the server
/datum/preference/toggle/green_pin
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "green_pin"
	default_value = FALSE
	can_randomize = FALSE

/datum/preference/toggle/green_pin/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return preferences?.parent?.is_green()

/datum/preference/toggle/green_pin/create_informed_default_value(datum/preferences/preferences)
	var/client/owner = preferences?.parent
	return owner?.has_playtime_data() && owner.is_green()

/datum/preference/toggle/green_pin/apply_to_human(mob/living/carbon/human/wearer, value, datum/preferences/preferences)
	if(!value)
		return

	// apply_prefs_to() runs before the key is moved onto the new mob on both the roundstart and the
	// latejoin path, so wearer.client is usually null here. Ask the preferences datum instead.
	var/datum/preferences/owner_prefs = preferences || wearer.client?.prefs
	var/client/owner = owner_prefs?.parent
	if(isnull(owner))
		return
	if(!owner.has_playtime_data() || owner.is_green())
		return

	owner_prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/green_pin], FALSE)

	if(owner_prefs.savefile)
		owner_prefs.save_preferences()

/client/proc/has_playtime_data()
	return length(prefs?.exp) > 0

/client/proc/is_green()
	return get_exp_living(pure_numeric = TRUE) <= PLAYTIME_GREEN

/// Whether this character should actually be handed a green pin on spawn.
/datum/preferences/proc/should_get_green_pin()
	if(!read_preference(/datum/preference/toggle/green_pin))
		return FALSE

	return !parent?.has_playtime_data() || parent.is_green()

// Mock clients for CI.
/datum/client_interface/proc/has_playtime_data()
	return FALSE

/datum/client_interface/proc/is_green()
	return FALSE
