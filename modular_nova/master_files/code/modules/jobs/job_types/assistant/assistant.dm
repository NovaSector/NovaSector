/datum/job/assistant
	allow_bureaucratic_error = FALSE

/datum/outfit/job/assistant
	uniform = /obj/item/clothing/under/color/random

// reverse the uniform override if we have a loadout uniform, we don't want to replace that
/datum/outfit/job/assistant/give_jumpsuit(mob/living/carbon/human/target)
	var/original_uniform = uniform

	. = ..()

	if(modified_outfit_slots & ITEM_SLOT_ICLOTHING)
		uniform = original_uniform

/datum/outfit/job/assistant/preview/give_jumpsuit(mob/living/carbon/human/target)
	// This is so it doesn't force a jumpsuit on if there's already something in the jumpsuit slot from the loadout.
	if(modified_outfit_slots & ITEM_SLOT_ICLOTHING)
		return

	return ..()
