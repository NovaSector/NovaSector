/obj/machinery/brm/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(move_detect)) // NOVA EDIT ADDITION

/// proc made to check if the machine is on when its moved, and to turn it off.
/obj/machinery/brm/proc/move_detect()
	SIGNAL_HANDLER
	if(toggled_on)
		toggled_on = FALSE
		end_processing()
		update_appearance(UPDATE_ICON_STATE)

/obj/machinery/brm/Destroy()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	return ..()
