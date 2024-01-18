// This NV quirk variant applies color_offsets night vision to a mob based on its chosen eye color. (see _eyes.dm)
// Some eye colors will produce very slightly stronger mechanical night vision effects just by virtue of their RGB values being scaled higher (typically lighter colours).

/datum/quirk/night_vision
	desc = "You can see a little better in darkness than most ordinary humanoids. If your eyes are naturally more sensitive to light through other means (such as being photophobic or a mothperson), this effect is significantly stronger."
	medical_record_text = "Patient's visual sensory organs demonstrate non-standard performance in low-light conditions."
	var/nv_color = null /// Holds the player's selected night vision colour

/datum/quirk/night_vision/add_unique(client/client_source)
	. = ..()
	nv_color = client_source?.prefs.read_preference(/datum/preference/color/nv_color)
	refresh_quirk_holder_eyes() // make double triple dog sure we apply the overlay

/datum/quirk_constant_data/night_vision
	associated_typepath = /datum/quirk/night_vision
	customization_options = list(/datum/preference/color/nv_color)

// Client preference for night vision colour
/datum/preference/color/nv_color
	savefile_key = "nv_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/color/nv_color/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Night Vision" in preferences.all_quirks

/datum/preference/color/nv_color/apply_to_human(mob/living/carbon/human/target, value)
	return
