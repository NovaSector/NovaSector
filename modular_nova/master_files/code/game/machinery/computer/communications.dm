/// Are we the AI?
/obj/machinery/computer/communications/proc/authenticated_as_ai_or_captain(mob/user)
	if (isAI(user))
		return TRUE
	return ACCESS_CAPTAIN in authorize_access
