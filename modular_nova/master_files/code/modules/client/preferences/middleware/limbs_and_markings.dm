#define DEFAULT_NAME "None"

/datum/preference_middleware/limbs_and_markings
	action_delegations = list(
		"set_bodypart_aug" = PROC_REF(set_bodypart_aug),
		"set_bodypart_aug_style" = PROC_REF(set_bodypart_aug_style),
		"add_marking"  = PROC_REF(add_marking),
		"change_marking" = PROC_REF(change_marking),
		"color_marking" = PROC_REF(color_marking),
		"remove_marking" = PROC_REF(remove_marking),
		"set_internal_implant_aug" = PROC_REF(set_internal_implant_aug),
		"set_preset" = PROC_REF(set_preset),
		"change_emissive" = PROC_REF(change_emissive_marking),
	)

/datum/preference_middleware/limbs_and_markings/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	target.dna.body_markings = LAZYCOPY(preferences.body_markings)

	var/list/visited_body_zones = list()
	for(var/key, augment_path in preferences.augments)
		var/visited_body_zone
		if(is_aug_valid_for_prefs(GLOB.augment_items[augment_path], target, preferences))
			var/datum/augment_item/aug = new augment_path()
			visited_body_zone = aug.apply(target, visuals_only, prefs = preferences)
			qdel(aug)
		if(visited_body_zone)
			visited_body_zones += visited_body_zone

	target.synchronize_bodytypes()
	target.synchronize_bodyshapes()

	if(!visuals_only)
		return

	var/should_greyscale_limbs
	if(!preferences.read_preference(/datum/preference/toggle/skin_tone_toggle))
		var/datum/preference/toggle/skin_tone_toggle/skin_tone_toggle = GLOB.preference_entries[/datum/preference/toggle/skin_tone_toggle]
		if(skin_tone_toggle.is_accessible(preferences))
			should_greyscale_limbs = TRUE

	for(var/body_zone in GLOB.all_body_zones)
		if(body_zone in visited_body_zones)
			continue
		var/obj/item/bodypart/target_bodypart = target.get_bodypart(body_zone, include_stumps = TRUE)
		if(should_greyscale_limbs)
			target_bodypart?.change_appearance(icon = BODYPART_ICON_HUMANOID, id = SPECIES_HUMANOID, greyscale = TRUE)
		else
			target_bodypart?.reset_appearance()

/// Builds the unified augment_items list in render order and returns it
/datum/preference_middleware/limbs_and_markings/proc/build_augment_choices()
	// First pass — catalogue augments by category and slot
	var/list/limb_catalogue         = list()
	var/list/internal_implant_slots = list()
	var/list/limb_implant_catalogue = list()

	for(var/augment_path, augment_instance in GLOB.augment_items)
		var/datum/augment_item/augment = augment_instance
		if(!augment.path)
			continue

		var/slot = augment.slot
		var/list/entry = list(
			"path"               = augment.type,
			"name"               = augment.name,
			"cost"               = augment.cost,
			"extra_info"         = augment.extra_info,
			"has_digi"           = augment.supports_digitigrade,
			"allows_styles"      = augment.uses_robotic_styles,
			"allows_implants"    = augment.allows_implants,
			"species_blacklist"  = LAZYLISTDUPLICATE(augment.species_blacklist),
			"species_whitelist"  = LAZYLISTDUPLICATE(augment.species_whitelist),
			"ckey_whitelist"     = LAZYLISTDUPLICATE(augment.ckey_whitelist),
		)
		switch(augment.category)
			if(AUGMENT_CATEGORY_LIMBS)
				if(!limb_catalogue[slot])
					limb_catalogue[slot] = list()
				limb_catalogue[slot] += list(entry)
			if(AUGMENT_CATEGORY_INTERNAL_IMPLANTS)
				if(!internal_implant_slots[slot])
					internal_implant_slots[slot] = list(
						"icon"    = initial(augment.icon),
						"options" = list(),
					)
				internal_implant_slots[slot]["options"] += list(entry)
			if(AUGMENT_CATEGORY_IMPLANTS)
				if(!limb_implant_catalogue[slot])
					limb_implant_catalogue[slot] = list()
				limb_implant_catalogue[slot] += list(entry)

	return build_unified_augments_list(limb_catalogue, internal_implant_slots, limb_implant_catalogue)

/// Takes the catalogued augment data and outputs a unified augment_items list in render order, so tsx has to do as little as possible
/datum/preference_middleware/limbs_and_markings/proc/build_unified_augments_list(list/limb_catalogue, list/internal_implant_slots, list/limb_implant_catalogue)
	var/list/augment_slots_with_items = list()

	// The augments that appear in the Bodyparts tab - in the order they should be rendered. keyed to their corresponding augment types.
	var/list/bodypart_augment_categories = list(
		AUGMENT_SLOT_L_ARM = /datum/augment_item/limb/l_arm,
		AUGMENT_SLOT_L_HAND = /datum/augment_item/limb/l_hand,
		AUGMENT_SLOT_L_LEG = /datum/augment_item/limb/l_leg,
		AUGMENT_SLOT_R_ARM = /datum/augment_item/limb/r_arm,
		AUGMENT_SLOT_R_HAND = /datum/augment_item/limb/r_hand,
		AUGMENT_SLOT_R_LEG = /datum/augment_item/limb/r_leg,
		AUGMENT_SLOT_HEAD = /datum/augment_item/limb/head,
		AUGMENT_SLOT_CHEST = /datum/augment_item/limb/chest,
	)

	// The augments that appear in the Internal Implants tab - in the order they should be remdered
	var/list/internal_augments_categories = list(
		AUGMENT_SLOT_BRAIN,
		AUGMENT_SLOT_HEART,
		AUGMENT_SLOT_LUNGS,
		AUGMENT_SLOT_LIVER,
		AUGMENT_SLOT_STOMACH,
		AUGMENT_SLOT_EARS,
		AUGMENT_SLOT_EYES,
		AUGMENT_SLOT_TONGUE,
		AUGMENT_SLOT_MOUTH_IMPLANT,
	)

	// Bodypart augment slots
	for(var/augment_slot, base_aug_type_path in bodypart_augment_categories)
		var/datum/augment_item/limb/limb_aug_path = base_aug_type_path
		var/list/aug_options = null
		var/list/implant_options = null
		// Build the limb options for this bodypart augment slot
		if(limb_catalogue[augment_slot])
			var/list/options = list(list(
				"path"       = null,
				"name"       = DEFAULT_NAME,
				"cost"       = 0,
				"extra_info" = "",
				"has_digi"   = TRUE,
			))
			options += limb_catalogue[augment_slot]
			aug_options = options
			// Build the limb implant options for this bodypart augment slot
			if(limb_implant_catalogue[augment_slot])
				implant_options = list(list(
					"path"       = null,
					"name"       = DEFAULT_NAME,
					"cost"       = 0,
					"extra_info" = "",
				))
				implant_options += limb_implant_catalogue[augment_slot]
		// Now build the category entry for this bodypart augment slot
		augment_slots_with_items += list(list(
			"slot"            = limb_aug_path::slot,
			"body_zone"       = limb_aug_path::body_zone,
			"slot_flag"       = limb_aug_path::slot_flag,
			"is_bodypart"     = TRUE,
			"aug_options"     = aug_options,
			"has_implant"     = !isnull(implant_options),
			"implant_options" = implant_options,
		))

	// Internal implant slots
	for(var/slot in internal_augments_categories)
		// Build the implant options for this internal implants slot
		var/list/internal_implants = internal_implant_slots[slot]
		var/list/options = list(list(
			"path"       = null,
			"name"       = DEFAULT_NAME,
			"cost"       = 0,
			"extra_info" = "",
		))
		if(internal_implants)
			options += internal_implants["options"]
		// Now build the category entry for this internal implants slot
		augment_slots_with_items += list(list(
			"slot"        = slot,
			"is_bodypart" = FALSE,
			"icon"        = internal_implants?["icon"],
			"aug_options" = options,
		))

	return augment_slots_with_items

/// Builds unfiltered marking choices per slot — TSX filters by species/mismatched parts
/datum/preference_middleware/limbs_and_markings/proc/build_marking_choices()
	var/list/marking_choices = list()
	for(var/slot in GLOB.body_markings_per_limb)
		var/list/slot_choices = list()
		for(var/marking_name in GLOB.body_markings_per_limb[slot])
			var/datum/body_marking/marking = GLOB.body_markings[marking_name]
			slot_choices += list(list(
				"name"                = marking_name,
				"recommended_species" = marking.recommended_species ? jointext(marking.recommended_species, ",") : null,
			))
		marking_choices[slot] = slot_choices
	return marking_choices

/// Builds unfiltered marking presets — TSX filters by species/mismatched parts
/datum/preference_middleware/limbs_and_markings/proc/build_marking_presets()
	var/list/presets = list()
	for(var/preset_name in GLOB.body_marking_sets)
		var/datum/body_marking_set/marking_set = GLOB.body_marking_sets[preset_name]
		presets += list(list(
			"name"                = preset_name,
			"recommended_species" = marking_set.recommended_species ? jointext(marking_set.recommended_species, ",") : null,
		))
	return presets

// data that never changes - the marking choices, should be cached and only built once per round
/datum/preference_middleware/limbs_and_markings/get_constant_data()
	var/list/data = list()

	var/list/robotic_styles = list(list(
			"name"            = DEFAULT_NAME,
			"icon"            = 'icons/mob/augmentation/augments.dmi',
			"supported_slots" = ALL,
			"has_digi"        = TRUE,
		))
	for(var/style_name, style_instance in GLOB.robotic_styles_list)
		var/datum/robotic_style/style = style_instance
		if(!style.supported_slots) // 0 = not for augments (e.g. dimorphic)
			continue
		robotic_styles += list(list(
			"name"            = style_name,
			"supported_slots" = style.supported_slots,
			"has_digi"        = style.has_digi,
		))
	data["robotic_styles"] = robotic_styles

	data["augment_items"]    = build_augment_choices()
	data["marking_choices"]  = build_marking_choices()
	data["marking_presets"]  = build_marking_presets()

	return data

// data that can change goes here, these need to be resent every time there is an update
/datum/preference_middleware/limbs_and_markings/get_ui_data(mob/user)
	var/list/data = list()

	var/datum/preference/choiced/mutant_choice/taur/taur_choice = GLOB.preference_entries[/datum/preference/choiced/mutant_choice/taur]
	data["taur_legs"] = (taur_choice.is_accessible(preferences) && preferences.read_preference(/datum/preference/choiced/mutant_choice/taur) != SPRITE_ACCESSORY_NONE)
	data["digi_legs"] = preferences.read_preference(/datum/preference/choiced/digitigrade_legs) == DIGITIGRADE_LEGS
	data["allow_mismatched_parts"] = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)

	data["markings"]        = fix_colors_on_markings_to_tgui()
	data["augments"]        = preferences.augments.Copy()
	data["augment_styles"]  = preferences.augment_limb_styles.Copy()

	// Quirk points
	data["quirk_points_enabled"] = SSquirks.points_enabled

	return data

/// Performs DM-side validation for anything we are reading from prefs
/datum/preference_middleware/limbs_and_markings/proc/is_aug_valid_for_prefs(datum/augment_item/aug, mob/user, datum/preferences/prefs)
	var/species_type = prefs.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = GLOB.species_prototypes[species_type]
	if(aug.species_blacklist && aug.species_blacklist[species.id])
		return FALSE
	if(aug.species_whitelist && !aug.species_whitelist[species.id])
		return FALSE
	var/digi_legs = prefs.read_preference(/datum/preference/choiced/digitigrade_legs) == DIGITIGRADE_LEGS
	if(digi_legs && aug.slot_flag && (aug.slot_flag & (LEG_LEFT|LEG_RIGHT)) && !aug.supports_digitigrade)
		return FALSE
	if(aug.ckey_whitelist && !LAZYFIND(aug.ckey_whitelist, user?.client?.ckey))
		return FALSE
	var/datum/preference/choiced/mutant_choice/taur/taur_choice = GLOB.preference_entries[/datum/preference/choiced/mutant_choice/taur]
	if(taur_choice.is_accessible(prefs) && prefs.read_preference(/datum/preference/choiced/mutant_choice/taur) != SPRITE_ACCESSORY_NONE)
		if(aug.slot_flag && (aug.slot_flag & (LEG_LEFT|LEG_RIGHT)))
			return FALSE
	if(SSquirks.points_enabled && aug.cost > 0)
		if((preferences.GetQuirkBalance() - aug.cost) < 0)
			return FALSE
	return TRUE

// Action procs
/datum/preference_middleware/limbs_and_markings/proc/set_bodypart_aug(list/params, mob/user)
	var/augment_path = text2path(params["augment_path"])
	var/augment_slot = params["slot"]
	if(!augment_path)
		preferences.augments -= augment_slot
	else
		var/datum/augment_item/aug = GLOB.augment_items[augment_path] // This augment path does not exist
		if(!aug)
			return
		if(!is_aug_valid_for_prefs(GLOB.augment_items[augment_path], user, preferences))
			return
		preferences.augments[augment_slot] = augment_path
	filter_quirks_and_refresh(user)
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/set_bodypart_aug_style(list/params, mob/user)
	var/augment_slot = params["slot"]
	var/style_name = params["style_name"]
	if(!style_name || style_name == DEFAULT_NAME)
		preferences.augment_limb_styles -= augment_slot
	else
		var/datum/robotic_style/style = GLOB.robotic_styles_list[style_name]
		if(isnull(style))
			return
		preferences.augment_limb_styles[augment_slot] = style_name
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/set_internal_implant_aug(list/params, mob/user)
	var/slot = params["internal_implant_slot"]
	var/augment_path = text2path(params["augment_path"])
	if(!augment_path)
		preferences.augments -= slot
	else
		var/datum/augment_item/aug = GLOB.augment_items[augment_path]
		if(isnull(aug))
			return
		if(!is_aug_valid_for_prefs(GLOB.augment_items[augment_path], user, preferences))
			return
		preferences.augments[slot] = augment_path
	filter_quirks_and_refresh(user)
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/filter_quirks_and_refresh(mob/user)
	var/list/filtered = SSquirks.filter_invalid_quirks(preferences.all_quirks, preferences.augments)
	if(filtered != preferences.all_quirks)
		preferences.all_quirks = filtered
		preferences.update_static_data(user)

// Marking actions
/datum/preference_middleware/limbs_and_markings/proc/fix_colors_on_markings_to_tgui()
	var/list/all_markings = preferences.body_markings
	if(!length(all_markings))
		return
	var/list/result = list()
	for(var/slot in all_markings)
		var/list/slot_markings = all_markings[slot]
		if(!length(slot_markings))
			continue
		var/list/fixed = list()
		var/marking_count = 0
		for(var/marking in slot_markings)
			marking_count++
			fixed += list(list(
				"name"       = marking,
				"color"      = sanitize_hexcolor(slot_markings[marking][1]),
				"marking_id" = "[slot]_[marking_count]",
				"emissive"   = slot_markings[marking][2],
			))
		result[slot] = fixed
	return result

/datum/preference_middleware/limbs_and_markings/proc/add_marking(list/params, mob/user)
	var/bodypart_slot = params["bodypart_slot"]
	if(!preferences.body_markings[bodypart_slot])
		preferences.body_markings[bodypart_slot] = list()
	if(length(preferences.body_markings[bodypart_slot]) >= MAXIMUM_MARKINGS_PER_LIMB)
		return
	var/marking_name = pick(GLOB.body_markings_per_limb[bodypart_slot])
	var/datum/body_marking/marking = GLOB.body_markings[marking_name]
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/list/mutant_colors = preferences.read_preference(/datum/preference/tri_color/mutant_colors)
	var/list/features = list(
		FEATURE_MUTANT_COLOR       = mutant_colors[1],
		FEATURE_MUTANT_COLOR_TWO   = mutant_colors[2],
		FEATURE_MUTANT_COLOR_THREE = mutant_colors[3],
		FEATURE_SKIN_COLOR         = skintone2hex(preferences.read_preference(/datum/preference/choiced/skin_tone)),
	)
	var/datum/species/current_species = GLOB.species_prototypes[species_type]
	preferences.body_markings[bodypart_slot] += list("[marking_name]" = list(marking.get_default_color(features, current_species), FALSE))
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/change_marking(list/params, mob/user)
	var/bodypart_slot = params["bodypart_slot"]
	var/marking_id = params["marking_id"]
	var/marking_name = params["marking_name"]
	var/list/markings = preferences.body_markings[bodypart_slot]
	var/list/new_markings = list()
	var/marking_count = 0
	for(var/entry, marking_data in markings)
		marking_count++
		if(marking_id == "[bodypart_slot]_[marking_count]")
			new_markings[marking_name] = marking_data
		else
			new_markings[entry] = markings[entry]
	preferences.body_markings[bodypart_slot] = new_markings
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/color_marking(list/params, mob/user)
	var/bodypart_slot = params["bodypart_slot"]
	var/marking_id = params["marking_id"]
	var/list/markings = preferences.body_markings[bodypart_slot]
	var/list/new_markings = list()
	var/marking_count = 0
	var/target_entry
	for(var/entry, marking_data in markings)
		marking_count++
		if(marking_id == "[bodypart_slot]_[marking_count]")
			target_entry = entry
		new_markings[entry] = marking_data
	var/new_color = tgui_color_picker(usr, "Select new color", null, preferences.body_markings[bodypart_slot][target_entry][1])
	if(!new_color)
		return TRUE
	new_markings[target_entry][1] = new_color
	preferences.body_markings[bodypart_slot] = new_markings
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/change_emissive_marking(list/params, mob/user)
	var/bodypart_slot = params["bodypart_slot"]
	var/marking_id = params["marking_id"]
	var/emissive = !params["emissive"]
	var/list/markings = preferences.body_markings[bodypart_slot]
	var/list/new_markings = list()
	var/marking_count = 0
	var/target_entry
	for(var/entry, marking_data in markings)
		marking_count++
		if(marking_id == "[bodypart_slot]_[marking_count]")
			target_entry = entry
		new_markings[entry] = marking_data
	new_markings[target_entry][2] = sanitize_integer(emissive)
	preferences.body_markings[bodypart_slot] = new_markings
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/remove_marking(list/params, mob/user)
	var/bodypart_slot = params["bodypart_slot"]
	var/marking_id = params["marking_id"]
	var/list/markings = preferences.body_markings[bodypart_slot]
	var/list/new_markings = list()
	var/marking_count = 0
	for(var/entry, marking_data in markings)
		marking_count++
		if(marking_id == "[bodypart_slot]_[marking_count]")
			continue
		new_markings[entry] = marking_data
	preferences.body_markings[bodypart_slot] = new_markings
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/limbs_and_markings/proc/set_preset(list/params, mob/user)
	var/preset = params["preset"]
	if(preset)
		var/datum/body_marking_set/BMS = GLOB.body_marking_sets[preset]
		var/species_type = preferences.read_preference(/datum/preference/choiced/species)
		var/list/mutant_colors = preferences.read_preference(/datum/preference/tri_color/mutant_colors)
		var/list/features = list(
			FEATURE_MUTANT_COLOR       = mutant_colors[1],
			FEATURE_MUTANT_COLOR_TWO   = mutant_colors[2],
			FEATURE_MUTANT_COLOR_THREE = mutant_colors[3],
			FEATURE_SKIN_COLOR         = skintone2hex(preferences.read_preference(/datum/preference/choiced/skin_tone)),
		)
		var/datum/species/current_species = GLOB.species_prototypes[species_type]
		preferences.body_markings = assemble_body_markings_from_set(BMS, features, current_species)
	preferences.character_preview_view.update_body()
	return TRUE

#undef DEFAULT_NAME
