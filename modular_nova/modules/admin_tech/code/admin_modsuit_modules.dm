// Nova Bluespace Tech Modsuits //
// Subspace Modules
/obj/item/mod/module/energy_shield/debug
	shield_icon = "none"
	max_charges = 10
	recharge_start_delay = 5
	charge_increment_delay = 0.5 SECONDS
	charge_recovery = 10
	block_overwhelming_attacks = TRUE

/obj/item/mod/module/infiltrator/debug//Users of this module cannot be inspected, also acts as a weldshield
	incompatible_modules = null

//Modsuit storage modules create their own storage datums, and dont reference a storage datum type
/obj/item/mod/module/storage/admin
	name = "MOD subspace storage module"
	desc = "A storage system developed by CentCom, these compartments employ \
		miniaturized bluespace pockets for the ultimate in storage technology; regardless of the weight of objects put inside."
	icon_state = "storage_large"
	storage_type = /datum/storage/admin

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
