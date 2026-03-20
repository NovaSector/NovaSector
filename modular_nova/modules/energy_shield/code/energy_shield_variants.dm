/// Mass-produced consumer-grade shield by Bolt Fabrications. Weak but legal and widely available.
/obj/item/clothing/accessory/energy_shield/civilian
	name = "\improper Bolt SafeGuard personal energy barrier"
	desc = "A mass-produced personal energy barrier manufactured by Bolt Fabrications under their SafeGuard consumer protection line. \
		Marketed towards frontier merchants, long-haul freight crews, and civilian colonists operating beyond reliable law enforcement coverage. \
		While its modest output won't stop military ordnance, it has saved enough lives to become standard kit in most frontier outfitters."
	max_shield_health = 50
	recharge_delay = 10 SECONDS
	recharge_rate = 5
	shield_color = "#88ccff"

/obj/item/clothing/accessory/energy_shield/civilian/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BOLT)

/// NT-issue tactical shield. Hardened circuitry allows integration with standard body armor up to class II.
/obj/item/clothing/accessory/energy_shield/military
	name = "NT tactical shield projector"
	desc = "A military-spec energy shield designed for Nanotrasen security forces. Hardened circuitry allows integration with standard-issue clothing except hardened body armour."
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
	max_armor_class = 100

/// Syndicate shield tuned for projectile interception only. Transparent to melee.
/obj/item/clothing/accessory/energy_shield/syndicate/phasic
	name = "Gorlex phasic deflector"
	desc = "A Syndicate shield tuned exclusively for high-velocity projectile interception. Its phase-shifted barrier is completely transparent to melee attacks."
	max_shield_health = 150
	shield_color = "#cc44ff"
	blocks_melee = FALSE

/// Massive Syndicate shield that slows the wearer while active.
/obj/item/clothing/accessory/energy_shield/syndicate/bulwark
	name = "Gorlex bulwark generator"
	desc = "A heavy-duty Syndicate shield generator that projects an immensely powerful barrier at the cost of mobility. Graviton field emitters interfere with normal locomotion while the shield is active."
	max_shield_health = 200
	recharge_delay = 8 SECONDS
	recharge_rate = 8
	persistent_visuals = TRUE
	shield_color = "#ff6644"

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
