// Antagonist Datum Holder OOC
/client/verb/aooc(msg as text)
	set name = "AOOC"
	set category = "OOC"
	send_department_ooc(src, "antagonist", msg)

ADMIN_VERB(toggleaooc, R_ADMIN, "Toggle Antag OOC", "Toggles Antag OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("antagonist")
	log_admin("[key_name(usr)] toggled Antagonist OOC.")
	message_admins("[key_name_admin(usr)] toggled Antagonist OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.department_ooc_channels["antagonist"].allowed ? "Enabled" : "Disabled"]"))
