/// Synthetic fuel cell Maintenance
/datum/surgery/fuelcell
	name = "Fuel Cell Maintenance"
	desc = "A mechanical surgery procedure designed to repair an android's internal fuel cell."
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB | SURGERY_REQUIRES_REAL_LIMB
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fuelcell/repair,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close,
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)
	organ_to_manipulate = ORGAN_SLOT_STOMACH
	requires_bodypart_type = BODYTYPE_ROBOTIC
	requires_organ_type = /obj/item/organ/stomach/synth
	requires_organ_flags = ORGAN_ROBOTIC
	requires_organ_damage = 10

// Subtype for synthetic humanoids with organic bodyparts
/datum/surgery/fuelcell/hybrid
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fuelcell/repair,
		/datum/surgery_step/close,
	)
	requires_bodypart_type = BODYTYPE_ORGANIC

/datum/surgery_step/fuelcell/repair
	name = "perform fuel cell maintenance (screwdriver)"
	implements = list(
		TOOL_SCREWDRIVER = 95,
		TOOL_SCALPEL = 45,
		/obj/item/melee/energy/sword = 35,
		/obj/item/knife = 25,
		/obj/item/shard = 5,
	)
	preop_sound = 'sound/effects/bodyfall/bodyfall1.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'

/datum/surgery_step/fuelcell/repair/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to patch the damaged section of [target]'s fuel cell..."),
		span_notice("[user] begins to delicately repair [target]'s fuel cell using [tool]."),
		span_notice("[user] begins to delicately repair [target]'s fuel cell."),
	)
	display_pain(target, "You feel a horrible stab in your gut!")

/datum/surgery_step/fuelcell/repair/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/patient = target
	var/obj/item/organ/stomach/fuelcell = target.get_organ_slot(ORGAN_SLOT_STOMACH)
	patient.setOrganLoss(ORGAN_SLOT_STOMACH, 0) // adjustOrganLoss didnt work here without runtimes spamming, setting to 0 as synths have no natural organ decay/regeneration
	if(fuelcell.organ_flags & ORGAN_EMP)
		fuelcell.organ_flags &= ~ORGAN_EMP
	display_results(
		user,
		target,
		span_notice("You successfully repair the damaged part of [target]'s fuel cell."),
		span_notice("[user] successfully repairs the damaged part of [target]'s fuel cell using [tool]."),
		span_notice("[user] successfully repairs the damaged part of [target]'s fuel cell."),
	)
	display_pain(target, "The errors clear from your fuel cell.")
	return ..()

/datum/surgery_step/fuelcell/repair/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	var/mob/living/carbon/human/patient = target
	patient.adjustOrganLoss(ORGAN_SLOT_STOMACH, 15)
	display_results(
		user,
		target,
		span_warning("You slip and puncture [target]'s fuel cell!"),
		span_warning("[user] slips and punctures [target]'s fuel cell with the [tool]!"),
		span_warning("[user] slips and punctures [target]'s fuel cell!"),
	)
	display_pain(target, "Your midsection throws additional errors; that's not right!")
