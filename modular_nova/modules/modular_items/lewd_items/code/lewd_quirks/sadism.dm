/datum/quirk/sadism
	name = "Sadism"
	desc = "You feel pleasure when you see someone in agony."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_SADISM
	gain_text = span_danger("You feel a sudden desire to inflict pain.")
	lose_text = span_notice("Others' pain doesn't satisfy you anymore.")
	medical_record_text = "Subject has sadism."
	icon = FA_ICON_HAMMER
	erp_quirk = TRUE

/datum/quirk/sadism/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human.gain_trauma(/datum/brain_trauma/very_special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/sadism/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human?.cure_trauma_type(/datum/brain_trauma/very_special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/brain_trauma/very_special/sadism
	name = "Sadism"
	desc = "The subject's cerebral pleasure centers are more active when someone is suffering."
	scan_desc = "sadistic tendencies"
	gain_text = span_purple("You feel a desire to hurt somebody.")
	lose_text = span_notice("You feel compassion again.")
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/very_special/sadism/on_life(seconds_per_tick, times_fired)
	var/mob/living/carbon/human/affected_mob = owner
	if(!owner.has_status_effect(/datum/status_effect/climax_cooldown) && affected_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp) && someone_suffering())
		affected_mob.adjust_arousal(2)
		owner.add_mood_event("sadistic", /datum/mood_event/sadistic)
	else
		owner.clear_mood_event("sadistic")

/datum/brain_trauma/very_special/sadism/proc/someone_suffering()
	if(owner.is_blind())
		return FALSE
	for(var/mob/living/carbon/human/iterated_mob in oview(owner, 4))
		if(!isliving(iterated_mob)) //ghosts ain't people
			continue
		if(!istype(iterated_mob)) //only count mobs of type mob/living/human/...
			continue
		if(iterated_mob.stat == DEAD) //don't count dead targets either
			continue
		if(iterated_mob.pain >= 10)
			return TRUE
	return FALSE
