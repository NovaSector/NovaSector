// This NV quirk variant applies color_offsets night vision to a mob based on its chosen eye color.
// Some eye colors will produce very slightly stronger mechanical night vision effects just by virtue of their RGB values being scaled higher (typically lighter colours).

/datum/quirk/night_vision
	desc = "You can see a little better in darkness than most ordinary humanoids. If your eyes are naturally more sensitive to light through other means (such as being photophobic or a mothperson), this effect is significantly stronger."
	medical_record_text = "Patient's visual sensory organs demonstrate non-standard performance in low-light conditions."
	var/nv_color = null /// Holds the player's selected night vision colour
	var/list/nv_color_cutoffs = null /// Contains the color_cutoffs applied to the user's eyes w/ our custom hue (once built)

/datum/quirk/night_vision/add_unique(client/client_source)
	. = ..()
	nv_color = client_source?.prefs.read_preference(/datum/preference/color/nv_color)
	if (isnull(nv_color))
		var/mob/living/carbon/human/human_holder = quirk_holder
		nv_color = process_chat_color(human_holder.eye_color_left)
	nv_color_cutoffs = calculate_color_cutoffs(nv_color)
	refresh_quirk_holder_eyes() // make double triple dog sure we apply the overlay

/// Calculate eye organ color_cutoffs used in tinted night vision with a supplied hexcode colour, clamping and scaling appropriately.
/datum/quirk/night_vision/proc/calculate_color_cutoffs(color)
	var/mob/living/carbon/human/target = quirk_holder

	// if we have more sensitive eyes, increase the power
	var/obj/item/organ/eyes/target_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	if (!istype(target_eyes))
		return
	var/infravision_multiplier = max(0, (-(target_eyes.flash_protect) * NOVA_NIGHT_VISION_SENSITIVITY_MULT)) + 1

	var/list/new_rgb_cutoffs = new /list(3)
	for(var/i in 1 to 3)
		var/base_color = hex2num(copytext(color, (i*2), (i*2)+2)) //convert their supplied hex colour value to RGB
		var/adjusted_color = max(((base_color / 255) * (NOVA_NIGHT_VISION_POWER_MAX * infravision_multiplier)), (NOVA_NIGHT_VISION_POWER_MIN * infravision_multiplier)) //linear convert their eye color into a color_cutoff range, ensuring it is clamped
		new_rgb_cutoffs[i] = adjusted_color

	return new_rgb_cutoffs

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

// run the Blessed Runechat Proc since it does most of what we want regarding luminance clamping anyway. could it be better? probably. is it more work? yes, it's a LOT of work.
/datum/preference/color/nv_color/deserialize(input, datum/preferences/preferences)
	return process_chat_color(sanitize_hexcolor(input))

/datum/preference/color/nv_color/serialize(input)
	return process_chat_color(sanitize_hexcolor(input))

/datum/preference/color/nv_color/create_default_value()
	return process_chat_color("#[random_color()]")
