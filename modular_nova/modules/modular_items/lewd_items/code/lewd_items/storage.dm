/obj/item/storage/box/erp
	name = "box of love"
	desc = "A discrete box full of mysteries."
	icon_state = "hugbox"
	illustration = "heart"
	foldable_result = /obj/item/stack/sheet/cardboard
	storage_type = /datum/storage/box/erp
	w_class = WEIGHT_CLASS_SMALL

/datum/storage/box/erp
	max_specific_storage = WEIGHT_CLASS_NORMAL

/datum/storage/box/erp/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(GLOB.erp_items)

