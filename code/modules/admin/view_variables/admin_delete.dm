/client/proc/admin_delete(datum/D)
	var/atom/A = D
	var/coords = ""
	var/jmp_coords = ""
	var/turf/T // NOVA EDIT -- Bluespace sparks on admin delete
	if(istype(A))
		T = get_turf(A) // NOVA EDIT, orginal: var/turf/T = get_turf(A)
		if(T)
			var/atom/a_loc = A.loc
			var/is_turf = isturf(a_loc)
			coords = "[is_turf ? "at" : "from [a_loc] at"] [AREACOORD(T)]"
			jmp_coords = "[is_turf ? "at" : "from [a_loc] at"] [ADMIN_VERBOSEJMP(T)]"
		else
			jmp_coords = coords = "in nullspace"

	if (tgui_alert(usr, "Are you sure you want to delete:\n[D]\n[coords]?", "Confirmation", list("Yes", "No")) == "Yes")
		log_admin("[key_name(usr)] deleted [D] [coords]")
		message_admins("[key_name_admin(usr)] deleted [D] [jmp_coords]")
		BLACKBOX_LOG_ADMIN_VERB("Delete")
		SEND_SIGNAL(D, COMSIG_ADMIN_DELETING, src)
		if(isturf(D))
			T = D // NOVA EDIT, orginal: var/turf/T = D
			T.ScrapeAway()
		else
			vv_update_display(D, "deleted", VV_MSG_DELETED)
			qdel(D)
			if(!QDELETED(D))
				vv_update_display(D, "deleted", "")
		// NOVA EDIT ADDITION START -- optional bluespace sparks on delete
		if(prefs.read_preference(/datum/preference/toggle/admin/delete_sparks))
			do_admin_sparks(10, TRUE, T) // non-interactive sparks
		// NOVA EDIT ADDITION END
