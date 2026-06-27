// Nerfs the meme value of the lead pipe. 95% of the time we get the normal drop sound.
// 5% of the time we get the current throw_drop_sound.
/obj/item/lead_pipe/play_throw_drop_sound(volume = DROP_SOUND_VOLUME)
	if(prob(95))
		return sound_chain(drop_sound, volume)
	return ..()
