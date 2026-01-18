/datum/supply_pack/companies/machines
	group = "★ Machines and Flatpacks"
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

// Akh Frontier

/datum/supply_pack/companies/machines

/datum/supply_pack/companies/machines/akh_frontier/deployables_fab

/datum/supply_pack/companies/machines/akh_frontier/deployables_fab/rapid_construction_fabricator
	contains = list(/obj/item/flatpacked_machine)
	cost = CARGO_CRATE_VALUE * 6
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/companies/machines/akh_frontier/deployables_fab/foodricator
	contains = list(/obj/item/flatpacked_machine/organics_ration_printer)
	cost = CARGO_CRATE_VALUE * 2

// Various smaller appliances than the deployable machines below

/datum/supply_pack/companies/machines/akh_frontier/appliances
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/machines/akh_frontier/appliances/charger
	contains = list(/obj/item/wallframe/cell_charger_multi)
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/machines/akh_frontier/appliances/wall_heater
	contains = list(/obj/item/wallframe/wall_heater)
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/machines/akh_frontier/appliances/water_synth
	contains = list(/obj/item/flatpacked_machine/water_synth)

/datum/supply_pack/companies/machines/akh_frontier/appliances/hydro_synth
	contains = list(/obj/item/flatpacked_machine/hydro_synth)

/datum/supply_pack/companies/machines/akh_frontier/appliances/sustenance_dispenser
	contains = list(/obj/item/flatpacked_machine/sustenance_machine)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/machines/akh_frontier/appliances/biogenerator
	contains = list(/obj/item/flatpacked_machine/organics_printer)
	desc = "An advanced machine seen in frontier outposts and colonies capable of turning organic plant matter into \
		reagents and items of use that a fabricator can't typically make."
	cost = CARGO_CRATE_VALUE * 3

// Flatpacked, ready to deploy machines

/datum/supply_pack/companies/machines/akh_frontier/deployables_misc
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/machines/akh_frontier/deployables_misc/arc_furnace
	contains = list(/obj/item/flatpacked_machine/arc_furnace)

/datum/supply_pack/companies/machines/akh_frontier/deployables_misc/co2_cracker
	contains = list(/obj/item/flatpacked_machine/co2_cracker)

/datum/supply_pack/companies/machines/akh_frontier/deployables_misc/recycler
	contains = list(/obj/item/flatpacked_machine/recycler)

/datum/supply_pack/companies/machines/akh_frontier/deployables_misc/ore_thumper
	contains = list(/obj/item/flatpacked_machine/ore_thumper)
	name = " Ore Thumper"
	desc = "A frame with a heavy block of metal suspended atop a pipe. \
		Must be deployed outdoors and given a wired power connection. \
		Forces pressurized gas into the ground which brings up buried resources."
	cost = CARGO_CRATE_VALUE * 5
	auto_name = FALSE

/datum/supply_pack/companies/machines/akh_frontier/deployables_misc/gps_beacon
	contains = list(/obj/item/flatpacked_machine/gps_beacon)
	desc = "A packed GPS beacon that can be deployed and anchored into the ground to \
		provide and unobstructed homing beacon for wayward travelers across the galaxy."
	cost = CARGO_CRATE_VALUE * 0.2

// Flatpacked, ready to deploy machines for power related activities

/datum/supply_pack/companies/machines/akh_frontier/deployables
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/machines/akh_frontier/deployables/turbine
	contains = list(/obj/item/flatpacked_machine/wind_turbine)
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/machines/akh_frontier/deployables/solids_generator
	contains = list(/obj/item/flatpacked_machine/fuel_generator)
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/companies/machines/akh_frontier/deployables/stirling_generator
	contains = list(/obj/item/flatpacked_machine/stirling_generator)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/machines/akh_frontier/deployables/rtg
	contains = list(/obj/item/flatpacked_machine/rtg)
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/companies/machines/akh_frontier/deployables/solar
	contains = list(/obj/item/flatpacked_machine/solar)
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/machines/akh_frontier/deployables/solar/titaniumglass
	contains = list(/obj/item/flatpacked_machine/solar/titaniumglass)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/machines/akh_frontier/deployables/solar/plasmaglass
	contains = list(/obj/item/flatpacked_machine/solar/plasmaglass)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/machines/akh_frontier/deployables/solar/plastitaniumglass
	contains = list(/obj/item/flatpacked_machine/solar/plastitaniumglass)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/machines/akh_frontier/deployables/solar_tracker
	contains = list(/obj/item/flatpacked_machine/solar_tracker)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/machines/akh_frontier/deployables/solar_control
	name = "Solar Array Console Board"
	contains = list(/obj/item/circuitboard/computer/solar_control)
	desc = "The circuit board for the console that controls the solar panel arrays"
	cost = CARGO_CRATE_VALUE * 1.5 // since the circuit board can be exported for 0.75 of a CCV, we need to be careful with the price of this one.
	auto_name = FALSE

// HC

/datum/supply_pack/companies/machines/hc_surplus

/datum/supply_pack/companies/machines/hc_surplus/food_replicator
	name = "Food Replicator"
	desc = "A widespread technology previously used by far colonies on the HC's borders, over time being shifted from the foundation of colonies \
		to a simple disaster relief solution. It can turn spoiled or inedible plant matter into food, medical supplies, and other general items. \
		These particular units were displaced during a stock count in an HC warehouse."
	contains = list(/obj/item/flatpack/food_replicator)
	cost = CARGO_CRATE_VALUE * 9
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE 
	auto_name = FALSE

// Vitezstvi

/datum/supply_pack/companies/machines/vitezstvi

/datum/supply_pack/companies/machines/vitezstvi/bench_itself
	contains = list(/obj/item/flatpack/ammo_workbench)
	cost = CARGO_CRATE_VALUE

// basic disk
/datum/supply_pack/companies/machines/vitezstvi/ammo_disk
	contains = list(/obj/item/ammo_workbench_module/lethal)
	cost = CARGO_CRATE_VALUE * 1.5

// disk but with the bits needed for EMP/fire bullets
/datum/supply_pack/companies/machines/vitezstvi/ammo_disk/lethal_gimmick
	contains = list(/obj/item/ammo_workbench_module/lethal_gimmick)
	cost = CARGO_CRATE_VALUE * 2.5

// disk but it's got HP/AP
/datum/supply_pack/companies/machines/vitezstvi/ammo_disk/variant
	contains = list(/obj/item/ammo_workbench_module/lethal_variant)
	cost = CARGO_CRATE_VALUE * 4

/datum/supply_pack/companies/machines/vitezstvi/bullet_drive
	contains = list(/obj/item/flatpack/bullet_drive)
	cost = CARGO_CRATE_VALUE

// Donk

/datum/supply_pack/companies/machines/donk

/datum/supply_pack/companies/machines/donk/vendors
	contains = list(/obj/item/summon_beacon/vendors)
	cost = CARGO_CRATE_VALUE * 3
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE 
