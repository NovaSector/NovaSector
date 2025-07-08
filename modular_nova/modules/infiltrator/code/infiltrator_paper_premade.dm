/obj/item/paper/fluff/infiltrator_left_note
//	name = ""
//	desc = ""

/obj/item/paper/fluff/infiltrator_left_note/proc/write_note(mob/infiltrator)
	var/first_name
	if(is_mononym(infiltrator.name))
		first_name = infiltrator.name
	else
		first_name = "[first_name(infiltrator.name)]"
	//add it to the note
	add_raw_text("[first_name],")
	add_raw_text("Hi.")
