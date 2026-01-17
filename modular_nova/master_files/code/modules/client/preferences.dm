#define MAX_MUTANT_ROWS 4

/datum/preferences
	/// Associative list, keyed by language typepath, pointing to LANGUAGE_UNDERSTOOD, or LANGUAGE_SPOKEN, for whether we understand or speak the language
	var/list/languages = list()
	/// List of chosen augmentations. It's an associative list with key name of the slot, pointing to a typepath of an augment define
	var/augments = list()
	/// List of chosen preferred styles for limb replacements
	var/augment_limb_styles = list()
	/// Which augment slot we currently have chosen, this is for UI display
	var/chosen_augment_slot
	/// A list of all bodymarkings
	var/list/list/body_markings = list()

	/// Will the person see accessories not meant for their species to choose from
	var/mismatched_customization = FALSE

	/// Allows the user to freely color his body markings and mutant parts.
	var/allow_advanced_colors = FALSE

	/// Preference of how the preview should show the character.
	var/preview_pref = PREVIEW_PREF_JOB

	var/needs_update = TRUE

	var/arousal_preview = AROUSAL_NONE

	// BACKGROUND STUFF
	var/general_record = ""
	var/security_record = ""
	var/medical_record = ""

	var/background_info = ""
	var/exploitable_info = ""

	/// Whether the user wants to see body size being shown in the preview
	var/show_body_size = FALSE

	/// Alternative job titles stored in preferences. Assoc list, ie. alt_job_titles["Scientist"] = "Cytologist"
	var/list/alt_job_titles = list()

	// Determines if the player has undergone TGUI preferences migration, if so, this will prevent constant loading.
	var/tgui_prefs_migration = TRUE

	/// An assoc list of food types to liked or dislike values. If null or empty, default species tastes are used instead on application.
	/// If a food doesn't exist in this list, it uses the default value.
	var/list/food_preferences = list()

/datum/preferences/proc/species_updated(species_type)
	all_quirks = list()
	// Reset cultural stuff
	languages[try_get_common_language()] = LANGUAGE_SPOKEN
	save_character()

/// Tries to get the topmost language of the language holder. Should be the species' native language, and if it isn't, you should pester a coder.
/datum/preferences/proc/try_get_common_language()
	var/datum/species/species_type = read_preference(/datum/preference/choiced/species)
	var/datum/language_holder/language_holder = GLOB.prototype_language_holders[species_type::species_language_holder]
	var/language = language_holder.spoken_languages[1]
	return language

/datum/preferences/proc/CanBuyAugment(datum/augment_item/target_aug, datum/augment_item/current_aug)
	// Check biotypes
	var/species_type = read_preference(/datum/preference/choiced/species)
	var/datum/species/current_species = GLOB.species_prototypes[species_type]
	if(!(current_species.inherent_biotypes & target_aug.allowed_biotypes))
		return
	var/quirk_points = GetQuirkBalance()
	var/leverage = 0
	if(current_aug)
		leverage += current_aug.cost
	if((quirk_points + leverage)>= target_aug.cost)
		return TRUE
	else
		return FALSE

/// This proc saves the damage currently on `character` (human) and reapplies it after `safe_transfer_prefs()` is applied to the `character`.
/datum/preferences/proc/safe_transfer_prefs_to_with_damage(mob/living/carbon/human/character, icon_updates = TRUE, is_antag = FALSE)
	if(!istype(character))
		return FALSE

	var/datum/component/damage_tracker/human/added_tracker = character.AddComponent(/datum/component/damage_tracker/human)
	if(!added_tracker)
		return FALSE

	safe_transfer_prefs_to(character, icon_updates, is_antag)
	qdel(added_tracker)

// Updates the mob's chat color in the global cache
/datum/preferences/safe_transfer_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE, is_antag = FALSE)
	. = ..()
	GLOB.chat_colors_by_mob_name[character.name] = list(character.chat_color, character.chat_color_darkened) // by now the mob has had its prefs applied to it
