///Action for voice_actor quirk
/datum/action/innate/alter_voice
	name = "Swap Voice"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "swap"
	check_flags = AB_CHECK_CONSCIOUS
	/// The chat color of the primary voice
	var/primary_color = COLOR_WHITE
	/// The chat color of the secondary voice
	var/secondary_color = COLOR_WHITE

	/// The primary voice, aka the initial voice
	var/primary_voice
	/// The pitch of the primary voice
	var/primary_pitch = 0

	/// The secondary voice that can be swapped to/from at will
	var/secondary_voice
	/// The secondary voice's pitch
	var/secondary_pitch = 0

	/// The primary vocal blooper, aka the initial blooper
	var/primary_blooper
	/// The talking speed of the primary blooper
	var/primary_blooper_speed = 0
	/// The pitch of the primary blooper
	var/primary_blooper_pitch = 0
	/// The pitch range of the primary blooper
	var/primary_blooper_pitch_range = 0

	/// The secondary vocal blooper that can be swapped to/from at will
	var/secondary_blooper
	/// The talking speed of the secondary blooper
	var/secondary_blooper_speed = 0
	/// The pitch of the secondary blooper
	var/secondary_blooper_pitch = 0
	/// The pitch range of the secondary blooper
	var/secondary_blooper_pitch_range = 0

/datum/action/innate/alter_voice/Grant(mob/grant_to)
	. = ..()
	if(grant_to != owner)
		return
	// Set up primary runechat color
	primary_color = grant_to.chat_color
	// Set up primary voice
	primary_voice = grant_to.voice
	primary_pitch = grant_to.pitch
	// Set up primary blooper
	primary_blooper = grant_to.blooper_id
	primary_blooper_speed = grant_to.blooper_speed
	primary_blooper_pitch = grant_to.blooper_pitch
	primary_blooper_pitch_range = grant_to.blooper_pitch_range
	// Attempt to set up secondary voice and blooper
	setup_preferences(grant_to)

/datum/action/innate/alter_voice/Remove(mob/remove_from)
	if(active && (remove_from == owner))
		set_primary_voice()
	return ..()

/datum/action/innate/alter_voice/Activate()
	swap_voice()

/datum/action/innate/alter_voice/Deactivate()
	swap_voice()

///Sets up the secondary chat color, TTS voice, and blooper variables.
/datum/action/innate/alter_voice/proc/setup_preferences(mob/actor)
	if(!actor.client)
		return
	var/datum/preferences/prefs = actor.client.prefs

	// Set up secondary color
	secondary_color = prefs.read_preference(/datum/preference/color/voice_actor_color)
	// Set up secondary pitch
	secondary_pitch = prefs.read_preference(/datum/preference/numeric/tts_voice_pitch/voice_actor)
	// Set up secondary voice
	var/speaker = prefs.read_preference(/datum/preference/choiced/voice_actor)
	if(((speaker == "Random") || !(speaker in GLOB.tts_voice_list)) && length(GLOB.tts_voice_list))
		secondary_voice = pick(GLOB.tts_voice_list)
	else
		secondary_voice = speaker

	// Set up secondary blooper speed
	secondary_blooper_speed = prefs.read_preference(/datum/preference/numeric/blooper_speech_speed/voice_actor)
	// Set up secondary blooper pitch
	secondary_blooper_pitch = prefs.read_preference(/datum/preference/numeric/blooper_speech_pitch/voice_actor)
	// Set up secondary blooper pitch range
	secondary_blooper_pitch_range = prefs.read_preference(/datum/preference/numeric/blooper_pitch_range/voice_actor)
	// Set up secondary blooper
	var/blooper = prefs.read_preference(/datum/preference/choiced/vocals/blooper/voice_actor)
	if(blooper == "Random" || !(blooper in GLOB.blooper_list))
		secondary_blooper = pick(GLOB.blooper_random_list)
	else
		secondary_blooper = blooper

///Swaps between primary and secondary chat colors, TTS voices, and bloopers
/datum/action/innate/alter_voice/proc/swap_voice()
	// If client didn't exist when action was granted, it should exist now.
	if(isnull(secondary_voice) || isnull(secondary_blooper))
		setup_preferences(owner)
	active = !active
	if(active)
		set_secondary_voice()
		to_chat(owner, span_green("You are now voice acting."))
	else
		set_primary_voice()
		to_chat(owner, span_green("You have stopped voice acting."))
	owner.balloon_alert(owner, "voice changed")
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

///Swaps to the Voice Actor quirk's secondary chat color, TTS voice, and blooper
/datum/action/innate/alter_voice/proc/set_secondary_voice()
	owner.apply_preference_chat_color(secondary_color)
	if(!isnull(secondary_voice))
		owner.voice = secondary_voice
		owner.pitch = secondary_pitch
	if(!isnull(secondary_blooper))
		owner.set_blooper(secondary_blooper)
		owner.blooper_pitch = secondary_blooper_pitch
		owner.blooper_pitch_range = secondary_blooper_pitch_range
		owner.blooper_speed = secondary_blooper_speed

///Swaps to the user's original primary chat color, TTS voice, and blooper
/datum/action/innate/alter_voice/proc/set_primary_voice()
	owner.apply_preference_chat_color(primary_color)
	owner.voice = primary_voice
	owner.pitch = primary_pitch
	owner.set_blooper(primary_blooper)
	owner.blooper_pitch = primary_blooper_pitch
	owner.blooper_pitch_range = primary_blooper_pitch_range
	owner.blooper_speed = primary_blooper_speed
