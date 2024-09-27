/datum/artifact_effect/noise
	log_name = "Noise"
	var/static/list/possible_noises = list(
		'sound/machines/buzz-sigh.ogg',
		'sound/machines/buzz-two.ogg',
		'sound/machines/chime.ogg',
		'sound/items/bikehorn.ogg',
		'sound/machines/ping.ogg',
		'sound/misc/sadtrombone.ogg',
		'sound/machines/warning-buzzer.ogg',
		'sound/machines/slowclap.ogg',
		'sound/voice/moth/scream_moth.ogg',
		'sound/items/toysqueak1.ogg',
		'sound/items/poster_ripped.ogg',
		'sound/items/coinflip.ogg',
		'sound/items/megaphone.ogg',
		'sound/magic/warpwhistle.ogg',
		'sound/voice/hiss1.ogg',
		'sound/voice/lizard/lizard_scream_1.ogg',
		'sound/weapons/flashbang.ogg',
		'sound/weapons/flash.ogg',
		'sound/weapons/whip.ogg',
		'sound/items/SitcomLaugh1.ogg',
		'sound/items/gavel.ogg',
		'sound/items/haunted/ghostitemattack.ogg',
		'sound/items/ceramic_break.ogg',
		'sound/hallucinations/veryfar_noise.ogg',
		'sound/hallucinations/radio_static.ogg',
		'sound/hallucinations/look_up1.ogg',
		'sound/hallucinations/wail.ogg',
		'sound/hallucinations/growl2.ogg',
		'sound/hallucinations/far_noise.ogg',
		'sound/creatures/alien_eat.ogg', // vore :3
		'sound/runtime/complionator/asshole.ogg',
		'sound/misc/scary_horn.ogg',
		'sound/magic/curse.ogg',
		'sound/machines/airlock_alien_prying.ogg',
		'sound/creatures/clown/hohoho.ogg', // hehe
		'sound/creatures/clown/hehe.ogg', // hohoho
		'sound/effects/wounds/crack1.ogg',
		'modular_nova/modules/emotes/sound/voice/scream_f1.ogg',
		'modular_nova/modules/encounters/sounds/alarm_radio.ogg',
		'modular_nova/modules/encounters/sounds/morse.ogg', // I can spend all day here, adding sounds. But i wont.
	)

/datum/artifact_effect/noise/New()
	. = ..()
	trigger = TRIGGER_OXY
	release_method = ARTIFACT_EFFECT_PULSE
	type_name = ARTIFACT_EFFECT_PSIONIC

/datum/artifact_effect/noise/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/list/sound_type = pick(possible_noises)
	playsound(holder, pick(sound_type), 50, ignore_walls = TRUE)

/datum/artifact_effect/noise/do_effect_destroy()
	playsound(holder, 'sound/hallucinations/wail.ogg', 75, ignore_walls = TRUE, extrarange = 25, pressure_affected = FALSE) // Louder than usual scream with extra range
