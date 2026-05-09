/datum/quirk/voice_actor
	name = "Voice Actor"
	desc = "You can swap to a second chat color, TTS voice, and vocal bark."
	icon = FA_ICON_MICROPHONE_LINES
	gain_text = span_notice("You are reminded of how your other voice sounds.")
	lose_text = span_warning("You suddenly forget what your other voice sounds like!")
	medical_record_text = ""
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk_constant_data/voice_actor
	associated_typepath = /datum/quirk/voice_actor
	customization_options = list(
		/datum/preference/color/voice_actor_color,
		/datum/preference/choiced/voice_actor,
		/datum/preference/numeric/tts_voice_pitch/voice_actor,
		/datum/preference/choiced/vocals/blooper/voice_actor,
		/datum/preference/numeric/blooper_speech_speed/voice_actor,
		/datum/preference/numeric/blooper_speech_pitch/voice_actor,
		/datum/preference/numeric/blooper_pitch_range/voice_actor,
	)

/datum/quirk/voice_actor/add(client/client_source)
	var/datum/action/innate/alter_voice/voice_action = new
	voice_action.Grant(quirk_holder)

/datum/quirk/voice_actor/remove()
	var/datum/action/action_to_remove = locate(/datum/action/innate/alter_voice) in quirk_holder.actions
	if(action_to_remove)
		qdel(action_to_remove)
