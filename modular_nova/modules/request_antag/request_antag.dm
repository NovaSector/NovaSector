/mob/dead/observer/proc/request_antag()
	var/static/list/midround_events_cache = subtypesof(/datum/dynamic_ruleset/midround/from_ghosts)
	var/list/midround_events = list()
	for(var/datum/dynamic_ruleset/event as anything in midround_events_cache)
		LAZYADDASSOC(midround_events, event.name, event)

	var/event_request_name = tgui_input_list(src, "Which antag would you like to request? Note, if granted - you are not guaranteed to win the roll.", "Choose Midround", midround_events)
	var/datum/dynamic_ruleset/midround/from_ghosts/requested_event = LAZYACCESS(midround_events, event_request_name)

	var/event_icon = new /mutable_appearance(requested_event.signup_atom_appearance)
	message_admins("[ADMIN_LOOKUP(src)] has requested [icon2html(event_icon, world)] [LOWER_TEXT(requested_event.name)]! <a href='byond://?_src_=holder;[HrefToken()];requestantag=[REF(requested_event)]'>Trigger?</a>")
