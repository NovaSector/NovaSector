// Badnana Spider

/datum/reagent/toxin/laughjuice
	name = "Laughin' Juice"
	description = "Don't drink too much or it you might die of laughter!"
	color = "#FF4DD2"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	toxpwr = 1
	taste_mult = 2
	taste_description = "uncanny sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/toxin/laughjuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(affected_mob.adjustOxyLoss(3 * REM * seconds_per_tick, FALSE, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type))
		affected_mob.visible_message(span_danger("[affected_mob] bursts out into a fit of uncontrollable laughter!"), span_userdanger("You burst out in a fit of uncontrollable laughter!"))
		affected_mob.Stun(5)
		affected_mob.emote("laugh")
		affected_mob.add_mood_event("chemical_laughter", /datum/mood_event/chemical_laughter)
		return UPDATE_MOB_HEALTH
