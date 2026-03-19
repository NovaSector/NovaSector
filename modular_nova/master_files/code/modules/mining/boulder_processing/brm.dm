// This code is to prevent people turning it on in a valid spot, unwrenching it, and moving it elsewhere where it should not function
/obj/machinery/brm/begin_processing()
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(on_brm_moved))

/// proc made to check if the machine is on when its moved, and to turn it off.
/obj/machinery/brm/proc/on_brm_moved(atom/movable/source, old_loc, movement_dir, forced, list/old_locs, momentum_change)
	SIGNAL_HANDLER
	if(toggled_on)
		toggled_on = FALSE
		balloon_alert_to_viewers("turns off!")
		end_processing()
		update_appearance(UPDATE_ICON_STATE)

/obj/machinery/brm/end_processing()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	return ..()
