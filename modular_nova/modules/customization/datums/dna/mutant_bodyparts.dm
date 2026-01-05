GLOBAL_LIST_EMPTY(emissive_list_cache)

/// Cached emissive lists (8 possible permutations of 0's and 1's)
/proc/emissive_list(...)
	if(length(args) != 3)
		CRASH("Emissive_list should take 3 args of 1's and 0's.")

	// Build a canonical string key
	// "1,0,1" etc
	var/key = jointext(args, ",")

	var/list/cached = GLOB.emissive_list_cache[key]
	if(cached)
		return cached

	// Create once
	var/list/emissive_list = args.Copy()

	GLOB.emissive_list_cache[key] = emissive_list
	return emissive_list

/datum/mutant_bodypart_def
	var/name
	var/enabled
	var/list/default_colors

/datum/mutant_bodypart
	/// The name of the corresponding sprite_accessory
	var/name = SPRITE_ACCESSORY_NONE
	/// The triplet of color strings for each color index.
	VAR_PROTECTED/list/colors
	/// The triplet of booleans for which color indices are emissive.
	VAR_PROTECTED/list/emissive_list
	/// The default list of colors
	var/static/list/default_colors = list(COLOR_WHITE, COLOR_WHITE, COLOR_WHITE)

/datum/mutant_bodypart/New(name, list/colors, list/emissive_list)
	. = ..()
	if(name)
		if(!istext(name))
			stack_trace("Tried to set name to a non-string value!")
		else
			src.name = name
	if(colors)
		set_colors(colors)
	if(emissive_list && length(emissive_list == 3))
		set_emissive_list(emissive_list[1], emissive_list[2], emissive_list[3])

/datum/mutant_bodypart/proc/get_colors()
	return colors || default_colors

/datum/mutant_bodypart/proc/set_colors(new_colors)
	if(!length(new_colors))
		CRASH("set_colors passed an empty list!")

	if(istext(new_colors))
		new_colors = list(new_colors, new_colors, new_colors)

	if(!islist(new_colors))
		CRASH("set_colors needs to be passed a list of colors or a color string!")

	colors = new_colors

/datum/mutant_bodypart/proc/get_primary_color()
	return colors?[1] || COLOR_WHITE

/datum/mutant_bodypart/proc/get_secondary_color()
	return colors?[2] || COLOR_WHITE

/datum/mutant_bodypart/proc/get_tertiary_color()
	return colors?[3] || COLOR_WHITE

/datum/mutant_bodypart/proc/set_emissive_list(...)
	if(!islist(args) || length(args) != 3)
		CRASH("set_emissive_list needs to be passed three booleans!")
	emissive_list = emissive_list(args[1], args[2], args[3])

/datum/mutant_bodypart/proc/get_emissive_list()
	return emissive_list

// Immutable species blueprint, used for default species parts
/datum/mutant_bodypart/species_blueprint
	/// Whether or not this can be randomized
	VAR_PROTECTED/is_randomizable = FALSE
	/// If TRUE, this is marked as a feature (aka dna.features) and should not be added to dna.mutant_bodyparts.
	VAR_PROTECTED/is_feature = FALSE

/datum/mutant_bodypart/species_blueprint/New(name, list/colors, list/emissive_list, is_randomizable, is_feature)
	. = ..()
	src.is_randomizable = is_randomizable
	src.is_feature = is_feature

/datum/mutant_bodypart/get_colors()
	return colors // Should be explicit here and either return a color list or null (no defaults)

/datum/mutant_bodypart/species_blueprint/set_colors(list/new_colors)
	return // Don't let these get changed ever

/datum/mutant_bodypart/get_primary_color()
	return colors?[1]

/datum/mutant_bodypart/get_secondary_color()
	return colors?[2]

/datum/mutant_bodypart/get_tertiary_color()
	return colors?[3]

/datum/mutant_bodypart/species_blueprint/set_emissive_list(...)
	return

/// Factory helper proc for creating and returning a new mutant_bodypart datum
/datum/species/proc/build_mutant_part(name, colors, emissive_list)
	return new /datum/mutant_bodypart(name, colors, emissive_list)
