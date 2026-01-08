/datum/surgery_operation/organ/repair
	/// Organ requires this much damage before it can be operated on
	var/requires_organ_damage

/datum/surgery_operation/organ/repair/is_available(obj/item/organ/organ, operated_zone)
	. = ..()
	// Ensure organ has the required amount of damage
	if(!isnull(requires_organ_damage) && (organn.damage < requires_organ_damage))
		return FALSE

// This is so that you can do organ surgeries multiple times on slimepeople.
/datum/surgery_operation/organ/repair/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	if(istype(target_lungs, /obj/item/organ/lungs/slime))
		addtimer(CALLBACK(PROC_REF(make_operable), organ, surgeon, tool, operation_args), 30 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME)
