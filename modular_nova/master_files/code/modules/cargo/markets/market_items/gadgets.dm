/datum/market_item/misc/shotglasses
	name = "Extra Large Syndicate Shotglasses"
	desc = "A box of shotglasses designed to hold more liquid than they truly seem to..."
	item = /obj/item/storage/box/syndieshotglasses
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE
	stock_max = 3
	availability_prob = 80

/datum/market_item/misc/c4
	name = "C4 Satchel Charge"
	desc = "Sticky charges listed on the black market uplink - surely these won't explode within your own hands..."
	item = /obj/item/grenade/c4
	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 2
	stock_max = 4
	availability_prob = 80

/datum/market_item/misc/tram_remote
	name = "Tram Remote Control"
	desc = "A bootlegged remote to control the subsystems of onboard computers found on Nanotrasen trams."
	item = /obj/item/assembly/control/transport/remote
	price_min = CARGO_CRATE_VALUE * 3
	price_max = CARGO_CRATE_VALUE * 4
	stock_max = 1
	availability_prob = 50
