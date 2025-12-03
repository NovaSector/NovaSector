/**
 * Modularly returns one of worn_icon_vox, worn_icon_teshari, etc.
 * Arguments:
 * * item_slot: The slot we're updating. One of LOADOUT_ITEM_HEAD, etc.
 * * item is the item we're checking.
 */
/datum/species/proc/get_custom_worn_icon(item_slot, obj/item/item)
	return null

/**
 * Modularly set one of worn_icon_vox, worn_icon_teshari, etc.
 * Arguments:
 * * item_slot: The slot we're updating. One of LOADOUT_ITEM_HEAD, etc.
 * * item is the item we're updating.
 * * icon is the icon we're setting to the var.
 */
/datum/species/proc/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	return

/**
 * Modularly get the species' fallback greyscale config.
 * Only used if you use generate_custom_worn_icon_fallback()
 * Arguments:
 * * item_slot: The slot we're updating. One of LOADOUT_ITEM_HEAD, etc.
 * * item: The item being rendered.
 */
/datum/species/proc/get_custom_worn_config_fallback(item_slot, obj/item/item)
	CRASH("`get_custom_worn_config_fallback()` was not implemented for [type]!")

/datum/species/proc/use_custom_worn_icon_cached()
	LAZYINITLIST(GLOB.species_clothing_fallback_cache[name])

/**
 * Read from freely usable cache of generated icons for your species.
 * Arguments:
 * * file_to_use: icon you're substituting
 * * state_to_use: icon state you're substituting
 * * meta: string containing other info.
 */
/datum/species/proc/get_custom_worn_icon_cached(file_to_use, state_to_use, meta)
	return GLOB.species_clothing_fallback_cache[name]["[file_to_use]-[state_to_use]-[meta]"]

/**
 * Write to a freely usable cache of generated icons for your species.
 * Arguments:
 * * file_to_use: icon you're substituting
 * * state_to_use: icon state you're substituting
 * * meta: string containing other info.
 * * cached_value: Cached value
 */
/datum/species/proc/set_custom_worn_icon_cached(file_to_use, state_to_use, meta, cached_value)
	GLOB.species_clothing_fallback_cache[name]["[file_to_use]-[state_to_use]-[meta]"] = cached_value

/**
 * Allow for custom clothing icon generation. Only called if the species is BODYSHAPE_CUSTOM
 * If null is returned, use default human icon.
 * Arguments:
 * * item_slot: The slot we're updating. One of LOADOUT_ITEM_HEAD, etc.
 * * item: The item being rendered.
 * * human_owner: The human wearing the item.
 */
/datum/species/proc/generate_custom_worn_icon(item_slot, obj/item/item, mob/living/carbon/human/human_owner)
	var/static/list/states_cache = list() // cache these so we are not calling the expensive icon_states proc.
	// If already set (possibly by us, or manually, use it.)
	var/icon/final_icon = get_custom_worn_icon(item_slot, item)
	if(final_icon && icon_exists(final_icon, item.worn_icon_state || item.icon_state)) // TODO: UNIT TEST teshari_worn_icon beforehand
		return final_icon

	// Else check if in custom icon.
	if(!(item_slot in custom_worn_icons))
		return null

	var/icon/species_worn_icon = custom_worn_icons[item_slot]
	var/static/list/state_cache = list()
	var/list/states = state_cache[species_worn_icon]
	if(!states)
		states = icon_states(species_worn_icon)
		state_cache[species_worn_icon] = states

	var/state = item.worn_icon_state || item.icon_state
	if(!(state in states))
		return null

	// Remember and use icon.
	set_custom_worn_icon(item_slot, item, species_worn_icon)
	return species_worn_icon

/**
 * Generate a fallback worn icon, if the species supports it. You must call it in an override of generate_custom_worn_icon()
 */
/datum/species/proc/generate_custom_worn_icon_fallback(item_slot, obj/item/item, mob/living/carbon/human/human_owner)
	var/icon/human_icon = item.worn_icon || item.icon
	var/human_icon_state = item.worn_icon_state || item.icon_state

	// Key for greyscale string (color "x" means non-gags/unknown)
	var/greyscale_key = item.greyscale_colors || "x"

	// First, let's just check if we've already made this.
	use_custom_worn_icon_cached()
	var/icon/cached_icon = get_custom_worn_icon_cached(human_icon, human_icon_state, greyscale_key)
	if(cached_icon)
		return cached_icon

	// Get GAGs config
	var/fallback_config = get_custom_worn_config_fallback(item_slot, item)
	if(!fallback_config)
		return null

	// The GAGs config needs this many colors.
	var/expected_num_colors = SSgreyscale.configurations["[fallback_config]"].expected_colors
	// The colors string.
	var/fallback_greyscale_colors

	// If this outfit is already GAGs, use the existing colors.
	// Case 1: item already has greyscale
	if(item.greyscale_colors)
		var/list/colors = SSgreyscale.ParseColorString(item.greyscale_colors)
		var/default_color = length(colors) ? colors[1] : COLOR_DARK

		var/list/final_colors = new /list(expected_num_colors)

		var/colors_len = length(colors)
		for(var/i in 1 to expected_num_colors)
			if(i <= colors_len)
				final_colors[i] = colors[i]
			else
				final_colors[i] = default_color

		fallback_greyscale_colors = final_colors.Join("")

	else
		// Case 2: // we have to actually guess the colors via pixel sampling
		var/icon/temp_icon = icon(human_icon, human_icon_state)
		var/list/color_list = new /list(expected_num_colors)

		var/list/coords = item.species_clothing_color_coords

		// extract pixels without additional bounds checks
		for(var/i in 1 to expected_num_colors)
			if(i > length(coords))
				color_list[i] = COLOR_DARK
				continue

			var/coord = coords[i]
			var/pixel = temp_icon.GetPixel(coord[1], coord[2])
			color_list[i] = pixel || COLOR_DARK

		fallback_greyscale_colors = color_list.Join("")

	// Finally, render with GAGs
	var/icon/final_icon = icon(SSgreyscale.GetColoredIconByType(get_custom_worn_config_fallback(item_slot, item), fallback_greyscale_colors))
	final_icon.Insert(final_icon, icon_state = human_icon_state) // include the expected icon_state
	final_icon = fcopy_rsc(final_icon)
	// Duplicate to the specific icon_state and set.
	// Cache the clean copy.
	set_custom_worn_icon_cached(human_icon, human_icon_state, greyscale_key, final_icon)

	return final_icon

/// Change return value to override default MOD module overlay icon file
/datum/species/proc/get_custom_mod_module_icon()
	return

