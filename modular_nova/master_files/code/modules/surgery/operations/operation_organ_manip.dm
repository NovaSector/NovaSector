// Don't show unremovable organs
/datum/surgery_operation/limb/organ_manipulation/internal/organ_check(obj/item/bodypart/limb, obj/item/organ/organ)
	. = ..() 
	if(!.)
		return
	return !(organ.organ_flags & ORGAN_UNREMOVABLE)
	
/datum/surgery_step/manipulate_organs/external/can_use_organ(obj/item/organ/organ)
	. = ..()
	if(!.)
		return
	return !(organ.organ_flags & ORGAN_UNREMOVABLE)
