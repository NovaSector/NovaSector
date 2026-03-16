/obj/item/organ/eyes/robotic/protean
	name = "imaging nanites"
	desc = "Nanites designed to collect visual data from the surrounding world."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/eyes/robotic/protean/Initialize(mapload)
	. = ..()
	if(QDELETED(src))
		return
	AddElement(/datum/element/nanite_organ)

/obj/item/organ/eyes/robotic/protean/on_life(seconds_per_tick, times_fired)
	if(damage > 0)
		apply_organ_damage(-1 * seconds_per_tick)
	return ..()
