/datum/examine_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/holder
	/// The screen containing the appearance of the mob
	var/atom/movable/screen/map_view/examine_panel_screen/examine_panel_screen

/datum/examine_panel/New(mob/holder_mob)
	holder = holder_mob

/datum/examine_panel/Destroy(force)
	holder = null
	qdel(examine_panel_screen)
	return ..()

/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/examine_panel/ui_close(mob/user)
	user.client?.clear_map(examine_panel_screen.assigned_map)

/atom/movable/screen/map_view/examine_panel_screen
	name = "examine panel screen"

/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!examine_panel_screen)
		examine_panel_screen = new
		examine_panel_screen.name = "screen"
		examine_panel_screen.assigned_map = "examine_panel_[REF(holder)]_map"
		examine_panel_screen.del_on_map_removal = FALSE
		examine_panel_screen.screen_loc = "[examine_panel_screen.assigned_map]:1,1"

	var/mutable_appearance/current_mob_appearance = new(holder)
	current_mob_appearance.setDir(SOUTH)
	current_mob_appearance.transform = matrix() // We reset their rotation, in case they're lying down.

	// In case they're pixel-shifted, we bring 'em back!
	current_mob_appearance.pixel_x = 0
	current_mob_appearance.pixel_y = 0

	examine_panel_screen.cut_overlays()
	examine_panel_screen.add_overlay(current_mob_appearance)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ExaminePanel")
		ui.open()
		examine_panel_screen.display_to(user, ui.window)

/datum/examine_panel/ui_data(mob/user)

	var/datum/preferences/preferences = holder.client?.prefs

	var/flavor_text
	var/flavor_text_nsfw
	var/custom_species
	var/custom_species_lore
	var/obscured
	var/ooc_notes = ""
	var/ooc_notes_nsfw = ""
	var/ideal_antag_optin_status
	var/current_antag_optin_status
	var/headshot = ""

	// OOC notes go first
	if(preferences)
		if(user.client?.prefs?.read_preference(/datum/preference/toggle/master_erp_preferences))
			var/e_prefs = preferences.read_preference(/datum/preference/choiced/erp_status)
			var/e_prefs_hypno = preferences.read_preference(/datum/preference/choiced/erp_status_hypno)
			var/e_prefs_v = preferences.read_preference(/datum/preference/choiced/erp_status_v)
			var/e_prefs_nc = preferences.read_preference(/datum/preference/choiced/erp_status_nc)
			var/e_prefs_mechanical = preferences.read_preference(/datum/preference/choiced/erp_status_mechanics)
			ooc_notes_nsfw += "ERP: [e_prefs]\n"
			ooc_notes_nsfw += "Hypnosis: [e_prefs_hypno]\n"
			ooc_notes_nsfw += "Vore: [e_prefs_v]\n"
			ooc_notes_nsfw += "Non-Con: [e_prefs_nc]\n"
			ooc_notes_nsfw += "ERP Mechanics: [e_prefs_mechanical]\n"
			ooc_notes_nsfw += "\n"

		if(!CONFIG_GET(flag/disable_antag_opt_in_preferences))
			var/antag_prefs = holder.mind?.ideal_opt_in_level
			var/effective_opt_in_level = holder.mind?.get_effective_opt_in_level()
			if(isnull(antag_prefs))
				antag_prefs = preferences.read_preference(/datum/preference/choiced/antag_opt_in_status)
			current_antag_optin_status = GLOB.antag_opt_in_strings[num2text(effective_opt_in_level)]
			ideal_antag_optin_status = GLOB.antag_opt_in_strings[num2text(antag_prefs)]

	// Now we handle silicon and/or human, order doesn't matter as both obviously can't fire.
	// If other variants of mob/living need to be handled at some point, put them here.
	if(issilicon(holder))
		flavor_text = preferences.read_preference(/datum/preference/text/silicon_flavor_text)
		flavor_text_nsfw = preferences.read_preference(/datum/preference/text/silicon_flavor_text_nsfw)
		custom_species = "Silicon"
		custom_species_lore = "A silicon unit, like a cyborg or pAI."
		ooc_notes += preferences.read_preference(/datum/preference/text/ooc_notes)
		ooc_notes_nsfw += preferences.read_preference(/datum/preference/text/ooc_notes_nsfw)
		headshot += preferences.read_preference(/datum/preference/text/headshot/silicon)

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) || (holder_human.head && (holder_human.head.flags_inv & HIDEFACE))
		custom_species = obscured ? "Obscured" : holder_human.dna.species.lore_protected ? holder_human.dna.species.name : holder_human.dna.features["custom_species"]
		flavor_text = obscured ? "Obscured" : holder_human.dna.features[EXAMINE_DNA_FLAVOR_TEXT]
		flavor_text_nsfw = obscured ? "Obscured" : holder_human.dna.features[EXAMINE_DNA_FLAVOR_TEXT_NSFW]
		custom_species_lore = obscured ? "Obscured" : holder_human.dna.species.lore_protected ? holder_human.dna.species.get_species_lore().Join("\n") : holder_human.dna.features["custom_species_lore"]
		ooc_notes += holder_human.dna.features[EXAMINE_DNA_OOC_NOTES]
		ooc_notes_nsfw += holder_human.dna.features[EXAMINE_DNA_OOC_NOTES_NSFW]
		if(!obscured)
			headshot += holder_human.dna.features[EXAMINE_DNA_HEADSHOT]

	var/list/data = list(
		// Danger—do not touch
		"assigned_map" = examine_panel_screen.assigned_map,
		// Identity
		"character_name" = obscured ? "Unknown" : holder.name,
		"headshot" = headshot,
		"obscured" = obscured ? TRUE : FALSE,
		// Descriptions
		"flavor_text" = flavor_text,
		"ooc_notes" = ooc_notes,
		"custom_species" = custom_species,
		"custom_species_lore" = custom_species_lore,
		// Descriptions, but requiring manual input to see
		"flavor_text_nsfw" = flavor_text_nsfw,
		"ooc_notes_nsfw" = ooc_notes_nsfw,
		// Antaggery
		"ideal_antag_optin_status" = ideal_antag_optin_status, // Our opt-in status from prefs when we joined the game
		"current_antag_optin_status" = current_antag_optin_status, // What it's being forced to if applicable
	)
	return data

/datum/examine_panel/ui_static_data(mob/user)
	var/list/data = list(
		"veteran_status" = SSplayer_ranks.is_veteran(holder.client, admin_bypass = FALSE),
		"opt_in_colors" = GLOB.antag_opt_in_colors,
	)
	return data

