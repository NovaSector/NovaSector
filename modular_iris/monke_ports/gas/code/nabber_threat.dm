//needs a complete resprite and replace meth speed with something else
/*
/datum/action/cooldown/nabber_threat
	name = "Toggle threat"
	desc = "Strengthen your chitin by coloring it with a battle color. Gaining extra speed!"
	cooldown_time = 10 SECONDS
	button_icon = 'modular_iris/monke_ports/gas/icons/actions.dmi'
	var/active = FALSE
/datum/action/cooldown/nabber_threat/New(Target, original)
	. = ..()
	button_icon_state = "nabber_threat_off"
/datum/action/cooldown/nabber_threat/Destroy()
	. = ..()
	if(active)
		remove_effect()
/datum/action/cooldown/nabber_threat/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/nabber = owner
	if(!nabber)
		return	FALSE
	if(isdead(nabber) || nabber.incapacitated)
		nabber.balloon_alert(nabber, "Incapacitated!")
		return FALSE
	if(nabber.on_fire)
		nabber.balloon_alert(nabber, "On fire!")
		return	FALSE
	if(nabber.alpha < 255)
		nabber.balloon_alert(nabber, "Can't now!")
		return	FALSE
	if(active)
		remove_effect()
		return TRUE
	RegisterSignal(owner, COMSIG_HUMAN_BURNING, PROC_REF(on_fire))
	RegisterSignal(owner, COMSIG_LIVING_STATUS_INCAPACITATE, PROC_REF(on_incapacitated))
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	apply_effect()
	return TRUE
/datum/action/cooldown/nabber_threat/proc/apply_effect()
	var/mob/living/carbon/human/nabber = owner
	nabber.visible_message(span_warning("[nabber] makes its chitin shimmer colorfully. Emitting threat."), span_notice("You made your chitin, hostile shimmer!"), span_hear("You hear a low hiss."))
	nabber.balloon_alert(nabber, "Threat on!")
	nabber.apply_status_effect(/datum/status_effect/nabber_combat)
	button_icon_state = "nabber_threat_on"
	nabber.update_action_buttons()
	active = TRUE
	return TRUE
/datum/action/cooldown/nabber_threat/proc/remove_effect(force = FALSE)
	var/mob/living/carbon/human/nabber = owner
	nabber.visible_message(span_notice("[nabber] becoming normal. Shimmering chitin, back to normal."), span_notice("You've got your chitin back to normal."), span_hear("You hear a low hiss."))
	if(force == TRUE)
		nabber.Stun(2 SECONDS)
	nabber.balloon_alert(nabber, "Threat off!")
	nabber.remove_status_effect(/datum/status_effect/nabber_combat)
	button_icon_state = "nabber_threat_off"
	nabber.update_action_buttons()
	active = FALSE
	UnregisterSignal(owner, list(COMSIG_HUMAN_BURNING, COMSIG_LIVING_STATUS_INCAPACITATE, COMSIG_LIVING_DEATH))
	return TRUE
/datum/action/cooldown/nabber_threat/proc/on_fire()
	SIGNAL_HANDLER
	owner.balloon_alert(owner, "On fire!")
	return remove_effect(force = TRUE)
/datum/action/cooldown/nabber_threat/proc/on_incapacitated()
	SIGNAL_HANDLER
	owner.balloon_alert(owner, "Incapacitated!")
	return remove_effect(force = TRUE)
/datum/action/cooldown/nabber_threat/proc/on_death()
	SIGNAL_HANDLER
	return remove_effect(force = TRUE)
*/
