/datum/psionic_power/sensual_touch
	required_powers = list(/datum/action/cooldown/psionic/pointed/living_target/empathic_read)
	action_type = /datum/action/cooldown/psionic/pointed/living_target/sensual_touch

/datum/psionic_rank_variant/sensual_touch
	/// Arousal applied to the target on a successful touch.
	var/arousal_gain
	/// Pleasure applied to the target on a successful touch.
	var/pleasure_gain

/datum/psionic_rank_variant/sensual_touch/gentle
	rank = PSIONIC_RANK_EPSILON
	variant_name = "gentle caress"
	description = "A soft psionic caress that stirs the senses."
	cooldown_time = 20 SECONDS
	cast_range = 1
	strain_gain = 8
	arousal_gain = 4
	pleasure_gain = 3
	block_charge_cost = 1
	block_message = "senses guarded!"

/datum/psionic_rank_variant/sensual_touch/blissful
	rank = PSIONIC_RANK_DELTA
	variant_name = "wave of bliss"
	description = "A rolling psionic wave of warmth and pleasure."
	cooldown_time = 20 SECONDS
	cast_range = 1
	strain_gain = 12
	arousal_gain = 8
	pleasure_gain = 6
	block_charge_cost = 1
	block_message = "senses guarded!"

/datum/action/cooldown/psionic/pointed/living_target/sensual_touch
	name = "Sensual Touch"
	desc = "Brush an adjacent mind's senses with warmth, kindling arousal and pleasure."
	button_icon_state = "psi_empathic_read"
	point_cost = 1
	lewd = TRUE
	psionic_flags = PSIONIC_INTRUSIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	rank_variant_types = list(
		/datum/psionic_rank_variant/sensual_touch/gentle,
		/datum/psionic_rank_variant/sensual_touch/blissful,
	)
	variant_type = /datum/psionic_rank_variant/sensual_touch
	active_msg = "You gather warm resonance in your fingertips..."
	deactive_msg = "You let the warmth dissipate."

/datum/action/cooldown/psionic/pointed/living_target/sensual_touch/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(target))
		owner.balloon_alert(owner, "no responsive body!")
		return FALSE

	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/sensual_touch/psionic_activate(atom/target)
	var/datum/psionic_rank_variant/sensual_touch/form = get_form()
	if(!form)
		return FALSE

	var/mob/living/carbon/human/human_target = target
	to_chat(owner, span_purple("You trail psionic warmth across [human_target]'s senses."))
	to_chat(human_target, span_purple("A wave of disembodied warmth rolls across your skin, kindling something deeper."))
	human_target.adjust_arousal(form.arousal_gain)
	human_target.adjust_pleasure(form.pleasure_gain)
	owner.log_message("used [name] on [key_name(human_target)]", LOG_GAME)
	return TRUE
