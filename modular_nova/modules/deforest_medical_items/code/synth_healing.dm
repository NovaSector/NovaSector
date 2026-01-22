// Used to stop synth structural damage
/obj/item/stack/medical/wound_recovery/robofoam
	name = "robotic repair spray"
	singular_name = "robotic repair spray"
	desc = "A needle-tip foam gun filled with an advanced synthetic foam that rapidly \
		fills and stabilizes structural damage in synthetics. The damaged area will be \
		vulnerable to further damage while the foam hardens"
	icon = 'modular_nova/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "robofoam"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/blunt/robotic,
	)
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam
	treatment_sound = 'sound/effects/spray.ogg'
	causes_pain = FALSE

/obj/item/stack/medical/wound_recovery/robofoam/examine(mob/user)
	. = ..()
	. += span_notice("This <b>cheaper</b> foam can only be used to fill <b>structural</b> wounds on synthetics.")
	return .

/obj/item/stack/medical/wound_recovery/robofoam/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 5)

// Used to cure practically any synthetic wound
/obj/item/stack/medical/wound_recovery/robofoam_super
	name = "premium robotic repair spray"
	singular_name = "premium robotic repair spray"
	desc = "A needle-tip foam gun filled with an advanced synthetic foam that rapidly \
		fills and stabilizes structural damage in synthetics. The damaged area will be \
		vulnerable to further damage while the foam hardens. \
		This special premium type can also be used to repair almost any possible type \
		of synthetic damage."
	icon = 'modular_nova/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "robofoam_super"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/blunt/robotic,
		/datum/wound/muscle/robotic,
		/datum/wound/electrical_damage,
		/datum/wound/burn/robotic,
	)
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam_super
	treatment_sound = 'sound/effects/spray.ogg'
	causes_pain = FALSE

/obj/item/stack/medical/wound_recovery/robofoam_super/examine(mob/user)
	. = ..()
	. += span_notice("This more <b>expensive</b> foam can be used to fill <b>any</b> type of wound on synthetics.")
	return .

/obj/item/stack/medical/wound_recovery/robofoam_super/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/dinitrogen_plasmide, 5)

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

// The actual STACK of patches
/obj/item/stack/medical/synth_repair
	name = "robotic repair patches"
	singular_name = "robotic repair patch piece"
	desc = "A pack of sealed patches of small nanite swarms along with electrical coagulant reagents to repair small amounts of synthetic damage."
	icon = 'modular_nova/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "synth_patch"
	amount = 3
	max_amount = 3
	inhand_icon_state = null
	self_delay = 4 SECONDS
	other_delay = 2 SECONDS
	merge_type = /obj/item/stack/medical/synth_repair

/obj/item/stack/medical/synth_repair/grind_results()
	return list(
			/datum/reagent/medicine/nanite_slurry = 10,
			/datum/reagent/dinitrogen_plasmide = 5,
			/datum/reagent/medicine/coagulant/fabricated = 10,
		)

/obj/item/stack/medical/synth_repair/try_heal_checks(mob/living/patient, mob/living/user, healed_zone, silent = FALSE)
	var/obj/item/bodypart/limb = patient.get_bodypart(healed_zone)
	if(isnull(limb))
		if(!silent)
			patient.balloon_alert(user, "no [parse_zone(healed_zone)]!")
		return FALSE
	if(!IS_ROBOTIC_LIMB(limb))
		patient.balloon_alert(user, "[limb.plaintext_zone] is not synthetic!")
		return FALSE
	return TRUE

/obj/item/stack/medical/synth_repair/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/living/user)
	. = ..()
	healed_mob.reagents.add_reagent_list(grind_results())

// Repairs a robotic organs directly, or during organ manipulation surgery.
// Sprites: [@splat1125](https://github.com/splat1125)
/obj/item/cybernetic_repair_paste
	name = "cybernetic repair paste"
	desc = "A repair paste applicator pen which allows for cybernetic organs to be repaired when used with organ manipulation surgery."
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
	// Search for a valid organ manipulation surgery in the targeted bodyzone
	var/datum/surgery/active_surgery = target_human.has_surgery(
		surgery_type = /datum/surgery/organ_manipulation,
		step_type = /datum/surgery_step/manipulate_organs,
		target_zone = user.zone_selected,
	)
	if(isnull(active_surgery))
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
	return chosen_organ

///Attempts to repair the given robotic organ, and returns TRUE if successful.
/obj/item/cybernetic_repair_paste/proc/repair_organ(obj/item/organ/target_organ, mob/living/user, mob/living/target_mob)
	if(uses <= 0)
		balloon_alert(user, "it's been used up!")
		return
	if(target_organ.damage <= NONE)
		balloon_alert(user, "organ isn't broken!")
		return
	if(!do_after(user, 5 SECONDS, target_mob))
		balloon_alert(user, "repair cancelled!")
		return

	target_organ.apply_organ_damage(-repair_amount, required_organ_flag = ORGAN_ROBOTIC)
	balloon_alert(user, "organ repaired")
	to_chat(user, span_notice("You successfully repair [target_organ]."))
	if(target_organ.damage  > NONE)
		to_chat(user, "The [target_organ] still has some lasting system damage that can be cleared.")

	uses -= 1
	if(uses <= 0)
		icon_state = "cyberpaste_spent"
		to_chat(user, "The [src] runs out of gels and stops working.")

	return TRUE
