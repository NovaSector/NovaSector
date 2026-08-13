#define PSIONIC_ANCHOR_TRAIT_SOURCE "psionic_anchor"

/datum/psionic_power/anchor
	required_powers = list(/datum/action/cooldown/psionic/pointed/kinetic_shove)
	action_type = /datum/action/cooldown/psionic/anchor

/datum/psionic_rank_variant/anchor
	rank = PSIONIC_RANK_GAMMA
	variant_name = "anchor"
	description = "A maintained hold that roots you against outside force."
	cooldown_time = 0
	strain_gain = 0
	active_strain_gain_per_second = 3
	block_charge_cost = 0
	/// Movement slowdown applied while this form is held.
	var/slowdown = 1.2
	/// If TRUE, this form also refuses knockdown.
	var/resists_knockdown = FALSE

/datum/psionic_rank_variant/anchor/beta
	rank = PSIONIC_RANK_BETA
	variant_name = "immovable"
	description = "A practised hold that costs less footing and refuses to be put down."
	active_strain_gain_per_second = 5
	slowdown = 0.7
	resists_knockdown = TRUE

/datum/action/cooldown/psionic/anchor
	name = "Anchor"
	desc = "Bind your weight to the floor. Force cannot shove, throw, or drag you while it holds, but you move slowly."
	button_icon_state = "psi_anchor"
	point_cost = 1
	psionic_flags = PSIONIC_KINETIC
	school = PSIONIC_SCHOOL_GRAVITY
	maintain_end_message = "Your weight settles back to normal."
	maintain_end_sound = 'sound/effects/gravhit.ogg'
	variant_type = /datum/psionic_rank_variant/anchor
	rank_variant_types = list(
		/datum/psionic_rank_variant/anchor,
		/datum/psionic_rank_variant/anchor/beta,
	)
	/// Move resist restored when the hold ends.
	var/original_move_resist

/datum/action/cooldown/psionic/anchor/is_valid_target(atom/target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return FALSE
	if(!isturf(living_owner.loc))
		living_owner.balloon_alert(living_owner, "no footing!")
		return FALSE
	if(living_owner.buckled)
		living_owner.balloon_alert(living_owner, "buckled!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/anchor/psionic_activate(atom/target)
	var/mob/living/living_owner = owner
	var/datum/psionic_rank_variant/anchor/form = get_form()
	if(!istype(living_owner) || !form)
		return FALSE

	// Levitating and anchoring are opposite holds on the same body, so the newer one wins.
	end_levitation(living_owner)
	original_move_resist = living_owner.move_resist
	living_owner.move_resist = MOVE_FORCE_EXTREMELY_STRONG
	ADD_TRAIT(living_owner, TRAIT_PUSHIMMUNE, PSIONIC_ANCHOR_TRAIT_SOURCE)
	living_owner.pulledby?.stop_pulling()
	apply_anchor_form(living_owner, form)
	RegisterSignal(living_owner, COMSIG_LIVING_GENERIC_STUN_CHECK, PROC_REF(on_stun_check))
	start_maintaining(living_owner)

	living_owner.visible_message(
		span_warning("[living_owner] settles, and the floor seems to grip [living_owner.p_them()]."),
		span_purple("You bind your weight to the floor."),
	)
	playsound(living_owner, 'sound/effects/gravhit.ogg', 40, TRUE)
	return TRUE

/datum/action/cooldown/psionic/anchor/on_maintain_stopped(mob/living/living_owner, silent = FALSE)
	if(!istype(living_owner))
		return

	UnregisterSignal(living_owner, COMSIG_LIVING_GENERIC_STUN_CHECK)
	REMOVE_TRAIT(living_owner, TRAIT_PUSHIMMUNE, PSIONIC_ANCHOR_TRAIT_SOURCE)
	living_owner.remove_movespeed_modifier(/datum/movespeed_modifier/psionic_anchor)
	if(!isnull(original_move_resist))
		living_owner.move_resist = original_move_resist
		original_move_resist = null

/datum/action/cooldown/psionic/anchor/can_maintain(mob/living/living_owner, datum/component/psionic_profile/profile)
	. = ..()
	if(!.)
		return FALSE

	return isturf(living_owner.loc) && !living_owner.buckled

/datum/action/cooldown/psionic/anchor/on_rank_variant_selected(mob/living/living_owner, datum/psionic_rank_variant/variant)
	. = ..()
	if(!is_maintaining() || !istype(variant, /datum/psionic_rank_variant/anchor))
		return

	var/datum/psionic_rank_variant/anchor/anchor_form = variant
	apply_anchor_form(living_owner, anchor_form)

/datum/action/cooldown/psionic/anchor/proc/apply_anchor_form(mob/living/living_owner, datum/psionic_rank_variant/anchor/form)
	if(!istype(living_owner) || !form)
		return

	living_owner.add_or_update_variable_movespeed_modifier(
		/datum/movespeed_modifier/psionic_anchor,
		multiplicative_slowdown = form.slowdown,
	)

/// Drops a maintained Levitate, which cannot coexist with a hold that pins the psion down.
/datum/action/cooldown/psionic/anchor/proc/end_levitation(mob/living/living_owner)
	var/datum/component/psionic_profile/profile = living_owner.get_psionic_profile()
	var/datum/action/cooldown/psionic/levitate/levitation = profile?.granted_actions[/datum/action/cooldown/psionic/levitate]
	if(levitation?.is_maintaining())
		levitation.stop_maintaining(living_owner)

/// Knockdown alone passes CANKNOCKDOWN; Stun and Paralyze both include CANSTUN, so this
/// refuses being put down without granting blanket stun immunity.
/datum/action/cooldown/psionic/anchor/proc/on_stun_check(mob/living/source, check_flags, force_stun)
	SIGNAL_HANDLER

	if(check_flags != CANKNOCKDOWN)
		return NONE

	var/datum/psionic_rank_variant/anchor/form = get_form()
	if(!form?.resists_knockdown)
		return NONE

	return COMPONENT_NO_STUN

/datum/movespeed_modifier/psionic_anchor
	variable = TRUE

#undef PSIONIC_ANCHOR_TRAIT_SOURCE
