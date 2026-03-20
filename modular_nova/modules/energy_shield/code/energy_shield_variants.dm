/// Mass-produced consumer-grade shield. Weak but legal and widely available.
/obj/item/clothing/accessory/energy_shield/civilian
	name = "personal energy barrier"
	desc = "A consumer-grade personal shield. Popular with merchants and travellers in dangerous frontier sectors."
	max_shield_health = 50
	recharge_delay = 10 SECONDS
	recharge_rate = 5
	shield_color = "#88ccff"

/// NT-issue tactical shield. Hardened circuitry allows integration with standard body armor up to class II.
/obj/item/clothing/accessory/energy_shield/military
	name = "NT tactical shield projector"
	desc = "A military-spec energy shield designed for Nanotrasen security forces. Hardened circuitry allows integration with standard-issue body armor."
	max_shield_health = 100
	recharge_delay = 8 SECONDS
	recharge_rate = 8
	shield_color = "#4488ff"
	max_armor_class = 20

/// High-performance Syndicate shield. No armor restriction and partial EMP resistance.
/obj/item/clothing/accessory/energy_shield/syndicate
	name = "Gorlex energy shield"
	desc = "A high-performance personal shield of Syndicate manufacture. Overclocked power cells and military-grade shielding emitters make it superior to anything on the legal market."
	max_shield_health = 125
	recharge_delay = 6 SECONDS
	recharge_rate = 10
	shield_color = "#ff2244"
	emp_retention = 0.5

/// Syndicate shields bypass all armor restrictions.
/obj/item/clothing/accessory/energy_shield/syndicate/wearer_has_heavy_armor()
	return FALSE

/// Syndicate shield tuned for projectile interception only. Transparent to melee.
/obj/item/clothing/accessory/energy_shield/syndicate/phasic
	name = "Gorlex phasic deflector"
	desc = "A Syndicate shield tuned exclusively for high-velocity projectile interception. Its phase-shifted barrier is completely transparent to melee attacks."
	max_shield_health = 150
	shield_color = "#cc44ff"

/// Phasic shields only absorb damage from projectiles — melee passes through entirely.
/obj/item/clothing/accessory/energy_shield/syndicate/phasic/on_damage_modifiers(mob/living/carbon/source, list/damage_mods, damage, damagetype, def_zone, sharpness, attack_direction, attacking_item)
	if(!isprojectile(attacking_item))
		return
	return ..()

// -- SYNDICATE BULWARK VARIANT --

/// Massive Syndicate shield that slows the wearer while active.
/obj/item/clothing/accessory/energy_shield/syndicate/bulwark
	name = "Gorlex bulwark generator"
	desc = "A heavy-duty Syndicate shield generator that projects an immensely powerful barrier at the cost of mobility. Graviton field emitters interfere with normal locomotion while the shield is active."
	max_shield_health = 200
	recharge_delay = 8 SECONDS
	recharge_rate = 8
	shield_color = "#ff6644"

/obj/item/clothing/accessory/energy_shield/syndicate/bulwark/equipped(mob/living/user, slot)
	. = ..()
	if(shield_active)
		wearer?.add_movespeed_modifier(/datum/movespeed_modifier/energy_shield_bulwark)

/obj/item/clothing/accessory/energy_shield/syndicate/bulwark/dropped(mob/living/user)
	user.remove_movespeed_modifier(/datum/movespeed_modifier/energy_shield_bulwark)
	return ..()

/obj/item/clothing/accessory/energy_shield/syndicate/bulwark/shield_collapse()
	wearer?.remove_movespeed_modifier(/datum/movespeed_modifier/energy_shield_bulwark)
	return ..()

/obj/item/clothing/accessory/energy_shield/syndicate/bulwark/process(seconds_per_tick)
	var/was_active = shield_active
	. = ..()
	if(shield_active && !was_active)
		wearer?.add_movespeed_modifier(/datum/movespeed_modifier/energy_shield_bulwark)
	else if(!shield_active && was_active)
		wearer?.remove_movespeed_modifier(/datum/movespeed_modifier/energy_shield_bulwark)

/// Movement speed penalty while the bulwark shield is active.
/datum/movespeed_modifier/energy_shield_bulwark
	multiplicative_slowdown = 0.35
