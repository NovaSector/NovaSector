/// Per-character fur color used by the Werewolf quirk's toggle when painting ears / tail / snout
/// / breasts and any other pelt-tinted wolf feature. Manually rendered because it only affects
/// the transformed form, not the base character preview.
/datum/preference/color/werewolf_fur_color
	savefile_key = "werewolf_fur_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	should_update_preview = FALSE

/datum/preference/color/werewolf_fur_color/create_default_value()
	return "#775533"

/datum/preference/color/werewolf_fur_color/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	return /datum/quirk/werewolf::name in preferences.all_quirks

/datum/preference/color/werewolf_fur_color/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/quirk_constant_data/werewolf
	associated_typepath = /datum/quirk/werewolf
	customization_options = list(/datum/preference/color/werewolf_fur_color)
