/datum/psionic_power/levitate
	action_type = /datum/action/cooldown/psionic/levitate

/datum/psionic_rank_variant/levitate
	rank = PSIONIC_RANK_EPSILON
	variant_name = "levitation"
	description = "A maintained lift that lets you float above the floor."
	cooldown_time = 0
	strain_gain = 0
	active_strain_gain_per_second = 3
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
	point_cost = 1
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	maintain_end_message = "You settle back to the ground."
	rank_variant_types = list(
		/datum/psionic_rank_variant/levitate,
		/datum/psionic_rank_variant/levitate/delta,
	)

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

/datum/action/cooldown/psionic/levitate/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE

	var/datum/psionic_rank_variant/levitate/form = get_selected_variant_as_type(/datum/psionic_rank_variant/levitate)
	if(!form)
		return FALSE

	living_owner.AddElement(/datum/element/forced_gravity, gravity = 0, can_override = TRUE)
	ADD_TRAIT(living_owner, TRAIT_SILENT_FOOTSTEPS, PSIONIC_LEVITATION_TRAIT_SOURCE)
	apply_levitation_form(living_owner, form)
	living_owner.set_resting(FALSE, TRUE)
	start_maintaining(living_owner)

	living_owner.visible_message(
		span_notice("[living_owner] rises slightly off the floor."),
		span_purple("You lift yourself off the ground."),
	)
	return TRUE

/datum/action/cooldown/psionic/levitate/on_rank_variant_selected(mob/living/living_owner, datum/psionic_rank_variant/variant)
	. = ..()
	if(!is_maintaining())
		return
	if(!istype(variant, /datum/psionic_rank_variant/levitate))
		return

	var/datum/psionic_rank_variant/levitate/levitation_form = variant
	apply_levitation_form(living_owner, levitation_form)

/datum/action/cooldown/psionic/levitate/proc/apply_levitation_form(mob/living/living_owner, datum/psionic_rank_variant/levitate/form)
	if(!istype(living_owner) || !form)
		return

	if(form.grants_free_float)
		ADD_TRAIT(living_owner, TRAIT_FREE_FLOAT_MOVEMENT, PSIONIC_LEVITATION_TRAIT_SOURCE)
	else
		REMOVE_TRAIT(living_owner, TRAIT_FREE_FLOAT_MOVEMENT, PSIONIC_LEVITATION_TRAIT_SOURCE)

/datum/action/cooldown/psionic/levitate/can_maintain(mob/living/living_owner, datum/component/psionic_profile/profile)
	. = ..()
	if(!.)
		return FALSE

	return isturf(living_owner.loc) && !living_owner.buckled

/datum/action/cooldown/psionic/levitate/on_maintain_stopped(mob/living/living_owner, silent = FALSE)
	if(!istype(living_owner))
		return

	REMOVE_TRAIT(living_owner, TRAIT_SILENT_FOOTSTEPS, PSIONIC_LEVITATION_TRAIT_SOURCE)
	REMOVE_TRAIT(living_owner, TRAIT_FREE_FLOAT_MOVEMENT, PSIONIC_LEVITATION_TRAIT_SOURCE)
	living_owner.RemoveElement(/datum/element/forced_gravity, gravity = 0, can_override = TRUE)
