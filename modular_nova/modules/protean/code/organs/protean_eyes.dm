/obj/item/organ/eyes/synth/protean
	name = "imaging nanites"
	desc = "Nanites designed to collect visual data from the surrounding world."
	organ_flags = ORGAN_ROBOTIC  | ORGAN_NANOMACHINE

/obj/item/organ/eyes/synth/protean/Initialize(mapload)
	. = ..()
	if(QDELETED(src))
		return
	AddElement(/datum/element/nanite_organ)
