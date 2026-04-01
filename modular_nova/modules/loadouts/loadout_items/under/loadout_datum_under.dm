// LOADOUT ITEM DATUMS FOR THE UNDER (UNIFORM) SLOT

/datum/loadout_category/undersuit
	category_name = "Undersuit"
	category_ui_icon = FA_ICON_SHIRT
	type_to_generate = /datum/loadout_item/under
	tab_order = /datum/loadout_category/suits::tab_order + 1

/datum/loadout_item/under
	abstract_type = /datum/loadout_item/under

/datum/loadout_item/under/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.uniform))
		.. ()
		return TRUE

/datum/loadout_item/under/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.uniform)
			LAZYADD(outfit.backpack_contents, outfit.uniform)
		outfit.uniform = item_path
	else
		outfit.uniform = item_path
	outfit.modified_outfit_slots |= ITEM_SLOT_ICLOTHING

/*
*	ITEMS BELOW HERE
*/

/*
 *	JUMPSUITS
 *	To cheat at alphabetization, these have extra spaces at the front of their name.
 *	In-game users won't see these spaces, but it'll still force these to sort as they appear below.
*/

/datum/loadout_item/under/jumpsuit
	abstract_type = /datum/loadout_item/under/jumpsuit

/datum/loadout_item/under/jumpsuit/greyscale
	name = "  Jumpsuit (Colorable)"
	item_path = /obj/item/clothing/under/color

/datum/loadout_item/under/jumpsuit/rainbow
	name = "  Jumpsuit (Rainbow)"
	item_path = /obj/item/clothing/under/color/rainbow

/datum/loadout_item/under/jumpsuit/random
	name = "  Jumpsuit - Random"
	item_path = /obj/item/clothing/under/color/random
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/under/jumpsuit/random/get_item_information()
	. = ..()
	.[FA_ICON_DICE] = TOOLTIP_RANDOM_COLOR

/datum/loadout_item/under/jumpsuit/greyscale_skirt
	name = " Jumpskirt (Colorable)"
	item_path = /obj/item/clothing/under/color/jumpskirt

/datum/loadout_item/under/jumpsuit/rainbow_skirt
	name = " Jumpskirt (Rainbow)"
	item_path = /obj/item/clothing/under/color/jumpskirt/rainbow

/datum/loadout_item/under/jumpsuit/random_skirt
	name = " Jumpskirt - Random"
	item_path = /obj/item/clothing/under/color/jumpskirt/random
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/under/jumpsuit/random_skirt/get_item_information()
	. = ..()
	.[FA_ICON_DICE] = TOOLTIP_RANDOM_COLOR

/*
 *	Unsorted
 *	For the love of god try to sort it first.
*/

/datum/loadout_item/under/jumpsuit/kim
	name = "Aerostatic Suit"
	item_path = /obj/item/clothing/under/rank/security/detective/kim

/datum/loadout_item/under/jumpsuit/frontier
	name = "Frontier Jumpsuit"
	item_path = /obj/item/clothing/under/frontier_colonist

/datum/loadout_item/under/jumpsuit/refit_wetsuit
	name = "Refitted Shoredress Wetsuit"
	item_path = /obj/item/clothing/under/akula_wetsuit/refit

/datum/loadout_item/under/miscellaneous //This needs to be removed whenever (ifever) loadout datums are actually cleaned.
	abstract_type = /datum/loadout_item/under/miscellaneous

/datum/loadout_item/under/miscellaneous/gear_harness
	name = "Gear Harness"
	item_path = /obj/item/clothing/under/misc/nova/gear_harness

/datum/loadout_item/under/miscellaneous/giant_scarf
	name = "Giant Scarf"
	item_path = /obj/item/clothing/under/dress/nova/giant_scarf
	reskin_datum = /datum/atom_skin/giant_scarf

/datum/loadout_item/under/miscellaneous/playsuit
	name = "Playsuit (Recolorable)"
	item_path = /obj/item/clothing/under/greyscale/playsuit

/datum/loadout_item/under/jumpsuit/disco
	name = "Superstar Cop Uniform"
	item_path = /obj/item/clothing/under/rank/security/detective/disco

/datum/loadout_item/under/miscellaneous/syndicate_unarmoured_skirt
	name = "Suspicious Tactical Skirtleneck (Grey)"
	item_path = /obj/item/clothing/under/syndicate/unarmoured/skirt

/datum/loadout_item/under/miscellaneous/syndicate_nova_unarmoured_skirt
	name = "Suspicious Tactical Skirtleneck (Red)"
	item_path = /obj/item/clothing/under/syndicate/nova/tactical/unarmoured/skirt

/datum/loadout_item/under/miscellaneous/syndicate_unarmoured
	name = "Suspicious Tactical Turtleneck (Grey)"
	item_path = /obj/item/clothing/under/syndicate/unarmoured

/datum/loadout_item/under/miscellaneous/syndicate_nova_unarmoured
	name = "Suspicious Tactical Turtleneck (Red)"
	item_path = /obj/item/clothing/under/syndicate/nova/tactical/unarmoured

/datum/loadout_item/under/miscellaneous/syndicate_nova_overalls_unarmoured_skirt
	name = "Suspicious Utility Overalls Skirtleneck"
	item_path = /obj/item/clothing/under/syndicate/nova/overalls/unarmoured/skirt

/datum/loadout_item/under/miscellaneous/syndicate_nova_overalls_unarmoured
	name = "Suspicious Utility Overalls Turtleneck"
	item_path = /obj/item/clothing/under/syndicate/nova/overalls/unarmoured

/datum/loadout_item/under/miscellaneous/tactical_pants
	name = "Tactical Pants"
	item_path = /obj/item/clothing/under/pants/tactical

/datum/loadout_item/under/miscellaneous/taccas
	name = "Tacticasual Uniform"
	item_path = /obj/item/clothing/under/misc/nova/taccas

/datum/loadout_item/under/miscellaneous/tactical_skirt
	name = "Tacticool Skirtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool/skirt

/datum/loadout_item/under/miscellaneous/tacticool_turtleneck
	name = "Tacticool Turtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool

/*
*	FORMAL UNDERSUITS
*/

/datum/loadout_item/under/formal
	abstract_type = /datum/loadout_item/under/formal
	group = "Formalwear"

/datum/loadout_item/under/formal/assistant
	name = "Assistant's Formal Uniform"
	item_path = /obj/item/clothing/under/misc/assistantformal

/datum/loadout_item/under/formal/amish_suit
	name = "Buttondown Suit (Black)"
	item_path = /obj/item/clothing/under/costume/buttondown/slacks/service

/datum/loadout_item/under/formal/blue_suit
	name = "Buttondown Suit (Blue)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit

/datum/loadout_item/under/formal/blue_suitskirt
	name = "Buttondown Suit (Blue, Skirt)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt

/datum/loadout_item/under/formal/recolorable_suit/casual
	name = "Buttondown Suit - Collared"
	item_path = /obj/item/clothing/under/suit/nova/recolorable/casual

/datum/loadout_item/under/jumpsuit/hlscientist
	name = "Buttondown Suit - Science Team"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/nova/hlscience
	group = "Formalwear" //This datum needs retyping to be /under/formal!

/datum/loadout_item/under/formal/executive_suit
	name = "Executive Suit"
	item_path = /obj/item/clothing/under/suit/black_really

/datum/loadout_item/under/formal/recolorable_suit/executive
	name = "Executive Suit (Colorable)"
	item_path = /obj/item/clothing/under/suit/nova/recolorable/executive

/datum/loadout_item/under/formal/executive_suit_alt
	name = "Executive Suit - Wide-collared"
	item_path = /obj/item/clothing/under/suit/nova/black_really_collared

/datum/loadout_item/under/formal/executive_skirt
	name = "Executive Suitskirt"
	item_path = /obj/item/clothing/under/suit/black_really/skirt

/datum/loadout_item/under/formal/pencil/black_really
	name = "Executive Suitskirt (Colorable, Pencilskirt)"
	item_path = /obj/item/clothing/under/suit/nova/pencil/black_really

/datum/loadout_item/under/formal/executive_skirt_alt
	name = "Executive Suitskirt - Wide-collared"
	item_path = /obj/item/clothing/under/suit/nova/black_really_collared/skirt

/datum/loadout_item/under/formal/red_gown
	name = "Formal Dress"
	item_path = /obj/item/clothing/under/dress/eveninggown

/datum/loadout_item/under/formal/countessdress
	name = "Formal Dress - Countess"
	item_path = /obj/item/clothing/under/dress/nova/countess

/datum/loadout_item/under/formal/formaldressred
	name = "Formal Dress - Crimson"
	item_path = /obj/item/clothing/under/dress/nova/redformal

/datum/loadout_item/under/formal/sailor_skirt
	name = "Formal Dress - Sailor"
	item_path = /obj/item/clothing/under/dress/sailor

/datum/loadout_item/under/formal/inferno
	name = "Inferno Suit"
	item_path = /obj/item/clothing/under/suit/nova/inferno
	reskin_datum = /datum/atom_skin/inferno_suit

/datum/loadout_item/under/formal/inferno_skirt
	name = "Inferno Suitskirt"
	item_path = /obj/item/clothing/under/suit/nova/inferno/skirt
	reskin_datum = /datum/atom_skin/inferno_suitskirt

/datum/loadout_item/under/formal/black_lawyer_suit
	name = "Lawyer Suit (Black)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black

/datum/loadout_item/under/formal/black_lawyer_skirt
	name = "Lawyer Suit (Black, Skirt)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black/skirt

/datum/loadout_item/under/formal/blue_lawyer_suit
	name = "Lawyer Suit (Blue)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue

/datum/loadout_item/under/formal/blue_lawyer_skirt
	name = "Lawyer Suit (Blue, Skirt)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue/skirt

/datum/loadout_item/under/formal/red_lawyer_suit
	name = "Lawyer Suit (Red)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red

/datum/loadout_item/under/formal/red_lawyer_skirt
	name = "Lawyer Suit (Red, Skirt)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red/skirt

/datum/loadout_item/under/formal/pencil
	name = "Pencilskirt"
	item_path = /obj/item/clothing/under/suit/nova/pencil

/datum/loadout_item/under/formal/pencil/checkered
	name = "Pencilskirt  (Checkered)" //This is recolorable, put it right after the base type
	item_path = /obj/item/clothing/under/suit/nova/pencil/checkered

/datum/loadout_item/under/formal/pencil/burgandy
	name = "Pencilskirt (Burgundy)"
	item_path = /obj/item/clothing/under/suit/nova/pencil/burgundy
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/under/formal/pencil/charcoal
	name = "Pencilskirt (Charcoal)"
	item_path = /obj/item/clothing/under/suit/nova/pencil/charcoal
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/under/formal/pencil/green
	name = "Pencilskirt (Green)"
	item_path = /obj/item/clothing/under/suit/nova/pencil/green
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/under/formal/pencil/navy
	name = "Pencilskirt (Navy)"
	item_path = /obj/item/clothing/under/suit/nova/pencil/navy
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/under/formal/pencil/tan
	name = "Pencilskirt (Tan)"
	item_path = /obj/item/clothing/under/suit/nova/pencil/tan
	loadout_flags = parent_type::loadout_flags | LOADOUT_FLAG_BLOCK_GREYSCALING

/datum/loadout_item/under/formal/pencil/noshirt
	name = "Pencilskirt - Shirtless"
	item_path = /obj/item/clothing/under/suit/nova/pencil/noshirt

/datum/loadout_item/under/formal/pencil/checkered/noshirt
	name = "Pencilskirt - Shirtless (Checkered)"
	item_path = /obj/item/clothing/under/suit/nova/pencil/checkered/noshirt

/datum/loadout_item/under/formal/recolorable_suit
	name = "Suit  (Colorable)"
	item_path = /obj/item/clothing/under/suit/nova/recolorable

/datum/loadout_item/under/formal/recolorable_suitskirt
	name = "Suit  (Colorable, Skirt)"
	item_path = /obj/item/clothing/under/suit/nova/recolorable/skirt

/datum/loadout_item/under/formal/beige_suit
	name = "Suit (Beige)"
	item_path = /obj/item/clothing/under/suit/beige

/datum/loadout_item/under/formal/black_suit
	name = "Suit (Black)"
	item_path = /obj/item/clothing/under/suit/black

/datum/loadout_item/under/formal/black_suitskirt
	name = "Suit (Black, Skirt)"
	item_path = /obj/item/clothing/under/suit/black/skirt

/datum/loadout_item/under/formal/burgundy_suit
	name = "Suit (Burgundy)"
	item_path = /obj/item/clothing/under/suit/burgundy

/datum/loadout_item/under/formal/charcoal_suit
	name = "Suit (Charcoal)"
	item_path = /obj/item/clothing/under/suit/charcoal

/datum/loadout_item/under/formal/checkered_suit
	name = "Suit (Checkered)"
	item_path = /obj/item/clothing/under/suit/checkered

/datum/loadout_item/under/formal/navy_suit
	name = "Suit (Navy)"
	item_path = /obj/item/clothing/under/suit/navy

/datum/loadout_item/under/formal/purple_suit
	name = "Suit (Purple)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit

/datum/loadout_item/under/formal/purple_suitskirt
	name = "Suit (Purple, Skirt)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt

/datum/loadout_item/under/formal/sensible_suit
	name = "Suit (Red)"
	item_path = /obj/item/clothing/under/rank/civilian/curator

/datum/loadout_item/under/formal/sensible_skirt
	name = "Suit (Red, Skirt)"
	item_path = /obj/item/clothing/under/rank/civilian/curator/skirt

/datum/loadout_item/under/formal/white_suit
	name = "Suit (White)"
	item_path = /obj/item/clothing/under/suit/white

/datum/loadout_item/under/formal/tuxedo
	name = "Tuxedo Suit"
	item_path = /obj/item/clothing/under/suit/tuxedo

/datum/loadout_item/under/formal/waiter
	name = "Waiter's Suit"
	item_path = /obj/item/clothing/under/suit/waiter

/datum/loadout_item/under/formal/midnight_gown
	name = "Midnight Gown"
	item_path = /obj/item/clothing/under/dress/nova/midnight_gown
	reskin_datum = /datum/atom_skin/midnight_gown

/*
*	erp_item
*/

/datum/loadout_item/under/bunny
	abstract_type = /datum/loadout_item/under/bunny
	group = "Bunny Suits"

/datum/loadout_item/under/bunny/black
	name = "Bunny Suit (Black)"
	item_path = /obj/item/clothing/under/costume/bunnylewd
	erp_item = TRUE
	group = "Bunny Suits"

/datum/loadout_item/under/bunny/white
	name = "Bunny Suit (White)"
	item_path = /obj/item/clothing/under/costume/bunnylewd/white
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/color
	name = "Bunny Suit (Colorable)"
	item_path = /obj/item/clothing/under/costume/playbunny/greyscale
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/wizard
	name = "Bunny Suit (Magician)"
	item_path = /obj/item/clothing/under/costume/playbunny/magician
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/centcom
	name = "Bunny Suit (Centcom)"
	item_path = /obj/item/clothing/under/costume/playbunny/centcom
	erp_item = TRUE
	group = "Bunny Suit"
	restricted_roles = list(ALL_JOBS_CC)

/datum/loadout_item/under/bunny/brit
	name = "Bunny Suit (British)"
	item_path = /obj/item/clothing/under/costume/playbunny/british
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/ussr
	name = "Bunny Suit (Communist)"
	item_path = /obj/item/clothing/under/costume/playbunny/communist
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/usa
	name = "Bunny Suit (USA)"
	item_path = /obj/item/clothing/under/costume/playbunny/usa
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/tailor
	name = "Bunny Suit (Tailormade)"
	item_path = /obj/item/clothing/under/costume/playbunny/custom_playbunny
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/mailman
	name = "Bunny Suit (Courier)"
	item_path = /obj/item/clothing/under/rank/cargo/mailman_bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/gamer
	name = "Bunny Suit (Gamer)"
	item_path = /obj/item/clothing/under/rank/cargo/bitrunner/bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/prisoner
	name = "Bunny Suit (Prisoner)"
	item_path = /obj/item/clothing/under/rank/security/prisoner_bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/janitor
	name = "Bunny Suit (Janitor)"
	item_path = /obj/item/clothing/under/rank/civilian/janitor/bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/bartender
	name = "Bunny Suit (Bartender)"
	item_path = /obj/item/clothing/under/rank/civilian/bartender_bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/chef
	name = "Bunny Suit (Cook)"
	item_path = /obj/item/clothing/under/rank/civilian/cook_bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/hydro
	name = "Bunny Suit (Botany)"
	item_path = /obj/item/clothing/under/rank/civilian/hydroponics/bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/chaplain
	name = "Bunny Suit (Chaplain)"
	item_path = /obj/item/clothing/under/rank/civilian/chaplain_bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/curatorred
	name = "Bunny Suit (Curator, Red)"
	item_path = /obj/item/clothing/under/rank/civilian/curator_bunnysuit_red
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/curatorgreen
	name = "Bunny Suit (Curator, Green)"
	item_path = /obj/item/clothing/under/rank/civilian/curator_bunnysuit_green
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/curatorteal
	name = "Bunny Suit (Curator, Teal)"
	item_path = /obj/item/clothing/under/rank/civilian/curator_bunnysuit_teal
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/lawyerblack
	name = "Bunny Suit (Lawyer, Black)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_black
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/lawyerblue
	name = "Bunny Suit (Lawyer, Blue)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_blue
	erp_item = TRUE
	group = "Bunny Suit"


/datum/loadout_item/under/bunny/lawyerred
	name = "Bunny Suit (Lawyer, Red)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_red
	erp_item = TRUE
	group = "Bunny Suit"


/datum/loadout_item/under/bunny/lawyergood
	name = "Bunny Suit (Lawyer, Good)"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer_bunnysuit_good
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/bunny/psychologist
	name = "Bunny Suit (Lawyer, Good)"
	item_path = /obj/item/clothing/under/rank/civilian/psychologist_bunnysuit
	erp_item = TRUE
	group = "Bunny Suit"

/datum/loadout_item/under/miscellaneous/latex_catsuit
	name = "Latex Catsuit"
	item_path = /obj/item/clothing/under/misc/latex_catsuit
	erp_item = TRUE
	group = "Costumes"

/datum/loadout_item/under/miscellaneous/stripper_outfit
	name = "Tearaway Garments"
	item_path = /obj/item/clothing/under/tearaway_garments
	erp_item = TRUE
	group = "Costumes"
