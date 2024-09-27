#define ARTIFACT_BAD_MESSAGES_MINOR list(\
		"You feel worried.",\
		"Something doesn't feel right.",\
		"You get a strange feeling in your gut.",\
		"Your instincts are trying to warn you about something.",\
		"Someone just walked over your grave.",\
		"There's a strange feeling in the air.",\
		"There's a strange smell in the air.",\
		"The tips of your fingers feel tingly.",\
		"You feel witchy.",\
		"You have a terrible sense of foreboding.",\
		"You've got a bad feeling about this.",\
		"Your scalp prickles.",\
		"The light seems to flicker.",\
		"The shadows seem to lengthen.",\
		"The walls are getting closer.",\
		"Something is wrong",\
)

#define ARTIFACT_BAD_MESSAGES_MAJOR list(\
		"You've got to get out of here!",\
		"Someone's trying to kill you!",\
		"There's something out there!",\
		"What's happening to you?",\
		"OH GOD!",\
		"HELP ME!",\
)

#define ARTIFACT_GOOD_MESSAGES_MINOR list(\
		"You feel good.",\
		"Everything seems to be going alright",\
		"You've got a good feeling about this",\
		"Your instincts tell you everything is going to be getting better.",\
		"There's a good feeling in the air.",\
		"Something smells... good.",\
		"The tips of your fingers feel tingly.",\
		"You've got a good feeling about this.",\
		"You feel happy.",\
		"You fight the urge to smile.",\
		"Your scalp prickles.",\
		"All the colours seem a bit more vibrant.",\
		"Everything seems a little lighter.",\
		"The troubles of the world seem to fade away.",\
)

#define ARTIFACT_GOOD_MESSAGES_MAJOR list(\
		"You want to hug everyone you meet!",\
		"Everything is going so well!",\
		"You feel euphoric.",\
		"You feel giddy.",\
		"You're so happy suddenly, you almost want to dance and sing.",\
		"You feel like the world is out to help you.",\
)

/datum/artifact_effect/feelings
	type_name = ARTIFACT_EFFECT_PSIONIC
	/// List of major messages for mood events
	var/list/drastic_message_list
	/// List of minor messages for mood events
	var/list/normal_message_list

/datum/artifact_effect/feelings/do_effect_touch(mob/user)
	. = ..()
	if(!.)
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_mob = user
	run_send_messages(human_mob, 50, 80)
	human_mob.adjust_dizzy_up_to(3 SECONDS, 15 SECONDS)

/datum/artifact_effect/feelings/do_effect_aura(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/human/human_mob in range(range, curr_turf))
		run_send_messages(human_mob, 2.5, 5, seconds_per_tick)
		human_mob.adjust_dizzy_up_to(1.5 SECONDS * seconds_per_tick, 15 SECONDS)

/datum/artifact_effect/feelings/do_effect_pulse(seconds_per_tick)
	. = ..()
	if(!.)
		return
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/human/human_mob in range(range, curr_turf))
		run_send_messages(human_mob, 80, 100)
		human_mob.adjust_dizzy_up_to(3 SECONDS, 10 SECONDS)
		if(prob(25))
			human_mob.adjust_dizzy_up_to(5 SECONDS, 30 SECONDS)

/datum/artifact_effect/feelings/do_effect_destroy()
	var/turf/curr_turf = get_turf(holder)
	for(var/mob/living/carbon/human/human_mob in range(7, curr_turf))
		run_send_messages(human_mob, 100, 0)
		human_mob.adjust_dizzy(30 SECONDS)

/**
 * Randomly selects between major and minor mood and applies it to the mob
 *
 * Arguments:
 * * receiver - who will receive mood event
 * * drastic_message_chance - chance to receive major mood event
 * * normal_message_chance - chance to receive minor mood event
 */
/datum/artifact_effect/feelings/proc/run_send_messages(mob/receiver, drastic_message_chance = 0, normal_message_chance = 0, seconds_per_tick)
	if(SPT_PROB(drastic_message_chance, seconds_per_tick))
		send_drastic_message(receiver)
		return
	if(SPT_PROB(normal_message_chance, seconds_per_tick))
		send_minor_message(receiver)

/// Send major mood event
/datum/artifact_effect/feelings/proc/send_drastic_message(mob/receiver)

/// Send minor mood event
/datum/artifact_effect/feelings/proc/send_minor_message(mob/receiver)

/datum/artifact_effect/feelings/bad
	log_name = "Bad Feeling"
	drastic_message_list = ARTIFACT_BAD_MESSAGES_MAJOR
	normal_message_list = ARTIFACT_BAD_MESSAGES_MINOR

/datum/artifact_effect/feelings/bad/send_drastic_message(mob/receiver)
	to_chat(receiver, "<font color='red' size='[num2text(rand(3, 5))]'><b>[pick(drastic_message_list)]</b></font>")
	var/mob/living/living_target = receiver
	living_target.add_mood_event("drastic_effect_bad", /datum/mood_event/artifact_effect_bad_major)

/datum/artifact_effect/feelings/bad/send_minor_message(mob/receiver)
	to_chat(receiver, "<font color='red'>[pick(normal_message_list)]</font>")
	var/mob/living/living_target = receiver
	living_target.add_mood_event("minor_effect_bad", /datum/mood_event/artifact_effect_bad_minor)

/datum/artifact_effect/feelings/good
	log_name = "Good Feeling"
	drastic_message_list = ARTIFACT_GOOD_MESSAGES_MAJOR
	normal_message_list = ARTIFACT_GOOD_MESSAGES_MINOR

/datum/artifact_effect/feelings/good/send_drastic_message(mob/receiver)
	to_chat(receiver, "<font color='blue' size='[num2text(rand(1,5))]'><b>[pick(drastic_message_list)]</b></font>")
	var/mob/living/living_target = receiver
	living_target.add_mood_event("drastic_effect_good",/datum/mood_event/artifact_effect_good_major)

/datum/artifact_effect/feelings/good/send_minor_message(mob/receiver)
	to_chat(receiver, "<font color='blue'>[pick(normal_message_list)]</font>")
	var/mob/living/living_target = receiver
	living_target.add_mood_event("minor_effect_good", /datum/mood_event/artifact_effect_good_minor)

/datum/mood_event/artifact_effect_good_major
	description = span_nicegreen("Wooo! What is going on?")
	mood_change = 10
	timeout = 10 MINUTES

/datum/mood_event/artifact_effect_good_minor
	description = span_nicegreen("I feel strange, but also very relaxed...")
	mood_change = 5
	timeout = 5 MINUTES

/datum/mood_event/artifact_effect_bad_major
	description = span_warning("It feels like a gaggle of geese are pecking at my skull...")
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/artifact_effect_bad_minor
	description = span_warning("I feel strange and uneasy...")
	mood_change = -5
	timeout = 5 MINUTES

#undef ARTIFACT_BAD_MESSAGES_MINOR
#undef ARTIFACT_BAD_MESSAGES_MAJOR
#undef ARTIFACT_GOOD_MESSAGES_MINOR
#undef ARTIFACT_GOOD_MESSAGES_MAJOR
