/datum/psionic_power/levitate
	action_type = /datum/action/cooldown/psionic/levitate

/datum/action/cooldown/psionic/levitate
	name = "Levitate"
	desc = "Toggle a careful psionic weightlessness, building strain while maintained."
	button_icon_state = "psi_levitate"
	cooldown_time = 0
	point_cost = 1
	strain_gain = 0
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	/// TRUE while the psion is actively maintaining levitation.
	var/levitating = FALSE
	/// Strain gained per second while levitation is maintained, before normal strain decay.
	var/levitation_strain_per_second = 3
	/// Fractional strain waiting to be applied.
	var/levitation_strain_buffer = 0

/datum/action/cooldown/psionic/levitate/Remove(mob/living/remove_from)
	if(remove_from)
		clear_levitation(remove_from, TRUE)
	return ..()

/datum/action/cooldown/psionic/levitate/IsAvailable(feedback = FALSE)
	if(is_levitating())
		return TRUE

	return ..()

/datum/action/cooldown/psionic/levitate/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return is_levitating()

/datum/action/cooldown/psionic/levitate/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/living_owner = owner
	if(!istype(living_owner) || !isturf(living_owner.loc))
		return FALSE
	if(living_owner.buckled)
		living_owner.balloon_alert(living_owner, "buckled!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/levitate/Activate(atom/target)
	var/mob/living/living_owner = owner
	if(is_levitating())
		return clear_levitation(living_owner)

	return ..()

/datum/action/cooldown/psionic/levitate/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	levitating = TRUE
	levitation_strain_buffer = 0
	living_owner.AddElement(/datum/element/forced_gravity, gravity = 0, can_override = TRUE)
	ADD_TRAIT(living_owner, TRAIT_SILENT_FOOTSTEPS, PSIONIC_LEVITATION_TRAIT_SOURCE)
	living_owner.set_resting(FALSE, TRUE)
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_levitation_life))
	RegisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_levitation_death))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

	living_owner.visible_message(
		span_notice("[living_owner] rises a handspan above the floor as the air warps around [living_owner.p_them()]."),
		span_purple("You bias gravity around yourself and lift into careful weightlessness."),
	)
	return TRUE

/datum/action/cooldown/psionic/levitate/proc/is_levitating()
	return levitating && istype(owner, /mob/living)

/datum/action/cooldown/psionic/levitate/proc/can_maintain_levitation(mob/living/living_owner, datum/component/psionic_profile/profile)
	if(action_disabled || !istype(living_owner) || !profile)
		return FALSE
	if(living_owner.stat != CONSCIOUS)
		return FALSE
	if(HAS_TRAIT(living_owner, TRAIT_INCAPACITATED) || living_owner.buckled)
		return FALSE
	if(!isturf(living_owner.loc))
		return FALSE
	if(profile.is_burned_out())
		return FALSE

	return living_owner.can_cast_psionics(psionic_flags)

/datum/action/cooldown/psionic/levitate/proc/on_levitation_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	if(!levitating)
		return

	var/mob/living/living_owner = source
	var/datum/component/psionic_profile/profile = living_owner?.get_psionic_profile()
	if(!can_maintain_levitation(living_owner, profile))
		clear_levitation(living_owner)
		return

	levitation_strain_buffer += levitation_strain_per_second * seconds_per_tick
	var/strain_to_gain = FLOOR(levitation_strain_buffer, 1)
	if(strain_to_gain <= 0)
		return

	levitation_strain_buffer -= strain_to_gain
	if(!profile.try_gain_strain(strain_to_gain, src))
		clear_levitation(living_owner)

/datum/action/cooldown/psionic/levitate/proc/on_levitation_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	clear_levitation(living_owner, TRUE)

/datum/action/cooldown/psionic/levitate/proc/clear_levitation(mob/living/living_owner, silent = FALSE)
	if(!levitating)
		return FALSE

	levitating = FALSE
	levitation_strain_buffer = 0
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
		REMOVE_TRAIT(living_owner, TRAIT_SILENT_FOOTSTEPS, PSIONIC_LEVITATION_TRAIT_SOURCE)
		living_owner.RemoveElement(/datum/element/forced_gravity, gravity = 0, can_override = TRUE)
		if(!silent)
			to_chat(living_owner, span_notice("The levitation pattern releases."))
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	return TRUE
