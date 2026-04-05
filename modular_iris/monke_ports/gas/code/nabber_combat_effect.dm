/*
#define NABBER_THREAT_ICON 'modular_iris/monke_ports/gas/icons/effects.dmi'
#define NABBER_THREAT_ICON_STATE "nabber_threat"
/datum/status_effect/nabber_combat
	id = "Nabber combat"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE
	tick_interval = -1
	var/image/nabber_image
/datum/status_effect/nabber_combat/on_apply()
	var/mob/living/carbon/human/color_source = owner
	nabber_image = image(NABBER_THREAT_ICON, owner, NABBER_THREAT_ICON_STATE, dir = owner.dir)
	nabber_image.override = TRUE
	nabber_image.alpha = 0
	nabber_image.color = color_source.dna.features["mcolor"]
	animate(nabber_image, alpha = 255, 0.2 SECONDS)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/nabber_combat)
	owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/everyone, id, nabber_image)
	if(owner.body_position == LYING_DOWN)
		nabber_image.transform = turn(nabber_image.transform, 90)
	RegisterSignal(owner, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_dir_change))
	RegisterSignal(owner, COMSIG_LIVING_SET_BODY_POSITION, PROC_REF(on_body_position_change))
	return TRUE
/datum/status_effect/nabber_combat/on_remove()
	owner.remove_alt_appearance(id)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/nabber_combat)
	QDEL_NULL(nabber_image)
	UnregisterSignal(owner, list(
		COMSIG_ATOM_DIR_CHANGE,
		COMSIG_LIVING_SET_BODY_POSITION
	))
/datum/status_effect/nabber_combat/proc/on_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	nabber_image.dir = new_dir
/datum/status_effect/nabber_combat/proc/on_body_position_change(datum/source, new_value, old_value)
	SIGNAL_HANDLER
	if(new_value == LYING_DOWN)
		nabber_image.transform = turn(nabber_image.transform, 90)
	else
		nabber_image.transform = turn(nabber_image.transform, -90)
/datum/status_effect/nabber_combat/Destroy() //absolutely ensure we're harddelling here
	. = ..()
	QDEL_NULL(nabber_image)
	UnregisterSignal(owner, list(
		COMSIG_ATOM_DIR_CHANGE,
		COMSIG_LIVING_SET_BODY_POSITION
	))
/datum/movespeed_modifier/nabber_combat
	blacklisted_movetypes = FLYING
	multiplicative_slowdown = -0.25
#undef NABBER_THREAT_ICON
#undef NABBER_THREAT_ICON_STATE
*/
