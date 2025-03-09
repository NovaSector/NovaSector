/datum/armament_entry/company_import/interdyne
	category = INTERDYNE_NAME
	company_bitflag = INDEPENDENT_INTERDYNE
	offstation = TRUE

/datum/armament_entry/company_import/interdyne/solo
	subcategory = "individual products"
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/interdyne/solo/defib
	item_type = /obj/item/defibrillator/compact/combat/loaded/interdyne

/datum/armament_entry/company_import/interdyne/solo/medkit
	item_type = /obj/item/storage/medkit/tactical/premium

/datum/armament_entry/company_import/interdyne/solo/hypospray
	item_type = /obj/item/reagent_containers/hypospray/combat/empty


/datum/armament_entry/company_import/interdyne/kits
	subcategory = "kits"
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/interdyne/kits/maid_multi
	item_type = /obj/item/storage/backpack/duffelbag/syndie/interdyne/advancedkit

/datum/armament_entry/company_import/interdyne/kits/maid_sing
	item_type = /obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing

/datum/armament_entry/company_import/interdyne/kits/multi_kit
	item_type = /obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_multi


// Modsuit mods that CAN be found in the uplinks
/datum/armament_entry/company_import/interdyne/mods
	subcategory = "Modsuits & Modules"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/mods/modsuit
	item_type = /obj/item/mod/control/pre_equipped/interdyne

/datum/armament_entry/company_import/interdyne/ai
	subcategory = "Artificial Intelligence"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/interdyne/ai/mmi
	item_type = /obj/item/mmi/syndie/interdyne

/datum/armament_entry/company_import/interdyne/ai/modsuit
	item_type = /obj/item/mmi/posibrain/syndie/interdyne
