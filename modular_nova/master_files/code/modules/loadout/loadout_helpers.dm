///Fetches the current loadout list from prefs and formats it via loadout_list_to_datums().
/client/proc/get_loadout_datums()
	RETURN_TYPE(/list)

	if(isnull(prefs))
		return list()
	var/list/loadout_entries = prefs.read_preference(/datum/preference/loadout)
	var/list/loadout_list = loadout_entries[prefs.read_preference(/datum/preference/loadout_index)]
	return loadout_list_to_datums(loadout_list)
