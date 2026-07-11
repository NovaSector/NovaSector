/datum/preference_middleware/tts/New(datum/preferences)
	. = ..()
	action_delegations += list(
		"play_second_voice" = PROC_REF(play_second_voice),
	)

///Plays a preview of the second voice for the Voice Actor quirk
/datum/preference_middleware/tts/proc/play_second_voice(list/params, mob/user)
	if(!COOLDOWN_FINISHED(src, tts_test_cooldown))
		return TRUE
	var/speaker = preferences.read_preference(/datum/preference/choiced/voice_actor)
	var/pitch = preferences.read_preference(/datum/preference/numeric/tts_voice_pitch/voice_actor)
	COOLDOWN_START(src, tts_test_cooldown, 0.5 SECONDS)
	INVOKE_ASYNC(SStts, TYPE_PROC_REF(/datum/controller/subsystem/tts, queue_tts_message), user.client, "Hello, this is my secondary voice.", speaker = speaker, pitch = pitch, local = TRUE)
	return TRUE
