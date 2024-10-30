/datum/action/sing_tones
	name = "Sing Tones"
	desc = "Use your electric discharger to sing!"
	button_icon = 'icons/obj/art/musician.dmi'
	button_icon_state = "xylophone"
	var/datum/song/song
	/// What instruments can be used.
	var/allowed_instrument_ids = list("spaceman", "meowsynth", "square", "sine", "saw")
	/// Instruments added after being emagged.
	var/emag_instrument_ids = list("honk")

/datum/action/sing_tones/Grant(mob/grant_to)
	song = new(grant_to, allowed_instrument_ids, 15)
	return ..()

/datum/action/sing_tones/Remove(mob/remove_from)
	QDEL_NULL(song)
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
	song.ui_interact(owner)
