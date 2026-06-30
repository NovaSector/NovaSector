/datum/psionic_power/rejuvenate
	required_school_points = 2
	required_powers = list(/datum/action/cooldown/psionic/pointed/living_target/biomend)
	action_type = /datum/action/cooldown/psionic/pointed/living_target/rejuvenate

/datum/psionic_rank_variant/rejuvenate
	rank = PSIONIC_RANK_DELTA
	variant_name = "revival"
	description = "A strenuous attempt to restart a recently dead organic body."
	block_charge_cost = 0

/datum/action/cooldown/psionic/pointed/living_target/rejuvenate
	name = "Rejuvenate"
	desc = "Spend heavy strain to restart a dead organic body that still has the organs needed for revival."
	button_icon_state = "psi_rejuvenate"
	cooldown_time = 2 MINUTES
	cast_range = 3
	allow_dead_targets = TRUE
	point_cost = 3
	strain_gain = 100
	psionic_flags = PSIONIC_PROTECTIVE
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	requires_concentration = TRUE
	rank_variant_types = list(/datum/psionic_rank_variant/rejuvenate)
	active_msg = "You gather a restorative pattern..."
	deactive_msg = "You release the restorative pattern."

/datum/action/cooldown/psionic/pointed/living_target/rejuvenate/is_valid_target(atom/target)
	. = ..()
	if(!.)
		return FALSE
	if(!iscarbon(target))
		owner.balloon_alert(owner, "not organic!")
		return FALSE
	var/mob/living/carbon/carbon_target = target
	if(carbon_target.stat != DEAD)
		owner.balloon_alert(owner, "not dead!")
		return FALSE
	if(HAS_TRAIT(carbon_target, TRAIT_DNR))
		owner.balloon_alert(owner, "cannot revive!")
		return FALSE
	if(!carbon_target.can_be_revived())
		owner.balloon_alert(owner, "body unsuitable!")
		return FALSE
	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/rejuvenate/psionic_activate(atom/target)
	var/mob/living/caster = owner
	var/mob/living/carbon/carbon_target = target
	caster.visible_message(
		span_notice("Soft light gathers between [caster] and [carbon_target]."),
		span_purple("You begin drawing [carbon_target]'s body back into rhythm."),
	)
	if(!do_after(caster, 12 SECONDS, target = carbon_target, timed_action_flags = IGNORE_HELD_ITEM))
		caster.balloon_alert(caster, "focus broken!")
		return FALSE
	if(QDELETED(carbon_target) || carbon_target.stat != DEAD || !carbon_target.can_be_revived() || HAS_TRAIT(carbon_target, TRAIT_DNR))
		caster.balloon_alert(caster, "revival failed!")
		return FALSE

	carbon_target.heal_overall_damage(brute = 60, burn = 60, required_bodytype = BODYTYPE_ORGANIC)
	carbon_target.adjust_oxy_loss(-80, forced = TRUE)
	carbon_target.adjust_tox_loss(-20, forced = TRUE)
	carbon_target.adjust_blood_volume(BLOOD_VOLUME_NORMAL, maximum = BLOOD_VOLUME_NORMAL)
	carbon_target.set_heartattack(FALSE)
	if(!carbon_target.revive(excess_healing = 10))
		caster.balloon_alert(caster, "revival failed!")
		return FALSE

	carbon_target.visible_message(
		span_notice("[carbon_target]'s body draws a shuddering breath."),
		span_purple("Your thoughts snap back into your body."),
	)
	return TRUE
