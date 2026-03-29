GLOBAL_VAR_INIT(summon_prey_spent, FALSE)

/// Grants the queen a one-time monkey summoning ability if it hasn't been used this round.
/mob/living/carbon/alien/adult/royal/queen/Initialize(mapload)
	. = ..()
	if(!GLOB.summon_prey_spent)
		var/datum/action/cooldown/alien/summon_monkeys/monkey_spell = new(src)
		monkey_spell.Grant(src)

/// One-time use alien ability that spawns two monkeys adjacent to the queen. Once used by any queen, no other queen can use it.
/datum/action/cooldown/alien/summon_monkeys
	name = "Summon Prey"
	desc = "Call upon the hive's psionic link to lure three unsuspecting primates to your location. Single use per round."
	button_icon_state = "alien_egg"
	plasma_cost = 100

/datum/action/cooldown/alien/summon_monkeys/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(GLOB.summon_prey_spent)
		return FALSE
	return TRUE

/datum/action/cooldown/alien/summon_monkeys/Activate(atom/target)
	var/area/owner_area = get_area(owner)
	if(istype(owner_area, /area/station/science/genetics) || istype(owner_area, /area/station/science/xenobiology) || istype(owner_area, /area/station/medical/virology))
		to_chat(owner, span_warning("The psionic link is scrambled by the research equipment in this area!"))
		return FALSE

	var/list/turf/candidates = list()
	for(var/turf/open/nearby in get_adjacent_open_turfs(owner))
		if(!nearby.is_blocked_turf())
			candidates += nearby

	if(length(candidates) < 3)
		to_chat(owner, span_warning("There isn't enough open space nearby to summon prey!"))
		return FALSE

	shuffle_inplace(candidates)

	for(var/i in 1 to 3)
		var/turf/spawn_turf = candidates[i]
		new /mob/living/carbon/human/species/monkey(spawn_turf)
		new /obj/effect/temp_visual/cult/sparks(spawn_turf)

	owner.visible_message(
		span_alertalien("[owner] lets out a haunting screech! three terrified monkeys appear nearby!"),
		span_noticealien("You reach out through the hive mind, luring three primates to your location."),
	)
	playsound(owner, 'sound/mobs/non-humanoids/alien/alien_york.ogg', 100)

	GLOB.summon_prey_spent = TRUE
	// Remove the action from all queens
	for(var/mob/living/carbon/alien/adult/royal/queen/queen as anything in GLOB.carbon_list)
		if(!istype(queen))
			continue
		var/datum/action/cooldown/alien/summon_monkeys/spell = locate() in queen.actions
		if(spell)
			qdel(spell)

	return TRUE
