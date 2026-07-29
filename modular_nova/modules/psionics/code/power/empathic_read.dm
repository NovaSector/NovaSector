/datum/psionic_power/empathic_read
	action_type = /datum/action/cooldown/psionic/pointed/living_target/empathic_read

/datum/psionic_rank_variant/empathic_read
	rank = PSIONIC_RANK_LAMBDA
	variant_name = "empathic read"
	description = "A gentle impression of one living target's emotional state."
	strain_gain = 3
	cooldown_time = 10 SECONDS
	cast_range = 5
	block_charge_cost = 1
	block_message = "mind closed!"

/datum/action/cooldown/psionic/pointed/living_target/empathic_read
	name = "Empathic Read"
	desc = "Brush against a nearby mind and read its emotional state."
	button_icon_state = "psi_empathic_read"
	point_cost = 0
	psionic_flags = PSIONIC_SENSORY
	school = PSIONIC_SCHOOL_BIOSCRAMBLER
	no_living_target_alert = "no mind there!"
	rank_variant_types = list(/datum/psionic_rank_variant/empathic_read)

/datum/action/cooldown/psionic/pointed/living_target/empathic_read/psionic_activate(atom/target)
	var/mob/living/living_target = target
	if(!istype(living_target))
		return FALSE

	var/datum/mood/target_mood = living_target.mob_mood
	if(!target_mood)
		to_chat(owner, span_notice("You brush against [living_target]'s mind, but no emotional resonance answers."))
		return TRUE

	to_chat(owner, span_purple("You brush against [living_target]'s mind: [get_mood_impression(target_mood)]."))
	var/datum/mood_event/strongest_event = get_strongest_mood_event(target_mood)
	if(strongest_event)
		to_chat(owner, span_notice("One feeling stands out: [strongest_event.description]"))
	return TRUE

/datum/action/cooldown/psionic/pointed/living_target/empathic_read/proc/get_mood_impression(datum/mood/target_mood)
	switch(target_mood.mood_level)
		if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
			return "a radiant, almost overflowing contentment"
		if(MOOD_LEVEL_HAPPY1 to MOOD_LEVEL_HAPPY2)
			return "a warm, settled calm"
		if(MOOD_LEVEL_NEUTRAL)
			return "a flat, unremarkable calm"
		if(MOOD_LEVEL_SAD2 to MOOD_LEVEL_SAD1)
			return "a dull undertow of unease"
		else
			return "a crushing, miserable weight"

/datum/action/cooldown/psionic/pointed/living_target/empathic_read/proc/get_strongest_mood_event(datum/mood/target_mood)
	var/datum/mood_event/strongest_event
	for(var/event_category in target_mood.mood_events)
		var/datum/mood_event/event = target_mood.mood_events[event_category]
		if(event.hidden || !event.description || !event.mood_change)
			continue
		if(!strongest_event || abs(event.mood_change) > abs(strongest_event.mood_change))
			strongest_event = event

	return strongest_event
