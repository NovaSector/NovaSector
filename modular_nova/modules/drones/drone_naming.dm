/datum/preference/name/drone
	savefile_key = "drone_name"

	allow_numbers = TRUE
	explanation = "Drone Name"
	group = "silicons"
	relevant_job = /datum/job/maintenance_drone

/datum/preference/name/drone/create_default_value()
	return ("[pick(GLOB.posibrain_names)]-[rand(100, 999)]")

/datum/preference_middleware/names/get_constant_data()
	var/list/data = ..()
	var/list/types = data["types"]

	for (var/preference_type in GLOB.preference_entries)
		var/datum/preference/name/name_pref = GLOB.preference_entries[preference_type]
		if (!istype(name_pref))
			continue
		var/list/extras = name_pref.get_extra_constant_data()
		if (length(extras))
			types[name_pref.savefile_key] |= extras

	return data

/// Used to add the allowed drone prefixes ("strings/names/posibrain.txt") to the data sent by the middleware to TGUI.
/datum/preference/name/proc/get_extra_constant_data()
	if (savefile_key == "drone_name")
		return list("prefixes" = GLOB.posibrain_names)
	return

/obj/effect/mob_spawn/ghost_role/drone/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()

	var/datum/mind/spawned_mind = spawned_mob?.mind
	var/client/mind_client = spawned_mob?.client
	var/saved_name = mind_client.prefs.read_preference(/datum/preference/name/drone)
	if(saved_name)
		spawned_mob.real_name = saved_name
		spawned_mob.name = saved_name
		spawned_mind.name = saved_name

	return .
