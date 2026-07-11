/mob/living/Topic(href, list/href_list)
	. = ..()
	if(href_list["temporary_flavor"])
		show_temp_ftext(usr)
		return
	if(href_list["loadout_examine"])
		var/obj/item/examined_atom = locate(href_list["loadout_examine"])
		if(!istype(examined_atom) || !HAS_TRAIT_FROM(examined_atom, TRAIT_WAS_RENAMED, "Loadout"))
			return
		run_examinate(examined_atom)

/mob/living/proc/show_temp_ftext(mob/user)
	if(temporary_flavor_text)
		var/datum/browser/popup = new(user, "[name]'s temporary flavor text", "[name]'s Temporary Flavor Text", 500, 200)
		popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s temporary flavor text", replacetext(temporary_flavor_text, "\n", "<BR>")))
		popup.open()
		return
