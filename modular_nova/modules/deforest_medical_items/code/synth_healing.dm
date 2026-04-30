// Used to cure basic robotic wounds
/obj/item/stack/medical/wound_recovery/robofoam
	name = "robotic break fix spray"
	singular_name = "robotic break fix spray"
	desc = "A needle-tip foam gun filled with an advanced foam that can be used to fix \
	<b>dents</b>, <b>broken latches</b>, and <b>loose or pierced lubricant tubing</b>. \
	Not rated for fully destroyed electrical parts or shredded lubricant tubing."
	icon = 'modular_nova/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "robofoam"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/robotic_blunt/moderate,
		/datum/wound/robotic_blunt/severe,
		/datum/wound/robotic_bleed/moderate,
		/datum/wound/robotic_bleed/severe,
	)
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam
	treatment_sound = 'sound/effects/spray.ogg'
	causes_pain = FALSE

/obj/item/stack/medical/wound_recovery/robofoam/examine(mob/user)
	. = ..()
	. += span_notice("This <b>cheaper</b> foam can only be used to fix <b>moderate and severe</b> wounds on robotic limbs.")
	return .

// Used to cure all tiers of robotic wound
/obj/item/stack/medical/wound_recovery/robofoam_super
	name = "premium robotic break fix spray"
	singular_name = "premium robotic break fix spray"
	desc = "A needle-tip foam gun filled with an advanced foam that can fix \
	<b>dents</b>, <b>broken latches</b>, and <b>loose or pierced lubricant tubing</b>. \
	It's also got nanites that will <b>repair "
	icon_state = "robofoam_super"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/robotic_blunt,
		/datum/wound/robotic_bleed
	)
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam_super
	treatment_sound = 'sound/effects/spray.ogg'
	causes_pain = FALSE

/obj/item/stack/medical/wound_recovery/robofoam_super/examine(mob/user)
	. = ..()
	. += span_notice("This more <b>expensive</b> foam can be used to fix <b>any</b> type of wound on robotic limbs.")
	return .

// Synth repair patch, gives the synth a small amount of healing chems
/obj/item/reagent_containers/applicator/pill/patch/robotic_patch
	name = "robotic patch"
	desc = "A chemical patch for touch-based applications on synthetics."
	icon = 'modular_nova/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "synth_patch"
	inhand_icon_state = null
	possible_transfer_amounts = list()
	volume = 40
	self_delay = 3 SECONDS

/obj/item/reagent_containers/applicator/pill/patch/robotic_patch/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return
		if(!IS_ROBOTIC_LIMB(affecting))
			to_chat(user, span_notice("Robotic patches won't work on an organic limb!"))
			return
	return ..()

/obj/item/reagent_containers/applicator/pill/patch/robotic_patch/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return FALSE
	return TRUE

// Repairs a robotic organs directly, or during organ manipulation surgery.
// Sprites: [@splat1125](https://github.com/splat1125)
/obj/item/cybernetic_repair_paste
	name = "robotic organ repair paste"
	desc = "Repair paste for robotic organs. Can be used directly on a robotic organ, \
	or on a patient during organ manipulation surgery to repair damaged robotic organs."
	icon = 'modular_nova/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "cyberpaste"
	w_class = WEIGHT_CLASS_SMALL
	///How much organ damage does this repair each time it is used?
	var/repair_amount = 25
	///How many times can this be used?
	var/uses = 5

/obj/item/cybernetic_repair_paste/examine()
	. = ..()
	if(uses > 0)
		. += span_notice("It is loaded with [uses] gels.")
	else
		. += span_notice("It is spent.")

// Attempts to repair a robotic organ via an active organ manipulation surgery.
/obj/item/cybernetic_repair_paste/attack(mob/living/target_mob, mob/living/user)
	if(!ishuman(target_mob))
		return ..()
	if(uses <= 0)
		balloon_alert(user, "it's been used up!")
		return ..()
	var/obj/item/organ/target_organ = select_organ(target_mob, user)
	if(isnull(target_organ))
		return
	// Ensure the user didn't move away from the target during the TGUI prompt
	if(!user.Adjacent(target_mob))
		return
	if(repair_organ(target_organ, user, target_mob))
		to_chat(target_mob, span_notice("[user] successfully repairs your [target_organ]"))

// Attempts to directly repair a robotic organ item.
/obj/item/cybernetic_repair_paste/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(isorgan(interacting_with) && repair_organ(interacting_with, user))
		return ITEM_INTERACT_SUCCESS

///Prompts the user to select a robotic organ in the target mob and returns it.
///Requires the target to have an active organ manipulation surgery in its "manipulate organs" stage.
/obj/item/cybernetic_repair_paste/proc/select_organ(mob/living/carbon/human/target_human, mob/living/user)
	// Check for valid organ manipulation surgery state in the targeted bodyzone
	var/obj/item/bodypart/part_to_repair = target_human.get_bodypart(deprecise_zone(user.zone_selected))
	var/surgery_step_bitflags = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT
	// Chest and brain require bone saw
	if(part_to_repair.body_zone == BODY_ZONE_CHEST)
		surgery_step_bitflags = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_BONE_SAWED

	if(!LIMB_HAS_SURGERY_STATE(part_to_repair, (surgery_step_bitflags)))
		balloon_alert(user, "requires open surgery!")
		return

	var/list/obj/item/organ/cyber_organs = list()
	for(var/obj/item/organ/organ as anything in target_human.get_organs_for_zone(user.zone_selected))
		if(organ.organ_flags & ORGAN_ROBOTIC)
			cyber_organs += organ
	if(!length(cyber_organs))
		balloon_alert(user, "lacks robotic organ!")
		return
	var/obj/item/organ/chosen_organ = tgui_input_list(user, "Repair which organ?", "Surgery", sort_list(cyber_organs))
	// Brains specifically also require the bone saw, so check that as well.
	if(chosen_organ.slot == ORGAN_SLOT_BRAIN)
		if(!LIMB_HAS_SURGERY_STATE(part_to_repair, (SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_BONE_SAWED)))
			balloon_alert(user, "requires the bones to be sawed open!")
			return

	return chosen_organ

///Attempts to repair the given robotic organ, and returns TRUE if successful.
/obj/item/cybernetic_repair_paste/proc/repair_organ(obj/item/organ/target_organ, mob/living/user, mob/living/target_mob)
	if(uses <= 0)
		balloon_alert(user, "it's been used up!")
		return
	if(!(target_organ.organ_flags & ORGAN_ROBOTIC))
		balloon_alert(user, "organ isn't robotic!")
		return
	if(target_organ.damage <= NONE)
		balloon_alert(user, "organ isn't broken!")
		return

	if(target_mob)
		if(!do_after(user, 5 SECONDS, target_mob))
			balloon_alert(user, "repair cancelled!")
			return
	else
		if(!do_after(user, 5 SECONDS, target_organ))
			balloon_alert(user, "repair cancelled!")
			return

	target_organ.apply_organ_damage(-repair_amount, required_organ_flag = ORGAN_ROBOTIC)
	to_chat(user, span_notice("You successfully repair [target_organ]."))
	if(target_organ.damage  > NONE)
		balloon_alert(user, "organ partially repaired")
		to_chat(user, "The [target_organ] still has some lasting system damage that can be cleared.")
	else
		balloon_alert(user, "organ fully repaired")
		to_chat(user, "The [target_organ] is fully repaired!")

	uses -= 1
	if(uses <= 0)
		icon_state = "cyberpaste_spent"
		to_chat(user, "The [src] runs out of gels and stops working.")

	return TRUE
