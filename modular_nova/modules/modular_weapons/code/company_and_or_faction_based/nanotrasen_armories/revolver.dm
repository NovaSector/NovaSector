/// NT-E Laevateinn .38 revolver - it's a bit chunky but it has a barrel charger

/obj/item/gun/ballistic/revolver/c38/super
	name = "\improper NT/E Laevateinn Revolver"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/ballistic.dmi'
	icon_state = "c38rail"
	base_icon_state = "c38rail"
	w_class = WEIGHT_CLASS_NORMAL
	obj_flags = UNIQUE_RENAME
	desc = "A new spin on a classic. Uses .38 Special rounds, and features both a magnified sight and a non-adjustable charge-shot assembly built into the barrel for precision fire."
	desc_controls = "Use the action button to toggle charged shots, increasing projectile speed and damage in return for firerate."
	lore_blurb = "The NT/E Laevateinn is Nanotrasen's take on a charged-shot revolver, designed shortly after the BR-38.<br><br>\
		With the success of the BR-38 (as a project), a small group of technicians experienced with the carbine's workings \
		proposed downscaling its magnetic acceleration system for use within a revolver's form-factor. Interestingly enough, \
		their proposal was accepted, and work began on the new project... with a surprising amount of success. \
		The smaller package necessitated some tradeoffs, though, to prevent catastrophic failures.<br><br>\
		The Laevateinn's performance is comparable to a regular .38 revolver by default. Enabling the charge assembly \
		increases projectile velocity and performance, but engages a tamper-proof limiter system that prevents successive trigger pulls \
		to prevent users from literally firing the gun into rapid, magnetically-accelerated deconstruction (read: exploding).<br><br>\
		Regardless of perceived drawbacks, some express a fondness for such experimental firearms. Many choose to give theirs a name."
	unique_reskin = list(
		"Baseline" = "c38rail",
		"Reflex" = "c38rail_sight",
		"Hunter" = "c38rail_scope",
		"Shadow Baseline" = "c38rail_dark",
		"Shadow Reflex" = "c38rail_dark_sight",
		"Shadow Hunter" = "c38rail_dark_scope",
		"Midnight Baseline" = "c38rail_midnight",
		"Midnight Reflex" = "c38rail_midnight_sight",
		"Midnight Hunter" = "c38rail_midnight_scope",
	)

	/// Is this revolver amped? Used instead of toggling a fire selector. Amped Laevateinns gain increased damage and projectile velocity in return for firerate and recoil.
	var/amped = FALSE
	/// Base damage multiplier of the revolver.
	var/base_damage_mult = 1
	/// Base projectile speed multiplier of the revolver.
	var/base_speed_mult = 1
	/// Base fire delay of the revolver.
	var/base_fire_delay = NONE // uses base click delay
	/// Base fire sound of the revolver.
	var/base_fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	/// Base recoil of the revolver.
	var/base_recoil = NONE
	/// Amped damage multiplier of the revolver.
	var/amped_damage_mult = 1.2
	/// Amped projectile speed multiplier of the revolver.
	var/amped_speed_mult = 1.5
	/// Amped fire delay of the revolver.
	var/amped_fire_delay = CLICK_CD_RANGE * 2 // this actually becomes CLICK_CD_MELEE.
	/// Amped fire sound of the revolver.
	var/amped_fire_sound = 'sound/items/weapons/thermalpistol.ogg'
	/// Amped recoil of the revolver.
	var/amped_recoil = 0.5
	actions_types = list(/datum/action/item_action/toggle_38rev_barrel)

/obj/item/gun/ballistic/revolver/c38/super/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/revolver/c38/super/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/revolver/c38/super/update_overlays()
	. = ..()
	if(amped)
		. += "[initial(icon_state)]_charge"

/obj/item/gun/ballistic/revolver/c38/super/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/toggle_38rev_barrel))
		toggle_amp(user)
	else
		..()

/obj/item/gun/ballistic/revolver/c38/super/proc/toggle_amp(mob/user)
	amped = !amped
	if(amped)
		projectile_damage_multiplier = amped_damage_mult
		projectile_speed_multiplier = amped_speed_mult
		fire_delay = amped_fire_delay
		fire_sound = amped_fire_sound
		recoil = amped_recoil
		balloon_alert(user, "barrel amped")
	else
		projectile_damage_multiplier = base_damage_mult
		projectile_speed_multiplier = base_speed_mult
		fire_delay = base_fire_delay
		fire_sound = base_fire_sound
		recoil = base_recoil
		balloon_alert(user, "barrel de-amped")
	playsound(user, 'sound/items/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	update_item_action_buttons()

/obj/item/gun/ballistic/revolver/c38/super/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38/empty

// Turns out cylinders really don't like it when they don't initialize ammo/start empty,
// so we just delete everything on init to keep the cylinder structure it expects in stored_ammo.
/obj/item/ammo_box/magazine/internal/cylinder/rev38/empty

/obj/item/ammo_box/magazine/internal/cylinder/rev38/empty/Initialize(mapload)
	. = ..()
	var/list/to_clear = ammo_list() // forces ammo to init
	for (var/obj/item/ammo_casing/casing in to_clear) // and then deletes it
		qdel(casing)
