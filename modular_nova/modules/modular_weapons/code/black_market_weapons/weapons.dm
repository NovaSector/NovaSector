// Evil Sol Pistol Guns

/datum/market_item/weapon/wespe_evil
	name = "Wespe Pistol (Used)"
	desc = "A heavy battle rifle firing .40 Sol. Commonly seen in the hands of SolFed military types. Accepts any standard SolFed rifle magazine."
	item = /obj/item/gun/ballistic/automatic/pistol/sol/evil/no_mag

	price_min = PAYCHECK_COMMAND * 4
	price_max = PAYCHECK_COMMAND * 6
	stock_max = 5
	availability_prob = 75

/datum/market_item/weapon/sindano_evil
	name = "Sindano Submachine Gun (Used)"
	desc = "A heavy battle rifle firing .40 Sol. Commonly seen in the hands of SolFed military types. Accepts any standard SolFed rifle magazine."
	item = /obj/item/gun/ballistic/automatic/sol_smg/evil/no_mag

	price_min = PAYCHECK_COMMAND * 5
	price_max = PAYCHECK_COMMAND * 7
	stock_max = 3
	availability_prob = 65

// Sol Pistol Magazines

/datum/market_item/ammunition/sol_pistol_mag
	name = "Sol Pistol Magazine"
	desc = "A standard size magazine for SolFed pistols, holds twelve rounds."
	item = /obj/item/ammo_box/magazine/c35sol_pistol/starts_empty

	price_min = PAYCHECK_CREW
	price_max = PAYCHECK_CREW * 2
	stock_max = 5
	availability_prob = 100

/datum/market_item/ammunition/sol_pistol_mag_stendo
	name = "Sol Extended Pistol Magazine"
	desc = "An extended magazine for SolFed pistols, holds twenty-four rounds."
	item = /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty

	price_min = PAYCHECK_COMMAND
	price_max = PAYCHECK_COMMAND * 2
	stock_max = 3
	availability_prob = 50

// Sol Rifles

/datum/market_item/weapon/sol_rifle
	name = "Carwo-Cawil Battle Rifle"
	desc = "A heavy battle rifle firing .40 Sol. Commonly seen in the hands of SolFed military types. Accepts any standard SolFed rifle magazine."
	item = /obj/item/gun/ballistic/automatic/sol_rifle/no_mag

	price_min = PAYCHECK_COMMAND * 13
	price_max = PAYCHECK_COMMAND * 15
	stock_max = 3
	availability_prob = 40

/datum/market_item/weapon/sol_rifle_evil
	name = "Carwo-Cawil Battle Rifle (Used)"
	desc = "A heavy battle rifle firing .40 Sol. Commonly seen in the hands of SolFed military types. Accepts any standard SolFed rifle magazine."
	item = /obj/item/gun/ballistic/automatic/sol_rifle/evil/no_mag

	price_min = PAYCHECK_COMMAND * 13
	price_max = PAYCHECK_COMMAND * 15
	stock_max = 1
	availability_prob = 20

/datum/market_item/weapon/sol_machinegun
	name = "Qarad Light Machinegun"
	desc = "A hefty machinegun commonly seen in the hands of SolFed military types. Accepts any standard SolFed rifle magazine."
	item = /obj/item/gun/ballistic/automatic/sol_rifle/machinegun/no_mag

	price_min = PAYCHECK_COMMAND * 22
	price_max = PAYCHECK_COMMAND * 24
	stock_max = 2
	availability_prob = 30

// Sol Rifle Magazines

/datum/market_item/ammunition/sol_rifle_mag_short
	name = "Sol Rifle Short Magazine"
	desc = "A shortened magazine for SolFed rifles, holds fifteen rounds."
	item = /obj/item/ammo_box/magazine/c40sol_rifle/starts_empty

	price_min = PAYCHECK_CREW
	price_max = PAYCHECK_CREW * 2
	stock_max = 5
	availability_prob = 100

/datum/market_item/ammunition/sol_rifle_mag
	name = "Sol Rifle Magazine"
	desc = "A standard size magazine for SolFed rifles, holds thirty rounds."
	item = /obj/item/ammo_box/magazine/c40sol_rifle/standard/starts_empty

	price_min = PAYCHECK_COMMAND
	price_max = PAYCHECK_COMMAND * 2
	stock_max = 3
	availability_prob = 50

// Kiboko Grenade Launcher

/datum/market_item/weapon/sol_grenade_launcher
	name = "Kiboko Grenade Launcher"
	desc = "A unique grenade launcher firing .980 grenades. A laser sight system allows its user to specify a range for the grenades it fires to detonate at."
	item = /obj/item/gun/ballistic/automatic/sol_grenade_launcher/no_mag

	price_min = PAYCHECK_COMMAND * 44
	price_max = PAYCHECK_COMMAND * 48
	stock_max = 1
	availability_prob = 30

/datum/market_item/weapon/sol_grenade_launcher_evil
	name = "Kiboko Grenade Launcher (Used)"
	desc = "A unique grenade launcher firing .980 grenades. A laser sight system allows its user to specify a range for the grenades it fires to detonate at."
	item = /obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil/no_mag

	price_min = PAYCHECK_COMMAND * 44
	price_max = PAYCHECK_COMMAND * 48
	stock_max = 1
	availability_prob = 15

// Kiboko Launcher Magazines

/datum/market_item/ammunition/kiboko_magazine
	name = "Kiboko Grenade Box"
	desc = "A standard size box for .980 grenades, holds four shells."
	item = /obj/item/ammo_box/magazine/c980_grenade/starts_empty

	price_min = PAYCHECK_COMMAND * 1.5
	price_max = PAYCHECK_COMMAND * 2.5
	stock_max = 5
	availability_prob = 100

/datum/market_item/ammunition/kiboko_drum
	name = "Kiboko Grenade Drum"
	desc = "A drum for .980 grenades, holds six shells."
	item = /obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty

	price_min = PAYCHECK_COMMAND * 2.5
	price_max = PAYCHECK_COMMAND * 3.5
	stock_max = 3
	availability_prob = 45

// Lanca

/datum/market_item/weapon/sol_grenade_launcher_evil
	name = "Lanca Battle Rifle"
	desc = "A relatively compact, long barreled bullpup battle rifle chambered for .310 Strilka. Has an integrated sight with \
		a surprisingly functional amount of magnification, given its place of origin."
	item = /obj/item/gun/ballistic/automatic/lanca/no_mag

	price_min = PAYCHECK_COMMAND * 13
	price_max = PAYCHECK_COMMAND * 15
	stock_max = 2
	availability_prob = 50

// Lanca Magazines

/datum/market_item/ammunition/kiboko_magazine
	name = "Lanca Rifle Magazine"
	desc = "A standard size magazine for Lanca rifles, holds five rounds."
	item = /obj/item/ammo_box/magazine/lanca/spawns_empty

	price_min = PAYCHECK_COMMAND * 1.5
	price_max = PAYCHECK_COMMAND * 2.5
	stock_max = 5
	availability_prob = 100

// Xhihao Sport Rifle

/datum/market_item/weapon/xhihao_sporting_rifle
	name = "Sakhno-Zhihao Sporting Rifle"
	desc = "An upgrade and modernisation of the original Sakhno rifle, made with such wonders as \
		modern materials, a scope, and other impressive technological advancements that, to be honest, \
		were already around when the original weapon was designed."
	item = /obj/item/gun/ballistic/rifle/boltaction/prime

	price_min = PAYCHECK_COMMAND * 10
	price_max = PAYCHECK_COMMAND * 12
	stock_max = 3
	availability_prob = 50

// Wylom (Based)

/datum/market_item/weapon/wylom
	name = "Wyłom Anti-Materiel Rifle"
	desc = "A massive, outdated beast of an anti materiel rifle that was once in use by CIN military forces. Fires the devastating .60 Strela caseless round, \
		the massively overperforming penetration of which being the reason this weapon was discontinued."
	item = /obj/item/gun/ballistic/automatic/wylom/no_mag

	price_min = PAYCHECK_COMMAND * 15
	price_max = PAYCHECK_COMMAND * 17
	stock_max = 1
	availability_prob = 30

// Lanca Magazines

/datum/market_item/ammunition/kiboko_magazine
	name = "Anti-Materiel Magazine (.60 Strela)"
	desc = "A massive magazine for .60 Strela caseless ammunition, holds three cartridges."
	item = /obj/item/ammo_box/magazine/wylom

	price_min = PAYCHECK_COMMAND * 1.5
	price_max = PAYCHECK_COMMAND * 2.5
	stock_max = 2
	availability_prob = 100
