/// Like add_reagent but you can enter a list. Adds them with no_react = TRUE. Format it like this: list(/datum/reagent/toxin = 10, "beer" = 15)
/datum/reagents/proc/add_noreact_reagent_list(list/list_reagents, list/data=null)
	for(var/r_id in list_reagents)
		var/amt = list_reagents[r_id]
		add_reagent(r_id, amt, data, no_react = TRUE)

/proc/reagent_process_flags_valid(mob/processor, datum/reagent/reagent)
	if(!ishuman(processor))
		if(reagent.process_flags == REAGENT_SYNTHETIC) // nonhumans can't be synths
			return FALSE
		return TRUE

	var/mob/living/carbon/human/human_processor = processor

	//Check if this mob's species is set and can process this type of reagent
	//If we somehow avoided getting a species or reagent_flags set, we'll assume we aren't meant to process ANY reagents
	if(human_processor.dna && human_processor.dna.species.reagent_flags)
		var/processor_flags = human_processor.dna.species.reagent_flags

		// SYNTHETIC-oriented reagents require PROCESS_SYNTHETIC or a synth liver
		if((reagent.process_flags & REAGENT_SYNTHETIC))
			if(processor_flags & PROCESS_SYNTHETIC)
				return TRUE
			var/obj/item/organ/liver/owner_liver = human_processor.get_organ_slot(ORGAN_SLOT_LIVER)
			if(istype(owner_liver, /obj/item/organ/liver/synth))
				// SYNTHETIC-oriented neuroware can't affect non-synthetics
				if(reagent.chemical_flags == REAGENT_NEUROWARE)
					return FALSE
				return TRUE

		// ORGANIC-oriented reagents require PROCESS_ORGANIC or a non-synth liver
		if((reagent.process_flags & REAGENT_ORGANIC))
			if(processor_flags & PROCESS_ORGANIC)
				return TRUE
			var/obj/item/organ/liver/owner_liver = human_processor.get_organ_slot(ORGAN_SLOT_LIVER)
			if(!istype(owner_liver, /obj/item/organ/liver/synth))
				// ORGANIC-oriented drugs can't affect synthetic humanoids
				if((processor_flags == PROCESS_SYNTHETIC) && !(reagent.process_flags & REAGENT_SYNTHETIC) && istype(reagent, /datum/reagent/drug))
					return FALSE
				return TRUE

		return FALSE
	return TRUE
