// Science / Research Departmental OOC
/client/verb/rooc(msg as text)
	set name = "ROOC"
	set category = "OOC"
	send_department_ooc(src, "research", msg)

ADMIN_VERB(togglerooc, R_ADMIN, "Toggle Research OOC", "Toggles Research OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("research")
	log_admin("[key_name(usr)] toggled Research OOC.")
	message_admins("[key_name_admin(usr)] toggled Research OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Research OOC", "[GLOB.department_ooc_channels["research"].allowed ? "Enabled" : "Disabled"]"))
