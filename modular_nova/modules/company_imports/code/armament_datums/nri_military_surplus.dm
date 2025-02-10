/datum/armament_entry/company_import/nri_surplus
	category = NRI_SURPLUS_COMPANY_NAME
	company_bitflag = CARGO_COMPANY_NRI_SURPLUS

// Various NRI clothing items

/datum/armament_entry/company_import/nri_surplus/clothing
	subcategory = "Clothing Supplies"

/datum/armament_entry/company_import/nri_surplus/clothing/uniform
	item_type = /obj/item/clothing/under/syndicate/rus_army/cin_surplus/random_color
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/belt
	item_type = /obj/item/storage/belt/military/cin_surplus/random_color
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/backpack
	item_type = /obj/item/storage/backpack/industrial/cin_surplus/random_color
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/helmet
	item_type = /obj/item/clothing/head/helmet/cin_surplus_helmet/random_color
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nri_surplus/clothing/vest
	item_type = /obj/item/clothing/suit/armor/vest/cin_surplus_vest
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nri_surplus/clothing/space_suit
	item_type = /obj/item/clothing/suit/space/voskhod
	cost = PAYCHECK_COMMAND*3

/datum/armament_entry/company_import/nri_surplus/clothing/space_helmet
	item_type = /obj/item/clothing/head/helmet/space/voskhod
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nri_surplus/clothing/police_uniform
	item_type = /obj/item/clothing/under/colonial/nri_police
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/police_cloak
	item_type = /obj/item/clothing/neck/cloak/colonial/nri_police
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/police_jacket
	item_type = /obj/item/clothing/suit/armor/vest/nri_police_jacket
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/police_suit_jacket
	item_type = /obj/item/clothing/suit/armor/vest/nri_police_jacket/suit
	description = "A black uniform jacket with Zvirdnyan Colonial Militia's signature white rectangle on its right sleeve and backside. \
	Letters inside the collar usually read the wearer's rank and internal kink. The jacket is of exceptional quality."
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/police_cap
	item_type = /obj/item/clothing/head/hats/colonial/nri_police
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/police_baseball_cap
	item_type = /obj/item/clothing/head/soft/nri_police
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/clothing/police_mask
	item_type = /obj/item/clothing/mask/gas/nri_police
	cost = PAYCHECK_CREW*2

/datum/armament_entry/company_import/nri_surplus/clothing/police_vest
	item_type = /obj/item/clothing/head/helmet/nri_police
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/nri_surplus/clothing/police_helmet
	item_type = /obj/item/clothing/suit/armor/vest/nri_police
	cost = PAYCHECK_COMMAND

// Random surplus store tier stuff, flags, old rations, multitools you'll never use, so on

/datum/armament_entry/company_import/nri_surplus/misc
	subcategory = "Miscellaneous Supplies"

/datum/armament_entry/company_import/nri_surplus/misc/flares
	item_type = /obj/item/storage/box/nri_flares
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/nri_surplus/misc/binoculars
	item_type = /obj/item/binoculars
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/misc/screwdriver_pen
	item_type = /obj/item/pen/screwdriver
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/misc/trench_tool
	item_type = /obj/item/trench_tool
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/misc/food_replicator
	description = "A widespread technology previously used by far colonies on the NRI's borders, over time being shifted from the foundation of colonies \
	to a simple disaster relief solution. It can turn spoiled or inedible plant matter into food, medical supplies, and other general items. \
	These particular units were displaced during a stock count in an NRI warehouse."
	item_type = /obj/item/circuitboard/machine/biogenerator/food_replicator
	cost = CARGO_CRATE_VALUE * 9

/datum/armament_entry/company_import/nri_surplus/misc/nri_flag
	item_type = /obj/item/sign/flag/nri
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/nri_surplus/firearm
	subcategory = "Firearms"

/datum/armament_entry/company_import/nri_surplus/firearm/shotgun_revolver
	item_type = /obj/item/gun/ballistic/revolver/shotgun_revolver
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nri_surplus/firearm/zashch
	item_type = /obj/item/gun/ballistic/automatic/pistol/zashch
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nri_surplus/firearm/plasma_thrower
	item_type = /obj/item/gun/ballistic/automatic/pistol/plasma_thrower
	cost = PAYCHECK_COMMAND * 6
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/firearm/plasma_marksman
	item_type = /obj/item/gun/ballistic/automatic/pistol/plasma_marksman
	cost = PAYCHECK_COMMAND * 6

/datum/armament_entry/company_import/nri_surplus/firearm/crank_taser
	item_type = /obj/item/gun/energy/taser/crank
	cost = PAYCHECK_COMMAND * 4 //No disabler, less charge in general in comparison to a normal double-mode taser; yet chargable on the spot (even if unwieldy)

/datum/armament_entry/company_import/nri_surplus/firearm/stun_gun //Not a gun but it's only fair to place similar items close to each other
	item_type = /obj/item/melee/baton/security/stun_gun/loaded
	cost = PAYCHECK_COMMAND * 3 //Similarly live action roleplay'iy stun baton lite

/datum/armament_entry/company_import/nri_surplus/firearm/miecz
	item_type = /obj/item/gun/ballistic/automatic/miecz
	cost = PAYCHECK_COMMAND * 10
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/firearm/napad
	item_type = /obj/item/gun/ballistic/automatic/napad
	cost = PAYCHECK_COMMAND * 12
	restricted = TRUE

/datum/armament_entry/company_import/nri_surplus/firearm/sakhno_rifle
	item_type = /obj/item/gun/ballistic/rifle/boltaction
	cost = PAYCHECK_COMMAND * 12

/datum/armament_entry/company_import/nri_surplus/firearm/lanca
	item_type = /obj/item/gun/ballistic/automatic/lanca
	cost = PAYCHECK_COMMAND * 14

/datum/armament_entry/company_import/nri_surplus/firearm/anti_materiel_rifle
	item_type = /obj/item/gun/ballistic/automatic/wylom
	cost = PAYCHECK_COMMAND * 16

/datum/armament_entry/company_import/nri_surplus/firearm_ammo
	subcategory = "Firearm Magazines"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/zashch
	item_type = /obj/item/ammo_box/magazine/zashch/spawns_empty

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/plasma_battery
	item_type = /obj/item/ammo_box/magazine/recharge/plasma_battery

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/miecz
	item_type = /obj/item/ammo_box/magazine/miecz/spawns_empty

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/napad
	item_type = /obj/item/ammo_box/magazine/napad/spawns_empty

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/sakhno
	item_type = /obj/item/ammo_box/strilka310

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/lanca
	item_type = /obj/item/ammo_box/magazine/lanca/spawns_empty

/datum/armament_entry/company_import/nri_surplus/firearm_ammo/amr_magazine
	item_type = /obj/item/ammo_box/magazine/wylom
	cost = PAYCHECK_CREW * 3
