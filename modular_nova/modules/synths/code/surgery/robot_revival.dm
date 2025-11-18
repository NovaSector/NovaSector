/datum/surgery/revive_synth
	name = "Restart Neural Network (Revival)"
	desc = "A mechanical surgical procedure that restarts an android's neural network."
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/finalize_restart,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	organ_to_manipulate = ORGAN_SLOT_BRAIN
	requires_bodypart_type = BODYTYPE_ROBOTIC
	requires_organ_flags = ORGAN_ROBOTIC

// Subtype for synthetic humanoids with organic bodyparts
/datum/surgery/revive_synth/hybrid
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/finalize_restart,
		/datum/surgery_step/close,
	)
	possible_locs = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ORGANIC

/datum/surgery/revive_synth/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	if(target.stat != DEAD)
		return FALSE

/datum/surgery_step/finalize_restart
	name = "finalize restart (multitool/shocking implement)"
	implements = list(
		TOOL_MULTITOOL = 100,
		/obj/item/shockpaddles = 70,
		/obj/item/melee/touch_attack/shock = 70,
		/obj/item/melee/baton/security = 35,
		/obj/item/gun/energy = 10
	)
	time = 5 SECONDS

/datum/surgery_step/finalize_restart/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		user,
		target,
		span_notice("You begin to force a reboot in [target]'s [brain_type]..."),
		span_notice("[user] begins to force a reboot in [target]'s [brain_type]."),
		span_notice("[user] begins to force a reboot in [target]'s [brain_type].")
	)

	target.notify_revival("Someone is trying to reboot your [brain_type].", source = target)

/datum/surgery_step/finalize_restart/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if (target.stat < DEAD)
		target.visible_message(span_notice("...[target] is completely unaffected! Seems like they're already active!"))
		return TRUE
	target.grab_ghost()
	if(target.revive())
		target.emote("chime")
		target.visible_message(span_notice("...[target] reactivates, their chassis coming online!"))
		to_chat(target, span_danger("[CONFIG_GET(string/blackoutpolicy)]"))
		return TRUE //This is due to synths having some weirdness with their revive.
	else
		target.emote("buzz")
		target.visible_message(span_warning("...[target.p_they()] convulses, then goes offline."))
		return FALSE

/datum/surgery_step/finalize_restart/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob)
	. = ..()

	target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, 130)
