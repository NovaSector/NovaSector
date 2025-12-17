/datum/supply_pack/companies/modsuits
	group = "★ Mods and Modsuits"
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

// Mod Suits

/datum/supply_pack/companies/modsuits/mods
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/companies/modsuits/mods/hazard_mod
	name = "HAZARD Frontier Belt Modsuit"
	contains = list(/obj/item/mod/control/pre_equipped/frontier_colonist)
	desc = "Spaceproof, shockproof, fits on your belt, and barely slows you down thanks \
		thanks to proprietary \"not putting servos in the joints\" technology! \
		What more could you ask for in the dead of space?"
	auto_name = FALSE
	cost = CARGO_CRATE_VALUE * 3.25

/datum/supply_pack/companies/modsuits/mods/civilian_mod
	name = "Civilian Miniaturized Belt Modsuit"
	contains = list(/obj/item/mod/control/pre_equipped/civilian)
	desc = "A non spaceproof belt Modsuit made for civilian operations and Modsuit training \
		this convenient frame allows the user to enjoy most Modsuit Modules without having to rely \
		on a heavy backpack control unit, making its operation less taxing and convenient for the \
		average user."
	auto_name = FALSE
	cost = CARGO_CRATE_VALUE * 2.5

/datum/supply_pack/companies/modsuits/mods/voskhod_refit_kit
	contains = list(/obj/item/crafting_conversion_kit/voskhod_refit)
	cost = CARGO_CRATE_VALUE * 6
	access = ACCESS_WEAPONS
	access_view = ACCESS_WEAPONS
	express_lock = TRUE
	order_flags = ORDER_GOODY
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

// MOD cores & Fuel

/datum/supply_pack/companies/modsuits/core
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/modsuits/core/standard
	contains = list(/obj/item/mod/core/standard)

/datum/supply_pack/companies/modsuits/core/plasma
	contains = list(/obj/item/mod/core/plasma)

/datum/supply_pack/companies/modsuits/core/ethereal
	contains = list(/obj/item/mod/core/ethereal)

/datum/supply_pack/companies/modsuits/core/voskhod_autodoc_refill
	contains = list(/obj/item/reagent_containers/cup/glass/waterbottle/large/protozine)
	cost = CARGO_CRATE_VALUE

// MOD plating

/datum/supply_pack/companies/modsuits/plating
	cost = CARGO_CRATE_VALUE * 0.5
	desc = "External plating used to finish a MOD control unit."
	auto_name = FALSE

/datum/supply_pack/companies/modsuits/plating/standard
	name = "MOD Standard Plating"
	contains = list(/obj/item/mod/construction/plating)
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/modsuits/plating/medical
	name = "MOD Medical Plating"
	contains = list(/obj/item/mod/construction/plating/medical)

/datum/supply_pack/companies/modsuits/plating/engineering
	name = "MOD Engineering Plating"
	contains = list(/obj/item/mod/construction/plating/engineering)

/datum/supply_pack/companies/modsuits/plating/atmospherics
	name = "MOD Atmospherics Plating"
	contains = list(/obj/item/mod/construction/plating/atmospheric)

/datum/supply_pack/companies/modsuits/plating/security
	name = "MOD Security Plating"
	contains = list(/obj/item/mod/construction/plating/security)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/modsuits/plating/clown
	name = "MOD CosmoHonk (TM) Plating"
	contains = list(/obj/item/mod/construction/plating/cosmohonk)

// MOD modules

// Protection, so shielding and whatnot

/datum/supply_pack/companies/modsuits/protection_modules
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/modsuits/protection_modules/welding
	contains = list(/obj/item/mod/module/welding)

/datum/supply_pack/companies/modsuits/protection_modules/longfall
	contains = list(/obj/item/mod/module/longfall)

/datum/supply_pack/companies/modsuits/protection_modules/rad_protection
	contains = list(/obj/item/mod/module/rad_protection)

/datum/supply_pack/companies/modsuits/protection_modules/emp_shield
	contains = list(/obj/item/mod/module/emp_shield)

/datum/supply_pack/companies/modsuits/protection_modules/dampener
	contains = list(/obj/item/mod/module/projectile_dampener)

// Medical Mods

/datum/supply_pack/companies/modsuits/medical_modules
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/modsuits/medical_modules/injector
	contains = list(/obj/item/mod/module/injector)

/datum/supply_pack/companies/modsuits/medical_modules/organizer
	contains = list(/obj/item/mod/module/organizer)

/datum/supply_pack/companies/modsuits/medical_modules/patient_transport
	contains = list(/obj/item/mod/module/criminalcapture/patienttransport)

/datum/supply_pack/companies/modsuits/medical_modules/thread_ripper
	contains = list(/obj/item/mod/module/thread_ripper)

/datum/supply_pack/companies/modsuits/medical_modules/surgical_processor
	contains = list(/obj/item/mod/module/surgical_processor)

/datum/supply_pack/companies/modsuits/medical_modules/quick_carry
	contains = list(/obj/item/mod/module/quick_carry)

// Utility modules, general purpose stuff that really anyone might want
/datum/supply_pack/companies/modsuits/utility_modules
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/modsuits/utility_modules/flashlight
	contains = list(/obj/item/mod/module/flashlight)

/datum/supply_pack/companies/modsuits/utility_modules/regulator
	contains = list(/obj/item/mod/module/thermal_regulator)

/datum/supply_pack/companies/modsuits/utility_modules/mouthhole
	contains = list(/obj/item/mod/module/mouthhole)

/datum/supply_pack/companies/modsuits/utility_modules/signlang
	contains = list(/obj/item/mod/module/signlang_radio)

/datum/supply_pack/companies/modsuits/utility_modules/plasma_stabilizer
	contains = list(/obj/item/mod/module/plasma_stabilizer)

/datum/supply_pack/companies/modsuits/utility_modules/basic_storage
	contains = list(/obj/item/mod/module/storage)

/datum/supply_pack/companies/modsuits/utility_modules/expanded_storage
	contains = list(/obj/item/mod/module/storage/large_capacity)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/modsuits/utility_modules/retract_plates
	contains = list(/obj/item/mod/module/plate_compression)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/modsuits/utility_modules/magnetic_deploy
	contains = list(/obj/item/mod/module/springlock/contractor)
	cost = CARGO_CRATE_VALUE

// Mobility modules, jetpacks and stuff

/datum/supply_pack/companies/modsuits/mobility_modules
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/modsuits/mobility_modules/tether
	contains = list(/obj/item/mod/module/tether)
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/modsuits/mobility_modules/magboot
	contains = list(/obj/item/mod/module/magboot)

/datum/supply_pack/companies/modsuits/mobility_modules/jetpack
	contains = list(/obj/item/mod/module/jetpack)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/modsuits/mobility_modules/pathfinder
	contains = list(/obj/item/mod/module/pathfinder)

/datum/supply_pack/companies/modsuits/mobility_modules/disposals
	contains = list(/obj/item/mod/module/disposal_connector)

/datum/supply_pack/companies/modsuits/mobility_modules/sphere
	contains = list(/obj/item/mod/module/sphere_transform)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/modsuits/mobility_modules/atrocinator
	contains = list(/obj/item/mod/module/atrocinator)
	cost = CARGO_CRATE_VALUE

// Novelty modules, goofy stuff that's rare/unprintable, but doesn't fit in any of the above categories

/datum/supply_pack/companies/modsuits/novelty_modules
	cost = CARGO_CRATE_VALUE * 0.2

/datum/supply_pack/companies/modsuits/novelty_modules/waddle
	contains = list(/obj/item/mod/module/waddle)

/datum/supply_pack/companies/modsuits/novelty_modules/bike_horn
	contains = list(/obj/item/mod/module/bikehorn)

/datum/supply_pack/companies/modsuits/novelty_modules/microwave_beam
	contains = list(/obj/item/mod/module/microwave_beam)

/datum/supply_pack/companies/modsuits/novelty_modules/tanner
	contains = list(/obj/item/mod/module/tanner)

/datum/supply_pack/companies/modsuits/novelty_modules/rave
	contains = list(/obj/item/mod/module/visor/rave)

/datum/supply_pack/companies/modsuits/novelty_modules/hat_stabilizer
	contains = list(/obj/item/mod/module/hat_stabilizer)

/datum/supply_pack/companies/modsuits/novelty_modules/dart_collector_safe
	contains = list(/obj/item/mod/module/recycler/donk/safe)

/datum/supply_pack/companies/modsuits/novelty_modules/dart_collector
	contains = list(/obj/item/mod/module/recycler/donk)
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/companies/modsuits/anomalock
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE
	cost = CARGO_CRATE_VALUE * 7.5

/datum/supply_pack/companies/modsuits/anomalock/kinesis
	contains = list(/obj/item/mod/module/anomaly_locked/kinesis/prebuilt/locked)

/datum/supply_pack/companies/modsuits/anomalock/antigrav
	contains = list(/obj/item/mod/module/anomaly_locked/antigrav/prebuilt/locked)

/datum/supply_pack/companies/modsuits/anomalock/teleporter
	contains = list(/obj/item/mod/module/anomaly_locked/teleporter/prebuilt/locked)
	cost = CARGO_CRATE_VALUE * 10
