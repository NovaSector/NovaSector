/obj/item/mod/module/hydraulic/on_part_activation()
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_TRASHMAN, MOD_TRAIT)

/obj/item/mod/module/hydraulic/on_part_deactivation(deleting = FALSE)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_TRASHMAN, MOD_TRAIT)

/obj/item/mod/module/ash_accretion
	incompatible_modules = list(/obj/item/mod/module/ash_accretion, /obj/item/mod/module/armor_booster)
	/// Is this ash accretion module providing its perks? Separate from active, because I don't know how it would interact with everything else as it's a passive module.
	var/protection_enabled = FALSE

/datum/armor/mod_ash_accretion
	melee = 4.5
	bullet = 1
	laser = 2
	energy = 2
	bomb = 4

/obj/item/mod/module/ash_accretion/on_install()
	. = ..()
	speed_added = mod.slowdown_deployed // so when you hit full ash accretion, slowdown cancels out
	RegisterSignal(mod, COMSIG_SPEED_POTION_APPLIED, PROC_REF(update_added_speed))

/obj/item/mod/module/ash_accretion/on_part_activation()
	. = ..()
	protection_enabled = TRUE
	RegisterSignals(mod, list(COMSIG_MOD_DEPLOYED, COMSIG_MOD_RETRACTED), PROC_REF(on_mod_toggle))

/obj/item/mod/module/ash_accretion/on_part_deactivation(deleting)
	. = ..()
	protection_enabled = FALSE
	UnregisterSignal(mod, list(COMSIG_MOD_DEPLOYED, COMSIG_MOD_RETRACTED))

/// Updates the ash accretion module's `speed_added`, so it entirely cancels out the suit's slowdown at full accretion. Not meant to be called for the external variant!
/obj/item/mod/module/ash_accretion/proc/update_added_speed()
	SIGNAL_HANDLER
	speed_added = mod.slowdown_deployed // no, you don't get to have a free speedup, actually

/// Checks if the suit's current state is valid for buff-granting purposes. Should only be called when the MOD is deployed or retracted.
/obj/item/mod/module/ash_accretion/proc/on_mod_toggle()
	var/fully_deployed = TRUE
	for(var/obj/item/part as anything in mod.get_parts())
		if(part.loc == mod)
			fully_deployed = FALSE
			break

	if(fully_deployed && mod.active)
		// suit is on and fully deployed, give them their proofing
		mod.wearer.add_traits(list(TRAIT_ASHSTORM_IMMUNE, TRAIT_SNOWSTORM_IMMUNE), MOD_TRAIT)
		RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
		balloon_alert(mod.wearer, "ash accretion enabled")
		protection_enabled = TRUE
		return

	// if their suit is not fully deployed, take their proofing away
	if(!protection_enabled)
		return // unless it was already gone

	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)
	mod.wearer.remove_traits(list(TRAIT_ASHSTORM_IMMUNE, TRAIT_SNOWSTORM_IMMUNE), MOD_TRAIT)
	balloon_alert(mod.wearer, "ash accretion disabled!")
	protection_enabled = FALSE
	if(!traveled_tiles)
		return

	var/datum/armor/to_remove = get_armor_by_type(armor_mod)
	for(var/obj/item/part as anything in mod.get_parts(all = TRUE))
		part.set_armor(part.get_armor().subtract_other_armor(to_remove.generate_new_with_multipliers(list(ARMOR_ALL = traveled_tiles))))

	if(traveled_tiles == max_traveled_tiles)
		mod.slowdown += speed_added
		mod.wearer.update_equipment_speed_mods()

	traveled_tiles = 0

/obj/item/mod/module/clamp
	required_slots = list(ITEM_SLOT_GLOVES, ITEM_SLOT_BACK|ITEM_SLOT_BELT)

/obj/item/mod/module/clamp/loader
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)

/obj/item/mod/module/hydraulic
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)

/obj/item/mod/module/magnet
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)

