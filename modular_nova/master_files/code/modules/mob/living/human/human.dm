/mob/living/carbon/human/can_use_guns(obj/item/G)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_PRONE))
		to_chat(src, span_warning("You are crawling too low to used a ranged weapon!"))
		return FALSE

///Returns the first surgery datum in the mob to match the given operation_type, or returns null if the search failed.
///Optionally also checks that the surgery is at the given step_type or within a specific bodyzone.
/mob/living/carbon/human/proc/has_surgery(datum/surgery/surgery_type, datum/surgery_step/step_type, target_zone)
	for(var/datum/surgery/surgery as anything in surgeries)
		if(!istype(surgery, surgery_type))
			continue
		// Skip searching outside the targeted bodyzone
		if(!isnull(target_zone) && (surgery.location != target_zone))
			continue
		// Ensure the surgery is on the given step_type
		if(!isnull(step_type) && !ispath(surgery.steps[surgery.status], step_type))
			continue
		// Successfully identified the required surgery
		return surgery
