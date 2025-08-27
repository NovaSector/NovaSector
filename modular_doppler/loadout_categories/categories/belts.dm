/datum/loadout_category/belt
	category_name = "Belt"
	category_ui_icon = FA_ICON_SCREWDRIVER_WRENCH
	type_to_generate = /datum/loadout_item/belts
	tab_order = /datum/loadout_category/accessories::tab_order + 1
	/// How many maximum of these can be chosen
	var/max_allowed = MAX_ALLOWED_EXTRA_CLOTHES

/datum/loadout_category/belt/New()
	. = ..()
	category_info = "([max_allowed] allowed)"

/datum/loadout_category/belt/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/belts/other_loadout_items = list()
	for(var/datum/loadout_item/belts/other_loadout_item in all_loadout_items)
		other_loadout_items += other_loadout_item

	if(length(other_loadout_items) >= max_allowed)
		// We only need to deselect something if we're above the limit
		// (And if we are we prioritize the first item found, FIFO)
		manager.deselect_item(other_loadout_items[1])
	return TRUE

/*
*	LOADOUT ITEM DATUMS FOR THE BELT SLOT
*/
/datum/loadout_item/belts
	abstract_type = /datum/loadout_item/belts

/datum/loadout_item/belts/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.belt)
			LAZYADD(outfit.backpack_contents, outfit.belt)
		outfit.belt = item_path
	else
		outfit.belt = item_path


/datum/loadout_item/belts/fanny_pack_black
	name = "Black Fannypack"
	item_path = /obj/item/storage/belt/fannypack/black

/datum/loadout_item/belts/fanny_pack_white
	name = "White Fannypack"
	item_path = /obj/item/storage/belt/fannypack/white

/datum/loadout_item/belts/fanny_pack_custom
	name = "Fannypack"
	item_path = /obj/item/storage/belt/fannypack/custom

/datum/loadout_item/belts/lantern
	name = "Lantern"
	item_path = /obj/item/flashlight/lantern

/datum/loadout_item/belts/champion
	name = "Champion's Belt"
	item_path = /obj/item/storage/belt/champion

// HOLSTERS

/datum/loadout_item/belts/holster_shoulders
	name = "Shoulder Holster"
	item_path = /obj/item/storage/belt/holster

// USEFUL BELTS

/datum/loadout_item/belts/medical
	name = "Medical Belt"
	item_path = /obj/item/storage/belt/medical

/datum/loadout_item/belts/medical/invisible
	name = "Compact Medical Belt"
	item_path = /obj/item/storage/belt/medical/invisible

/datum/loadout_item/belts/security
	name = "Security Belt"
	item_path = /obj/item/storage/belt/security

/datum/loadout_item/belts/utility
	name = "Utility Belt"
	item_path = /obj/item/storage/belt/utility

/datum/loadout_item/belts/utility/invisible
	name = "Compact Utility Belt"
	item_path = /obj/item/storage/belt/utility/invisible

/datum/loadout_item/belts/mining
	name = "Explorer's Webbing"
	item_path = /obj/item/storage/belt/mining

/datum/loadout_item/belts/mining_alt
	name = "Explorer's Webbing (Alt)"
	item_path = /obj/item/storage/belt/mining/alt

/datum/loadout_item/belts/boarding_rig
	name = "Chest Rig"
	item_path = /obj/item/storage/belt/military

/datum/loadout_item/belts/deforest_med
	name = "Satchel Med-kit"
	item_path = /obj/item/storage/backpack/duffelbag/deforest_medkit

/datum/loadout_item/belts/synth_repair
	name = "Android Repair Kit"
	item_path = /obj/item/storage/medkit/robotic_repair/stocked

/datum/loadout_item/belts/frontier_med
	name = "Frontier Med-kit"
	item_path = /obj/item/storage/medkit/frontier/stocked

/datum/loadout_item/belts/deforest_surgical
	name = "First Responder Med-kit"
	item_path = /obj/item/storage/backpack/duffelbag/deforest_surgical

/datum/loadout_item/belts/crusader_belt
	name = "Sword Belt & Sheath"
	item_path = /obj/item/storage/belt/crusader

/datum/loadout_item/belts/frontier_colonist
	name = "Frontier Chest Rig"
	item_path = /obj/item/storage/belt/utility/frontier_colonist

/datum/loadout_item/belts/pouch_rig
	name = "Chest Rig (Alt)"
	item_path = /obj/item/storage/belt/military/pouches

/datum/loadout_item/belts/lizard_sword
	name = "Tizirian Chopping Sword Sheath"
	item_path = /obj/item/storage/belt/lizard_sabre
