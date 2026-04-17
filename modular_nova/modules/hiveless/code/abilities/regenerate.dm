/// Regrows missing limbs after a 3-second do_after.
/datum/action/cooldown/spell/hiveless/regenerate
	name = "Knit Flesh"
	desc = "Regrow any missing limbs in a slow, visible ritual. Costs protein."
	button_icon_state = "regenerate"
	cooldown_time = 15 SECONDS
	protein_cost = HIVELESS_COST_REGEN

/datum/action/cooldown/spell/hiveless/regenerate/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/user = owner
	if(!iscarbon(user))
		return FALSE
	var/list/missing = user.get_missing_limbs()
	if(!length(missing))
		user.balloon_alert(user, "nothing missing!")
		return FALSE
	user.visible_message(
		span_warning("[user]'s flesh bubbles and strains as [user.p_they()] begin[user.p_s()] regrowing missing limbs."),
		span_notice("We anchor ourselves and begin weaving replacement limbs. Hold still."),
	)
	if(!do_after(user, 3 SECONDS, target = user, timed_action_flags = IGNORE_HELD_ITEM))
		user.balloon_alert(user, "regrowth interrupted!")
		return FALSE
	if(!spend_protein())
		return FALSE
	for(var/zone in missing)
		user.regenerate_limb(zone)
	spray_cast_blood(user)
	playsound(user, 'sound/effects/blob/blobattack.ogg', 40, TRUE)
	user.visible_message(
		span_warning("[user]'s limbs reform with a wet crunch!"),
		span_userdanger("Your limbs regrow, and it hurts like hell!"),
		span_hear("You hear organic matter tearing and reweaving itself."),
	)
	user.emote("gasp")
	return TRUE
