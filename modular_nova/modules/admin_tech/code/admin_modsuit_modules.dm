//! MODsuit modules made for use with modsuits from [admin_modsuits.dm]

// Unique Subspace Modules
// Unfilled basic admin module
// todo: fill this path
/obj/item/mod/module/admin
	allow_flags = MODULE_ALLOW_INACTIVE
	complexity = 0
	active_power_cost = 0
	incompatible_modules = null

/obj/item/mod/module/admin/carbine
	name = "MOD linked subspace carbine module"
	desc = "Provides technicians with a weapon they cannot be separated from."
	icon_state = "holster"
	icon = 'modular_nova/modules/marines/icons/items/module.dmi'
	overlay_icon_file = 'modular_nova/modules/marines/icons/mobs/mod_modules.dmi'
	module_type = MODULE_ACTIVE
	device = /obj/item/gun/energy/modular_laser_rifle/carbine/admin
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	/// Power consumed per bullet fired
	var/power_per_bullet = 0

/obj/item/mod/module/admin/carbine/on_activation()
	. = ..()
	RegisterSignal(device, COMSIG_GUN_FIRED, PROC_REF(consume_energy))

/obj/item/mod/module/subspace/carbine/proc/consume_energy(mob/user, atom/target, params, zone_override)
	SIGNAL_HANDLER

	drain_power(power_per_bullet)

// TODO: Should probably be removed, and we should use the new personal energy dune shields instead
/obj/item/mod/module/energy_shield/admin
	shield_icon = "none"
	max_charges = 10
	recharge_start_delay = 5
	charge_increment_delay = 0.5 SECONDS
	charge_recovery = 10
	block_overwhelming_attacks = TRUE

// Users of this module cannot be inspected, also acts as a weldshield
// TODO: see readme.md for advanced idea of this module
/obj/item/mod/module/infiltrator/admin
	incompatible_modules = null

// Modsuit storage modules create their own storage datums, and dont reference a storage datum type
// TODO: Investigate the runtime this seems to create
/obj/item/mod/module/storage/admin
	name = "MOD subspace storage module"
	desc = "A storage system developed by CentCom, these compartments employ \
		miniaturized bluespace pockets for the ultimate in storage technology; regardless of the weight of objects put inside."
	icon_state = "storage_large"
	storage_type = /datum/storage/admin
