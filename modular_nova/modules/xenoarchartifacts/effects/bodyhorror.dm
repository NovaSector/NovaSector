// Same as /mob/living/basic/living_limb_flesh but in radius
/datum/artifact_effect/bodyhorror
	log_name = "bodyswap"
	type_name = ARTIFACT_EFFECT_ORGANIC

/datum/artifact_effect/bodyhorror/New()
	..()
	release_method = ARTIFACT_EFFECT_PULSE
	range = rand(2,5)

/datum/artifact_effect/bodyhorror/DoEffectPulse()
	. = ..()
	if(!.)
		return
	mutatelimbs(0)

/datum/artifact_effect/bodyhorror/DoEffectDestroy()
	mutatelimbs(5)

/datum/artifact_effect/bodyhorror/proc/mutatelimbs(add_range)
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/Hooman in range(range + add_range, curr_turf))
		var/weakness = get_anomaly_protection(Hooman)
		if(weakness <= 0.5 || Hooman.stat == DEAD || HAS_TRAIT(Hooman, TRAIT_NODISMEMBER))
			continue

		var/list/zone_candidates = Hooman.get_missing_limbs()
		for(var/obj/item/bodypart/bodypart in Hooman.bodyparts)
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
		var/obj/item/bodypart/target_part = Hooman.get_bodypart(target_zone)
		if(isnull(target_part))
			Hooman.emote("scream") // dismember already makes them scream so only do this if we aren't doing that
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

		Hooman.visible_message(span_danger("[Hooman][Hooman.p_s()] limb suddenly swells and rips apart, revealing a brand new red bloody flesh!"))
		var/obj/item/bodypart/new_bodypart = new part_type()
		var/mob/living/basic/living_limb_flesh/parasite = new /mob/living/basic/living_limb_flesh
		parasite.forceMove(new_bodypart)
		new_bodypart.replace_limb(Hooman, TRUE)
		parasite.register_to_limb(new_bodypart)
		return TRUE


