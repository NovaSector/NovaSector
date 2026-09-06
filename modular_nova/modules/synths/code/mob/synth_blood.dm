/mob/living/carbon/human/species/synth



// Takes care blood loss and regeneration
/mob/living/carbon/human/species/synth/handle_blood(seconds_per_tick)
	// Under these circumstances blood handling is not necessary
	if(bodytemperature < BLOOD_STOP_TEMP || HAS_TRAIT_NOT_FROM(src, TRAIT_FAKEDEATH, QUIRK_TRAIT))
		return

	// Run the signal, still allowing mobs with noblood to "handle blood" in their own way
	var/sigreturn = SEND_SIGNAL(src, COMSIG_HUMAN_ON_HANDLE_BLOOD, seconds_per_tick)
	if((sigreturn & HANDLE_BLOOD_HANDLED) || !CAN_HAVE_BLOOD(src))
		return

	var/heart_blood_multiplier = get_heart_blood_regeneration_multiplier()
	//Blood regeneration if there is some space
	if(heart_blood_multiplier && !(sigreturn & HANDLE_BLOOD_NO_NUTRITION_DRAIN) && get_blood_volume() < BLOOD_VOLUME_NORMAL && !HAS_TRAIT(src, TRAIT_NOHUNGER))
		var/nutrition_ratio = round(nutrition / NUTRITION_LEVEL_WELL_FED, 0.2)

		if(satiety > 80)
			nutrition_ratio *= 1.25

		var/blood_to_restore = BLOOD_REGEN_FACTOR * GET_PHYSIOLOGY(src, PHYS_COEFF_BLOOD_REGEN) * heart_blood_multiplier * nutrition_ratio * seconds_per_tick
		var/blood_restored = adjust_blood_volume(blood_to_restore, maximum = BLOOD_VOLUME_NORMAL)
		if (blood_restored > 0)
			adjust_nutrition(-nutrition_ratio * HUNGER_FACTOR * seconds_per_tick * (blood_restored / blood_to_restore))

	var/bleed_rate = get_bleed_rate()

	if(bleed_rate)
		bleed(bleed_rate * seconds_per_tick)
		bleed_warn(bleed_rate)

	for (var/obj/item/bodypart/bodypart as anything in get_bodyparts())
		if (bodypart.generic_bleedstacks)
			bodypart.adjustBleedStacks(-1, 0)

	//Effects of bloodloss
	if(sigreturn & HANDLE_BLOOD_NO_OXYLOSS)
		return

	// Takes into account modifiers like saline-glucose solution in the blood
	var/modified_blood_volume = get_blood_volume(apply_modifiers = TRUE)

	// Some effects are halved mid-combat.
	var/determined_mod = has_status_effect(/datum/status_effect/determined) ? 0.5 : 1

	var/word = pick("woozy","dizzy","hot","overheated")
	switch(modified_blood_volume)
		// Way too much blood!
		if(BLOOD_VOLUME_EXCESS to BLOOD_VOLUME_MAX_LETHAL)
			if(SPT_PROB(7.5, seconds_per_tick))
				to_chat(src, span_userdanger("Internal fluid starts to tear your casing apart. You're going to burst!"))
				investigate_log("has been gibbed by having too much blood.", INVESTIGATE_DEATHS)
				inflate_gib()
		// Too much blood
		if(BLOOD_VOLUME_MAXIMUM to BLOOD_VOLUME_EXCESS)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(src, span_warning("You feel terribly bloated."))
		// Low blood but not a big deal in the immediate
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			if(SPT_PROB(2.5, seconds_per_tick))
				set_eye_blur_if_lower(2 SECONDS * determined_mod)
				if(prob(50))
					to_chat(src, span_danger("You feel [word]. It's getting a bit hard to cool down."))
					adjust_bodytemperature(0.5 * determined_mod * seconds_per_tick)
				else if(get_stamina_loss() < 25 * determined_mod)
					to_chat(src, span_danger("You feel [word]. It's getting a bit hard to focus."))
					adjust_stamina_loss(5 * determined_mod * seconds_per_tick)
		// Pretty low blood, getting dangerous!
		if(BLOOD_VOLUME_RISKY to BLOOD_VOLUME_OKAY)
			if(SPT_PROB(5, seconds_per_tick))
				set_eye_blur_if_lower(2 SECONDS * determined_mod)
				set_dizzy_if_lower(2 SECONDS * determined_mod)
				if(prob(50))
					to_chat(src, span_bolddanger("You feel very [word]. It's getting hard to cool down!"))
					adjust_bodytemperature(2 * determined_mod)
				else if(get_stamina_loss() < 40 * determined_mod)
					to_chat(src, span_bolddanger("You feel very [word]. It's getting hard to stay awake!"))
					adjust_stamina_loss(7.5 * determined_mod)
		// Very low blood, danger!!
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_RISKY)
			if(SPT_PROB(5, seconds_per_tick))
				set_eye_blur_if_lower(4 SECONDS * determined_mod)
				set_dizzy_if_lower(4 SECONDS * determined_mod)
				if(prob(50))
					to_chat(src, span_userdanger("You feel extremely [word]! It's getting very hard to cool down!"))
					adjust_bodytemperature(3 * determined_mod)
				else if(get_stamina_loss() < 80 * determined_mod)
					to_chat(src, span_userdanger("You feel extremely [word]! It's getting very hard to stay awake!"))
					adjust_stamina_loss(10 * determined_mod)
		// Critically low blood, death is near! Adrenaline won't help you here.
		if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
			if(SPT_PROB(7.5, seconds_per_tick))
				Unconscious(rand(1 SECONDS, 2 SECONDS))
				to_chat(src, span_userdanger("You black out for a moment as your pump draws all your power!"))
		// Instantly die upon this threshold
		if(-INFINITY to BLOOD_VOLUME_SURVIVE)
			if(!HAS_TRAIT(src, TRAIT_NODEATH))
				investigate_log("has died of bloodloss.", INVESTIGATE_DEATHS)
				death()

	// Blood ratio! if you have 280 blood, this equals 0.5 as that's half of the current value, 560.
	var/effective_blood_ratio = modified_blood_volume / BLOOD_VOLUME_NORMAL
	var/target_oxyloss = max((1 - effective_blood_ratio) * 100, 0)

	// If your ratio is less than one (you're missing any blood) and your oxyloss is under missing blood %, start getting oxy damage.
	// This damage accrues faster the less blood you have.
	// If the damage surpasses the KO threshold for oxyloss, then we'll always tick up so you die eventually
	if(target_oxyloss > 0 && (get_oxy_loss() < target_oxyloss || (target_oxyloss >= OXYLOSS_PASSOUT_THRESHOLD && IS_UNCONSCIOUS(src))))
		// At roughly half blood this equals to 3 oxyloss per tick. At 90% blood it's close to 0.5
		var/rounded_oxyloss = round(0.01 * (BLOOD_VOLUME_NORMAL - modified_blood_volume), 0.25) * seconds_per_tick
		adjust_oxy_loss(rounded_oxyloss, updating_health = TRUE)
