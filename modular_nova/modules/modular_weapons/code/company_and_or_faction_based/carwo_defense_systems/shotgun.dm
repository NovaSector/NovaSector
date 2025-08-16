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

/obj/item/ammo_box/magazine/internal/shot/sol
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	max_ammo = 8

/obj/item/gun/ballistic/shotgun/riot/sol/thunderdome
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol/thunderdome

/obj/item/ammo_box/magazine/internal/shot/sol/thunderdome
	ammo_type = /obj/item/ammo_casing/shotgun/beehive

// Shotgun but EVIL!

/obj/item/gun/ballistic/shotgun/riot/sol/evil
	desc = parent_type::desc + "This one is painted in a tacticool black."

	icon_state = "renoster_evil"
	worn_icon_state = "renoster_evil"
	inhand_icon_state = "renoster_evil"

/obj/item/gun/ballistic/shotgun/riot/sol/evil/thunderdome
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol/thunderdome/evil

/obj/item/ammo_box/magazine/internal/shot/sol/thunderdome/evil
	ammo_type = /obj/item/ammo_casing/shotgun/flechette_nova

/obj/item/gun/ballistic/shotgun/riot/sol/super
	name = "\improper Kolben enhanced combat shotgun"
	desc = "A robust twelve-gauge shotgun with an extended ten-shell top-mounted magazine tube and integrated barrel charger. \
	A specialist's shotgun for very specific purposes; typically, the reunion of men with their ancestors."
	can_suppress = FALSE
	can_be_sawn_off = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol_super
	icon_state = "renoster_super"
	bolt_wording = "bolt"
	lore_blurb = "The Kolben is an overhaul of the robust M64 shotgun of SolFed fame, improving on an already lethal design.<br><br>\
		More precisely, the Archon Combat Systems \"KOLBEN-KASUAR\" suite (as it's officially known) is an upgrade and accessory set for the M64, \
		consisting of a hardened receiver and magazine tube, smartlink sight, hybridized handguard-smartlinked aiming module, and an integrated barrel charger \
		providing improved ballistic performance, with an optional overclock mode tied to manual bolt actuation. \
		None of this, however, comes cheap, especially to the civilian market, which means that examples of the Kolben only typically appear in the collections \
		of wealthy trend-chasers or paramilitary groups with more funding than regard for sapient life."
	projectile_damage_multiplier = 1.35
	projectile_speed_multiplier = 1
	rack_delay = 0.5 SECONDS
	fire_delay = 0.4 SECONDS
	/// Is this shotgun amped? Used instead of toggling a fire selector. Amped Kolbens switch from semi-auto to manual action, gain increased accuracy, and improved damage.
	var/amped = FALSE
	// Base damage multiplier of the shotgun.
	var/base_damage_mult = 1.35
	/// Base projectile speed multiplier of the shotgun.
	var/base_speed_mult = 1
	/// Base fire delay of the shotgun.
	var/base_fire_delay = 0.4 SECONDS
	/// Amped damage multiplier of the shotgun.
	var/amped_damage_mult = 1.5
	/// Amped projectile speed multiplier of the shotgun.
	var/amped_speed_mult = 1.5
	/// Amped fire delay of the shotgun.
	var/amped_fire_delay = 2 SECONDS
	actions_types = list(/datum/action/item_action/toggle_shotgun_barrel)

/obj/item/gun/ballistic/shotgun/riot/sol/super/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_ARCHON)

/obj/item/gun/ballistic/shotgun/riot/sol/super/empty
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/sol_super

/obj/item/gun/ballistic/shotgun/riot/sol/super/update_overlays()
	. = ..()
	if(amped)
		. += "[initial(icon_state)]_charge"

/obj/item/gun/ballistic/shotgun/riot/sol/super/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/toggle_shotgun_barrel))
		toggle_amp(user)
	else
		..()

/obj/item/gun/ballistic/shotgun/riot/sol/super/rack(mob/user)
	. = ..()
	if(amped)
		playsound(src, 'sound/items/weapons/kinetic_reload.ogg', 50, TRUE)

/obj/item/gun/ballistic/shotgun/riot/sol/super/proc/toggle_amp(mob/user)
	amped = !amped
	if(amped)
		semi_auto = FALSE
		casing_ejector = FALSE
		projectile_damage_multiplier = amped_damage_mult
		projectile_speed_multiplier = amped_speed_mult
		fire_delay = amped_fire_delay
		balloon_alert(user, "barrel amped, set to manual")
	else
		semi_auto = TRUE
		casing_ejector = TRUE
		projectile_damage_multiplier = base_damage_mult
		projectile_speed_multiplier = base_speed_mult
		fire_delay = base_fire_delay
		balloon_alert(user, "barrel de-amped, set to semi")
	playsound(user, 'sound/items/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	update_item_action_buttons()

/obj/item/gun/ballistic/shotgun/riot/sol/super/before_firing(atom/target, mob/user)
	if(amped && chambered && chambered.variance > 0)
		chambered.variance = initial(chambered.variance) / 2.5
	return ..()

/obj/item/ammo_box/magazine/internal/shot/sol_super
	ammo_type = /obj/item/ammo_casing/shotgun/flechette
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/shot/sol_super/empty
	start_empty = TRUE
