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
