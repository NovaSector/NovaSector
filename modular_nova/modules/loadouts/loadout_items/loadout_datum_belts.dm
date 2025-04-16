/datum/loadout_category/belt
	category_name = "Belt"
	category_ui_icon = FA_ICON_SCREWDRIVER_WRENCH
	type_to_generate = /datum/loadout_item/belts
	tab_order = /datum/loadout_category/accessories::tab_order + 1


/*
*	LOADOUT ITEM DATUMS FOR THE BELT SLOT
*/
/datum/loadout_item/belts
	abstract_type = /datum/loadout_item/belts

/datum/loadout_item/belts/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)  // don't bother storing in backpack, can't fit
	if(initial(outfit_important_for_life.belt))
		return TRUE

/datum/loadout_item/belts/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.belt)
			LAZYADD(outfit.backpack_contents, outfit.belt)

	outfit.belt = item_path

/datum/loadout_item/belts/fanny_pack_black
	name = "Black Fannypack"
	item_path = /obj/item/storage/belt/fannypack/black

/datum/loadout_item/belts/fanny_pack_blue
	name = "Blue Fannypack"
	item_path = /obj/item/storage/belt/fannypack/blue

/datum/loadout_item/belts/fanny_pack_brown
	name = "Brown Fannypack"
	item_path = /obj/item/storage/belt/fannypack

/datum/loadout_item/belts/fanny_pack_cyan
	name = "Cyan Fannypack"
	item_path = /obj/item/storage/belt/fannypack/cyan

/datum/loadout_item/belts/fanny_pack_green
	name = "Green Fannypack"
	item_path = /obj/item/storage/belt/fannypack/green

/datum/loadout_item/belts/fanny_pack_orange
	name = "Orange Fannypack"
	item_path = /obj/item/storage/belt/fannypack/orange

/datum/loadout_item/belts/fanny_pack_pink
	name = "Pink Fannypack"
	item_path = /obj/item/storage/belt/fannypack/pink

/datum/loadout_item/belts/fanny_pack_purple
	name = "Purple Fannypack"
	item_path = /obj/item/storage/belt/fannypack/purple

/datum/loadout_item/belts/fanny_pack_red
	name = "Red Fannypack"
	item_path = /obj/item/storage/belt/fannypack/red

/datum/loadout_item/belts/fanny_pack_yellow
	name = "Yellow Fannypack"
	item_path = /obj/item/storage/belt/fannypack/yellow

/datum/loadout_item/belts/fanny_pack_white
	name = "White Fannypack"
	item_path = /obj/item/storage/belt/fannypack/white

/datum/loadout_item/belts/thigh_satchel
	name = "Thigh Satchel"
	item_path = /obj/item/storage/belt/thigh_satchel

/datum/loadout_item/belts/lantern
	name = "Lantern"
	item_path = /obj/item/flashlight/lantern

/datum/loadout_item/belts/candle_box
	name = "Candle Box"
	item_path = /obj/item/storage/fancy/candle_box

// HOLSTERS

/datum/loadout_item/belts/holster_shoulders
	name = "Shoulder Holster"
	item_path = /obj/item/storage/belt/holster

/datum/loadout_item/belts/holster_cowboy
	name = "Cowboy Belt (Thigh Holster)"
	item_path = /obj/item/storage/belt/holster/cowboy

// RIGS/WEBBING (for military larpers)

/datum/loadout_item/belts/cin_surplus_chestrig
	name = "CIN Surplus Chest Rig (Standard)"
	item_path = /obj/item/storage/belt/military/cin_surplus

/datum/loadout_item/belts/cin_surplus_chestrig_desert
	name = "CIN Surplus Chest Rig (Desert)"
	item_path = /obj/item/storage/belt/military/cin_surplus/desert

/datum/loadout_item/belts/cin_surplus_chestrig_forest
	name = "CIN Surplus Chest Rig (Forest)"
	item_path = /obj/item/storage/belt/military/cin_surplus/forest

/datum/loadout_item/belts/cin_surplus_chestrig_marine
	name = "CIN Surplus Chest Rig (Marine)"
	item_path = /obj/item/storage/belt/military/cin_surplus/marine

/datum/loadout_item/belts/expeditionary_chestrig_belt
	name = "Expeditionary Chest Rig/Webbing Belt"
	item_path = /obj/item/storage/belt/military/expeditionary_corps

/datum/loadout_item/belts/frontier_chestrig
	name = "Frontier Chest Rig"
	item_path = /obj/item/storage/belt/utility/frontier_colonist

