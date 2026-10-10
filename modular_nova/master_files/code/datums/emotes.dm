/datum/emote
	manual_specific_emote_audio_cooldown = 0 SECONDS // The 2 second global emote cooldown is sufficient in most cases. Specific emote cooldowns can be applied on a per-emote basis on top of that.
	sound_volume = 25 // NOVA EDIT CHANGE - ORIGINAL: var/sound_volume = 25 - now declared upstream on /datum/emote itself
	/// What species can use this emote?
	var/list/allowed_species

/datum/emote/proc/check_config()
	return TRUE
