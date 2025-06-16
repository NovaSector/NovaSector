//brimdemon fang
/obj/item/crusher_trophy/brimdemon_fang/on_mark_detonation(mob/living/target, mob/living/user)
	// Check if we're on lavaland
	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return

	var/datum/space_level/level = SSmapping.z_list[current_turf.z]

	// Only work on ztrait_lava_ruins
	if(!level || !(ZTRAIT_LAVA_RUINS in level.traits))
		to_chat(user, span_warning("[src.name] feels inert here - it only responds to the hostile environment of lavaland."))
		return

	// Original effect
	. = ..()
	playsound(target, 'sound/mobs/non-humanoids/brimdemon/brimdemon_crush.ogg', 100)

/obj/item/crusher_trophy/brimdemon_fang/effect_desc()
	return "mark detonation to create visual and audiosensory effects at the target (only on lavaland)"

//legion skull
/obj/item/crusher_trophy/legion_skull
	var/bonus_currently_applied = FALSE
	var/mob/living/current_user

/obj/item/crusher_trophy/legion_skull/add_to(obj/item/kinetic_crusher/pkc, mob/living/user)
	. = ..()
	if(.)
		current_user = user
		RegisterSignal(pkc, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_crusher_z_change))
		check_and_update_bonus(pkc, user)
		// DON'T apply bonus here - let check_and_update_bonus handle it conditionally

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	if(bonus_currently_applied)
		pkc.charge_time += bonus_value
		bonus_currently_applied = FALSE

	. = ..()
	if(.)
		UnregisterSignal(pkc, COMSIG_MOVABLE_Z_CHANGED)
		current_user = null
		// DON'T remove bonus here - we already handled it above

/obj/item/crusher_trophy/legion_skull/proc/on_crusher_z_change(datum/source, atom/old_loc, atom/new_loc)
	SIGNAL_HANDLER
	check_and_update_bonus(source, current_user)

/obj/item/crusher_trophy/legion_skull/proc/check_and_update_bonus(obj/item/kinetic_crusher/pkc, mob/living/user)
	var/turf/current_turf = get_turf(pkc)
	if(!current_turf)
		return

	var/datum/space_level/level = SSmapping.z_list[current_turf.z]
	var/should_have_bonus = level && (ZTRAIT_LAVA_RUINS in level.traits)

	if(should_have_bonus && !bonus_currently_applied)
		// Apply bonus
		pkc.charge_time -= bonus_value
		bonus_currently_applied = TRUE
	else if(!should_have_bonus && bonus_currently_applied)
		// Remove bonus
		pkc.charge_time += bonus_value
		bonus_currently_applied = FALSE

// Bileworm spewlet
/obj/item/crusher_trophy/bileworm_spewlet
	var/mob/living/current_user

/obj/item/crusher_trophy/bileworm_spewlet/add_to(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	if(.)
		current_user = user
		crusher.add_item_action(ability)
		RegisterSignal(crusher, COMSIG_MOVABLE_MOVED, PROC_REF(on_crusher_movement))

/obj/item/crusher_trophy/bileworm_spewlet/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	crusher.remove_item_action(ability)
	UnregisterSignal(crusher, COMSIG_MOVABLE_MOVED)
	current_user = null

/obj/item/crusher_trophy/bileworm_spewlet/proc/on_crusher_movement(datum/source, atom/old_loc, atom/new_loc)
	SIGNAL_HANDLER
	var/turf/old_turf = get_turf(old_loc)
	var/turf/new_turf = get_turf(new_loc)

	if(!old_turf || !new_turf || old_turf.z == new_turf.z)
		return

/obj/item/crusher_trophy/bileworm_spewlet/on_mark_detonation(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	. = ..()
	ability.InterceptClickOn(user, null, target)

/obj/item/crusher_trophy/bileworm_spewlet/on_projectile_hit_mineral(turf/closed/mineral, mob/living/user)
	var/obj/item/kinetic_crusher/crusher = loc
	if(!crusher?.trophies_enabled)
		return
	for(var/turf/closed/mineral/mineral_turf in RANGE_TURFS(1, mineral) - mineral)
		mineral_turf.gets_drilled(user, 1)
