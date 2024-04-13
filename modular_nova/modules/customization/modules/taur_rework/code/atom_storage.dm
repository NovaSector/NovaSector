/atom/create_storage(max_slots, max_specific_storage, max_total_storage, list/canhold, list/canthold, storage_type)
	. = ..()
	SEND_SIGNAL(src, COMSIG_ATOM_STORAGE_SET, atom_storage)

/atom/clone_storage(datum/storage/cloning)
	. = ..()
	SEND_SIGNAL(src, COMSIG_ATOM_STORAGE_SET, atom_storage)

/datum/storage/attempt_remove(obj/item/thing, atom/remove_to_loc, silent)
	. = ..()
	if (!.)
		return FALSE

	SEND_SIGNAL(parent, COMSIG_STORAGE_REMOVED_ITEM, thing, remove_to_loc, silent)
