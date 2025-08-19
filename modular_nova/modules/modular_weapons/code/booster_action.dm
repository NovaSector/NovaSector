/// Component that handles barrel-charger-esque effects, typically increasing damage/projectile speed but reducing firerate
/// Examples: the Laevateinn revolver, the Kolben shotgun
/datum/component/gun_booster
	/// Is our currently attached gun amped?
	var/amped = FALSE
	/// Base damage multiplier of the gun.
	var/base_damage_mult = 1
	/// Base projectile speed multiplier of the gun.
	var/base_speed_mult = 1
	/// Base fire delay of the gun.
	var/base_fire_delay = NONE

	/// Amped damage multiplier of the gun.
	var/amped_damage_mult = 1.2
	/// Amped projectile speed multiplier of the gun.
	var/amped_speed_mult = 1.5
	/// Amped fire delay of the gun.
	var/amped_fire_delay = CLICK_CD_RANGE * 2 // this actually becomes CLICK_CD_MELEE.
