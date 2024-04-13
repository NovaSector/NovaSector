/atom/create_storage(max_slots, max_specific_storage, max_total_storage, list/canhold, list/canthold, storage_type)
    . = ..()
    SEND_SIGNAL(src, COMSIG_ATOM_STORAGE_SET, atom_storage)

/atom/clone_storage(datum/storage/cloning)    
    . = ..()
    SEND_SIGNAL(src, COMSIG_ATOM_STORAGE_SET, atom_storage)
