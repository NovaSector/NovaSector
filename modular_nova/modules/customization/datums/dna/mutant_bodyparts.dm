GLOBAL_LIST_EMPTY(emissive_list_cache)

/**
 * Returns a cached emissive boolean list for mutant bodyparts.
 *
 * This proc takes exactly three boolean-like values (0 or 1) representing
 * whether the primary, secondary, and tertiary color channels are emissive.
 *
 * To reduce memory churn and repeated list allocations, all possible
 * permutations (2³ = 8 total) are cached globally and reused.
 *
 * The returned list should be treated as immutable.
 * Modifying the returned list will affect all users of that permutation.
 *
 * Arguments:
 * - arg1: Whether the primary color channel is emissive (0 or 1)
 * - arg2: Whether the secondary color channel is emissive (0 or 1)
 * - arg3: Whether the tertiary color channel is emissive (0 or 1)
 *
 * Returns:
 * - A list of length 3 containing the emissive flags, shared from cache.
 *
 * Crashes:
 * - If called with anything other than exactly three arguments.
 */
/proc/emissive_tri_bool_list(...)
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
		set_emissive_tri_bool_list(emissive_list[1], emissive_list[2], emissive_list[3])

/**
 * Returns the color list for this mutant bodypart.
 * Falls back to `default_colors` if no explicit colors are set.
 *
 * Returns:
 * - list: The list of colors for this bodypart.
 */
/datum/mutant_bodypart/proc/get_colors()
	return colors || default_colors

/**
 * Sets the color list for this mutant bodypart.
 *
 * Accepts either:
 * - A list of colors
 * - A single color string, which will be replicated to all color slots
 *
 * Arguments:
 * - new_colors: A list of colors or a single color string.
 *
 * Crashes:
 * - If passed an empty list.
 * - If passed a value that is not a list or string.
 */
/datum/mutant_bodypart/proc/set_colors(new_colors)
	if(!length(new_colors))
		CRASH("set_colors passed an empty list!")

	if(istext(new_colors))
		new_colors = list(new_colors, new_colors, new_colors)

	if(!islist(new_colors))
		CRASH("set_colors needs to be passed a list of colors or a color string!")

	colors = new_colors

/**
 * Returns the primary (first) color of this mutant bodypart.
 *
 * Returns:
 * - string: The primary color, or COLOR_WHITE if unset.
 */
/datum/mutant_bodypart/proc/get_primary_color()
	return colors?[1] || COLOR_WHITE

/**
 * Returns the secondary (second) color of this mutant bodypart.
 *
 * Returns:
 * - string: The secondary color, or COLOR_WHITE if unset.
 */
/datum/mutant_bodypart/proc/get_secondary_color()
	return colors?[2] || COLOR_WHITE

/**
 * Returns the tertiary (third) color of this mutant bodypart.
 *
 * Returns:
 * - string: The tertiary color, or COLOR_WHITE if unset.
 */
/datum/mutant_bodypart/proc/get_tertiary_color()
	return colors?[3] || COLOR_WHITE

/**
 * Sets the emissive tri-boolean list for this mutant bodypart.
 *
 * Expects exactly three boolean arguments representing emissive channels.
 *
 * Arguments:
 * - ...: Three booleans indicating emissive state per channel.
 *
 * Crashes:
 * - If not passed exactly three arguments.
 */
/datum/mutant_bodypart/proc/set_emissive_tri_bool_list(...)
	if(length(args) != 3)
		CRASH("set_emissive_list needs to be passed three booleans!")
	emissive_list = emissive_tri_bool_list(args[1], args[2], args[3])

/**
 * Returns the emissive tri-boolean list for this mutant bodypart.
 *
 * Returns:
 * - list: The emissive list for this bodypart.
 */
/datum/mutant_bodypart/proc/get_emissive_tri_bool_list()
	return emissive_list

/**
 * Factory helper proc for creating and returning a new mutant_bodypart datum.
 *
 * Arguments:
 * - name: The sprite accessory name for the mutant bodypart.
 * - colors: Optional list of colors or color string for the bodypart.
 * - emissive_list: Optional emissive tri-boolean list for the bodypart.
 *
 * Returns:
 * - /datum/mutant_bodypart: A newly created mutant bodypart datum.
 */
/datum/species/proc/build_mutant_part(name, colors, emissive_list)
	return new /datum/mutant_bodypart(name, colors, emissive_list)

// Immutable species blueprint, used for default species parts. These are what get stored in GLOB.default_mutant_parts
/datum/mutant_bodypart/species_blueprint
	/// Whether or not this can be randomized
	VAR_FINAL/is_randomizable
	/// If TRUE, this is marked as a feature (aka dna.features) and should not be added to dna.mutant_bodyparts.
	VAR_FINAL/is_feature

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

/datum/mutant_bodypart/species_blueprint/set_emissive_tri_bool_list(...)
	return
