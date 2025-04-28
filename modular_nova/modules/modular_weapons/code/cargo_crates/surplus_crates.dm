#define ITEM_WEIGHT_CLOTHING 3
#define ITEM_WEIGHT_ARMOR 2
#define ITEM_WEIGHT_MISC 3
#define ITEM_WEIGHT_MISC_BUT_RARER 2
#define ITEM_WEIGHT_AMMO_SINGLE 3
#define ITEM_WEIGHT_AMMO_BULK 2
#define ITEM_WEIGHT_GUN_COMMON 2
#define ITEM_WEIGHT_GUN_RARE 1


// used in budget calculation
#define CRATE_ITEM_WEIGHT_MAX 3

#define CRATE_BUDGET_MINIMUM 20
#define CRATE_BUDGET_MAXIMUM 35

// Special basically locks it out of appearing literally ever unless an admin VV's the cargo subsystem
/datum/supply_pack/imports/russian
	special = TRUE

/// base type that uses paxil's crate budgeting system. contains stuff from the CIN
/datum/supply_pack/imports/budgeted
	name = "CIN Surplus Equipment Crate"
	desc = "A collection of surplus equipment sourced from the Coalition of Independent Nations' military stockpiles. \
	Likely to contain old and outdated equipment, as is the nature of surplus."
	contraband = TRUE
	cost = CARGO_CRATE_VALUE * 20
	contains = list(
		// Clothing
		/obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color = ITEM_WEIGHT_CLOTHING,
		/obj/item/storage/belt/military/cin_surplus/random_color = ITEM_WEIGHT_CLOTHING,
		/obj/item/storage/backpack/industrial/cin_surplus/random_color = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/under/colonial/nri_police = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/neck/cloak/colonial/nri_police = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/head/hats/colonial/nri_police = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/mask/gas/nri_police = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/mask/balaclavaadjust = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/gloves/tackler/combat = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/shoes/jackboots = ITEM_WEIGHT_CLOTHING,
		// Armors
		/obj/item/clothing/head/helmet/cin_surplus_helmet/random_color = ITEM_WEIGHT_ARMOR,
		/obj/item/clothing/suit/armor/vest/cin_surplus_vest = ITEM_WEIGHT_ARMOR,
		/obj/item/clothing/head/helmet/nri_police = ITEM_WEIGHT_ARMOR,
		/obj/item/clothing/suit/armor/vest/nri_police = ITEM_WEIGHT_ARMOR,
		// Weapons
		/obj/item/gun/ballistic/revolver/shotgun_revolver = ITEM_WEIGHT_GUN_COMMON,
		/obj/item/gun/ballistic/automatic/pistol/plasma_thrower = ITEM_WEIGHT_GUN_COMMON,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = ITEM_WEIGHT_GUN_COMMON,
		/obj/item/storage/toolbox/guncase/soviet/sakhno = ITEM_WEIGHT_GUN_COMMON,
		/obj/item/gun/ballistic/automatic/miecz = ITEM_WEIGHT_GUN_RARE,
		/obj/item/gun/ballistic/automatic/lanca = ITEM_WEIGHT_GUN_RARE,
		/obj/item/gun/ballistic/automatic/wylom = ITEM_WEIGHT_GUN_RARE,
		// Ammo
		/obj/item/storage/toolbox/ammobox/strilka310 = ITEM_WEIGHT_AMMO_BULK,
		/obj/item/storage/toolbox/ammobox/strilka310/surplus = ITEM_WEIGHT_AMMO_BULK,
		/obj/item/ammo_box/c27_54cesarzowa = ITEM_WEIGHT_AMMO_BULK,
		/obj/item/ammo_box/c27_54cesarzowa/rubber = ITEM_WEIGHT_AMMO_BULK,
		/obj/item/ammo_box/c310_cargo_box = ITEM_WEIGHT_AMMO_BULK,
		/obj/item/ammo_box/c310_cargo_box/rubber = ITEM_WEIGHT_AMMO_BULK,
		/obj/item/ammo_box/c310_cargo_box/piercing = ITEM_WEIGHT_AMMO_BULK,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = ITEM_WEIGHT_AMMO_SINGLE,
		/obj/item/ammo_box/magazine/miecz/spawns_empty = ITEM_WEIGHT_AMMO_SINGLE,
		/obj/item/ammo_box/strilka310 = ITEM_WEIGHT_AMMO_SINGLE,
		/obj/item/ammo_box/magazine/lanca/spawns_empty = ITEM_WEIGHT_AMMO_SINGLE,
		/obj/item/ammo_box/magazine/wylom = ITEM_WEIGHT_AMMO_SINGLE,
		// Other items
		/obj/item/sign/flag/nri = ITEM_WEIGHT_MISC,
		/obj/item/trench_tool = ITEM_WEIGHT_MISC,
		/obj/item/binoculars = ITEM_WEIGHT_MISC,
		/obj/item/storage/box/nri_flares = ITEM_WEIGHT_MISC,
		/obj/item/pen/screwdriver = ITEM_WEIGHT_MISC_BUT_RARER,
		/obj/item/storage/box/colonial_rations = ITEM_WEIGHT_MISC_BUT_RARER,
		/obj/item/gun_maintenance_supplies = ITEM_WEIGHT_MISC_BUT_RARER,
	)
	/// lower bound of random crate budget
	var/item_budget_min = CRATE_BUDGET_MINIMUM
	/// upper bound of random crate budget
	var/item_budget_max = CRATE_BUDGET_MAXIMUM
	/// maximum number of contents
	var/max_contents = 20

/datum/supply_pack/imports/budgeted/fill(obj/structure/closet/crate/we_are_filling_this_crate)
	var/item_budget = rand(item_budget_min, item_budget_max)
	for(var/iterator in 1 to max_contents) // 20 items max, but we have a budget too
		var/new_thing = pick_weight(contains)
		// We don't want to go too far over budget
		if(item_budget <= 0)
			return
		new new_thing(we_are_filling_this_crate)
		// Basically inverts the weight before subtracting it from the budget
		item_budget -= ((CRATE_ITEM_WEIGHT_MAX + 1) - contains[new_thing])

/// contains stuff from the vanguard expeditionary corps
/datum/supply_pack/imports/budgeted/vanguard_surplus
	name = "Vanguard Expeditionary Corps Surplus"
	desc = "Contains an assortment of surplus equipment from the now-defunct Vanguard Expeditionary Corps. May or may not just be things they stole from other stations."
	cost = CARGO_CRATE_VALUE * 20
	contraband = FALSE
	// note: weights are entirely arbitrary. also arbitrarily sorted by weight
	contains = list(
		// clothes incl. storage
		/obj/item/clothing/under/rank/expeditionary_corps = ITEM_WEIGHT_CLOTHING,
		/obj/item/storage/belt/military/expeditionary_corps = ITEM_WEIGHT_CLOTHING,
		/obj/item/storage/backpack/duffelbag/expeditionary_corps = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/gloves/color/black/expeditionary_corps = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/shoes/combat/expeditionary_corps = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/gloves/latex/nitrile/expeditionary_corps = ITEM_WEIGHT_CLOTHING,
		// armor
		/obj/item/clothing/head/helmet/expeditionary_corps = ITEM_WEIGHT_CLOTHING,
		/obj/item/clothing/suit/armor/vest/expeditionary_corps = ITEM_WEIGHT_CLOTHING,
		// misc goodies?
		/obj/item/storage/box/expeditionary_survival = ITEM_WEIGHT_MISC,
		/obj/item/melee/tomahawk = ITEM_WEIGHT_MISC_BUT_RARER,
		// the stuff they probably just stole from the station before going
		/obj/item/storage/medkit/regular = ITEM_WEIGHT_MISC_BUT_RARER,
		/obj/item/trench_tool = ITEM_WEIGHT_MISC,
		/obj/item/binoculars = ITEM_WEIGHT_MISC,
		/obj/item/storage/box/nri_flares = ITEM_WEIGHT_MISC,
		/obj/item/storage/pouch/medical/firstaid/loaded = ITEM_WEIGHT_MISC_BUT_RARER,
		/obj/item/storage/pouch/medical/firstaid/advanced = ITEM_WEIGHT_MISC_BUT_RARER,
		// maybe not junk
		/obj/item/knife/combat/throwing = ITEM_WEIGHT_MISC_BUT_RARER,
		/obj/item/storage/belt/machete/full = ITEM_WEIGHT_MISC_BUT_RARER,
		/obj/item/storage/medkit/expeditionary/surplus = ITEM_WEIGHT_MISC_BUT_RARER,
		/obj/item/pointman_broken = ITEM_WEIGHT_GUN_RARE, // diy project for a shield that you can wield for 75 blockchance + beat people to death with
		/obj/item/clothing/gloves/chief_engineer/expeditionary_corps = ITEM_WEIGHT_MISC_BUT_RARER, // congratulations you won (it's basically combat gloves but not quite)
		/obj/item/modular_computer/pda/expeditionary_corps = ITEM_WEIGHT_MISC_BUT_RARER, // except for when you didn't (scammed)
	)
	// lowered values because of smaller loot pool
	item_budget_min = CRATE_BUDGET_MINIMUM - 15
	item_budget_max = CRATE_BUDGET_MAXIMUM - 20
	max_contents = 10
	crate_name = "vanguard surplus crate"
	crate_type = /obj/structure/closet/crate/cargo

#undef ITEM_WEIGHT_CLOTHING
#undef ITEM_WEIGHT_ARMOR
#undef ITEM_WEIGHT_MISC
#undef ITEM_WEIGHT_MISC_BUT_RARER
#undef ITEM_WEIGHT_AMMO_SINGLE
#undef ITEM_WEIGHT_AMMO_BULK
#undef ITEM_WEIGHT_GUN_COMMON
#undef ITEM_WEIGHT_GUN_RARE

#undef CRATE_ITEM_WEIGHT_MAX

#undef CRATE_BUDGET_MINIMUM
#undef CRATE_BUDGET_MAXIMUM
