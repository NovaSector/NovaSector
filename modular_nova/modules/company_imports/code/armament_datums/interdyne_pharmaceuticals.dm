/datum/armament_entry/company_import/interdyne
	category = INTERDYNE_PHARMACEUTICALS_NAME
	offstation = TRUE
	// Defines what is the default cost. (If a subcategory cost is not defined it will assume this value)
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/interdyne/solo
	subcategory = "individual products"
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/interdyne/solo/defib
	item_type = /obj/item/defibrillator/compact/combat/loaded/interdyne
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/interdyne/solo/hypospray
	item_type = /obj/item/reagent_containers/hypospray/combat/empty
	cost = PAYCHECK_COMMAND * 8

/datum/armament_entry/company_import/interdyne/solo/evilchems
	item_type = /obj/item/storage/box/evilmeds
	cost = PAYCHECK_COMMAND * 12

/datum/armament_entry/company_import/interdyne/solo/nvgs
	item_type = /obj/item/clothing/glasses/hud/health/night/science

/datum/armament_entry/company_import/interdyne/solo/computer
	name = "Preloaded Surgical processor"
	item_type = /obj/item/mod/module/surgical_processor/preloaded
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/interdyne/solo/powerator
	item_type = /obj/item/circuitboard/machine/powerator/interdyne
	cost = PAYCHECK_COMMAND * 50


/* Figure out price or to keep
/datum/armament_entry/company_import/interdyne/solo/emagsurgerey
	item_type = /obj/item/autosurgeon/syndicate/emaggedsurgerytoolset
	cost = PAYCHECK_COMMAND * 8
*/
/datum/armament_entry/company_import/interdyne/solo/analyzer
	item_type = /obj/item/healthanalyzer/advanced
	cost = PAYCHECK_COMMAND / 4

/datum/armament_entry/company_import/interdyne/solo/guncasebig
	item_type = /obj/item/storage/toolbox/guncase/nova/interdyne
	cost = PAYCHECK_COMMAND / 2

/datum/armament_entry/company_import/interdyne/solo/guncasesmall
	item_type = /obj/item/storage/toolbox/guncase/nova/interdyne/pistol
	cost = PAYCHECK_COMMAND / 2

/datum/armament_entry/company_import/interdyne/solo/guncasebigspec
	item_type = /obj/item/storage/toolbox/guncase/nova/interdynespec
	cost = PAYCHECK_COMMAND / 2

/datum/armament_entry/company_import/interdyne/solo/guncasesmallspec
	item_type = /obj/item/storage/toolbox/guncase/nova/interdynespec/pistol
	cost = PAYCHECK_COMMAND / 2

/*
*** Large Kits
*/

/datum/armament_entry/company_import/interdyne/largekit
	subcategory = "kits"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/largekit/doctorkit
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne
	cost = PAYCHECK_COMMAND * 50

/datum/armament_entry/company_import/interdyne/largekit/traumakit
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/trauma
	cost = PAYCHECK_COMMAND * 25

/datum/armament_entry/company_import/interdyne/largekit/maid_sing
	item_type = /obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/interdyne/largekit/standard
	item_type = /obj/item/storage/medkit/tactical/premium/interdyne/medium

/*
*** Small Kits
*/

/datum/armament_entry/company_import/interdyne/smallkit
	subcategory = "Small First Aid Kits"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/smallkit/generalkit
	item_type = /obj/item/storage/pouch/medical/firstaid/interdyne

/datum/armament_entry/company_import/interdyne/smallkit/spraykit
	description = "A small first aid kit loaded with a interdyne hypospray and various chemicals for usage /Trained doctor not included/"
	item_type = /obj/item/storage/pouch/medical/firstaid/interdyne/spray
	cost = PAYCHECK_COMMAND * 25

/datum/armament_entry/company_import/interdyne/smallkit/burnkit
	item_type = /obj/item/storage/pouch/medical/firstaid/interdyne/burn

/datum/armament_entry/company_import/interdyne/smallkit/brutekit
	item_type = /obj/item/storage/pouch/medical/firstaid/interdyne/brute

/datum/armament_entry/company_import/interdyne/smallkit/toxinkit
	item_type = /obj/item/storage/pouch/medical/firstaid/interdyne/toxin

/datum/armament_entry/company_import/interdyne/smallkit/oxygenkit
	item_type = /obj/item/storage/pouch/medical/firstaid/interdyne/oxygen

/datum/armament_entry/company_import/interdyne/smallkit/corpsekit
	item_type = /obj/item/storage/pouch/medical/firstaid/interdyne/corpse
	cost = PAYCHECK_COMMAND * 15


// Modsuit mods that CAN be found in the uplinks
/datum/armament_entry/company_import/interdyne/mods
	subcategory = "Modsuits & Modules"
	cost = PAYCHECK_COMMAND * 15

/datum/armament_entry/company_import/interdyne/mods/modsuit
	item_type = /obj/item/mod/control/pre_equipped/interdyne/nerfed
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
	item_type = /obj/structure/closet/crate/secure/syndicate/interdyne/biohazard
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/interdyne/crates/maid
	item_type = /obj/structure/closet/crate/secure/syndicate/interdyne/maid
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/crates/smallkit
	item_type = /obj/structure/closet/crate/secure/syndicate/interdyne/smallkits
	cost = PAYCHECK_COMMAND * 40

/datum/armament_entry/company_import/interdyne/crates/traumakit
	item_type = /obj/structure/closet/crate/secure/syndicate/interdyne/premium
	cost = PAYCHECK_COMMAND * 50

/datum/armament_entry/company_import/interdyne/crates/doctorkit
	item_type = /obj/structure/closet/crate/secure/syndicate/interdyne/doctorbox
	cost = PAYCHECK_COMMAND * 100
