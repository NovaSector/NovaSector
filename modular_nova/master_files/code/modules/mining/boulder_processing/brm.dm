/obj/machinery/brm
	/// Defines which areas this machine is allowed to operate. By default only the station but done this way in case its needed to be varedited by an admin. DO NOT ALLOW THIS FOR THE GHOST ROLES.
	var/allowed_areas_to_work = list(/area/station)

/obj/machinery/brm/handle_teleport_conditions(mob/user)
	if (!is_type_in_list(get_area(src), allowed_areas_to_work))
		balloon_alert(user, "invalid area of use!")
		return FALSE
	return ..()

/obj/machinery/brm/toggle_auto_on(mob/user)
	if (!is_type_in_list(get_area(src), allowed_areas_to_work))
		balloon_alert(user, "invalid area of use!")
		return FALSE
	return ..()
