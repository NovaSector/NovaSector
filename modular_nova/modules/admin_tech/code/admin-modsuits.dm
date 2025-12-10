// Nova Bluespace Tech Modsuits //
// Debug Modules
/obj/item/mod/module/energy_shield/debug
	shield_icon = "love_hearts"//We can remove this later but for now it makes me happy

/obj/item/mod/module/infiltrator/debug//Users of this module cannot be inspected, also acts as a weldshield
	incompatible_modules = null

//Modsuit storage modules create their own storage datums, and dont reference a storage datum type
/obj/item/mod/module/storage/debug
	name = "MOD subspace storage module"
	desc = "A storage system developed by CentCom, these compartments employ \
		miniaturized bluespace pockets for the ultimate in storage technology; regardless of the weight of objects put inside."
	icon_state = "storage_large"
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = WEIGHT_CLASS_GIGANTIC * 28
	max_items = 28
	big_nesting = TRUE

//The Subspace Technician's Modsuit. Lots of frills.
/obj/item/mod/control/pre_equipped/subspace
	theme = /datum/mod_theme/administrative
	starting_frequency = MODLINK_FREQ_CENTCOM
	applied_core = /obj/item/mod/core/infinite
	applied_modules = list(
		/obj/item/mod/module/hearing_protection,
		/obj/item/mod/module/storage/debug,
		/obj/item/mod/module/infiltrator/debug,
		/obj/item/mod/module/emp_shield/advanced,
		/obj/item/mod/module/energy_shield/debug,
		/obj/item/mod/module/plasma_stabilizer,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/mouthhole,
		/obj/item/mod/module/quick_carry/advanced,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/stealth/ninja,
		/obj/item/mod/module/anomaly_locked/kinesis/admin,
		/obj/item/mod/module/dispenser,
		/obj/item/mod/module/shove_blocker,
		/obj/item/mod/module/quick_cuff,
		/obj/item/mod/module/anti_magic,
		/obj/item/mod/module/noslip,
		/obj/item/mod/module/longfall,
		/obj/item/mod/module/shock_absorber,
		/obj/item/mod/module/hacker,
		/obj/item/mod/module/visor/diaghud,
		/obj/item/mod/module/mister/atmos,
		/obj/item/mod/module/defibrillator/combat,
		/obj/item/mod/module/medbeam,
		/obj/item/mod/module/surgical_processor/preloaded,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/baton_holster/preloaded,
		/obj/item/mod/module/flamethrower,
		/obj/item/mod/module/adrenaline_boost,
		/obj/item/mod/module/jaeger_sprint,
		/obj/item/mod/module/jump_jet,
		/obj/item/mod/module/reagent_scanner/advanced,
		/obj/item/mod/module/selfcleaner,
		/obj/item/mod/module/anomaly_locked/antigrav/prebuilt,
		/obj/item/mod/module/anomaly_locked/teleporter/prebuilt,
		/obj/item/mod/module/sphere_transform,
		/obj/item/mod/module/rewinder,
		/obj/item/mod/module/timestopper,
		/obj/item/mod/module/timeline_jumper,
		/obj/item/mod/module/tem,
		/obj/item/mod/module/megaphone,
		/obj/item/mod/module/flashlight/darkness,
		/obj/item/mod/module/balloon/advanced,
		/obj/item/mod/module/paper_dispenser,
	)
	default_pins = list(
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/anomaly_locked/kinesis/admin,
		/obj/item/mod/module/timeline_jumper,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/mister/atmos,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/dispenser,
		/obj/item/mod/module/balloon/advanced,
	)

// Extremely cursed modsuit that will self install any modsuit module in existence
// Do NOT spawn this on a live server. The lag from this being created is impressive.
/obj/item/mod/control/pre_equipped/administrative/module_debug
    default_pins = list()
    applied_modules = list()

/obj/item/mod/control/pre_equipped/administrative/debug/Initialize(mapload, new_theme, new_skin, new_core)
    . = ..()
    for(var/path in subtypesof(/obj/item/mod/module))
        var/obj/item/mod/module/module = new path(src)
        module.mod = src
        modules += module
        module.on_install()
        module.forceMove(src)
