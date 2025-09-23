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
			message_admins("[ADMIN_LOOKUPFLW(player)] has taken on [player.p_their()] operative alias, [player.p_their()] previous name was [old_name].")
		if("Random alias")
			player.fully_replace_character_name(player.real_name, "[pick(GLOB.operative_aliases)] [syndicate_name()]")
			player.playsound_local(player, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)
			message_admins("[ADMIN_LOOKUPFLW(player)] has taken on a random name, [player.p_their()] previous name was [old_name].")
		else
			player.playsound_local(player, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)


/datum/dynamic_ruleset/midround/from_living/traitor
	var/static/list/sleeper_current_polling = list()
	var/static/list/rejected_traitor = list()

/datum/dynamic_ruleset/midround/from_living/traitor/collect_candidates()
	var/list/candidates = ..()
	candidates = shuffle(trim_candidates(candidates))
	return poll_candidates_for_one(candidates)

/**
 * Polls a group of candidates to see if they want to be a sleeper agent.
 *
 * @param candidates a list containing a candidate mobs
 */
/datum/dynamic_ruleset/midround/from_living/traitor/proc/poll_candidates_for_one(candidates)
	message_admins("Attempting to poll [length(candidates)] people individually to become a Sleeper Agent...first one to say yes gets chosen.")
	var/list/potential_candidates = shuffle(candidates)
	var/list/yes_candidate = list()
	for(var/mob/living/candidate in potential_candidates)
		potential_candidates -= candidate
		sleeper_current_polling += candidate
		yes_candidate += SSpolling.poll_candidates(
		question = "Do you want to be a syndicate sleeper agent? If you ignore this, you will be considered to have declined and will be inelegible for all future rolls this round.",
		group = list(candidate),
		poll_time = 15 SECONDS,
		flash_window = TRUE,
		start_signed_up = FALSE,
		announce_chosen = FALSE,
		role_name_text = "Sleeper Agent",
		alert_pic = /obj/structure/sign/poster/contraband/gorlex_recruitment,
		custom_response_messages = list(
			POLL_RESPONSE_SIGNUP = "You have signed up to be a traitor!",
			POLL_RESPONSE_ALREADY_SIGNED = "You are already signed up to be a traitor.",
			POLL_RESPONSE_NOT_SIGNED = "You aren't signed up to be a traitor.",
			POLL_RESPONSE_TOO_LATE_TO_UNREGISTER = "It's too late to decide against being a traitor.",
			POLL_RESPONSE_UNREGISTERED = "You decide against being a traitor.",
		),
		chat_text_border_icon = /obj/structure/sign/poster/contraband/gorlex_recruitment,
	)
		if(length(yes_candidate))
			sleeper_current_polling -= candidate
			break
		else
			message_admins("Candidate [candidate] has declined to be a sleeper agent.")
			rejected_traitor += candidate
			sleeper_current_polling -= candidate

	return yes_candidate
