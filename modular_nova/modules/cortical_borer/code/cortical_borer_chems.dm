/datum/reagent/drug/methamphetamine/borer_version
	name = "Unknown Methamphetamine Isomer"
	overdose_threshold = 40

/datum/reagent/drug/methamphetamine/borer_version/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	var/high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(affected_mob, span_notice("[high_message]"))
	affected_mob.add_mood_event("tweaking", /datum/mood_event/stimulant_medium, name)
	affected_mob.AdjustStun(-2.667 SECONDS * seconds_per_tick * metabolization_ratio)
	affected_mob.AdjustKnockdown(-2.667 SECONDS * seconds_per_tick * metabolization_ratio)
	affected_mob.AdjustUnconscious(-2.667 SECONDS * seconds_per_tick * metabolization_ratio)
	affected_mob.AdjustParalyzed(-2.667 SECONDS * seconds_per_tick * metabolization_ratio)
	affected_mob.AdjustImmobilized(-2.667 SECONDS * seconds_per_tick * metabolization_ratio)
	if(affected_mob.adjust_stamina_loss(-1.33 * seconds_per_tick * metabolization_ratio, updating_stamina = FALSE))
		. = UPDATE_MOB_HEALTH

	affected_mob.set_jitter_if_lower(5 SECONDS)

	if(SPT_PROB(2.5, seconds_per_tick))
		affected_mob.emote(pick("twitch", "shiver"))
	return ..() || .
