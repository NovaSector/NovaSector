/*
*	LOADOUT ITEM DATUMS FOR THE HAND SLOT
*/

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

/datum/loadout_item/gloves/fingerless
	name = "Fingerless Gloves"
	item_path = /obj/item/clothing/gloves/fingerless

/datum/loadout_item/gloves/lalune_long
	name = "Designer Black Gloves"
	item_path = /obj/item/clothing/gloves/lalune_long

/datum/loadout_item/gloves/black
	name = "Black Gloves"
	item_path = /obj/item/clothing/gloves/color/black

/datum/loadout_item/gloves/blue
	name = "Blue Gloves"
	item_path = /obj/item/clothing/gloves/color/blue

/datum/loadout_item/gloves/brown
	name = "Brown Gloves"
	item_path = /obj/item/clothing/gloves/color/brown

/datum/loadout_item/gloves/green
	name = "Green Gloves"
	item_path = /obj/item/clothing/gloves/color/green

/datum/loadout_item/gloves/grey
	name = "Grey Gloves"
	item_path = /obj/item/clothing/gloves/color/grey

/datum/loadout_item/gloves/light_brown
	name = "Light Brown Gloves"
	item_path = /obj/item/clothing/gloves/color/light_brown

/datum/loadout_item/gloves/orange
	name = "Orange Gloves"
	item_path = /obj/item/clothing/gloves/color/orange

/datum/loadout_item/gloves/purple
	name = "Purple Gloves"
	item_path = /obj/item/clothing/gloves/color/purple

/datum/loadout_item/gloves/red
	name = "Red Gloves"
	item_path = /obj/item/clothing/gloves/color/red

/datum/loadout_item/gloves/yellow
	name = "Yellow Gloves"
	item_path = /obj/item/clothing/gloves/color/ffyellow
	additional_displayed_text = list("Non-Insulating")

/datum/loadout_item/gloves/white
	name = "White Gloves"
	item_path = /obj/item/clothing/gloves/color/white

/datum/loadout_item/gloves/rainbow
	name = "Rainbow Gloves"
	item_path = /obj/item/clothing/gloves/color/rainbow

/datum/loadout_item/gloves/evening
	name = "Evening Gloves"
	item_path = /obj/item/clothing/gloves/evening

/datum/loadout_item/gloves/kim
	name = "Aerostatic Gloves"
	item_path = /obj/item/clothing/gloves/kim

/datum/loadout_item/gloves/maid
	name = "Maid Arm Covers"
	item_path = /obj/item/clothing/gloves/maid

/datum/loadout_item/gloves/maid_arm_covers
	name = "Colourable Maid Arm Covers"
	item_path = /obj/item/clothing/gloves/maid_arm_covers

/datum/loadout_item/gloves/tactical_maid_sleeves
	name = "tactical maid sleeves"
	item_path = /obj/item/clothing/gloves/tactical_maid

/datum/loadout_item/gloves/armwraps
	name = "Colourable Arm Wraps"
	item_path = /obj/item/clothing/gloves/bracer/wraps

/datum/loadout_item/gloves/latex
	name = "Long Gloves"
	item_path = /obj/item/clothing/gloves/long_gloves
	erp_item = TRUE

/*
*	RINGS
*/

/datum/loadout_item/gloves/silverring
	name = "Silver Ring"
	item_path = /obj/item/clothing/gloves/ring/silver

/datum/loadout_item/gloves/goldring
	name = "Gold Ring"
	item_path = /obj/item/clothing/gloves/ring

/datum/loadout_item/gloves/diamondring
	name = "Diamond Ring"
	item_path = /obj/item/clothing/gloves/ring/diamond

/*
*	DONATOR
*/

/datum/loadout_item/gloves/donator
	abstract_type = /datum/loadout_item/gloves/donator
	donator_only = TRUE

/datum/loadout_item/gloves/donator/military
	name = "Military Gloves"
	item_path = /obj/item/clothing/gloves/military
