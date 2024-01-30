#define ITEM_WEIGHT_CLOTHING 3
#define ITEM_WEIGHT_ARMOR 2
#define ITEM_WEIGHT_MISC 3
#define ITEM_WEIGHT_MISC_BUT_RARER 2
#define ITEM_WEIGHT_AMMO_SINGLE 3
#define ITEM_WEIGHT_AMMO_BULK 2
#define ITEM_WEIGHT_GUN_COMMON 2
#define ITEM_WEIGHT_GUN_RARE 1

#define CRATE_BUDGET_MINIMUM 20
#define CRATE_BUDGET_MAXIMUM 35

// Special basically locks it out of appearing literally ever unless an admin VV's the cargo subsystem
/datum/supply_pack/imports/russian
	special = TRUE

/datum/supply_pack/imports/cin_surplus
	name = "CIN Surplus Equipment Crate"
	desc = "A collection of surplus equipment sourced from the Coalition of Independent Nations' military stockpiles. Likely to contain old and outdated equipment, as is the nature of surplus."
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
		/obj/item/clothing/mask/balaclavaadjust
		/obj/item/clothing/gloves/tackler/combat
		/obj/item/clothing/shoes/jackboots
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
		/obj/item/storage/toolbox/maint_kit = ITEM_WEIGHT_MISC_BUT_RARER,
	)

/datum/supply_pack/imports/cin_surplus/fill(obj/structure/closet/crate/we_are_filling_this_crate)
	var/item_budget = rand(CRATE_BUDGET_MINIMUM, CRATE_BUDGET_MAXIMUM)
	while(item_budget > 0)
		var/new_thing = pick_weight(contains)
		// We don't want to go over-budget
		if((item_budget - contains[new_thing]) < 0)
			continue
		new new_thing(src)
		item_budget -= contains[new_thing]

#undef ITEM_WEIGHT_CLOTHING
#undef ITEM_WEIGHT_ARMOR
#undef ITEM_WEIGHT_MISC
#undef ITEM_WEIGHT_MISC_BUT_RARER
#undef ITEM_WEIGHT_AMMO_SINGLE
#undef ITEM_WEIGHT_AMMO_BULK
#undef ITEM_WEIGHT_GUN_COMMON
#undef ITEM_WEIGHT_GUN_RARE

#undef CRATE_BUDGET_MINIMUM
#undef CRATE_BUDGET_MAXIMUM
