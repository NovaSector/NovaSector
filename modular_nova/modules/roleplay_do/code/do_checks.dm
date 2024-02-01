/mob/proc/do_checks(message)
	if(!length(message))
		return FALSE

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return FALSE

	//quickly calc our name stub again: duplicate this in say.dm override
	var/name_stub = " (<b>[usr]</b>)"
	if(length(message) > (MAX_MESSAGE_LEN - length(name_stub)))
		to_chat(usr, message)
		to_chat(usr, span_warning("^^^----- The preceeding message has been DISCARDED for being over the maximum length of [MAX_MESSAGE_LEN]. It has NOT been sent! -----^^^"))
		return FALSE

	if(usr.stat == SOFT_CRIT || usr.stat == UNCONSCIOUS || usr.stat == DEAD)
		to_chat(usr, span_notice("You cannot send a Do in your current condition."))
		return FALSE

	return TRUE
