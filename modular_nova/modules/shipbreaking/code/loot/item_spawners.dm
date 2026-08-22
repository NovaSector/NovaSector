/obj/effect/spawner/random/salvage
	abstract_type = /obj/effect/spawner/random/salvage
	name = "shipbreaking random spawner"
	icon = 'modular_nova/modules/shipbreaking/icons/spawners.dmi'
	icon_state = null

/obj/effect/spawner/random/salvage/munitions
	name = "random munitions"
	icon_state = "munitions"
	loot = list(
		/obj/structure/shuttle_decoration/munition/missile,
		/obj/structure/shuttle_decoration/munition/missile/orbital,
		/obj/structure/shuttle_decoration/munition/missile/extraorbital,
		/obj/structure/shuttle_decoration/munition/ciws,
		/obj/structure/shuttle_decoration/munition/autocannon,
		/obj/structure/shuttle_decoration/munition/chaff_flares,
	)

/obj/effect/spawner/random/salvage/munitions/only_ammoboxes
	name = "random ammo crates"
	icon_state = "ammo"
	loot = list(
		/obj/structure/shuttle_decoration/munition/ciws,
		/obj/structure/shuttle_decoration/munition/autocannon,
		/obj/structure/shuttle_decoration/munition/chaff_flares,
	)

/obj/effect/spawner/random/salvage/munitions/only_missiles
	name = "random missiles"
	icon_state = "missiles"
	loot = list(
		/obj/structure/shuttle_decoration/munition/missile,
		/obj/structure/shuttle_decoration/munition/missile/orbital,
		/obj/structure/shuttle_decoration/munition/missile/extraorbital,
	)

/obj/effect/spawner/random/salvage/interior_trash_n_debris
	name = "random shuttle interior trash and debris"
	icon_state = "interior_debris"
	spawn_random_offset = TRUE
	loot = list(
		/obj/effect/spawner/random/salvage/shuttle_maintenance = 2,
		/obj/effect/spawner/random/trash/deluxe_garbage/no_mobs_ever = 4,
		/obj/effect/spawner/random/engineering/tool = 2,
		/obj/effect/spawner/random/bureaucracy/pen = 2,
		/obj/effect/spawner/random/bureaucracy/paper = 2,
		/obj/effect/spawner/random/engineering/flashlight = 2,
		/obj/effect/spawner/random/engineering/toolbox = 1,
		/obj/effect/spawner/random/contraband = 1,
		/obj/effect/spawner/random/entertainment/coin = 1,
		/obj/effect/spawner/random/maintenance/no_decals = 2,
	)

/obj/effect/spawner/random/salvage/shuttle_maintenance
	name = "random shuttle maintenance items"
	icon_state = "maint_loot"
	loot = list(
		/obj/item/epic_loot/water_filter = 2,
		/obj/item/epic_loot/thermometer = 2,
		/obj/item/epic_loot/nail_box = 2,
		/obj/item/epic_loot/cold_weld = 2,
		/obj/item/epic_loot/electric_motor = 2,
		/obj/item/epic_loot/current_converter = 2,
		/obj/item/epic_loot/signal_amp = 2,
		/obj/item/epic_loot/thermal_camera = 2,
		/obj/item/epic_loot/fuel_conditioner = 2,
		/obj/item/epic_loot/shuttle_gyro = 1,
		/obj/item/epic_loot/phased_array = 1,
		/obj/item/epic_loot/shuttle_battery = 1,
		/obj/item/epic_loot/device_fan = 2,
		/obj/item/epic_loot/display = 1,
		/obj/item/epic_loot/display_broken = 2,
		/obj/item/epic_loot/graphics = 1,
		/obj/item/epic_loot/military_circuit = 1,
		/obj/item/epic_loot/civilian_circuit = 2,
		/obj/item/epic_loot/processor = 1,
		/obj/item/epic_loot/power_supply = 2,
		/obj/item/epic_loot/disk_drive = 2,
		/obj/item/epic_loot/ssd = 1,
		/obj/item/epic_loot/hdd = 2,
	)

/obj/effect/spawner/random/salvage/shuttle_maintenance/random_offset
	name = "randomly offset shuttle maintenance items"
	spawn_random_offset = TRUE

/obj/effect/spawner/random/food_or_drink/seed_rare/one
	name = "singular rare seed"
	spawn_loot_count = 1

/obj/effect/spawner/random/food_or_drink/plant_produce/one
	name = "singular plant produce"
	spawn_loot_count = 1

/obj/effect/spawner/random/food_or_drink/seed/one
	name = "singular seed"
	spawn_loot_count = 1

/obj/effect/spawner/random/food_or_drink/seed_flowers/one
	name = "singular flower seed"
	spawn_all_loot = FALSE

/obj/effect/spawner/random/salvage/cargo_machine
	name = "random cargo machine"
	icon_state = "machine"
	loot = list(
		/obj/machinery/portable_atmospherics/pump,
		/obj/machinery/portable_atmospherics/scrubber,
		/obj/machinery/portable_atmospherics/scrubber/huge/movable/cargo,
		/obj/machinery/power/port_gen/pacman/solid_fuel,
		/obj/machinery/power/rtg/portable,
		/obj/machinery/power/portagrav,
		/obj/machinery/chem_dispenser/frontier_appliance,
		/obj/machinery/chem_dispenser,
		/obj/machinery/chem_dispenser/mutagensaltpeter,
		/obj/machinery/coffeemaker/impressa,
		/obj/machinery/dish_drive,
		/obj/machinery/electrolyzer,
		/obj/machinery/electrolyzer/co2_cracker,
		/obj/machinery/exoscanner,
		/obj/machinery/fishing_portal_generator,
		/obj/machinery/fishing_portal_generator/full,
		/obj/machinery/food_cart,
		/obj/machinery/icecream_vat,
		/obj/machinery/hydroponics/constructable,
		/obj/machinery/hydroponics/constructable/fullupgrade,
		/obj/machinery/microwave/engineering/cell_included,
		/obj/machinery/photocopier/gratis/prebuilt,
		/obj/machinery/smesbank/super/full,
		/obj/machinery/smoke_machine,
		/obj/machinery/space_heater,
		/obj/machinery/washing_machine,
		/obj/effect/spawner/random/engineering/atmospherics_portable,
		/obj/effect/spawner/random/engineering/canister,
		/obj/effect/spawner/random/engineering/canister/lots_of_them,
		/obj/effect/spawner/random/engineering/tank,
		/obj/effect/spawner/random/structure/tank_holder,
	)

/obj/effect/spawner/random/salvage/cargo_machine/medical_or_research
	name = "random medical or research machine"
	loot = list(
		/obj/machinery/power/port_gen/pacman/solid_fuel,
		/obj/machinery/power/rtg/portable,
		/obj/machinery/power/portagrav,
		/obj/machinery/chem_dispenser,
		/obj/machinery/chem_dispenser/mutagensaltpeter,
		/obj/machinery/coffeemaker/impressa,
		/obj/machinery/electrolyzer,
		/obj/machinery/electrolyzer/co2_cracker,
		/obj/machinery/exoscanner,
		/obj/machinery/hydroponics/constructable,
		/obj/machinery/hydroponics/constructable/fullupgrade,
		/obj/machinery/chem_master,
		/obj/machinery/chem_heater/withbuffer,
		/obj/machinery/chem_mass_spec,
		/obj/effect/spawner/random/engineering/canister/lots_of_them,
	)

/obj/effect/spawner/random/salvage/cargo_machine/construction
	name = "random construction machine"
	loot = list(
		/obj/machinery/portable_atmospherics/pump,
		/obj/machinery/portable_atmospherics/scrubber,
		/obj/machinery/portable_atmospherics/scrubber/huge/movable/cargo,
		/obj/machinery/power/rtg/portable,
		/obj/machinery/electrolyzer,
		/obj/machinery/electrolyzer/co2_cracker,
		/obj/machinery/smesbank/super/full,
		/obj/machinery/smoke_machine,
		/obj/machinery/space_heater,
		/obj/structure/girder/displaced,
		/obj/effect/spawner/random/engineering/atmospherics_portable,
		/obj/effect/spawner/random/engineering/canister/lots_of_them,
		/obj/effect/spawner/random/engineering/tank,
		/obj/effect/spawner/random/structure/tank_holder,
	)

/obj/effect/spawner/random/salvage/civilian_supply
	name = "random civilian machine"
	loot = list(
		/obj/machinery/portable_atmospherics/pump,
		/obj/machinery/portable_atmospherics/scrubber,
		/obj/machinery/power/port_gen/pacman/solid_fuel,
		/obj/machinery/chem_dispenser/frontier_appliance,
		/obj/machinery/coffeemaker/impressa,
		/obj/machinery/dish_drive,
		/obj/machinery/electrolyzer/co2_cracker,
		/obj/machinery/fishing_portal_generator,
		/obj/machinery/fishing_portal_generator/full,
		/obj/machinery/food_cart,
		/obj/machinery/icecream_vat,
		/obj/machinery/hydroponics/constructable,
		/obj/machinery/hydroponics/constructable/fullupgrade,
		/obj/machinery/microwave/engineering/cell_included,
		/obj/machinery/photocopier/gratis/prebuilt,
		/obj/machinery/space_heater,
		/obj/machinery/washing_machine,
		/obj/effect/spawner/random/engineering/tank,
	)

/obj/effect/spawner/random/salvage/cargo_machine/military
	name = "random military machine"
	loot = list(
		/obj/machinery/power/port_gen/pacman/solid_fuel = 1,
		/obj/machinery/power/rtg/portable = 1,
		/obj/machinery/electrolyzer/co2_cracker = 1,
		/obj/machinery/exoscanner = 1,
		/obj/effect/spawner/random/salvage/munitions = 2,
	)

/obj/effect/spawner/random/salvage/cargo_machine/scrap
	name = "random scrap machine"
	loot = list(
		/obj/structure/hull_plating/airlock,
		/obj/structure/hull_plating/airlock/interior,
		/obj/structure/hull_plating/airlock/access_panel,
		/obj/structure/hull_plating/nanocarbon,
		/obj/structure/hull_plating/nanocarbon/floor,
		/obj/structure/hull_plating/gold_foil,
		/obj/structure/hull_plating/silver_foil,
		/obj/structure/hull_plating/plastamic_sheets,
		/obj/structure/hull_plating/armor_panels,
		/obj/structure/hull_plating/aluminum,
		/obj/structure/hull_plating/aluminum/floor,
		/obj/effect/spawner/random/salvage/nanocarbon_shards,
		/obj/structure/girder/displaced,
		/obj/effect/spawner/random/engineering/canister,
		/obj/effect/spawner/random/engineering/tank,
		/obj/effect/spawner/random/engineering/canister/lots_of_them,
		/obj/effect/spawner/random/structure/tank_holder,
	)

/obj/effect/spawner/random/salvage/nanocarbon_shards
	name = "random nanocarbon shards"
	icon_state = "maint_loot"
	spawn_loot_count = 5
	spawn_random_offset = TRUE
	loot = list(
		/obj/item/nanocarbon_shard,
	)

/obj/effect/spawner/random/engineering/canister/lots_of_them
	name = "shipbreaking low value gas canister spawner"
	loot = list(
		/obj/machinery/portable_atmospherics/canister/air,
		/obj/machinery/portable_atmospherics/canister/anesthetic_mix,
		/obj/machinery/portable_atmospherics/canister/bz,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide,
		/obj/machinery/portable_atmospherics/canister/freon,
		/obj/machinery/portable_atmospherics/canister/hydrogen,
		/obj/machinery/portable_atmospherics/canister/helium,
		/obj/machinery/portable_atmospherics/canister/nitrogen,
		/obj/machinery/portable_atmospherics/canister/nitrous_oxide,
		/obj/machinery/portable_atmospherics/canister/oxygen,
		/obj/machinery/portable_atmospherics/canister/plasma,
		/obj/machinery/portable_atmospherics/canister/water_vapor,
	)

/obj/effect/spawner/random/trash/deluxe_garbage/no_mobs_ever
	name = "deluxe garbage with no mobs spawner"

/obj/effect/spawner/random/trash/deluxe_garbage/no_mobs_ever/Initialize(mapload)
	loot -= /mob/living/basic/mouse
	loot -= /mob/living/basic/snail
	return ..()
