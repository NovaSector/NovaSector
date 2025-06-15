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
		pkc.charge_time += bonus_value
		RegisterSignal(pkc, COMSIG_MOVABLE_MOVED, PROC_REF(on_crusher_movement))
		check_and_update_bonus(pkc, user)

/obj/item/crusher_trophy/legion_skull/remove_from(obj/item/kinetic_crusher/pkc, mob/living/user)
	if(bonus_currently_applied)

		pkc.charge_time += bonus_value
		bonus_currently_applied = FALSE

	. = ..()
	if(.)
		UnregisterSignal(pkc, COMSIG_MOVABLE_MOVED)
		current_user = null

/obj/item/crusher_trophy/legion_skull/proc/on_crusher_movement(datum/source, atom/old_loc, atom/new_loc)
	SIGNAL_HANDLER
	var/turf/old_turf = get_turf(old_loc)
	var/turf/new_turf = get_turf(new_loc)

	if(!old_turf || !new_turf || old_turf.z == new_turf.z)
		return

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
		if(user)
			to_chat(user, span_notice("[src.name] responds to lavaland's environment!"))
	else if(!should_have_bonus && bonus_currently_applied)
		// Remove bonus
		pkc.charge_time += bonus_value
		bonus_currently_applied = FALSE
		if(user)  //
			to_chat(user, span_warning("[src.name] feels inert away from lavaland."))
