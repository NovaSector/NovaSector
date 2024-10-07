// Same as /mob/living/basic/living_limb_flesh but in radius
/datum/artifact_effect/bodyhorror
	log_name = "bodyswap"
	type_name = ARTIFACT_EFFECT_ORGANIC

/datum/artifact_effect/bodyhorror/New()
	. = ..()
	release_method = ARTIFACT_EFFECT_PULSE
	range = rand(2,5)

/datum/artifact_effect/bodyhorror/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	mutatelimbs(0)

/datum/artifact_effect/bodyhorror/do_effect_destroy()
	mutatelimbs(5)

/**
 * Tries to replace every mob's limbs with living flesh mob in artifact range.
 *
 * Arguments:
 * * add_range - bonus range to the base artifact's
 */
/datum/artifact_effect/bodyhorror/proc/mutatelimbs(add_range)
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/carbon_mob in range(range + add_range, curr_turf))
		var/weakness = get_anomaly_protection(carbon_mob)
		if(weakness <= 0.5 || carbon_mob.stat == DEAD || HAS_TRAIT(carbon_mob, TRAIT_NODISMEMBER))
			continue

		var/list/zone_candidates = carbon_mob.get_missing_limbs()
		for(var/obj/item/bodypart/bodypart in carbon_mob.bodyparts)
			if(bodypart.body_zone == BODY_ZONE_HEAD || bodypart.body_zone == BODY_ZONE_CHEST)
				continue
			if(HAS_TRAIT(bodypart, TRAIT_IGNORED_BY_LIVING_FLESH))
				continue
			if(bodypart.bodypart_flags & BODYPART_UNREMOVABLE)
				continue
			zone_candidates += bodypart.body_zone

		if(!length(zone_candidates))
			continue

		var/target_zone = pick(zone_candidates)
		var/obj/item/bodypart/target_part = carbon_mob.get_bodypart(target_zone)
		if(isnull(target_part))
			carbon_mob.emote("scream") // dismember already makes them scream so only do this if we aren't doing that
		else
			target_part.dismember()

		var/part_type
		switch(target_zone)
			if(BODY_ZONE_L_ARM)
				part_type = /obj/item/bodypart/arm/left/flesh
			if(BODY_ZONE_R_ARM)
				part_type = /obj/item/bodypart/arm/right/flesh
			if(BODY_ZONE_L_LEG)
				part_type = /obj/item/bodypart/leg/left/flesh
			if(BODY_ZONE_R_LEG)
				part_type = /obj/item/bodypart/leg/right/flesh

		carbon_mob.visible_message(
			span_danger("[carbon_mob][carbon_mob.p_s()] limb suddenly swells and rips apart, revealing brand new red bloody flesh!"),
			span_bolddanger("Your limb suddenly swells and rips apart, revealing brand new red bloody flesh!"),
			blind_message = span_hear("You hear gore sounds, like someone is tearing up flesh and breaking bones."),
		)
		var/obj/item/bodypart/new_bodypart = new part_type()
		var/mob/living/basic/living_limb_flesh/parasite = new /mob/living/basic/living_limb_flesh
		parasite.forceMove(new_bodypart)
		new_bodypart.replace_limb(carbon_mob, TRUE)
		parasite.register_to_limb(new_bodypart)
		return TRUE

