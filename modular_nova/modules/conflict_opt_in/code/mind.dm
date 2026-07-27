/// If a player has any of these enabled, they are forced to use a minimum of ANTAG_OPT_IN_ANTAG_ENABLED_LEVEL antag optin. Dynamic - checked on the fly, not cached.
GLOBAL_LIST_INIT(conflict_optin_forcing_midround_antag_categories, list())

/// If a player has any of these enabled ON SPAWN, they are forced to use a minimum of ANTAG_OPT_IN_ANTAG_ENABLED_LEVEL antag optin for the rest of the round.
GLOBAL_LIST_INIT(conflict_optin_forcing_on_spawn_antag_categories, list())

/datum/mind
	/// The optin level set by preferences.
	var/ideal_conflict_opt_in_level = CONFLICT_OPT_IN_DEFAULT_LEVEL
	/// Set on the FIRST mob login. Set by on-spawn conflicts (e.g. if you have traitor on and spawn, this will be set to CONFLICT_OPT_IN_ANTAG_ENABLED_LEVEL and cannot change)
	var/on_spawn_conflict_opt_in_level = CONFLICT_OPT_OUT
	/// Set to TRUE on a successful transfer_mind() call. If TRUE, transfer_mind() will not refresh opt in.
	var/conflict_opt_in_initialized

// There was a /mob/living/Login() proc here once, it now lives with all its siblings at modular_nova\master_files\code\modules\mob\living\living.dm

/// Refreshes our ideal/on spawn antag opt in level by accessing preferences.
/datum/mind/proc/update_conflict_opt_in(datum/preferences/preference_instance = GLOB.preferences_datums[ckey(key)])
	if (isnull(preference_instance))
		return

	ideal_conflict_opt_in_level = preference_instance.read_preference(/datum/preference/choiced/conflict_opt_in_status)

	if (preference_instance.read_preference(/datum/preference/toggle/be_antag))
		for (var/conflict_category in GLOB.conflict_optin_forcing_on_spawn_antag_categories)
			if (conflict_category in preference_instance.be_special)
				on_spawn_conflict_opt_in_level = CONFLICT_OPT_IN_ANTAG_ENABLED_LEVEL
				break

/// Gets the actual opt-in level used for determining targets.
/datum/mind/proc/get_effective_conflict_opt_in_level()
	var/step_1 = max(ideal_conflict_opt_in_level, get_job_conflict_opt_in_level())
	var/step_2 = max(step_1, get_conflict_opt_in_level())
	var/step_3 = max(step_2, get_effective_antag_opt_in_level())
	return step_3

/// Returns the opt in level of our job.
/datum/mind/proc/get_job_conflict_opt_in_level()
	return assigned_role?.minimum_opt_in_level || CONFLICT_OPT_OUT

/// If we have any conflicts enabled in GLOB.conflict_optin_forcing_midround_admin_categories, returns ANTAG_OPT_IN_ANTAG_ENABLED_LEVEL. ANTAG_OPT_OUT otherwise.
/datum/mind/proc/get_conflict_opt_in_level()
	if (on_spawn_conflict_opt_in_level > CONFLICT_OPT_OUT)
		return on_spawn_conflict_opt_in_level

	var/datum/preferences/preference_instance = GLOB.preferences_datums[ckey(key)]
	if (!isnull(preference_instance) && preference_instance.read_preference(/datum/preference/toggle/be_antag))
		for (var/conflict_category in GLOB.conflict_optin_forcing_on_spawn_antag_categories)
			if (conflict_category in preference_instance.be_special)
				return CONFLICT_OPT_IN_ANTAG_ENABLED_LEVEL
	return CONFLICT_OPT_OUT
