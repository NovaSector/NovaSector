/*!
 * Contains crusher trophies you can obtain from megafauna
 */
// Marks this trophy as a fauna trophy so it triggers the lore messages when entering the mining z-level. Cosmetic trophies won't activate this
/obj/item/crusher_trophy
// LAVALAND TROPHIES
/obj/item/crusher_trophy/miner_eye
	fauna_trophy = TRUE

/obj/item/crusher_trophy/tail_spike
	fauna_trophy = TRUE

/obj/item/crusher_trophy/demon_claws
	fauna_trophy = TRUE
	var/stat_bonuses_applied = FALSE
	var/mob/living/current_user

/obj/item/crusher_trophy/blaster_tubes
	fauna_trophy = TRUE

/obj/item/crusher_trophy/vortex_talisman
	fauna_trophy = TRUE

//blood-drunk hunter
/obj/item/crusher_trophy/miner_eye/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	. = ..()

//ash drake
/obj/item/crusher_trophy/tail_spike/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	. = ..()

//bubblegum demon claws
/obj/item/crusher_trophy/demon_claws/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(!.)
		return
	current_user = user
	RegisterSignal(pkc, COMSIG_MOVABLE_MOVED, PROC_REF(on_crusher_moved))
	check_and_update_bonuses(pkc, user)

/obj/item/crusher_trophy/demon_claws/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	if(stat_bonuses_applied)
		pkc.force_wielded -= bonus_value * 0.2
		pkc.detonation_damage -= bonus_value * 0.8
		pkc.update_wielding()
		stat_bonuses_applied = FALSE
	UnregisterSignal(pkc, COMSIG_MOVABLE_MOVED)
	current_user = null
	. = ..()

/obj/item/crusher_trophy/demon_claws/proc/on_crusher_moved(datum/source, atom/old_loc, atom/new_loc)
	SIGNAL_HANDLER
	check_and_update_bonuses(source, current_user)

/obj/item/crusher_trophy/demon_claws/proc/check_and_update_bonuses(obj/item/kinetic_crusher/pkc, mob/living/user)
	var/should_have_bonuses = pkc.trophies_enabled

	if(should_have_bonuses && !stat_bonuses_applied)
		pkc.force_wielded += bonus_value * 0.2
		pkc.detonation_damage += bonus_value * 0.8
		pkc.update_wielding()
		stat_bonuses_applied = TRUE
	else if(!should_have_bonuses && stat_bonuses_applied)
		pkc.force_wielded -= bonus_value * 0.2
		pkc.detonation_damage -= bonus_value * 0.8
		pkc.update_wielding()
		stat_bonuses_applied = FALSE

/obj/item/crusher_trophy/demon_claws/on_melee_hit(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	user.heal_ordered_damage(bonus_value * 0.1, damage_heal_order)

/obj/item/crusher_trophy/demon_claws/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()
	user.heal_ordered_damage(bonus_value * 0.4, damage_heal_order)

//colossus
/obj/item/crusher_trophy/blaster_tubes/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	. = ..()

//hierophant
/obj/item/crusher_trophy/vortex_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	. = ..()

// ICE WASTES TROPHIES
