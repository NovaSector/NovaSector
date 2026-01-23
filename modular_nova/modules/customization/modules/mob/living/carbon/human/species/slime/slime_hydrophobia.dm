/*
* HYDROPHOBIA SPELL
* Makes it so that slimes are waterproof, but slower, and they don't regenerate.
*/
/datum/action/cooldown/slime_hydrophobia
	name = "Toggle Hydrophobia"
	desc = "Develop an oily layer on your outer membrane, repelling water at the cost of lower viscosity and halting regeneration."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_shield"
	background_icon_state = "bg_alien"

	cooldown_time = 1 MINUTES

/datum/action/cooldown/slime_hydrophobia/Activate(mob/living/carbon/human/user = usr)
	. = ..()

	if(user.has_status_effect(/datum/status_effect/slime_hydrophobia))
		slime_hydrophobia_deactivate(user)
		return

	ADD_TRAIT(user, TRAIT_SLIME_HYDROPHOBIA, ACTION_TRAIT)
	user.apply_status_effect(/datum/status_effect/slime_hydrophobia)
	user.visible_message(
		span_purple("[user]'s outer membrane starts to ooze out an oily coating, [owner.p_their()] body becoming more viscous!"),
		span_purple("Your outer membrane starts to ooze out an oily coating, protecting you from water but making your body more viscous.")
		)

/**
* Called when you activate it again after casting the ability-- turning it off, so to say.
*/
/datum/action/cooldown/slime_hydrophobia/proc/slime_hydrophobia_deactivate(mob/living/carbon/human/user)
	if(!user.has_status_effect(/datum/status_effect/slime_hydrophobia))
		return

	REMOVE_TRAIT(user, TRAIT_SLIME_HYDROPHOBIA, ACTION_TRAIT)
	user.remove_status_effect(/datum/status_effect/slime_hydrophobia)
	user.visible_message(
		span_purple("[user]'s outer membrane returns to normal, [owner.p_their()] body drawing the oily coat back inside!"),
		span_purple("Your outer membrane returns to normal, water becoming dangerous to you once again.")
		)

/datum/movespeed_modifier/status_effect/slime_hydrophobia
	multiplicative_slowdown = 1.5

/datum/status_effect/slime_hydrophobia
	id = "slime_hydrophobia"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/slime_hydrophobia/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/slime_hydrophobia, update=TRUE)

/datum/status_effect/slime_hydrophobia/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/slime_hydrophobia, update=TRUE)

/datum/status_effect/slime_hydrophobia/get_examine_text()
	return span_notice("[owner.p_They()] is oozing out an oily coating onto [owner.p_their()] outer membrane, water rolling right off.")
