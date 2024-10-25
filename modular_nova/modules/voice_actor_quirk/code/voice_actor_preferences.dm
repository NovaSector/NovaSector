/datum/preference/choiced/voice_actor
	savefile_key = "voice_actor"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/voice_actor/apply_to_human()
	return

/datum/preference/choiced/voice_actor/create_default_value()
	return "Random"

/datum/preference/choiced/voice_actor/is_valid(value)
	if(SStts.tts_enabled && (value in SStts.available_speakers))
		return TRUE
	else
		return FALSE

/datum/preference/choiced/voice_actor/init_possible_values()
	if(SStts.tts_enabled)
		return SStts.available_speakers
	if(fexists("data/cached_tts_voices.json"))
		var/list/text_data = rustg_file_read("data/cached_tts_voices.json")
		var/list/cached_data = json_decode(text_data)
		if(!cached_data)
			return list("N/A")
		return cached_data
	return list("N/A")

/datum/preference/numeric/voice_actor_pitch
	savefile_key = "voice_actor_pitch"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = -12
	maximum = 12

/datum/preference/choiced/voice_actor_pitch/apply_to_human()
	return

/datum/preference/numeric/tts_voice_pitch/create_default_value()
	return 0
