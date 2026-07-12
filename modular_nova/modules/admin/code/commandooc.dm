// Command Departmental OOC
/client/verb/cooc(msg as text)
	set name = "COOC"
	set category = "OOC"
	send_department_ooc(src, "command", msg)

ADMIN_VERB(togglecooc, R_ADMIN, "Toggle Command OOC", "Toggles Command OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("command")
	log_admin("[key_name(usr)] toggled Command OOC.")
	message_admins("[key_name_admin(usr)] toggled Command OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Command OOC", "[GLOB.department_ooc_channels["command"].allowed ? "Enabled" : "Disabled"]"))
