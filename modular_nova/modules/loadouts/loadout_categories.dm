/datum/loadout_category
/// Is this an ERP category?
	var/erp_category = FALSE
/// How many of this category can we select in a loadout?
	var/max_allowed = MAX_ALLOWED_STANDARD_CLOTHES

/datum/loadout_category/New()
	. = ..()
	associated_items = get_items()
	for(var/datum/loadout_item/item as anything in associated_items)
		if(GLOB.all_loadout_datums[item.item_path])
			stack_trace("Loadout datum collision - [item.item_path] is shared between multiple loadout datums.")
		GLOB.all_loadout_datums[item.item_path] = item
	category_info = "([max_allowed] allowed)"

/datum/loadout_category/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/other_loadout_items = list()
	for(var/datum/loadout_item/other_loadout_item in all_loadout_items)
		other_loadout_items += other_loadout_item

	if(length(other_loadout_items) >= max_allowed)
		// We only need to deselect something if we're above the limit
		// (And if we are we prioritize the first item found, FIFO)
		manager.deselect_item(other_loadout_items[1])
	return TRUE

