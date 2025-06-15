/atom/movable
	// Text-to-blooper sounds
	// yes. all atoms can have a say.

	/// Which sound is selected
	var/sound/blooper
	/// The ID of the blooper
	var/blooper_id
	/// Pitch of the soundd
	var/blooper_pitch = 1
	/// Range of the blooper sound
	var/blooper_pitch_range = 0.2 //Actual pitch is (pitch - (blooper_pitch_range*0.5)) to (pitch + (blooper_pitch_range*0.5))
	/// Volume of the blooper sound
	var/blooper_volume = 50
	/// Speed of the blooper sound
	var/blooper_speed = 4 //Lower values are faster, higher values are slower
	/// When bloopers are queued, this gets passed to the blooper proc. If blooper_current_blooper doesn't match the args passed to the blooper proc (if passed at all), then the blooper simply doesn't play. Basic curtailing of spam~
	var/blooper_current_blooper

/// Sets thee blooper's ID
/atom/movable/proc/set_blooper(id)
	if(!id)
		return FALSE
	var/datum/blooper/base_bloop = GLOB.blooper_list[id]
	if(isnull(base_bloop))
		return FALSE
	blooper = sound(initial(base_bloop.soundpath))
	blooper_id = id
	return blooper

/// Proc for Voice Bloopers
/atom/movable/proc/blooper(list/listeners, distance, volume, pitch, queue_time)
	/// Checks if bloopere is alllowed
	if(!GLOB.blooper_allowed)
		return
	/// Checks if blooper is queued or not
	if(queue_time && blooper_current_blooper != queue_time)
		return
	if(!blooper)
		if(!blooper_id || !set_blooper(blooper_id)) //just-in-time blooper generation
			return
	volume = min(volume, 100)
	var/turf/our_turf = get_turf(src)
	for(var/mob/mob_with_client in listeners)
		if(!mob_with_client.client)
			return
		var/user_volume_pref = mob_with_client.client.prefs.read_preference(/datum/preference/numeric/volume/sound_blooper_volume) // If we have a client adjust the volume to their prefs before playing the blooper
		var/scaled_volume = volume * (user_volume_pref / 100)
		mob_with_client.playsound_local(our_turf, vol = scaled_volume, vary = TRUE, frequency = pitch, max_distance = distance, falloff_distance = 0, falloff_exponent = BLOOPER_SOUND_FALLOFF_EXPONENT, sound_to_use = blooper, distance_multiplier = 1)

/// Sends blooping sound/data
/atom/movable/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language, list/message_mods = list(), forced = FALSE, tts_message, list/tts_filter)
	. = ..()
	var/list/listeners = get_hearers_in_view(range, source)
	if(blooper || blooper_id)
		for(var/mob/mob_with_client in listeners)
			if(!mob_with_client.client)
				continue
			if(!(mob_with_client.client.prefs?.read_preference(/datum/preference/toggle/hear_sound_blooper)))
				listeners -= mob_with_client
		var/bloopers = min(round((LAZYLEN(message) / blooper_speed)) + 1, BLOOPER_MAX_BLOOPERS)
		var/total_delay
		blooper_current_blooper = world.time //this is juuuuust random enough to reliably be unique every time send_speech() is called, in most scenarios
		for(var/blooperinteger in 1 to bloopers)
			if(total_delay > BLOOPER_MAX_TIME)
				break
			addtimer(CALLBACK(src, PROC_REF(blooper), listeners, range, blooper_volume, BLOOPER_DO_VARY(blooper_pitch, blooper_pitch_range), blooper_current_blooper), total_delay)
			total_delay += rand(DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE), DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE) + DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE)) TICKS


/// Initializes Voice_Bark
/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	/// This gives a random vocal bark to a random created person
	if(!client)
		set_blooper(pick(GLOB.blooper_list))
		blooper_pitch = BLOOPER_PITCH_RAND(gender)
		blooper_pitch_range = BLOOPER_VARIANCE_RAND
		blooper_speed = rand(BLOOPER_DEFAULT_MINSPEED, BLOOPER_DEFAULT_MAXSPEED)

/// Sends speech from a living mob
/mob/living/send_speech(message_raw, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language = null, list/message_mods = list(), forced = null, tts_message, list/tts_filter)
	. = ..()

	var/voice_type_pref = client?.prefs.read_preference(/datum/preference/choiced/vocals/voice_type)
	if(voice_type_pref != VOICE_TYPE_BARK)
		if((!SStts.tts_enabled && voice_type_pref == VOICE_TYPE_TTS) && client?.prefs.read_preference(/datum/preference/toggle/fallback_to_blooper))
			play_bloopers(message_raw, message_range, source, message_mods) // if and only if we are using tts and fallback is enabled, we can bloop
		return
	play_bloopers(message_raw, message_range, source, message_mods)

/// Plays the blooper sound effect based on the message provided
/mob/living/proc/play_bloopers(message_raw, message_range, obj/source, list/message_mods = list())
	if(HAS_TRAIT(src, TRAIT_SIGN_LANG) && !HAS_TRAIT(src, TRAIT_MUTE)) //if you can speak and you sign, your hands don't make a bark. Unless you are completely mute, you can have some hand bark.
		return
	var/blooper_volume_to_use = blooper_volume
	if(message_mods[WHISPER_MODE])
		blooper_volume_to_use *= 0.5 //Whispered barked are half as loud.
		message_range++
	var/list/listening = get_hearers_in_view(message_range, source)
	var/is_yell = (say_test(message_raw) == "2")
	//Listening gets trimmed here if a blooper blooper's present. If anyone ever makes this proc return listening, make sure to instead initialize a copy of listening in here to avoid wonkiness
	if(blooper || blooper_id)
		for(var/mob/listener in listening)
			if(!listener.client)
				continue

			var/hear_blooper = listener.client.prefs?.read_preference(/datum/preference/toggle/hear_sound_blooper)

			if(!hear_blooper) // Check pref for blooper
				listening -= listener

		var/bloopers = min(round((LAZYLEN(message_raw) / blooper_speed)) + 1, BLOOPER_MAX_BLOOPERS)
		var/total_delay
		blooper_current_blooper = world.time
		for(var/blooperinteger in 1 to bloopers)
			if(total_delay > BLOOPER_MAX_TIME)
				break
			addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, blooper), listening, message_range + 1, (blooper_volume_to_use * (is_yell ? 2 : 1)), BLOOPER_DO_VARY(blooper_pitch, blooper_pitch_range), blooper_current_blooper), total_delay) //The function is zero on the seventh tile. This makes it a maximum of 1 more.
			total_delay += rand(DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE), DS2TICKS(blooper_speed / BLOOPER_SPEED_BASELINE) + DS2TICKS((blooper_speed / BLOOPER_SPEED_BASELINE) * (is_yell ? 0.5 : 1))) TICKS
