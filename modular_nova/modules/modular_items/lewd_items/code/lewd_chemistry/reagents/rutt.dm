/datum/reagent/drug/aphrodisiac/rutt
	name = "\improper R.U.T.T."
	description = "Chemically condensed dopamine, sexual proteins, estrogens, and adrenalines. This aphrodisiac is an extremely powerful narcotic which may cause unintended climax."
	taste_description = "potent and floral sexual musk"
	color = "#ffa9a9"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED | REAGENT_NO_RANDOM_RECIPE
	life_pref_datum = /datum/preference/toggle/erp/aphro
	///The maximum amount of pleasure the reagent can cause per cycle
	var/maximum_pleasure = 15

/datum/reagent/drug/aphrodisiac/rutt/on_mob_add(mob/living/carbon/human/exposed_mob)
	if(!(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/aphro)))
		return ..()
	to_chat(exposed_mob, span_userlove("You're hit with an intense wave of sexual pleasure!"))
	return ..()

/datum/reagent/drug/aphrodisiac/rutt/on_mob_life(mob/living/carbon/human/exposed_mob, seconds_per_tick, times_fired)
	. = ..()
	if(!ishuman(exposed_mob))
		return
	if(!(exposed_mob.client?.prefs.read_preference(/datum/preference/toggle/erp/aphro)))
		return ..()
	if(exposed_mob.has_status_effect(/datum/status_effect/climax) || !exposed_mob?.client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	if(current_cycle > 10)
		exposed_mob.adjust_arousal(arousal_adjust_amount)

	if(current_cycle > 25)
		var/pleasure_amount = clamp(current_cycle * 0.5, 1, maximum_pleasure)
		exposed_mob.adjust_pleasure(pleasure_amount)

	switch(current_cycle)
		if(10)
			to_chat(exposed_mob, span_userlove("Your groin starts to feel really good..."))
		if(25)
			to_chat(exposed_mob, span_userlove("Your feel an orgasm building up..."))
		if(45 to INFINITY)
			if(SPT_PROB(20, seconds_per_tick))
				exposed_mob.try_lewd_autoemote(pick("drool", "shiver", "twitch"))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(exposed_mob, span_userlove("You can't stop cumming!"))
				exposed_mob.climax(manual = FALSE)

/datum/chemical_reaction/rutt
	results = list(/datum/reagent/drug/aphrodisiac/rutt = 7)
	required_reagents = list(
		/datum/reagent/drug/aphrodisiac/crocin = 3,
		/datum/reagent/drug/aphrodisiac/dopamine = 1,
		/datum/reagent/consumable/femcum = 1,
		/datum/reagent/medicine/epinephrine = 2
	)
	required_temp = 322 // Kind of warmed up
	mix_message = "The musky mixture foams into a warm pink froth..."
	erp_reaction = TRUE
