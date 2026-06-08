/datum/status_effect/pregnancy
	id = "pregnancy"
	duration = STATUS_EFFECT_PERMANENT
	tick_interval = 2 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/pregnancy
	remove_on_fullheal = FALSE

	var/pregnancy_flags = PREGNANCY_FLAGS_DEFAULT
	var/pregnancy_progress = 0
	var/pregnancy_stage = 0

/datum/status_effect/pregnancy/Destroy()
	if(owner)
		UnregisterSignal(owner, list(\
			COMSIG_LIVING_DEATH,\
			COMSIG_LIVING_HEALTHSCAN,\
		))
	return ..()

/datum/status_effect/pregnancy/on_creation(mob/living/new_owner, source_data)
	if(istype(source_data, /datum/quirk/mammal_pregnancy))
		var/datum/quirk/mammal_pregnancy/source_quirk = source_data
		inherit_quirk(source_quirk)

	. = ..()
	if(QDELETED(src))
		return

	RegisterSignal(new_owner, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(new_owner, COMSIG_LIVING_HEALTHSCAN, PROC_REF(on_health_scan))

/// Copies runtime settings from the quirk instance that caused this pregnancy.
/datum/status_effect/pregnancy/proc/inherit_quirk(datum/quirk/mammal_pregnancy/source_quirk)
	pregnancy_flags = source_quirk.pregnancy_flags

/// Miscarriage on death; drops the pregnancy status effect entirely.
/datum/status_effect/pregnancy/proc/on_death(datum/source)
	SIGNAL_HANDLER
	qdel(src)

/// Appends pregnancy info to the health analyzer readout unless the pregnancy is cryptic.
/datum/status_effect/pregnancy/proc/on_health_scan(datum/source, list/render_list, advanced, mob/user, mode, tochat)
	SIGNAL_HANDLER

	if(pregnancy_flags & PREGNANCY_FLAG_CRYPTIC)
		return

	if((pregnancy_stage >= PREGNANCY_STAGE_PRESSURE) || advanced)
		render_list += conditional_tooltip("<span class='alert ml-1'>Subject is pregnant[advanced ? " (Stage [pregnancy_stage])" : "."]</span>", "Pregnancy is ongoing until medically ended.", tochat)
	render_list += "<br>"

/datum/status_effect/pregnancy/tick(seconds_between_ticks)
	. = ..()

	pregnancy_progress += (seconds_between_ticks SECONDS)
	var/previous_stage = pregnancy_stage
	if(pregnancy_progress >= PREGNANCY_STAGE_STABLE_TIME)
		pregnancy_stage = PREGNANCY_STAGE_STABLE
	else if(pregnancy_progress >= PREGNANCY_STAGE_SWELL_TIME)
		pregnancy_stage = PREGNANCY_STAGE_SWELL
	else if(pregnancy_progress >= PREGNANCY_STAGE_PRESSURE_TIME)
		pregnancy_stage = PREGNANCY_STAGE_PRESSURE

	if(pregnancy_stage >= PREGNANCY_STAGE_PRESSURE)
		if(previous_stage < PREGNANCY_STAGE_PRESSURE)
			to_chat(owner, span_warning("You can feel some pressure build up against your chest cavity."))
		else if(SPT_PROB(PREGNANCY_KICK_CHANCE, seconds_between_ticks))
			if(pregnancy_flags & PREGNANCY_FLAG_NAUSEA)
				owner.adjust_disgust(PREGNANCY_NAUSEA_DISGUST)
			to_chat(owner, span_warning("Something [pick("squirms", "shakes", "kicks")] inside you."))

	if(pregnancy_stage >= PREGNANCY_STAGE_SWELL)
		if(previous_stage < PREGNANCY_STAGE_SWELL)
			if(pregnancy_flags & PREGNANCY_FLAG_BELLY_INFLATION)
				to_chat(owner, span_warning("Your belly swells as the pregnancy develops."))
		else if(owner.get_stamina_loss() < PREGNANCY_STAMINA_SOFT_CAP)
			owner.adjust_stamina_loss(PREGNANCY_SWELL_STAMINA_PER_SECOND * seconds_between_ticks)

	if(pregnancy_stage >= PREGNANCY_STAGE_STABLE && previous_stage < PREGNANCY_STAGE_STABLE)
		to_chat(owner, span_warning("The pregnancy settles into a steady, persistent weight."))

/atom/movable/screen/alert/status_effect/pregnancy
	name = "Pregnant"
	desc = "Something grows inside you."
	icon = 'modular_nova/modules/pregnancy/icons/screen_alert.dmi'
	icon_state = "baby"
