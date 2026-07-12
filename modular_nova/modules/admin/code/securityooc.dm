// Security Departmental OOC
/client/verb/sooc(msg as text)
	set name = "SOOC"
	set category = "OOC"
	send_department_ooc(src, "security", msg)

ADMIN_VERB(togglesooc, R_ADMIN, "Toggle Security OOC", "Toggles Security OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("security")
	log_admin("[key_name(usr)] toggled Security OOC.")
	message_admins("[key_name_admin(usr)] toggled Security OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Security OOC", "[GLOB.department_ooc_channels["security"].allowed ? "Enabled" : "Disabled"]"))
