GLOBAL_LIST_INIT(rejected_traitor, list())
GLOBAL_LIST_INIT(debug_dynamic_be_antag_disabled, list()) //This wont stick around, just for debugging purposes but i need it for now

/**
 * Polls a group of candidates to see if they want to be a sleeper agent.
 *
 * @param candidates a list containing a candidate mobs
 */
/datum/dynamic_ruleset/midround/from_living/autotraitor/proc/poll_candidates_for_one(candidates)
	message_admins("Attempting to poll [length(candidates)] people individually to become a Sleeper Agent...first one to say yes gets chosen.")
	var/list/potential_candidates = shuffle(candidates)
	var/list/yes_candidate = list()
	for(var/mob/living/candidate in potential_candidates)
		potential_candidates -= candidate
		sleeper_current_polling += candidate
		yes_candidate += SSpolling.poll_candidates(
		question = "Do you want to be a syndicate sleeper agent?",
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
			GLOB.rejected_traitor += candidate
			sleeper_current_polling -= candidate

	return yes_candidate
