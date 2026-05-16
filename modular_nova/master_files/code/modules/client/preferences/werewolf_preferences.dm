#define WEREWOLF_SIZE_DELTA_MIN 0
#define WEREWOLF_SIZE_DELTA_MAX 0.5
#define WEREWOLF_SIZE_DELTA_DEFAULT 0.2
#define WEREWOLF_SIZE_DELTA_STEP 0.05

/// Per-character fur color used by the Werewolf quirk's toggle when painting ears / tail / snout /
/// body tint / etc. Manually rendered because it only affects the transformed form, not the
/// base character preview.
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

/// Per-character additive bump applied to `dna.features["body_size"]` on Werewolf transform.
/// Clamped at cast time against `BODY_SIZE_MAX`, so picking the max here just means "grow as
/// much as the engine lets me" for a mob already partway there.
/datum/preference/numeric/werewolf_size_delta
	savefile_key = "werewolf_size_delta"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	minimum = WEREWOLF_SIZE_DELTA_MIN
	maximum = WEREWOLF_SIZE_DELTA_MAX
	step = WEREWOLF_SIZE_DELTA_STEP

/datum/preference/numeric/werewolf_size_delta/create_default_value()
	return WEREWOLF_SIZE_DELTA_DEFAULT

/datum/preference/numeric/werewolf_size_delta/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	return /datum/quirk/werewolf::name in preferences.all_quirks

/datum/preference/numeric/werewolf_size_delta/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/quirk_constant_data/werewolf
	associated_typepath = /datum/quirk/werewolf
	customization_options = list(
		/datum/preference/color/werewolf_fur_color,
		/datum/preference/numeric/werewolf_size_delta,
	)

#undef WEREWOLF_SIZE_DELTA_MIN
#undef WEREWOLF_SIZE_DELTA_MAX
#undef WEREWOLF_SIZE_DELTA_DEFAULT
#undef WEREWOLF_SIZE_DELTA_STEP
