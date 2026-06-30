/datum/psionic_power/levitate
	action_type = /datum/action/cooldown/psionic/levitate

/datum/psionic_rank_variant/levitate
	rank = PSIONIC_RANK_EPSILON
	variant_name = "levitation"
	description = "A maintained lift that lets you float above the floor."
	block_charge_cost = 0
	/// If TRUE, this form allows controlled movement while weightless.
	var/grants_free_float = FALSE

/datum/psionic_rank_variant/levitate/delta
	rank = PSIONIC_RANK_DELTA
	variant_name = "controlled levitation"
	description = "A maintained lift that lets you float above the floor and move freely."
	active_strain_gain_per_second = 5
	grants_free_float = TRUE

/datum/action/cooldown/psionic/levitate
	name = "Levitate"
	desc = "Lift yourself off the ground, building strain while maintained."
	button_icon_state = "psi_levitate"
	cooldown_time = 0
	point_cost = 1
	strain_gain = 0
	active_strain_gain_per_second = 3
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	rank_variant_types = list(
		/datum/psionic_rank_variant/levitate,
		/datum/psionic_rank_variant/levitate/delta,
	)
	/// TRUE while the psion is actively maintaining levitation.
	var/levitating = FALSE

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

	var/datum/psionic_rank_variant/levitate/form = get_levitation_form()
	if(!form)
		return FALSE

	levitating = TRUE
	living_owner.AddElement(/datum/element/forced_gravity, gravity = 0, can_override = TRUE)
	ADD_TRAIT(living_owner, TRAIT_SILENT_FOOTSTEPS, PSIONIC_LEVITATION_TRAIT_SOURCE)
	apply_levitation_form(living_owner, form)
	living_owner.set_resting(FALSE, TRUE)
	RegisterSignal(living_owner, COMSIG_LIVING_LIFE, PROC_REF(on_levitation_life))
	RegisterSignal(living_owner, COMSIG_LIVING_DEATH, PROC_REF(on_levitation_death))
	build_all_button_icons(UPDATE_BUTTON_STATUS)

	living_owner.visible_message(
		span_notice("[living_owner] rises slightly off the floor."),
		span_purple("You lift yourself off the ground."),
	)
	return TRUE

/datum/action/cooldown/psionic/levitate/on_rank_variant_selected(mob/living/living_owner, datum/psionic_rank_variant/variant)
	. = ..()
	if(!is_levitating())
		return
	if(!istype(variant, /datum/psionic_rank_variant/levitate))
		return

	var/datum/psionic_rank_variant/levitate/levitation_form = variant
	apply_levitation_form(living_owner, levitation_form)

/datum/action/cooldown/psionic/levitate/proc/is_levitating()
	return levitating && istype(owner, /mob/living)

/datum/action/cooldown/psionic/levitate/proc/get_levitation_form()
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return null

	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	var/datum/psionic_rank_variant/selected_variant = get_selected_rank_variant(profile)
	if(istype(selected_variant, /datum/psionic_rank_variant/levitate))
		return selected_variant

	return null

/datum/action/cooldown/psionic/levitate/proc/apply_levitation_form(mob/living/living_owner, datum/psionic_rank_variant/levitate/form)
	if(!istype(living_owner) || !form)
		return

	if(form.grants_free_float)
		ADD_TRAIT(living_owner, TRAIT_FREE_FLOAT_MOVEMENT, PSIONIC_LEVITATION_TRAIT_SOURCE)
	else
		REMOVE_TRAIT(living_owner, TRAIT_FREE_FLOAT_MOVEMENT, PSIONIC_LEVITATION_TRAIT_SOURCE)

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

	if(!try_gain_active_strain(profile, seconds_per_tick))
		clear_levitation(living_owner)

/datum/action/cooldown/psionic/levitate/proc/on_levitation_death(datum/source, gibbed)
	SIGNAL_HANDLER

	var/mob/living/living_owner = source
	clear_levitation(living_owner, TRUE)

/datum/action/cooldown/psionic/levitate/proc/clear_levitation(mob/living/living_owner, silent = FALSE)
	if(!levitating)
		return FALSE

	levitating = FALSE
	if(istype(living_owner))
		UnregisterSignal(living_owner, list(COMSIG_LIVING_LIFE, COMSIG_LIVING_DEATH))
		REMOVE_TRAIT(living_owner, TRAIT_SILENT_FOOTSTEPS, PSIONIC_LEVITATION_TRAIT_SOURCE)
		REMOVE_TRAIT(living_owner, TRAIT_FREE_FLOAT_MOVEMENT, PSIONIC_LEVITATION_TRAIT_SOURCE)
		living_owner.RemoveElement(/datum/element/forced_gravity, gravity = 0, can_override = TRUE)
		if(!silent)
			to_chat(living_owner, span_notice("You settle back to the ground."))
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	return TRUE
