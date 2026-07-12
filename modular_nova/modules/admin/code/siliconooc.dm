// Silicon / Robots Departmental OOC
/client/verb/slooc(msg as text)
	set name = "SLOOC"
	set category = "OOC"
	send_department_ooc(src, "silicon", msg)

ADMIN_VERB(toggleslooc, R_ADMIN, "Toggle Silicon OOC", "Toggles Silicon OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("silicon")
	log_admin("[key_name(usr)] toggled Silicon OOC.")
	message_admins("[key_name_admin(usr)] toggled Silicon OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Silicon OOC", "[GLOB.department_ooc_channels["silicon"].allowed ? "Enabled" : "Disabled"]"))
