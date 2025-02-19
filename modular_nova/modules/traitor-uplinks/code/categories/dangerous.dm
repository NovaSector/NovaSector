/datum/uplink_item/dangerous/foamsmg_traitor
	name = "Toy Submachine Gun"
	desc = "A fully-loaded Donksoft bullpup submachine gun that fires riot grade darts with a 20-round magazine."
	item = /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot
	cost = 4
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/sindano
	name = "Sindano Submachine Gun Kit"
	desc = "A Sindano SMG, with spare lethal-and-non-lethal ammo, and three various magazines. (stendos not guaranteed) "
	item = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano/evil
	cost = 9
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/wespe
	name = "Guepe Pistol Kit"
	desc = "A Guepe personal defense pistol, with two lethal magazines, full-auto and dubiously legal."
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/wespe
	cost = 7
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/miniegunkit
	name = "Mini-egun Kit"
	desc = "A mini-egun and included recharger kit, it's better then nothing!"
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/egun_mini
	cost = 1 // 1 whole dolar
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
