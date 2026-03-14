// Disable the ID tracking procs
/obj/structure/holopay/track(atom/movable/thing)
	return

/obj/structure/holopay/untrack(atom/movable/thing)
	return

/obj/structure/holopay/handle_move(atom/movable/source, atom/old_loc, dir, forced, list/old_locs)
	return
