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
	if(value == "Random")
		return TRUE
	if(SStts.tts_enabled && (value in SStts.available_speakers))
		return TRUE
	return FALSE

/datum/preference/choiced/voice_actor/init_possible_values()
	if(SStts.tts_enabled)
		var/list/speakers = SStts.available_speakers
		speakers.Insert(1, "Random")
		return speakers
	if(fexists("data/cached_tts_voices.json"))
		var/list/text_data = rustg_file_read("data/cached_tts_voices.json")
		var/list/cached_data = json_decode(text_data)
		if(cached_data)
			cached_data.Insert(1, "Random")
			return cached_data
	return list("Random")

/datum/preference/numeric/voice_actor_pitch
	savefile_key = "voice_actor_pitch"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = -12
	maximum = 12

/datum/preference/numeric/voice_actor_pitch/apply_to_human()
	return

/datum/preference/numeric/voice_actor_pitch/create_default_value()
	return 0
