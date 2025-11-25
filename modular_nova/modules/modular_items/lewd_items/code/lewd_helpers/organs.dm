/obj/item/organ/brain/on_life(seconds_per_tick, times_fired) //All your horny is here *points to the head*
	. = ..()
	var/mob/living/carbon/human/brain_owner = owner
	if(brain_owner.client && !(organ_flags & ORGAN_FAILING) && istype(brain_owner))
		brain_owner.dna.species.handle_arousal(brain_owner, seconds_per_tick, times_fired)
