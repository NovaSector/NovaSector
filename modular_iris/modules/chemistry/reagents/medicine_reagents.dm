/datum/reagent/medicine/copium
	name = "Copium"
	description = "Potent psychotropic that makes users 'cope', whatever that means."
	color = "#eeacd5"
	ph = 5
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	penetrates_skin = TOUCH|VAPOR
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/copium/on_mob_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	affected_mob.manual_emote("takes a deep breath.")
	to_chat(affected_mob, span_warning("You start coping, everything is alright."))

/datum/reagent/medicine/copium/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	affected_mob.emote(pick("cry","whimper"))
	to_chat(affected_mob, span_warning("THE COPIUM IS GONE, NOOOOO"))

/datum/reagent/medicine/copium/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	switch(current_cycle)
		if(20)
			affected_mob.emote(pick("scream", "cry", "whimper", "sigh"))
			affected_mob.say(pick("Everything is gonna be okay...", "I am the most qualified person on this station...", "Guys...I AM the best...right?", "I did a good job..."))
		if(21 to INFINITY)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.manual_emote(pick("huffs the copium!","breathes heavily!","breathes rapidly!", "eyes start to water!", "sheds a small tear!"))

/datum/chemical_reaction/medicine/copium
	results = list(/datum/reagent/medicine/copium = 3)
	required_reagents = list(/datum/reagent/toxin/fentanyl = 1, /datum/reagent/drug/space_drugs = 1, /datum/reagent/drug/happiness = 1)
	mix_message = "The solution starts to vaporise, becoming much thinner than usual."
	reaction_tags = REACTION_TAG_EASY
	//FermiChem vars:
	required_temp = 50
	optimal_temp = 300
	overheat_temp = 500
	optimal_ph_min = 3.5
	optimal_ph_max = 7.5
	determin_ph_range = 3
	temp_exponent_factor = 1
	ph_exponent_factor = 1
	thermic_constant = 100
	H_ion_release = 0
	rate_up_lim = 10
	purity_min = 0.3

