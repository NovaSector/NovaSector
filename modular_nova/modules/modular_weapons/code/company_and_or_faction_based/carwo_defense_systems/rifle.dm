// Base Sol rifle

/obj/item/gun/ballistic/automatic/sol_rifle
	name = "\improper MMR-2543E"
	desc = "A heavy assault rifle chambered in .40Sol, with a comically fast fire-rate for weapons of it's class."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	icon_state = "infanterie"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "infanterie"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "infanterie"

	SET_BASE_PIXEL(-8, 0)

	special_mags = TRUE

	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK

	accepted_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle
	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle/standard

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/rifle_heavy.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_rifle.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 2
	suppressor_y_offset = 1

	burst_size = 1
	fire_delay = 0.30 SECONDS
	actions_types = list()

	spread = 2
	projectile_wound_bonus = 10
	projectile_damage_multiplier = 0.75

/obj/item/gun/ballistic/automatic/sol_rifle/Initialize(mapload)
	. = ..()

	give_autofire()

/// Separate proc for handling auto fire just because one of these subtypes isn't otomatica
/obj/item/gun/ballistic/automatic/sol_rifle/proc/give_autofire()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/sol_rifle/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/sol_rifle/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/sol_rifle/examine_more(mob/user)
	. = ..()

	. += "The MMR-2543 is the current standard service rifle for all branches of the Sol Federation Armed Forces. \
		The MMR-2543 was initially created for use by the Sagittarian Triumvirate’s military, \
		with its adoption by SolFed coming a few years later. Thanks to both the prestige the weapon gained from being adopted \
		by two of the most prominent military forces in SolFed, \
		and its modular design making it easily adapted to different requirements, it is currently the most widely adopted rifle in SolFed with a wide range of different users. \
		This variant is the Espatier model and is the standard weapon for SolFed’s Espatier Corps. It features a slim and compact design optimized for the close-range engagements \
		Espatiers typically find themselves in, while still retaining effectiveness at long range. A computerized sight allows for quick and easy adjustment for engagements at different ranges, \
		and in a wide range of environments, while a swappable internal heatsink protects the weapon from overheating whilst firing in a vacuum."

	return .

/obj/item/gun/ballistic/automatic/sol_rifle/no_mag
	spawnwithmagazine = FALSE

// Sol marksman rifle

/obj/item/gun/ballistic/automatic/sol_rifle/marksman
	name = "\improper MMR-2543I"
	desc = "A heavy marksman rifle commonly seen in the hands of SolFed military types. Accepts any standard SolFed rifle magazine."

	icon_state = "elite"
	worn_icon_state = "elite"
	inhand_icon_state = "elite"

	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle

	fire_delay = 0.4 SECONDS
	
	suppressor_x_offset = 1
	suppressor_y_offset = 1

	burst_size = 3
	spread = 5.5
	projectile_damage_multiplier = 1
	projectile_wound_bonus = 3

/obj/item/gun/ballistic/automatic/sol_rifle/marksman/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/automatic/sol_rifle/marksman/give_autofire()
	return

/obj/item/gun/ballistic/automatic/sol_rifle/marksman/examine_more(mob/user)
	. = ..()

	. = "The MMR-2543 is the current standard service rifle for all branches of the Sol Federation Armed Forces. \
		The MMR-2543 was initially created for use by the Sagittarian Triumvirate’s military, \
		with its adoption by SolFed coming a few years later. Thanks to both the prestige the weapon gained from \
		being adopted by two of the most prominent military forces in SolFed, and its modular \
		design making it easily adapted to different requirements, it is currently the most widely adopted rifle \
		in SolFed with a wide range of different users. This variant is the Infantry model and is the primary rifle \
		for both the SolFed Hydro Corps and Atmospheric Corps. It features excellent accuracy and durability, \
		a specialized two shot burst designed to fire off two rounds before recoil can impact the shooter, \
		and a more moderate rate of automatic fire to help preserve ammunition during long engagements."

	return .

/obj/item/gun/ballistic/automatic/sol_rifle/marksman/no_mag
	spawnwithmagazine = FALSE

// Machinegun based on the base Sol rifle

/obj/item/gun/ballistic/automatic/sol_rifle/machinegun
	name = "\improper Qarad Light Machinegun"
	desc = "A hefty machinegun commonly seen in the hands of SolFed military types. Accepts any standard SolFed rifle magazine."

	icon_state = "qarad"
	worn_icon_state = "qarad"
	inhand_icon_state = "outomaties"

	bolt_type = BOLT_TYPE_OPEN

	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle

	fire_delay = 0.1 SECONDS

	recoil = 1
	spread = 12.5
	projectile_wound_bonus = -20

/obj/item/gun/ballistic/automatic/sol_rifle/machinegun/examine_more(mob/user)
	. = ..()

	. += "The 'Qarad' variant of the rifle, what you are looking at now, \
		is a modification to turn the weapon into a passable, if sub-optimal \
		light machinegun. To support the machinegun role, the internals were \
		converted to make the gun into an open bolt, faster firing machine. These \
		additions, combined with a battle rifle not meant to be used fully auto \
		much to begin with, made for a relatively unwieldy weapon. A machinegun, \
		however, is still a machinegun, no matter how hard it is to keep on target."

	return .

/obj/item/gun/ballistic/automatic/sol_rifle/machinegun/no_mag
	spawnwithmagazine = FALSE

// Evil version of the rifle (nothing different it's just black)

/obj/item/gun/ballistic/automatic/sol_rifle/evil
	desc = "A heavy battle rifle, this one seems to be painted tacticool black. Accepts any standard SolFed rifle magazine."

	icon_state = "infanterie_evil"
	worn_icon_state = "infanterie_evil"
	inhand_icon_state = "infanterie_evil"

/obj/item/gun/ballistic/automatic/sol_rifle/evil/no_mag
	spawnwithmagazine = FALSE
