/**
 * Called from subsystem's PreInit and builds sprite_accessories list with (almost) all existing sprite accessories
 */
/datum/controller/subsystem/accessories/proc/make_sprite_accessory_references()
	for (var/datum/sprite_accessory/sprite_accessory_path as anything in subtypesof(/datum/sprite_accessory))
		var/key = initial(sprite_accessory_path.key)
		if (isnull(key))
			continue // skip abstract or incomplete defs

		var/name = initial(sprite_accessory_path.name)
		if(isnull(name))
			continue

		// Try to reuse existing instance if already built in feature_list
		var/datum/sprite_accessory/instance
		var/list/key_list = feature_list[key]

		if (key_list)
			instance = key_list[name]

		// Create new only if not cached
		if (isnull(instance))
			instance = new sprite_accessory_path()

		// Ensure sprite_accessories[key] list exists
		var/list/accessory_group = sprite_accessories[key]
		if (isnull(accessory_group))
			accessory_group = sprite_accessories[key] = list()

		// Store reference
		accessory_group[name] = instance

	cached_mutant_icon_files = null // We don't really need to keep this list in memory once we're done creating our singletons

/// Generates cached list of mutant_icon_files if it doesn't exist yet - Should never be called more than once.
/datum/controller/subsystem/accessories/proc/build_cached_icon_states(icon_file)
	var/list/cached = list()
	for(var/state in icon_states(new /icon(icon_file)))
		cached[state] = TRUE
	cached_mutant_icon_files[icon_file] = cached
	return cached
