// Low caliber grenade launcher (fun & games)

/obj/item/gun/ballistic/sol_grenade_launcher_break_action
	name = "\improper Scorpion Grenade Launcher"
	desc = "A unique single shot, break action grenade launcher firing .980 grenades. A laser sight system allows its user to specify a range for the grenades it fires to detonate at."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	icon_state = "scorpion"

	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	worn_icon_state = "scorpion"

	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "scorpion"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE
	bolt_type = BOLT_TYPE_LOCKING
	bolt_wording = "breech"
	semi_auto = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/sol_grenade_launcher_break_action
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT
	can_suppress = FALSE

	rack_sound = 'sound/items/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/rifle/bolt_in.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/rifle/rifle_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/rifle/rifle_pickup1.ogg'
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/grenade_launcher.ogg'

	/obj/item/gun/ballistic/sol_grenade_launcher_break_action/rack(mob/user = null)
		if (bolt_locked == FALSE)
			balloon_alert(user, "breech opened")
			process_chamber(FALSE, FALSE, FALSE)
			bolt_locked = TRUE
			update_appearance()
			return
	drop_bolt(user)

	/obj/item/gun/ballistic/sol_grenade_launcher_break_action/can_shoot()
		if (bolt_locked)
			return FALSE
		return ..()

	/obj/item/gun/ballistic/sol_grenade_launcher_break_action/examine(mob/user)
		. = ..()
		. += "The breech is [bolt_locked ? "open" : "closed"]."


	burst_size = 1
	fire_delay = 1
	actions_types = list()

	/// The currently stored range to detonate shells at
	var/target_range = 14
	/// The maximum range we can set grenades to detonate at, just to be safe
	var/maximum_target_range = 14

/obj/item/gun/ballistic/sol_grenade_launcher_break_action/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/sol_grenade_launcher_break_action/examine(mob/user)
	. = ..()

	. += span_notice("With <b>Right Click</b> you can set the range that shells will detonate at.")
	. += span_notice("A small indicator in the sight notes the current detonation range is: <b>[target_range]</b>.")

/obj/item/gun/ballistic/sol_grenade_launcher_break_action/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!interacting_with || !user)
		return ITEM_INTERACT_BLOCKING

	var/distance_ranged = get_dist(user, interacting_with)
	if(distance_ranged > maximum_target_range)
		user.balloon_alert(user, "out of range")
		return ITEM_INTERACT_BLOCKING

	target_range = distance_ranged
	user.balloon_alert(user, "range set: [target_range]")
	return ITEM_INTERACT_SUCCESS


