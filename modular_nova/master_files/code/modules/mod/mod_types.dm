/obj/item/mod
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/modsuit/mod_clothing.dmi'

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
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/chameleon,
	)
	default_pins = list(
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/jump_jet,
	)
	theme = /datum/mod_theme/deepspace

/obj/item/mod/control/pre_equipped/deepspace_admiral
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
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/jump_jet,
	)
	theme = /datum/mod_theme/deepspace_admiral

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
