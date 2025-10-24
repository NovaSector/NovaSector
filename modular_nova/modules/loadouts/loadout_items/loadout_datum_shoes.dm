// LOADOUT ITEM DATUMS FOR THE SHOE SLOT

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

/datum/loadout_item/shoes/kim
	name = "Aerostatic Shoes"
	item_path = /obj/item/clothing/shoes/jackboots/kim

/datum/loadout_item/shoes/high_heels
	name = "High Heels"
	item_path = /obj/item/clothing/shoes/high_heels

/datum/loadout_item/shoes/black_heels
	name = "High Heels - Fancy"
	item_path = /obj/item/clothing/shoes/fancy_heels

/datum/loadout_item/shoes/laceup
	name = "Laceup Shoes"

/datum/loadout_item/shoes/recolorable_laceups
	name = "Laceup Shoes (Colorable)"
	item_path = /obj/item/clothing/shoes/colorable_laceups

/datum/loadout_item/shoes/disco
	name = "Lizardskin Shoes"
	item_path = /obj/item/clothing/shoes/discoshoes

/datum/loadout_item/shoes/sandals
	name = "Sandals"
	item_path = /obj/item/clothing/shoes/sandal

/datum/loadout_item/shoes/recolorable_sandals
	name = "Sandals  (Colorable)"
	item_path = /obj/item/clothing/shoes/colorable_sandals

/datum/loadout_item/shoes/sandals_black
	name = "Sandals (Black)"
	item_path = /obj/item/clothing/shoes/sandal/alt

/datum/loadout_item/shoes/sandals_laced
	name = "Sandals - Velcro"

/datum/loadout_item/shoes/sandals_laced_black
	name = "Sandals - Velcro (Black)"

/datum/loadout_item/shoes/sportshoes
	name = "Sport Shoes"
	item_path = /obj/item/clothing/shoes/sports

/datum/loadout_item/shoes/sport_boots
	name = "Sport Boots"
	item_path = /obj/item/clothing/shoes/sport_boots

/*
*	BOOTS
*/

/datum/loadout_item/shoes/colonial_boots
	name = "Boots - Colonial Half-Boots"
	item_path = /obj/item/clothing/shoes/jackboots/colonial

/datum/loadout_item/shoes/cowboy_recolorable
	name = "Boots - Cowboy (Colorable)"
	item_path = /obj/item/clothing/shoes/cowboy/laced/recolorable

/datum/loadout_item/shoes/cowboy_black
	name = "Boots - Cowboy, Laced (Black)"

/datum/loadout_item/shoes/cowboy_brown
	name = "Boots - Cowboy, Laced (Brown)"

/datum/loadout_item/shoes/cowboy_white
	name = "Boots - Cowboy, Laced (White)"

/datum/loadout_item/shoes/jackboots/frontier
	name = "Boots - Heavy Frontier"
	item_path = /obj/item/clothing/shoes/jackboots/frontier_colonist

/datum/loadout_item/shoes/timbs
	name = "Boots - Hiking"
	item_path = /obj/item/clothing/shoes/jackboots/timbs

/datum/loadout_item/shoes/jackboots
	name = "Boots - Jackboots"
	item_path = /obj/item/clothing/shoes/jackboots

/datum/loadout_item/shoes/recolorable_jackboots
	name = "Boots - Jackboots  (Colorable)"
	item_path = /obj/item/clothing/shoes/jackboots/recolorable

/datum/loadout_item/shoes/jackboots/heel //Donator reward for Thedragmeme, unrestricted at their request
	name = "Boots - Jackboots, High-Heel"
	item_path = /obj/item/clothing/shoes/jackboots/heel

/datum/loadout_item/shoes/kneeboot
	name = "Boots - Jackboots, Knee"
	item_path = /obj/item/clothing/shoes/jackboots/knee

/datum/loadout_item/shoes/jungle
	name = "Boots - Jungle"
	item_path = /obj/item/clothing/shoes/jungleboots

/datum/loadout_item/shoes/mining_boots
	name = "Boots - Mining"
	item_path = /obj/item/clothing/shoes/workboots/mining

/datum/loadout_item/shoes/duck_boots
	name = "Boots - Northeastern Duckboots"
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
*	SNEAKERS
*/

/datum/loadout_item/shoes/greyscale_sneakers
	name = "Sneakers  (Colorable)"
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

/datum/loadout_item/shoes/wraps_colorable
	name = "Wraps  (Colorable)"
	item_path = /obj/item/clothing/shoes/wraps/colourable

/datum/loadout_item/shoes/bluecuffs
	name = "Wraps (Blue)"
	item_path = /obj/item/clothing/shoes/wraps/blue

/datum/loadout_item/shoes/gildedcuffs
	name = "Wraps (Gilded)"
	item_path = /obj/item/clothing/shoes/wraps

/datum/loadout_item/shoes/redcuffs
	name = "Wraps (Red)"
	item_path = /obj/item/clothing/shoes/wraps/red

/datum/loadout_item/shoes/silvercuffs
	name = "Wraps (Silver)"
	item_path = /obj/item/clothing/shoes/wraps/silver

/datum/loadout_item/shoes/clothwrap
	name = "Wraps - Cloth"
	item_path = /obj/item/clothing/shoes/wraps/cloth

/*
*	COSTUME
*/

/datum/loadout_item/shoes/christmas
	name = "Christmas Boots"
	item_path = /obj/item/clothing/shoes/winterboots/christmas
	group = "Costumes"

/datum/loadout_item/shoes/glow_shoes
	name = "Glowing Shoes (Colorable)"
	group = "Costumes"

/datum/loadout_item/shoes/griffin
	name = "Griffon Boots"
	item_path = /obj/item/clothing/shoes/griffin
	group = "Costumes"

/datum/loadout_item/shoes/jingleshoes
	name = "Jester Shoes"
	item_path = /obj/item/clothing/shoes/jester_shoes
	group = "Costumes"

/datum/loadout_item/shoes/rollerskates
	name = "Roller Skates"
	item_path = /obj/item/clothing/shoes/wheelys/rollerskates
	group = "Costumes"

/datum/loadout_item/shoes/wheelys
	name = "Wheely-Heels"
	item_path = /obj/item/clothing/shoes/wheelys
	group = "Costumes"

/*
*	JOB-RESTRICTED
*/

/datum/loadout_item/shoes/jackboots_sec_blue
	name = "Security Jackboots (Blue)"
	item_path = /obj/item/clothing/shoes/jackboots/sec/blue
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

/datum/loadout_item/shoes/clown_shoes
	abstract_type = /datum/loadout_item/shoes/clown_shoes
	restricted_roles = list(JOB_CLOWN)
	group = "Job-Locked"

/datum/loadout_item/shoes/clown_shoes/jester
	name = "Clown's Jester Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/jester

/datum/loadout_item/shoes/clown_shoes/pink
	name = "Pink Clown Shoes"
	item_path = /obj/item/clothing/shoes/clown_shoes/pink

/*
*	erp_item
*/

/datum/loadout_item/shoes/ballet_heels
	name = "Ballet Heels"
	item_path = /obj/item/clothing/shoes/ballet_heels
	erp_item = TRUE

/datum/loadout_item/shoes/dominaheels
	name = "Dominant Heels"
	item_path = /obj/item/clothing/shoes/ballet_heels/domina_heels
	erp_item = TRUE

/datum/loadout_item/shoes/latex_socks
	name = "Latex Socks"
	item_path = /obj/item/clothing/shoes/latex_socks
	erp_item = TRUE

/*
*	DONATOR
*/

/datum/loadout_item/shoes/donator
	abstract_type = /datum/loadout_item/shoes/donator
	donator_only = TRUE

/datum/loadout_item/shoes/donator/blackjackboots
	name = "Boots - Jackboots (Black)"
	item_path = /obj/item/clothing/shoes/jackboots/black

/datum/loadout_item/shoes/donator/rainbow
	name = "Sneakers - Rainbow"
	item_path = /obj/item/clothing/shoes/sneakers/rainbow
