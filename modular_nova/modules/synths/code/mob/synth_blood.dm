/datum/species/synthetic/proc/synth_blood(mob/living/carbon/human/synth, seconds_per_tick)
	SIGNAL_HANDLER

	if(synth.stat == DEAD)
		return HANDLE_BLOOD_HANDLED

	if(synth.bodytemperature < BLOOD_STOP_TEMP || HAS_TRAIT_NOT_FROM(synth, TRAIT_FAKEDEATH, QUIRK_TRAIT))
		return

	var/bleed_rate = synth.get_bleed_rate()

	if(bleed_rate)
		synth.bleed(bleed_rate * seconds_per_tick)
		synth.bleed_warn(bleed_rate)

	for (var/obj/item/bodypart/bodypart as anything in synth.get_bodyparts())
		if (bodypart.generic_bleedstacks)
			bodypart.adjustBleedStacks(-1, 0)

	// Takes into account modifiers like saline-glucose solution in the blood
	var/modified_blood_volume = synth.get_blood_volume(apply_modifiers = TRUE)

	// Some effects are halved mid-combat.
	var/determined_mod = synth.has_status_effect(/datum/status_effect/determined) ? 0.5 : 1

	var/word = pick("woozy","dizzy","hot","overheated")
	switch(modified_blood_volume)
		// Way too much blood!
		if(BLOOD_VOLUME_EXCESS to BLOOD_VOLUME_MAX_LETHAL)
			if(SPT_PROB(7.5, seconds_per_tick))
				to_chat(synth, span_userdanger("Internal fluid starts to tear your casing apart. You're going to burst!"))
				synth.investigate_log("has been gibbed by having too much blood.", INVESTIGATE_DEATHS)
				synth.inflate_gib()
		// Too much blood
		if(BLOOD_VOLUME_MAXIMUM to BLOOD_VOLUME_EXCESS)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(synth, span_warning("You feel terribly bloated and cold."))
				synth.adjust_bodytemperature(-40 * determined_mod * seconds_per_tick)
		// Low blood but not a big deal in the immediate
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			synth.adjust_bodytemperature(1 * determined_mod)
			if(SPT_PROB(2.5, seconds_per_tick))
				synth.set_eye_blur_if_lower(2 SECONDS * determined_mod)
				if(prob(50))
					to_chat(synth, span_danger("You feel [word]. It's getting a bit hard to cool down."))
					synth.adjust_bodytemperature(10 * determined_mod * seconds_per_tick)
				else if(synth.get_stamina_loss() < 25 * determined_mod)
					to_chat(synth, span_danger("You feel [word]. It's getting a bit hard to focus."))
					synth.adjust_stamina_loss(5 * determined_mod * seconds_per_tick)
		// Pretty low blood, getting dangerous!
		if(BLOOD_VOLUME_RISKY to BLOOD_VOLUME_OKAY)
			synth.adjust_bodytemperature(8 * determined_mod)
			if(SPT_PROB(5, seconds_per_tick))
				synth.set_eye_blur_if_lower(2 SECONDS * determined_mod)
				synth.set_dizzy_if_lower(2 SECONDS * determined_mod)
				if(prob(50))
					to_chat(synth, span_bolddanger("You feel very [word]. It's getting hard to cool down!"))
					synth.adjust_bodytemperature(25 * determined_mod)
				else if(synth.get_stamina_loss() < 40 * determined_mod)
					to_chat(synth, span_bolddanger("You feel very [word]. It's getting hard to stay awake!"))
					synth.adjust_stamina_loss(7.5 * determined_mod)
		// Very low blood, danger!!
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_RISKY)
			synth.adjust_bodytemperature(13 * determined_mod)
			if(SPT_PROB(5, seconds_per_tick))
				synth.set_eye_blur_if_lower(4 SECONDS * determined_mod)
				synth.set_dizzy_if_lower(4 SECONDS * determined_mod)
				if(prob(50))
					to_chat(synth, span_userdanger("You feel extremely [word]! It's getting very hard to cool down!"))
					synth.adjust_bodytemperature(50 * determined_mod)
				else if(synth.get_stamina_loss() < 80 * determined_mod)
					to_chat(synth, span_userdanger("You feel extremely [word]! It's getting very hard to stay awake!"))
					synth.adjust_stamina_loss(10 * determined_mod)
		// Critically low blood, death is near! Adrenaline won't help you here.
		if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
			if(SPT_PROB(7.5, seconds_per_tick))
				synth.Unconscious(rand(1 SECONDS, 2 SECONDS))
				to_chat(synth, span_userdanger("You black out for a moment as your pump draws all your power!"))
		// Instantly die upon this threshold
		if(-INFINITY to BLOOD_VOLUME_SURVIVE)
			if(!HAS_TRAIT(synth, TRAIT_NODEATH))
				synth.investigate_log("has died of bloodloss.", INVESTIGATE_DEATHS)
				synth.death()

	return HANDLE_BLOOD_HANDLED
