//! MODsuit modules made for use with modsuits from [admin_modsuits.dm]

// Unique Subspace Modules
// Unfilled basic admin module
// todo: fill this path
/obj/item/mod/module/admin
	allow_flags = MODULE_ALLOW_INACTIVE
	complexity = 0
	active_power_cost = 0
	incompatible_modules = null

/obj/item/mod/module/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

///Creates new subspace boxes.
/obj/item/mod/module/dispenser/subspacebox
	name = "MOD subspace box dispenser module"
	desc = "The pipeline of creation."
	icon_state = "dispenser"
	complexity = 0
	idle_power_cost = 0
	active_power_cost = 0
	use_energy_cost = 0
	incompatible_modules = list()
	cooldown_time = 2 SECONDS
	required_slots = list()
	dispense_type = /obj/item/storage/box/debug

/obj/item/mod/module/dispenser/subspacebox/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

/obj/item/mod/module/admin/carbine
	name = "MOD linked subspace carbine module"
	desc = "Provides technicians with a weapon they cannot be separated from."
	icon_state = "holster"
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	overlay_icon_file = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	module_type = MODULE_ACTIVE
	device = /obj/item/gun/energy/modular_laser_rifle/carbine/admin
	cooldown_time = 0.5 SECONDS
	required_slots = list()
	/// Power consumed per bullet fired

/obj/item/mod/module/admin/carbine/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// TODO: Should probably be removed, and we should use the new personal energy dune shields instead
/obj/item/mod/module/energy_shield/admin
	shield_icon = "none"
	max_charges = 10
	recharge_start_delay = 5
	charge_increment_delay = 0.5 SECONDS
	charge_recovery = 10
	block_overwhelming_attacks = TRUE

/obj/item/mod/module/energy_shield/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Users of this module cannot be inspected, also acts as a weldshield
// TODO: see readme.md for advanced idea of this module
/obj/item/mod/module/infiltrator/admin
	name = "technician's visual cloak"
	removable = FALSE
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0
	incompatible_modules = null
	required_slots = null
	/// List of traits added when the suit is activated
	traits_to_add = list(TRAIT_SILENT_FOOTSTEPS, TRAIT_ADMIN_STEALTH, TRAIT_UNKNOWN_VOICE, TRAIT_HEAD_INJURY_BLOCKED)

/obj/item/mod/module/infiltrator/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)

// Modsuit storage modules create their own storage datums, and dont reference a storage datum type
/obj/item/mod/module/storage/admin
	name = "MOD subspace storage module"
	desc = "A storage system developed by CentCom, these compartments employ \
		miniaturized bluespace pockets for the ultimate in storage technology; regardless of the weight of objects put inside."
	icon_state = "storage_large"
	storage_type = /datum/storage/admin

/obj/item/mod/module/storage/admin/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ADMIN)
