/// Prompts the parent mob to send a say message to the soulcatcher. Returns False if no soulcatcher or message could be found.
GAME_VERB_PROC_DESC(/mob/living, soulcatcher_say, "Soul Say", "Send a Say message to your currently targeted soulcatcher room.", "IC")
	var/datum/component/soulcatcher/target_soulcatcher = find_soulcatcher()
	if(!target_soulcatcher || !target_soulcatcher.targeted_soulcatcher_room)
		return FALSE

	var/message_to_send = tgui_input_text(usr, "Input the message you want to send", "Soulcatcher", multiline = TRUE)
	if(!message_to_send)
		return FALSE

	target_soulcatcher.targeted_soulcatcher_room.send_message(message_to_send, target_soulcatcher.targeted_soulcatcher_room.outside_voice)
	return TRUE

/// Prompts the parent mob to send a emote to the soulcatcher. Returns False if no soulcatcher or emote could be found.
GAME_VERB_PROC_DESC(/mob/living, soulcatcher_emote, "Soul Me", "Send an emote to your currently targeted soulcatcher room.", "IC")
	var/datum/component/soulcatcher/target_soulcatcher = find_soulcatcher()
	if(!target_soulcatcher || !target_soulcatcher.targeted_soulcatcher_room)
		return FALSE

	var/message_to_send = tgui_input_text(usr, "Input the emote you want to send", "Soulcatcher", max_length = MAX_MESSAGE_LEN, multiline = TRUE)
	if(!message_to_send)
		return FALSE

	target_soulcatcher.targeted_soulcatcher_room.send_message(message_to_send, target_soulcatcher.targeted_soulcatcher_room.outside_voice, TRUE)
	return TRUE

/// Attempts to find and return the soulcatcher the parent mob is currently using. If none can be found, returns `FALSE`
/mob/living/proc/find_soulcatcher()
	var/obj/item/soulcatcher_holder/soul_holder = locate(/obj/item/soulcatcher_holder) in contents
	if(QDELETED(soul_holder))
		return FALSE

	var/datum/component/soulcatcher/target_soulcatcher = soul_holder.GetComponent(/datum/component/soulcatcher)
	if(QDELETED(target_soulcatcher))
		return FALSE

	return target_soulcatcher

/mob/living/carbon/human/find_soulcatcher()
	. = ..()
	if(.) // No need to go searching further if we've already found one.
		return .

	var/datum/nifsoft/soulcatcher/souclatcher_nifsoft = find_nifsoft(/datum/nifsoft/soulcatcher)
	if(QDELETED(souclatcher_nifsoft))
		return FALSE

	var/datum/component/soulcatcher/target_soulcatcher = souclatcher_nifsoft.linked_soulcatcher.resolve()
	if(QDELETED(target_soulcatcher))
		return FALSE

	return target_soulcatcher
