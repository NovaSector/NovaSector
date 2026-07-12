// Supply / Cargo Departmental OOC
/client/verb/suooc(msg as text)
	set name = "SUOOC"
	set category = "OOC"
	send_department_ooc(src, "supply", msg)

ADMIN_VERB(togglesuooc, R_ADMIN, "Toggle Supply OOC", "Toggles Supply OOC.", ADMIN_CATEGORY_SERVER)
	toggle_department_ooc("supply")
	log_admin("[key_name(usr)] toggled Supply OOC.")
	message_admins("[key_name_admin(usr)] toggled Supply OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Supply OOC", "[GLOB.department_ooc_channels["supply"].allowed ? "Enabled" : "Disabled"]"))
