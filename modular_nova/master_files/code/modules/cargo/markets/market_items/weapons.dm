/datum/market_item/weapon/mosin_pro
	name = "Xhihao 'Rengo' Precision Rifle Stock"
	desc = "Sure, it doesn't come with any of the actual bits that go bang, but who's gonna be laughing when you spook 'em with three more rounds?"
	item = /obj/item/crafting_conversion_kit/mosin_pro
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 4
	stock_max = 3
	availability_prob = 80

/datum/market_item/weapon/ablative_bat
	name = "Ablative Baseball Bat"
	desc = "A baseball bat made completely out of metal, its seller informs you this once belonged to a famous sportsman and won't be sold for cheap..."
	item = /obj/item/melee/baseball_bat/ablative
	price_min = CARGO_CRATE_VALUE * 6
	price_max = CARGO_CRATE_VALUE * 10
	stock_max = 1
	availability_prob = 55

// Makes this even more expensive
/datum/market_item/weapon/dimensional_bomb
	price_min = CARGO_CRATE_VALUE * 180
	price_max = CARGO_CRATE_VALUE * 200
