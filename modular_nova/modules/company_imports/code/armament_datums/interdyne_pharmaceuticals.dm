/datum/armament_entry/company_import/interdyne
	category = INTERDYNE_NAME
	offstation = FALSE

/datum/armament_entry/company_import/interdyne/solo
	subcategory = "individual products"
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/interdyne/solo/defib
	item_type = /obj/item/defibrillator/compact/combat/loaded/interdyne

	cost = PAYCHECK_COMMAND * 8

/datum/armament_entry/company_import/interdyne/solo/hypospray
	item_type = /obj/item/reagent_containers/hypospray/combat/empty

/datum/armament_entry/company_import/interdyne/solo/evilchems
	item_type = /obj/item/storage/box/evilmeds

/datum/armament_entry/company_import/interdyne/solo/hypospray
	item_type = /obj/item/reagent_containers/hypospray/combat/empty





/*
*** Kits
*/

/datum/armament_entry/company_import/interdyne/largekit
	subcategory = "kits"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/largekit/medkit
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne



/datum/armament_entry/company_import/interdyne/largekit/maid_sing
	item_type = /obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/interdyne/mediumkit
	subcategory = "Moderate Trauma Kits"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/mediumkit/standard
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/medium

/datum/armament_entry/company_import/interdyne/smallkit
	subcategory = "Small First Aid Kits"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/smallkit/generalkit
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/small


/datum/armament_entry/company_import/interdyne/smallkit/spraykit
	description = "A small first aid kit loaded with a interdyne hypospray and various chemicals for usage /Trained doctor not included/"
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/small/spray

/datum/armament_entry/company_import/interdyne/smallkit/burnkit
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/small/burn

/datum/armament_entry/company_import/interdyne/smallkit/brutekit
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/small/brute

/datum/armament_entry/company_import/interdyne/smallkit/toxinkit
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/small/toxin

/datum/armament_entry/company_import/interdyne/smallkit/oxygenkit
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/small/oxygen
// Modsuit mods that CAN be found in the uplinks
/datum/armament_entry/company_import/interdyne/mods
	subcategory = "Modsuits & Modules"
	cost = PAYCHECK_COMMAND * 15

/datum/armament_entry/company_import/interdyne/mods/modsuit
	description = "Test Description"
	item_type = /obj/item/mod/control/pre_equipped/interdyne
	cost = PAYCHECK_COMMAND * 25

/datum/armament_entry/company_import/interdyne/ai
	subcategory = "Artificial Intelligence"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/ai/mmi
	item_type = /obj/item/mmi/syndie/interdyne

/datum/armament_entry/company_import/interdyne/ai/modsuit
	item_type = /obj/item/mmi/posibrain/syndie/interdyne

/datum/armament_entry/company_import/interdyne/crates
	subcategory = "Crates & Large Shipments"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/crates/biohazard
	item_type = /obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/crates/biohazard
	item_type = /obj/structure/closet/crate/secure/syndicate/interdyne/biohazard
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/crates/maid
	item_type = /obj/structure/closet/crate/secure/syndicate/interdyne/maid
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/crates/smallkit
	item_type = /obj/structure/closet/crate/secure/syndicate/interdyne/smallkits
	cost = PAYCHECK_COMMAND * 10
