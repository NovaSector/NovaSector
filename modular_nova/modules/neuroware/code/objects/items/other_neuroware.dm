// Grants additional music instruments to synthetic humanoids
/obj/item/disk/neuroware/synthesizer
	name = "blank instruments neuroware"
	desc = "A neuroware chip containing additional musical instruments to be played via a synthetic humanoid's built-in audio synthesizer."
	icon_state = "chip_nt"
	success_message = "instruments upgraded"
	manufacturer_tag = NEUROWARE_NT
	var/list/add_instrument_ids

/obj/item/disk/neuroware/synthesizer/install(mob/living/carbon/human/target, mob/living/carbon/human/user)
	var/datum/action/sing_tones/sing_action = locate(/datum/action/sing_tones) in target.actions
	if(isnull(sing_action))
		return FALSE
	var/datum/song/song = sing_action.song
	// Prevent installing multiple times
	if(song.allowed_instrument_ids.Find(add_instrument_ids[1]))
		return FALSE
	song.allowed_instrument_ids += add_instrument_ids
	song.set_instrument(add_instrument_ids[1])
	return TRUE

/obj/item/disk/neuroware/synthesizer/brass
	name = "brass & wind instruments neuroware"
	desc = "A neuroware chip containing wind and brass synthesizer instruments to be played via a synthetic person's built-in audio synthesizer."
	add_instrument_ids = list("harmonica", "crharmony", "crbrass", "trombone", "saxophone", "crtrumpet", "trombone", "crtrombone")

/obj/item/disk/neuroware/synthesizer/guitar
	name = "guitar & strings instruments neuroware"
	desc = "A neuroware chip containing guitar and string synthesizer instruments to be played via a synthetic person's built-in audio synthesizer. Includes bonus banjo instrument!"
	add_instrument_ids = list("banjo", "guitar", "eguitar", "csteelgt", "cnylongt", "ccleangt", "cmutedgt", "violin")

/obj/item/disk/neuroware/synthesizer/percussion
	name = "percussion instruments neuroware"
	desc = "A neuroware chip containing percussion synthesizer instruments to be played via a synthetic person's built-in audio synthesizer."
	add_instrument_ids = list("xylophone", "glockenspiel", "crvibr", "sgmmbox", "r3celeste")

/obj/item/disk/neuroware/synthesizer/piano
	name = "piano instruments neuroware"
	desc = "A neuroware chip containing piano synthesizer instruments to be played via a synthetic person's built-in audio synthesizer."
	add_instrument_ids = list("piano", "r3grand", "r3harpsi", "crharpsi", "crgrand1", "crbright1", "crichugan", "crihamgan", "crack")
