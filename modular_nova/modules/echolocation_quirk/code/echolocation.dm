/datum/quirk/echolocation
	name = "Echolocation"
	desc = "Though your eyes no longer function, you accomodate for it by some means of extrasensory echolocation and sensitive hearing. Beware: if you're ever deafened, you'll also lose your echolocation until you recover!"
	gain_text = span_notice("The slightest sounds map your surroundings.")
	lose_text = span_notice("The world resolves into colour and clarity.")
	value = 0
	icon = FA_ICON_EAR_LISTEN
	mob_trait = TRAIT_GOOD_HEARING
	medical_record_text = "Patient's eyes are biologically nonfunctional. Hearing tests indicate almost supernatural acuity."
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	mail_goodies = list(/obj/item/clothing/glasses/sunglasses, /obj/item/cane/white)
	var/datum/component/echolocation/esp // where we store easy access to the character's echolocation component (for stuff like drugs)
	var/datum/client_colour/esp_color // where we store access to the client colour we make

/datum/quirk/echolocation/add(client/client_source)
	// echolocation component handles blinding us already so we don't need to worry about that
	var/mob/living/carbon/human/human_holder = quirk_holder
	// set up the desired echo group from our quirk preferences
	var/client_echo_group = lowertext(client_source?.prefs.read_preference(/datum/preference/choiced/echolocation_key))
	if (isnull(client_echo_group))
		client_echo_group = "echolocation"
	if (client_echo_group == "psychic")
		client_echo_group = "psyker" // set this non-player-facing so they share echolocation with coded chaplain psykers/pirates and the like

	var/client_use_echo = client_source?.prefs.read_preference(/datum/preference/toggle/echolocation_overlay)
	if (isnull(client_use_echo))
		client_use_echo = TRUE

	///datum/client_colour/monochrome/blind
	human_holder.AddComponent(/datum/component/echolocation, blocking_trait = TRAIT_DEAF, echo_range = 5, echo_group = client_echo_group, images_are_static = FALSE, use_echo = client_use_echo, show_own_outline = TRUE) //echolocation has now blinded us and added this on, so remove it
	esp = human_holder.GetComponent(/datum/component/echolocation)

	// the way this works is: client colours need a type path, a datum we make is not a type path.
	// so we just take the colour we get from players and update the /datum/client_colour/monochrome/blind that the
	// echolocation blinding gives us, thus applying the effect. it's jank but whatever
	if (length(human_holder.client_colours))
		// HEY! we probably need something to make sure they don't set a color that's too dark or their UI could be totally invisible.
		// GOOD NEWS! we can re-use the runechat colour stuff for this (probably)
		var/col = process_chat_color(client_source?.prefs.read_preference(/datum/preference/color/echolocation_outline))
		var/datum/client_colour/monochrome/blind/blind_col = human_holder.client_colours[1]
		blind_col.priority = 1 // mirrors PRIORITY_ABSOLUTE def inside client_color.dm, stops pipes and stuff showing as different colours
		blind_col.update_colour(col)
		esp_color = blind_col

	// double the ear/hearing damage multiplier from any source.
	var/obj/item/organ/internal/ears/echo_ears = human_holder.get_organ_slot(ORGAN_SLOT_EARS)
	if (!istype(echo_ears))
		return

	echo_ears.damage_multiplier *= 2

/datum/quirk/echolocation/remove()
	esp.Destroy() // echolocation component removal handles graceful disposal of everything above except the ears
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/internal/ears/echo_ears = human_holder.get_organ_slot(ORGAN_SLOT_EARS)
	if (!istype(echo_ears))
		return
	echo_ears.damage_multiplier = initial(echo_ears.damage_multiplier)

/datum/quirk_constant_data/echolocation
	associated_typepath = /datum/quirk/echolocation
	customization_options = list(/datum/preference/color/echolocation_outline, /datum/preference/choiced/echolocation_key, /datum/preference/toggle/echolocation_overlay)

// Client preference for echolocation outline colour
/datum/preference/color/echolocation_outline
	savefile_key = "echolocation_outline"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/color/echolocation_outline/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/color/echolocation_outline/apply_to_human(mob/living/carbon/human/target, value)
	return

// Client preference for echolocation key type
/datum/preference/choiced/echolocation_key
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "echolocation_key"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/echolocation_key/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/choiced/echolocation_key/init_possible_values()
	var/list/values = list("Extrasensory", "Psychic", "Auditory/Vibrational")
	return values

/datum/preference/choiced/echolocation_key/apply_to_human(mob/living/carbon/human/target, value)
	return

// Client preference for whether we display the echolocation overlay or not
/datum/preference/toggle/echolocation_overlay
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "echolocation_use_echo"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/toggle/echolocation_overlay/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/toggle/echolocation_overlay/apply_to_human(mob/living/carbon/human/target, value)
	return
