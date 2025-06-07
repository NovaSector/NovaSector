// LOADOUT ITEM DATUMS FOR THE SHOES SLOT

/datum/loadout_category/shoes
	tab_order = /datum/loadout_category/hands::tab_order + 1

/datum/loadout_item/shoes
	abstract_type = /datum/loadout_item/shoes

/datum/loadout_item/shoes/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.shoes))
		.. ()
		return TRUE

/datum/loadout_item/shoes/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.shoes)
			LAZYADD(outfit.backpack_contents, outfit.shoes)
		outfit.shoes = item_path
	else
		outfit.shoes = item_path

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/shoes/black_heels
	name = "Fancy Heels"
	item_path = /obj/item/clothing/shoes/fancy_heels

/datum/loadout_item/shoes/griffin
	name = "Griffon Boots"
	item_path = /obj/item/clothing/shoes/griffin

/datum/loadout_item/shoes/high_heels
	name = "High Heels"
	item_path = /obj/item/clothing/shoes/high_heels

/datum/loadout_item/shoes/jingleshoes
	name = "Jester Shoes"
	item_path = /obj/item/clothing/shoes/jester_shoes

/datum/loadout_item/shoes/rollerskates
	name = "Roller Skates"
	item_path = /obj/item/clothing/shoes/wheelys/rollerskates

/datum/loadout_item/shoes/sandals
	name = "Sandals"
	item_path = /obj/item/clothing/shoes/sandal

/datum/loadout_item/shoes/sandals_black
	name = "Sandals (Black)"
	item_path = /obj/item/clothing/shoes/sandal/alt

/datum/loadout_item/shoes/recolorable_sandals
	name = "Sandals (Colorable)"
	item_path = /obj/item/clothing/shoes/colorable_sandals

/datum/loadout_item/shoes/recolorable_laceups
	name = "Shoes (Laceup, Colorable)"
	item_path = /obj/item/clothing/shoes/colorable_laceups

/datum/loadout_item/shoes/disco
	name = "Shoes - Green Lizardskin"
	item_path = /obj/item/clothing/shoes/discoshoes

/datum/loadout_item/shoes/sportshoes
	name = "Shoes - Sport"
	item_path = /obj/item/clothing/shoes/sports

/datum/loadout_item/shoes/wheelys
	name = "Wheely-Heels"
	item_path = /obj/item/clothing/shoes/wheelys

/*
*	JACKBOOTS
*/

/datum/loadout_item/shoes/jackboots
	name = "Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots

/datum/loadout_item/shoes/recolorable_jackboots
	name = "Jackboots (Colorable)"
	item_path = /obj/item/clothing/shoes/jackboots/recolorable

// Thedragmeme's donator reward, they've decided to make them available to everybody.
/datum/loadout_item/shoes/jackboots/heel
	name = "Jackboots - High-Heel"
	item_path = /obj/item/clothing/shoes/jackboots/heel

/datum/loadout_item/shoes/kneeboot
	name = "Jackboots - Knee"
	item_path = /obj/item/clothing/shoes/jackboots/knee

/*
*	MISC BOOTS
*/

/datum/loadout_item/shoes/kim
	name = "Boots - Aerostatic"
	item_path = /obj/item/clothing/shoes/kim

/datum/loadout_item/shoes/colonial_boots
	name = "Boots - Colonial Half-Boots"
	item_path = /obj/item/clothing/shoes/jackboots/colonial

/datum/loadout_item/shoes/jackboots/frontier
	name = "Boots - Heavy Frontier"
	item_path = /obj/item/clothing/shoes/jackboots/frontier_colonist

/datum/loadout_item/shoes/timbs
	name = "Boots - Hiking"
	item_path = /obj/item/clothing/shoes/jackboots/timbs

/datum/loadout_item/shoes/jungle
	name = "Boots - Jungle"
	item_path = /obj/item/clothing/shoes/jungleboots

/datum/loadout_item/shoes/mining_boots
	name = "Boots - Mining"
	item_path = /obj/item/clothing/shoes/workboots/mining

/datum/loadout_item/shoes/duck_boots
	name = "Boots - Northeastern Duck"
	item_path = /obj/item/clothing/shoes/jackboots/duckboots

/datum/loadout_item/shoes/russian_boots
	name = "Boots - Russian"
	item_path = /obj/item/clothing/shoes/russian

/datum/loadout_item/shoes/winter_boots
	name = "Boots - Winter"
	item_path = /obj/item/clothing/shoes/winterboots

/datum/loadout_item/shoes/work_boots
	name = "Boots - Work"
	item_path = /obj/item/clothing/shoes/workboots

/*
*	COWBOY
*/

/datum/loadout_item/shoes/cowboy_recolorable
	name = "Boots (Cowboy, Colorable)"
	item_path = /obj/item/clothing/shoes/cowboy/laced/recolorable

/*
*	SNEAKERS
*/

/datum/loadout_item/shoes/greyscale_sneakers
	name = "Sneakers, Colorable"
	item_path = /obj/item/clothing/shoes/sneakers

/datum/loadout_item/shoes/black_sneakers
	name = "Sneakers (Black)"
	item_path = /obj/item/clothing/shoes/sneakers/black
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/shoes/blue_sneakers
	name = "Sneakers (Blue)"
	item_path = /obj/item/clothing/shoes/sneakers/blue
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/shoes/brown_sneakers
	name = "Sneakers (Brown)"
	item_path = /obj/item/clothing/shoes/sneakers/brown
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/shoes/green_sneakers
	name = "Sneakers (Green)"
	item_path = /obj/item/clothing/shoes/sneakers/green
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/shoes/orange_sneakers
	name = "Sneakers (Orange)"
	item_path = /obj/item/clothing/shoes/sneakers/orange
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/shoes/purple_sneakers
	name = "Sneakers (Purple)"
	item_path = /obj/item/clothing/shoes/sneakers/purple
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/shoes/white_sneakers
	name = "Sneakers (White)"
	item_path = /obj/item/clothing/shoes/sneakers/white
	can_be_greyscale = DONT_GREYSCALE

/datum/loadout_item/shoes/yellow_sneakers
	name = "Sneakers (Yellow)"
	item_path = /obj/item/clothing/shoes/sneakers/yellow
	can_be_greyscale = DONT_GREYSCALE

/*
*	LEG WRAPS
*/

/datum/loadout_item/shoes/cuffs
	abstract_type = /datum/loadout_item/shoes/cuffs

/datum/loadout_item/shoes/cuffs/colourable
	name = "Leg Wraps, Colorable"
	item_path = /obj/item/clothing/shoes/wraps/colourable

/datum/loadout_item/shoes/gildedcuffs
	name = "Leg Wraps (Gilded)"
	item_path = /obj/item/clothing/shoes/wraps

/datum/loadout_item/shoes/silvercuffs
	name = "Leg Wraps (Silver)"
	item_path = /obj/item/clothing/shoes/wraps/silver

/datum/loadout_item/shoes/redcuffs
	name = "Leg Wraps (Red)"
	item_path = /obj/item/clothing/shoes/wraps/red

/datum/loadout_item/shoes/bluecuffs
	name = "Leg Wraps (Blue)"
	item_path = /obj/item/clothing/shoes/wraps/blue

/datum/loadout_item/shoes/clothwrap
	name = "Leg Wraps - Cloth"
	item_path = /obj/item/clothing/shoes/wraps/cloth

/*
*	SEASONAL
*/

/datum/loadout_item/shoes/christmas
	name = "Christmas Boots (Red)"
	item_path = /obj/item/clothing/shoes/winterboots/christmas

/datum/loadout_item/shoes/christmas/green
	name = "Christmas Boots (Green)"
	item_path = /obj/item/clothing/shoes/winterboots/christmas/green


/*
*	JOB-RESTRICTED
*/

/datum/loadout_item/shoes/clown_shoes
	abstract_type = /datum/loadout_item/shoes/clown_shoes
	group = "Job-Locked"
	restricted_roles = list(JOB_CLOWN)

/datum/loadout_item/shoes/clown_shoes/jester
	name = "Clown Shoes (Jester)"
	item_path = /obj/item/clothing/shoes/clown_shoes/jester

/datum/loadout_item/shoes/clown_shoes/pink
	name = "Clown Shoes (Pink)"
	item_path = /obj/item/clothing/shoes/clown_shoes/pink

/datum/loadout_item/shoes/jackboots_sec_blue
	name = "Security Jackboots (Blue)"
	item_path = /obj/item/clothing/shoes/jackboots/sec/blue
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

/*
*	ERP
*/

/datum/loadout_item/shoes/dominaheels
	name = "Dominant Heels"
	item_path = /obj/item/clothing/shoes/ballet_heels/domina_heels
	erp_item = TRUE

/datum/loadout_item/shoes/latex_socks
	name = "Latex Socks"
	item_path = /obj/item/clothing/shoes/latex_socks
	erp_item = TRUE

/datum/loadout_item/shoes/ballet_heels
	name = "Ballet Heels"
	item_path = /obj/item/clothing/shoes/ballet_heels
	erp_item = TRUE

/*
*	DONATOR
*/

/datum/loadout_item/shoes/donator
	abstract_type = /datum/loadout_item/shoes/donator
	donator_only = TRUE

/datum/loadout_item/shoes/donator/blackjackboots
	name = "Black Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots/black

/datum/loadout_item/shoes/donator/rainbow
	name = "Rainbow Converse"
	item_path = /obj/item/clothing/shoes/sneakers/rainbow
