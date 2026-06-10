/obj/item/organ/tongue/speaker
	name = "robotic voice box"
	desc = "A high-fidelity speaker used to produce a clear synthetic voice. It is incapable of the exact intonation and subvocal queues of humans in accordance with TerraGov law."
	organ_flags = ORGAN_ROBOTIC
	modifies_speech = TRUE
	say_mod = "states"
	attack_verb_continuous = list("beeps", "boops")
	attack_verb_simple = list("beep", "boop")
	voice_filter = "alimiter=0.9,acompressor=threshold=0.2:ratio=20:attack=10:release=50:makeup=2,highpass=f=1000"
	icon_state = "speaker"
	icon = 'modular_nova/modules/robots/sprites/robot_organs.dmi'
	sense_of_taste = FALSE
	liked_foodtypes = NONE
	disliked_foodtypes = NONE
	toxic_foodtypes = MEAT | VEGETABLES | RAW | JUNKFOOD | GRAIN | FRUIT | DAIRY | FRIED | ALCOHOL | SUGAR | GROSS | TOXIC | PINEAPPLE | BREAKFAST | CLOTH | NUTS | SEAFOOD | ORANGES | BUGS | GORE | STONE

/obj/item/organ/tongue/speaker/on_life(seconds_per_tick, times_fired)
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
	if(robot_brain.power <= 5)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering [name] to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= (ROBOT_POWER_DRAIN * seconds_per_tick) * robot_brain.temperature_disparity
	robot_brain.run_updates()

/obj/item/organ/tongue/speaker/modify_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT
	var/chance_of_replacement = ((damage / maxHealth) * 100)
	if(organ_flags & ORGAN_DEPOWERED)
		chance_of_replacement = 100 // can't say SHIT without power
	if(organ_flags & ORGAN_FAILING)
		chance_of_replacement = 100 // can't say SHIT if broken
	if(chance_of_replacement)
		var/message = speech_args[SPEECH_MESSAGE]
		var/list/possible_words_to_replace = splittext_char(message, " ")
		for(var/word in 1 to length(possible_words_to_replace))
			if(prob(chance_of_replacement))
				var/list/new_word = list()
				for(var/i in 1 to length(possible_words_to_replace[word]))
					new_word += "█"
				possible_words_to_replace[word] = jointext(new_word, "")
		message = jointext(possible_words_to_replace, " ")
		speech_args[SPEECH_MESSAGE] = message
