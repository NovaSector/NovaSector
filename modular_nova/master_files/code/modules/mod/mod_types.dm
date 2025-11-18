/obj/item/mod/control/pre_equipped/nuclear/chameleon
	req_access = null
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/chameleon,
	)

/obj/item/mod/control/pre_equipped/civilian
	applied_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/flashlight,
	)

/obj/item/mod/control/pre_equipped/loader
	applied_modules = list(
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/stamp,
	)

/obj/item/mod/control/pre_equipped/deepspace
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/chameleon,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/jump_jet,
	)
	theme = /datum/mod_theme/syndicate/deepspace

/obj/item/mod/control/pre_equipped/deepspace_admiral
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/jump_jet,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/hat_stabilizer/syndicate,
		/obj/item/mod/module/quick_cuff,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/jump_jet,
	)
	theme = /datum/mod_theme/elite/admiral

/obj/item/mod/control/pre_equipped/frontier_colonist
	theme = /datum/mod_theme/frontier_colonist
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/welding,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/status_readout,
		/obj/item/mod/module/thermal_regulator,
	)
	default_pins = list(
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/thermal_regulator,
	)

/obj/item/mod/control/pre_equipped/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Joint torsion module that can't be removed and has no complexity

/obj/item/mod/module/joint_torsion/permanent
	removable = FALSE
	complexity = 0
	incompatible_modules = list(/obj/item/mod/module/holster)

/obj/item/mod/control/pre_equipped/voskhod
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	theme = /datum/mod_theme/voskhod
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
	)
	default_pins = list(
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/auto_doc,
	)

/obj/item/mod/control/pre_equipped/voskhod/ancient_milsim
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/mouthhole,
	)
	default_pins = list(
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/thermal_regulator,
	)

/obj/item/mod/control/pre_equipped/tarkon
	theme = /datum/mod_theme/tarkon
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/tether,
	)
	default_pins = list(
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/tether,
	)

/////////// Prototype Hauler Suit

/obj/item/mod/control/pre_equipped/prototype/hauler
	theme = /datum/mod_theme/prototype/hauler
	req_access = list(ACCESS_TARKON)
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/tether,
	)

/obj/item/mod/control/pre_equipped/marine
	theme = /datum/mod_theme/marines
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/power_kick,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/dna_lock, //in lieu of req_access
		/obj/item/mod/module/visor/sechud, //for identifying teammates also in suits
	)
	default_pins = list(
		/obj/item/mod/module/holster,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/power_kick,
	)

/obj/item/mod/control/pre_equipped/marine/engineer //smartgunner version of modsuit, with less versatile modules but the ALMIGHTY SMARTGUN
	theme = /datum/mod_theme/marines
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/visor/sechud,
		/obj/item/mod/module/smartgun/marines,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/smartgun/marines,
	)

/obj/item/mod/control/pre_equipped/marine/damaged //'worn down' version, with less armor and no ERT/antag modules
	theme = /datum/mod_theme/marines/damaged
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	//removed modules: noslip, powerkick, megaphone
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/dna_lock, //in lieu of req_access
		/obj/item/mod/module/visor/sechud, //for identifying teammates also in suits
	)
	default_pins = list(
		/obj/item/mod/module/holster,
		/obj/item/mod/module/jetpack,
	)

/obj/item/mod/control/pre_equipped/blueshield
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi'
	icon = 'modular_nova/master_files/icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "praetorian-control"
	theme = /datum/mod_theme/blueshield
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/projectile_dampener,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/holster,
	)

/obj/item/mod/control/pre_equipped/interdyne/nerfed
	theme = /datum/mod_theme/interdyne
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_cell = /obj/item/stock_parts/power_store/cell/super
	applied_modules = list(
		/obj/item/mod/module/defibrillator,
		/obj/item/mod/module/injector,
		/obj/item/mod/module/surgical_processor/preloaded,
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/thread_ripper,
	)

/obj/item/mod/control/pre_equipped/marine
	theme = /datum/mod_theme/marines
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/power_kick,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/dna_lock, //in lieu of req_access
		/obj/item/mod/module/visor/sechud, //for identifying teammates also in suits
	)
	default_pins = list(
		/obj/item/mod/module/holster,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/power_kick,
	)

/obj/item/mod/control/pre_equipped/marine/engineer //smartgunner version of modsuit, with less versatile modules but the ALMIGHTY SMARTGUN
	theme = /datum/mod_theme/marines
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/visor/sechud,
		/obj/item/mod/module/smartgun/marines,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/smartgun/marines,
	)

/obj/item/mod/control/pre_equipped/marine/damaged //'worn down' version, with less armor and no ERT/antag modules
	theme = /datum/mod_theme/marines/damaged
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	//removed modules: noslip, powerkick, megaphone
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/dna_lock, //in lieu of req_access
		/obj/item/mod/module/visor/sechud, //for identifying teammates also in suits
	)
	default_pins = list(
		/obj/item/mod/module/holster,
		/obj/item/mod/module/jetpack,
	)
