/obj/item/bodypart
	disabling_threshold_percentage = 1 // Originally: disabling_threshold_percentage = LIMB_NO_DISABLE
	/// The bodypart's currently applied style's name. Only necessary for bodyparts that come in multiple
	/// variants, like prosthetics and cyborg bodyparts.
	var/current_style = null

/obj/item/bodypart/generate_icon_key()
	RETURN_TYPE(/list)
	. = ..()
	if(current_style)
		. += "-[current_style]"

	for(var/key in markings)
		. += limb_id == BODYPART_ID_DIGITIGRADE ? "[BODYPART_ID_DIGITIGRADE]_[body_zone]" : body_zone
		. += "-[key]_[markings[key][MARKING_INDEX_COLOR]]_[markings[key][MARKING_INDEX_EMISSIVE]]"

	return .

/**
 * # This should only be ran by augments, if you don't know what you're doing, you shouldn't be touching this.
 * A setter for the `icon_static` variable of the bodypart. Runs through `icon_exists()` for sanity, and it won't
 * change anything in the event that the check fails.
 *
 * Arguments:
 * * new_icon - The new icon filepath that you want to replace `icon_static` with.
 */
/obj/item/bodypart/proc/set_icon_static(new_icon)
	var/state_to_verify = "[limb_id]_[body_zone][is_dimorphic ? "_[limb_gender]" : ""]"
	if(icon_exists_or_scream(new_icon, state_to_verify))
		icon_static = new_icon

/**
 * # This should only be ran by augments, if you don't know what you're doing, you shouldn't be touching this.
 * A setter for the `icon_greyscale` variable of the bodypart. Runs through `icon_exists()` for sanity, and it won't
 * change anything in the event that the check fails.
 *
 * Arguments:
 * * new_icon - The new icon filepath that you want to replace `icon_greyscale` with.
 */
/obj/item/bodypart/proc/set_icon_greyscale(new_icon)
	var/state_to_verify = "[limb_id]_[body_zone][is_dimorphic ? "_[limb_gender]" : ""]"
	if(icon_exists_or_scream(new_icon, state_to_verify))
		icon_greyscale = new_icon
