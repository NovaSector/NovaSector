/// NT-E Laevateinn .38 revolver - it's a bit chunky but it has a barrel charger

/datum/atom_skin/laevateinn_revolver
	abstract_type = /datum/atom_skin/laevateinn_revolver

/datum/atom_skin/laevateinn_revolver/base
	preview_name = "Baseline"
	new_icon_state = "c38rail"

/datum/atom_skin/laevateinn_revolver/base/reflex
	preview_name = "Reflex"
	new_icon_state = "c38rail_sight"

/datum/atom_skin/laevateinn_revolver/base/hunter
	preview_name = "Hunter"
	new_icon_state = "c38rail_scope"

/datum/atom_skin/laevateinn_revolver/base/shadow
	preview_name = "Shadow Baseline"
	new_icon_state = "c38rail_dark"

/datum/atom_skin/laevateinn_revolver/base/shadow/reflex
	preview_name = "Shadow Reflex"
	new_icon_state = "c38rail_dark_sight"

/datum/atom_skin/laevateinn_revolver/base/shadow/hunter
	preview_name = "Shadow Hunter"
	new_icon_state = "c38rail_dark_scope"

/datum/atom_skin/laevateinn_revolver/midnight
	preview_name = "Midnight Baseline"
	new_icon_state = "c38rail_midnight"

/datum/atom_skin/laevateinn_revolver/midnight/reflex
	preview_name = "Midnight Reflex"
	new_icon_state = "c38rail_midnight_sight"

/datum/atom_skin/laevateinn_revolver/midnight/hunter
	preview_name = "Midnight Hunter"
	new_icon_state = "c38rail_midnight_scope"

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

	/// Base fire sound of the revolver.
	var/base_fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	/// Base recoil of the revolver.
	var/base_recoil = NONE
	/// Amped fire sound of the revolver.
	var/amped_fire_sound = 'sound/items/weapons/thermalpistol.ogg'
	/// Amped recoil of the revolver.
	var/amped_recoil = 0.5

/obj/item/gun/ballistic/revolver/c38/super/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/laevateinn_revolver)

/obj/item/gun/ballistic/revolver/c38/super/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)
	AddComponent(\
		/datum/component/gun_booster, \
		booster_action = /datum/action/item_action/booster/c38super, \
		base_damage_mult = 1, \
		base_speed_mult = 1, \
		base_fire_delay = NONE, \
		amped_damage_mult = 1.2, \
		amped_speed_mult = 1.2, \
		amped_fire_delay = (CLICK_CD_RANGE*2), \
	)
	RegisterSignal(src, COMSIG_GUN_BOOSTER_TOGGLED, PROC_REF(on_booster_toggle))

/obj/item/gun/ballistic/revolver/c38/super/Destroy(force)
	UnregisterSignal(src, COMSIG_GUN_BOOSTER_TOGGLED)
	return ..()

/obj/item/gun/ballistic/revolver/c38/super/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/revolver/c38/super/proc/on_booster_toggle(datum/component/source, mob/user, amped)
	SIGNAL_HANDLER
	if(amped)
		fire_sound = amped_fire_sound
		recoil = amped_recoil
		balloon_alert(user, "barrel amped")
	else
		fire_sound = base_fire_sound
		recoil = base_recoil
		balloon_alert(user, "barrel de-amped")

/datum/action/item_action/booster/c38super
	button_icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/ballistic.dmi'
	button_icon_state = "revboost"
	name = "Toggle Revolver Barrel Charger"

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
