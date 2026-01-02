// Secondary voice for the Voice Actor quirk
/datum/preference/choiced/voice_actor
	savefile_key = "voice_actor"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/voice_actor/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	if(SStts.tts_enabled)
		return TRUE

/datum/preference/choiced/voice_actor/apply_to_human()
	return

/datum/preference/choiced/voice_actor/create_default_value()
	return "Random"

/datum/preference/choiced/voice_actor/is_valid(value)
	if(value == "Random")
		return TRUE
	if(value in get_choices())
		return TRUE
	return FALSE

/datum/preference/choiced/voice_actor/init_possible_values()
	// Create a cache of available TTS voices to use later
	if(!length(GLOB.tts_voice_list))
		if(SStts.tts_enabled)
			GLOB.tts_voice_list.Insert(0, SStts.available_speakers)
		else if(fexists("data/cached_tts_voices.json"))
			var/list/tts_voices_json = json_decode(rustg_file_read("data/cached_tts_voices.json"))
			if(length(tts_voices_json))
				GLOB.tts_voice_list.Insert(0, tts_voices_json)
	if(length(GLOB.tts_voice_list))
		return list("Random") + GLOB.tts_voice_list
	return list("Random")

// Secondary voice pitch
/datum/preference/numeric/tts_voice_pitch/voice_actor
	savefile_key = "voice_actor_pitch"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/numeric/tts_voice_pitch/voice_actor/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	if(SStts.pitch_enabled)
		return TRUE

/datum/preference/numeric/tts_voice_pitch/voice_actor/create_default_value()
	return 0

/datum/preference/numeric/tts_voice_pitch/voice_actor/apply_to_human(mob/living/carbon/human/target, value)
	return

// Secondary chat color
/datum/preference/color/voice_actor_color
	savefile_key = "voice_actor_color"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/voice_actor_color/apply_to_human()
	return

/datum/preference/color/voice_actor_color/create_default_value()
	return process_chat_color("#[random_color()]")

// Subtypes of blooper preferences for the Voice Actor quirk
/datum/preference/choiced/vocals/blooper/voice_actor
	savefile_key = "voice_actor_blooper"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/choiced/vocals/blooper/voice_actor/init_possible_values()
	var/list/blooper_list = ..()
	return list("Random") + blooper_list

/datum/preference/choiced/vocals/blooper/voice_actor/create_default_value()
	return "Random"

/datum/preference/choiced/vocals/blooper/voice_actor/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return TRUE

/datum/preference/choiced/vocals/blooper/voice_actor/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences) // don't apply this to people who don't have it enabled
	return

/datum/preference/numeric/blooper_speech_speed/voice_actor
	savefile_key = "voice_actor_blooper_speech_speed"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/numeric/blooper_speech_speed/voice_actor/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return TRUE

/datum/preference/numeric/blooper_speech_speed/voice_actor/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/blooper_speech_pitch/voice_actor
	savefile_key = "voice_actor_blooper_speech_pitch"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/numeric/blooper_speech_pitch/voice_actor/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return TRUE

/datum/preference/numeric/blooper_speech_pitch/voice_actor/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/blooper_pitch_range/voice_actor
	savefile_key = "voice_actor_blooper_pitch_range"
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/numeric/blooper_pitch_range/voice_actor/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE
	return TRUE

/datum/preference/numeric/blooper_pitch_range/voice_actor/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return
