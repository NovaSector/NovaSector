#define VOICE_TYPE_NONE "None"

/datum/preference/numeric/tts_voice_pitch
	category = PREFERENCE_CATEGORY_VOCALS // Originally PREFERENCE_CATEGORY_NON_CONTEXTUAL, we are relocating it to the voice menu

/datum/preference/numeric/tts_voice_pitch/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return
	return (preferences.read_preference(/datum/preference/choiced/vocals/voice_type) == VOICE_TYPE_TTS)

/datum/preference/choiced/vocals
	category = PREFERENCE_CATEGORY_VOCALS
	savefile_identifier = PREFERENCE_CHARACTER
	abstract_type = /datum/preference/choiced/vocals

/datum/preference/choiced/vocals/voice_type
	savefile_key = "voice_type"
	can_randomize = FALSE

/datum/preference/choiced/vocals/voice_type/init_possible_values()
	return list(VOICE_TYPE_TTS, VOICE_TYPE_BARK, VOICE_TYPE_NONE)

/datum/preference/choiced/vocals/voice_type/create_default_value()
	return VOICE_TYPE_NONE

/datum/preference/choiced/vocals/voice_type/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/fallback_to_blooper
	category = PREFERENCE_CATEGORY_VOCALS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "fallback_to_blooper"
	default_value = FALSE
	can_randomize = FALSE
	/// These will be grouped together on the preferences menu
	var/group = "vocals"

/datum/preference/toggle/fallback_to_blooper/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return
	return (preferences.read_preference(/datum/preference/choiced/vocals/voice_type) == VOICE_TYPE_TTS)

/datum/preference/toggle/fallback_to_blooper/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/choiced/vocals/blooper
	category = PREFERENCE_CATEGORY_VOCALS
	savefile_key = "blooper_speech"

/datum/preference/choiced/vocals/blooper/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return
	var/voice_type_pref = preferences.read_preference(/datum/preference/choiced/vocals/voice_type)
	var/datum/preference/toggle/fallback_to_blooper/fallback_pref = GLOB.preference_entries[/datum/preference/toggle/fallback_to_blooper]
	return (voice_type_pref == VOICE_TYPE_BARK || (preferences.read_preference(/datum/preference/toggle/fallback_to_blooper) && fallback_pref.is_accessible(preferences)))

/datum/preference/choiced/vocals/blooper/init_possible_values()
	return assoc_to_keys(GLOB.blooper_list)

/datum/preference/choiced/vocals/blooper/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences) // don't apply this to people who don't have it enabled
	var/voice_type_pref = preferences.read_preference(/datum/preference/choiced/vocals/voice_type)
	if(voice_type_pref == VOICE_TYPE_BARK || (preferences.read_preference(/datum/preference/toggle/fallback_to_blooper)))
		target.set_blooper(value)

/datum/preference/numeric/blooper_speech_speed
	category = PREFERENCE_CATEGORY_VOCALS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_speech_speed"
	minimum = BLOOPER_DEFAULT_MINSPEED
	maximum = BLOOPER_DEFAULT_MAXSPEED
	step = 0.01

/datum/preference/numeric/blooper_speech_speed/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return
	var/voice_type_pref = preferences.read_preference(/datum/preference/choiced/vocals/voice_type)
	var/datum/preference/toggle/fallback_to_blooper/fallback_pref = GLOB.preference_entries[/datum/preference/toggle/fallback_to_blooper]
	return (voice_type_pref == VOICE_TYPE_BARK || (preferences.read_preference(/datum/preference/toggle/fallback_to_blooper) && fallback_pref.is_accessible(preferences)))

/datum/preference/numeric/blooper_speech_speed/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.blooper_speed = value

/datum/preference/numeric/blooper_speech_speed/create_default_value()
	return round((BLOOPER_DEFAULT_MINSPEED + BLOOPER_DEFAULT_MAXSPEED) / 2)

/datum/preference/numeric/blooper_speech_pitch
	category = PREFERENCE_CATEGORY_VOCALS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_speech_pitch"
	minimum = BLOOPER_DEFAULT_MINPITCH
	maximum = BLOOPER_DEFAULT_MAXPITCH
	step = 0.01

/datum/preference/numeric/blooper_speech_pitch/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return
	var/voice_type_pref = preferences.read_preference(/datum/preference/choiced/vocals/voice_type)
	var/datum/preference/toggle/fallback_to_blooper/fallback_pref = GLOB.preference_entries[/datum/preference/toggle/fallback_to_blooper]
	return (voice_type_pref == VOICE_TYPE_BARK || (preferences.read_preference(/datum/preference/toggle/fallback_to_blooper) && fallback_pref.is_accessible(preferences)))

/datum/preference/numeric/blooper_speech_pitch/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.blooper_pitch = value

/datum/preference/numeric/blooper_speech_pitch/create_default_value()
	return round((BLOOPER_DEFAULT_MINPITCH + BLOOPER_DEFAULT_MAXPITCH) / 2)

/datum/preference/numeric/blooper_pitch_range
	category = PREFERENCE_CATEGORY_VOCALS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_pitch_range"
	minimum = BLOOPER_DEFAULT_MINVARY
	maximum = BLOOPER_DEFAULT_MAXVARY
	step = 0.01

/datum/preference/numeric/blooper_pitch_range/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return
	var/voice_type_pref = preferences.read_preference(/datum/preference/choiced/vocals/voice_type)
	var/datum/preference/toggle/fallback_to_blooper/fallback_pref = GLOB.preference_entries[/datum/preference/toggle/fallback_to_blooper]
	return (voice_type_pref == VOICE_TYPE_BARK || (preferences.read_preference(/datum/preference/toggle/fallback_to_blooper) && fallback_pref.is_accessible(preferences)))

/datum/preference/numeric/blooper_pitch_range/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.blooper_pitch_range = value

/datum/preference/numeric/blooper_pitch_range/create_default_value()
	return 0.2

/// Can I hear everyone else's bloops?
/datum/preference/toggle/hear_sound_blooper
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "hear_sound_blooper"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/// Can I have a slider to adjust the volume of the barks?
/datum/preference/numeric/volume/sound_blooper_volume
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "sound_blooper_volume"
	savefile_identifier = PREFERENCE_PLAYER
	maximum = 200

/datum/preference/numeric/volume/sound_blooper_volume/create_default_value()
	return 100

/datum/preference_middleware/blooper
	/// Cooldown on requesting a Blooper preview.
	COOLDOWN_DECLARE(blooper_cooldown)

	action_delegations = list(
		"play_blooper" = PROC_REF(play_blooper),
	)

/datum/preference_middleware/blooper/proc/play_blooper(list/params, mob/user)
	if(!COOLDOWN_FINISHED(src, blooper_cooldown))
		return TRUE
	var/atom/movable/blooperbox = new(get_turf(user))
	blooperbox.set_blooper(preferences.read_preference(/datum/preference/choiced/vocals/blooper))
	blooperbox.blooper_pitch = preferences.read_preference(/datum/preference/numeric/blooper_speech_pitch)
	blooperbox.blooper_speed = preferences.read_preference(/datum/preference/numeric/blooper_speech_speed)
	blooperbox.blooper_pitch_range = preferences.read_preference(/datum/preference/numeric/blooper_pitch_range)
	var/total_delay
	for(var/i in 1 to (round((32 / blooperbox.blooper_speed)) + 1))
		addtimer(CALLBACK(blooperbox, TYPE_PROC_REF(/atom/movable, blooper), list(user), 7, 70, BLOOPER_DO_VARY(blooperbox.blooper_pitch, blooperbox.blooper_pitch_range)), total_delay)
		total_delay += rand(DS2TICKS(blooperbox.blooper_speed/4), DS2TICKS(blooperbox.blooper_speed/4) + DS2TICKS(blooperbox.blooper_speed/4)) TICKS
	QDEL_IN(blooperbox, total_delay)
	COOLDOWN_START(src, blooper_cooldown, 2 SECONDS)
	return TRUE

#undef VOICE_TYPE_NONE
