// LOADOUT ITEM DATUMS FOR THE EAR SLOT

/datum/loadout_category/ears
	category_name = "Ears"
	category_ui_icon = FA_ICON_EAR_LISTEN
	type_to_generate = /datum/loadout_item/ears
	tab_order = /datum/loadout_category/face::tab_order + 1

/datum/loadout_item/ears
	abstract_type = /datum/loadout_item/ears

/datum/loadout_item/ears/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.ears))
		.. ()
		return TRUE

/datum/loadout_item/ears/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.ears)
			LAZYADD(outfit.backpack_contents, outfit.ears)
		outfit.ears = item_path
	else
		outfit.ears = item_path

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/ears/headphones
	name = "Headphones"
	item_path = /obj/item/instrument/piano_synth/headphones

/datum/loadout_item/ears/earmuffs
	name = "Earmuffs"
	item_path = /obj/item/clothing/ears/earmuffs
