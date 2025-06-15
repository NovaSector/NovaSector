/datum/armament_entry/company_import/tarkon
	category = TARKON_NAME
	offstation = TRUE

/datum/armament_entry/company_import/tarkon/clothing
	subcategory = "Clothing"
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/tarkon/clothing/backpack
	item_type = /obj/item/storage/backpack/tarkon

/datum/armament_entry/company_import/tarkon/clothing/satchel
	item_type = /obj/item/storage/backpack/satchel/tarkon

/datum/armament_entry/company_import/tarkon/clothing/duffel
	item_type = /obj/item/storage/backpack/duffelbag/tarkon

/datum/armament_entry/company_import/tarkon/clothing/messenger
	item_type = /obj/item/storage/backpack/messenger/tarkon

// Tarkon Weapons
/datum/armament_entry/company_import/tarkon/kits
	subcategory = "Kits"
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/tarkon/kits/gunkit
	item_type = /obj/item/storage/backpack/duffelbag/tarkon/gunkit

/datum/armament_entry/company_import/tarkon/weapons
	subcategory = "Weapons"
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/tarkon/weapons/m6pdw
	item_type = /obj/item/gun/ballistic/automatic/m6pdw

/datum/armament_entry/company_import/tarkon/ammo
	subcategory = "Ammunition"
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/tarkon/ammo/mag
	item_type = /obj/item/ammo_box/magazine/c35sol_pistol/starts_empty

/datum/armament_entry/company_import/tarkon/ammo/magstendo
	item_type = /obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty

/datum/armament_entry/company_import/tarkon/ammo/solreg
	item_type = /obj/item/ammo_box/c35sol

/datum/armament_entry/company_import/tarkon/ammo/solincap
	item_type = /obj/item/ammo_box/c35sol/incapacitator

/datum/armament_entry/company_import/tarkon/ammo/solripper
	item_type = /obj/item/ammo_box/c35sol/ripper

/datum/armament_entry/company_import/tarkon/turret
	subcategory = "Automated Weaponry"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/tarkon/turret/cerberus
	item_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/cerberus

/datum/armament_entry/company_import/tarkon/turret/hoplite
	item_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite

// Tarkon specific modsuits/mods
/datum/armament_entry/company_import/tarkon/mods
	subcategory = "Modsuits & Mods"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/tarkon/mods/modsuit
	item_type = /obj/item/mod/control/pre_equipped/tarkon
	cost = PAYCHECK_COMMAND * 15

