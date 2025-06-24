/*!
 * Contains crusher trophies you can obtain from regular fauna
 */

// Marks this trophy as triggering lore messages when entering a special mining z-level
/obj/item/crusher_trophy
	/// Whether this trophy triggers lore messages when equipped in specific environments.
	var/trophy_triggers_lore = FALSE

// LAVALAND TROPHIES
/obj/item/crusher_trophy/watcher_wing
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/blaster_tubes/magma_wing
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/watcher_wing/ice_wing
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/goliath_tentacle
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/brimdemon_fang
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/legion_skull
	trophy_triggers_lore = TRUE
	/// Tracks whether the active bonus from this trophy is currently applied to the crusher.
	var/bonus_currently_applied = FALSE
	/// Cached reference to the mob who attached the trophy. Used for bonus recalculations.
	var/mob/living/current_user

/obj/item/crusher_trophy/bileworm_spewlet
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/lobster_claw
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/wolf_ear
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/ice_demon_cube
	trophy_triggers_lore = TRUE

/obj/item/crusher_trophy/bear_paw
	trophy_triggers_lore = TRUE

// Watcher wing
/obj/item/crusher_trophy/watcher_wing/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()

// Magmawing watcher
/obj/item/crusher_trophy/blaster_tubes/magma_wing/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()

// Icewing watcher
/obj/item/crusher_trophy/watcher_wing/ice_wing/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()

// Goliath tentacle
/obj/item/crusher_trophy/goliath_tentacle/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()
	var/missing_health = user.maxHealth - user.health
	missing_health *= missing_health_ratio
	missing_health *= bonus_value
	if(missing_health > 0)
		target.adjustBruteLoss(missing_health)

// Brimdemon fang
/obj/item/crusher_trophy/brimdemon_fang/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()

// Legion skull
/obj/item/crusher_trophy/legion_skull/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(.)
		// Apply base penalty
		pkc.charge_time += bonus_value
		current_user = user
		check_and_update_bonus(pkc, user)

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	// If speed bonus is currently active, remove it before calling parent otherwise it will duplicate apply, increasing the recharge cooldown for the crusher
	if(bonus_currently_applied)
		pkc.charge_time += bonus_value
		bonus_currently_applied = FALSE
	. = ..()
	if(.)
		pkc.charge_time -= bonus_value
		current_user = null

/obj/item/crusher_trophy/legion_skull/proc/check_and_update_bonus(obj/item/kinetic_crusher/pkc, mob/living/user)
	var/should_have_bonus = pkc.trophies_enabled

	if(should_have_bonus && !bonus_currently_applied)
		// Apply bonus - make crusher faster
		pkc.charge_time -= bonus_value
		bonus_currently_applied = TRUE
	else if(!should_have_bonus && bonus_currently_applied)
		// Remove bonus - return to normal speed
		pkc.charge_time += bonus_value
		bonus_currently_applied = FALSE

// Bileworm spewlet
/obj/item/crusher_trophy/bileworm_spewlet/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()

/obj/item/crusher_trophy/bileworm_spewlet/on_projectile_hit_mineral(turf/closed/mineral, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		// Can't break a large amount of rocks with the spewlet on station like tram
		return

	for(var/turf/closed/mineral/mineral_turf in RANGE_TURFS(1, mineral) - mineral)
		mineral_turf.gets_drilled(user, 1)

// Lobster claw
/obj/item/crusher_trophy/lobster_claw/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()
