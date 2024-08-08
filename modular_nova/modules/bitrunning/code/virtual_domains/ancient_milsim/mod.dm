/obj/item/mod/control/pre_equipped/responsory/milsim_mechanic
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/meson,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/meson,
	)
	insignia_type = /obj/item/mod/module/insignia/engineer
	additional_module = /obj/item/mod/module/dispenser/incendiary

/obj/item/mod/control/pre_equipped/responsory/milsim_trapper
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/active_sonar,
	)
	insignia_type = /obj/item/mod/module/insignia/commander
	additional_module = /obj/item/mod/module/dispenser/landmine

/obj/item/mod/control/pre_equipped/responsory/milsim_marksman
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/security
	additional_module = /obj/item/mod/module/shooting_assistant

/obj/item/mod/control/pre_equipped/responsory/milsim_medic
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
	additional_module = /obj/item/mod/module/dispenser/hypospray

/obj/item/mod/module/dispenser/incendiary
	name = "MOD incendiary grenade dispenser module"
	desc = "This module can create activated incendiary grenades at the user's liking."
	dispense_type = /obj/item/grenade/chem_grenade/incendiary

/obj/item/mod/module/dispenser/barrinade/on_use()
	. = ..()
	if(!.)
		return
	var/obj/item/grenade/chem_grenade/incendiary/grenade = .
	grenade.arm_grenade(mod.wearer)

/obj/item/mod/module/dispenser/landmine
	name = "MOD landmine dispenser module"
	desc = "This module can create deactivated landmines at the user's liking."
	cooldown_time = 10 SECONDS
	dispense_type = /obj/item/minespawner/ancient_milsim

/obj/item/mod/module/dispenser/hypospray
	name = "MOD custom hypospray dispenser module"
	desc = "This module can create a single empty combat hypospray and additional cartridges at the user's liking."
	cooldown_time = 5 SECONDS
	dispense_type = /obj/item/hypospray/mkii/deluxe/cmo/combat
	var/first_use = TRUE

/obj/item/mod/module/dispenser/hypospray/on_use()
	. = ..()
	if(first_use)
		first_use = FALSE
		cooldown_time = 15 SECONDS
		dispense_type = /obj/item/reagent_containers/cup/vial/large/advomni
