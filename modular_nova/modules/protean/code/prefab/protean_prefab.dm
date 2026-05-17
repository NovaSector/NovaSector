// Used for printing dead protean bodies
/mob/living/carbon/human/species/protean/empty

/mob/living/carbon/human/species/protean/empty/Initialize(mapload)
	. = ..()
	var/obj/item/organ/heart/to_remove_heart = get_organ_slot(ORGAN_SLOT_HEART)
	QDEL_NULL(to_remove_heart)

	src.adjust_brute_loss(250)

	var/obj/item/organ/brain/to_remove_brain = get_organ_slot(ORGAN_SLOT_BRAIN)
	QDEL_NULL(to_remove_brain)
