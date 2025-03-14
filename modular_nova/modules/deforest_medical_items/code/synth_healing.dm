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
/obj/item/reagent_containers/pill/robotic_patch
	name = "robotic patch"
	desc = "A chemical patch for touch-based applications on synthetics."
	icon = 'modular_nova/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "synth_patch"
	inhand_icon_state = null
	possible_transfer_amounts = list()
	volume = 40
	apply_type = PATCH
	apply_method = "apply"
	self_delay = 3 SECONDS
	dissolvable = FALSE

/obj/item/reagent_containers/pill/robotic_patch/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return
		if(!IS_ROBOTIC_LIMB(affecting))
			to_chat(user, span_notice("Robotic patches won't work on an organic limb!"))
			return
	return ..()

/obj/item/reagent_containers/pill/robotic_patch/canconsume(mob/eater, mob/user)
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
	grind_results = list(/datum/reagent/medicine/nanite_slurry = 10,
		/datum/reagent/dinitrogen_plasmide = 5,
		/datum/reagent/medicine/coagulant/fabricated = 10,
	)
	merge_type = /obj/item/stack/medical/synth_repair

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
	healed_mob.reagents.add_reagent_list(grind_results)
