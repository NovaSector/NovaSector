GLOBAL_DATUM(character_directory, /datum/character_directory)
GLOBAL_LIST_EMPTY(name_to_appearance)
#define READ_PREFS(target, pref) (target.client?.prefs?.read_preference(/datum/preference/pref))
///Helper macro for directory ads' preview views
#define CHAR_DIRECTORY_ASSIGNED_VIEW(user_ckey) "preview_[user_ckey]_char_directory_records"

// We want players to be able to decide whether they show up in the directory or not
/datum/preference/toggle/show_in_directory
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE
	savefile_key = "show_in_directory"
	savefile_identifier = PREFERENCE_PLAYER

// The advertisement that you show to people looking through the directory
/datum/preference/text/character_ad
	savefile_key = "character_ad"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	maximum_value_length = MAX_FLAVOR_LEN

// TGUI gets angry if you don't define a default on text preferences
/datum/preference/text/character_ad/create_default_value()
	return ""

// Any text preference needs this for some reason
/datum/preference/text/character_ad/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/attraction
	savefile_key = "attraction"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/attraction/init_possible_values()
	return list("Gay", "Lesbian", "Straight", "Skolio", "Bi", "Pan", "Poly", "Omni", "Ace", "Aro", "Aro/Ace", "Unset", "Check OOC")

/datum/preference/choiced/attraction/create_default_value()
	return "Unset"

/datum/preference/choiced/attraction/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/display_gender
	savefile_key = "display_gender"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/display_gender/init_possible_values()
	return list("Male", "Female", "Null", "Plural", "Nonbinary", "Omni", "Trans", "Andro", "Gyno", "Fluid", "Unset", "Check OOC")

/datum/preference/choiced/display_gender/create_default_value()
	return "Unset"

/datum/preference/choiced/display_gender/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

// Add a cooldown for the character directory to the client, primarily to stop server lag from refresh spam
/client
	COOLDOWN_DECLARE(char_directory_cooldown)

/// Opens character directory UI for a specific user
/client/verb/show_character_directory(specific_ad as text|null)
	set name = "Character Directory"
	set category = "OOC"
	set desc = "Shows a listing of all active characters, along with their associated OOC notes, flavor text, and more."

	if(is_character_directory_on_cooldown())
		return

	// Check if there's not already a character directory open; open a new one if one is not present
	if(!GLOB.character_directory)
		GLOB.character_directory = new

	// So we start opening their page right away. There really isn't any other good way to pass this to tgui unfortunately...
	if(specific_ad)
		var/sanitized_name = trim(specific_ad, MAX_NAME_LEN)
		GLOB.character_directory.start_viewing_ad[ckey] = sanitized_name

	GLOB.character_directory.ui_interact(mob)

/// Returns TRUE if it's on cooldown, FALSE otherwise. This is primarily to stop malicious users from trying to lag the server by spamming this verb
/client/proc/is_character_directory_on_cooldown()
	// This is primarily to stop malicious users from trying to lag the server by spamming this verb
	if(!COOLDOWN_FINISHED(src, char_directory_cooldown))
		to_chat(src, span_alert("Hold your horses! It's still refreshing!"))
		return TRUE
	COOLDOWN_START(src, char_directory_cooldown, 10)
	return FALSE

// This is a global singleton. Keep in mind that all operations should occur on user, not src.
/datum/character_directory
	/// The character preview views for the UI.
	var/list/atom/movable/screen/map_view/char_preview/directory/character_preview_views = list()
	/// For when a character starts off viewing a specific character's ad
	var/list/start_viewing_ad = list()

/datum/character_directory/Destroy(force)
	for(var/ckey in character_preview_views)
		var/atom/movable/screen/map_view/char_preview/directory/preview = character_preview_views[ckey]
		qdel(preview)
	return ..()

/atom/movable/screen/map_view/char_preview/directory
	/// Tracks a ref to the client ckey, for the character directory
	var/client_ckey

/atom/movable/screen/map_view/char_preview/directory/Destroy(force)
	GLOB.character_directory?.character_preview_views -= client_ckey

	return ..()

/// Makes a managed character preview view for a specific user
/datum/character_directory/proc/create_character_preview_view(mob/user, datum/tgui_window/window)
	var/assigned_view = CHAR_DIRECTORY_ASSIGNED_VIEW(user.ckey)

	// sometimes--e.g. if you have a ui open and you observe--you can end up with a stuck map_view, which leads to subsequent previews not rendering.
	// let's clear those out, we always want a new one when calling this proc anyway.
	var/old_view = user.client?.screen_maps[assigned_view]
	if(old_view)
		qdel(old_view)

	var/atom/movable/screen/map_view/char_preview/directory/new_view = new(null)
	new_view.client_ckey = user.ckey
	new_view.generate_view(assigned_view)
	new_view.display_to(user, window)
	character_preview_views[user.ckey] = new_view
	return new_view

/// Takes a record and updates the character preview view to match it.
/datum/character_directory/proc/update_preview(mob/user, assigned_view, mutable_appearance/appearance, datum/tgui_window/window)
	var/mutable_appearance/preview = new(appearance)

	var/atom/movable/screen/map_view/char_preview/directory/old_view = user.client?.screen_maps[assigned_view]?[1]
	if(!old_view)
		create_character_preview_view(user, window)
		return

	old_view.appearance = preview.appearance

/datum/character_directory/ui_state(mob/user)
	return GLOB.always_state

/datum/character_directory/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NovaCharacterDirectory", "Character Directory")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/character_directory/ui_close(mob/user)
	var/atom/movable/screen/map_view/char_preview/directory/old_preview = character_preview_views[user.ckey]
	if(QDELETED(old_preview))
		return
	qdel(old_preview)

// We want this information to update any time the player updates their preferences, not just when the panel is refreshed
/datum/character_directory/ui_data(mob/user)
	. = ..()
	var/list/data = .

	// Collect the user's own preferences for the top of the UI
	if (user?.client?.prefs)
		data["personalVisibility"] = READ_PREFS(user, toggle/show_in_directory)
		data["personalAttraction"] = READ_PREFS(user, choiced/attraction)
		data["personalGender"] = READ_PREFS(user, choiced/display_gender)
		data["personalErpTag"] = READ_PREFS(user, choiced/erp_status)
		data["personalVoreTag"] = READ_PREFS(user, choiced/erp_status_v)
		data["personalNonconTag"] = READ_PREFS(user, choiced/erp_status_nc)
		data["personalHypnoTag"] = READ_PREFS(user, choiced/erp_status_hypno)
		data["prefsOnly"] = TRUE

	data["assignedView"] = CHAR_DIRECTORY_ASSIGNED_VIEW(user.ckey)
	data["canOrbit"] = isobserver(user)
	// for when we want to start off with a search term filled in automatically
	var/autofill_search_term = start_viewing_ad[user.ckey]
	if(autofill_search_term)
		data["startViewing"] = autofill_search_term
		start_viewing_ad -= user.ckey

	return data

/datum/character_directory/ui_static_data(mob/user)
	. = ..()
	var/list/data = .

	// These are the variables we're trying to display in the directory
	var/list/directory_mobs = list()
	var/name
	var/species
	var/ooc_notes
	var/flavor_text
	var/attraction
	var/gender
	var/erp
	var/vore
	var/noncon
	var/hypno
	var/veteran_status
	var/character_ad
	var/headshot
	var/ref

	// We want the directory to display only alive players, not observers or people in the lobby
	for(var/mob/mob in GLOB.alive_player_list)
		// Skip people who are opted out
		if(!READ_PREFS(mob, toggle/show_in_directory))
			continue
		// Just in case ?
		if(QDELETED(mob))
			continue

		ref = REF(mob)

		// Different approach for humans and silicons
		if(ishuman(mob))
			var/mob/living/carbon/human/human = mob
			//If someone is obscured without flavor text visible, we don't want them on the Directory.
			if((human.wear_mask && (human.wear_mask.flags_inv & HIDEFACE)) || (human.head && (human.head.flags_inv & HIDEFACE)) || (HAS_TRAIT(human, TRAIT_UNKNOWN)))
				continue
			//Display custom species, otherwise show base species instead
			species = (READ_PREFS(human, text/custom_species)) || "Unset"
			if(species == "Unset")
				species = "[human.dna.species.name]"
			//Load standard flavor text preference
			flavor_text = READ_PREFS(human, text/flavor_text) || ""
			headshot = human.dna.features["headshot"] || ""
		else if(issilicon(mob))
			var/mob/living/silicon/silicon = mob
			//If the target is a silicon, we want it to show its brain as its species
			species = READ_PREFS(silicon, choiced/brain_type)
			//Load silicon flavor text in place of normal flavor text
			flavor_text = READ_PREFS(silicon, text/silicon_flavor_text) || ""
			headshot = READ_PREFS(silicon, text/headshot) || ""
		// Don't show if they are not a human or a silicon
		else
			continue

		// List of all the shown ERP preferences in the Directory. If there is none, return "Unset"
		attraction = READ_PREFS(mob, choiced/attraction) || "Unspecified"
		gender = READ_PREFS(mob, choiced/display_gender) || "Unset"
		if(gender == "Unset")
			gender = capitalize(mob.gender)
		erp = READ_PREFS(mob, choiced/erp_status) || "Ask"
		vore = READ_PREFS(mob, choiced/erp_status_v) || "Ask"
		noncon = READ_PREFS(mob, choiced/erp_status_nc) || "Ask"
		hypno = READ_PREFS(mob, choiced/erp_status_hypno) || "Ask"
		character_ad = READ_PREFS(mob, text/character_ad) || ""
		ooc_notes = READ_PREFS(mob, text/ooc_notes) || ""
		veteran_status = mob.client && SSplayer_ranks.is_veteran(mob.client, admin_bypass = FALSE)
		// And finally, we want to get the mob's name, taking into account disguised names.
		name = mob.real_name ? mob.name : mob.real_name

		directory_mobs.Add(list(list(
			"name" = name,
			"appearance_name" = mob.real_name,
			"species" = species,
			"ooc_notes" = ooc_notes,
			"attraction" = attraction,
			"gender" = gender,
			"erp" = erp,
			"vore" = vore,
			"noncon" = noncon,
			"hypno" = hypno,
			"veteran_status" = veteran_status,
			"character_ad" = character_ad,
			"flavor_text" = flavor_text,
			"headshot" = headshot,
			"ref" = ref
		)))

	data["directory"] = directory_mobs

	return data

/datum/character_directory/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return

	var/mob/user = usr
	if(!user)
		return

	switch(action)
		if("refresh")
			// This is primarily to stop malicious users from trying to lag the server by spamming this verb
			if(!COOLDOWN_FINISHED(user.client, char_directory_cooldown))
				to_chat(user, "<span class='warning'>Please wait before refreshing the directory again.</span>")
				return
			COOLDOWN_START(user.client, char_directory_cooldown, 10)
			update_static_data(user, ui)
			return TRUE
		if("orbit")
			var/ref = params["ref"]
			var/mob/dead/observer/ghost = user
			var/atom/movable/poi = (locate(ref) in GLOB.mob_list)
			if (poi == null)
				return TRUE
			ghost.ManualFollow(poi)
			ghost.reset_perspective(null)
			return TRUE
		if("view_character")
			update_preview(usr, params["assigned_view"], GLOB.name_to_appearance[params["name"]], ui.window)
			return TRUE
