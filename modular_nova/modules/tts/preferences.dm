/datum/preference/numeric/tts_voice_pitch/on_value_update(datum/preferences/prefs, new_value)
	var/mob/living/carbon/human/target_mob = prefs.parent?.mob
	if (!target_mob)
		return FALSE

	if (!SStts.tts_enabled || !SStts.pitch_enabled)
		return FALSE

	target_mob.pitch = new_value
