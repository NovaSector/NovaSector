/datum/outfit/job/prisoner/post_equip(mob/living/carbon/human/new_prisoner, visualsOnly)
	. = ..()

	var/implants_removed = 0
	var/implants_total = 0

	for(var/obj/item/organ/cyberimp/cybernetic in new_prisoner.organs)
		implants_total += 1
		if (cybernetic.cannot_confiscate)
			continue
		QDEL_NULL(cybernetic)
		implants_removed += 1

	if (implants_removed >= 1)
		to_chat(new_prisoner, span_warning("[(implants_total > implants_removed) ? "Some of your" : "Your"] implants have been confiscated as part of your sentence."))
