/datum/supply_pack/service/survivalknives
	express_lock = TRUE

/datum/supply_pack/service/minerkit
	desc = "All the miners died too fast? Assistant wants to get a taste of life off-station? \
		Either way, this kit is the best way to turn a regular crewman into an ore-producing, \
		monster-slaying machine. Contains meson goggles, a seclite, automatic mining scanner, \
		ore bag, knife, PKA, SEVA mask, and SEVA suit."
	access = NONE
	access_view = NONE
	crate_type = /obj/structure/closet/crate/cargo/mining

/datum/supply_pack/service/mineraccess
	name = "Shaft Miner Access Kit"
	desc = "You want to recruit more miners and the HoP is too busy to make new cards? \
		Fear not, this kit contains a mining ID card and a mining headset!."
	cost = CARGO_CRATE_VALUE * 1.4
	access = ACCESS_QM
	access_view = ACCESS_MINING_STATION
	contains = list(/obj/item/encryptionkey/headset_mining, /obj/item/card/id/advanced/mining)
	crate_name = "shaft miner access kit"
	crate_type = /obj/structure/closet/crate/secure/cargo/mining
	console_flag = CARGO_CONSOLE_NT | CARGO_CONSOLE_PDA // No ghost roles should get free ID cards for NT.
