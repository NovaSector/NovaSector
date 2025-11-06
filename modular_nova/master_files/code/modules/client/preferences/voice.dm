
/datum/preference/choiced/voice
	category = PREFERENCE_CATEGORY_VOCALS // Originally PREFERENCE_CATEGORY_NON_CONTEXTUAL, we are relocating it to the voice menu

/datum/preference/choiced/voice/is_accessible(datum/preferences/preferences)
	var/voice_type_pref = preferences.read_preference(/datum/preference/choiced/vocals/voice_type)
	if(voice_type_pref != VOICE_TYPE_TTS)
		return FALSE

	return ..(preferences)

/datum/preference/choiced/voice/init_possible_values()
	if(SStts.tts_enabled)
		return list(TTS_VOICE_NONE) + SStts.available_speakers

	if(fexists("data/cached_tts_voices.json"))
		var/list/text_data = rustg_file_read("data/cached_tts_voices.json")
		var/list/cached_data = json_decode(text_data)
		if(!cached_data)
			return list("invalid")

		return list(TTS_VOICE_NONE) + cached_data

	return list("invalid")

/datum/preference/choiced/voice/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(preferences.read_preference(/datum/preference/choiced/vocals/voice_type) != VOICE_TYPE_TTS)
		target.voice = TTS_VOICE_NONE
		return
	if(SStts.tts_enabled && !(value in cached_values))
		value = pick(SStts.available_speakers) // As a failsafe

	target.voice = value == TTS_VOICE_NONE ? "" : value

#undef TTS_VOICE_NONE
