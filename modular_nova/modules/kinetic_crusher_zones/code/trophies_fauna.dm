/*!
 * Contains crusher trophies you can obtain from regular fauna
 */

// Marks this trophy as a fauna trophy so it triggers the lore messages when entering the mining z-level. Cosmetic trophies won't activate this
/obj/item/crusher_trophy
	var/fauna_trophy = FALSE

// LAVALAND TROPHIES
/obj/item/crusher_trophy/watcher_wing
	fauna_trophy = TRUE

/obj/item/crusher_trophy/blaster_tubes/magma_wing
	fauna_trophy = TRUE

/obj/item/crusher_trophy/watcher_wing/ice_wing
	fauna_trophy = TRUE

/obj/item/crusher_trophy/goliath_tentacle
	fauna_trophy = TRUE

/obj/item/crusher_trophy/brimdemon_fang
	fauna_trophy = TRUE

/obj/item/crusher_trophy/legion_skull
	fauna_trophy = TRUE
	//modular edit so that the bonus doesn't apply twice
	var/bonus_currently_applied = FALSE
	var/mob/living/current_user

/obj/item/crusher_trophy/bileworm_spewlet
	fauna_trophy = TRUE

/obj/item/crusher_trophy/lobster_claw
	fauna_trophy = TRUE

/obj/item/crusher_trophy/wolf_ear
	fauna_trophy = TRUE

/obj/item/crusher_trophy/ice_demon_cube
	fauna_trophy = TRUE

/obj/item/crusher_trophy/bear_paw
	fauna_trophy = TRUE

//watcher wing
/obj/item/crusher_trophy/watcher_wing/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()
	
//magmawing watcher
/obj/item/crusher_trophy/blaster_tubes/magma_wing/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()

//icewing watcher
/obj/item/crusher_trophy/watcher_wing/ice_wing/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()

//goliath tentacle
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

//brimdemon fang
/obj/item/crusher_trophy/brimdemon_fang/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()

//legion skull
/obj/item/crusher_trophy/legion_skull/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(.)
		// Apply base penalty
		pkc.charge_time += bonus_value
		current_user = user
		RegisterSignal(pkc, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_crusher_z_changed))
		if(ismob(pkc.loc))
			RegisterSignal(pkc.loc, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_crusher_z_changed))
		check_and_update_bonus(pkc, user)

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	// If speed bonus is currently active, remove it before calling parent otherwise it will duplicate apply, increasing the recharge cooldown for the crusher
	if(bonus_currently_applied)
		pkc.charge_time += bonus_value
		bonus_currently_applied = FALSE
	. = ..()
	if(.)
		pkc.charge_time -= bonus_value
		UnregisterSignal(pkc, COMSIG_MOVABLE_Z_CHANGED)
		if(ismob(pkc.loc))
			UnregisterSignal(pkc.loc, COMSIG_MOVABLE_Z_CHANGED)
		current_user = null

/obj/item/crusher_trophy/legion_skull/proc/on_crusher_z_changed(datum/source, turf/old_turf, turf/new_turf)
	SIGNAL_HANDLER
	var/obj/item/kinetic_crusher/pkc = loc
	if(pkc)
		check_and_update_bonus(pkc, current_user)

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

//bileworm spewlet
/obj/item/crusher_trophy/bileworm_spewlet/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	return ..()

/obj/item/crusher_trophy/bileworm_spewlet/on_projectile_hit_mineral(turf/closed/mineral, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		// can't break a large amount of rocks with the spewlet on station like tram
		return

	for(var/turf/closed/mineral/mineral_turf in RANGE_TURFS(1, mineral) - mineral)
		mineral_turf.gets_drilled(user, 1)

//lobster claw
/obj/item/crusher_trophy/lobster_claw/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()

// ICE WASTES TROPHIES


// demonic watcher
/obj/item/crusher_trophy/ice_demon_cube/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()
	if(isnull(target) || !COOLDOWN_FINISHED(src, summon_cooldown))
		return

// Wolf
/obj/item/crusher_trophy/wolf_ear/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()

// Polar bear
/obj/item/crusher_trophy/bear_paw/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return

	. = ..()
