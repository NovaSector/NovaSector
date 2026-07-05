/mob/verb/do_verb(message as message)
	set name = "Do"
	set category = "IC"
	set instant = TRUE

	if(GLOB.say_disabled)
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(message)
		QUEUE_OR_CALL_VERB_FOR(VERB_CALLBACK(src, TYPE_VERB_REF(/mob/living, do_actual_verb), message), SSspeech_controller)

/mob/living/verb/do_actual_verb(message as message)
	if (!message || !doverb_checks(message))
		return

	if(!CAN_BYPASS_FILTER(usr))
		var/list/filter_result = is_ic_filtered(message)

		if(filter_result)
			to_chat(usr, span_warning("That emote contained a word prohibited in IC emotes! Consider reviewing the server rules.\n\"[message]\""))
			REPORT_CHAT_FILTER_TO_USER(usr, filter_result)
			log_filter("IC Emote", message, filter_result)
			SSblackbox.record_feedback("tally", "ic_blocked_words", 1, LOWER_TEXT(config.ic_filter_regex.match))
			return FALSE

		filter_result = is_soft_ic_filtered(message)

		if(filter_result)
			if(tgui_alert(usr, "Your emote contains \"[filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to emote it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
				SSblackbox.record_feedback("tally", "soft_ic_blocked_words", 1, LOWER_TEXT(config.soft_ic_filter_regex.match))
				log_filter("Soft IC Emote", message, filter_result)
				return FALSE

			message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for emote \"[filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Emote: \"[html_encode(message)]\"")
			log_admin_private("[key_name(usr)] has passed the soft filter for emote \"[filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Emote: \"[message]\"")
			SSblackbox.record_feedback("tally", "passed_soft_ic_blocked_words", 1, LOWER_TEXT(config.soft_ic_filter_regex.match))
			log_filter("Soft IC Emote (Passed)", message, filter_result)

	if(usr.client?.prefs?.muted & MUTE_IC)
		to_chat(usr, span_boldwarning("You cannot send IC messages (muted)."))
		return

	var/name_stub = " (<b>[usr]</b>)"
	message = usr.apply_message_emphasis(message)
	message = trim(copytext_char(message, 1, (MAX_MESSAGE_LEN - length(name_stub))))
	var/message_with_name = message + name_stub

	usr.log_message(message, LOG_EMOTE)

	var/list/viewers = get_hearers_in_view(DEFAULT_MESSAGE_RANGE, usr)

	if(istype(usr, /mob/living/silicon/ai))
		var/mob/living/silicon/ai/ai = usr
		viewers = get_hearers_in_view(DEFAULT_MESSAGE_RANGE, ai.eyeobj)

	var/obj/effect/overlay/holo_pad_hologram/hologram = GLOB.hologram_impersonators[usr]
	if(hologram)
		viewers |= get_hearers_in_view(1, hologram)

	for(var/mob/living/silicon/ai/ai as anything in GLOB.ai_list)
		if(ai.client && !(ai in viewers) && (ai.eyeobj in viewers))
			viewers += ai

	for(var/mob/ghost as anything in GLOB.dead_mob_list)
		if((ghost.client?.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(ghost in viewers))
			ghost.show_message(span_emote(message_with_name))

	for(var/mob/receiver in viewers)
		receiver.show_message(span_emote(message_with_name), alt_msg = span_emote(message_with_name))
		if (receiver.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
			receiver.create_chat_message(usr, null, message, null, EMOTE_MESSAGE)
