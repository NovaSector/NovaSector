/datum/storage/attempt_remove(obj/item/thing, atom/remove_to_loc, silent)
	. = ..()
	if (!.)
		return FALSE

	SEND_SIGNAL(parent, COMSIG_STORAGE_REMOVED_ITEM, thing, remove_to_loc, silent)
