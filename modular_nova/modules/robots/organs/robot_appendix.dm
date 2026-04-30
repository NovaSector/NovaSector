/obj/item/organ/appendix/random_number_database
	name = "cyborg GPU"
	desc = "A beefy GPU built for installation inside of cybernetic organisms, used for various computing tasks. This particular one is well-worn."
	organ_flags = ORGAN_ROBOTIC
	icon = 'modular_nova/modules/robots/sprites/robot_organs.dmi'
	icon_state = "random_number_database"
	var/list/guessed_numbers = list() // well, it's a database
	var/random_number = 69
	var/max_number = 10000

/obj/item/organ/appendix/random_number_database/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/brain/robot_nova/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: No cybernetic brain to draw power from!")
			organ_flags |= ORGAN_DEPOWERED
		return
	if(robot_brain.power <= 50)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering [name] to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED
	if(organ_flags & ORGAN_DEPOWERED)
		return
	robot_brain.power -= (ROBOT_POWER_DRAIN * seconds_per_tick) * robot_brain.temperature_disparity
	var/chosen_number = rand(1, max_number)
	if(chosen_number == random_number)
		say("Account complete! Thank you for contributing to the work. Complimentary power will now be distributed.")
		robot_brain.power += 25
		guessed_numbers += chosen_number
		random_number = rand(1, max_number)
	robot_brain.run_updates()

/obj/item/organ/appendix/emotion_chip
	name = "emotion processing unit"
	desc = "A beefy neural processing unit for simulating life-like emotions in synthetic life."
	organ_flags = ORGAN_ROBOTIC
	icon_state = "random_number_database"
	icon = 'modular_nova/modules/robots/sprites/robot_organs.dmi'

/obj/item/organ/appendix/emotion_chip/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/brain/robot_nova/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: No cybernetic brain to draw power from!")
			organ_flags |= ORGAN_DEPOWERED
		return
	if(robot_brain.power <= 50)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering [name] to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED

	if(organ_flags & ORGAN_DEPOWERED)
		if(robot_brain.owner && !robot_brain.owner.mob_mood.forced_neutral)
			robot_brain.owner.mob_mood.enable_forced_neutral()
		return

	robot_brain.power -= (ROBOT_POWER_DRAIN * seconds_per_tick) * robot_brain.temperature_disparity
	if(robot_brain.owner.mob_mood.forced_neutral)
		robot_brain.owner.mob_mood.disable_forced_neutral()
	robot_brain.run_updates()

/obj/item/organ/appendix/internal_synthesizer
	name = "sound processing unit"
	desc = "A beefy sound card for simulating life-like sound effects at 48khz."
	organ_flags = ORGAN_ROBOTIC
	icon_state = "random_number_database"
	icon = 'modular_nova/modules/robots/sprites/robot_organs.dmi'
	var/datum/action/sing_tones/sing_action

/obj/item/organ/appendix/internal_synthesizer/Initialize(mapload)
	. = ..()
	sing_action = new

/obj/item/organ/appendix/internal_synthesizer/Destroy()
	qdel(sing_action)
	. = ..()

/obj/item/organ/appendix/internal_synthesizer/on_mob_remove(mob/living/carbon/organ_owner)
	sing_action.Remove(organ_owner)
	. = ..()

/obj/item/organ/appendix/internal_synthesizer/on_mob_insert(mob/living/carbon/organ_owner)
	. = ..()
	sing_action.Grant(organ_owner)

/obj/item/organ/appendix/internal_synthesizer/on_life(seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/brain/robot_nova/robot_brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!robot_brain || !istype(robot_brain))
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: No cybernetic brain to draw power from!")
			organ_flags |= ORGAN_DEPOWERED
		return
	if(robot_brain.power <= 50)
		if(!(organ_flags & ORGAN_DEPOWERED))
			say("ERROR: Power critically low, depowering [name] to conserve energy!")
			organ_flags |= ORGAN_DEPOWERED
	else
		organ_flags &= ~ORGAN_DEPOWERED

	if(organ_flags & ORGAN_DEPOWERED)
		if(robot_brain.owner)
			sing_action.Remove(sing_action)
		return

	robot_brain.power -= (ROBOT_POWER_DRAIN * seconds_per_tick) * robot_brain.temperature_disparity
	if(sing_action.owner != robot_brain.owner)
		sing_action.Grant(robot_brain.owner)
	robot_brain.run_updates()

/obj/item/organ/appendix/cpu // TODO: Internal Computer support as an appendix option
	name = "central processing unit"
	desc = "A high-powered CPU for emulating NTOS, as the software was written for a different instruction set than robots operate on."
	organ_flags = ORGAN_ROBOTIC
	icon_state = "random_number_database"
	icon = 'modular_nova/modules/robots/sprites/robot_organs.dmi'
