/obj/machinery/brm/begin_processing()
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(move_detect))

/// proc made to check if the machine is on when its moved, and to turn it off.
/obj/machinery/brm/proc/move_detect(atom/movable/source, old_loc, movement_dir, forced, list/old_locs, momentum_change)
	SIGNAL_HANDLER
	if(toggled_on)
		toggled_on = FALSE
		end_processing()
		update_appearance(UPDATE_ICON_STATE)

/obj/machinery/brm/end_processing()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	return ..()
