// Engineering Departmental OOC
/client/verb/eooc(msg as text)
	set name = "EOOC"
	set category = "OOC"
	send_department_ooc(src, "engineering", msg)

ADMIN_VERB(toggleeooc, R_ADMIN, "Toggle Engineering OOC", "Toggles Engineering OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("engineering")
	log_admin("[key_name(usr)] toggled Engineering OOC.")
	message_admins("[key_name_admin(usr)] toggled Engineering OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Engineering OOC", "[GLOB.department_ooc_channels["engineering"].allowed ? "Enabled" : "Disabled"]"))
