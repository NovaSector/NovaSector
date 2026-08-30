/// Name-change proc to be used for midround antags that would like to change their name
/datum/dynamic_ruleset/midround/from_ghosts/proc/prompt_namechange(mob/living/player, client/player_client)
	if(!player_client)
		return
	var/old_name = player.real_name
	player.playsound_local(player, 'sound/machines/terminal/terminal_prompt.ogg', 50, FALSE)
	window_flash(player_client)
	switch(tgui_alert(
			player,
			"Do you wish to take on an alias?",
			"Change Name?",
			list("Operative alias", "Random alias", "Keep current name"),
			1 MINUTES,
		))
		if("Operative alias")
			player.fully_replace_character_name(player.real_name, "[player_client?.prefs?.read_preference(/datum/preference/name/operative_alias)]")
			player.playsound_local(player, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)
			message_admins("[ADMIN_LOOKUPFLW(player)] has taken on [player.p_their()] operative alias, [player.p_their()] previous name was [html_encode(old_name)].")
		if("Random alias")
			player.fully_replace_character_name(player.real_name, "[pick(GLOB.operative_aliases)] [syndicate_name()]")
			player.playsound_local(player, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)
			message_admins("[ADMIN_LOOKUPFLW(player)] has taken on a random name, [player.p_their()] previous name was [html_encode(old_name)].")
		else
			player.playsound_local(player, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)



/datum/dynamic_ruleset/midround/from_living/collect_candidates()
	var/list/candidates = ..()
	candidates = shuffle(trim_candidates(candidates))
	return poll_candidates(candidates)

/datum/dynamic_ruleset/midround/from_living
	var/midround_ask_question // Optional question asked to candidates for consent before rolling them into a midround antagonist.
	var/midround_ask_alert_pic // Optional alert icon shown alongside the consent poll.
	var/list/midround_custom_response_messages // Optional custom response messages for the consent poll.

/**
 * Individually asks each candidate in the list if they want to become this antagonist,
 * stopping and returning as soon as one accepts.
 */
/datum/dynamic_ruleset/midround/from_living/proc/poll_candidates(list/candidates)
	message_admins("MID-ROUND ANTAG: attempting to poll [length(candidates)] people individually to become [name].")
	var/list/potential_candidates = shuffle(candidates)
	var/list/yes_candidate = list()
	for(var/mob/living/candidate in potential_candidates)
		potential_candidates -= candidate
		yes_candidate += SSpolling.poll_candidates(
			question = midround_ask_question || "Do you want to become [name]?.",
			group = list(candidate),
			poll_time = 60 SECONDS,
			flash_window = TRUE,
			start_signed_up = FALSE,
			announce_chosen = FALSE,
			role_name_text = name,
			alert_pic = midround_ask_alert_pic,
			custom_response_messages = midround_custom_response_messages || list(
				POLL_RESPONSE_SIGNUP = "You have signed up to be a [name]!",
				POLL_RESPONSE_ALREADY_SIGNED = "You are already signed up to be a [name].",
				POLL_RESPONSE_NOT_SIGNED = "You aren't signed up to be a [name].",
				POLL_RESPONSE_TOO_LATE_TO_UNREGISTER = "It's too late to decide against being a [name].",
				POLL_RESPONSE_UNREGISTERED = "You decide against being a [name].",
			),
		)
		if(length(yes_candidate))
			break
		message_admins("Candidate [candidate] has declined to become [name].")
	if(!length(yes_candidate))
		message_admins("Nobody accepted the offer to become [name] - the ruleset will not execute this time.")
	return yes_candidate

/*
 * Midround_ask_question and midround_ask_alert_pic - definations.
*/
/datum/dynamic_ruleset/midround/from_living/malf_ai
	midround_ask_question = "Do you want to become a malfunctioning AI and turn against your Asimov laws?."

/datum/dynamic_ruleset/midround/from_living/blob
	midround_ask_question = "Do you want to become infected and turn into a blob host?."
	midround_ask_alert_pic = /obj/structure/blob/normal

/datum/dynamic_ruleset/midround/from_living/obsesed
	midround_ask_question = "Do you want to become obsessed with another crew member?."

/datum/dynamic_ruleset/midround/from_living/traitor/
	midround_ask_question = "Do you want to be a syndicate sleeper agent?."
	midround_ask_alert_pic = /obj/structure/sign/poster/contraband/gorlex_recruitment
