// Medical Departmental OOC
/client/verb/mooc(msg as text)
	set name = "MOOC"
	set category = "OOC"
	send_department_ooc(src, "medical", msg)

ADMIN_VERB(togglemooc, R_ADMIN, "Toggle Medical OOC", "Toggles Medical OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("medical")
	log_admin("[key_name(usr)] toggled Medical OOC.")
	message_admins("[key_name_admin(usr)] toggled Medical OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Medical OOC", "[GLOB.department_ooc_channels["medical"].allowed ? "Enabled" : "Disabled"]"))
