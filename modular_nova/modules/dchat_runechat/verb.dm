GLOBAL_VAR_INIT(drune_allowed, TRUE)
ADMIN_VERB(toggle_ooc_dead_rune, R_ADMIN, "Toggle Dead Runechat", "Toggle the runechat for dead players on or off.", ADMIN_CATEGORY_SERVER)
	toggle_drune()
	log_admin("[key_name(user)] toggled Dead runechat.")
	message_admins("[key_name_admin(user)] toggled Dead Runechat.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Dead Runechat", "[GLOB.drune_allowed ? "Enabled" : "Disabled"]"))

/proc/toggle_drune(toggle = null)
	if(toggle != null)
		if(toggle != GLOB.drune_allowed)
			GLOB.drune_allowed = toggle
		else
			return
	else
		GLOB.drune_allowed = !GLOB.drune_allowed
