// LOADOUT ITEM DATUMS FOR TOY ITEMS, PLACED DIRECTLY INTO THE BACKPACK

/datum/loadout_category/toys
	category_name = "Toys"
	category_ui_icon = FA_ICON_TROPHY
	type_to_generate = /datum/loadout_item/toys
	tab_order = /datum/loadout_category/inhands::tab_order + 1
	/// How many toys are allowed at maximum.
	VAR_PRIVATE/max_allowed = 3

/datum/loadout_category/toys/New()
	. = ..()
	category_info = "([max_allowed] allowed)"

/datum/loadout_category/toys/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/toys/other_toys = list()
	for(var/datum/loadout_item/toys/other_toy in all_loadout_items)
		other_toys += other_toy

	if(length(other_toys) >= max_allowed)
		// We only need to deselect something if we're above the limit
		// (And if we are we prioritize the first item found, FIFO)
		manager.deselect_item(other_toys[1])
	return TRUE

/datum/loadout_item/toys
	abstract_type = /datum/loadout_item/toys

/datum/loadout_item/toys/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)  // these go in the backpack
	return FALSE

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/toys/crayons
	//Extra space forces the "Toys" Group to the top
	name = " Box of Crayons"
	item_path = /obj/item/storage/crayons

/datum/loadout_item/toys/cat_toy
	name = "Cat Toy"
	item_path = /obj/item/toy/cattoy

/datum/loadout_item/toys/dog_bone
	name = "Jumbo Dog Bone"
	item_path = /obj/item/dog_bone

/datum/loadout_item/toys/red_laser
	name = "Laser Pointer (Red)"
	item_path = /obj/item/laser_pointer/limited/red

/datum/loadout_item/toys/green_laser
	name = "Laser Pointer (Green)"
	item_path = /obj/item/laser_pointer/limited/green

/datum/loadout_item/toys/blue_laser
	name = "Laser Pointer (Blue)"
	item_path = /obj/item/laser_pointer/limited/blue

/datum/loadout_item/toys/purple_laser
	name = "Laser Pointer (Purple)"
	item_path = /obj/item/laser_pointer/limited/purple

/datum/loadout_item/toys/eightball
	name = "Magic Eightball"
	item_path = /obj/item/toy/eightball

/datum/loadout_item/toys/spray_can
	name = "Spray Can"
	item_path = /obj/item/toy/crayon/spraycan

/datum/loadout_item/toys/toykatana
	name = "Toy Katana"
	item_path = /obj/item/toy/katana

/*
*	TENNIS BALLS
*/

/datum/loadout_item/toys/tennis
	name = "Tennis Ball (Classic)"
	item_path = /obj/item/toy/tennis

/datum/loadout_item/toys/tennisred
	name = "Tennis Ball (Red)"
	item_path = /obj/item/toy/tennis/red

/datum/loadout_item/toys/tennisyellow
	name = "Tennis Ball (Yellow)"
	item_path = /obj/item/toy/tennis/yellow

/datum/loadout_item/toys/tennisgreen
	name = "Tennis Ball (Green)"
	item_path = /obj/item/toy/tennis/green

/datum/loadout_item/toys/tenniscyan
	name = "Tennis Ball (Cyan)"
	item_path = /obj/item/toy/tennis/cyan

/datum/loadout_item/toys/tennisblue
	name = "Tennis Ball (Blue)"
	item_path = /obj/item/toy/tennis/blue

/datum/loadout_item/toys/tennispurple
	name = "Tennis Ball (Purple)"
	item_path = /obj/item/toy/tennis/purple

/*
*	CARDS
*/

/datum/loadout_item/toys/card_binder
	name = "Card Binder"
	item_path = /obj/item/storage/card_binder

/datum/loadout_item/toys/card_deck
	name = "Card Deck"
	item_path = /obj/item/toy/cards/deck

/datum/loadout_item/toys/kotahi_deck
	name = "Card Deck - Kotahi"
	item_path = /obj/item/toy/cards/deck/kotahi

/datum/loadout_item/toys/tarot
	name = "Card Deck - Tarot"
	item_path = /obj/item/toy/cards/deck/tarot

/datum/loadout_item/toys/wizoff_deck
	name = "Card Deck - Wizoff"
	item_path = /obj/item/toy/cards/deck/wizoff

/*
*	DICE
*/

/datum/loadout_item/toys/dice
	group = "Dice"
	abstract_type = /datum/loadout_item/toys/dice

/datum/loadout_item/toys/dice/d00
	//Extra space forces "Dice" Group above "Plushies"
	name = " D00"
	item_path = /obj/item/dice/d00

//I am NOT alphabetizing numbers dawg. It's not actually number order 11 comes before 2
/datum/loadout_item/toys/dice/d1
	name = "D1"
	item_path = /obj/item/dice/d1

/datum/loadout_item/toys/dice/d2
	name = "D2"
	item_path = /obj/item/dice/d2

/datum/loadout_item/toys/dice/d4
	name = "D4"
	item_path = /obj/item/dice/d4

/datum/loadout_item/toys/dice/d6
	name = "D6"
	item_path = /obj/item/dice/d6

/datum/loadout_item/toys/dice/d6_ebony
	name = "D6 (Ebony)"
	item_path = /obj/item/dice/d6/ebony

/datum/loadout_item/toys/dice/d6_space
	name = "D6 (Space)"
	item_path = /obj/item/dice/d6/space

/datum/loadout_item/toys/dice/d8
	name = "D8"
	item_path = /obj/item/dice/d8

/datum/loadout_item/toys/dice/d10
	name = "D10"
	item_path = /obj/item/dice/d10

/datum/loadout_item/toys/dice/d12
	name = "D12"
	item_path = /obj/item/dice/d12

/datum/loadout_item/toys/dice/d20
	name = "D20"
	item_path = /obj/item/dice/d20

/datum/loadout_item/toys/dice/d20_weighted_low
	name = "D20 (Weighted, Low)"
	item_path = /obj/item/dice/d20/nat1

/datum/loadout_item/toys/dice/d20_weighted_high
	name = "D20 (Weighted, High)"
	item_path = /obj/item/dice/d20/nat20

/datum/loadout_item/toys/dice/d100
	name = "D100"
	item_path = /obj/item/dice/d100

/datum/loadout_item/toys/dice/dice_bag
	name = "Dice Bag"
	item_path = /obj/item/storage/dice
