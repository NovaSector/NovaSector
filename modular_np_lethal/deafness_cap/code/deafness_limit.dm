/datum/component/limit_deafness
	// How many ticks of deafness is our maximum?
	var/max_deafness_ticks = 10

/datum/component/limit_deafness/Initialize(...)
	. = ..()
	if (!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(deaf_check))

/datum/component/limit_deafness/proc/deaf_check(mob/living/whatdidyousay)
	var/mob/living/carbon/human/speakup = whatdidyousay
	var/obj/item/organ/internal/ears/target_ears = speakup?.get_organ_slot(ORGAN_SLOT_EARS)

	if (target_ears)
		if (target_ears.deaf > max_deafness_ticks)
			target_ears.deaf = min(max_deafness_ticks, target_ears.deaf)
			to_chat(speakup, span_notice("The ringing in your ears begins to fade..."))

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/limit_deafness)
