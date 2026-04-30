/obj/item/organ/ears/microphone
	name = "auditory sensor suite"
	desc = "A pair of ruggedized microphones. Used to translate noise to sound for cybernetic organisms."
	icon_state = "microphone"
	icon = 'modular_nova/modules/robots/sprites/robot_organs.dmi'
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/ears/microphone/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	RegisterSignal(organ_owner, COMSIG_MOVABLE_HEAR, PROC_REF(handle_hearing))

/obj/item/organ/ears/microphone/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	UnregisterSignal(organ_owner, COMSIG_MOVABLE_HEAR)
	. = ..()

/obj/item/organ/ears/microphone/adjust_temporary_deafness(amount)
	return

/obj/item/organ/ears/microphone/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/mob/living/carbon/human/robot = owner
	if(!istype(robot))
		return
	var/obj/item/organ/brain/robot_nova/robot_brain = robot.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: No cybernetic brain to draw power from!")
			organ_flags |= ORGAN_DEPOWERED
		return
	if(robot_brain.power <= 10)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering [name] to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= (ROBOT_POWER_DRAIN * seconds_per_tick) * robot_brain.temperature_disparity
	robot_brain.run_updates()

/obj/item/organ/ears/microphone/proc/handle_hearing(datum/source, list/hearing_args)
	SIGNAL_HANDLER
	var/chance_of_replacement = ((damage / maxHealth) * 100)
	if(organ_flags & ORGAN_DEPOWERED)
		chance_of_replacement = 100 // can't hear SHIT without power
	if(organ_flags & ORGAN_FAILING)
		chance_of_replacement = 100 // can't say SHIT if broken
	if(chance_of_replacement)
		var/message = hearing_args[HEARING_RAW_MESSAGE]
		var/list/possible_words_to_replace = splittext_char(message, " ")
		for(var/word in 1 to length(possible_words_to_replace))
			if(prob(chance_of_replacement))
				var/list/new_word = list()
				for(var/i in 1 to length(possible_words_to_replace[word]))
					new_word += "█"
				possible_words_to_replace[word] = jointext(new_word, "")
		message = jointext(possible_words_to_replace, " ")
		hearing_args[HEARING_RAW_MESSAGE] = message
