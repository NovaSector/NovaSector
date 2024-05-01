// Removes the knockdown on take-off/landing of the emergency shuttle
/obj/docking_port/mobile/emergency
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)

// We still launch with haste on amber or above
/obj/docking_port/mobile/emergency/on_emergency_launch()
	// Lets not overwrite the emag effect
	for (var/obj/machinery/computer/emergency_shuttle/shuttle_computer as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/computer/emergency_shuttle))
		if(shuttle_computer.obj_flags & EMAGGED)
			return ..()
	// Check the security level
	var/security_level = SSsecurity_level.current_security_level.number_level
	if (security_level >= SEC_LEVEL_AMBER)
		SSshuttle.emergency.movement_force = list("KNOCKDOWN" = 3, "THROW" = 0)
	return ..()
