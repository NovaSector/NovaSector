///Action for voice_actor quirk
/datum/action/innate/alter_voice
	name = "Swap Voice"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "swap"
	check_flags = AB_CHECK_CONSCIOUS
	var/primary_voice
	var/primary_pitch = 0
	var/secondary_voice
	var/secondary_pitch = 0

///Sets up the voice and pitch variables.
/datum/action/innate/alter_voice/proc/setup_second_voice(mob/actor)
	if(!actor.client)
		return
	// Set up secondary pitch
	secondary_pitch = actor.client.prefs.read_preference(/datum/preference/numeric/voice_actor_pitch)
	// Set up secondary voice
	var/speaker = actor.client.prefs.read_preference(/datum/preference/choiced/voice_actor)
	var/list/available_speakers
	if(SStts.tts_enabled)
		available_speakers = SStts.available_speakers
	else if(fexists("data/cached_tts_voices.json"))
		available_speakers = json_decode(rustg_file_read("data/cached_tts_voices.json"))
	if((speaker == "Random") || !(speaker in available_speakers))
		secondary_voice = pick(available_speakers)
	else
		secondary_voice = speaker

///Swaps between primary_voice and secondary_voice
/datum/action/innate/alter_voice/proc/swap_voice(new_status)
	// If client didn't exist when action was granted, it should exist now.
	if(isnull(secondary_voice))
		setup_second_voice(owner)
	// Voice failed to load somehow
	if(isnull(secondary_voice))
		to_chat(owner, span_userdanger("You can't remember your second voice at the moment. (Adminhelp and report this as an issue on github)"))
	if(isnull(new_status))
		new_status = active
	if(active)
		owner.voice = secondary_voice
		owner.pitch = secondary_pitch
		to_chat(owner, span_green("You are now voice acting."))
	else
		owner.voice = primary_voice
		owner.pitch = primary_pitch
		to_chat(owner, span_green("You have stopped voice acting."))
	owner.balloon_alert(owner, "voice changed")
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

/datum/action/innate/alter_voice/Grant(mob/grant_to)
	. = ..()
	if(grant_to != owner)
		return
	// Set up primary pitch
	if(SStts.pitch_enabled)
		primary_pitch = grant_to.pitch
	// Set up primary voice
	primary_voice = grant_to.voice
	setup_second_voice(grant_to)

/datum/action/innate/alter_voice/Remove(mob/remove_from)
	if(remove_from == owner)
		remove_from.voice = primary_voice
		remove_from.pitch = primary_pitch
	return ..()

/datum/action/innate/alter_voice/Activate()
	active = TRUE
	swap_voice(TRUE)

/datum/action/innate/alter_voice/Deactivate()
	active = FALSE
	swap_voice(FALSE)
