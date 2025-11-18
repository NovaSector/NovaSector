/mob/living/silicon/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"] == "open_examine_panel")
		mob_examine_panel.ui_interact(usr) //datum has a examine_panel datum, here we open the window
	if(href_list["temporary_flavor"]) // we need this here because tg code doesnt call parent in /mob/living/silicon/Topic()
		show_temp_ftext(usr)
	if(href_list["lookup_info"] == "open_character_ad")
		usr.client?.show_character_directory(specific_ad = name)
	if(href_list["open_door"])
		var/obj/machinery/door/airlock/door = locate(href_list["open_door"]) in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock)
		var/mob/living/requester = locate(href_list["user"]) in GLOB.mob_list

		if(!requester)
			return
		if(!door)
			return
		fulfill_door_request(requester, door, href_list["action"])
	if(href_list["track"])
		var/mob/living/silicon/ai/AI = src
		if(AI.deployed_shell)
			AI.deployed_shell.undeploy()
		AI.ai_tracking_tool.track_name(src, href_list["track"])
