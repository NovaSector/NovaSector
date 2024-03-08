/datum/market_item/ammunition
	category = "Ammunition"

/datum/market_item/ammunition/datadisk
	name = "Advanced Munitions Datadisk"
	desc = "An datadisk filled with advanced munition fabrication data for the ammunition workbench, including lethal ammotypes if not previously enabled. \
		No parties are liable for any incidents that occur if safeties were circumvented beforehand."
	item = /obj/item/disk/ammo_workbench/advanced

	price_min = PAYCHECK_COMMAND * 4
	price_max = PAYCHECK_COMMAND * 6
	stock_max = 2
	availability_prob = 50

// .310 Strip Clips

/datum/market_item/ammunition/sakhno_stripper
	name = "Stripper Clip (.310 Strilka)"
	desc = "A stripper clip for five rounds of .310 Strilka"
	item = /obj/item/ammo_box/strilka310

	price_min = PAYCHECK_COMMAND * 1.5
	price_max = PAYCHECK_COMMAND * 2.5
	stock_max = 4
	availability_prob = 100

/datum/market_item/ammunition/sakhno_stripper_box
	name = ".310 Strilka Ammo Box (Surplus?)"
	desc = "It contains a few clips. Goddamn, this thing smells awful. \
		Has this been sitting in a warehouse for the last several centuries?"
	item = /obj/item/storage/toolbox/ammobox/strilka310/surplus

	price_min = PAYCHECK_COMMAND * 5
	price_max = PAYCHECK_COMMAND * 7
	stock_max = 2
	availability_prob = 50

// .310 ammo

/datum/market_item/ammunition/strilka_lethal
	name = "Ammo Box (.310 Strilka lethal)"
	desc = "A box of .310 Strilka lethal rifle rounds, holds ten cartridges."
	item = /obj/item/ammo_box/c310_cargo_box

	price_min = PAYCHECK_CREW
	price_max = PAYCHECK_CREW * 2
	stock_max = 5
	availability_prob = 65

/datum/market_item/ammunition/strilka_pierce
	name = "Ammo Box (.310 Strilka piercing)"
	desc = "A box of .310 Strilka piercing rifle rounds, holds ten cartridges."
	item = /obj/item/ammo_box/c310_cargo_box/piercing

	price_min = PAYCHECK_CREW * 2
	price_max = PAYCHECK_CREW * 4
	stock_max = 3
	availability_prob = 45

// .27-54

/datum/market_item/ammunition/cesarzowa_lethal
	name = "Ammo Box (.27-54 Cesarzowa piercing)"
	desc = "A box of .27-54 Cesarzowa piercing pistol rounds, holds eighteen cartridges."
	item = /obj/item/ammo_box/c27_54cesarzowa

	price_min = PAYCHECK_CREW
	price_max = PAYCHECK_CREW * 2
	stock_max = 5
	availability_prob = 65

// .35 Sol

/datum/market_item/ammunition/sol_short_lethal
	name = "Ammo Box (.35 Sol Short lethal)"
	desc = "A box of .35 Sol Short pistol rounds, holds twenty-four rounds."
	item = /obj/item/ammo_box/c35sol

	price_min = PAYCHECK_CREW
	price_max = PAYCHECK_CREW * 2
	stock_max = 5
	availability_prob = 65

// .40 Sol

/datum/market_item/ammunition/sol_long_lethal
	name = "Ammo Box (.40 Sol Long lethal)"
	desc = "A box of .40 Sol Long rifle rounds, holds thirty bullets."
	item = /obj/item/ammo_box/c40sol

	price_min = PAYCHECK_CREW
	price_max = PAYCHECK_CREW * 2
	stock_max = 5
	availability_prob = 65

/datum/market_item/ammunition/sol_long_fire
	name = "Ammo Box (.40 Sol Long incendiary)"
	desc = "A box of .40 Sol Long rifle rounds, holds thirty bullets. The orange stripe indicates this should hold incendiary ammunition."
	item = /obj/item/ammo_box/c40sol/incendiary

	price_min = PAYCHECK_CREW * 2
	price_max = PAYCHECK_CREW * 4
	stock_max = 3
	availability_prob = 45

// .585

/datum/market_item/ammunition/trappiste_lethal
	name = "Ammo Box (.585 Trappiste lethal)"
	desc = "A box of .585 Trappiste pistol rounds, holds twelve cartridges."
	item = /obj/item/ammo_box/c585trappiste

	price_min = PAYCHECK_CREW
	price_max = PAYCHECK_CREW * 2
	stock_max = 5
	availability_prob = 65

// .980

/datum/market_item/ammunition/tydhouer_smoke
	name = "Ammo Box (.980 Tydhouer smoke)"
	desc = "A box of four .980 Tydhouer smoke grenades. \
		Instructions on the box indicate these are smoke rounds that will make a small cloud of laser-dampening smoke on detonation."
	item = /obj/item/ammo_box/c980grenade/smoke

	price_min = PAYCHECK_COMMAND
	price_max = PAYCHECK_COMMAND * 2
	stock_max = 3
	availability_prob = 50

/datum/market_item/ammunition/tydhouer_riot
	name = "Ammo Box (.980 Tydhouer tear gas)"
	desc = "A box of four .980 Tydhouer tear gas grenades. \
		Instructions on the box indicate these are tear gas grenades that will detonate into a cloud of crowd-dispersing smoke on detonation."
	item = /obj/item/ammo_box/c980grenade/riot

	price_min = PAYCHECK_COMMAND
	price_max = PAYCHECK_COMMAND * 2
	stock_max = 3
	availability_prob = 50

/datum/market_item/ammunition/tydhouer_shrapnel
	name = "Ammo Box (.980 Tydhouer shrapnel)"
	desc = "A box of four .980 Tydhouer shrapnel grenades. Instructions on the box indicate these are shrapnel rounds. Its also covered in hazard signs, odd."
	item = /obj/item/ammo_box/c980grenade/shrapnel

	price_min = PAYCHECK_COMMAND
	price_max = PAYCHECK_COMMAND * 3
	stock_max = 2
	availability_prob = 35

/datum/market_item/ammunition/tydhouer_phosphor
	name = "Ammo Box (.980 Tydhouer phosphor)"
	desc = "A box of four .980 Tydhouer phosphor grenades. Instructions on the box indicate these are incendiary explosive rounds. Its also covered in hazard signs, odd."
	item = /obj/item/ammo_box/c980grenade/shrapnel/phosphor

	price_min = PAYCHECK_COMMAND
	price_max = PAYCHECK_COMMAND * 3
	stock_max = 2
	availability_prob = 25
