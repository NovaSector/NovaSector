// SolFed shotgun (this was gonna be in a proprietary shotgun shell type outside of 12ga at some point, wild right?)

/obj/item/gun/ballistic/shotgun/riot/sol
	name = "\improper M64 Shotgun"
	desc = "A robust twelve-gauge shotgun with an eight-shell, top-mounted magazine tube. Made for and used by SolFed's various military and police forces."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	icon_state = "renoster"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "renoster"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "renoster"

	inhand_x_dimension = 32
	inhand_y_dimension = 32

	SET_BASE_PIXEL(-8, 0)

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/shotgun_heavy.ogg'
	rack_sound = 'modular_nova/modules/modular_weapons/sounds/shotgun_rack.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = TRUE
	rack_delay = 0.5 SECONDS
	fire_delay = 0.5 SECONDS // Turns out, this is actually pretty fairly balanced
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol
	suppressor_x_offset = 7
	suppressor_y_offset = -3

	lore_blurb = "The M64 was designed, at its core, as a police shotgun.<br><br>\
		As a consequence, it holds all the qualities a police force would want \
		in a shotgun; a large capacity, robust frame, and enough modularity \
		to satiate even the most overfunded of peacekeeper forces. \
		Inevitably, it made its way into civilian markets, \
		alongside its sale to several military branches that also \
		saw value in having a heavy shotgun."

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

/obj/item/gun/ballistic/shotgun/riot/sol/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 32, \
		overlay_y = 12, \
	)

/obj/item/gun/ballistic/shotgun/riot/sol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/shotgun/riot/sol/update_appearance(updates)
	if(sawn_off)
		suppressor_x_offset = 0
		SET_BASE_PIXEL(0, 0)

	. = ..()

/obj/item/gun/ballistic/shotgun/riot/sol/sawoff(mob/user, obj/item/saw, handle_modifications)
	. = ..()
	magazine.max_ammo = 4 // capacity drops to 4+1 because Where's The Rest Of The Magazine, Bro
	// possible todo short inhands?

/obj/item/ammo_box/magazine/internal/shot/sol
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	max_ammo = 8

/obj/item/gun/ballistic/shotgun/riot/sol/thunderdome
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol/thunderdome

/obj/item/ammo_box/magazine/internal/shot/sol/thunderdome
	ammo_type = /obj/item/ammo_casing/shotgun/beehive

// Shotgun but EVIL!

/obj/item/gun/ballistic/shotgun/riot/sol/evil
	desc = parent_type::desc + " This one is painted in a tacticool black."

	icon_state = "renoster_evil"
	worn_icon_state = "renoster_evil"
	inhand_icon_state = "renoster_evil"

/obj/item/gun/ballistic/shotgun/riot/sol/evil/thunderdome
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol/thunderdome/evil

/obj/item/ammo_box/magazine/internal/shot/sol/thunderdome/evil
	ammo_type = /obj/item/ammo_casing/shotgun/flechette_nova

/obj/item/gun/ballistic/shotgun/riot/sol/super
	name = "\improper Nachtreiher combat shotgun"
	desc = "A robust twelve-gauge shotgun with an extended nine-shell top-mounted magazine tube and integrated barrel charger. \
		A fine choice for those who swore to bring order to chaos."
	desc_controls = "Use the action button to toggle the barrel charger, increasing projectile speed and damage but reducing firerate."
	can_suppress = FALSE
	can_be_sawn_off = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol_super
	unique_reskin = list(
		"Standard" = "renoster_super",
		"Shadowed" = "renoster_super_dark",
	)
	icon_state = "renoster_super"
	inhand_icon_state = "renoster_super"
	lore_blurb = "The Nachtreiher is an overhaul of the robust M64 shotgun of SolFed fame, improving on an already lethal design.<br><br>\
		More precisely, the Archon Combat Systems \"KOLBEN/NACHTREIHER\" suite (as it's officially known) is an upgrade and accessory set for the M64, \
		featuring an extended magazine tube, smartlink sight, and improved-ergonomics pump. \
		An auxiliary barrel charger provides improved ballistic performance, but, when activated, \
		limits firerate in order to prevent catastrophic failure. \
		None of this, however, comes cheap, which means that examples of Nachtreiher overhauls are an uncommon sight."
	rack_delay = 0.5 SECONDS
	fire_delay = 0.4 SECONDS

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
		chambered.variance = initial(chambered.variance) / 2.5
	return ..()

/datum/action/item_action/booster/sol_super
	button_icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns32x.dmi'
	button_icon_state = "hbarrel"
	name = "Toggle Shotgun Barrel Charger"

/obj/item/ammo_box/magazine/internal/shot/sol_super
	ammo_type = /obj/item/ammo_casing/shotgun/flechette
	max_ammo = 9

/obj/item/ammo_box/magazine/internal/shot/sol_super/empty
	start_empty = TRUE

/obj/item/gun/ballistic/shotgun/riot/sol/super/plus
	name = "\improper Kasuar enhanced assault shotgun"
	desc = "A concerningly robust twelve-gauge shotgun with an extended ten-shell top-mounted magazine tube and integrated barrel charger. \
		A specialist's shotgun for very specific purposes, such as the reunion of men with their ancestors."
	icon_state = "renoster_super2"
	unique_reskin = list(
		"Standard" = "renoster_super2",
		"Shadowed" = "renoster_super2_dark",
	)
	lore_blurb = "The Kasuar is an extensive overhaul of the robust M64 shotgun of SolFed fame, further iterating on an already lethal design.<br><br>\
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
