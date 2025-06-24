/*!
 * Contains crusher trophies you can obtain from megafauna
 */

// Marks this trophy as triggering lore messages when entering a special mining z-level
/obj/item/crusher_trophy

// LAVALAND TROPHIES
/obj/item/crusher_trophy/miner_eye
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/tail_spike
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/demon_claws
	trophy_triggers_lore = TRUE
	/// Tracks whether demon claw stat bonuses are currently applied.
	var/stat_bonuses_applied = FALSE

/obj/item/crusher_trophy/blaster_tubes
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/vortex_talisman
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/gladiator
	trophy_triggers_lore = TRUE
	/// Tracks whether the block chance bonus has been applied.
	var/bonus_applied = FALSE
	/// Cached reference to the user who applied the trophy.
	var/mob/living/current_user

/obj/item/crusher_trophy/ice_block_talisman
	trophy_triggers_lore = TRUE

/// Heals the user slightly on mark detonation which requires trophy bonuses to be active.
/obj/item/crusher_trophy/miner_eye/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	. = ..()

/// Damages on mark detonation which requires trophy bonuses to be active.
/obj/item/crusher_trophy/tail_spike/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	. = ..()

/// Applies stat bonuses when demon claws are added to the crusher.
/obj/item/crusher_trophy/demon_claws/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(!.) return
	RegisterSignal(pkc, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_crusher_moved))
	check_and_update_bonuses(pkc, user)

/// Removes stat bonuses from demon claws.
/obj/item/crusher_trophy/demon_claws/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	if(stat_bonuses_applied)
		pkc.force_wielded -= bonus_value * 0.2
		pkc.detonation_damage -= bonus_value * 0.8
		pkc.update_wielding()
		stat_bonuses_applied = FALSE
	UnregisterSignal(pkc, COMSIG_MOVABLE_Z_CHANGED)
	. = ..()

/// Signal handler for crusher movement to recheck bonuses.
/obj/item/crusher_trophy/demon_claws/proc/on_crusher_moved(datum/source, atom/old_loc, atom/new_loc)
	SIGNAL_HANDLER
	var/obj/item/kinetic_crusher/crusher = loc
	if(QDELETED(crusher)) return
	var/mob/living/crusher_user = crusher.loc
	if(istype(crusher_user))
		check_and_update_bonuses(source, crusher_user)

/// Determines whether the demon claws should apply their stat bonuses.
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

/// Applies lifesteal on melee hit if enabled.
/obj/item/crusher_trophy/demon_claws/on_melee_hit(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled) return
	user.heal_ordered_damage(bonus_value * 0.1, damage_heal_order)

/// Applies stronger healing on mark detonation if enabled.
/obj/item/crusher_trophy/demon_claws/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled) return
	. = ..()
	user.heal_ordered_damage(bonus_value * 0.4, damage_heal_order)

/// Applies bonus projectile effect if trophy is active.
/obj/item/crusher_trophy/blaster_tubes/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled) return
	. = ..()

/// Summons hierophant trails on mark detonation if active.
/obj/item/crusher_trophy/vortex_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled) return
	. = ..()

/// Applies block bonus when equipped and disables it when removed.
/obj/item/crusher_trophy/gladiator/add_to(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		current_user = user
		RegisterSignal(incomingchance, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_crusher_z_changed))
		if (ismob(incomingchance.loc))
			RegisterSignal(incomingchance.loc, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_crusher_z_changed))
		check_and_update_bonus(incomingchance)

/// Removes the block bonus from the gladiator trophy.
/obj/item/crusher_trophy/gladiator/remove_from(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	if (bonus_applied)
		incomingchance.block_chance -= bonus_value
		bonus_applied = FALSE
	. = ..()
	if(.)
		UnregisterSignal(incomingchance, COMSIG_MOVABLE_Z_CHANGED)
		if (ismob(incomingchance.loc))
			UnregisterSignal(incomingchance.loc, COMSIG_MOVABLE_Z_CHANGED)
		current_user = null

/// Handles bonus recalculation when the crusher moves z-levels.
/obj/item/crusher_trophy/gladiator/proc/on_crusher_z_changed(datum/source, turf/old_turf, turf/new_turf)
	SIGNAL_HANDLER
	var/obj/item/kinetic_crusher/incomingchance = loc
	if (incomingchance)
		check_and_update_bonus(incomingchance)

/// Updates whether the block bonus should be active.
/obj/item/crusher_trophy/gladiator/proc/check_and_update_bonus(obj/item/kinetic_crusher/incomingchance)
	var/should_apply = incomingchance.trophies_enabled
	if (should_apply && !bonus_applied)
		incomingchance.block_chance += bonus_value
		bonus_applied = TRUE
	else if (!should_apply && bonus_applied)
		incomingchance.block_chance -= bonus_value
		bonus_applied = FALSE

// ICE WASTES TROPHIES

/// On-detonation behavior for the ice block talisman.
/obj/item/crusher_trophy/ice_block_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled) return
	. = ..()
