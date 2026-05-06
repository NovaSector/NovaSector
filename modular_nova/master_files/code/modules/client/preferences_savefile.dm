/**
 * This is a cheap replica of the standard savefile version, only used for characters for now.
 * You can't really use the non-modular version, least you eventually want asinine merge
 * conflicts and/or potentially disastrous issues to arise, so here's your own.
 */
#define MODULAR_SAVEFILE_VERSION_MAX 18

#define MODULAR_SAVEFILE_UP_TO_DATE -1

#define VERSION_GENITAL_TOGGLES 1
#define VERSION_BREAST_SIZE_CHANGE 2
#define VERSION_SYNTH_REFACTOR 3
#define VERSION_UNDERSHIRT_BRA_SPLIT 4
#define VERSION_CHRONOLOGICAL_AGE 5
#define VERSION_TG_LOADOUT 6
#define VERSION_INTERNAL_EXTERNAL_ORGANS 7
#define VERSION_SKRELL_HAIR_NAME_UPDATE 8
#define VERSION_TG_EMOTE_SOUNDS 9
#define VERSION_CAT_EARS_DUPES 10
#define VERSION_LOADOUT_PRESETS 12
#define VERSION_EMO_LONG_REMOVAL 13
#define VERSION_TOOLKIT_IMPLANTS 14
#define VERSION_VOCAL_BARKS 15
#define VERSION_FEATHERY_WINGS_FIX 16
#define VERSION_DONK_MIGRATION 17
#define VERSION_AUGMENT_ITEMS_PATH_CHANGE 18

#define INDEX_UNDERWEAR 1
#define INDEX_BRA 2

/**
 * Checks if the modular side of the savefile is up to date.
 * If the return value is higher than 0, update_character_nova() will be called later.
 */
/datum/preferences/proc/savefile_needs_update_nova(list/save_data)
	var/savefile_version = save_data["modular_version"]

	if(save_data.len && savefile_version < MODULAR_SAVEFILE_VERSION_MAX)
		return savefile_version

	return MODULAR_SAVEFILE_UP_TO_DATE


/// Loads the modular customizations of a character from the savefile
/datum/preferences/proc/load_character_nova(list/save_data)
	if(!save_data)
		save_data = list()

	var/needs_nova_update = savefile_needs_update_nova(save_data)

	load_augments(SANITIZE_LIST(save_data["augments"]), needs_nova_update)

	augment_limb_styles = SANITIZE_LIST(save_data["augment_limb_styles"])
	for(var/key in augment_limb_styles)
		if(!GLOB.robotic_styles_list[augment_limb_styles[key]])
			augment_limb_styles -= key

	body_markings = update_markings(SANITIZE_LIST(save_data["body_markings"]))
	mismatched_customization = save_data["mismatched_customization"]
	allow_advanced_colors = save_data["allow_advanced_colors"]

	alt_job_titles = save_data["alt_job_titles"]

	general_record = sanitize_text(general_record)
	security_record = sanitize_text(security_record)
	medical_record = sanitize_text(medical_record)
	background_info = sanitize_text(background_info)
	exploitable_info = sanitize_text(exploitable_info)

	var/list/save_languages = SANITIZE_LIST(save_data["languages"])
	for(var/language in save_languages)
		var/value = save_languages[language]
		save_languages -= language

		if(istext(language))
			language = text2path(language)
		save_languages[language] = value
	languages = save_languages

	tgui_prefs_migration = save_data["tgui_prefs_migration"]
	if(!tgui_prefs_migration && save_data.len) // If save_data is empty, this is definitely a new character
		to_chat(parent, boxed_message(span_redtext("PREFERENCE MIGRATION BEGINNING.\
		\nDO NOT INTERACT WITH YOUR PREFERENCES UNTIL THIS PROCESS HAS BEEN COMPLETED.\
		\nDO NOT DISCONNECT UNTIL THIS PROCESS HAS BEEN COMPLETED.\
		")))
		migrate_nova(save_data)
		addtimer(CALLBACK(src, PROC_REF(check_migration)), 10 SECONDS)


	food_preferences = SANITIZE_LIST(save_data["food_preferences"])

	if(needs_nova_update >= 0)
		update_character_nova(needs_nova_update, save_data) // needs_nova_update == savefile_version if we need an update (positive integer)


/// Brings a savefile up to date with modular preferences. Called if savefile_needs_update_nova() returned a value higher than 0
/datum/preferences/proc/update_character_nova(current_version, list/save_data)
	if(current_version < VERSION_GENITAL_TOGGLES)
		// removed genital toggles, with the new choiced prefs paths as assoc
		var/static/list/old_toggles
		if(!old_toggles)
			old_toggles = list(
				"penis_toggle" = /datum/preference/choiced/genital/penis,
				"testicles_toggle" = /datum/preference/choiced/genital/testicles,
				"vagina_toggle" = /datum/preference/choiced/genital/vagina,
				"womb_toggle" = /datum/preference/choiced/genital/womb,
				"breasts_toggle" = /datum/preference/choiced/genital/breasts,
				"anus_toggle" = /datum/preference/choiced/genital/anus,
			)

		for(var/toggle in old_toggles)
			var/has_genital = save_data[toggle]
			if(!has_genital) // The toggle was off, so we make sure they have it set to the default "None" in the dropdown pref.
				var/datum/preference/genital = GLOB.preference_entries[old_toggles[toggle]]
				write_preference(genital, genital.create_default_value())

		if(save_data["skin_tone_toggle"])
			for(var/pref_type in subtypesof(/datum/preference/toggle/genital_skin_tone))
				write_preference(GLOB.preference_entries[pref_type], TRUE)

	if(current_version < VERSION_BREAST_SIZE_CHANGE)
		var/list/old_breast_prefs
		old_breast_prefs = save_data["breasts_size"]
		if(isnum(old_breast_prefs)) // Can't be too careful
			// You weren't meant to be able to pick sizes over this anyways.
			write_preference(GLOB.preference_entries[/datum/preference/choiced/breasts_size], GLOB.breast_size_translation["[min(old_breast_prefs, 10)]"])

	if(current_version < VERSION_SYNTH_REFACTOR)
		var/old_species = save_data["species"]
		if(istext(old_species) && (old_species in list("synthhuman", "synthliz", "synthmammal", "ipc")))

			var/list/new_color

			if(old_species == "synthhuman")
				write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/synth_chassis], "Human Chassis")
				write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/synth_head], "Human Head")
				// Get human skintone instead of mutant color
				new_color = save_data["skin_tone"]
				new_color = skintone2hex(new_color)
			else if(old_species == "synthliz")
				write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/synth_chassis], "Lizard Chassis")
				write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/synth_head], "Lizard Head")
			if(old_species == "synthmammal")
				write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/synth_chassis], "Mammal Chassis")
				write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/synth_head], "Mammal Head")

			// Sorry, but honestly, you folk might like to browse the IPC screens now they've got previews.
			write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/ipc_screen], "None")
			// Unfortunately, you will get a human last name applied due to load behaviours. Nothing I can do about it.
			write_preference(GLOB.preference_entries[/datum/preference/choiced/species], "synth")

			// If human code hasn't kicked in, grab mutant colour.
			if(!new_color)
				new_color = save_data["mutant_colors_color"]
				if(islist(new_color) && new_color.len > 0)
					new_color = sanitize_hexcolor(new_color[1])
				// Just let validation pick its own value.

			if(new_color)
				write_preference(GLOB.preference_entries[/datum/preference/color/mutant/synth_chassis], new_color)
				write_preference(GLOB.preference_entries[/datum/preference/color/mutant/synth_head], new_color)

	if(current_version < VERSION_UNDERSHIRT_BRA_SPLIT)
		var/static/list/underwear_to_underwear_bra = list(
			"Bikini" = list("Panties - Slim", "Bra"),
			"Lace Bikini" = list("Panties - Thin", "Bra - Thin"),
			"Bralette w/ Boyshorts" = list("Boyshorts (Alt)", "Bra, Sports"),
			"Sports Bra w/ Boyshorts" = list("Boyshorts", "Bra, Sports - Alt"),
			"Strapless Bikini" = list("Panties - Slim", "Strapless Swimsuit Top (Alt)"),
			"Babydoll" = list("Thong - Alt", null), // Got moved to an undershirt, actual underwear part is now a thong.
			"Two-Piece Swimsuit" = list("Panties - Swimsuit", "Swimsuit Top"),
			"Strapless Two-Piece Swimsuit" = list("Panties - Swimsuit", "Strapless Swimsuit Top"),
			"Halter Swimsuit" = list("Panties - Basic", "Bra - Halterneck - (Alt)"),
			"Neko Bikini (White)" = list("Panties - Neko", "Bra - Neko"),
			"Neko Bikini (Black)" = list("Panties - Neko", "Bra - Neko"),
			"UK Biniki" = list("Panties - UK", "Bra - UK"),
		)

		var/current_underwear = save_data["underwear"]
		var/migrated_underwear_bra = underwear_to_underwear_bra[current_underwear]

		if(migrated_underwear_bra)
			var/migrated_color = save_data["underwear_color"]
			var/migrated_underwear = migrated_underwear_bra[INDEX_UNDERWEAR]
			var/migrated_bra = migrated_underwear_bra[INDEX_BRA]

			if(migrated_underwear)
				write_preference(GLOB.preference_entries[/datum/preference/choiced/underwear], migrated_underwear)

			if(migrated_bra)
				write_preference(GLOB.preference_entries[/datum/preference/choiced/bra], migrated_bra)
				write_preference(GLOB.preference_entries[/datum/preference/color/bra_color], migrated_color)

		var/current_undershirt = save_data["undershirt"]

		// This one has a different treatment because it's an underwear that has been moved mainly to an undershirt,
		// ending up as a thong for the underwear part itself. We only want to override the undershirt if there's none,
		// though.
		if(current_underwear == "Babydoll" && current_undershirt == "Nude")
			var/migrated_color = save_data["underwear_color"]

			write_preference(GLOB.preference_entries[/datum/preference/choiced/undershirt], "Babydoll")
			write_preference(GLOB.preference_entries[/datum/preference/color/undershirt_color], migrated_color)

		var/static/list/undershirt_to_bra = list(
			"Bra, Sports" = "Bra, Sports",
			"Sports Bra (Alt)" = "Sports Bra (Alt)",
			"Bra" = "Bra",
			"Bra - Alt" = "Bra - Alt",
			"Bra - Thin" = "Bra - Thin",
			"Bra - Kinky Black" = "Bra - Kinky Black",
			"Bra - Freedom" = "Bra - Freedom",
			"Bra - Commie" = "Bra - Commie",
			"Bra - Bee-kini" = "Bra - Bee-kini",
			"Bra - UK" = "Bra - UK",
			"Bra - Neko" = "Bra - Neko",
			"Bra - Halterneck" = "Bra - Halterneck",
			"Bra - Sports - Alt" = "Bra - Sports - Alt",
			"Bra - Strapless" = "Bra - Strapless",
			"Bra - Latex" = "Bra - Latex",
			"Bra - Striped" = "Bra - Striped",
			"Bra - Sarashi" = "Bra - Sarashi",
			"Fishnet - Sleeved" = "Fishnet - Sleeved",
			"Fishnet - Sleeved (Greyscaled)" = "Fishnet - Sleeved (Greyscaled)",
			"Fishnet - Sleeveless" = "Fishnet - Sleeveless",
			"Fishnet - Sleeveless (Greyscaled)" = "Fishnet - Sleeveless (Greyscaled)",
			"Swimsuit Top" = "Bra - Halterneck - (Alt)",
			"Chastity Bra" = "Chastity Bra",
			"Pasties" = "Pasties",
			"Pasties - Alt" = "Pasties - Alt",
			"Shibari" = "Shibari",
			"Shibari Sleeves" = "Shibari Sleeves",
			"Binder" = "Binder",
			"Binder - Strapless" = "Binder - Strapless",
			"Safekini" = "Safekini",
		)

		var/migrated_bra_from_undershirt = undershirt_to_bra[current_undershirt]

		if(migrated_bra_from_undershirt)
			var/migrated_color = save_data["undershirt_color"]

			write_preference(GLOB.preference_entries[/datum/preference/choiced/bra], migrated_bra_from_undershirt)
			write_preference(GLOB.preference_entries[/datum/preference/color/bra_color], migrated_color)
			write_preference(GLOB.preference_entries[/datum/preference/choiced/undershirt], "Nude")

	// Resets Chronological Age field to default.
	if(current_version < VERSION_CHRONOLOGICAL_AGE)
		write_preference(GLOB.preference_entries[/datum/preference/numeric/chronological_age], read_preference(/datum/preference/numeric/age))

	if(current_version < VERSION_TG_LOADOUT)
		var/list/save_loadout = SANITIZE_LIST(save_data["loadout_list"])
		for(var/loadout in save_loadout)
			var/entry = save_loadout[loadout]
			save_loadout -= loadout

			if(istext(loadout))
				loadout = _text2path(loadout)
			save_loadout[loadout] = entry
		var/loadout_list = sanitize_loadout_list(save_loadout)

		if (length(loadout_list)) // We only want to write these changes down if we're certain that there was anything in that.
			write_preference(GLOB.preference_entries[/datum/preference/loadout], loadout_list)

	if(current_version < VERSION_SKRELL_HAIR_NAME_UPDATE)
		var/list/mutant_bodyparts = SANITIZE_LIST(save_data["mutant_bodyparts"])

		var/datum/mutant_bodypart/mutant_part = mutant_bodyparts[FEATURE_SKRELL_HAIR]
		if(mutant_part)
			var/current_skrell_hair = mutant_part.name

			if(current_skrell_hair == "Male")
				write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/skrell_hair], "Short")
			else if(current_skrell_hair == "Female")
				write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/skrell_hair], "Long")

		// Sets old insect laugh to the merged moth/insect in case character uses it.
	if (current_version < VERSION_TG_EMOTE_SOUNDS)
		var/current_laugh = save_data["character_laugh"]
		var/current_scream = save_data["character_scream"]
		if(current_laugh == "Moth Laugh" || current_laugh == "Insect Laugh")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/laugh], "Insect Laugh (Moth)")
		if(current_scream == "Moth Scream 2")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/scream], "Lizard Scream")

	if (current_version < VERSION_CAT_EARS_DUPES)
		var/current_ears = save_data["feature_ears"]
		if(current_ears == "Cat, Big")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/ears], "Cat (Colorable Inner, Behind Hair)")
		else if(current_ears == "Cat, normal")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/ears], "Cat, Alert")
		else if(current_ears == "Cat, Big (Alt)")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/ears], "Cat (Colorable Inner)")

	if(current_version < VERSION_LOADOUT_PRESETS)
		write_preference(GLOB.preference_entries[/datum/preference/loadout], list("Default" = save_data["loadout_list"]))

	if(current_version < VERSION_EMO_LONG_REMOVAL)
		var/current_hair = save_data["hairstyle_name"]
		if(current_hair == "Emo Long")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/hairstyle], "Long Emo")

	if(current_version < VERSION_VOCAL_BARKS)
		var/current_tts_voice = save_data["tts_voice"]
		if(current_tts_voice != TTS_VOICE_NONE && current_tts_voice != "invalid") // make sure we don't turn off TTS for people who have it on
			write_preference(GLOB.preference_entries[/datum/preference/choiced/vocals/voice_type], "Text-to-speech")

	if(current_version < VERSION_FEATHERY_WINGS_FIX)
		var/current_wings = save_data["feature_wings"]
		if(current_wings == "Moth (Featherful)")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/mutant_choice/wings], "Moth (Feathery)")

	if(current_version < VERSION_DONK_MIGRATION)
		var/current_donk = save_data["feature_penis"]
		if(current_donk != "None")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/genital/penis], current_donk + " (Alt)")
		var/current_pocket = save_data["feature_testicles"]
		if(current_pocket == "Pair")
			write_preference(GLOB.preference_entries[/datum/preference/choiced/genital/testicles], "Pair (Alt)")

/datum/preferences/proc/check_migration()
	if(!tgui_prefs_migration)
		to_chat(parent, boxed_message(span_redtext("CRITICAL FAILURE IN PREFERENCE MIGRATION, REPORT THIS IMMEDIATELY.")))
		message_admins("PREFERENCE MIGRATION: [ADMIN_LOOKUPFLW(parent)] has failed the process for migrating PREFERENCES. Check runtimes.")

/// Saves the modular customizations of a character on the savefile
/datum/preferences/proc/save_character_nova(list/save_data)
	save_data["augments"] = augments
	save_data["augment_limb_styles"] = augment_limb_styles
	save_data["body_markings"] = body_markings
	save_data["mismatched_customization"] = mismatched_customization
	save_data["allow_advanced_colors"] = allow_advanced_colors
	save_data["alt_job_titles"] = alt_job_titles
	save_data["languages"] = languages
	save_data["modular_version"] = MODULAR_SAVEFILE_VERSION_MAX
	save_data["food_preferences"] = food_preferences

/datum/preferences/proc/update_markings(list/markings)
	if (islist(markings))
		for (var/marking in markings)
			for (var/title in markings[marking])
				if (!islist(markings[marking][title]))
					markings[marking][title] = list(sanitize_hexcolor(markings[marking][title]), FALSE)
	return markings

/datum/preferences/proc/load_augments(list/augments_prefs, current_version)
	if(!length(augments_prefs))
		augments = augments_prefs
		return
	if(current_version != MODULAR_SAVEFILE_UP_TO_DATE && current_version < VERSION_AUGMENT_ITEMS_PATH_CHANGE)
		migrate_augment_items(augments_prefs)

	var/list/augments_sanitized = list()
	for(var/aug_slot, augment in augments_prefs)
		var/aug_entry = augment

		if(istext(aug_entry))
			aug_entry = text2path(aug_entry)

		var/datum/augment_item/aug = GLOB.augment_items[aug_entry]
		if(aug)
			augments_sanitized[aug_slot] = aug_entry
	augments = augments_sanitized

/// Migrates everyone's prefs augments over to the new format, (slot, /datum/augment_item)
/datum/preferences/proc/migrate_augment_items(list/augments_prefs)
	var/static/list/path_to_augment
	if(isnull(path_to_augment))
		path_to_augment = list(
			/obj/item/organ/cyberimp/chest/nutriment = /datum/augment_item/implant/chest/nutriment_pump,
			/obj/item/organ/cyberimp/chest/opticalcamo = /datum/augment_item/implant/chest/optical_camo,
			/obj/item/organ/cyberimp/chest/scanner/lite = /datum/augment_item/implant/chest/internal_health_analyzer/lite,
			/obj/item/organ/cyberimp/arm/toolkit/armblade/early/l = /datum/augment_item/implant/l_arm/mantis_blade_left,
			/obj/item/organ/cyberimp/arm/toolkit/power_cord/left_arm = /datum/augment_item/implant/l_arm/charging_implant,
			/obj/item/organ/cyberimp/arm/toolkit/civilian_lighter/left_arm = /datum/augment_item/implant/l_arm/civilian_lighter,
			/obj/item/organ/cyberimp/arm/toolkit/razor_claws/left_arm = /datum/augment_item/implant/l_arm/razor_claws,
			/obj/item/organ/cyberimp/arm/toolkit/adjuster/left_arm = /datum/augment_item/implant/l_arm/adjuster,
			/obj/item/organ/cyberimp/arm/toolkit/bureaucracy/left_arm = /datum/augment_item/implant/l_arm/bureaucracy,
			/obj/item/organ/cyberimp/arm/toolkit/cargo/left_arm = /datum/augment_item/implant/l_arm/cargo,
			/obj/item/organ/cyberimp/arm/toolkit/civilian_barstaff/left_arm = /datum/augment_item/implant/l_arm/civilian_barstaff,
			/obj/item/organ/cyberimp/arm/toolkit/emt_triage/left_arm = /datum/augment_item/implant/l_arm/emt_triage,
			/obj/item/organ/cyberimp/arm/toolkit/blacksteel_forging/left_arm = /datum/augment_item/implant/l_arm/blacksteel_forging,
			/obj/item/organ/cyberimp/arm/toolkit/arc_welder/left_arm = /datum/augment_item/implant/l_arm/arc_welder,
			/obj/item/organ/cyberimp/arm/toolkit/electrical_toolset/left_arm = /datum/augment_item/implant/l_arm/electrical_toolset,
			/obj/item/organ/cyberimp/arm/toolkit/mining_drill/left_arm = /datum/augment_item/implant/l_arm/mining_drill,
			/obj/item/organ/cyberimp/arm/toolkit/armblade/early = /datum/augment_item/implant/r_arm/mantis_blade_right,
			/obj/item/organ/cyberimp/arm/toolkit/power_cord/right_arm = /datum/augment_item/implant/r_arm/charging_implant,
			/obj/item/organ/cyberimp/arm/toolkit/civilian_lighter/right_arm = /datum/augment_item/implant/r_arm/civilian_lighter,
			/obj/item/organ/cyberimp/arm/toolkit/razor_claws/right_arm = /datum/augment_item/implant/r_arm/razor_claws,
			/obj/item/organ/cyberimp/arm/toolkit/adjuster/right_arm = /datum/augment_item/implant/r_arm/adjuster,
			/obj/item/organ/cyberimp/arm/toolkit/bureaucracy/right_arm = /datum/augment_item/implant/r_arm/bureaucracy,
			/obj/item/organ/cyberimp/arm/toolkit/cargo/right_arm = /datum/augment_item/implant/r_arm/cargo,
			/obj/item/organ/cyberimp/arm/toolkit/civilian_barstaff/right_arm = /datum/augment_item/implant/r_arm/civilian_barstaff,
			/obj/item/organ/cyberimp/arm/toolkit/emt_triage/right_arm = /datum/augment_item/implant/r_arm/emt_triage,
			/obj/item/organ/cyberimp/arm/toolkit/blacksteel_forging/right_arm = /datum/augment_item/implant/r_arm/blacksteel_forging,
			/obj/item/organ/cyberimp/arm/toolkit/arc_welder/right_arm = /datum/augment_item/implant/r_arm/arc_welder,
			/obj/item/organ/cyberimp/arm/toolkit/electrical_toolset/right_arm = /datum/augment_item/implant/r_arm/electrical_toolset,
			/obj/item/organ/cyberimp/arm/toolkit/mining_drill/right_arm = /datum/augment_item/implant/r_arm/mining_drill,
			/obj/item/bodypart/head/robot/weak = /datum/augment_item/limb/head/cyborg,
			/obj/item/bodypart/head/robot/weak/greyscale = /datum/augment_item/limb/head/cyborg/greyscale,
			/obj/item/bodypart/chest/robot/weak = /datum/augment_item/limb/chest/cyborg,
			/obj/item/bodypart/chest/robot/weak/greyscale = /datum/augment_item/limb/chest/cyborg/greyscale,
			/obj/item/bodypart/arm/left/robot/surplus = /datum/augment_item/limb/l_arm/prosthetic,
			/obj/item/bodypart/arm/left/robot/surplus/greyscale = /datum/augment_item/limb/l_arm/prosthetic/greyscale,
			/obj/item/bodypart/arm/left/robot/weak = /datum/augment_item/limb/l_arm/cyborg,
			/obj/item/bodypart/arm/left/robot/weak/greyscale = /datum/augment_item/limb/l_arm/cyborg/greyscale,
			/obj/item/bodypart/arm/left/plasmaman = /datum/augment_item/limb/l_arm/plasmaman,
			/obj/item/bodypart/arm/left/ghetto = /datum/augment_item/limb/l_arm/peg,
			/obj/item/bodypart/arm/left/stump = /datum/augment_item/limb/l_arm/stump,
			/obj/item/bodypart/arm/right/robot/surplus = /datum/augment_item/limb/r_arm/prosthetic,
			/obj/item/bodypart/arm/right/robot/surplus/greyscale = /datum/augment_item/limb/r_arm/prosthetic/greyscale,
			/obj/item/bodypart/arm/right/robot/weak = /datum/augment_item/limb/r_arm/cyborg,
			/obj/item/bodypart/arm/right/robot/weak/greyscale = /datum/augment_item/limb/r_arm/cyborg/greyscale,
			/obj/item/bodypart/arm/right/plasmaman = /datum/augment_item/limb/r_arm/plasmaman,
			/obj/item/bodypart/arm/right/ghetto = /datum/augment_item/limb/r_arm/peg,
			/obj/item/bodypart/arm/right/stump = /datum/augment_item/limb/r_arm/stump,
			/obj/item/bodypart/leg/left/robot/surplus = /datum/augment_item/limb/l_leg/prosthetic,
			/obj/item/bodypart/leg/left/robot/surplus/greyscale = /datum/augment_item/limb/l_leg/prosthetic/greyscale,
			/obj/item/bodypart/leg/left/robot/weak = /datum/augment_item/limb/l_leg/cyborg,
			/obj/item/bodypart/leg/left/robot/weak/greyscale = /datum/augment_item/limb/l_leg/cyborg/greyscale,
			/obj/item/bodypart/leg/left/plasmaman = /datum/augment_item/limb/l_leg/plasmaman,
			/obj/item/bodypart/leg/left/ghetto = /datum/augment_item/limb/l_leg/peg,
			/obj/item/bodypart/leg/left/stump = /datum/augment_item/limb/l_leg/stump,
			/obj/item/bodypart/leg/right/robot/surplus = /datum/augment_item/limb/r_leg/prosthetic,
			/obj/item/bodypart/leg/right/robot/surplus/greyscale = /datum/augment_item/limb/r_leg/prosthetic/greyscale,
			/obj/item/bodypart/leg/right/robot/weak = /datum/augment_item/limb/r_leg/cyborg,
			/obj/item/bodypart/leg/right/robot/weak/greyscale = /datum/augment_item/limb/r_leg/cyborg/greyscale,
			/obj/item/bodypart/leg/right/plasmaman = /datum/augment_item/limb/r_leg/plasmaman,
			/obj/item/bodypart/leg/right/ghetto = /datum/augment_item/limb/r_leg/peg,
			/obj/item/bodypart/leg/right/stump = /datum/augment_item/limb/r_leg/stump,
			/obj/item/organ/brain/cybernetic/cortical = /datum/augment_item/organ/brain/cortical,
			/obj/item/organ/heart = /datum/augment_item/organ/heart/normal,
			/obj/item/organ/heart/cybernetic = /datum/augment_item/organ/heart/cybernetic,
			/obj/item/organ/heart/synth = /datum/augment_item/organ/heart/synth,
			/obj/item/organ/lungs = /datum/augment_item/organ/lungs/normal,
			/obj/item/organ/lungs/cybernetic = /datum/augment_item/organ/lungs/cybernetic,
			/obj/item/organ/liver = /datum/augment_item/organ/liver/normal,
			/obj/item/organ/liver/cybernetic = /datum/augment_item/organ/liver/cybernetic,
			/obj/item/organ/liver/synth = /datum/augment_item/organ/liver/synth,
			/obj/item/organ/stomach = /datum/augment_item/organ/stomach/normal,
			/obj/item/organ/stomach/cybernetic = /datum/augment_item/organ/stomach/cybernetic,
			/obj/item/organ/stomach/lithovore = /datum/augment_item/organ/stomach/lithovore,
			/obj/item/organ/eyes = /datum/augment_item/organ/eyes/normal,
			/obj/item/organ/eyes/robotic = /datum/augment_item/organ/eyes/cybernetic,
			/obj/item/organ/eyes/robotic/moth = /datum/augment_item/organ/eyes/cybernetic/moth,
			/obj/item/organ/eyes/robotic/glow = /datum/augment_item/organ/eyes/highlumi,
			/obj/item/organ/eyes/robotic/glow/moth = /datum/augment_item/organ/eyes/highlumi/moth,
			/obj/item/organ/eyes/robotic/binoculars = /datum/augment_item/organ/eyes/binoculars,
			/obj/item/organ/cyberimp/mouth/breathing_tube = /datum/augment_item/organ/mouth/breathing_tube,
			/obj/item/organ/cyberimp/mouth/breathing_tube/hidden = /datum/augment_item/organ/mouth/breathing_tube/hidden,
			/obj/item/organ/tongue/human = /datum/augment_item/organ/tongue/normal,
			/obj/item/organ/tongue/robot = /datum/augment_item/organ/tongue/robo,
			/obj/item/organ/tongue/lizard/robot = /datum/augment_item/organ/tongue/robo/forked,
			/obj/item/organ/tongue/cybernetic = /datum/augment_item/organ/tongue/cybernetic,
			/obj/item/organ/tongue/lizard/cybernetic = /datum/augment_item/organ/tongue/cybernetic/forked,
			/obj/item/organ/tongue/lizard = /datum/augment_item/organ/tongue/forked,
			/obj/item/organ/tongue/lizard/filterless = /datum/augment_item/organ/tongue/forked/filterless,
			/obj/item/organ/ears = /datum/augment_item/organ/ears/normal,
			/obj/item/organ/ears/cybernetic = /datum/augment_item/organ/ears/cybernetic,
			/obj/item/organ/ears/cat/cybernetic = /datum/augment_item/organ/ears/cybernetic/cat,
			/obj/item/organ/ears/cat/cybernetic/blue = /datum/augment_item/organ/ears/cybernetic/cat/blue,
			/obj/item/organ/ears/cat/cybernetic/green = /datum/augment_item/organ/ears/cybernetic/cat/green,
			/obj/item/bodypart/head/mutant = /datum/augment_item/limb/head/species/mutant,
			/obj/item/bodypart/chest/mutant = /datum/augment_item/limb/chest/species/mutant,
			/obj/item/bodypart/arm/left/mutant = /datum/augment_item/limb/l_arm/species/mutant,
			/obj/item/bodypart/arm/right/mutant = /datum/augment_item/limb/r_arm/species/mutant,
			/obj/item/bodypart/leg/left/mutant = /datum/augment_item/limb/l_leg/species/mutant,
			/obj/item/bodypart/leg/right/mutant = /datum/augment_item/limb/r_leg/species/mutant,
			/obj/item/bodypart/head/mutant/akula = /datum/augment_item/limb/head/species/akula,
			/obj/item/bodypart/chest/mutant/akula = /datum/augment_item/limb/chest/species/akula,
			/obj/item/bodypart/arm/left/mutant/akula = /datum/augment_item/limb/l_arm/species/akula,
			/obj/item/bodypart/arm/right/mutant/akula = /datum/augment_item/limb/r_arm/species/akula,
			/obj/item/bodypart/leg/left/mutant/akula = /datum/augment_item/limb/l_leg/species/akula,
			/obj/item/bodypart/leg/right/mutant/akula = /datum/augment_item/limb/r_leg/species/akula,
			/obj/item/bodypart/head/mutant/aquatic = /datum/augment_item/limb/head/species/mutant/aquatic,
			/obj/item/bodypart/chest/mutant/aquatic = /datum/augment_item/limb/chest/species/mutant/aquatic,
			/obj/item/bodypart/arm/left/mutant/aquatic = /datum/augment_item/limb/l_arm/species/mutant/aquatic,
			/obj/item/bodypart/arm/right/mutant/aquatic = /datum/augment_item/limb/r_arm/species/mutant/aquatic,
			/obj/item/bodypart/leg/left/mutant/aquatic = /datum/augment_item/limb/l_leg/species/mutant/aquatic,
			/obj/item/bodypart/leg/right/mutant/aquatic = /datum/augment_item/limb/r_leg/species/mutant/aquatic,
			/obj/item/bodypart/head/mutant/insect = /datum/augment_item/limb/head/species/insect,
			/obj/item/bodypart/chest/mutant/insect = /datum/augment_item/limb/chest/species/insect,
			/obj/item/bodypart/arm/left/mutant/insect = /datum/augment_item/limb/l_arm/species/insect,
			/obj/item/bodypart/arm/right/mutant/insect = /datum/augment_item/limb/r_arm/species/insect,
			/obj/item/bodypart/leg/left/mutant/insect = /datum/augment_item/limb/l_leg/species/insect,
			/obj/item/bodypart/leg/right/mutant/insect = /datum/augment_item/limb/r_leg/species/insect,
			/obj/item/bodypart/head/lizard = /datum/augment_item/limb/head/species/mutant/lizard,
			/obj/item/bodypart/chest/lizard = /datum/augment_item/limb/chest/species/mutant/lizard,
			/obj/item/bodypart/arm/left/lizard = /datum/augment_item/limb/l_arm/species/mutant/lizard,
			/obj/item/bodypart/arm/right/lizard = /datum/augment_item/limb/r_arm/species/mutant/lizard,
			/obj/item/bodypart/leg/left/lizard = /datum/augment_item/limb/l_leg/species/mutant/lizard,
			/obj/item/bodypart/leg/right/lizard = /datum/augment_item/limb/r_leg/species/mutant/lizard,
			/obj/item/bodypart/head/fly = /datum/augment_item/limb/head/fly,
			/obj/item/bodypart/chest/fly = /datum/augment_item/limb/chest/fly,
			/obj/item/bodypart/arm/left/fly = /datum/augment_item/limb/l_arm/fly,
			/obj/item/bodypart/arm/right/fly = /datum/augment_item/limb/r_arm/fly,
			/obj/item/bodypart/leg/left/fly = /datum/augment_item/limb/l_leg/fly,
			/obj/item/bodypart/leg/right/fly = /datum/augment_item/limb/r_leg/fly,
			/obj/item/bodypart/head/golem = /datum/augment_item/limb/head/golem,
			/obj/item/bodypart/chest/golem = /datum/augment_item/limb/chest/golem,
			/obj/item/bodypart/arm/left/golem = /datum/augment_item/limb/l_arm/golem,
			/obj/item/bodypart/arm/right/golem = /datum/augment_item/limb/r_arm/golem,
			/obj/item/bodypart/leg/left/golem = /datum/augment_item/limb/l_leg/golem,
			/obj/item/bodypart/leg/right/golem = /datum/augment_item/limb/r_leg/golem,
			/obj/item/bodypart/head/jelly/slime/roundstart = /datum/augment_item/limb/head/species/mutant/slime,
			/obj/item/bodypart/chest/jelly/slime/roundstart = /datum/augment_item/limb/chest/species/mutant/slime,
			/obj/item/bodypart/arm/left/jelly/slime/roundstart = /datum/augment_item/limb/l_arm/species/mutant/slime,
			/obj/item/bodypart/arm/right/jelly/slime/roundstart = /datum/augment_item/limb/r_arm/species/mutant/slime,
			/obj/item/bodypart/leg/left/jelly/slime/roundstart = /datum/augment_item/limb/l_leg/species/mutant/slime,
			/obj/item/bodypart/leg/right/jelly/slime/roundstart = /datum/augment_item/limb/r_leg/species/mutant/slime,
			/obj/item/bodypart/head/moth = /datum/augment_item/limb/head/species/moth,
			/obj/item/bodypart/chest/moth = /datum/augment_item/limb/chest/species/moth,
			/obj/item/bodypart/arm/left/moth = /datum/augment_item/limb/l_arm/species/moth,
			/obj/item/bodypart/arm/right/moth = /datum/augment_item/limb/r_arm/species/moth,
			/obj/item/bodypart/leg/left/moth = /datum/augment_item/limb/l_leg/species/moth,
			/obj/item/bodypart/leg/right/moth = /datum/augment_item/limb/r_leg/species/moth,
			/obj/item/bodypart/head/mushroom = /datum/augment_item/limb/head/species/mushroom,
			/obj/item/bodypart/chest/mushroom = /datum/augment_item/limb/chest/species/mushroom,
			/obj/item/bodypart/arm/left/mushroom = /datum/augment_item/limb/l_arm/species/mushroom,
			/obj/item/bodypart/arm/right/mushroom = /datum/augment_item/limb/r_arm/species/mushroom,
			/obj/item/bodypart/leg/left/mushroom = /datum/augment_item/limb/l_leg/species/mushroom,
			/obj/item/bodypart/leg/right/mushroom = /datum/augment_item/limb/r_leg/species/mushroom,
			/obj/item/bodypart/head/pod = /datum/augment_item/limb/head/species/pod,
			/obj/item/bodypart/chest/pod = /datum/augment_item/limb/chest/species/pod,
			/obj/item/bodypart/arm/left/pod = /datum/augment_item/limb/l_arm/species/pod,
			/obj/item/bodypart/arm/right/pod = /datum/augment_item/limb/r_arm/species/pod,
			/obj/item/bodypart/leg/left/pod = /datum/augment_item/limb/l_leg/species/pod,
			/obj/item/bodypart/leg/right/pod = /datum/augment_item/limb/r_leg/species/pod,
			/obj/item/bodypart/head = /datum/augment_item/limb/head/species/human,
			/obj/item/bodypart/chest = /datum/augment_item/limb/chest/species/human,
			/obj/item/bodypart/arm/left = /datum/augment_item/limb/l_arm/species/human,
			/obj/item/bodypart/arm/right = /datum/augment_item/limb/r_arm/species/human,
			/obj/item/bodypart/leg/left = /datum/augment_item/limb/l_leg/species/human,
			/obj/item/bodypart/leg/right = /datum/augment_item/limb/r_leg/species/human,
			/obj/item/bodypart/leg/left/human_digi_capable = /datum/augment_item/limb/l_leg/species/human_digi_capable,
			/obj/item/bodypart/leg/right/human_digi_capable = /datum/augment_item/limb/r_leg/species/human_digi_capable,
			/obj/item/bodypart/head/ethereal = /datum/augment_item/limb/head/species/ethereal,
			/obj/item/bodypart/chest/ethereal = /datum/augment_item/limb/chest/species/ethereal,
			/obj/item/bodypart/arm/left/ethereal = /datum/augment_item/limb/l_arm/species/ethereal,
			/obj/item/bodypart/arm/right/ethereal = /datum/augment_item/limb/r_arm/species/ethereal,
			/obj/item/bodypart/leg/left/ethereal = /datum/augment_item/limb/l_leg/species/ethereal,
			/obj/item/bodypart/leg/right/ethereal = /datum/augment_item/limb/r_leg/species/ethereal,
			/obj/item/bodypart/head/mutant/skrell = /datum/augment_item/limb/head/species/skrell,
			/obj/item/bodypart/chest/mutant/skrell = /datum/augment_item/limb/chest/species/skrell,
			/obj/item/bodypart/arm/left/mutant/skrell = /datum/augment_item/limb/l_arm/species/skrell,
			/obj/item/bodypart/arm/right/mutant/skrell = /datum/augment_item/limb/r_arm/species/skrell,
			/obj/item/bodypart/leg/left/mutant/skrell = /datum/augment_item/limb/l_leg/species/skrell,
			/obj/item/bodypart/leg/right/mutant/skrell = /datum/augment_item/limb/r_leg/species/skrell,
			/obj/item/bodypart/head/mutant/vox = /datum/augment_item/limb/head/species/mutant/vox,
			/obj/item/bodypart/chest/mutant/vox = /datum/augment_item/limb/chest/species/mutant/vox,
			/obj/item/bodypart/arm/left/mutant/vox = /datum/augment_item/limb/l_arm/species/mutant/vox,
			/obj/item/bodypart/arm/right/mutant/vox = /datum/augment_item/limb/r_arm/species/mutant/vox,
			/obj/item/bodypart/leg/left/mutant/vox = /datum/augment_item/limb/l_leg/species/mutant/vox,
			/obj/item/bodypart/leg/right/mutant/vox = /datum/augment_item/limb/r_leg/species/mutant/vox,
			/obj/item/bodypart/head/mutant/xenohybrid = /datum/augment_item/limb/head/species/mutant/xenohybrid,
			/obj/item/bodypart/chest/mutant/xenohybrid = /datum/augment_item/limb/chest/species/mutant/xenohybrid,
			/obj/item/bodypart/arm/left/mutant/xenohybrid = /datum/augment_item/limb/l_arm/species/mutant/xenohybrid,
			/obj/item/bodypart/arm/right/mutant/xenohybrid = /datum/augment_item/limb/r_arm/species/mutant/xenohybrid,
			/obj/item/bodypart/leg/left/digitigrade/xenohybrid = /datum/augment_item/limb/l_leg/species/mutant/xenohybrid,
			/obj/item/bodypart/leg/right/digitigrade/xenohybrid = /datum/augment_item/limb/r_leg/species/mutant/xenohybrid,
			/obj/item/bodypart/head/mutant/ramatae = /datum/augment_item/limb/head/species/mutant/ramatae,
			/obj/item/bodypart/head/mutant/ramatae/eyes = /datum/augment_item/limb/head/species/mutant/ramatae/eyes,
			/obj/item/bodypart/chest/mutant/ramatae = /datum/augment_item/limb/chest/species/mutant/ramatae,
			/obj/item/bodypart/arm/left/mutant/ramatae = /datum/augment_item/limb/l_arm/species/mutant/ramatae,
			/obj/item/bodypart/arm/right/mutant/ramatae = /datum/augment_item/limb/r_arm/species/mutant/ramatae,
			/obj/item/bodypart/leg/left/mutant/ramatae = /datum/augment_item/limb/l_leg/species/mutant/ramatae,
			/obj/item/bodypart/leg/right/mutant/ramatae = /datum/augment_item/limb/r_leg/species/mutant/ramatae,
			/obj/item/bodypart/head/mutant/shadekin = /datum/augment_item/limb/head/species/shadekin,
			/obj/item/bodypart/chest/mutant/shadekin = /datum/augment_item/limb/chest/species/shadekin,
			/obj/item/bodypart/arm/left/mutant/shadekin = /datum/augment_item/limb/l_arm/species/shadekin,
			/obj/item/bodypart/arm/right/mutant/shadekin = /datum/augment_item/limb/r_arm/species/shadekin,
			/obj/item/bodypart/leg/left/mutant/shadekin = /datum/augment_item/limb/l_leg/species/shadekin,
			/obj/item/bodypart/leg/right/mutant/shadekin = /datum/augment_item/limb/r_leg/species/shadekin,
			/obj/item/bodypart/leg/left/mutant/harpy = /datum/augment_item/limb/l_leg/species/mutant/harpy,
			/obj/item/bodypart/leg/right/mutant/harpy = /datum/augment_item/limb/r_leg/species/mutant/harpy,
			/obj/item/bodypart/leg/left/mutant/harpy_skin = /datum/augment_item/limb/l_leg/species/harpy,
			/obj/item/bodypart/leg/right/mutant/harpy_skin = /datum/augment_item/limb/r_leg/species/harpy,
			/obj/item/bodypart/leg/left/robot/surplus/digi = /datum/augment_item/limb/l_leg/digi_prosthetic,
			/obj/item/bodypart/leg/left/robot/digi = /datum/augment_item/limb/l_leg/digi_cybernetic,
			/obj/item/bodypart/leg/right/robot/surplus/digi = /datum/augment_item/limb/r_leg/digi_prosthetic,
			/obj/item/bodypart/leg/right/robot/digi = /datum/augment_item/limb/r_leg/digi_cybernetic,
			/obj/item/bodypart/head/robot/teshari = /datum/augment_item/limb/head/teshari_cyborg,
			/obj/item/bodypart/chest/robot/teshari = /datum/augment_item/limb/chest/teshari_cyborg,
			/obj/item/bodypart/arm/left/robot/teshari_surplus = /datum/augment_item/limb/l_arm/teshari_prosthetic,
			/obj/item/bodypart/arm/left/robot/teshari = /datum/augment_item/limb/l_arm/teshari_cybernetic,
			/obj/item/bodypart/arm/right/robot/teshari_surplus = /datum/augment_item/limb/r_arm/teshari_prosthetic,
			/obj/item/bodypart/arm/right/robot/teshari = /datum/augment_item/limb/r_arm/teshari_cybernetic,
			/obj/item/bodypart/leg/left/robot/teshari_surplus = /datum/augment_item/limb/l_leg/teshari_prosthetic,
			/obj/item/bodypart/leg/left/robot/teshari = /datum/augment_item/limb/l_leg/teshari_cybernetic,
			/obj/item/bodypart/leg/right/robot/teshari_surplus = /datum/augment_item/limb/r_leg/teshari_prosthetic,
			/obj/item/bodypart/leg/right/robot/teshari = /datum/augment_item/limb/r_leg/teshari_cybernetic,
		)
	var/list/to_remove
	for(var/slot, path in augments_prefs)
		var/new_path = path_to_augment[istext(path) ? text2path(path) : path]
		if(new_path)
			augments_prefs[slot] = new_path
		else
			LAZYADD(to_remove, slot)
	for(var/slot in to_remove)
		augments_prefs -= slot

#undef MODULAR_SAVEFILE_VERSION_MAX
#undef MODULAR_SAVEFILE_UP_TO_DATE

#undef VERSION_GENITAL_TOGGLES
#undef VERSION_BREAST_SIZE_CHANGE
#undef VERSION_SYNTH_REFACTOR
#undef VERSION_UNDERSHIRT_BRA_SPLIT
#undef VERSION_CHRONOLOGICAL_AGE
#undef VERSION_TG_LOADOUT
#undef VERSION_INTERNAL_EXTERNAL_ORGANS
#undef VERSION_SKRELL_HAIR_NAME_UPDATE
#undef VERSION_TG_EMOTE_SOUNDS
#undef VERSION_CAT_EARS_DUPES
#undef VERSION_LOADOUT_PRESETS
#undef VERSION_EMO_LONG_REMOVAL
#undef VERSION_TOOLKIT_IMPLANTS
#undef VERSION_VOCAL_BARKS
#undef VERSION_FEATHERY_WINGS_FIX
#undef VERSION_DONK_MIGRATION
#undef VERSION_AUGMENT_ITEMS_PATH_CHANGE
