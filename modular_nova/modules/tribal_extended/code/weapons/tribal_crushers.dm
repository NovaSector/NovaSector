/obj/item/kinetic_crusher/tribal/runic_greatsword
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "swordon"
	inhand_icon_state = "swordon"
	worn_icon_state = "swordon"
	name = "Runic Greatsword"
	desc = "A greatsword of Hearthkin make. The runes on the blades glows a soft blue"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	light_color = "#8DEBFF"

//changed compared to the basic version, mainly we don't fire a projectile and we don't care if the cursor is over the player.
/obj/item/kinetic_crusher/tribal/runic_greatsword/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(src, TRAIT_WIELDED) && !acts_as_if_wielded) // NOVA EDIT CHANGE - Original: if(!HAS_TRAIT(src, TRAIT_WIELDED))
		balloon_alert(user, "wield it first!")
		return ITEM_INTERACT_BLOCKING
	runic_spin()
	user.changeNext_move(CLICK_CD_MELEE)
	return ITEM_INTERACT_SUCCESS

// Marks living things in melee of the user if crusher is charged.
/obj/item/kinetic_crusher/tribal/runic_greatsword/proc/runic_spin()
	var/spin_radius = 1 //Hits everyone around the user
	var/spin_center = get_turf(usr)
	new /obj/effect/temp_visual/runic_spin(get_turf(usr))
	if(!charged)
		return
	for(var/mob/living/living_target in range(spin_radius,spin_center))
		if(living_target != usr && !(usr in living_target.buckled_mobs)) // we're not marking ourselves or our mount.
			for(var/obj/item/crusher_trophy/crusher_trophy as anything in trophies)
				crusher_trophy.on_projectile_hit_mob(living_target, usr)
			if(QDELETED(living_target) || living_target.health <= 0)
				continue
			living_target.apply_status_effect(/datum/status_effect/crusher_mark)
			living_target.update_appearance()
			new /obj/effect/temp_visual/flying_rune(get_turf(living_target))
	playsound(usr, 'sound/effects/magic/tail_swing.ogg', 100, TRUE)
	charged = FALSE
	icon_state = "swordoff"
	inhand_icon_state = "swordoff"
	worn_icon_state = "swordoff"
	update_appearance()
	attempt_recharge_runes()

//visual feedback on ability use, might need something more visible
/obj/effect/temp_visual/runic_spin
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "ring_leader_effect"
	duration = 2

//flavour, small rune pops where the marked target is.
/obj/effect/temp_visual/flying_rune
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "small_rune_11"
	duration = 6

// Handles the timer for reloading the projectile (slight edit of kinetic_crusher.dm)
/obj/item/kinetic_crusher/tribal/proc/attempt_recharge_runes(set_recharge_time)
	if(!set_recharge_time)
		set_recharge_time = charge_time
	deltimer(charge_timer)
	charge_timer = addtimer(CALLBACK(src, PROC_REF(recharge_runes)), set_recharge_time, TIMER_STOPPABLE)

// Recharges the projectile (slight edit of kinetic_crusher.dm)
/obj/item/kinetic_crusher/tribal/proc/recharge_runes()
	if(!charged)
		charged = TRUE
		icon_state = "swordon"
		inhand_icon_state = "swordon"
		worn_icon_state = "swordon"
		update_appearance()
		playsound(src.loc, 'sound/items/weapons/kinetic_reload.ogg', 60, TRUE)

//I'm not a spriter, reusing the moonlight greatsword which doesn't have a wielded icon, can probably removed if someone does a sprite with a wielded icon.
/obj/item/kinetic_crusher/tribal/runic_greatsword/update_icon_state()
	. = ..()
	inhand_icon_state = "swordon" // this is not icon_state and not supported by 2hcomponent

/datum/crafting_recipe/runic_greatsword
	name = "Runic Greatsword"
	category = CAT_WEAPON_MELEE
	//recipe given to icecats as part of their spawner/team setting
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	reqs = list(
		/obj/item/forging/complete/sword = 1,
		/obj/item/stack/sheet/leather = 1,
		/obj/item/stack/sheet/mineral/wood = 1,
		// Add rare mat
	)
	tool_behaviors = list(TOOL_RUSTSCRAPER)
	result = /obj/item/kinetic_crusher/tribal/runic_greatsword

// tofix : add rare mat from archeo
// Possibilty to add a spear version, if I can learn to sprite something decent.
