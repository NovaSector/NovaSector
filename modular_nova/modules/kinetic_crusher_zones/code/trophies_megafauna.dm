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
	trophy_triggers_lore = TRUE //Still leaving this here because it still needs to check to trigger lore

// ICE WASTE TROPHIES
/obj/item/crusher_trophy/ice_block_talisman
	trophy_triggers_lore = TRUE

//blood drunk
/// Gives the user 90% damage reduction on mark based on z-level
/obj/item/crusher_trophy/miner_eye/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	return ..()

//tail spike
/// Damages on mark detonation which requires trophy bonuses to be active.
/obj/item/crusher_trophy/tail_spike/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	return ..()

//demon claws
/// Applies stat bonuses when demon claws are added to the crusher.
/obj/item/crusher_trophy/demon_claws/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(!.)
		return
	check_and_update_bonus(pkc)

/// Removes stat bonuses from demon claws.
/obj/item/crusher_trophy/demon_claws/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	if(stat_bonuses_applied)
		pkc.force_wielded -= bonus_value * 0.2
		pkc.detonation_damage -= bonus_value * 0.8
		pkc.update_wielding()
		stat_bonuses_applied = FALSE
	return ..()

/// Determines whether the demon claws should apply their stat bonuses.
/obj/item/crusher_trophy/demon_claws/check_and_update_bonus(obj/item/kinetic_crusher/target_crusher)
	var/should_have_bonuses = target_crusher.trophies_enabled //Whether the bonuses apply (heal, bonus damage,) when something is hit/detonated by the crusher.
	if(should_have_bonuses && !stat_bonuses_applied)
		target_crusher.force_wielded += bonus_value * 0.2
		target_crusher.detonation_damage += bonus_value * 0.8
		target_crusher.update_wielding()
		stat_bonuses_applied = TRUE
	else if(!should_have_bonuses && stat_bonuses_applied)
		target_crusher.force_wielded -= bonus_value * 0.2
		target_crusher.detonation_damage -= bonus_value * 0.8
		target_crusher.update_wielding()
		stat_bonuses_applied = FALSE

/// Applies lifesteal on melee hit if enabled.
/obj/item/crusher_trophy/demon_claws/on_melee_hit(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	return ..()

/// Applies stronger healing on mark detonation if enabled.
/obj/item/crusher_trophy/demon_claws/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	return ..()

//blaster tubes
/// Applies bonus projectile effect if trophy is active.
/obj/item/crusher_trophy/blaster_tubes/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	return ..()

//hierophant talisman
/// Summons hierophant trails on mark detonation if active.
/obj/item/crusher_trophy/vortex_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	return ..()

// ICE WASTES TROPHIES

//demonic frost miner
/// On-detonation behavior for the ice block talisman.
/obj/item/crusher_trophy/ice_block_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	return ..()
