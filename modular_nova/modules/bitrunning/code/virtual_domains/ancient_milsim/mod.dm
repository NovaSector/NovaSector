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
		/obj/item/mod/module/visor/meson,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/meson,
	)
	insignia_type = /obj/item/mod/module/insignia/engineer
	additional_module = /obj/item/mod/module/dispenser/emp

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
	additional_module = /obj/item/mod/module/dispenser/landmine

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
		/obj/item/mod/module/visor/night,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/visor/night,
	)
	insignia_type = /obj/item/mod/module/insignia/security
	additional_module = /obj/item/mod/module/stealth/ancient_milsim

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
	additional_module = /obj/item/mod/module/dispenser/hypospray

/obj/item/mod/module/stealth/ancient_milsim
	removable = FALSE

/obj/item/mod/module/dispenser/emp
	name = "MOD EMP grenade dispenser module"
	desc = "This module can create activated EMP grenades at the user's liking."
	removable = FALSE
	dispense_type = /obj/item/grenade/empgrenade

/obj/item/mod/module/dispenser/emp/on_use()
	. = ..()
	if(!.)
		return
	var/obj/item/grenade/empgrenade/grenade = .
	grenade.arm_grenade(mod.wearer)

/obj/item/mod/module/dispenser/landmine
	name = "MOD landmine dispenser module"
	desc = "This module can create deactivated landmines at the user's liking."
	removable = FALSE
	cooldown_time = 10 SECONDS
	dispense_type = /obj/item/minespawner/ancient_milsim

/obj/item/mod/module/dispenser/hypospray
	name = "MOD custom hypospray dispenser module"
	desc = "This module can create a single combat hypospray and additional cartridges at the user's liking."
	removable = FALSE
	cooldown_time = 5 SECONDS
	dispense_type = /obj/item/hypospray/mkii/deluxe/cmo/combat
	var/first_use = TRUE

/obj/item/mod/module/dispenser/hypospray/on_use()
	. = ..()
	if(first_use)
		first_use = FALSE
		cooldown_time = 15 SECONDS
		dispense_type = /obj/item/reagent_containers/cup/vial/large/ancient_milsim

/obj/item/hypospray/mkii/deluxe/cmo/combat
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
