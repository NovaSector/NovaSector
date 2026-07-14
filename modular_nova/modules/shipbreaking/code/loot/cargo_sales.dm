/datum/export/material/aluminum
	cost = CARGO_CRATE_VALUE * 0.175
	material_id = /datum/material/aluminum
	message = "cm3 of aluminum"

/datum/export/material/nanocarbon
	cost = CARGO_CRATE_VALUE * 0.275
	material_id = /datum/material/nanocarbon
	message = "cm3 of nanocarbon"

/datum/export/salvage_generic
	cost = CARGO_CRATE_VALUE * 0.375
	unit_name = "general salvage"
	export_types = list(
		/obj/structure/engine_covers/thruster_nozzle,
		/obj/structure/engine_covers/heater_cover,
		/obj/structure/shuttle_decoration/rcs,
		/obj/structure/shuttle_decoration/ladder,
		/obj/structure/shuttle_decoration/ladder_black,
		/obj/structure/shuttle_decoration/eva_catwalks,
		/obj/structure/shuttle_decoration/radiator,
		/obj/structure/shuttle_decoration/extinguisher,
		/obj/structure/shuttle_decoration/bullbar,
		/obj/structure/shuttle_decoration/headlight,
		/obj/structure/shuttle_decoration/landing_engine,
		/obj/structure/shuttle_decoration/aux_engine,
		/obj/structure/shuttle_decoration/junction_box,
		/obj/structure/shuttle_decoration/console,
	)

/datum/export/shipping_containers
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "salvaged shipping containers"
	export_types = list(
		/obj/structure/closet/shipping_container,
	)

/datum/export/salvage_scanners
	cost = CARGO_CRATE_VALUE
	unit_name = "salvaged sensor equipment"
	export_types = list(
		/obj/machinery/exoscanner/shuttle_part/radar_panel,
		/obj/machinery/exoscanner/shuttle_part/sensors_blister,
		/obj/machinery/exoscanner/shuttle_part/open_sensors_blister,
		/obj/machinery/exoscanner/shuttle_part/radio_dish,
	)

/datum/export/salvage_shipmind
	cost = CARGO_CRATE_VALUE * 3
	unit_name = "recovered shipmind"
	export_types = list(
		/obj/structure/shuttle_decoration/liquid_tank/battery/shipmind,
	)

/datum/export/salvage_reactor
	cost = CARGO_CRATE_VALUE * 5
	unit_name = "salvaged bloom reactor"
	export_types = list(
		/obj/structure/shuttle_decoration/liquid_tank/reactor,
	)

/datum/export/salvage_reactor
	cost = CARGO_CRATE_VALUE * 7.5
	unit_name = "salvaged large bloom reactor"
	export_types = list(
		/obj/structure/shuttle_decoration/liquid_tank/reactor/super,
	)

/datum/export/salvage_engines
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "salvaged engines"
	export_types = list(
		/obj/machinery/power/shuttle_engine/propulsion/salvage,
		/obj/machinery/power/shuttle_engine/heater/salvage,
		/obj/structure/engine_covers/ion_plate,
	)

/datum/export/salvage_hazard
	cost = CARGO_CRATE_VALUE
	unit_name = "hazardous salvage"
	export_types = list(
		/obj/structure/shuttle_decoration/liquid_tank/battery,
		/obj/structure/shuttle_decoration/liquid_tank/coolant,
	)

/datum/export/salvage_munitions
	cost = CARGO_CRATE_VALUE * 1.25
	unit_name = "salvaged munitions"
	export_types = list(
		/obj/structure/shuttle_decoration/munition/missile,
		/obj/structure/shuttle_decoration/munition/missile/orbital,
		/obj/structure/shuttle_decoration/munition/missile/extraorbital,
		/obj/structure/shuttle_decoration/munition/ciws,
		/obj/structure/shuttle_decoration/munition/autocannon,
		/obj/structure/shuttle_decoration/munition/chaff_flares,
	)

/datum/export/salvage_fuel
	cost = CARGO_CRATE_VALUE
	unit_name = "salvaged fuel tanks"
	export_types = list(
		/obj/structure/shuttle_decoration/liquid_tank/explosive,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium,
	)

/datum/export/salvage_fuel_big
	cost = CARGO_CRATE_VALUE * 2
	unit_name = "salvaged large tanks"
	export_types = list(
		/obj/structure/shuttle_decoration/liquid_tank/explosive/industrial,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/hydrazine/industrial,
		/obj/structure/shuttle_decoration/liquid_tank/explosive/lithium/industrial,
	)

/datum/export/salvage_crates
	cost = CARGO_CRATE_VALUE * 0.75
	unit_name = "salvaged shipping crates"
	export_types = list(
		/obj/structure/closet/crate/shuttle,
		/obj/structure/closet/crate/shuttle/small,
		/obj/structure/closet/crate/shuttle_hard,
	)

/datum/export/salvage_airlocks
	cost = CARGO_CRATE_VALUE * 0.5
	unit_name = "salvaged airlocks"
	export_types = list(
		/obj/structure/hull_plating/airlock,
		/obj/structure/hull_plating/airlock/interior,
		/obj/structure/hull_plating/airlock/access_panel,
	)
