// LOADOUT ITEM DATUMS FOR POCKET ITEMS, PLACED DIRECTLY INTO THE BACKPACK

/datum/loadout_category/pocket
	tab_order = /datum/loadout_category/toys::tab_order + 1

/datum/loadout_item/pocket_items/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE) // these go in the backpack
	return FALSE

/datum/loadout_item/pocket_items/wallet/get_item_information()
	. = ..()
	.[FA_ICON_BOX] = "Auto-Filled"

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/pocket_items/soap
	name = "Bar of Soap"
	item_path = /obj/item/soap

/datum/loadout_item/pocket_items/tapeplayer
	name = "Cassette Recorder"
	item_path = /obj/item/taperecorder

/datum/loadout_item/pocket_items/tape
	name = "Cassette Tape"
	item_path = /obj/item/tape/random

/datum/loadout_item/pocket_items/cheaplighter
	name = "Lighter - Cheap"
	item_path = /obj/item/lighter/greyscale

/datum/loadout_item/pocket_items/lighter
	name = "Lighter - Zippo"

/datum/loadout_item/pocket_items/cigarettes
	name = "Cigarette Pack"
	item_path = /obj/item/storage/fancy/cigarettes

/datum/loadout_item/pocket_items/cigar
	name = "Cigar"
	item_path = /obj/item/cigarette/cigar

/datum/loadout_item/pocket_items/folder
	name = "Folder"
	item_path = /obj/item/folder

/datum/loadout_item/pocket_items/matches
	name = "Matchbox"
	item_path = /obj/item/storage/box/matches

/datum/loadout_item/pocket_items/link_scryer
	name = "MODlink Scryer"
	item_path = /obj/item/clothing/neck/link_scryer/loaded

/datum/loadout_item/pocket_items/modular_laptop
	name = "Modular Laptop"
	item_path = /obj/item/modular_computer/laptop/preset/civilian/closed

/datum/loadout_item/pocket_items/newspaper
	name = "Newspaper"
	item_path = /obj/item/newspaper

/datum/loadout_item/pocket_items/cross
	name = "Ornate Cross"
	item_path = /obj/item/crucifix

/datum/loadout_item/pocket_items/gum_pack
	name = "Pack of Gum"
	item_path = /obj/item/storage/box/gum

/datum/loadout_item/pocket_items/gum_pack_nicotine
	name = "Pack of Gum - Nicotine"
	item_path = /obj/item/storage/box/gum/nicotine

/datum/loadout_item/pocket_items/gum_pack_hp
	name = "Pack of Gum - HP+"
	item_path = /obj/item/storage/box/gum/happiness

/datum/loadout_item/pocket_items/multipen
	name = "Pen - Multicolored"
	item_path = /obj/item/pen/fourcolor

/datum/loadout_item/pocket_items/fountainpen
	name = "Pen - Fancy"
	item_path = /obj/item/pen/fountain

/datum/loadout_item/pocket_items/paicard
	name = "Personal AI Device"
	item_path = /obj/item/pai_card

/datum/loadout_item/pocket_items/rag
	name = "Rag"
	item_path = /obj/item/rag

/datum/loadout_item/pocket_items/razor
	name = "Razor"
	item_path = /obj/item/razor

/datum/loadout_item/pocket_items/ttsdevice
	name = "Text-to-Speech Device"
	item_path = /obj/item/ttsdevice

/datum/loadout_item/pocket_items/ringbox_diamond
	name = "Ring Box - Diamond"
	item_path = /obj/item/storage/fancy/ringbox/diamond

/datum/loadout_item/pocket_items/ringbox_gold
	name = "Ring Box - Gold"
	item_path = /obj/item/storage/fancy/ringbox

/datum/loadout_item/pocket_items/ringbox_silver
	name = "Ring Box - Silver"
	item_path = /obj/item/storage/fancy/ringbox/silver

/*
*	UTILITY
*/

/datum/loadout_item/pocket_items/medkit_pouch
	name = "Colonial First Aid Pouch (Empty)"
	item_path = /obj/item/storage/pouch/cin_medkit

/datum/loadout_item/pocket_items/general_pouch
	name = "Colonial General Purpose Pouch (Empty)"
	item_path = /obj/item/storage/pouch/cin_general

/datum/loadout_item/pocket_items/medipen_pouch
	name = "Colonial Medipen Pouch (Empty)"
	item_path = /obj/item/storage/pouch/cin_medipens

/datum/loadout_item/pocket_items/deforest_cheesekit
	name = "Medical Kit - Civil Defense"
	item_path = /obj/item/storage/medkit/civil_defense/stocked

/datum/loadout_item/pocket_items/medkit
	name = "Medical Kit - First-Aid"
	item_path = /obj/item/storage/medkit/regular

/datum/loadout_item/pocket_items/deforest_frontiermedkit
	name = "Medical Kit - Frontier"
	item_path = /obj/item/storage/medkit/frontier/stocked

/datum/loadout_item/pocket_items/synthetic_medkit
	name = "Medical Kit - Robotics"
	item_path = /obj/item/storage/medkit/robotic_repair/stocked

/datum/loadout_item/pocket_items/mini_extinguisher
	name = "Mini Fire Extinguisher"
	item_path = /obj/item/extinguisher/mini

/datum/loadout_item/pocket_items/neuroware_spacedrugs
	name = "Neuroware Chips Box (Kaleido)"
	item_path = /obj/item/storage/box/flat/neuroware/space_drugs

/datum/loadout_item/pocket_items/neuroware_thc
	name = "Neuroware Chips Box (Mr.Stoned)"
	item_path = /obj/item/storage/box/flat/neuroware/thc

/datum/loadout_item/pocket_items/neuroware_mindbreaker
	name = "Neuroware Chips Box (PosiBlaster64)"
	item_path = /obj/item/storage/box/flat/neuroware/mindbreaker

/datum/loadout_item/pocket_items/binoculars
	name = "Pair of Binoculars"
	item_path = /obj/item/binoculars

/datum/loadout_item/pocket_items/drugs_happy
	name = "Pillbottle - Happy Pills"
	item_path = /obj/item/storage/pill_bottle/happy

/datum/loadout_item/pocket_items/drugs_lsd
	name = "Pillbottle - Mindbreaker"
	item_path = /obj/item/storage/pill_bottle/lsd

/datum/loadout_item/pocket_items/random_pizza
	name = "Random Pizza Box"
	item_path = /obj/item/pizzabox/random

/datum/loadout_item/pocket_items/moth_mre
	name = "Rations - Mothic"
	item_path = /obj/item/storage/box/mothic_rations

/datum/loadout_item/pocket_items/colonial_mre
	name = "Rations - Colonial"
	item_path = /obj/item/storage/box/colonial_rations

/datum/loadout_item/pocket_items/drugs_weed
	name = "Seeds - Cannabis"
	item_path = /obj/item/seeds/cannabis

/datum/loadout_item/pocket_items/drugs_liberty
	name = "Seeds - Liberty Cap"
	item_path = /obj/item/seeds/liberty

/datum/loadout_item/pocket_items/drugs_reishi
	name = "Seeds - Reishi"
	item_path = /obj/item/seeds/reishi

/datum/loadout_item/pocket_items/six_beer
	name = "Six-Pack - Beer"
	item_path = /obj/item/storage/cans/sixbeer

/datum/loadout_item/pocket_items/six_soda
	name = "Six-Pack - Soda"
	item_path = /obj/item/storage/cans/sixsoda

/datum/loadout_item/pocket_items/power_cell
	name = "Standard Power Cell"
	item_path = /obj/item/stock_parts/power_store/cell

/datum/loadout_item/pocket_items/cloth_ten
	name = "Ten Cloth Sheets"
	item_path = /obj/item/stack/sheet/cloth/ten

/datum/loadout_item/pocket_items/ingredients
	name = "Wildcard Ingredient Box"
	item_path = /obj/item/storage/box/ingredients/wildcard

/*
*	COSMETICS
*/

/datum/loadout_item/pocket_items/hairbrush
	name = "Brush"
	item_path = /obj/item/hairbrush
	group = "Cosmetics"

/datum/loadout_item/pocket_items/comb
	name = "Comb"
	item_path = /obj/item/hairbrush/comb
	group = "Cosmetics"

/datum/loadout_item/pocket_items/hairbrush
	name = "Brush"
	item_path = /obj/item/hairbrush
	group = "Cosmetics"

/datum/loadout_item/pocket_items/dye
	group = "Cosmetics"

/datum/loadout_item/pocket_items/hair_tie
	name = "Hair Tie"
	item_path = /obj/item/clothing/head/hair_tie
	group = "Cosmetics"

/datum/loadout_item/pocket_items/hair_tie_scrunchie
	name = "Hair Tie - Scrunchie"
	item_path = /obj/item/clothing/head/hair_tie/scrunchie
	group = "Cosmetics"

/datum/loadout_item/pocket_items/hair_tie_plastic_beads
	name = "Hair Tie - Plastic"
	item_path = /obj/item/clothing/head/hair_tie/plastic_beads
	group = "Cosmetics"

/datum/loadout_item/pocket_items/hhmirror
	name = "Handheld Mirror"
	item_path = /obj/item/hhmirror
	group = "Cosmetics"

//LIPSTICK
/datum/loadout_item/pocket_items/lipstick
	group = "Cosmetics"

/datum/loadout_item/pocket_items/lipstick_black
	name = "Lipstick (Black)"
	item_path = /obj/item/lipstick/black
	group = "Cosmetics"

/datum/loadout_item/pocket_items/lipstick_blue
	name = "Lipstick (Blue)"
	item_path = /obj/item/lipstick/blue
	group = "Cosmetics"

/datum/loadout_item/pocket_items/lipstick_green
	name = "Lipstick (Green)"
	item_path = /obj/item/lipstick/green
	group = "Cosmetics"

/datum/loadout_item/pocket_items/lipstick_jade
	name = "Lipstick (Jade)"
	item_path = /obj/item/lipstick/jade
	group = "Cosmetics"

/datum/loadout_item/pocket_items/lipstick_purple
	name = "Lipstick (Purple)"
	item_path = /obj/item/lipstick/purple
	group = "Cosmetics"

/datum/loadout_item/pocket_items/lipstick_white
	name = "Lipstick (White)"
	item_path = /obj/item/lipstick/white
	group = "Cosmetics"

//PERFUME
/datum/loadout_item/pocket_items/fragrance_amber
	name = "Perfume (Amber)"
	item_path = /obj/item/perfume/amber
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_cherry
	name = "Perfume (Cherry)"
	item_path = /obj/item/perfume/cherry
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_jasmine
	name = "Perfume (Jasmine)"
	item_path = /obj/item/perfume/jasmine
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_mint
	name = "Perfume (Mint)"
	item_path = /obj/item/perfume/mint
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_pear
	name = "Perfume (Pear)"
	item_path = /obj/item/perfume/pear
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_rose
	name = "Perfume (Rose)"
	item_path = /obj/item/perfume/rose
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_strawberry
	name = "Perfume (Strawberry)"
	item_path = /obj/item/perfume/strawberry
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_vanilla
	name = "Perfume (Vanilla)"
	item_path = /obj/item/perfume/vanilla
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_wood
	name = "Perfume (Wood)"
	item_path = /obj/item/perfume/wood
	group = "Cosmetics"

/datum/loadout_item/pocket_items/fragrance_cologne
	name = "Perfume - Cologne"
	item_path = /obj/item/perfume/cologne
	group = "Cosmetics"

/*
*	JOB-LOCKED
*/
// No group (groups should be ~5+ items)

/datum/loadout_item/pocket_items/crusher_sword_kit
	name = "Crusher Retool Kit"
	item_path = /obj/item/crusher_trophy/retool_kit
	restricted_roles = list(JOB_SHAFT_MINER)

/*
*	DONATOR
*/

/datum/loadout_item/pocket_items/donator
	abstract_type = /datum/loadout_item/pocket_items/donator
	donator_only = TRUE

/datum/loadout_item/pocket_items/donator/coin
	name = "Iron Coin"
	item_path = /obj/item/coin/iron

/datum/loadout_item/pocket_items/donator/havana_cigar_case
	name = "Havanian Cigars"
	item_path = /obj/item/storage/fancy/cigarettes/cigars/havana

/datum/loadout_item/pocket_items/donator/vape
	name = "E-Cigarette"
	item_path = /obj/item/vape
