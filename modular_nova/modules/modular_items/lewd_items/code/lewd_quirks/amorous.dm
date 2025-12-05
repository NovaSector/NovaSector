/datum/quirk/amorous
	name = "Amorous"
	desc = "You have a more active libido than most people."
	value = 0
	mob_trait = TRAIT_AMOROUS
	gain_text = span_userlove("Your libido is going haywire!")
	lose_text = span_notice("Your libido settles down to a normal level.")
	medical_record_text = "Subject has permanent hormonal disruption."
	icon = FA_ICON_HEART
	erp_quirk = TRUE

/datum/quirk/amorous/add()
	var/mob/living/carbon/carbon_holder = quirk_holder
	carbon_holder.gain_trauma(/datum/brain_trauma/very_special/amorous, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/amorous/remove()
	var/mob/living/carbon/carbon_holder = quirk_holder
	carbon_holder.cure_trauma_type(/datum/brain_trauma/very_special/amorous, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/brain_trauma/very_special/amorous
	name = "Permanent hormonal disruption"
	desc = "The patient has completely lost the ability to regulate their hormones, and seems extremely aroused."
	scan_desc = "permanent hormonal disruption"
	gain_text = span_purple("Your thoughts get cloudy, but it turns you on like hell.")
	lose_text = span_warning("A pleasant coolness spreads throughout your body. You are thinking clearly again.")
	//people need to be able to gain it through the chemical OD
	can_gain = TRUE
	//people should not be able to randomly get this trauma
	random_gain = FALSE
	//we don't want this to be displayed on a scanner
	display_scanner = FALSE
	resilience = TRAUMA_RESILIENCE_LOBOTOMY
	///how satisfied the person is, gained through climaxing
	var/satisfaction = 1000
	///The maximum number satisfaction is allowed to reach
	var/satisfaction_max = 1000
	///The amount of satisfaction gained via climaxing
	var/satisfaction_gain = 300
	///The amount of satisfaction lost
	var/satisfaction_loss = 1
	///how stressed the person is, gained through zero satisfaction
	var/stress = 0
	///The maximum number stress is allowed to reach
	var/stress_max = 300

	COOLDOWN_DECLARE(desire_cooldown)
	///The time between each desire message within company
	var/desire_cooldown_number = 30 SECONDS

/**
 * If we are not satisfied, this will be ran through
 */
/datum/brain_trauma/very_special/amorous/proc/try_unsatisfied()
	var/mob/living/carbon/human/human_owner = owner
	//we definitely need an owner; but if you are satisfied, just return
	if(satisfaction || !human_owner)
		return FALSE
	//we need to feel consequences for being unsatisfied
	//the message that will be sent to the owner at the end
	var/lust_message
	//we are using if statements so that it slowly becomes more and more to the person
	if(stress == 60)
		human_owner.set_jitter_if_lower(40 SECONDS)
		lust_message = "You feel a static sensation all across your skin..."
	if(stress == 120)
		human_owner.set_eye_blur_if_lower(20 SECONDS)
		lust_message = "You vision begins to blur, the heat beginning to rise..."
	if(stress == 180)
		lust_message = "You begin to fantasize of what you could with someone..."
	if(stress == 240)
		human_owner.adjust_stamina_loss(30)
		lust_message = "You body feels so very hot, almost unwilling to cooperate..."
	if(stress == 300)
		lust_message = "You feel your neck tightening, straining..."
	if(!isnull(lust_message))
		to_chat(human_owner, span_purple(lust_message))
	return TRUE

/**
 * If we have climaxed, return true
 */
/datum/brain_trauma/very_special/amorous/proc/check_climaxed()
	if(owner.has_status_effect(/datum/status_effect/climax))
		stress = 0
		satisfaction = min(satisfaction + satisfaction_gain, satisfaction_max)
		return TRUE
	return FALSE

/datum/brain_trauma/very_special/amorous/on_life()
	var/mob/living/carbon/human/human_owner = owner

	//Check if we climaxed, if so, just stop for now
	if(check_climaxed())
		return
	//if we are satisfied, slowly lower satisfaction as well as stress
	if(satisfaction)
		satisfaction = clamp(satisfaction - 1, 0, satisfaction_max)
		stress = clamp(stress - 1, 0, stress_max)
	//since we are not satisfied, increase our stress
	else
		stress = clamp(stress + 1, 0, stress_max)

	human_owner.adjust_arousal(10)
	if(human_owner.pleasure < 45)
		human_owner.adjust_pleasure(5)

	//Anything beyond this obeys a cooldown system because we don't want to spam it
	if(!COOLDOWN_FINISHED(src, desire_cooldown))
		return
	COOLDOWN_START(src, desire_cooldown, desire_cooldown_number)

	//if we are unsatisfied, do this code block and then stop
	if(try_unsatisfied())
		return

	//Anything beyond this requires company
	if(!in_company())
		//since you aren't within company, you won't be satisfied
		satisfaction = clamp(satisfaction - 1, 0, satisfaction_max)
		to_chat(human_owner, span_purple("You feel so alone without someone..."))
		return

	switch(satisfaction)
		if(100)
			to_chat(human_owner, span_purple("You can't STAND it, you need a partner NOW!"))
		if(150)
			to_chat(human_owner, span_purple("You'd hit that. Yeah. That's at least a six."))
		if(200)
			to_chat(human_owner, span_purple("Your clothes are feeling tight."))
		if(250)
			to_chat(human_owner, span_purple("Desire fogs your decisions."))
		if(300)
			to_chat(human_owner, span_purple("Jeez, it's hot in here..."))

/**
 * If we have another human in view, return true
 */
/datum/brain_trauma/very_special/amorous/proc/in_company()
	for(var/mob/living/carbon/human/human_check in oview(owner, 4))
		if(!istype(human_check))
			continue
		return TRUE
	return FALSE

/datum/brain_trauma/very_special/amorous/on_gain()
	. = ..()
	owner.add_mood_event("amorous", /datum/mood_event/amorous)
	if(!HAS_TRAIT_FROM(owner, TRAIT_AMOROUS, TRAIT_LEWDCHEM))
		ADD_TRAIT(owner, TRAIT_AMOROUS, TRAIT_LEWDCHEM)
	if(!HAS_TRAIT_FROM(owner, TRAIT_MASOCHISM, TRAIT_APHRO))
		ADD_TRAIT(owner, TRAIT_MASOCHISM, TRAIT_APHRO)

/datum/brain_trauma/very_special/amorous/on_lose()
	. = ..()
	owner.clear_mood_event("amorous")
	if(HAS_TRAIT_FROM(owner, TRAIT_AMOROUS, TRAIT_LEWDCHEM))
		REMOVE_TRAIT(owner, TRAIT_AMOROUS, TRAIT_LEWDCHEM)
	if(HAS_TRAIT_FROM(owner, TRAIT_MASOCHISM, TRAIT_APHRO))
		REMOVE_TRAIT(owner, TRAIT_MASOCHISM, TRAIT_APHRO)

//Mood boost
/datum/mood_event/amorous
	description = span_purple("So-o... Turned..on... Lo-ve it!\n")
