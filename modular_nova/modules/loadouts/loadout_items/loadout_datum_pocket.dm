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
	group = "Gear"

/datum/loadout_item/pocket_items/tapeplayer
	name = "Cassette Recorder"
	item_path = /obj/item/taperecorder
	group = "Comfort"

/datum/loadout_item/pocket_items/tape
	name = "Cassette Tape"
	item_path = /obj/item/tape/random
	group = "Comfort"

/datum/loadout_item/pocket_items/cheaplighter
	name = "Lighter - Cheap"
	item_path = /obj/item/lighter/greyscale
	group = "Comfort"

/datum/loadout_item/pocket_items/lighter
	name = "Lighter - Zippo"
	group = "Comfort"

/datum/loadout_item/pocket_items/cigarettes
	name = "Cigarette Pack"
	item_path = /obj/item/storage/fancy/cigarettes
	group = "Comfort"

/datum/loadout_item/pocket_items/cigar
	name = "Cigar"
	item_path = /obj/item/cigarette/cigar
	group = "Comfort"

/datum/loadout_item/pocket_items/folder
	name = "Folder"
	item_path = /obj/item/folder
	group = "Comfort"

/datum/loadout_item/pocket_items/matches
	name = "Matchbox"
	item_path = /obj/item/storage/box/matches
	group = "Comfort"

/datum/loadout_item/pocket_items/link_scryer
	name = "MODlink Scryer"
	item_path = /obj/item/clothing/neck/link_scryer/loaded
	group = "Gear"

/datum/loadout_item/pocket_items/modular_laptop
	name = "Modular Laptop"
	item_path = /obj/item/modular_computer/laptop/preset/civilian/closed
	group = "Gear"

/datum/loadout_item/pocket_items/newspaper
	name = "Newspaper"
	item_path = /obj/item/newspaper
	group = "Comfort"

/datum/loadout_item/pocket_items/cross
	name = "Ornate Cross"
	item_path = /obj/item/crucifix
	group = "Comfort"

/datum/loadout_item/pocket_items/gum_pack
	name = "Pack of Gum"
	item_path = /obj/item/storage/box/gum
	group = "Comfort"

/datum/loadout_item/pocket_items/gum_pack_nicotine
	name = "Pack of Gum - Nicotine"
	item_path = /obj/item/storage/box/gum/nicotine
	group = "Comfort"

/datum/loadout_item/pocket_items/gum_pack_hp
	name = "Pack of Gum - HP+"
	item_path = /obj/item/storage/box/gum/happiness
	group = "Comfort"

/datum/loadout_item/pocket_items/multipen
	name = "Pen - Multicolored"
	item_path = /obj/item/pen/fourcolor
	group = "Comfort"

/datum/loadout_item/pocket_items/fountainpen
	name = "Pen - Fancy"
	item_path = /obj/item/pen/fountain
	group = "Comfort"

/datum/loadout_item/pocket_items/paicard
	name = "Personal AI Device"
	item_path = /obj/item/pai_card
	group = "Comfort"

/datum/loadout_item/pocket_items/rag
	name = "Rag"
	item_path = /obj/item/rag
	group = "Gear"

/datum/loadout_item/pocket_items/razor
	name = "Razor"
	item_path = /obj/item/razor
	group = "Comfort"

/datum/loadout_item/pocket_items/ttsdevice
	name = "Text-to-Speech Device"
	item_path = /obj/item/ttsdevice
	group = "Gear"

/datum/loadout_item/pocket_items/ringbox_diamond
	name = "Ring Box - Diamond"
	item_path = /obj/item/storage/fancy/ringbox/diamond
	group = "Comfort"

/datum/loadout_item/pocket_items/ringbox_gold
	name = "Ring Box - Gold"
	item_path = /obj/item/storage/fancy/ringbox
	group = "Comfort"

/datum/loadout_item/pocket_items/ringbox_silver
	name = "Ring Box - Silver"
	item_path = /obj/item/storage/fancy/ringbox/silver
	group = "Comfort"

/datum/loadout_item/pocket_items/paperbin
	name = "Paperbin - Paper"
	item_path = /obj/item/paper_bin
	group = "Comfort"

/datum/loadout_item/pocket_items/paperbin_carbon
	name = "Paperbin - Carbon"
	item_path = /obj/item/paper_bin/carbon
	group = "Comfort"

/datum/loadout_item/pocket_items/paperbin_construction
	name = "Paperbin - Construction"
	item_path = /obj/item/paper_bin/construction
	group = "Comfort"

/datum/loadout_item/pocket_items/paperbin_natural
	name = "Paperbin - Natural"
	item_path = /obj/item/paper_bin/bundlenatural
	group = "Comfort"

/*
*	UTILITY
*/

/datum/loadout_item/pocket_items/medkit_pouch
	name = "Colonial First Aid Pouch (Empty)"
	item_path = /obj/item/storage/pouch/cin_medkit
	group = "Gear"

/datum/loadout_item/pocket_items/general_pouch
	name = "Colonial General Purpose Pouch (Empty)"
	item_path = /obj/item/storage/pouch/cin_general
	group = "Gear"

/datum/loadout_item/pocket_items/medipen_pouch
	name = "Colonial Medipen Pouch (Empty)"
	item_path = /obj/item/storage/pouch/cin_medipens
	group = "Gear"

/datum/loadout_item/pocket_items/deforest_cheesekit
	name = "Medical Kit - Civil Defense"
	item_path = /obj/item/storage/medkit/civil_defense/stocked
	group = "Gear"

/datum/loadout_item/pocket_items/medkit
	name = "Medical Kit - First-Aid"
	item_path = /obj/item/storage/medkit/regular
	group = "Gear"

/datum/loadout_item/pocket_items/deforest_frontiermedkit
	name = "Medical Kit - Frontier"
	item_path = /obj/item/storage/medkit/frontier/stocked
	group = "Gear"

/datum/loadout_item/pocket_items/synthetic_medkit
	name = "Medical Kit - Robotics"
	item_path = /obj/item/storage/medkit/robotic_repair/stocked
	group = "Gear"

/datum/loadout_item/pocket_items/mini_extinguisher
	name = "Mini Fire Extinguisher"
	item_path = /obj/item/extinguisher/mini
	group = "Gear"

/datum/loadout_item/pocket_items/neuroware_spacedrugs
	name = "Neuroware Chips Box (Kaleido)"
	item_path = /obj/item/storage/box/flat/neuroware/space_drugs
	group = "Comfort"

/datum/loadout_item/pocket_items/neuroware_thc
	name = "Neuroware Chips Box (Mr.Stoned)"
	item_path = /obj/item/storage/box/flat/neuroware/thc
	group = "Comfort"

/datum/loadout_item/pocket_items/neuroware_mindbreaker
	name = "Neuroware Chips Box (PosiBlaster64)"
	item_path = /obj/item/storage/box/flat/neuroware/mindbreaker
	group = "Comfort"

/datum/loadout_item/pocket_items/binoculars
	name = "Pair of Binoculars"
	item_path = /obj/item/binoculars
	group = "Gear"

/datum/loadout_item/pocket_items/drugs_happy
	name = "Pillbottle - Happy Pills"
	item_path = /obj/item/storage/pill_bottle/happy
	group = "Comfort"

/datum/loadout_item/pocket_items/drugs_lsd
	name = "Pillbottle - Mindbreaker"
	item_path = /obj/item/storage/pill_bottle/lsd
	group = "Comfort"

/datum/loadout_item/pocket_items/random_pizza
	name = "Random Pizza Box"
	item_path = /obj/item/pizzabox/random
	group = "Comfort"

/datum/loadout_item/pocket_items/moth_mre
	name = "Rations - Mothic"
	item_path = /obj/item/storage/box/mothic_rations
	group = "Comfort"

/datum/loadout_item/pocket_items/colonial_mre
	name = "Rations - Colonial"
	item_path = /obj/item/storage/box/colonial_rations
	group = "Comfort"

/datum/loadout_item/pocket_items/drugs_weed
	name = "Seeds - Cannabis"
	item_path = /obj/item/seeds/cannabis
	group = "Comfort"

/datum/loadout_item/pocket_items/drugs_liberty
	name = "Seeds - Liberty Cap"
	item_path = /obj/item/seeds/liberty
	group = "Comfort"

/datum/loadout_item/pocket_items/drugs_reishi
	name = "Seeds - Reishi"
	item_path = /obj/item/seeds/reishi
	group = "Comfort"

/datum/loadout_item/pocket_items/six_beer
	name = "Six-Pack - Beer"
	item_path = /obj/item/storage/cans/sixbeer
	group = "Comfort"

/datum/loadout_item/pocket_items/six_soda
	name = "Six-Pack - Soda"
	item_path = /obj/item/storage/cans/sixsoda
	group = "Comfort"

/datum/loadout_item/pocket_items/power_cell
	name = "Standard Power Cell"
	item_path = /obj/item/stock_parts/power_store/cell
	group = "Comfort"

/datum/loadout_item/pocket_items/cloth_ten
	name = "Ten Cloth Sheets"
	item_path = /obj/item/stack/sheet/cloth/ten
	group = "Comfort"

/datum/loadout_item/pocket_items/ingredients
	name = "Wildcard Ingredient Box"
	item_path = /obj/item/storage/box/ingredients/wildcard
	group = "Comfort"

/datum/loadout_item/pocket_items/shaker
	name = "Drink Shaker"
	item_path = /obj/item/reagent_containers/cup/glass/shaker
	group = "Comfort"

/datum/loadout_item/pocket_items/primitive_centrifuge
	name = "Primitive Centrifuge"
	item_path = /obj/item/reagent_containers/cup/primitive_centrifuge
	group = "Comfort"

/datum/loadout_item/pocket_items/pizza_voucher
	name = "Pizza Voucher"
	item_path = /obj/item/pizzavoucher
	group = "Comfort"

/datum/loadout_item/pocket_items/spess_knife
	name = "Spess Knife"
	item_path = /obj/item/spess_knife
	group = "Comfort"

/datum/loadout_item/pocket_items/jerry_can
	name = "Jerry Can"
	item_path = /obj/item/reagent_containers/cup/jerrycan
	group = "Comfort"
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
*	FLAGS
*/

/datum/loadout_item/pocket_items/gay_pride_flag
	name = "Pride Flag - Rainbow"
	item_path = /obj/item/sign/flag/pride/gay
	group = "Comfort"

/datum/loadout_item/pocket_items/ace_pride_flag
	name = "Pride Flag - Asexual"
	item_path = /obj/item/sign/flag/pride/ace
	group = "Comfort"

/datum/loadout_item/pocket_items/bi_pride_flag
	name = "Pride Flag - Bisexual"
	item_path = /obj/item/sign/flag/pride/bi
	group = "Comfort"

/datum/loadout_item/pocket_items/lesbian_pride_flag
	name = "Pride Flag - Lesbian"
	item_path = /obj/item/sign/flag/pride/lesbian
	group = "Comfort"

/datum/loadout_item/pocket_items/pan_pride_flag
	name = "Pride Flag - Pansexual"
	item_path = /obj/item/sign/flag/pride/pan
	group = "Comfort"

/datum/loadout_item/pocket_items/trans_pride_flag
	name = "Pride Flag - Transgender"
	item_path = /obj/item/sign/flag/pride/trans
	group = "Comfort"
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
	group = "Comfort"

/datum/loadout_item/pocket_items/donator/havana_cigar_case
	name = "Havanian Cigars"
	item_path = /obj/item/storage/fancy/cigarettes/cigars/havana
	group = "Comfort"

/datum/loadout_item/pocket_items/donator/vape
	name = "E-Cigarette"
	item_path = /obj/item/vape
	group = "Comfort"
