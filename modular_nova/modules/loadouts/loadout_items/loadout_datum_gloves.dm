// LOADOUT ITEM DATUMS FOR THE HANDS SLOT

/datum/loadout_category/hands
	category_name = "Hands"
	category_ui_icon = FA_ICON_HAND
	type_to_generate = /datum/loadout_item/gloves
	tab_order = /datum/loadout_category/belt::tab_order + 1

/datum/loadout_item/gloves
	abstract_type = /datum/loadout_item/gloves

/datum/loadout_item/gloves/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.gloves))
		.. ()
		return TRUE

/datum/loadout_item/gloves/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.gloves)
			LAZYADD(outfit.backpack_contents, outfit.gloves)
		outfit.gloves = item_path
	else
		outfit.gloves = item_path

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/gloves/armwraps
	name = "Arm Wraps (Colorable)"
	item_path = /obj/item/clothing/gloves/bracer/wraps

/datum/loadout_item/gloves/black
	name = "Gloves (Black)"
	item_path = /obj/item/clothing/gloves/color/black

/datum/loadout_item/gloves/brown
	name = "Gloves (Brown)"
	item_path = /obj/item/clothing/gloves/color/brown

/datum/loadout_item/gloves/blue
	name = "Gloves (Blue)"
	item_path = /obj/item/clothing/gloves/color/blue

/datum/loadout_item/gloves/green
	name = "Gloves (Green)"
	item_path = /obj/item/clothing/gloves/color/green

/datum/loadout_item/gloves/grey
	name = "Gloves (Grey)"
	item_path = /obj/item/clothing/gloves/color/grey

/datum/loadout_item/gloves/light_brown
	name = "Gloves (Light Brown)"
	item_path = /obj/item/clothing/gloves/color/light_brown

/datum/loadout_item/gloves/orange
	name = "Gloves (Orange)"
	item_path = /obj/item/clothing/gloves/color/orange

/datum/loadout_item/gloves/purple
	name = "Gloves (Purple)"
	item_path = /obj/item/clothing/gloves/color/purple

/datum/loadout_item/gloves/red
	name = "Gloves (Red)"
	item_path = /obj/item/clothing/gloves/color/red

/datum/loadout_item/gloves/white
	name = "Gloves (White)"
	item_path = /obj/item/clothing/gloves/color/white

/datum/loadout_item/gloves/yellow
	name = "Gloves (Yellow)"
	item_path = /obj/item/clothing/gloves/color/ffyellow

/datum/loadout_item/gloves/yellow/get_item_information()
	. = ..()
	.[FA_ICON_BOLT] = "Non-Insulating"

/datum/loadout_item/gloves/kim
	name = "Gloves - Aerostatic"
	item_path = /obj/item/clothing/gloves/kim

/datum/loadout_item/gloves/lalune_long
	name = "Gloves - Designer"
	item_path = /obj/item/clothing/gloves/designer

/datum/loadout_item/gloves/evening
	name = "Gloves - Evening"
	item_path = /obj/item/clothing/gloves/evening

/datum/loadout_item/gloves/fingerless
	name = "Gloves - Fingerless"
	item_path = /obj/item/clothing/gloves/fingerless

/datum/loadout_item/gloves/rainbow
	name = "Gloves - Rainbow"
	item_path = /obj/item/clothing/gloves/color/rainbow

/datum/loadout_item/gloves/latex
	name = "Latex Gloves"
	item_path = /obj/item/clothing/gloves/long_gloves
	erp_item = TRUE

/datum/loadout_item/gloves/maid
	name = "Maid Arm Covers"
	item_path = /obj/item/clothing/gloves/maid

/datum/loadout_item/gloves/maid_arm_covers
	name = "Maid Arm Covers (Colorable)"
	item_path = /obj/item/clothing/gloves/maid_arm_covers

/datum/loadout_item/gloves/tactical_maid_sleeves
	name = "Maid Arm Covers - Tactical"
	item_path = /obj/item/clothing/gloves/tactical_maid
/*
*	RINGS
*/

/datum/loadout_item/gloves/diamondring
	name = "Ring - Diamond"
	item_path = /obj/item/clothing/gloves/ring/diamond

/datum/loadout_item/gloves/goldring
	name = "Ring - Gold"
	item_path = /obj/item/clothing/gloves/ring

/datum/loadout_item/gloves/silverring
	name = "Ring - Silver"
	item_path = /obj/item/clothing/gloves/ring/silver

/*
*	DONATOR
*/

/datum/loadout_item/gloves/donator
	abstract_type = /datum/loadout_item/gloves/donator
	donator_only = TRUE

/datum/loadout_item/gloves/donator/military
	name = "Military Gloves"
	item_path = /obj/item/clothing/gloves/military
