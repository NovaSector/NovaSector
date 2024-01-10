/mob/living/silicon/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"] == "open_examine_panel")
		examine_panel.holder = src
		examine_panel.ui_interact(usr) //datum has a tgui component, here we open the window
	if(href_list["temporary_flavor"]) // I LOVE IT WHEN THINGS DONT CALL PARENT
		show_temp_ftext(usr)
