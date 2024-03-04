// Synth brains don't drop in deathmatch
/datum/deathmatch_lobby/proc/spawn_observer_as_player(ckey, loc)
	. = ..()
	var/obj/item/organ/internal/brain/synth/synth_brain = new_player.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(synth_brain))
		synth_brain.drop_when_organ_spilling = FALSE

