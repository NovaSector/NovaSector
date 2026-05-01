/obj/item/organ/liver/synth/protean
	name = "reagent catalyst"
	desc = "A nanite harvester that processes chemicals and distributes them to the nanite swarm."
	organ_flags = ORGAN_ROBOTIC | ORGAN_NANOMACHINE | ORGAN_UNREMOVABLE

/obj/item/organ/liver/synth/protean/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(QDELETED(src))
		return FALSE
	return ..()

/obj/item/organ/liver/synth/protean/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nanite_organ)
