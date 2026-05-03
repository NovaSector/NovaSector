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
	/*if(belly != null)
		if(belly.lastuser != null)
			if(belly.lastuser.client != null)
				return belly.lastuser.client*/
	return user?.client

/datum/erp_belly_prefshelper/proc/get_assoc_belly(mob/user)
	RETURN_TYPE(/obj/item/belly_function)
	var/obj/item/belly_function/belly = locate() in user
	return belly

/datum/erp_belly_prefshelper/ui_interact(mob/dead/new_player/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, debug_ui_name, "bwelly")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/erp_belly_prefshelper/ui_static_data(mob/user)
	. = list()
	//.["a_constant"] = A_CONSTANT
	var/static/consent_options = list("Never", "Query", "Always")
	.["pred_options"] = consent_options
	.["prey_options"] = consent_options
	.["ckeyTab"] = "[user.client?.ckey]TumsTab"

/datum/erp_belly_prefshelper/ui_data(mob/user)
	. = list()

	// Figure out if this is a local call (actual player entity and belly helper to modify) or a charprefs call.
	var/obj/item/belly_function/belly = get_assoc_belly(user)
	.["has_belly"] = (belly != null || (/datum/quirk/belly::name in get_assoc_client(user)?.prefs.all_quirks))
	.["has_player"] = (belly != null)

	// Figure out what tab we're in
	var/ui_tab = 2
	if(belly != null)
		ui_tab = 1
	if("[user.client?.ckey]TumsTab" in tgui_shared_states)
		ui_tab = text2num(tgui_shared_states["[user.client?.ckey]TumsTab"])
		if(belly == null && ui_tab == 1)
			ui_tab = 2

	// Of note here, tgui_shared_states does *not* like to be written to directly.
	// Sanity checks here and in the TSX side *should* stop invalid tab states, but...
	// It's not a guarantee.

	// Actually fill out ui_data
	if(ui_tab == 1)
		if(belly == null)
			return
		if(belly.lastuser == null)
			return
		// == LOCAL SETTINGS BREAKER ==
		// Send title
		.["title"] = "Local belly prefs: [belly.lastuser]"
		// Send current color & sprite variants
		.["color"] = belly.color
		.["use_skintone"] = belly.use_skintone
		.["use_slime_alpha"] = belly.use_slime_alpha
		// Send current size modifiers
		.["sizemod"] = belly.sizemod
		.["sizemod_autostuffed"] = belly.sizemod_autostuffed
		.["sizemod_audio"] = belly.sizemod_audio
		// Send current sound rules
		.["allow_sound_groans"] = belly.allow_sound_groans
		.["allow_sound_gurgles"] = belly.allow_sound_gurgles
		.["allow_sound_move_creaks"] = belly.allow_sound_move_creaks
		.["allow_sound_move_sloshes"] = belly.allow_sound_move_sloshes
		// Send details on current calculated belly size
		.["maxsize"] = belly.maxsize
		var/nutritionmaxxing = "N/A"
		var/belly_current_size_unclamped = ((((belly.base_size_cosmetic + belly.base_size_full + belly.base_size_stuffed) / 10)**1.5) / (4/3) / PI)**(1/3)
		var/belly_last_size = FLOOR(belly_current_size_unclamped, 1)
		if(belly_last_size > 16)
			belly_last_size = 16
		if(belly_last_size > belly.maxsize)
			belly_last_size = belly.maxsize
		if(belly_last_size < 0)
			belly_last_size = 0
		if(belly.sizemod_autostuffed > 0 && belly.sizemod > 0)
			nutritionmaxxing = (((25.9852 * ((belly_current_size_unclamped)**2))/belly.sizemod/belly.sizemod_autostuffed) + 500) / 0.4
		.["calculated_size"] = "Base cosmetic sizes: sprite size of [belly_current_size_unclamped]/16 ([belly_last_size]/[belly.maxsize] clamped) or [nutritionmaxxing] nutrition."
		// Send a calculated max for the sliders - this is based on the volume equation.
		// This sets per-category max to the value required to reach a smidge beyond the maximum sprite size.
		if(belly.sizemod > 0)
			.["base_size_max"] = (25.9852 * ((16+1)**2))/belly.sizemod
		else
			.["base_size_max"] = (25.9852 * ((16+1)**2))
		.["base_size_cosmetic"] = belly.base_size_cosmetic
		.["base_size_full"] = belly.base_size_full
		.["base_size_stuffed"] = belly.base_size_stuffed
		// Send current vore-related prefs
		.["pred_mode"] = belly.pred_mode
		.["endo_size_label"] = "Default endo size (sprite size [(((belly.endo_size / 10 * belly.sizemod)**1.5) / (4/3) / PI)**(1/3)])"
		.["endo_size"] = belly.endo_size
		// Possibly need to refactor this to store prey_mode on mobs somewhere to avoid constant pref reads
		.["prey_mode"] = get_assoc_client(user).prefs.read_preference(/datum/preference/choiced/erp_vore_prey_pref) || "Never"
	else if(ui_tab == 2)
		// == PREFS SETTINGS BREAKER ==
		// Send title
		.["title"] = "Character belly prefs: [get_assoc_client(user).prefs.read_preference(/datum/preference/name/real_name)]"
		// Send current color & sprite variants
		.["color"] = get_assoc_client(user).prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) || "#FFFFFF"
		.["use_skintone"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone) || FALSE
		.["use_slime_alpha"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_use_slime_alpha) || FALSE
		// Send current size modifiers
		var/prefs_sizemod = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod) || 1
		.["sizemod"] = prefs_sizemod
		var/prefs_sizemod_autostuffed = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed) || 1
		.["sizemod_autostuffed"] = prefs_sizemod_autostuffed
		var/prefs_sizemod_audio = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_audio) || 1
		.["sizemod_audio"] = prefs_sizemod_audio
		// Send current sound rules
		.["allow_sound_groans"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans) || FALSE
		.["allow_sound_gurgles"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles) || FALSE
		.["allow_sound_move_creaks"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks) || FALSE
		.["allow_sound_move_sloshes"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes) || FALSE
		// Read & calculate current prefs-based sizes
		var/prefs_base_size_cosmetic = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_base) || 0
		var/prefs_base_size_full = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_full) || 0
		var/prefs_base_size_stuffed = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_stuffed) || 0
		var/prefs_maxsize = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_maxsize) || 0
		.["maxsize"] = prefs_maxsize
		var/prefs_current_size_unclamped = ((((prefs_base_size_cosmetic + prefs_base_size_full + prefs_base_size_stuffed) / 10)**1.5) / (4/3) / PI)**(1/3)
		var/prefs_last_size = FLOOR(prefs_current_size_unclamped, 1)
		if(prefs_last_size > 16)
			prefs_last_size = 16
		if(prefs_last_size > prefs_maxsize)
			prefs_last_size = prefs_maxsize
		if(prefs_last_size < 0)
			prefs_last_size = 0
		// Send details on current calculated belly size
		var/nutritionmaxxing = "N/A"
		if(prefs_sizemod_autostuffed > 0 && prefs_sizemod > 0)
			nutritionmaxxing = (((25.9852 * ((prefs_current_size_unclamped)**2))/prefs_sizemod/prefs_sizemod_autostuffed) + 500) / 0.4
		.["calculated_size"] = "Base cosmetic sizes: sprite size of [prefs_current_size_unclamped]/16 ([prefs_last_size]/[prefs_maxsize] clamped) or [nutritionmaxxing] nutrition."
		// Send a calculated max for the sliders - this is based on the volume equation.
		// This sets per-category max to the value required to reach a smidge beyond the maximum sprite size.
		if(prefs_sizemod > 0)
			.["base_size_max"] = (25.9852 * ((16+1)**2))/prefs_sizemod
		else
			.["base_size_max"] = (25.9852 * ((16+1)**2))
		.["base_size_cosmetic"] = prefs_base_size_cosmetic
		.["base_size_full"] = prefs_base_size_full
		.["base_size_stuffed"] = prefs_base_size_stuffed
		// Send current vore-related prefs
		.["pred_mode"] = get_assoc_client(user).prefs.read_preference(/datum/preference/choiced/erp_bellyquirk_pred_pref) || "Never"
		var/prefs_endo_size = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_endo) || 1000
		.["endo_size_label"] = "Default endo size (sprite size [(((prefs_endo_size / 10 * prefs_sizemod)**1.5) / (4/3) / PI)**(1/3)])"
		.["endo_size"] = prefs_endo_size
		.["prey_mode"] = get_assoc_client(user).prefs.read_preference(/datum/preference/choiced/erp_vore_prey_pref) || "Never"
	else if(ui_tab == 3)
		// == GLOBAL PREFS SETTINGS BREAKER ==
		// Send title
		.["title"] = "Global belly prefs"
		// Send sprite visibility rules
		.["global_belly_visibility"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly) || FALSE
		.["global_maxsize"] = get_assoc_client(user).prefs.read_preference(/datum/preference/numeric/erp_belly_maxsize) || 0
		// Send current sound rules
		.["global_sound_groans"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_groans) || FALSE
		.["global_sound_gurgles"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_gurgles) || FALSE
		.["global_sound_move_creaks"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_creaks) || FALSE
		.["global_sound_move_sloshes"] = get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_sloshes) || FALSE

/datum/erp_belly_prefshelper/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	// Setup some temp variables for tracking things
	var/static/list_yesno = list("Yes", "No")
	var/wrote_prefs = FALSE
	var/mob/user = ui.user
	var/obj/item/belly_function/belly = get_assoc_belly(user)

	// Sanity check: if our owner exploded or something, close the UI.
	if(belly != null)
		if(belly.lastuser == null)
			ui.close()
			return FALSE
	// Sanity check: if someone's client peaced out for whatever reason, close the UI.
	if(get_assoc_client(user) == null)
		ui.close()
		return FALSE

	// UI tab tracker requires that we actually have a user to pull the shared state for, so we check here.
	var/ui_tab = 1
	if("[user.client?.ckey]TumsTab" in tgui_shared_states)
		ui_tab = text2num(tgui_shared_states["[user.client?.ckey]TumsTab"])

	switch(action)
		if("changeColor")
			var/new_color = get_assoc_client(user).prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) || "#FFFFFF"
			new_color = tgui_color_picker(belly.lastuser, "Enter new color:", "Color", new_color)
			if(new_color != null || QDELETED(belly.lastuser) || QDELETED(src))
				if(params["tab"] == "2" || ui_tab == 2)
					get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/color/erp_bellyquirk_color], new_color)
					wrote_prefs = TRUE
					if(new_color != belly?.color && belly != null)
						var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
						if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
							belly.color = new_color
				else if(belly != null)
					belly.color = new_color
			belly?.do_alt_appearance(belly?.lastuser, TRUE, belly?.last_size)
			belly?.last_size = -1
		if("changeUseSkintone")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_use_skintone = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_skintone], new_use_skintone != FALSE)
				wrote_prefs = TRUE
				var/new_color = null
				if(new_use_skintone)
					var/mode_select = tgui_alert(belly.lastuser, "Auto-set color based on your skintone?", "Inherit Skintone?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						new_color = skintone2hex(get_assoc_client(user).prefs.read_preference(/datum/preference/choiced/skin_tone)) //why this isn't in DNA hurts me
						get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/color/erp_bellyquirk_color], new_color)
						wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.use_skintone = new_use_skintone
						if(new_color != null)
							belly.color = new_color
			else if(belly != null)
				belly.use_skintone = !belly.use_skintone
				if(belly.use_skintone)
					var/mode_select = tgui_alert(belly.lastuser, "Auto-set color based on your skintone?", "Inherit Skintone?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.color = skintone2hex(belly.lastuser.skin_tone) //why this isn't in DNA hurts me
			belly?.do_alt_appearance(belly?.lastuser, TRUE, belly?.last_size)
			belly?.last_size = -1
		if("changeUseSlimeAlpha")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_use_slime_alpha = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_use_slime_alpha) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_use_slime_alpha], new_use_slime_alpha != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.use_slime_alpha = new_use_slime_alpha
			else if(belly != null)
				belly.use_slime_alpha = !belly.use_slime_alpha
			belly?.do_alt_appearance(belly?.lastuser, TRUE, belly?.last_size)
			belly?.last_size = -1
		if("changeSizemod")
			var/new_sizemod = text2num(params["newSizemod"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod], new_sizemod)
				wrote_prefs = TRUE
				if(new_sizemod != belly?.sizemod && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.sizemod = new_sizemod
			else if(belly != null)
				belly.sizemod = new_sizemod
		if("changeSizemodAutostuffed")
			var/new_sizemod_autostuffed = text2num(params["newSizemodAutostuffed"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed], new_sizemod_autostuffed)
				wrote_prefs = TRUE
				if(new_sizemod_autostuffed != belly?.sizemod_autostuffed && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.sizemod_autostuffed = new_sizemod_autostuffed
			else if(belly != null)
				belly.sizemod_autostuffed = new_sizemod_autostuffed
		if("changeSizemodAudio")
			var/new_sizemod_audio = text2num(params["newSizemodAudio"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_sizemod_audio], new_sizemod_audio)
				wrote_prefs = TRUE
				if(new_sizemod_audio != belly?.sizemod_audio && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.sizemod_audio = new_sizemod_audio
			else if(belly != null)
				belly.sizemod_audio = new_sizemod_audio
		if("changeSoundGroans")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_allow_sound_groans = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_groans], new_allow_sound_groans != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.allow_sound_groans = new_allow_sound_groans
			else if(belly != null)
				belly.allow_sound_groans = !belly.allow_sound_groans
		if("changeSoundGurgles")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_allow_sound_gurgles = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_gurgles], new_allow_sound_gurgles != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.allow_sound_gurgles = new_allow_sound_gurgles
			else if(belly != null)
				belly.allow_sound_gurgles = !belly.allow_sound_gurgles
		if("changeSoundMoveCreaks")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_allow_sound_move_creaks = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_move_creaks], new_allow_sound_move_creaks != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.allow_sound_move_creaks = new_allow_sound_move_creaks
			else if(belly != null)
				belly.allow_sound_move_creaks = !belly.allow_sound_move_creaks
		if("changeSoundMoveSloshes")
			if(params["tab"] == "2" || ui_tab == 2)
				var/new_allow_sound_move_sloshes = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes) || FALSE)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp_bellyquirk_move_sloshes], new_allow_sound_move_sloshes != FALSE)
				wrote_prefs = TRUE
				if(belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.allow_sound_move_sloshes = new_allow_sound_move_sloshes
			else if(belly != null)
				belly.allow_sound_move_sloshes = !belly.allow_sound_move_sloshes
		if("changeMaxsize")
			var/new_maxsize = text2num(params["newMaxsize"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_maxsize], new_maxsize)
				wrote_prefs = TRUE
				if(new_maxsize != belly?.maxsize && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.maxsize = new_maxsize
			else if(belly != null)
				belly.maxsize = new_maxsize
		if("changeBaseCosmetic")
			var/new_base_size_cosmetic = text2num(params["newBaseCosmetic"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_base], new_base_size_cosmetic)
				wrote_prefs = TRUE
				if(new_base_size_cosmetic != belly?.base_size_cosmetic && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.base_size_cosmetic = new_base_size_cosmetic
			else if(belly != null)
				belly.base_size_cosmetic = new_base_size_cosmetic
		if("changeBaseFull")
			var/new_base_size_full = text2num(params["newBaseFull"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_full], new_base_size_full)
				wrote_prefs = TRUE
				if(new_base_size_full != belly?.base_size_full && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.base_size_full = new_base_size_full
			else if(belly != null)
				belly.base_size_full = new_base_size_full
		if("changeBaseStuffed")
			var/new_base_size_stuffed = text2num(params["newBaseStuffed"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_stuffed], new_base_size_stuffed)
				wrote_prefs = TRUE
				if(new_base_size_stuffed != belly?.base_size_stuffed && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.base_size_stuffed = new_base_size_stuffed
			else if(belly != null)
				belly.base_size_stuffed = new_base_size_stuffed
		if("changePredMode")
			var/new_pred_mode = params["newPredMode"]
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/choiced/erp_bellyquirk_pred_pref], new_pred_mode)
				wrote_prefs = TRUE
				if(new_pred_mode != belly?.pred_mode && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.pred_mode = new_pred_mode
			else if(belly != null)
				belly.pred_mode = new_pred_mode
		if("changeEndoSize")
			var/new_endo_size = text2num(params["newEndoSize"])
			if(params["tab"] == "2" || ui_tab == 2)
				get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_bellyquirk_size_endo], new_endo_size)
				wrote_prefs = TRUE
				if(new_endo_size != belly?.endo_size && belly != null)
					var/mode_select = tgui_alert(belly.lastuser, "Update your current in-round prefs to match the new value?", "Update Local?", list_yesno)
					if(!(isnull(mode_select) || QDELETED(belly.lastuser) || QDELETED(src)) && mode_select == "Yes")
						belly.endo_size = new_endo_size
			else if(belly != null)
				belly.endo_size = new_endo_size
		if("changePreyMode")
			var/new_prey_mode = params["newPreyMode"]
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/choiced/erp_vore_prey_pref], new_prey_mode)
			wrote_prefs = TRUE
			//in-round prey mode edits don't exist yet ,this may yet be refactored.
		// === GLOBAL PREFS BREAKER ===
		if("changeGlobalSoundGroans")
			var/new_global_sound_groans = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_groans) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_groans], new_global_sound_groans != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalSoundGurgles")
			var/new_global_sound_gurgles = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_gurgles) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_gurgles], new_global_sound_gurgles != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalSoundMoveCreaks")
			var/new_global_sound_move_creaks = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_creaks) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_move_creaks], new_global_sound_move_creaks != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalSoundMoveSloshes")
			var/new_global_sound_move_sloshes = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly/sound_move_sloshes) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly/sound_move_sloshes], new_global_sound_move_sloshes != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalVisibility")
			var/new_visibility = !(get_assoc_client(user).prefs.read_preference(/datum/preference/toggle/erp/belly) || FALSE)
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/erp/belly], new_visibility != FALSE)
			wrote_prefs = TRUE
		if("changeGlobalMaxsize")
			var/new_maxsize = text2num(params["newMaxsize"])
			get_assoc_client(user).prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/erp_belly_maxsize], new_maxsize)
			wrote_prefs = TRUE

	if(wrote_prefs == TRUE)
		get_assoc_client(user).prefs.save_preferences()
	return TRUE
