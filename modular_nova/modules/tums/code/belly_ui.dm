GLOBAL_DATUM_INIT(erp_belly_prefshelper, /datum/erp_belly_prefshelper, new)

/// Helper for managing preferences independent of an equipped belly.
/datum/erp_belly_prefshelper
	/// Tracker for this helper's client.
	//var/client/associated_client
	/// Tracker for this helper's associated belly function, if it's in-round.
	//var/obj/item/belly_function/belly
	/// Tracker for whether or not this helper's associated preferences datum had changes made; keeps us from doing save_preferences every time.
	//var/wrote_prefs = FALSE
	var/debug_ui_name = "NovaTumsPrefs"

/datum/erp_belly_prefshelper/ui_state(mob/user)
	return GLOB.always_state

/datum/erp_belly_prefshelper/proc/get_assoc_client(mob/user)
	RETURN_TYPE(/client)
	return user?.client

/datum/erp_belly_prefshelper/proc/get_assoc_belly(mob/user)
	RETURN_TYPE(/obj/item/belly_function)
	var/obj/item/belly_function/belly = locate() in user
	return belly

/// Standard "sync this change to your live belly?" prompt. Returns TRUE on Yes.
/// Safe to call with a null belly (returns FALSE without prompting).
/datum/erp_belly_prefshelper/proc/confirm_sync(obj/item/belly_function/belly)
	if(belly == null)
		return FALSE
	var/choice = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list("Yes", "No"))
	return choice == "Yes" && !QDELETED(belly.lastuser) && !QDELETED(src)

/// Fills the shared belly-size readout fields (calculated_size, base_size_max, maxsize)
/// from a set of base sizes. Used identically by the local and character-prefs tabs.
/datum/erp_belly_prefshelper/proc/build_size_data(list/out, cosmetic, full, stuffed, maxsize, sizemod, sizemod_autostuffed)
	var/unclamped = ((((cosmetic + full + stuffed) / 10) ** 1.5) / (4/3) / PI) ** (1/3)
	var/last_size = round(unclamped, 1)
	if(last_size > 16)
		last_size = 16
	if(last_size > maxsize)
		last_size = maxsize
	if(last_size < 0)
		last_size = 0
	var/nutritionmaxxing = "N/A"
	if(sizemod_autostuffed > 0 && sizemod > 0)
		nutritionmaxxing = (((25.9852 * (unclamped ** 2)) / sizemod / sizemod_autostuffed) + 500) / 0.4
	out["calculated_size"] = "Base cosmetic sizes: sprite size of [unclamped]/16 ([last_size]/[maxsize] clamped) or [nutritionmaxxing] nutrition."
	// Per-category slider max: the value needed to reach a smidge beyond max sprite size.
	out["base_size_max"] = sizemod > 0 ? (25.9852 * ((16+1)**2)) / sizemod : (25.9852 * ((16+1)**2))
	out["maxsize"] = maxsize

/datum/erp_belly_prefshelper/ui_interact(mob/dead/new_player/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, debug_ui_name, "bwelly")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/erp_belly_prefshelper/ui_static_data(mob/user)
	. = list()
	var/static/consent_options = list("Never", "Query", "Always")
	.["pred_options"] = consent_options
	.["prey_options"] = consent_options
	.["ckeyTab"] = "[user.client?.ckey]TumsTab"

/datum/erp_belly_prefshelper/ui_data(mob/user)
	. = list()

	var/client/client = get_assoc_client(user)
	var/tab_key = "[user.client?.ckey]TumsTab"

	// Figure out if this is a local call (actual player entity and belly helper to modify) or a charprefs call.
	var/obj/item/belly_function/belly = get_assoc_belly(user)
	.["has_belly"] = (belly != null || (/datum/quirk/belly::name in client?.prefs.all_quirks))
	.["has_player"] = (belly != null)

	// Figure out what tab we're in
	var/ui_tab = 2
	if(belly != null)
		ui_tab = 1
	if(tab_key in tgui_shared_states)
		ui_tab = text2num(tgui_shared_states[tab_key])
		if(belly == null && ui_tab == 1)
			ui_tab = 2

	// Of note here, tgui_shared_states does *not* like to be written to directly.
	// Sanity checks here and in the TSX side *should* stop invalid tab states, but...
	// It's not a guarantee.

	if(ui_tab == 1)
		// == LOCAL SETTINGS BREAKER ==
		if(belly == null || belly.lastuser == null)
			return
		.["title"] = "Local belly prefs: [belly.lastuser]"
		.["color"] = belly.color
		.["use_skintone"] = belly.use_skintone
		.["sizemod"] = belly.sizemod
		.["sizemod_autostuffed"] = belly.sizemod_autostuffed
		.["sizemod_audio"] = belly.sizemod_audio
		.["allow_sound_groans"] = belly.allow_sound_groans
		.["allow_sound_gurgles"] = belly.allow_sound_gurgles
		.["allow_sound_move_creaks"] = belly.allow_sound_move_creaks
		.["allow_sound_move_sloshes"] = belly.allow_sound_move_sloshes
		build_size_data(., belly.base_size_cosmetic, belly.base_size_full, belly.base_size_stuffed, belly.maxsize, belly.sizemod, belly.sizemod_autostuffed)
		.["base_size_cosmetic"] = belly.base_size_cosmetic
		.["base_size_full"] = belly.base_size_full
		.["base_size_stuffed"] = belly.base_size_stuffed
		.["pred_mode"] = belly.pred_mode
		.["endo_size_label"] = "Default endo size (sprite size [(((belly.endo_size / 10 * belly.sizemod) ** 1.5) / (4/3) / PI) ** (1/3)])"
		.["endo_size"] = belly.endo_size
		// Possibly need to refactor this to store prey_mode on mobs somewhere to avoid constant pref reads
		.["prey_mode"] = client.prefs.read_preference(/datum/preference/choiced/erp_vore_prey_pref) || "Never"

	else if(ui_tab == 2)
		// == PREFS SETTINGS BREAKER ==
		.["title"] = "Character belly prefs: [client.prefs.read_preference(/datum/preference/name/real_name)]"
		.["color"] = client.prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) || "#FFFFFF"
		.["use_skintone"] = client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone) || FALSE
		var/prefs_sizemod = client.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod) || 1
		.["sizemod"] = prefs_sizemod
		var/prefs_sizemod_autostuffed = client.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed) || 1
		.["sizemod_autostuffed"] = prefs_sizemod_autostuffed
		.["sizemod_audio"] = client.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_audio) || 1
		.["allow_sound_groans"] = client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans) || FALSE
		.["allow_sound_gurgles"] = client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles) || FALSE
		.["allow_sound_move_creaks"] = client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks) || FALSE
		.["allow_sound_move_sloshes"] = client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes) || FALSE
		var/prefs_base_size_cosmetic = client.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_base) || 0
		var/prefs_base_size_full = client.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_full) || 0
		var/prefs_base_size_stuffed = client.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_stuffed) || 0
		var/prefs_maxsize = client.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_maxsize) || 0
		build_size_data(., prefs_base_size_cosmetic, prefs_base_size_full, prefs_base_size_stuffed, prefs_maxsize, prefs_sizemod, prefs_sizemod_autostuffed)
		.["base_size_cosmetic"] = prefs_base_size_cosmetic
		.["base_size_full"] = prefs_base_size_full
		.["base_size_stuffed"] = prefs_base_size_stuffed
		.["pred_mode"] = client.prefs.read_preference(/datum/preference/choiced/erp_bellyquirk_pred_pref) || "Never"
		var/prefs_endo_size = client.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_endo) || 1000
		.["endo_size_label"] = "Default endo size (sprite size [(((prefs_endo_size / 10 * prefs_sizemod) ** 1.5) / (4/3) / PI) ** (1/3)])"
		.["endo_size"] = prefs_endo_size
		.["prey_mode"] = client.prefs.read_preference(/datum/preference/choiced/erp_vore_prey_pref) || "Never"

	else if(ui_tab == 3)
		// == GLOBAL PREFS SETTINGS BREAKER ==
		.["title"] = "Global belly prefs"
		.["global_belly_visibility"] = client.prefs.read_preference(/datum/preference/toggle/erp/belly) || FALSE
		.["global_maxsize"] = client.prefs.read_preference(/datum/preference/numeric/erp_belly_maxsize) || 0
		.["global_sound_groans"] = client.prefs.read_preference(/datum/preference/toggle/erp/belly/sound_groans) || FALSE
		.["global_sound_gurgles"] = client.prefs.read_preference(/datum/preference/toggle/erp/belly/sound_gurgles) || FALSE
		.["global_sound_move_creaks"] = client.prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_creaks) || FALSE
		.["global_sound_move_sloshes"] = client.prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_sloshes) || FALSE

/datum/erp_belly_prefshelper/proc/recheck_alt_apperances(client/player)
	if(player.mob != null)
		var/mob/living/player_as_living = player.mob
		if(istype(player_as_living))
			for(var/datum/atom_hud/alternate_appearance/erp/belly/bellyview in GLOB.active_alternate_appearances)
				if(istype(bellyview))
					bellyview.check_hud(player_as_living)
		else
			var/mob/dead/player_as_dead = player.mob
			if(istype(player_as_dead))
				for(var/datum/atom_hud/alternate_appearance/erp/belly/bellyview in GLOB.active_alternate_appearances)
					if(istype(bellyview))
						bellyview.check_hud(player_as_dead)

/datum/erp_belly_prefshelper/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return


	var/static/list/list_yesno = list("Yes", "No")
	var/update_dummy = TRUE
	var/mob/user = ui.user
	var/obj/item/belly_function/belly = get_assoc_belly(user)

	// Sanity check: if our owner exploded or something, close the UI.
	if(!isnull(belly) && isnull(belly.lastuser))
		ui.close()
		return FALSE
	// Sanity check: if someone's client peaced out for whatever reason, close the UI.
	var/client/client = get_assoc_client(user)
	if(client == null)
		ui.close()
		return FALSE

	var/tab_key = "[user.client?.ckey]TumsTab"
	var/ui_tab = 1
	if(tab_key in tgui_shared_states)
		ui_tab = text2num(tgui_shared_states[tab_key])
	var/is_prefs_tab = (params["tab"] == "2" || ui_tab == 2)

	// Recipient for any sleeping prompt; falls back to the acting user when there's no live belly.
	var/mob/prompt_target = belly?.lastuser || user

	switch(action)
		if("changeColor")
			var/new_color = client.prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) || "#FFFFFF"
			new_color = tgui_color_picker(prompt_target, "Enter new color:", "Color", new_color)
			if(!isnull(new_color) && !QDELETED(src))
				if(is_prefs_tab)
					client.prefs.write_preference(GLOB.preference_entries[/datum/preference/color/erp_bellyquirk_color], new_color)
					if(belly != null && new_color != belly.color && confirm_sync(belly))
						belly.color = new_color
				else if(belly != null)
					belly.color = new_color
			belly?.do_alt_appearance(belly?.lastuser, TRUE, belly?.last_size)
			belly?.last_size = -1
		if("changeUseSkintone")
			if(is_prefs_tab)
				var/new_use_skintone = !(client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone) || FALSE)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_skintone], new_use_skintone)
				var/new_color = null
				if(belly != null && confirm_sync(belly))
					belly.use_skintone = new_use_skintone
					if(new_color != null)
						belly.color = new_color
			else if(belly != null)
				belly.use_skintone = !belly.use_skintone
			belly?.do_alt_appearance(belly?.lastuser, TRUE, belly?.last_size)
			belly?.last_size = -1
		if("changeSizemod")
			var/new_sizemod = text2num(params["newSizemod"])
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod], new_sizemod)
				if(new_sizemod != belly?.sizemod && confirm_sync(belly))
					belly.sizemod = new_sizemod
			else if(belly != null)
				belly.sizemod = new_sizemod
		if("changeSizemodAutostuffed")
			var/new_sizemod_autostuffed = text2num(params["newSizemodAutostuffed"])
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed], new_sizemod_autostuffed)
				if(new_sizemod_autostuffed != belly?.sizemod_autostuffed && confirm_sync(belly))
					belly.sizemod_autostuffed = new_sizemod_autostuffed
			else if(belly != null)
				belly.sizemod_autostuffed = new_sizemod_autostuffed
		if("changeSizemodAudio")
			var/new_sizemod_audio = text2num(params["newSizemodAudio"])
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod_audio], new_sizemod_audio)
				if(new_sizemod_audio != belly?.sizemod_audio && confirm_sync(belly))
					belly.sizemod_audio = new_sizemod_audio
			else if(belly != null)
				belly.sizemod_audio = new_sizemod_audio
			update_dummy = FALSE
		if("changeSoundGroans")
			if(is_prefs_tab)
				var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans) || FALSE)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_groans], new_val)
				if(belly != null && confirm_sync(belly))
					belly.allow_sound_groans = new_val
			else if(belly != null)
				belly.allow_sound_groans = !belly.allow_sound_groans
			update_dummy = FALSE
		if("changeSoundGurgles")
			if(is_prefs_tab)
				var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles) || FALSE)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_gurgles], new_val)
				if(belly != null && confirm_sync(belly))
					belly.allow_sound_gurgles = new_val
			else if(belly != null)
				belly.allow_sound_gurgles = !belly.allow_sound_gurgles
			update_dummy = FALSE
		if("changeSoundMoveCreaks")
			if(is_prefs_tab)
				var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks) || FALSE)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_move_creaks], new_val)
				if(belly != null && confirm_sync(belly))
					belly.allow_sound_move_creaks = new_val
			else if(belly != null)
				belly.allow_sound_move_creaks = !belly.allow_sound_move_creaks
			update_dummy = FALSE
		if("changeSoundMoveSloshes")
			if(is_prefs_tab)
				var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes) || FALSE)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_move_sloshes], new_val)
				if(belly != null && confirm_sync(belly))
					belly.allow_sound_move_sloshes = new_val
			else if(belly != null)
				belly.allow_sound_move_sloshes = !belly.allow_sound_move_sloshes
		if("changeMaxsize")
			var/new_maxsize = text2num(params["newMaxsize"])
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_maxsize], new_maxsize)
				if(new_maxsize != belly?.maxsize && confirm_sync(belly))
					belly.maxsize = new_maxsize
			else if(belly != null)
				belly.maxsize = new_maxsize
		if("changeBaseCosmetic")
			var/new_base_size_cosmetic = text2num(params["newBaseCosmetic"])
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_base], new_base_size_cosmetic)
				if(new_base_size_cosmetic != belly?.base_size_cosmetic && confirm_sync(belly))
					belly.base_size_cosmetic = new_base_size_cosmetic
			else if(belly != null)
				belly.base_size_cosmetic = new_base_size_cosmetic
		if("changeBaseFull")
			var/new_base_size_full = text2num(params["newBaseFull"])
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_full], new_base_size_full)
				if(new_base_size_full != belly?.base_size_full && confirm_sync(belly))
					belly.base_size_full = new_base_size_full
			else if(belly != null)
				belly.base_size_full = new_base_size_full
		if("changeBaseStuffed")
			var/new_base_size_stuffed = text2num(params["newBaseStuffed"])
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_stuffed], new_base_size_stuffed)
				if(new_base_size_stuffed != belly?.base_size_stuffed && confirm_sync(belly))
					belly.base_size_stuffed = new_base_size_stuffed
			else if(belly != null)
				belly.base_size_stuffed = new_base_size_stuffed
		if("changePredMode")
			var/new_pred_mode = params["newPredMode"]
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/choiced/erp_bellyquirk_pred_pref], new_pred_mode)
				if(new_pred_mode != belly?.pred_mode && confirm_sync(belly))
					belly.pred_mode = new_pred_mode
			else if(belly != null)
				belly.pred_mode = new_pred_mode
		if("changeEndoSize")
			var/new_endo_size = text2num(params["newEndoSize"])
			if(is_prefs_tab)
				client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_endo], new_endo_size)
				if(new_endo_size != belly?.endo_size && confirm_sync(belly))
					belly.endo_size = new_endo_size
			else if(belly != null)
				belly.endo_size = new_endo_size
		if("changePreyMode")
			var/new_prey_mode = params["newPreyMode"]
			client.prefs.write_preference(GLOB.preference_entries[/datum/preference/choiced/erp_vore_prey_pref], new_prey_mode)
			update_dummy = FALSE
			//in-round prey mode edits don't exist yet, this may yet be refactored.
		// === GLOBAL PREFS BREAKER ===
		if("changeGlobalSoundGroans")
			var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp/belly/sound_groans) || FALSE)
			client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_groans], new_val)
			update_dummy = FALSE
		if("changeGlobalSoundGurgles")
			var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp/belly/sound_gurgles) || FALSE)
			client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_gurgles], new_val)
		if("changeGlobalSoundMoveCreaks")
			var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_creaks) || FALSE)
			client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_move_creaks], new_val)
			update_dummy = FALSE
		if("changeGlobalSoundMoveSloshes")
			var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_sloshes) || FALSE)
			client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_move_sloshes], new_val)
			update_dummy = FALSE
		if("changeGlobalVisibility")
			var/new_val = !(client.prefs.read_preference(/datum/preference/toggle/erp/belly) || FALSE)
			client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly], new_val)
			update_dummy = FALSE
			recheck_alt_apperances(client)
		if("changeGlobalMaxsize")
			var/new_maxsize = text2num(params["newGlobalMaxsize"])
			client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_belly_maxsize], new_maxsize)
			update_dummy = FALSE
			recheck_alt_apperances(client)

	if(update_dummy)
		client.prefs.character_preview_view?.update_body()
	return TRUE
