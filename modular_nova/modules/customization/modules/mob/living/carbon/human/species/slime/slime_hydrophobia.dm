///////
/// HYDROPHOBIA TOGGLE
/// Makes it so that slimes are waterproof, but slower, and they don't regenerate.

/datum/action/cooldown/slime_hydrophobia
	name = "Toggle Hydrophobia"
	desc = "Develop an oily layer on your outer membrane, repelling water at the cost of lower viscosity and halting regeneration."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_shield"
	background_icon_state = "bg_alien"

	cooldown_time = 1 MINUTES

/datum/action/cooldown/slime_hydrophobia/Remove(mob/living/remove_from) // If we lose the spell make sure to remove its effects
	. = ..()
	remove_from.remove_status_effect(/datum/status_effect/slime_hydrophobia)

/datum/action/cooldown/slime_hydrophobia/Activate()
	. = ..()
	var/mob/living/carbon/human/user = owner
	if(!ishuman(user))
		CRASH("Non-human somehow had [name] action")

	if(user.has_status_effect(/datum/status_effect/slime_hydrophobia))
		user.remove_status_effect(/datum/status_effect/slime_hydrophobia)
	else
		user.apply_status_effect(/datum/status_effect/slime_hydrophobia)

/datum/action/cooldown/slime_hydrophobia/proc/slime_hydrophobia_deactivate(mob/living/carbon/human/user)
	user.remove_status_effect(/datum/status_effect/slime_hydrophobia)

/datum/movespeed_modifier/status_effect/slime_hydrophobia
	multiplicative_slowdown = 1.5

/datum/status_effect/slime_hydrophobia
	id = "slime_hydrophobia"
	tick_interval = STATUS_EFFECT_NO_TICK
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null

/datum/status_effect/slime_hydrophobia/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/slime_hydrophobia, update = TRUE)
	ADD_TRAIT(owner, TRAIT_SLIME_HYDROPHOBIA, TRAIT_STATUS_EFFECT(id))
	owner.visible_message(
		span_purple("[owner]'s outer membrane starts to ooze out an oily coating, [owner.p_their()] body becoming more viscous!"),
		span_purple("Your outer membrane starts to ooze out an oily coating, protecting you from water but making your body more viscous.")
	)
	owner.balloon_alert_to_viewers("starts oozing a hydrophobic coating!")
	return TRUE

/datum/status_effect/slime_hydrophobia/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/slime_hydrophobia, update = TRUE)
	REMOVE_TRAIT(owner, TRAIT_SLIME_HYDROPHOBIA, TRAIT_STATUS_EFFECT(id))
	owner.visible_message(
		span_purple("[owner]'s outer membrane returns to normal, [owner.p_their()] body drawing the oily coat back inside!"),
		span_purple("Your outer membrane returns to normal, water being dangerous to you again.")
	)
	owner.balloon_alert_to_viewers("hydrophobic coating dispelled")

/datum/status_effect/slime_hydrophobia/get_examine_text()
	return span_purple("[owner.p_They()] [owner.p_are()] oozing out an oily coating onto [owner.p_their()] outer membrane, water rolling right off.")
