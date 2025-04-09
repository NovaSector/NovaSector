/datum/armament_entry/company_import/kahraman
	category = KAHRAMAN_INDUSTRIES_NAME
	company_bitflag = CARGO_COMPANY_KAHRAMAN

// Tools that you could use the rapid fabricator for, but you're too lazy to actually do that

/datum/armament_entry/company_import/kahraman/basic
	subcategory = "Hand-Held Equipment"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kahraman/basic/fock
	item_type = /obj/item/multitool/fock
	cost = PAYCHECK_COMMAND * 4

/datum/armament_entry/company_import/kahraman/basic/omni_drill
	item_type = /obj/item/screwdriver/omni_drill

/datum/armament_entry/company_import/kahraman/basic/arc_welder
	item_type = /obj/item/weldingtool/electric/arc_welder

/datum/armament_entry/company_import/kahraman/basic/compact_drill
	item_type = /obj/item/pickaxe/drill/compact

/datum/armament_entry/company_import/kahraman/basic/gps
	item_type = /obj/item/gps
	cost = PAYCHECK_CREW

// Occupational health and safety? Never heard of her.

/datum/armament_entry/company_import/kahraman/ppe
	subcategory = "Protective Equipment"

/datum/armament_entry/company_import/kahraman/ppe/gas_mask
	item_type = /obj/item/clothing/mask/gas/atmos/frontier_colonist
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kahraman/ppe/headset
	item_type = /obj/item/radio/headset/headset_frontier_colonist
	cost = PAYCHECK_COMMAND * 1.5

/datum/armament_entry/company_import/kahraman/ppe/flak_vest
	item_type = /obj/item/clothing/suit/frontier_colonist_flak
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/kahraman/ppe/tanker_helmet
	item_type = /obj/item/clothing/head/frontier_colonist_helmet
	cost = PAYCHECK_COMMAND

// Pouches

/datum/armament_entry/company_import/kahraman/pouches
	subcategory = "Pouches"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kahraman/pouches/medipen
	item_type = /obj/item/storage/pouch/cin_medipens

/datum/armament_entry/company_import/kahraman/pouches/medikit
	item_type = /obj/item/storage/pouch/cin_medkit

/datum/armament_entry/company_import/kahraman/pouches/general
	item_type = /obj/item/storage/pouch/cin_general

// Work clothing

/datum/armament_entry/company_import/kahraman/work_clothing
	subcategory = "Clothing"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kahraman/work_clothing/jumpsuit
	item_type = /obj/item/clothing/under/frontier_colonist

/datum/armament_entry/company_import/kahraman/work_clothing/jacket
	item_type = /obj/item/clothing/suit/jacket/frontier_colonist

/datum/armament_entry/company_import/kahraman/work_clothing/jacket_short
	item_type = /obj/item/clothing/suit/jacket/frontier_colonist/short

/datum/armament_entry/company_import/kahraman/work_clothing/med_jacket
	item_type = /obj/item/clothing/suit/jacket/frontier_colonist/medical

/datum/armament_entry/company_import/kahraman/work_clothing/ballcap
	item_type = /obj/item/clothing/head/soft/frontier_colonist

/datum/armament_entry/company_import/kahraman/work_clothing/med_ballcap
	item_type = /obj/item/clothing/head/soft/frontier_colonist/medic

/datum/armament_entry/company_import/kahraman/work_clothing/booties
	item_type = /obj/item/clothing/shoes/jackboots/frontier_colonist

/datum/armament_entry/company_import/kahraman/work_clothing/gloves
	item_type = /obj/item/clothing/gloves/frontier_colonist


// "Equipment", so storage items and whatnot

/datum/armament_entry/company_import/kahraman/storage_equipment
	subcategory = "Personal Equipment"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/kahraman/storage_equipment/backpack
	item_type = /obj/item/storage/backpack/industrial/frontier_colonist

/datum/armament_entry/company_import/kahraman/storage_equipment/satchel
	item_type = /obj/item/storage/backpack/industrial/frontier_colonist/satchel

/datum/armament_entry/company_import/kahraman/storage_equipment/messenger
	item_type = /obj/item/storage/backpack/industrial/frontier_colonist/messenger

/datum/armament_entry/company_import/kahraman/storage_equipment/belt
	item_type = /obj/item/storage/belt/utility/frontier_colonist

/datum/armament_entry/company_import/kahraman/storage_equipment/vest
	item_type = /obj/item/clothing/accessory/colonial_webbing
