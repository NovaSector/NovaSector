/datum/action/sing_tones
	name = "Sing Tones"
	desc = "Use your electric discharger to sing!"
	button_icon = 'icons/obj/art/musician.dmi'
	button_icon_state = "xylophone"
	var/obj/item/instrument/ethereal_synth/tone_synth

/datum/action/sing_tones/Grant(mob/grant_to)
	tone_synth = new
	return ..()

/datum/action/sing_tones/Remove(mob/remove_from)
	QDEL_NULL(tone_synth)
	return ..()

/datum/action/sing_tones/IsAvailable(feedback)
	var/mob/living/carbon/human/human_target = owner
	var/obj/item/organ/internal/tongue/ethereal/discharger = human_target.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(discharger && istype(discharger, /obj/item/organ/internal/tongue/ethereal))
		return ..()
	return FALSE

/datum/action/sing_tones/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	tone_synth.interact(owner)
