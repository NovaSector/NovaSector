/obj/item/organ/brain/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	// Ensure all neuroware is removed if the brain is removed
	if(isnull(organ_owner.has_status_effect(/datum/status_effect/neuroware)))
		return
	for(var/datum/reagent/reagent as anything in organ_owner.reagents.reagent_list)
		if(reagent.chemical_flags & REAGENT_NEUROWARE)
			organ_owner.reagents.remove_reagent(reagent)
