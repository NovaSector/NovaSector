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

	return ..()

// Icewing watcher
/obj/item/crusher_trophy/watcher_wing/ice_wing/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return  ..()

// Goliath tentacle
/obj/item/crusher_trophy/goliath_tentacle/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()

// Brimdemon fang
/obj/item/crusher_trophy/brimdemon_fang/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()

// Legion skull
/obj/item/crusher_trophy/legion_skull/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(.)
		pkc.charge_time += bonus_value
		check_and_update_bonus(pkc)

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	if(bonus_currently_applied)
		pkc.charge_time += bonus_value
		bonus_currently_applied = FALSE
	. = ..()
	if(.)
		pkc.charge_time -= bonus_value

/obj/item/crusher_trophy/legion_skull/check_and_update_bonus(obj/item/kinetic_crusher/target_crusher)
	var/should_have_bonus = target_crusher.trophies_enabled

	if(should_have_bonus && !bonus_currently_applied)
		target_crusher.charge_time -= bonus_value
		bonus_currently_applied = TRUE
	else if(!should_have_bonus && bonus_currently_applied)
		target_crusher.charge_time += bonus_value
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

	return ..()

// ICE WASTES TROPHIES

// demonic watcher
/obj/item/crusher_trophy/ice_demon_cube/on_mark_detonation(mob/living/target, mob/living/user)
	if(isnull(target) || !COOLDOWN_FINISHED(src, summon_cooldown))
		return

	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()

// Wolf
/obj/item/crusher_trophy/wolf_ear/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()

// Polar bear
/obj/item/crusher_trophy/bear_paw/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()
