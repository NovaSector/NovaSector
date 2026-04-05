
/obj/item/mod/module/storage/bluespace/nerfed
	icon_state = "storage_bluespace"
	storage_type = /datum/storage/mod_storage/bs_nerfed


/datum/storage/mod_storage/bs_nerfed
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = 30
	max_slots = 25
	allow_big_nesting = TRUE

// Same as the Syndie version, but with has higher power drain, complexity and takes longer to charge. Also can't be used with armor modules.
/obj/item/mod/module/energy_shield/nanotrasen
	desc = "A prototype, previously classified by Nanotrasen's R&D, made to mimic the Syndicate's own Energy Shield Module. \
		It is capable of blocking nearly any incoming attack, but only once every few seconds. \
		Due to it's weird design, it can not be used alongside any retractable armor plates."
	/// 2 more complexity.
	complexity = 5
	/// Double the power usage.
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 4
	incompatible_modules = list(/obj/item/mod/module/energy_shield)
	/// 5 seconds longer delay.
	recharge_start_delay = 15 SECONDS
	/// Double the delay.
	charge_increment_delay = 2 SECONDS
	shield_icon = "shield-old"

// Same as nukie version but has double the complexity and triple the power cost.
/obj/item/mod/module/medbeam/nanotrasen
	desc = "A compact, integrated version of the Automated First Aid Device, \
		a revolutionary device meant for fixing scrapes and bruises, and totally not a knockoff of the legendary medibeam. \
		Due to it's compact design, it has a shorter range."
	complexity = 2
	active_power_cost = DEFAULT_CHARGE_DRAIN * 3
	device = /obj/item/gun/medbeam/afad/mod
	cooldown_time = 1

// Automated First Aid Device version with half the range.
/obj/item/gun/medbeam/afad/mod
	max_range = 4
