// LOADOUT ITEM DATUMS FOR THE BELT SLOT

/datum/loadout_category/belt
	category_name = "Belt"
	category_ui_icon = FA_ICON_SCREWDRIVER_WRENCH
	type_to_generate = /datum/loadout_item/belts
	tab_order = /datum/loadout_category/accessories::tab_order + 1

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

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/belts/fanny_pack_black
	name = "Fannypack (Black)"
	item_path = /obj/item/storage/belt/fannypack/black

/datum/loadout_item/belts/fanny_pack_blue
	name = "Fannypack (Blue)"
	item_path = /obj/item/storage/belt/fannypack/blue

/datum/loadout_item/belts/fanny_pack_brown
	name = "Fannypack (Brown)"
	item_path = /obj/item/storage/belt/fannypack

/datum/loadout_item/belts/fanny_pack_cyan
	name = "Fannypack (Cyan)"
	item_path = /obj/item/storage/belt/fannypack/cyan

/datum/loadout_item/belts/fanny_pack_green
	name = "Fannypack (Green)"
	item_path = /obj/item/storage/belt/fannypack/green

/datum/loadout_item/belts/fanny_pack_orange
	name = "Fannypack (Orange)"
	item_path = /obj/item/storage/belt/fannypack/orange

/datum/loadout_item/belts/fanny_pack_pink
	name = "Fannypack (Pink)"
	item_path = /obj/item/storage/belt/fannypack/pink

/datum/loadout_item/belts/fanny_pack_purple
	name = "Fannypack (Purple)"
	item_path = /obj/item/storage/belt/fannypack/purple

/datum/loadout_item/belts/fanny_pack_red
	name = "Fannypack (Red)"
	item_path = /obj/item/storage/belt/fannypack/red

/datum/loadout_item/belts/fanny_pack_white
	name = "Fannypack (White)"
	item_path = /obj/item/storage/belt/fannypack/white

/datum/loadout_item/belts/fanny_pack_yellow
	name = "Fannypack (Yellow)"
	item_path = /obj/item/storage/belt/fannypack/yellow

/datum/loadout_item/belts/lantern
	name = "Lantern"
	item_path = /obj/item/flashlight/lantern

/datum/loadout_item/belts/thigh_satchel
	name = "Thigh Satchel"
	item_path = /obj/item/storage/belt/thigh_satchel

// HOLSTERS

/datum/loadout_item/belts/holster_shoulders
	name = "Holster (Shoulder)"
	item_path = /obj/item/storage/belt/holster

/datum/loadout_item/belts/holster_cowboy
	name = "Holster (Thigh, Colorable)"
	item_path = /obj/item/storage/belt/holster/thigh

// RIGS/WEBBING (for military larpers)

/datum/loadout_item/belts/webbing
	name = "Webbing - Basic"
	item_path = /obj/item/storage/belt/webbing

/datum/loadout_item/belts/cin_surplus_chestrig
	name = "Webbing - CIN Surplus (Colorable)"
	item_path = /obj/item/storage/belt/military/cin_surplus

/datum/loadout_item/belts/cin_surplus_chestrig_desert
	name = "Webbing - CIN Surplus (Desert)"
	item_path = /obj/item/storage/belt/military/cin_surplus/desert
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/belts/cin_surplus_chestrig_forest
	name = "Webbing - CIN Surplus (Forest)"
	item_path = /obj/item/storage/belt/military/cin_surplus/forest
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/belts/cin_surplus_chestrig_marine
	name = "Webbing - CIN Surplus (Marine)"
	item_path = /obj/item/storage/belt/military/cin_surplus/marine
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/belts/colonial_webbing
	name = "Webbing - Colonial"
	item_path = /obj/item/storage/belt/webbing/colonial

/datum/loadout_item/belts/webbing_pouch
	name = "Webbing - Drop Pouches"
	item_path = /obj/item/storage/belt/webbing/pouch
	can_be_reskinned = TRUE

/datum/loadout_item/belts/expeditionary_chestrig_belt
	name = "Webbing - Expeditionary"
	item_path = /obj/item/storage/belt/military/expeditionary_corps

/datum/loadout_item/belts/frontier_chestrig
	name = "Webbing - Frontier"
	item_path = /obj/item/storage/belt/utility/frontier_colonist

/datum/loadout_item/belts/webbing_pilot
	name = "Webbing - Rigging"
	item_path = /obj/item/storage/belt/webbing/pilot
	can_be_reskinned = TRUE

/datum/loadout_item/belts/webbing_vest
	name = "Webbing - Vest"
	item_path = /obj/item/storage/belt/webbing/vest
	can_be_reskinned = TRUE

