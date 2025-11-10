/**
 * Called from subsystem's PreInit and builds sprite_accessories list with (almost) all existing sprite accessories
 */
/datum/controller/subsystem/accessories/proc/make_sprite_accessory_references()
	for (var/datum/sprite_accessory/sprite_accessory_path as anything in subtypesof(/datum/sprite_accessory))
		var/key = initial(sprite_accessory_path.key)
		var/name = initial(sprite_accessory_path.name)
		if (!key || !name)
			continue // skip abstract or incomplete defs

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
