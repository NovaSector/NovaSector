/datum/quirk/voice_actor
	name = "Voice Actor"
	desc = "You are able to change your TTS voice to a different style."
	icon = FA_ICON_MICROPHONE_LINES
	gain_text = span_notice("You are reminded of how your other voice sounds.")
	lose_text = span_warning("You suddenly forget what your other voice sounds like!")
	medical_record_text = ""
	value = 4
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/voice_actor/add(client/client_source)
	var/datum/action/innate/alter_voice/voice_action = new
	voice_action.Grant(quirk_holder)

/datum/quirk/voice_actor/remove()
	var/datum/action/action_to_remove = locate(/datum/action/innate/alter_voice) in quirk_holder.actions
	if(action_to_remove)
		qdel(action_to_remove)
