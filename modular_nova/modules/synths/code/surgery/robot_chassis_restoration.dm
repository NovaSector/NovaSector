#define SYNTH_REVIVE_WELD_INTERNALS_DAMAGE 30

/datum/surgery/chassis_restoration
	name = "Chassis Restoration (Repair + Revival)"
	desc = "A mechanical surgical procedure that completely rebuilds an android's chassis, and restarts their neural network."
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating/fullbody,
		/datum/surgery_step/weld_plating/fullbody,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/add_plating/fullbody,
		/datum/surgery_step/finalize_chassis_restoration,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	organ_to_manipulate = ORGAN_SLOT_BRAIN
	requires_bodypart_type = BODYTYPE_ROBOTIC
	requires_organ_flags = ORGAN_ROBOTIC

/datum/surgery/chassis_restoration/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	if(target.stat != DEAD)
		return FALSE

/datum/surgery_step/pry_off_plating/fullbody
	time = 1.4 SECONDS

/datum/surgery_step/pry_off_plating/fullbody/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to pry open the outer protective panels on [target]'s braincase..."),
		span_notice("[user] begins to pry open the outer protective panels on [target]'s braincase."),
		span_notice("[user] begins to pry open the outer protective panels on [target]'s braincase."),
	)

/datum/surgery_step/weld_plating/fullbody
	time = 2 SECONDS

/datum/surgery_step/weld_plating/fullbody/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to slice the inner protective panels from [target]'s braincase..."),
		span_notice("[user] begins to slice the inner protective panels from [target]'s braincase."),
		span_notice("[user] begins to slice the inner protective panels from [target]'s braincase."),
	)

/datum/surgery_step/weld_plating/fullbody/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	. = ..()

	target.apply_damage(SYNTH_REVIVE_WELD_INTERNALS_DAMAGE, BRUTE, "[target_zone]", wound_bonus = CANT_WOUND)

/datum/surgery_step/add_plating/fullbody
	name = "add plating (15 iron sheets)"
	time = 3 SECONDS
	ironamount = 15

/datum/surgery_step/add_plating/fullbody/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to add new panels to [target]'s braincase..."),
		span_notice("[user] begins to add new panels to [target]'s braincase."),
		span_notice("[user] begins to add new panels to [target]'s braincase."),
	)

/datum/surgery_step/add_plating/fullbody/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()

	target.heal_bodypart_damage(brute = SYNTH_REVIVE_WELD_INTERNALS_DAMAGE, target_zone = "[target_zone]", required_bodytype = BODYTYPE_ROBOTIC)

/datum/surgery_step/finalize_chassis_restoration
	name = "finalize restoration (multitool/shocking implement)"
	implements = list(
		TOOL_MULTITOOL = 100,
		/obj/item/shockpaddles = 70,
		/obj/item/melee/touch_attack/shock = 70,
		/obj/item/melee/baton/security = 35,
		/obj/item/gun/energy = 10
	)
	time = 5 SECONDS

/datum/surgery_step/finalize_chassis_restoration/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
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

/datum/surgery_step/finalize_chassis_restoration/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if (target.stat < DEAD)
		target.visible_message(span_notice("...[target] is completely unaffected! Seems like they're already active!"))
		return TRUE

	target.cure_husk()
	target.grab_ghost()
	target.updatehealth()

	if(target.revive())
		target.emote("chime")
		target.visible_message(span_notice("...[target] reactivates, their chassis coming online!"))
		to_chat(target, span_danger("[CONFIG_GET(string/blackoutpolicy)]"))
		return TRUE //This is due to synths having some weirdness with their revive.
	else
		target.emote("buzz")
		target.visible_message(span_warning("...[target.p_they()] convulses, then goes offline."))
		return FALSE

/datum/surgery_step/finalize_chassis_restoration/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob)
	. = ..()

	target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, 130)

#undef SYNTH_REVIVE_WELD_INTERNALS_DAMAGE
