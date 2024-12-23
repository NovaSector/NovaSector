/datum/mod_theme/responsory/ancient_milsim
	armor_type = /datum/armor/armor_sf_hardened

/obj/item/mod/control/pre_equipped/responsory/milsim_mechanic
	theme = /datum/mod_theme/responsory/ancient_milsim
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	insignia_type = /obj/item/mod/module/insignia/engineer
	additional_module = /obj/item/mod/module/dispenser/ancient_milsim/mechanic

/obj/item/mod/control/pre_equipped/responsory/milsim_trapper
	theme = /datum/mod_theme/responsory/ancient_milsim
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/thermal,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/thermal,
	)
	insignia_type = /obj/item/mod/module/insignia/commander
	additional_module = /obj/item/mod/module/dispenser/ancient_milsim/trapper

/obj/item/mod/control/pre_equipped/responsory/milsim_marksman
	theme = /datum/mod_theme/responsory/ancient_milsim
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/security
	additional_module = /obj/item/mod/module/dispenser/ancient_milsim/marksman

/obj/item/mod/control/pre_equipped/responsory/milsim_medic
	theme = /datum/mod_theme/responsory/ancient_milsim
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/medhud,
	)
	insignia_type = /obj/item/mod/module/insignia/medic
	additional_module = /obj/item/mod/module/dispenser/ancient_milsim/medic

/obj/item/mod/module/dispenser/ancient_milsim
	removable = FALSE
	var/first_user = TRUE
	var/new_dispense_type = /obj/item
	var/new_cooldown_time = 2 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/on_use()
	. = ..()
	if(first_use)
		first_use = FALSE
		cooldown_time = new_cooldown_time
		dispense_type = new_dispense_type

/obj/item/mod/module/dispenser/ancient_milsim/mechanic
	name = "alien tools-cable dispenser module"
	desc = "This module can create set of advanced tools and additional cable coils at the user's liking."
	dispense_type = /obj/item/storage/belt/military/abductor/full
	cooldown_time = 45 SECONDS
	new_dispense_type = /obj/item/stack/cable_coil
	new_cooldown_time = 10 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/trapper
	name = "chameleon projector-stealth landmines dispenser module"
	desc = "This module can create a chameleon projector and additional stealth landmines at the user's liking."
	dispense_type = /obj/item/chameleon
	cooldown_time = 15 SECONDS
	new_dispense_type = /obj/item/minespawner/ancient_milsim
	new_cooldown_time = 10 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/marksman
	name = "barricade box-throwing knives dispenser module"
	desc = "This module can create a box of barricades and additional throwing knives at the user's liking."
	dispense_type = /obj/item/storage/barricade
	cooldown_time = 15 SECONDS
	new_dispense_type = /obj/item/knife/combat/throwing
	new_cooldown_time = 5 SECONDS

/obj/item/mod/module/dispenser/ancient_milsim/medic
	name = "custom hypospray-hypospray vials dispenser module"
	desc = "This module can create a single combat hypospray and additional cartridges at the user's liking."
	dispense_type = /obj/item/hypospray/mkii/deluxe/cmo/combat/ancient_milsim
	cooldown_time = 5 SECONDS
	new_dispense_type = /obj/item/reagent_containers/cup/vial/large/ancient_milsim
	new_cooldown_time = 15 SECONDS

/obj/item/hypospray/mkii/deluxe/cmo/combat/ancient_milsim
	start_vial = /obj/item/reagent_containers/cup/vial/large/ancient_milsim

/obj/item/reagent_containers/cup/vial/large/ancient_milsim
	name = "All-Heal-Virtual"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(
		/datum/reagent/medicine/muscle_stimulant = 15,
		/datum/reagent/medicine/regen_jelly = 30,
		/datum/reagent/iron = 25,
		/datum/reagent/medicine/coagulant = 15,
		/datum/reagent/medicine/c2/penthrite = 15,
	)
