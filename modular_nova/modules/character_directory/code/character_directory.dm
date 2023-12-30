GLOBAL_DATUM(character_directory, /datum/character_directory)
#define READ_PREFS(target, pref) (target.client.prefs.read_preference(/datum/preference/pref) || "Unset")

//We want players to be able to decide whether they show up in the directory or not
/datum/preference/toggle/show_in_directory
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE
	savefile_key = "show_in_directory"
	savefile_identifier = PREFERENCE_PLAYER

//The advertisement that you show to people looking through the directory
/datum/preference/text/character_ad
	savefile_key = "character_ad"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	maximum_value_length = MAX_FLAVOR_LEN

//TGUI gets angry if you don't define a default on text preferences
/datum/preference/text/character_ad/create_default_value()
	return ""

//Any text preference needs this for some reason
/datum/preference/text/character_ad/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/attraction
	savefile_key = "attraction"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/attraction/init_possible_values()
	return list("Gay", "Lesbian", "Straight", "Skolio", "Bi", "Pan", "Poly", "Omni", "Ace", "Unset", "Check OOC")

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
//Can't believe Bubberstation invented attraction and gender in the year December 2023

//Add a cooldown for the character directory to the client, primarily to stop server lag from refresh spam
/client
	COOLDOWN_DECLARE(char_directory_cooldown)

//Make a verb to open the character directory
/client/verb/show_character_directory()
	set name = "Character Directory"
	set category = "OOC"
	set desc = "Shows a listing of all active characters, along with their associated OOC notes, flavor text, and more."

	// This is primarily to stop malicious users from trying to lag the server by spamming this verb
	if(!COOLDOWN_FINISHED(src, char_directory_cooldown))
		to_chat(src, span_alert("Hold your horses! Its still refreshing!"))
		return
	COOLDOWN_START(src, char_directory_cooldown, 10)

//Check if there's not already a character directory open; open a new one if one is not present
	if(!GLOB.character_directory)
		GLOB.character_directory = new
	GLOB.character_directory.ui_interact(mob)

// This is a global singleton. Keep in mind that all operations should occur on user, not src.
/datum/character_directory

/datum/character_directory/ui_state(mob/user)
	return GLOB.always_state

/datum/character_directory/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NovaCharacterDirectory", "Character Directory")
		ui.open()

//We want this information to update any time the player updates their preferences, not just when the panel is refreshed
/datum/character_directory/ui_data(mob/user)
	. = ..()
	var/list/data = .
