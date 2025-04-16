/datum/armament_entry/company_import/mining_corps // Pricing logic is PAYCHECK_CREW * (point price/100), miners still get unlimited of all this thanks to vents infinite points.
	category = MINING_CORPS_NAME
	company_bitflag = CARGO_COMPANY_MINING_CORPS

// All Drilling equipment, ie, stuff made to break rock. A bit cheaper given how the rest of similar equipment is cheap on cargo when ordering it.

/datum/armament_entry/company_import/mining_corps/drill
	subcategory = "Drilling Equipment"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/mining_corps/drill/resonator
	item_type = /obj/item/resonator
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/drill/resonator_upgraded
	item_type = /obj/item/resonator/upgraded
	cost = PAYCHECK_CREW * 16

/datum/armament_entry/company_import/mining_corps/drill/pickaxe
	item_type = /obj/item/pickaxe/mini

/datum/armament_entry/company_import/mining_corps/drill/pickaxe/silver
	item_type = /obj/item/pickaxe/silver
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/mining_corps/drill/pickaxe/diamond
	item_type = /obj/item/pickaxe/diamond
	cost = PAYCHECK_CREW * 10

/datum/armament_entry/company_import/mining_corps/drill/drill
	item_type = /obj/item/pickaxe/drill
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/drill/diamonddrill
	item_type = /obj/item/pickaxe/drill/diamonddrill
	cost = PAYCHECK_CREW * 14

/datum/armament_entry/company_import/mining_corps/drill/jackhammer
	item_type = /obj/item/pickaxe/drill/jackhammer
	cost = PAYCHECK_CREW * 20

/datum/armament_entry/company_import/mining_corps/drill/plasmacutter
	item_type = /obj/item/gun/energy/plasmacutter
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/drill/plasmacutter_adv
	item_type = /obj/item/gun/energy/plasmacutter/adv
	cost = PAYCHECK_CREW * 16

// Equipment and things that arent weapons, suits or ways to mine.

/datum/armament_entry/company_import/mining_corps/mining
	subcategory = "Mining Equipment"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/mining_corps/mining/mining_scanner
	item_type = /obj/item/mining_scanner

/datum/armament_entry/company_import/mining_corps/mining/adv_mining_scanner
	item_type = /obj/item/t_scanner/adv_mining_scanner
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/gear/emergency_oxygen
	item_type = /obj/item/tank/internals/emergency_oxygen/engi

/datum/armament_entry/company_import/mining_corps/gear/oxygen
	item_type = /obj/item/tank/internals/oxygen/yellow
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/mining_corps/mining/marker_beacon
	item_type = /obj/item/stack/marker_beacon/ten

/datum/armament_entry/company_import/mining_corps/mining/weather_monitor
	item_type = /obj/item/radio/weather_monitor
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/mining_corps/mining/boulder_collector
	item_type = /obj/item/flatpacked_machine/boulder_collector/nt
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/mining_corps/mining/vent
	item_type = /obj/item/pinpointer/vent
	cost = PAYCHECK_CREW * 11

/datum/armament_entry/company_import/mining_corps/mining/fulton_core
	item_type = /obj/item/fulton_core
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/mining_corps/mining/extraction_pack
	item_type = /obj/item/extraction_pack
	cost = PAYCHECK_CREW * 8

/datum/armament_entry/company_import/mining_corps/mining/wormhole_jaunter
	item_type = /obj/item/wormhole_jaunter
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/mining/environmental
	item_type = /obj/item/bodybag/environmental
	cost = PAYCHECK_CREW * 5

/datum/armament_entry/company_import/mining_corps/mining/skeleton_key
	item_type = /obj/item/skeleton_key
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/mining/mining_stabilizer
	item_type = /obj/item/mining_stabilizer
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/mining_corps/mining/lantern
	item_type = /obj/item/flashlight/lantern
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/mining_corps/mining/rescue
	name = "Rescue Fishing Rod"
	item_type = /obj/item/fishing_rod/rescue
	description = "For when your fellow miner has inevitably fallen into a chasm, and it's up to you to save them."
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/mining/grapple_gun
	item_type = /obj/item/grapple_gun
	cost = PAYCHECK_CREW * 30

// All wearables except for the Modsuits

/datum/armament_entry/company_import/mining_corps/gear
	subcategory = "Mining Gear"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/mining_corps/gear/bhop
	item_type = /obj/item/clothing/shoes/bhop
	cost = PAYCHECK_CREW * 20

/datum/armament_entry/company_import/mining_corps/gear/ice_boots
	item_type = /obj/item/clothing/shoes/winterboots/ice_boots
	cost = PAYCHECK_CREW * 20

/datum/armament_entry/company_import/mining_corps/gear/seva_mask
	item_type = /obj/item/clothing/mask/gas/seva

/datum/armament_entry/company_import/mining_corps/gear/seva
	item_type = /obj/item/clothing/suit/hooded/seva
	cost = PAYCHECK_CREW * 4

/datum/armament_entry/company_import/mining_corps/gear/kheiral_cuffs
	item_type = /obj/item/kheiral_cuffs
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/gear/meson
	item_type = /obj/item/clothing/glasses/meson

/datum/armament_entry/company_import/mining_corps/gear/prescription
	item_type = /obj/item/clothing/glasses/meson/prescription
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/mining_corps/gear/style_meter
	item_type = /obj/item/style_meter
	cost = PAYCHECK_CREW * 12

/datum/armament_entry/company_import/mining_corps/gear/ore
	item_type =  /obj/item/storage/bag/ore

/datum/armament_entry/company_import/mining_corps/gear/holding
	item_type =  /obj/item/storage/bag/ore/holding
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/gear/belt
	item_type = /obj/item/storage/belt/mining
	cost = PAYCHECK_CREW * 4

// All PKA Stuff

/datum/armament_entry/company_import/mining_corps/pka
	subcategory = "Proto-Kinetic Accelerators"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/mining_corps/pka/kinetic_accelerator
	item_type = /obj/item/gun/energy/recharge/kinetic_accelerator
	cost = PAYCHECK_CREW * 6

/datum/armament_entry/company_import/mining_corps/pka/tracer
	name = "White Tracer PKA Mod"
	item_type = /obj/item/borg/upgrade/modkit/tracer

/datum/armament_entry/company_import/mining_corps/pka/tracer_adjustable
	name = "Colorable Tracer PKA Mod"
	item_type = /obj/item/borg/upgrade/modkit/tracer/adjustable
	cost = PAYCHECK_CREW * 1.5

/datum/armament_entry/company_import/mining_corps/pka/chassis_mod
	name = "Super Chassis PKA Mod"
	item_type = /obj/item/borg/upgrade/modkit/chassis_mod
	cost = PAYCHECK_CREW * 2

/datum/armament_entry/company_import/mining_corps/pka/orange
	name = "Hyper Chassis PKA Mod"
	item_type = /obj/item/borg/upgrade/modkit/chassis_mod/orange
	cost = PAYCHECK_CREW * 3
