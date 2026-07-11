// Base Sol classic rifle meant for crewside use

/obj/item/gun/ballistic/automatic/sol_classic
	name = "\improper Renpaard Battle Rifle"
	desc = "A previous-generation heavy battle rifle firing .40 Sol. Seen in the hands of SolFed parade units \
		or in surplus stockpiles. Accepts any standard SolFed rifle magazine."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/veldjen-kuiper_armories/guns48x.dmi'
	icon_state = "infanterie"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/veldjen-kuiper_armories/guns_worn.dmi'
	worn_icon_state = "infanterie"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/veldjen-kuiper_armories/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/veldjen-kuiper_armories/guns_righthand.dmi'
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

	suppressor_x_offset = 12

	burst_size = 1
	fire_delay = 0.4 SECONDS
	actions_types = list()

	spread = 5
	projectile_wound_bonus = -10

	lore_blurb = "The V-K Blokstaart series of battle rifles are SolFed's previous generation of battle rifle, manufactured by Veldjen-Kuiper Armories.<br>\
		<br>\
		Designed from the ground-up to be reliable, durable, and still relatively cheap for mass adoption, the Blokstaart series was developed around \
		the .40 Sagittarian cartridge, well before its official adoption as .40 Sol Long. \
		This close relationship between rifle and cartridge allows all conventional variants of the Blokstaart to share magazines and cartridges, \
		lengthening the lifespans of logistics coordinators, quartermasters, and other supply staff by several years.<br>\
		<br>\
		While primarily manufactured for military sale, limited amounts were sold to the civilian market when it was still in service. \
		When the MMR-2543 series was initially adopted, the Blokstaart series was decommissioned and left for surplus stockpiles - which gave it \
		a second life during the Rimward War, when those stockpiles were smuggled into occupied territories to arm a great deal of SolFed partisans.<br>\
		<br>\
		With the further adoption of the MMR-2543, Veldjen-Kuiper Armories has decided to open sales to independent customers \
		to make good use of their surplus stock."

	/// Lore specific to this type of gun.
	var/model_specific_lore = "This particular variant is the Renpaard-Infanterie model, built for general use across SolFed's various infantry branches. \
		The plain glow-sights aren't anything remarkable, and the skeletal stock is firmly locked in place, unable to fold. \
		The fact of the matter, though, is that it remains true to its name as a swift warhorse of a rifle."

/obj/item/gun/ballistic/automatic/sol_classic/Initialize(mapload)
	. = ..()
	give_autofire()

/obj/item/gun/ballistic/automatic/sol_classic/get_lore_blurb()
	return lore_blurb + "<br><br>" + model_specific_lore

/// Separate proc for handling auto fire just because one of these subtypes isn't otomatica
/obj/item/gun/ballistic/automatic/sol_classic/proc/give_autofire()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/sol_classic/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_VELDJEN_KUIPER)

/obj/item/gun/ballistic/automatic/sol_classic/no_mag
	spawnwithmagazine = FALSE

// Sol marksman rifle

/obj/item/gun/ballistic/automatic/sol_classic/marksman
	name = "\improper Krijgspaard Marksman Rifle"
	desc = "A previous-generation heavy marksman rifle firing .40 Sol, sacrificing firerate for precision. Seen in the hands of SolFed parade units \
		or in surplus stockpiles. Accepts any standard SolFed rifle magazine."

	icon_state = "elite"
	worn_icon_state = "elite"
	inhand_icon_state = "elite"

	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle

	fire_delay = 0.6 SECONDS

	spread = 0
	projectile_damage_multiplier = 1.3 // 27*1.3 = 35.1 damage off base .40 sol, balanced by slightly slower firedelay + only semiauto
	projectile_speed_multiplier = 1.2 // and also faster shots.
	projectile_wound_bonus = 10

	model_specific_lore = "This particular variant is the Krijgspaard-Elite model, built for precision fire for use by designated marksmen. \
		Forsaking automatic fire in favor of precision, models like these typically feature match-grade triggers, \
		free-floating accurized barrels, and a variable-magnification optic built into the carrying handle. \
		These are typically seen with smaller magazines for the shooter's comfort, but remain fully compatible with full-size magazines, \
		in case you need to make a lot of very precise shots without reloading."

/obj/item/gun/ballistic/automatic/sol_classic/marksman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/automatic/sol_classic/marksman/give_autofire()
	return

/obj/item/gun/ballistic/automatic/sol_classic/marksman/no_mag
	spawnwithmagazine = FALSE

// Evil version of the rifles (nothing different it's just black)

/obj/item/gun/ballistic/automatic/sol_classic/evil
	desc = parent_type::desc + " This one is painted in a tacticool black."

	icon_state = "infanterie_evil"
	worn_icon_state = "infanterie_evil"
	inhand_icon_state = "infanterie_evil"

/obj/item/gun/ballistic/automatic/sol_classic/evil/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/sol_classic/marksman/evil
	desc = parent_type::desc + " This one is painted in a tacticool black."

	icon_state = "elite_evil"
	worn_icon_state = "elite_evil"
	inhand_icon_state = "elite_evil"

/obj/item/gun/ballistic/automatic/sol_classic/marksman/evil/no_mag
	spawnwithmagazine = FALSE
