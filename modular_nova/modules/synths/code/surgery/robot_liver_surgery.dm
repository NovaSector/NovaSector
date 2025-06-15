/// Reagent Processor Repair surgery
/datum/surgery/reagent_pump
	name = "Reagent Processor Manual Reset"
	desc = "A mechanical surgery procedure designed to repair an android's reagent processor."
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/reagent_pump/repair,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	organ_to_manipulate = ORGAN_SLOT_LIVER
	requires_bodypart_type = BODYTYPE_ROBOTIC
	requires_organ_type = /obj/item/organ/liver/synth
	requires_organ_flags = ORGAN_ROBOTIC
	requires_organ_damage = 10

// Subtype for synthetic humanoids with organic bodyparts
/datum/surgery/reagent_pump/hybrid
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/reagent_pump/repair,
		/datum/surgery_step/close,
	)
	requires_bodypart_type = BODYTYPE_ORGANIC

/datum/surgery_step/reagent_pump/repair
	name = "perform valve adjustment (screwdriver)"
	implements = list(
		TOOL_SCREWDRIVER = 95,
		TOOL_SCALPEL = 45,
		/obj/item/melee/energy/sword = 35,
		/obj/item/knife = 25,
		/obj/item/shard = 5,
	)
	preop_sound = 'sound/items/tools/screwdriver_operating.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'

/datum/surgery_step/reagent_pump/repair/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You start to descale minerals built up in [target]'s reagent processor..."),
		span_notice("[user] begins to fix [target]'s reagent processor with [tool]."),
		span_notice("[user] begins to fix [target]'s reagent processor."),
	)
	display_pain(target, "Your systems disconnect from your reagent processor, avoiding unnecessary errors.")

/datum/surgery_step/reagent_pump/repair/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/patient = target
	var/obj/item/organ/liver/reagent_processor = target.get_organ_slot(ORGAN_SLOT_LIVER)
	patient.setOrganLoss(ORGAN_SLOT_LIVER, 0) // adjustOrganLoss didnt work here without runtimes spamming, setting to 0 as synths have no natural organ decay/regeneration
	if(reagent_processor.organ_flags & ORGAN_EMP)
		reagent_processor.organ_flags &= ~ORGAN_EMP
	display_results(
		user,
		target,
		span_notice("You successfully descale [target]'s reagent processor, restoring factory settings and removing built up minerals."),
		span_notice("[user] successfully descales [target]'s reagent processor, restoring factory settings and removing built up minerals."),
		span_notice("[user] successfully resets [target]'s reagent processor."),
	)
	display_pain(target, "Flow rate restored.")
	return ..()

/datum/surgery_step/reagent_pump/repair/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	var/mob/living/carbon/human/patient = target
	patient.adjustOrganLoss(ORGAN_SLOT_LIVER, 15)
	display_results(
		user,
		target,
		span_warning("You adjust [target]'s reagent processor out of spec!"),
		span_warning("[user] follows the wrong guide for [target]'s reagent processor!"),
		span_warning("[user] finishes adjusting [target]'s reagent processor... wait that isn't right..."),
	)
	display_pain(target, "You see errors flow across your vision!")
