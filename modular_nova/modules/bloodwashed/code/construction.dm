/obj/item/melee/blood_magic/construction/examine(mob/user)
	. = ..()
	. += "Guns into profane weapons that fire burning, blood-touched projectiles."

/obj/item/melee/blood_magic/construction/cast_spell(atom/target, mob/living/carbon/user)
	if(istype(target, /obj/item/gun))
		if(channeling)
			to_chat(user, span_cult_italic("You are already invoking twisted construction!"))
			return

		var/obj/item/gun/candidate = target
		if(candidate.GetComponent(/datum/component/bloodwashed_corrupted_gun))
			to_chat(user, span_warning("[candidate] has already been twisted by blood magic!"))
			return

		channeling = TRUE
		var/turf/candidate_turf = get_turf(candidate)
		user.visible_message(span_danger("A dark cloud emanates from [user]'s hand and swirls around [candidate]!"))
		playsound(candidate_turf, 'sound/machines/airlock/airlock_alien_prying.ogg', 80, TRUE)
		var/previous_color = candidate.color
		candidate.color = COLOR_BLACK
		if(!do_after(user, 5 SECONDS, target = candidate))
			channeling = FALSE
			if(!QDELETED(candidate))
				candidate.color = previous_color
			return

		channeling = FALSE
		if(QDELETED(candidate))
			return
		candidate.color = previous_color
		if(candidate.GetComponent(/datum/component/bloodwashed_corrupted_gun))
			to_chat(user, span_warning("[candidate] has already been twisted by blood magic!"))
			return

		candidate.AddComponent(/datum/component/bloodwashed_corrupted_gun)
		candidate.update_appearance(UPDATE_OVERLAYS)
		uses--
		user.visible_message(
			span_warning("A dark cloud writhes from [user]'s hand and sinks into [candidate]!"),
			span_cult_italic("You twist [candidate] into a profane weapon."),
		)
		SEND_SOUND(user, sound('sound/effects/magic.ogg', FALSE, 0, 25))
		if(invocation)
			user.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
		if(health_cost)
			var/target_arm = user.active_hand_index == 1 ? BODY_ZONE_L_ARM : BODY_ZONE_R_ARM
			user.apply_damage(health_cost, BRUTE, target_arm, wound_bonus = CANT_WOUND)
		qdel(src)
		return TRUE

	return ..()
