/datum/reagent/plantnutriment/eznutriment/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(SPT_PROB(tox_prob, seconds_per_tick))
		var/flipped_number = (affected_mob.mob_biotypes & MOB_PLANT) ? -1 : 1
		if(affected_mob.adjustBruteLoss(flipped_number, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/plantnutriment/left4zednutriment/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(SPT_PROB(tox_prob, seconds_per_tick))
		var/flipped_number = (affected_mob.mob_biotypes & MOB_PLANT) ? -1 : 1
		if(affected_mob.adjustOxyLoss(flipped_number, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/plantnutriment/robustharvestnutriment/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(SPT_PROB(tox_prob, seconds_per_tick))
		var/flipped_number = (affected_mob.mob_biotypes & MOB_PLANT) ? -1 : 1
		if(affected_mob.adjustFireLoss(flipped_number, updating_health = FALSE))
			return UPDATE_MOB_HEALTH
