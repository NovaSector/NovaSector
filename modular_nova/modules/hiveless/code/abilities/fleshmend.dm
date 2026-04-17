/// Applies the fleshmend heal-over-time status effect.
/datum/action/cooldown/spell/hiveless/fleshmend
	name = "Fleshmend"
	desc = "Trigger a rapid heal-over-time that mends burns, bruises, and breath. Costs protein."
	button_icon_state = "fleshmend"
	cooldown_time = 20 SECONDS
	protein_cost = HIVELESS_COST_FLESHMEND
	disabled_by_fire = FALSE

/datum/action/cooldown/spell/hiveless/fleshmend/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/user = owner
	if(!isliving(user))
		return FALSE
	if(user.has_status_effect(/datum/status_effect/fleshmend))
		if(feedback)
			user.balloon_alert(user, "already fleshmending!")
		return FALSE
	return TRUE

/datum/action/cooldown/spell/hiveless/fleshmend/cast(atom/cast_on)
	. = ..()
	var/mob/living/user = owner
	if(!isliving(user))
		return FALSE
	if(!spend_protein())
		return FALSE
	to_chat(user, span_notice("We begin to heal rapidly."))
	user.apply_status_effect(/datum/status_effect/fleshmend)
	return TRUE
