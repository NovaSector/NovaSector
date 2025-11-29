// -- The loadout item datum and related procs. --

/*
 * Generate a list of singleton loadout_item datums from all subtypes of [type_to_generate]
 *
 * returns a list of singleton datums.
 */
/proc/generate_loadout_items(type_to_generate)
	RETURN_TYPE(/list)

	. = list()
	if(!ispath(type_to_generate))
		CRASH("generate_loadout_items(): called with an invalid or null path as an argument!")

	for(var/datum/loadout_item/found_type as anything in subtypesof(type_to_generate))
		/// Any item without a name is "abstract"
		if(isnull(initial(found_type.name)))
			continue

		if(!ispath(initial(found_type.item_path)))
			stack_trace("generate_loadout_items(): Attempted to instantiate a loadout item ([initial(found_type.name)]) with an invalid or null typepath! (got path: [initial(found_type.item_path)])")
			continue

		var/datum/loadout_item/spawned_type = new found_type()
		// Let's sanitize in case somebody inserted the player's byond name instead of ckey in canonical form
		if(spawned_type.ckeywhitelist)
			for (var/i = 1, i <= length(spawned_type.ckeywhitelist), i++)
				spawned_type.ckeywhitelist[i] = ckey(spawned_type.ckeywhitelist[i])
		GLOB.all_loadout_datums[spawned_type.item_path] = spawned_type
		. |= spawned_type


/datum/loadout_item
	/// If set, it's a list containing ckeys which only can get the item
	var/list/ckeywhitelist
	/// If set, is a list of job names of which can get the loadout item
	var/list/restricted_roles
	/// If set, is a list of job names of which can't get the loadout item
	var/list/blacklisted_roles
	/// If set, is a list of species which can get the loadout item
	var/list/species_whitelist
	/// If set, is a list of species which can't get the loadout item
	var/list/species_blacklist
	/// Whether the item is restricted to supporters
	var/donator_only
	/// Whether the item is restricted to Nova stars.
	var/nova_stars_only
	/// Whether the item requires a specific season in order to be available
	var/required_season = null
	/// Is the loadout item a mechanical item? If so, it will be blocked by 'allow_mechanical_loadout_items' under some circumstances
	var/mechanical_item = FALSE
	/// If the item won't appear when the ERP config is disabled
	var/erp_item = FALSE
	/// If the item goes into the special erp box
	var/erp_box = FALSE

/*
 * Place our [var/item_path] into [outfit].
 *
 * By default, just adds the item into the outfit's backpack contents, if non-visual.
 *
 * equipper - If we're equipping our outfit onto a mob at the time, this is the mob it is equipped on. Can be null.
 * outfit - The outfit we're equipping our items into.
 * visual - If TRUE, then our outfit is only for visual use (for example, a preview).
 * override_items - The type of override to use.
 */
/datum/loadout_item/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(!visuals_only)
		LAZYADD(outfit.backpack_contents, item_path)

/*
 * To be called before insert_path_into_outfit()
 *
 * Checks if an important_for_life item exists and puts the loadout item into the backpack if they would take up the same slot as it.
 *
 * equipper - If we're equipping our outfit onto a mob at the time, this is the mob it is equipped on. Can be null.
 * outfit - The outfit we're equipping our items into.
 * outfit_important_for_life - The outfit whose slots we want to make sure we don't equip an item into.
 * visual - If TRUE, then our outfit is only for visual use (for example, a preview).
 *
 * Returns TRUE if there is an important_for_life item in the slot that the loadout item would normally occupy, FALSE otherwise
 */
/datum/loadout_item/proc/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(!visuals_only)
		LAZYADD(outfit.backpack_contents, item_path)

/*
 * Called after the item is equipped on [equipper], at the end of character setup.
 */
/datum/loadout_item/proc/post_equip_item(datum/preferences/preference_source, mob/living/carbon/human/equipper)
	return FALSE

/**
 * Called before a loadout item is given to a mob, making sure that they're
 * eligible to receive it, based on all of that item's restrictions, if any.
 *
 * Returns `TRUE` if `target` is allowed to receive this item, `FALSE` if not.
 */
/datum/loadout_item/proc/can_be_applied_to(mob/living/target, datum/preferences/preference_source, datum/job/equipping_job, allow_mechanical_loadout_items = TRUE, visuals_only)
	var/client/client = preference_source.parent

	// mechanical restrictions come first
	if(!allow_mechanical_loadout_items && !equipping_job && mechanical_item)
		return message_client(client, target, "this ghost role not allowing it")

	// job restrictions
	if(equipping_job)
		var/title = equipping_job.title

		if(restricted_roles && !(title in restricted_roles))
			if(!visuals_only)
				message_client(client, target, "job restrictions")
			return FALSE

		if(blacklisted_roles && (title in blacklisted_roles))
			if(!visuals_only)
				message_client(client, target, "job blacklist")
			return FALSE

	// species restrictions
	if(iscarbon(target))
		var/mob/living/carbon/carbon_mob = target
		var/datum/dna/dna = carbon_mob.dna
		if(!dna)
			return FALSE

		var/spec = dna.species.id

		if(species_whitelist && !(spec in species_whitelist))
			if(!visuals_only)
				message_client(client, target, "species restrictions")
			return FALSE
		else if(species_blacklist && (spec in species_blacklist))
			if(!visuals_only)
				message_client(client, target, "species restrictions")
			return FALSE

	// donor/star
	if(donator_only && !SSplayer_ranks.is_donator(client))
		if(!visuals_only)
			message_client(client, target, "donator")
		return FALSE

	if(nova_stars_only && !SSplayer_ranks.is_nova_star(client))
		if(!visuals_only)
			message_client(client, target, "Nova star")
		return FALSE

	// ckey restrictions
	if(LAZYLEN(ckeywhitelist) && !(client?.ckey in ckeywhitelist))
		if(!visuals_only)
			message_client(client, target, "CKEY whitelist")
		return FALSE

	return TRUE

/// Tells the client we couldn't equip their item
/datum/loadout_item/proc/message_client(client, target, msg)
	if(client)
		to_chat(target, span_warning("You were unable to get a loadout item ([initial(item_path.name)]) due to [msg]!"))
	return FALSE

/datum/loadout_item/get_ui_buttons()
	var/list/buttons = ..()

	if(loadout_flags & LOADOUT_FLAG_ALLOW_NAMING)
		UNTYPED_LIST_ADD(buttons, list(
			"label" = "Change description",
			"act_key" = "set_description",
			"button_icon" = FA_ICON_PEN,
			"active_key" = INFO_DESCRIBED,
		))

	return buttons

/datum/loadout_item/to_ui_data()
	var/list/formatted_item = ..()
	formatted_item["ckey_whitelist"] = ckeywhitelist
	formatted_item["restricted_roles"] = restricted_roles
	formatted_item["blacklisted_roles"] = blacklisted_roles
	formatted_item["species_whitelist"] = species_whitelist
	formatted_item["donator_only"] = donator_only
	formatted_item["nova_stars_only"] = nova_stars_only

	return formatted_item


/datum/loadout_item/handle_loadout_action(datum/preference_middleware/loadout/manager, mob/user, action, params)
	if(action == "set_description" && (loadout_flags & LOADOUT_FLAG_ALLOW_NAMING))
		return set_description(manager, user)

	return ..()


/// Sets the description of the item.
/datum/loadout_item/proc/set_description(datum/preference_middleware/loadout/manager, mob/user)
	var/list/loadout = manager.get_current_loadout()
	var/input_desc = tgui_input_text(
		user = user,
		message = "What description do you want to give the [name]? Leave blank to clear.",
		title = "[name] description",
		default = loadout?[item_path]?[INFO_DESCRIBED], // plop in existing description (if any)
		max_length = MAX_DESC_LEN,
	)
	if(QDELETED(src) || QDELETED(user) || QDELETED(manager) || QDELETED(manager.preferences))
		return FALSE

	loadout = manager.get_current_loadout() // Make sure no shenanigans happened
	if(!loadout?[item_path])
		return FALSE

	if(input_desc)
		loadout[item_path][INFO_DESCRIBED] = input_desc
	else if(input_desc == "")
		loadout[item_path] -= INFO_DESCRIBED

	manager.save_current_loadout(loadout)
	return TRUE // just so that it updates the UI. Gonna change it later, upstream.
