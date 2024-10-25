/datum/quirk/voice_actor
	name = "Voice Actor"
	desc = "You are able to change your TTS voice to a different style."
	icon = FA_ICON_MICROPHONE_LINES
	lose_text = span_warning("You suddenly forget what your other voice sounds like...")
	value = 4
	veteran_only = TRUE
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/voice_actor/add(client/client_source)
	var/datum/action/innate/alter_voice/voice_action = new
	voice_action.Grant(quirk_holder)

/datum/quirk/voice_actor/remove()
	var/datum/action/action_to_remove = locate(/datum/action/innate/alter_voice) in quirk_holder.actions
	if(action_to_remove)
		qdel(action_to_remove)
