/datum/armament_entry/company_import/akh_frontier
	category = FRONTIER_EQUIPMENT_NAME
	company_bitflag = CARGO_COMPANY_FRONTIER_EQUIPMENT

// Flatpacked fabricator and related upgrades

/datum/armament_entry/company_import/akh_frontier/deployables_fab
	subcategory = "Deployable Fabrication Equipment"

/datum/armament_entry/company_import/akh_frontier/deployables_fab/rapid_construction_fabricator
	item_type = /obj/item/flatpacked_machine
	cost = CARGO_CRATE_VALUE * 6

/datum/armament_entry/company_import/akh_frontier/deployables_fab/foodricator
	item_type = /obj/item/flatpacked_machine/organics_ration_printer
	cost = CARGO_CRATE_VALUE * 2

// Various smaller appliances than the deployable machines below

/datum/armament_entry/company_import/akh_frontier/appliances
	subcategory = "Appliances"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/akh_frontier/appliances/charger
	item_type = /obj/item/wallframe/cell_charger_multi
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/akh_frontier/appliances/wall_heater
	item_type = /obj/item/wallframe/wall_heater
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/akh_frontier/appliances/water_synth
	item_type = /obj/item/flatpacked_machine/water_synth

/datum/armament_entry/company_import/akh_frontier/appliances/hydro_synth
	item_type = /obj/item/flatpacked_machine/hydro_synth

/datum/armament_entry/company_import/akh_frontier/appliances/sustenance_dispenser
	item_type = /obj/item/flatpacked_machine/sustenance_machine
	cost = PAYCHECK_COMMAND * 2

/datum/armament_entry/company_import/akh_frontier/appliances/biogenerator
	item_type = /obj/item/flatpacked_machine/organics_printer
	description = "An advanced machine seen in frontier outposts and colonies capable of turning organic plant matter into \
		reagents and items of use that a fabricator can't typically make."
	cost = CARGO_CRATE_VALUE * 3

// Flatpacked, ready to deploy machines

/datum/armament_entry/company_import/akh_frontier/deployables_misc
	subcategory = "Deployable General Equipment"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/akh_frontier/deployables_misc/arc_furnace
	item_type = /obj/item/flatpacked_machine/arc_furnace

/datum/armament_entry/company_import/akh_frontier/deployables_misc/co2_cracker
	item_type = /obj/item/flatpacked_machine/co2_cracker

/datum/armament_entry/company_import/akh_frontier/deployables_misc/recycler
	item_type = /obj/item/flatpacked_machine/recycler

/datum/armament_entry/company_import/akh_frontier/deployables_misc/ore_thumper
	item_type = /obj/item/flatpacked_machine/ore_thumper
	description = "A frame with a heavy block of metal suspended atop a pipe. \
		Must be deployed outdoors and given a wired power connection. \
		Forces pressurized gas into the ground which brings up buried resources."
	cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/company_import/akh_frontier/deployables_misc/gps_beacon
	item_type = /obj/item/flatpacked_machine/gps_beacon
	description = "A packed GPS beacon, can be deployed and anchored into the ground to \
		provide and unobstructed homing beacon for wayward travelers across the galaxy."
	cost = PAYCHECK_LOWER

// Flatpacked, ready to deploy machines for power related activities

/datum/armament_entry/company_import/akh_frontier/deployables
	subcategory = "Deployable Power Equipment"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/akh_frontier/deployables/turbine
	item_type = /obj/item/flatpacked_machine/wind_turbine
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/akh_frontier/deployables/solids_generator
	item_type = /obj/item/flatpacked_machine/fuel_generator

/datum/armament_entry/company_import/akh_frontier/deployables/stirling_generator
	item_type = /obj/item/flatpacked_machine/stirling_generator
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/akh_frontier/deployables/rtg
	item_type = /obj/item/flatpacked_machine/rtg
	cost = PAYCHECK_COMMAND * 2
