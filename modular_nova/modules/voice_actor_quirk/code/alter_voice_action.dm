/datum/action/innate/alter_voice
	name = "Swap Voice"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "swap"
	check_flags = AB_CHECK_CONSCIOUS
	var/primary_voice
	var/primary_pitch
	var/secondary_voice
	var/secondary_pitch

/datum/action/innate/alter_voice/proc/setup_voices(mob/actor)
	// Set up pitches
	if(SStts.pitch_enabled)
		primary_pitch = actor.pitch
		secondary_pitch = actor.client.prefs.read_preference(/datum/preference/numeric/voice_actor_pitch)
	// Set up voices
	primary_voice = actor.voice
	var/speaker = actor.client.prefs.read_preference(/datum/preference/choiced/voice_actor)
	if((speaker == "Random") || !(speaker in SStts.available_speakers))
		secondary_voice = pick(SStts.available_speakers)
	else
		secondary_voice = speaker

/datum/action/innate/alter_voice/Grant(mob/grant_to)
	if(!SStts.tts_enabled)
		return
	. = ..()
	if(grant_to != owner)
		return
	// Setup voices later if the client doesn't exist
	if(grant_to.client)
		setup_voices(grant_to)

/datum/action/innate/alter_voice/Remove(mob/remove_from)
	if(remove_from == owner)
		remove_from.voice = primary_voice
		remove_from.pitch = primary_pitch
	return ..()

/datum/action/innate/alter_voice/IsAvailable(feedback = FALSE)
	return SStts.tts_enabled

/datum/action/innate/alter_voice/Activate()
	// If client didn't exist when action was granted, it should exist now
	if(!primary_voice || !secondary_voice)
		if(!owner.client)
			return
		setup_voices()
	swap_voice(owner)
	active = !active

/// Swaps between primary_voice and secondary_voice
/datum/action/innate/alter_voice/proc/swap_voice(mob/actor)
	if(active)
		actor.voice = primary_voice
		actor.pitch = primary_pitch
	else
		actor.voice = secondary_voice
		actor.pitch = secondary_pitch
