// Archon Combat Systems shotguns are generally conversions of previously-existing shotguns with barrel chargers.
// Barrel chargers improve damage and projectile speed, but cause the firerate to suffer.

// Nachtreiher combat shotgun - pump-action, larger magazine, amp increases damage, decreases firerate.

/datum/atom_skin/nachtreiher_shotgun
	change_base_icon_state = TRUE
	change_worn_icon_state = FALSE
	abstract_type = /datum/atom_skin/nachtreiher_shotgun

/datum/atom_skin/nachtreiher_shotgun/standard
	preview_name = "Standard"
	new_icon_state = "renoster_super"

/datum/atom_skin/nachtreiher_shotgun/shadowed
	preview_name = "Shadowed"
	new_icon_state = "renoster_super_dark"

/obj/item/gun/ballistic/shotgun/riot/sol/super
	name = "\improper Nachtreiher combat shotgun"
	desc = "A robust twelve-gauge shotgun with an extended nine-shell top-mounted magazine tube and integrated barrel charger. \
		A fine choice for those who swore to bring order to chaos."
	desc_controls = "Use the action button to toggle the barrel charger, increasing projectile speed and damage but reducing firerate."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/archon_combat_systems/guns48x.dmi'
	icon_state = "renoster_super"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "renoster"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/archon_combat_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/archon_combat_systems/guns_righthand.dmi'
	inhand_icon_state = "renoster_super"

	can_suppress = FALSE
	can_be_sawn_off = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol_super
	rack_delay = 0.5 SECONDS
	fire_delay = 0.4 SECONDS

	lore_blurb = "The Nachtreiher is an overhaul of the robust M64 shotgun of SolFed fame, improving on an already lethal design.<br>\
		<br>\
		More precisely, the Archon Combat Systems \"KOLBEN/NACHTREIHER\" suite (as it's officially known) is an upgrade and accessory set for the M64, \
		featuring an extended magazine tube, smartlink sight, and improved-ergonomics pump. \
		An auxiliary barrel charger provides improved ballistic performance, but, when activated, \
		limits firerate in order to prevent catastrophic failure. \
		None of this, however, comes cheap, which means that examples of Nachtreiher overhauls are an uncommon sight."

/obj/item/gun/ballistic/shotgun/riot/sol/super/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/nachtreiher_shotgun)

/obj/item/gun/ballistic/shotgun/riot/sol/super/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ARCHON)

/obj/item/gun/ballistic/shotgun/riot/sol/super/empty
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol_super/empty

/obj/item/gun/ballistic/shotgun/riot/sol/super/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/gun_booster, \
		booster_action = /datum/action/item_action/booster/sol_super, \
		base_damage_mult = 1, \
		base_speed_mult = 1, \
		base_fire_delay = 0.4 SECONDS, \
		amped_damage_mult = 1.2, \
		amped_speed_mult = 1.25, \
		amped_fire_delay = 1 SECONDS, \
	)
	RegisterSignal(src, COMSIG_GUN_BOOSTER_TOGGLED, PROC_REF(on_booster_toggle))

/obj/item/gun/ballistic/shotgun/riot/sol/super/Destroy(force)
	UnregisterSignal(src, COMSIG_GUN_BOOSTER_TOGGLED)
	return ..()

/obj/item/gun/ballistic/shotgun/riot/sol/super/proc/on_booster_toggle(datum/component/source, mob/user, amped)
	SIGNAL_HANDLER
	if(amped)
		balloon_alert(user, "barrel amped, firerate limited")
	else
		balloon_alert(user, "barrel de-amped, firerate released")

// todo send COMSIG_GUN_RACK and COMSIG_GUN_BEFORE_FIRING signals to upstream if they'll take it
/obj/item/gun/ballistic/shotgun/riot/sol/super/rack(mob/user)
	. = ..()
	var/datum/component/gun_booster/booster_component = GetComponent(/datum/component/gun_booster)
	if(booster_component?.amped)
		playsound(src, 'sound/items/weapons/kinetic_reload.ogg', 50, TRUE)

/obj/item/gun/ballistic/shotgun/riot/sol/super/before_firing(atom/target, mob/user)
	var/datum/component/gun_booster/booster_component = GetComponent(/datum/component/gun_booster)
	if(booster_component?.amped && chambered && chambered.variance > 0)
		chambered.variance = initial(chambered.variance) * 0.7
	return ..()

/datum/action/item_action/booster/sol_super
	button_icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/archon_combat_systems/parts_kits.dmi'
	button_icon_state = "sol_super_action"
	name = "Toggle Shotgun Barrel Charger"

/obj/item/ammo_box/magazine/internal/shot/sol_super
	ammo_type = /obj/item/ammo_casing/shotgun/flechette
	max_ammo = 9

/obj/item/ammo_box/magazine/internal/shot/sol_super/empty
	start_empty = TRUE

// Kasuar enhanced assault shotgun - semi-automatic, becomes manual/bolt-action when amped. Works like a better combat shotgun, otherwise.

/datum/atom_skin/kasuar_shotgun
	abstract_type = /datum/atom_skin/kasuar_shotgun
	change_base_icon_state = TRUE
	change_worn_icon_state = FALSE

/datum/atom_skin/kasuar_shotgun/standard
	preview_name = "Standard"
	new_icon_state = "renoster_super2"

/datum/atom_skin/kasuar_shotgun/shadowed
	preview_name = "Shadowed"
	new_icon_state = "renoster_super2_dark"

/obj/item/gun/ballistic/shotgun/riot/sol/super/plus
	name = "\improper Kasuar enhanced assault shotgun"
	desc = "A concerningly robust twelve-gauge shotgun with an extended ten-shell top-mounted magazine tube and integrated barrel charger. \
		A specialist's shotgun for very specific purposes, such as the reunion of men with their ancestors."
	icon_state = "renoster_super2"
	lore_blurb = "The Kasuar is an extensive overhaul of the robust M64 shotgun of SolFed fame, further iterating on an already lethal design.<br>\
		<br>\
		More precisely, the Archon Combat Systems \"KOLBEN/KASUAR\" suite (as it's officially known) is an upgrade and accessory set for the M64, \
		consisting of a hardened semi-automatic internals suite, extended magazine tube, smartlink sight, hybridized handguard-smartlink aiming module, \
		and an integrated duplex barrel charger providing innately improved ballistic performance, \
		with an optional, exceptionally performant overclock mode tied to manual bolt actuation to avoid catastrophic failure. \
		None of this, however, comes cheap, especially to the civilian market, \
		which means that examples of the Kolben only typically appear in the collections \
		of wealthy trend-chasers or paramilitary groups with more funding than regard for sapient life."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol_super/plus
	bolt_wording = "bolt"
	semi_auto = TRUE
	casing_ejector = TRUE
	projectile_damage_multiplier = 1.35

/obj/item/gun/ballistic/shotgun/riot/sol/super/plus/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/kasuar_shotgun)

/datum/action/item_action/booster/sol_super/plus
	name = "Overclock Shotgun Barrel Charger"

/obj/item/gun/ballistic/shotgun/riot/sol/super/plus/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/gun_booster, \
		booster_action = /datum/action/item_action/booster/sol_super/plus, \
		base_damage_mult = 1.35, \
		base_speed_mult = 1, \
		base_fire_delay = 0.4 SECONDS, \
		amped_damage_mult = 1.75, \
		amped_speed_mult = 1.5, \
		amped_fire_delay = 1 SECONDS, \
	)

/obj/item/ammo_box/magazine/internal/shot/sol_super/plus
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/shot/sol_super/plus/empty
	start_empty = TRUE

// Lammergeier enhanced double-barrel - over/under, increased accuracy and base damage, barrel charger amplifies both

/datum/atom_skin/double_super
	change_base_icon_state = TRUE
	change_worn_icon_state = FALSE
	abstract_type = /datum/atom_skin/double_super

/datum/atom_skin/double_super/standard
	preview_name = "Standard"
	new_icon_state = "double_super"

/datum/atom_skin/double_super/shadowed
	preview_name = "Shadowed"
	new_icon_state = "double_super_dark"

/datum/atom_skin/double_super/standard_wood
	preview_name = "Caravaneer Standard"
	new_icon_state = "double_super_wood"

/datum/atom_skin/double_super/shadowed_wood
	preview_name = "Caravaneer Shadowed"
	new_icon_state = "double_super_dark_wood"

/obj/item/gun/ballistic/shotgun/doublebarrel/super
	name = "\improper Lammergeier enhanced double-barrel shotgun"
	desc = "The marksman's choice for long-range, precision shotgun shooting. \
		Features a magnification-capable hologram emitter sight and twinned charged barrels."
	desc_controls = "Use the action button to toggle the barrel charger, increasing projectile speed and damage but reducing firerate."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/archon_combat_systems/guns48x.dmi'
	icon_state = "double_super"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/archon_combat_systems/guns_worn.dmi'
	worn_icon_state = "double_super"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/archon_combat_systems/64x_guns_left.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/archon_combat_systems/64x_guns_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	inhand_icon_state = "double_super"

	base_icon_state = "double_super"
	force = 12
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/dual/slugs
	can_be_sawn_off = FALSE // probably don't do this, but in case it happens:
	sawn_desc = "Formerly the marksman's choice for long-range, precision shotgun shooting. \
		Creative reasembly maintains both the integrated hologram sight and twinned charged barrels."
	obj_flags = UNIQUE_RENAME
	lore_blurb = "The Lammergeier is an extensive overhaul of the venerable side-by-side double-barrel shotgun into \
		an over/under configuration with reinforced barrels and an enhanced receiver that improves ballistic performance.<br>\
		<br>\
		Designed with the discerning precision shotgun shooter in mind, the mechanisms at work within the Lammergeier provide \
		improved velocity and tighter spread for fired projectiles, and the sights feature an integrated hologram emitter that can provide \
		both a magnified view and advanced ballistic co-processing for making your two shots really count. \
		In the event you really need your shots to matter, though, the Lammergeier, much like many other Archon offerings, features a barrel charger - \
		more accurately, two duplex barrel chargers, one for each barrel, with enhanced throughput compared to standard barrel chargers allowing for \
		greatly improved ballistic performance."
	projectile_damage_multiplier = 1.1
	projectile_speed_multiplier = 1.1
	/// Base fire sound of the shotgun.
	var/base_fire_sound = 'modular_nova/modules/modular_weapons/sounds/shotgun_heavy.ogg'
	/// Base recoil of the shotgun.
	var/base_recoil = NONE
	/// Fire sound when the shotgun's barrel chargers are on (amped).
	var/amped_fire_sound = 'sound/items/weapons/kinetic_accel.ogg'
	/// Recoil when the shotgun's barrel chargers are on (amped).
	var/amped_recoil = 0.5

/obj/item/gun/ballistic/shotgun/doublebarrel/super/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/double_super)

/obj/item/gun/ballistic/shotgun/doublebarrel/super/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/gun_booster, \
		booster_action = /datum/action/item_action/booster/doublebarrel_super, \
		base_damage_mult = 1.1, \
		base_speed_mult = 1.1, \
		base_fire_delay = 0.4 SECONDS, \
		amped_damage_mult = 1.35, \
		amped_speed_mult = 1.5, \
		amped_fire_delay = 0.6 SECONDS, \
	)
	AddComponent(/datum/component/scope, range_modifier = 2)
	RegisterSignal(src, COMSIG_GUN_BOOSTER_TOGGLED, PROC_REF(on_booster_toggle))

/obj/item/gun/ballistic/shotgun/doublebarrel/super/Destroy(force)
	UnregisterSignal(src, COMSIG_GUN_BOOSTER_TOGGLED)
	return ..()

/obj/item/gun/ballistic/shotgun/doublebarrel/super/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ARCHON)

/obj/item/gun/ballistic/shotgun/doublebarrel/super/empty
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/dual/empty

/obj/item/gun/ballistic/shotgun/doublebarrel/super/proc/on_booster_toggle(datum/component/source, mob/user, amped)
	SIGNAL_HANDLER
	if(amped)
		fire_sound = amped_fire_sound
		recoil = amped_recoil
		pb_knockback = 5 // i hope you're throwing them into a wall
		balloon_alert(user, "barrels amped")
	else
		fire_sound = base_fire_sound
		recoil = base_recoil
		pb_knockback = initial(pb_knockback)
		balloon_alert(user, "barrels de-amped")

/obj/item/gun/ballistic/shotgun/doublebarrel/super/unload_ammo(mob/living/user, forced)
	. = ..()
	var/datum/component/gun_booster/booster_component = GetComponent(/datum/component/gun_booster)
	if(booster_component?.amped)
		playsound(src, 'sound/items/weapons/kinetic_reload.ogg', 50, TRUE)

/obj/item/gun/ballistic/shotgun/doublebarrel/super/before_firing(atom/target, mob/user)
	var/datum/component/gun_booster/booster_component = GetComponent(/datum/component/gun_booster)
	if(booster_component?.amped && chambered && chambered.variance > 0)
		chambered.variance = initial(chambered.variance) * 0.4
	else if(chambered && chambered.variance > 0)
		chambered.variance = initial(chambered.variance) * 0.7
	return ..()

/datum/action/item_action/booster/doublebarrel_super
	button_icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/archon_combat_systems/parts_kits.dmi'
	button_icon_state = "double_super_action"
	name = "Toggle Shotgun Twinned Barrel Chargers"

/obj/item/ammo_box/magazine/internal/shot/dual/empty
	start_empty = TRUE
