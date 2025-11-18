/obj/item/mod/module/hydraulic/on_part_activation()
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_TRASHMAN, MOD_TRAIT)

/obj/item/mod/module/hydraulic/on_part_deactivation(deleting = FALSE)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_TRASHMAN, MOD_TRAIT)

/obj/item/mod/module/clamp
	required_slots = list(ITEM_SLOT_GLOVES, ITEM_SLOT_BACK|ITEM_SLOT_BELT)

/obj/item/mod/module/clamp/loader
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)

/obj/item/mod/module/hydraulic
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)

/obj/item/mod/module/magnet
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)

