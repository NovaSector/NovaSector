/datum/supply_pack/security/armory/wt550/sec
	name = "Surplus WT-550 Crate"
	desc = "An entire crate of outdated service rifles, offered by your wonderful benefactors, Nanotrasen. \
		Employees are reminded that rumors of face-melting are just that, and these weapons are entirely safe, if not \
		entirely up to modern standards; all the same, Nanotrasen is not responsible for issues arising from their deployment. \
		Ammo sold separately."
	cost = CARGO_CRATE_VALUE * 8
	access = ACCESS_ARMORY
	access_view = ACCESS_ARMORY
	contains = list(
		/obj/item/gun/ballistic/automatic/wt550 = 3,
	)
	crate_name = "Surplus Autorifles Crate"
	crate_type = /obj/structure/closet/crate/secure/weapon

/datum/supply_pack/security/armory/wt550ammo_sec
	name = "Surplus WT-550 Ammo Crate"
	desc = "A crate of WT-550 ammunition, intended to supply surplus rifles, or be taken as a novelty."
	cost = CARGO_CRATE_VALUE * 6
	access = ACCESS_ARMORY
	access_view = ACCESS_ARMORY
	contains = list(
		/obj/item/ammo_box/magazine/wt550m9 = 3,
		/obj/item/ammo_box/magazine/wt550m9/rub = 3,
	)
	crate_name = "Surplus Ammunition Crate"
	crate_type = /obj/structure/closet/crate/secure/weapon

/datum/market_item/weapon/wt550
	name = "WT-550 Autorifle"
	desc = "*!&@#FANCY SEEING YOU HERE, AGENT! YOU KNOW THE OFFER - AN AUTORIFLE, FOR YOUR USE AND ENJOYMENT!#@*$"
	item = /obj/item/gun/ballistic/automatic/wt550

	price_min = CARGO_CRATE_VALUE * 0.75
	price_max = CARGO_CRATE_VALUE * 3
	stock_max = 3
	availability_prob = 60 // There are multiple routes to obtaining these

/datum/market_item/weapon/wt550/ammo
	name = "WT-550 Autorifle Ammunition"
	desc = "'Enumerate with your WT-550: Projectile Thrown Weapon. Container has 6 REAL WT-550 Magazine Ammunitions and hours of fun!'"
	item = /obj/item/storage/toolbox/ammobox/wt550

	price_min = CARGO_CRATE_VALUE * 2 // the ammo in this is a lot harder to get than the guns themselves
	price_max = CARGO_CRATE_VALUE * 5
	stock_max = 4 // the contents of these boxes are fundamentally random; carry a few in case one spawns with all rubbers or something
	stock_min = 2
	availability_prob = 90 // These are largely available exclusively here
