/datum/dynamic_ruleset/midround/from_living/autotraitor/proc/optin(candidates)
	message_admins("Polling [candidates.len] people to become a Sleeper Agent")
	var/list/mob/living/candidates_pruned = SSpolling.poll_candidates(
		question = "Do you want to be a syndicate sleeper agent?",
		group = candidates,
		poll_time = 20 SECONDS,
		flash_window = TRUE,
		start_signed_up = FALSE,
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

	return candidates_pruned
