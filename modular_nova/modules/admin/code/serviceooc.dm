// Service Departmental OOC
/client/verb/srooc(msg as text)
	set name = "SROOC"
	set category = "OOC"
	send_department_ooc(src, "service", msg)

ADMIN_VERB(togglesrooc, R_ADMIN, "Toggle Service OOC", "Toggles Service OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("service")
	log_admin("[key_name(usr)] toggled Service OOC.")
	message_admins("[key_name_admin(usr)] toggled Service OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Service OOC", "[GLOB.department_ooc_channels["service"].allowed ? "Enabled" : "Disabled"]"))
