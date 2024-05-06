// Any item with this component can have its storage accessed by alt clicking the wearer.
/datum/component/accessable_storage

/datum/component/accessable_storage/Initialize()
	if (!isitem(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/accessable_storage/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(parent_equipped))
	RegisterSignal(parent, COMSIG_STORAGE_STORED_ITEM, PROC_REF(parent_stored_item))
	RegisterSignal(parent, COMSIG_STORAGE_REMOVED_ITEM, PROC_REF(parent_removed_item))

/datum/component/accessable_storage/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED))

/datum/component/accessable_storage/proc/parent_equipped(datum/signal_source, mob/equipper, slot)
	SIGNAL_HANDLER

	RegisterSignal(equipper, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(mob_unequipped_item))

	if (isliving(equipper) && equipper.get_slot_by_item(parent) &~ (ITEM_SLOT_HANDS|ITEM_SLOT_POCKETS))
		RegisterSignal(equipper, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(mob_unequipped_item))
		RegisterSignal(equipper, COMSIG_CLICK_ALT, PROC_REF(mob_alt_clicked_on))

/datum/component/accessable_storage/proc/mob_alt_clicked_on(mob/signal_source, mob/clicker)
	SIGNAL_HANDLER

	var/obj/item/item_parent = parent
	item_parent.atom_storage?.open_storage(clicker, signal_source)
	item_parent.atom_storage?.animate_parent(signal_source)

/datum/component/accessable_storage/proc/mob_unequipped_item(mob/signal_source, obj/item/item, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER

	if (item == parent)
		UnregisterSignal(signal_source, list(COMSIG_MOB_UNEQUIPPED_ITEM, COMSIG_CLICK_ALT))

/datum/component/accessable_storage/proc/parent_stored_item(obj/item/signal_source, obj/item/inserted, mob/user, force)
	SIGNAL_HANDLER

	if (isliving(signal_source.loc))
		var/datum/storage/storage_datum = signal_source.atom_storage
		storage_datum.animate_parent(signal_source.loc)

/datum/component/accessable_storage/proc/parent_removed_item(obj/item/signal_source, obj/item/thing, atom/remove_to_loc, silent)
	SIGNAL_HANDLER

	if (isliving(signal_source.loc))
		var/datum/storage/storage_datum = signal_source.atom_storage
		storage_datum.animate_parent(signal_source.loc)
