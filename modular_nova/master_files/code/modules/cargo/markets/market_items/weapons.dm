/datum/market_item/weapon/mosin_pro
	name = "Xhihao 'Rengo' Precision Rifle Stock"
	desc = "Sure, it doesn't come with any of the actual bits that go bang, but who's gonna be laughing when you spook 'em with five more rounds?"
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

/datum/market_item/weapon/edagger
	name = "Inconspicuous Pen"
	desc = "A seemingly normal pen with some sort of generator installed in the cam (the bit that toggles the tip)."
	item = /obj/item/pen/edagger
	price_min = CARGO_CRATE_VALUE * 3
	price_max = CARGO_CRATE_VALUE * 7
	stock_max = 1
	availability_prob = 25

/datum/market_item/weapon/telescopic_bronze
	name = "Bronze-capped Telescopic Baton"
	desc = "A reinforced telescopic baton, likely stolen from some unfortunate Quartermaster."
	item = /obj/item/melee/baton/telescopic/bronze
	price_min = CARGO_CRATE_VALUE * 8
	price_max = CARGO_CRATE_VALUE * 13
	stock_max = 1
	availability_prob = 45

/datum/market_item/weapon/Assasin_kit
	name = "Assassin Starter Kit"
	desc = "An extremely illegal gun kit that somehow ended up on the black market. Seller claims no responsibility for the contents of the kit, their functionality, or the actions of future owners."
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/makarov
	price_min = CARGO_CRATE_VALUE * 15
	price_max = CARGO_CRATE_VALUE * 25
	stock_max = 1
	availability_prob = 5

/datum/market_item/weapon/hollowpoint9mm
	name = "9mm HP Magazine"
	desc = "8-round magazine of 9mm hollowpoint. Obviously, this is illegally acquired, and likely made to fit into an even more illegal weapon."
	item = /obj/item/ammo_box/magazine/m9mm/hp
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 0.7
	stock_max = 3
	availability_prob = 15

/datum/market_item/weapon/sord
	name = "SORD"
	desc = "This thing is so unspeakably shitty that the only thing more foolish than trying to sell it, is to buy it."
	item = /obj/item/sord
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 0.7
	stock_max = 1
	availability_prob = 100

/datum/market_item/weapon/carrotshiv
	name = "Carrot Shiv"
	desc = "Unlike other carrots, you should probably keep this far away from your eyes."
	item = /obj/item/knife/shiv/carrot
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 0.7
	stock_max = 5
	availability_prob = 75

// Makes this even more expensive
/datum/market_item/weapon/dimensional_bomb
	price_min = CARGO_CRATE_VALUE * 180
	price_max = CARGO_CRATE_VALUE * 200

/datum/market_item/weapon/milspec_buck
	name = "Mil-Spec Buckshot Box"
	desc = "A standard-sized box of 15 Scarborough-manufactured, hot-loaded buckshot shells, for those with a penchant for grievous bodily harm."
	item = /obj/item/ammo_box/advanced/s12gauge/buckshot/milspec
	price_min = CARGO_CRATE_VALUE * 3
	price_max = CARGO_CRATE_VALUE * 6
	availability_prob = 40
	stock_max = 2

/datum/market_item/weapon/milspec_slugs
	name = "Mil-Spec Slug Box"
	desc = "A standard-sized box of 15 Scarborough-manufactured, hot-loaded slug shells, for those with a penchant for grievous bodily harm."
	item = /obj/item/ammo_box/advanced/s12gauge/milspec
	price_min = CARGO_CRATE_VALUE * 3
	price_max = CARGO_CRATE_VALUE * 6
	availability_prob = 40
	stock_max = 2
