// By temporarily removing the unspillable organs before calling the parent proc we can avoid NOVA EDITs and make this less likely to break in the future
/mob/living/carbon/spill_organs(drop_bitflags)
	var/list/held_organs = list()
	for(var/obj/item/organ/organ as anything in organs)
		if(!organ.drop_when_organ_spilling)
			held_organs.Add(organ)
			organs.Remove(organ)

	// synth brains always drop when gibbed, by default
	var/obj/item/organ/brain/synth/synth_brain = get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(synth_brain))
		drop_bitflags |= DROP_BRAIN

	. = ..()

	// put the unspillable organs back
	for(var/obj/item/organ/organ as anything in held_organs)
		organs.Add(organ)
