// Yeah I'm using datums for this, because the code on a regular gun would suck huge
// Holds a lot of information that will be applied ot the gun, as well as info that the gun will read later
// This basetype is applies to the base 2 burst laser kill mode for the large laser gun
/datum/laser_weapon_mode
	/// What name does this weapon mode have? Will appear in the weapon's radial menu
	var/name = "Kill"
	/// What casing does this variant of weapon use?
	var/obj/item/ammo_casing/casing = /obj/item/ammo_casing/energy/cybersun_big_kill
	/// What icon_state does this weapon mode use?
	var/weapon_icon_state = "kill"
	/// How many charge sections does this variant of weapon have?
	var/charge_sections = 5
	/// What is the shot cooldown this variant applies to the weapon?
	var/shot_delay = 1 SECONDS

/// Applies some of the universal stats from the variables above
/datum/laser_weapon_mode/proc/apply_stats(obj/item/gun/energy/applied_gun)
	if(!length(applied_gun.ammo_type))
		applied_gun.ammo_type += casing
	else
		applied_gun.ammo_type[1] = casing
	applied_gun.charge_sections = charge_sections
	applied_gun.fire_delay = shot_delay
	applied_gun.icon_state = "[applied_gun.base_icon_state]_[weapon_icon_state]"
	applied_gun.update_appearance()

/// Stuff applied to the passed gun when the weapon mode is given to the gun
/datum/laser_weapon_mode/proc/apply_to_weapon(obj/item/gun/energy/applied_gun)
	applied_gun.burst_size = 2

/// Stuff applied to the passed gun when the weapon mode is removed from the gun
/datum/laser_weapon_mode/proc/remove_from_weapon(obj/item/gun/energy/applied_gun)
	applied_gun.burst_size = 1

// Marksman mode for the large laser, adds a scope, slower firing rate, and really quick projectiles
/datum/laser_weapon_mode/marksman
	name = "Marksman"
	casing = /obj/item/ammo_casing/energy/cybersun_big_sniper
	weapon_icon_state = "sniper"
	shot_delay = 2 SECONDS

/datum/laser_weapon_mode/marksman/apply_to_weapon(obj/item/gun/energy/applied_gun)
	applied_gun.AddComponentFrom(REF(src), /datum/component/scope, 3)

/datum/laser_weapon_mode/marksman/remove_from_weapon(obj/item/gun/energy/applied_gun)
	applied_gun.RemoveComponentSource(REF(src), /datum/component/scope)

// Windup autofire disabler mode for the large laser
/datum/laser_weapon_mode/disabler_machinegun
	name = "Disable"
	casing = /obj/item/ammo_casing/energy/cybersun_big_disabler
	weapon_icon_state = "disabler"
	charge_sections = 2

/datum/laser_weapon_mode/disabler_machinegun/apply_to_weapon(obj/item/gun/energy/applied_gun)
	applied_gun.AddComponentFrom(REF(src), /datum/component/automatic_fire, shot_delay, TRUE, 0.1, 0.6)

/datum/laser_weapon_mode/disabler_machinegun/remove_from_weapon(obj/item/gun/energy/applied_gun)
	applied_gun.RemoveComponentSource(REF(src), /datum/component/automatic_fire)

// Grenade launching mode for the large laser
/datum/laser_weapon_mode/launcher
	name = "Launcher"
	casing = /obj/item/ammo_casing/energy/cybersun_big_launcher
	weapon_icon_state = "launcher"
	charge_sections = 3
	shot_delay = 2 SECONDS

/datum/laser_weapon_mode/launcher/apply_to_weapon(obj/item/gun/energy/applied_gun)
	return

/datum/laser_weapon_mode/launcher/remove_from_weapon(obj/item/gun/energy/applied_gun)
	return

// Shotgun mode for the large laser
/datum/laser_weapon_mode/shotgun
	name = "Shotgun"
	casing = /obj/item/ammo_casing/energy/cybersun_big_shotgun
	weapon_icon_state = "shot"
	charge_sections = 3
	shot_delay = 0.75 SECONDS

/datum/laser_weapon_mode/shotgun/apply_to_weapon(obj/item/gun/energy/applied_gun)
	return

/datum/laser_weapon_mode/shotgun/remove_from_weapon(obj/item/gun/energy/applied_gun)
	return
