/obj/item/melee/blood_magic/construction/examine(mob/user)
	. = ..()
	. += "Guns into profane weapons that fire burning, blood-touched projectiles."

/obj/item/melee/blood_magic/construction/cast_spell(atom/target, mob/living/carbon/user)
	if(istype(target, /obj/item/gun))
		var/obj/item/gun/candidate = target
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
		return ..()

	return ..()
