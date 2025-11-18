/datum/emote
	specific_emote_audio_cooldown = 0 SECONDS // The 2 second global emote cooldown is sufficient in most cases. Specific emote cooldowns can be applied on a per-emote basis on top of that.
	/// Emote volume
	var/sound_volume = 25
	/// What species can use this emote?
	var/list/allowed_species

/datum/emote/proc/check_config()
	return TRUE
